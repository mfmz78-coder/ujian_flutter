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
  final Map<String, bool> _documents = {};

  EntryCategory? _academicCategory;

  late String _country;
  late String _fieldOfStudy;

  String? _choice1;
  String? _choice2;
  String? _choice3;

  @override
  void initState() {
    super.initState();

    _country = widget.programme.country;
    _fieldOfStudy = widget.programme.fieldOfStudy;
    _choice1 = widget.programme.id;

    for (final document in ettDocumentChecklist) {
      _documents[document] = false;
    }
  }

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

  List<String> get _countries =>
      {for (final p in sampleProgrammes) p.country}.toList();

  String _countryLabel(String country) => switch (country) {
    'Egypt' => '🇪🇬 Mesir',
    'Morocco' => '🇲🇦 Maghribi',
    _ => country,
  };

  List<String> get _fields => {
    for (final p in sampleProgrammes)
      if (p.country == _country) p.fieldOfStudy,
  }.toList();

  List<Programme> get _choiceProgrammes {
    return sampleProgrammes
        .where((p) => p.country == _country && p.fieldOfStudy == _fieldOfStudy)
        .toList();
  }

  void _onCountryChanged(String? value) {
    if (value == null) return;

    setState(() {
      _country = value;

      final fields = _fields;
      _fieldOfStudy = fields.isNotEmpty ? fields.first : '';

      _resetChoices();
    });
  }

  void _onFieldChanged(String? value) {
    if (value == null) return;

    setState(() {
      _fieldOfStudy = value;
      _resetChoices();
    });
  }

  void _resetChoices() {
    final programmes = _choiceProgrammes;

    _choice1 = programmes.isNotEmpty ? programmes.first.id : null;

    _choice2 = null;
    _choice3 = null;
  }

  void _submitDummy() {
    /* ... kod Latihan 3, buang pada 4.12 ... */
  }

  @override
  Widget build(BuildContext context) {
    final choiceProgrammes = _choiceProgrammes;
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

              const SizedBox(height: 24),

              const Text(
                'Kelayakan & Pilihan Pengajian',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<EntryCategory>(
                initialValue: _academicCategory,
                decoration: const InputDecoration(labelText: 'Kategori Sijil'),
                items: const [
                  DropdownMenuItem<EntryCategory>(
                    value: EntryCategory.spm,
                    child: Text('SPM'),
                  ),
                  DropdownMenuItem<EntryCategory>(
                    value: EntryCategory.stam,
                    child: Text('STAM'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _academicCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Sila pilih kategori sijil';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 14),

              Text(
                'Peraturan eTT: 1 negara + 1 bidang setiap permohonan. '
                'Anda boleh menyusun sehingga 3 pilihan universiti '
                'dalam bidang tersebut.',
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),

              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
                initialValue: _country,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Negara (satu sahaja)',
                ),
                items: [
                  for (final country in _countries)
                    DropdownMenuItem<String>(
                      value: country,
                      child: Text(_countryLabel(country)),
                    ),
                ],
                onChanged: _onCountryChanged,
                validator: (value) {
                  if (value == null) {
                    return 'Sila pilih negara';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 14),

              DropdownButtonFormField<String>(
                initialValue: _fields.contains(_fieldOfStudy)
                    ? _fieldOfStudy
                    : null,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Bidang (satu sahaja)',
                ),
                items: [
                  for (final field in _fields)
                    DropdownMenuItem<String>(
                      value: field,
                      child: Text(field, overflow: TextOverflow.ellipsis),
                    ),
                ],
                onChanged: _onFieldChanged,
                validator: (value) {
                  if (value == null) {
                    return 'Sila pilih bidang';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 14),

              _ChoiceDropdown(
                label: 'Pilihan 1 (wajib)',
                value: _choice1,
                programmes: choiceProgrammes,
                onChanged: (value) {
                  setState(() {
                    _choice1 = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Pilihan 1 diperlukan';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 14),

              _ChoiceDropdown(
                label: 'Pilihan 2 (pilihan)',
                value: _choice2,
                programmes: choiceProgrammes,
                includeNone: true,
                onChanged: (value) {
                  setState(() {
                    _choice2 = value;
                  });
                },
              ),

              const SizedBox(height: 14),

              _ChoiceDropdown(
                label: 'Pilihan 3 (pilihan)',
                value: _choice3,
                programmes: choiceProgrammes,
                includeNone: true,
                onChanged: (value) {
                  setState(() {
                    _choice3 = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChoiceDropdown extends StatelessWidget {
  const _ChoiceDropdown({
    required this.label,
    required this.value,
    required this.programmes,
    required this.onChanged,
    this.validator,
    this.includeNone = false,
  });

  final String label;
  final String? value;
  final List<Programme> programmes;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;
  final bool includeNone;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(labelText: label),
      items: [
        if (includeNone)
          const DropdownMenuItem<String>(value: null, child: Text('Tiada')),
        for (final programme in programmes)
          DropdownMenuItem<String>(
            value: programme.id,
            child: Text(
              '${programme.universityName} '
              '(${programme.city})',
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
      onChanged: onChanged,
      validator: validator,
    );
  }
}
