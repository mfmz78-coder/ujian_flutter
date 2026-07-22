import 'package:flutter/material.dart';
import '../widgets/lifecycle_demo.dart';
import '../models/application.dart';
import '../models/programme.dart';
import 'application_form_screen.dart';

class ProgrammeDetailScreen extends StatefulWidget {
  const ProgrammeDetailScreen({super.key, required this.programme});

  final Programme programme;

  @override
  State<ProgrammeDetailScreen> createState() => _ProgrammeDetailScreenState();
}

class _ProgrammeDetailScreenState extends State<ProgrammeDetailScreen> {
  bool _sudahMohon = false;

  Future<void> _mohon() async {
    final hasil = await Navigator.of(context).push<Application>(
      MaterialPageRoute(
        builder: (_) => ApplicationFormScreen(programme: widget.programme),
      ),
    );

    if (!mounted) return;

    if (hasil != null) {
      setState(() {
        _sudahMohon = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permohonan ${hasil.id} berjaya dihantar!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.programme.universityName)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.programme.universityName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),

            Text(
              '${widget.programme.city}, '
              '${widget.programme.countryLabel}',
            ),
            const SizedBox(height: 8),

            Text(widget.programme.fieldOfStudy),

            const SizedBox(height: 24),

            const LifecycleDemo(),

const SizedBox(height: 24),

            FilledButton.icon(
              onPressed: _sudahMohon ? null : _mohon,
              icon: Icon(_sudahMohon ? Icons.check : Icons.app_registration),
              label: Text(_sudahMohon ? 'Anda Telah Memohon' : 'Mohon'),
            ),
          ],
        ),
      ),
    );
  }
}
