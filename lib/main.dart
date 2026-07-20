import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('eTT Mobile'),
        ),
        body: const Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 24),
            child: SavedProgrammeCounter(),
          ),
        ),
      ),
    );
  }
}

class SavedProgrammeCounter extends StatefulWidget {
  const SavedProgrammeCounter({super.key});

  @override
  State<SavedProgrammeCounter> createState() =>
      _SavedProgrammeCounterState();
}

class _SavedProgrammeCounterState extends State<SavedProgrammeCounter> {
  int _savedCount = 0;

  void _addProgramme() {
    setState(() {
      _savedCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Program disimpan: $_savedCount',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _addProgramme,
            child: const Text('+ Simpan Program'),
          ),
        ],
      ),
    );
  }
}