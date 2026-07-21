import 'package:flutter/material.dart';
import 'data/sample_programmes.dart';
import 'theme.dart';
import 'widgets/programme_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: KptTheme.light,
      home: Scaffold(
        appBar: AppBar(title: const Text('eTT Mobile')),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 12),
          children: [
            ProgrammeCard(
              programme: sampleProgrammes[0],
              onTap: () {
                debugPrint('Universiti Al-Azhar ditekan');
              },
            ),
            ProgrammeCard(programme: sampleProgrammes[6]),
            const SizedBox(height: 16),
            const SavedProgrammeCounter(),
          ],
        ),
      ),
    );
  }
}

class SavedProgrammeCounter extends StatefulWidget {
  const SavedProgrammeCounter({super.key});

  @override
  State<SavedProgrammeCounter> createState() => _SavedProgrammeCounterState();
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
