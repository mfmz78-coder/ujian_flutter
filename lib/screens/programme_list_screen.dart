// lib/screens/programme_list_screen.dart
import 'package:flutter/material.dart';

import '../data/sample_programmes.dart';
import '../widgets/programme_card.dart';

class ProgrammeListScreen extends StatelessWidget {
  const ProgrammeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      itemCount: 1000, // contoh: 1000 kad
      itemBuilder: (context, index) {
        final p = sampleProgrammes[index];
        print('Kad dibina untuk: ${p.universityName}');
                      return ProgrammeCard(
                programme: p,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProgrammeDetailScreen(programme: p),
                  ),
                ),
              );
      },
    );
  }
}
