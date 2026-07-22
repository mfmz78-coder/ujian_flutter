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
    // ── 4.2 — Input Controller ─────────────────────────
  final _nameCtrl = TextEditingController();
  final _icCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _academicCtrl = TextEditingController();

  // 👈 4.3 — TAMBAH dispose() SELEPAS BARIS INI
    @override
  void dispose() {
    // ── 4.3 — Bersihkan setiap Controller ─────────────
    _nameCtrl.dispose();
    _icCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _academicCtrl.dispose();
    super.dispose(); // WAJIB baris TERAKHIR
  }

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
            // ── 4.4 — Nama Penuh ──────────────────────
            TextFormField(
              controller: _nameCtrl,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Nama Penuh'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Nama diperlukan' : null,
            ),

            // 👈 4.5 — TAMBAH medan IC SELEPAS BARIS INI
            ],
          ),
        ),
      ),
    );
  }
}