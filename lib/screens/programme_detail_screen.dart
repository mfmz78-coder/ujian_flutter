// lib/screens/programme_detail_screen.dart
import 'package:flutter/material.dart';

import '../models/programme.dart';

class ProgrammeDetailScreen extends StatefulWidget {
  const ProgrammeDetailScreen({super.key, required this.programme});

  final Programme programme;

  @override
  State<ProgrammeDetailScreen> createState() => _ProgrammeDetailScreenState();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(programme.universityName)),
      body: Center(
        child: Text('${programme.city}, ${programme.countryLabel}'),
      ),
    );
  }
}


class _ProgrammeDetailScreenState extends State<ProgrammeDetailScreen> {
  bool _sudahMohon = false;

  // 👈 3.3 — TAMBAH _mohon() SELEPAS BARIS INI
    Future<void> _mohon() async {
    final hasil = await Navigator.of(context).push<Application>(
      MaterialPageRoute(
        builder: (_) => ApplicationFormScreen(programme: widget.programme),
      ),
    );
    if (!mounted) return; // skrin mungkin sudah ditutup semasa menunggu
    if (hasil != null) {
      setState(() => _sudahMohon = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permohonan ${hasil.id} berjaya dihantar!')),
      );
    }
  }
}