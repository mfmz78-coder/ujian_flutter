#!/usr/bin/env python3
"""
Simple file-watcher that auto-adds, commits and pushes changed files on save.
Requirements:
  pip install watchdog
Usage:
  python3 .githooks/autopush_on_save.py --path lib --message "Auto-save"

Notes:
- Skips .git and .githooks directories.
- Debounces rapid changes to the same file.
- Use with caution and don't run in production branches you can't push to.
"""
import argparse
import os
import subprocess
import sys
import time
from collections import defaultdict

try:
    from watchdog.observers import Observer
    from watchdog.events import FileSystemEventHandler
except ImportError:
    print("Missing dependency: watchdog. Install with: pip install watchdog")
    sys.exit(2)

DEBOUNCE_SECONDS = 1.2
IGNORED_DIRS = {'.git', '.githooks', 'build', 'ios/Flutter/ephemeral'}

class AutoPushHandler(FileSystemEventHandler):
    def __init__(self, repo_root, commit_message_prefix):
        super().__init__()
        self.repo_root = repo_root
        self.commit_message_prefix = commit_message_prefix
        self.timers = {}
        self.last_commit = 0

    def _is_ignored(self, src_path):
        rel = os.path.relpath(src_path, self.repo_root)
        parts = rel.split(os.sep)
        if parts[0] in IGNORED_DIRS:
            return True
        if rel.startswith('.git') or rel.startswith('.githooks'):
            return True
        return False

    def _schedule(self, src_path):
        if self._is_ignored(src_path):
            return
        src_path = os.path.abspath(src_path)
        now = time.time()
        # debounce per file
        self.timers[src_path] = now
        # commit after debounce window
        time.sleep(DEBOUNCE_SECONDS)
        # check timer hasn't been updated
        if time.time() - self.timers.get(src_path, 0) >= DEBOUNCE_SECONDS:
            self._commit_and_push(src_path)

    def on_modified(self, event):
        if event.is_directory:
            return
        self._schedule(event.src_path)

    def on_created(self, event):
        if event.is_directory:
            return
        self._schedule(event.src_path)

    def _run(self, *args, cwd=None, check=True):
        try:
            out = subprocess.check_output(list(args), cwd=cwd or self.repo_root, stderr=subprocess.STDOUT)
            return out.decode('utf-8', errors='replace')
        except subprocess.CalledProcessError as e:
            print('Command failed:', e.cmd)
            print(e.output.decode('utf-8', errors='replace'))
            return None

    def _commit_and_push(self, src_path):
        rel = os.path.relpath(src_path, self.repo_root)
        # run git add
        print(f"Staging {rel}")
        self._run('git', 'add', '--', rel)
        # check staged changes
        staged = self._run('git', 'diff', '--staged', '--name-only') or ''
        if not staged.strip():
            print('No staged changes to commit')
            return
        # build commit message
        msg = f"{self.commit_message_prefix}: {rel}"
        print(f"Committing: {msg}")
        self._run('git', 'commit', '-m', msg)
        # get current branch
        branch = self._run('git', 'rev-parse', '--abbrev-ref', 'HEAD').strip()
        if not branch:
            branch = 'main'
        print(f"Pushing {branch} to origin")
        self._run('git', 'push', 'origin', branch)
        self.last_commit = time.time()


def main():
    p = argparse.ArgumentParser()
    p.add_argument('--path', '-p', default='.', help='Path to watch (relative to repo root)')
    p.add_argument('--message', '-m', default='Auto-save', help='Commit message prefix')
    args = p.parse_args()

    repo_root = os.path.abspath('.')
    watch_path = os.path.join(repo_root, args.path)
    if not os.path.exists(watch_path):
        print('Watch path does not exist:', watch_path)
        sys.exit(1)

    handler = AutoPushHandler(repo_root, args.message)
    observer = Observer()
    observer.schedule(handler, watch_path, recursive=True)
    observer.start()
    print('Watching', watch_path)
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()

if __name__ == '__main__':
    main()
