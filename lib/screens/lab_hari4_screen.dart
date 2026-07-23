import 'package:flutter/material.dart';

import '../models/programme.dart';
import '../services/programme_service.dart';
import '../widgets/programme_card.dart';
import 'programme_detail_screen.dart';

enum LoadState { idle, loading, loaded, error }

class LabHari4Screen extends StatefulWidget {
  const LabHari4Screen({super.key});

  @override
  State<LabHari4Screen> createState() => _LabHari4ScreenState();
}

class _LabHari4ScreenState extends State<LabHari4Screen> {
  final _service = ProgrammeService();

  // State Latihan 5 akan ditambah di sini.

  LoadState _state = LoadState.idle;
  List<Programme> _programmes = [];

  Future<void> _load() async {
  setState(() {
    _state = LoadState.loading;
  });

  try {
    final data = await _service.fetchProgrammes();

    setState(() {
      _programmes = data;
      _state = LoadState.loaded;
    });
  } catch (_) {
    setState(() {
      _state = LoadState.error;
    });
  }
}

@override
void initState() {
  super.initState();
  _load();
}

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text(
        'Lab Hari 4 — Tawaran eTT (API)',
      ),
    ),
    body: _buildBody(),
  );
}
}
