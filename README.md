# ujian_flutter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Project-local auto-push watcher

This repository includes a small project-local watcher that can automatically
stage, commit and push files under a specified path when you save them. It's
meant for local convenience during development and is intentionally scoped to
this project only.

Files added:

- `.githooks/autopush_on_save.py` — lightweight Python watcher using
	`watchdog` that stages the changed file, commits it with a message like
	`Auto-save: <path>` and pushes to `origin/<current-branch>`.
- `.vscode/tasks.json` — VS Code workspace task to run the watcher from the
	editor.

Quick usage:

1. Install the Python dependency (recommended in your development environment):

```bash
pip install watchdog
```

2. Run the watcher from the project root (watching `lib/` as an example):

```bash
python3 .githooks/autopush_on_save.py --path lib --message "Auto-save"
```

3. In VS Code: open Command Palette → Run Task → "Run Autopush Watcher".

Notes and safety:

- This tool commits and pushes automatically — avoid running it on protected
	branches where force push or direct pushes are restricted.
- The watcher ignores `.git` and `.githooks` by default. You can narrow the
	watched path to reduce noise (e.g., `--path lib/widgets`).
- Use with caution on large repositories or when working with sensitive code.

If you'd like, I can add a short README section showing how to register this
watcher as a macOS LaunchAgent or a systemd service for background runs.
