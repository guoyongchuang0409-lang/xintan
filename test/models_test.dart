// Pure Dart unit tests for domain models
// These tests verify serialization round-trip for core models

import 'package:flutter_test/flutter_test.dart';
import 'package:personality_quiz_app/domain/models/rating_level.dart';
import 'package:personality_quiz_app/domain/models/app_settings.dart';
import 'package:personality_quiz_app/domain/models/quiz_report.dart';

void main() {
  group('RatingLevel', () {
    test('toJson returns correct code', () {
      expect(RatingLevel.sss.toJson(), 'SSS');
      expect(RatingLevel.ss.toJson(), 'SS');
      expect(RatingLevel.s.toJson(), 'S');
      expect(RatingLevel.q.toJson(), 'Q');
      expect(RatingLevel.n.toJson(), 'N');
      expect(RatingLevel.w.toJson(), 'W');
    });

    test('fromJson returns correct enum', () {
      expect(RatingLevel.fromJson('SSS'), RatingLevel.sss);
      expect(RatingLevel.fromJson('SS'), RatingLevel.ss);
      expect(RatingLevel.fromJson('S'), RatingLevel.s);
      expect(RatingLevel.fromJson('Q'), RatingLevel.q);
      expect(RatingLevel.fromJson('N'), RatingLevel.n);
      expect(RatingLevel.fromJson('W'), RatingLevel.w);
    });

    test('fromJson returns w for unknown code', () {
      expect(RatingLevel.fromJson('UNKNOWN'), RatingLevel.w);
    });

    test('round-trip serialization', () {
      for (final level in RatingLevel.values) {
        final json = level.toJson();
        final restored = RatingLevel.fromJson(json);
        expect(restored, level);
      }
    });
  });

  group('AppSettings', () {
    test('default values', () {
      const settings = AppSettings();
      expect(settings.autoSaveScreenshot, true);
    });

    test('toJson/fromJson round-trip', () {
      const settings = AppSettings(autoSaveScreenshot: false);
      final json = settings.toJson();
      final restored = AppSettings.fromJson(json);
      expect(restored.autoSaveScreenshot, settings.autoSaveScreenshot);
      expect(restored, settings);
    });


    test('copyWith creates new instance with updated values', () {
      const original = AppSettings(autoSaveScreenshot: true);
      final modified = original.copyWith(autoSaveScreenshot: false);
      expect(modified.autoSaveScreenshot, false);
      expect(original.autoSaveScreenshot, true);
    });
  });

  group('QuizReport', () {
    test('toJson/fromJson round-trip', () {
      final report = QuizReport(
        id: 'test-id-123',
        quizTypeId: 'female-m',
        quizTypeName: '女M自测',
        createdAt: DateTime(2024, 1, 15, 10, 30),
        ratings: {
          'item1': RatingLevel.sss,
          'item2': RatingLevel.ss,
          'item3': RatingLevel.n,
        },
        categoryStats: {
          'category1': CategoryStats(
            categoryName: '性奴',
            levelCounts: {
              RatingLevel.sss: 1,
              RatingLevel.ss: 1,
              RatingLevel.n: 1,
            },
            levelPercentages: {
              RatingLevel.sss: 33.33,
              RatingLevel.ss: 33.33,
              RatingLevel.n: 33.34,
            },
          ),
        },
      );

      final json = report.toJson();
      final restored = QuizReport.fromJson(json);

      expect(restored.id, report.id);
      expect(restored.quizTypeId, report.quizTypeId);
      expect(restored.quizTypeName, report.quizTypeName);
      expect(restored.createdAt, report.createdAt);
      expect(restored.ratings.length, report.ratings.length);
      expect(restored.ratings['item1'], RatingLevel.sss);
      expect(restored.ratings['item2'], RatingLevel.ss);
      expect(restored.ratings['item3'], RatingLevel.n);
      expect(restored.categoryStats.length, report.categoryStats.length);
      expect(restored.categoryStats['category1']?.categoryName, '性奴');
    });
  });

  group('CategoryStats', () {
    test('toJson/fromJson round-trip', () {
      final stats = CategoryStats(
        categoryName: '测试分类',
        levelCounts: {
          RatingLevel.sss: 5,
          RatingLevel.ss: 3,
          RatingLevel.s: 2,
        },
        levelPercentages: {
          RatingLevel.sss: 50.0,
          RatingLevel.ss: 30.0,
          RatingLevel.s: 20.0,
        },
      );

      final json = stats.toJson();
      final restored = CategoryStats.fromJson(json);

      expect(restored.categoryName, stats.categoryName);
      expect(restored.levelCounts[RatingLevel.sss], 5);
      expect(restored.levelCounts[RatingLevel.ss], 3);
      expect(restored.levelCounts[RatingLevel.s], 2);
      expect(restored.levelPercentages[RatingLevel.sss], 50.0);
      expect(restored.levelPercentages[RatingLevel.ss], 30.0);
      expect(restored.levelPercentages[RatingLevel.s], 20.0);
    });
  });
}
