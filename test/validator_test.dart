import 'package:flutter_test/flutter_test.dart';
import 'package:ujian_flutter/utils/validators.dart';

void main() {
  group('validateAcademicSummary', () {
    test('menolak null', () {
      expect(
        validateAcademicSummary(null),
        'Ringkasan keputusan diperlukan',
      );
    });

    test('menolak string kosong', () {
      expect(
        validateAcademicSummary(''),
        'Ringkasan keputusan diperlukan',
      );
    });

    test('menolak ruang kosong sahaja', () {
      expect(
        validateAcademicSummary('     '),
        'Ringkasan keputusan diperlukan',
      );
    });

    test('menerima ringkasan keputusan yang sah', () {
      expect(
        validateAcademicSummary('SPM 2025 — 9A'),
        isNull,
      );
    });
  });
}