import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/programme.dart';

class ProgrammeService {
  ProgrammeService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const String _endpoint =
      'https://raw.githubusercontent.com/mfmz78-coder/ujian_flutter/main/mock-api/programmes.json';

  // ── 4.1 — GET paling bare, cetak sahaja ───────────────
  Future<List<Programme>> fetchProgrammes() async {
    final response = await _client.get(Uri.parse(_endpoint));
    // ignore: avoid_print
    print('Status: ${response.statusCode}');
    // ignore: avoid_print
    print('Body: ${response.body}');
    return []; // 👈 4.2 — GANTI baris ini dengan penghuraian JSON sebenar
  }

  void dispose() => _client.close();
}
