import 'package:flutter/material.dart';

import '../models/programme.dart';
import '../theme.dart';

class ProgrammeCard extends StatelessWidget {
  const ProgrammeCard({super.key, required this.programme, this.onTap});

  final Programme programme;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    programme.flagEmoji,
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(width: 12),

                  // Expanded mengelakkan nama universiti menolak
                  // bahagian kos keluar daripada skrin.
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          programme.universityName,
                          style: const TextStyle(
                            color: KptTheme.navy,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          programme.fieldOfStudy,
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${programme.city}, ${programme.countryLabel}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 8),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Anggaran',
                        style: TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                      Text(
                        'RM ${programme.estimatedAnnualCostMyr}',
                        style: const TextStyle(
                          color: KptTheme.navy,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'setahun',
                        style: TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  CategoryPill(category: programme.category),
                  ProgrammeInfoChip(
                    icon: Icons.school_outlined,
                    label: programme.studyLevel.label,
                  ),
                  ProgrammeInfoChip(
                    icon: Icons.calendar_month_outlined,
                    label: programme.intakeMonth,
                  ),
                  ProgrammeInfoChip(
                    icon: Icons.groups_outlined,
                    label: '${programme.quotaSeats} tempat',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryPill extends StatelessWidget {
  const CategoryPill({super.key, required this.category});

  final EntryCategory category;

  @override
  Widget build(BuildContext context) {
    final label = switch (category) {
      EntryCategory.spm => 'SPM ++',
      EntryCategory.stam => 'STAM',
      EntryCategory.both => 'SPM / STAM',
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: KptTheme.gold.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: KptTheme.gold),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: KptTheme.navy,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ProgrammeInfoChip extends StatelessWidget {
  const ProgrammeInfoChip({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: Colors.grey[700]),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(color: Colors.grey[700], fontSize: 12)),
      ],
    );
  }
}
