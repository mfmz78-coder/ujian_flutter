import 'package:flutter/material.dart';
import 'models/programme.dart';
import 'screens/home_screen.dart';
import 'screens/programme_detail_screen.dart';
import 'theme.dart';
import 'services/programme_service.dart';

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

Future<void> main() async {
  final service = ProgrammeService();

  await service.fetchProgrammes();

  service.dispose();
}

class ProgrammeSummaryRow extends StatelessWidget {
  const ProgrammeSummaryRow({super.key, required this.programme});

  final Programme programme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              programme.universityName,
              style: const TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(' — ${programme.city}, ${programme.countryLabel}'),
        ],
      ),
    );
  }
}

class EttMobileApp extends StatelessWidget {
  const EttMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eTT Mobile',
      debugShowCheckedModeBanner: false,
      theme: KptTheme.light, // tema navy + emas
      home: const HomeScreen(), // skrin kekal aplikasi
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          final programme = settings.arguments as Programme;
          return MaterialPageRoute(
            builder: (_) => ProgrammeDetailScreen(programme: programme),
          );
        }
        return null; // laluan tidak dikenali
      },
    );
  }
}
