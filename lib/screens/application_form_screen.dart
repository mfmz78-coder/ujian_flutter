import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/document_checklist.dart';
import '../data/sample_programmes.dart';
import '../models/application.dart';
import '../models/programme.dart';
import '../utils/validators.dart';

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

  void _submitDummy() {
    /* ... kod Latihan 3, buang pada 4.12 ... */
  }

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
              const SizedBox(height: 14),

              // ── 4.5 — No. Kad Pengenalan ──────────────
              TextFormField(
                controller: _icCtrl,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
                ],
                decoration: const InputDecoration(
                  labelText: 'No. Kad Pengenalan',
                  hintText: '051231-14-5678',
                ),
                validator: validateIcNumber,
              ),

              // 👈 4.6 — TAMBAH Emel, Telefon, Ringkasan SELEPAS BARIS INI-------
              const SizedBox(height: 14),

              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Emel',
                  hintText: 'nama@contoh.com',
                ),
                validator: validateEmail,
              ),

              const SizedBox(height: 14),

              TextFormField(
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'No. Telefon',
                  hintText: '0123456789',
                ),
                validator: validatePhoneNumber,
              ),

              const SizedBox(height: 14),

              TextFormField(
                controller: _academicCtrl,
                decoration: const InputDecoration(
                  labelText: 'Ringkasan Keputusan',
                  hintText: 'Cth: SPM 2025 — 9A',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ringkasan keputusan diperlukan';
                  }

                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
