import 'package:flutter/material.dart';

import '../models/application.dart';
import '../models/programme.dart';

class ApplicationFormScreen extends StatefulWidget {
  const ApplicationFormScreen({super.key, required this.programme});

  final Programme programme;

  @override
  State<ApplicationFormScreen> createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends State<ApplicationFormScreen> {
  // ╔══════════════════════════════════════════════════╗
  // ║  4.1 — _formKey masuk DI SINI                    ║
  // ╚══════════════════════════════════════════════════╝
  // ── 4.1 — Kunci borang ────────────────────────────
  final _formKey = GlobalKey<FormState>();
  // ╔══════════════════════════════════════════════════╗
  // ║  4.2 — Controller masuk DI SINI                  ║
  // ╚══════════════════════════════════════════════════╝

  void _submitDummy() { /* ... kod Latihan 3, buang pada 4.12 ... */ }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Borang Permohonan eTT')),
      body: Form(
        key: _formKey,
        // PENTING: SingleChildScrollView + Column, BUKAN ListView.
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Maklumat Pemohon',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // ╔══════════════════════════════════════╗
              // ║  4.4 — TextFormField masuk DI SINI   ║
              // ╚══════════════════════════════════════╝
            ],
          ),
        ),
      ),
    );
  }
}