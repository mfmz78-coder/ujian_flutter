import 'package:flutter/material.dart';

import '../data/sample_programmes.dart';
import '../widgets/programme_card.dart';
import 'programme_detail_screen.dart';

class ProgrammeListScreen extends StatelessWidget {
  const ProgrammeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 16,
      ),

      // Gunakan jumlah sebenar data.
      itemCount: sampleProgrammes.length,

      itemBuilder: (context, index) {
        final programme = sampleProgrammes[index];

        return ProgrammeCard(
          programme: programme,

          // Kad pertama menggunakan named route
          // untuk eksperimen Latihan 2 Hari 3.
          onTap: index == 0
              ? () {
                  Navigator.of(context).pushNamed(
                    '/detail',
                    arguments: programme,
                  );
                }
              : () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ProgrammeDetailScreen(
                        programme: programme,
                      ),
                    ),
                  );
                },
        );
      },
    );
  }
}