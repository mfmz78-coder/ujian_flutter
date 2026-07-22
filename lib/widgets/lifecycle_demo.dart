import 'package:flutter/material.dart';

class LifecycleDemo extends StatefulWidget {
  const LifecycleDemo({super.key});

  @override
  State<LifecycleDemo> createState() => _LifecycleDemoState();
}

class _LifecycleDemoState extends State<LifecycleDemo> {
  int _count = 0;

  @override
  void initState() {
    super.initState();

    debugPrint(
      '[LifecycleDemo] initState() — dipanggil SEKALI',
    );
  }

  void _increment() {
    setState(() {
      _count++;
    });
  }

  void _reset() {
    setState(() {
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
      '[LifecycleDemo] build() — _count = $_count',
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Demo Lifecycle',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Kiraan: $_count',
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: _increment,
              onLongPress: _reset,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Tekan: +1 · Tekan lama: reset',
                ),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: _increment,
              child: const Text('Tambah'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    debugPrint(
      '[LifecycleDemo] dispose() — widget ditutup',
    );

    super.dispose();
  }
}