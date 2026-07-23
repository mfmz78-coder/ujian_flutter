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
      appBar: AppBar(title: const Text('Lab Hari 4 — Tawaran eTT (API)')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (_state) {
      case LoadState.idle:
      case LoadState.loading:
        return const Center(child: CircularProgressIndicator());

      case LoadState.error:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off, size: 48, color: Colors.grey),
              const SizedBox(height: 12),
              const Text('Gagal memuat data program.'),
              const SizedBox(height: 12),
              FilledButton(onPressed: _load, child: const Text('Cuba Lagi')),
            ],
          ),
        );

      case LoadState.loaded:
        return RefreshIndicator(
          onRefresh: _load,
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: _programmes.length,
            itemBuilder: (context, index) {
              final p = _programmes[index];

              return ProgrammeCard(
                programme: p,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProgrammeDetailScreen(programme: p),
                  ),
                ),
              );
            },
          ),
        );
    }
  }
}
