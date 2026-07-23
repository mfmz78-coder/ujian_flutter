import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/sample_programmes.dart';
import '../models/programme.dart';

class ProgrammeService {
  ProgrammeService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const String _endpoint =
      'https://raw.githubusercontent.com/mfmz78-coder/ujian_flutter/main/mock-api/programmes.json';

  // ── 4.1 — GET paling bare, cetak sahaja ───────────────
  Future<List<Programme>> fetchProgrammes() async {
  try {
    final response = await _client
        .get(Uri.parse(_endpoint))
        .timeout(const Duration(seconds: 8));

    if (response.statusCode == 200) {
      final List<dynamic> data =
          jsonDecode(response.body) as List<dynamic>;

      return data
          .map(
            (e) => Programme.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();
    }

    return _fallback();
  } catch (_) {
    return _fallback();
  }
}

  void dispose() => _client.close();
}
