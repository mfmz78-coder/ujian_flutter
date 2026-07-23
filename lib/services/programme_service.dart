import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/sample_programmes.dart';
import '../models/programme.dart';
import '../models/application.dart';

class ProgrammeService {
  ProgrammeService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const String _endpoint =
      'https://raw.githubusercontent.com/mfmz78-coder/ujian_flutter/main/mock-api/programmes.json';

  static const String _baseUrl = 'http://localhost:3001';

  // ── 4.1 — GET paling bare, cetak sahaja ───────────────
  Future<List<Programme>> fetchProgrammes() async {
    try {
      final response = await _client
          .get(Uri.parse(_endpoint))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

        return data
            .map((e) => Programme.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      // print('status: ${response.statusCode}');
      return _fallback();
    } catch (_) {
      return _fallback();
    }
  }

  Future<List<Programme>> _fallback() async {
    await Future.delayed(const Duration(milliseconds: 600));

    return sampleProgrammes;
  }

  Future<bool> submitApplication(Application application) async {
    try {
      final response = await _client
          .post(
            Uri.parse('$_baseUrl/applications'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(application.toJson()),
          )
          .timeout(const Duration(seconds: 8));

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (_) {
      return false;
    }
  }

  void dispose() => _client.close();
}
