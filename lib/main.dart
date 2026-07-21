// import 'package:flutter/material.dart';
// import 'data/sample_programmes.dart';
// import 'theme.dart';
// // import 'widgets/programme_card.dart';
// import 'models/programme.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: KptTheme.light,
//       home: Scaffold(
//         appBar: AppBar(title: const Text('eTT Mobile')),
//         body: Center(
//           child: ProgrammeSummaryRow(programme: sampleProgrammes[6]),
//         ),
//       ),
//     );
//   }
// }

// class ProgrammeSummaryRow extends StatelessWidget {
//   const ProgrammeSummaryRow({super.key, required this.programme});

//   final Programme programme;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         children: [
//           Text(
//             programme.universityName,
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),
//           Text(' — ${programme.city}, ${programme.countryLabel}'),
//         ],
//       ),
//     );
//   }
// }

// class SavedProgrammeCounter extends StatefulWidget {
//   const SavedProgrammeCounter({super.key});

//   @override
//   State<SavedProgrammeCounter> createState() => _SavedProgrammeCounterState();
// }

// class _SavedProgrammeCounterState extends State<SavedProgrammeCounter> {
//   int _savedCount = 0;

//   void _addProgramme() {
//     setState(() {
//       _savedCount++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       margin: const EdgeInsets.symmetric(horizontal: 12),
//       decoration: BoxDecoration(
//         color: Colors.blueGrey,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             'Program disimpan: $_savedCount',
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 12),
//           ElevatedButton(
//             onPressed: _addProgramme,
//             child: const Text('+ Simpan Program'),
//           ),
//         ],
//       ),
//     );
//   }
// }


// lib/main.dart — STATUS AKHIR HARI 2
import 'package:flutter/material.dart';
import 'models/programme.dart';
import 'data/sample_programmes.dart';

// ...
import 'screens/home_screen.dart';
import 'theme.dart';

void main() {
  runApp(const EttMobileApp());
}

// ── 1.1 — Ringkasan program TANPA Expanded (akan overflow) ──────
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
      theme: KptTheme.light,      // tema navy + emas
      home: const HomeScreen(),   // skrin kekal aplikasi
    );
  }
}
