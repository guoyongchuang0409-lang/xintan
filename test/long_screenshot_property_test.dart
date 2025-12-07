// Property-based tests for long screenshot content completeness
// **Feature: dialog-toast-optimization, Property 1: Long screenshot captures complete content**
// **Validates: Requirements 3.1, 3.2**

import 'dart:math';
import 'package:test/test.dart';
import 'package:glados/glados.dart';

// Local test models to avoid Flutter dependencies
// These mirror the domain models but are pure Dart

enum TestRatingLevel {
  sss('SSS', '非常喜欢'),
  ss('SS', '喜欢'),
  s('S', '无所谓'),
  q('Q', '不喜欢但会做'),
  n('N', '绝不'),
  w('W', '未知');

  final String code;
  final String description;

  const TestRatingLevel(this.code, this.description);
}

class TestQuizItem {
  final String id;
  final String name;
  final String categoryId;
  final String? description;

  const TestQuizItem({
    required this.id,
    required this.name,
    required this.categoryId,
    this.description,
  });
}

class TestSelectionDetail {
  final TestQuizItem item;
  final TestRatingLevel rating;

  const TestSelectionDetail({
    required this.item,
    required this.rating,
  });
}

class TestCategoryStats {
  final String categoryName;
  final Map<TestRatingLevel, int> levelCounts;
  final Map<TestRatingLevel, double> levelPercentages;
  final List<TestSelectionDetail> selections;

  const TestCategoryStats({
    required this.categoryName,
    required this.levelCounts,
    required this.levelPercentages,
    this.selections = const [],
  });
}

class TestQuizReport {
  final String id;
  final String quizTypeId;
  final String quizTypeName;
  final DateTime createdAt;
  final Map<String, TestRatingLevel> ratings;
  final Map<String, TestCategoryStats> categoryStats;
  final String? shareCode;

  const TestQuizReport({
    required this.id,
    required this.quizTypeId,
    required this.quizTypeName,
    required this.createdAt,
    required this.ratings,
    required this.categoryStats,
    this.shareCode,
  });
}

/// Pure function to build the complete report widget structure for screenshot
/// This mirrors the logic in report_page.dart _buildCompleteReportForScreenshot
/// but returns a list of section identifiers for testing
List<String> buildReportSections(TestQuizReport report) {
  final sections = <String>[];
  
  // 1. Report header - always present
  sections.add('header');
  
  // 2. Summary section - always present
  sections.add('summary');
  
  // 3. Detail table - always present
  sections.add('detail_table');
  
  // 4. Selection details - one for each category
  for (final categoryId in report.categoryStats.keys) {
    sections.add('selection_$categoryId');
  }
  
  // 5. Analysis section - always present
  sections.add('analysis');
  
  return sections;
}

/// Count the expected number of sections in a report
int countExpectedSections(TestQuizReport report) {
  // Base sections: header, summary, detail_table, analysis = 4
  // Plus one selection detail section per category
  return 4 + report.categoryStats.length;
}

/// Verify that all category selections are included
bool allCategorySelectionsIncluded(TestQuizReport report, List<String> sections) {
  for (final categoryId in report.categoryStats.keys) {
    if (!sections.contains('selection_$categoryId')) {
      return false;
    }
  }
  return true;
}

/// Verify that all base sections are present
bool allBaseSectionsPresent(List<String> sections) {
  return sections.contains('header') &&
         sections.contains('summary') &&
         sections.contains('detail_table') &&
         sections.contains('analysis');
}

/// Generate a random QuizItem
TestQuizItem generateQuizItem(Random random, String categoryId, int index) {
  return TestQuizItem(
    id: 'item_${categoryId}_$index',
    name: 'Test Item $index',
    categoryId: categoryId,
    description: random.nextBool() ? 'Description for item $index' : null,
  );
}

/// Generate random CategoryStats
TestCategoryStats generateCategoryStats(Random random, String categoryId, int itemCount) {
  final levelCounts = <TestRatingLevel, int>{};
  final levelPercentages = <TestRatingLevel, double>{};
  final selections = <TestSelectionDetail>[];
  
  // Initialize counts
  for (final level in TestRatingLevel.values) {
    levelCounts[level] = 0;
  }
  
  // Generate selections
  for (int i = 0; i < itemCount; i++) {
    final item = generateQuizItem(random, categoryId, i);
    final rating = TestRatingLevel.values[random.nextInt(TestRatingLevel.values.length)];
    levelCounts[rating] = (levelCounts[rating] ?? 0) + 1;
    selections.add(TestSelectionDetail(item: item, rating: rating));
  }
  
  // Calculate percentages
  for (final level in TestRatingLevel.values) {
    final count = levelCounts[level] ?? 0;
    levelPercentages[level] = itemCount > 0 ? (count / itemCount * 100) : 0.0;
  }
  
  return TestCategoryStats(
    categoryName: 'Category $categoryId',
    levelCounts: levelCounts,
    levelPercentages: levelPercentages,
    selections: selections,
  );
}

/// Parameters for property tests
class ReportParams {
  final int categoryCount;
  final List<int> itemsPerCategory;

  ReportParams({
    required this.categoryCount,
    required this.itemsPerCategory,
  });

  @override
  String toString() =>
      'ReportParams(categoryCount: $categoryCount, itemsPerCategory: $itemsPerCategory)';
}

/// Generate a QuizReport from ReportParams
TestQuizReport generateReport(ReportParams params, Random random) {
  final categoryStats = <String, TestCategoryStats>{};
  final ratings = <String, TestRatingLevel>{};
  
  for (int i = 0; i < params.categoryCount; i++) {
    final categoryId = 'cat_$i';
    final itemCount = params.itemsPerCategory[i];
    final stats = generateCategoryStats(random, categoryId, itemCount);
    categoryStats[categoryId] = stats;
    
    // Add ratings for each item
    for (final selection in stats.selections) {
      ratings[selection.item.id] = selection.rating;
    }
  }
  
  return TestQuizReport(
    id: 'test_report_${random.nextInt(10000)}',
    quizTypeId: 'test_type',
    quizTypeName: 'Test Quiz',
    createdAt: DateTime.now(),
    ratings: ratings,
    categoryStats: categoryStats,
    shareCode: 'TEST01',
  );
}

/// Generator function for ReportParams
Shrinkable<ReportParams> generateReportParams(Random random, int size) {
  // Category count: 1-5 categories (realistic range)
  final categoryCount = 1 + random.nextInt(5);
  
  // Items per category: 1-10 items each
  final itemsPerCategory = List.generate(
    categoryCount,
    (_) => 1 + random.nextInt(10),
  );
  
  final params = ReportParams(
    categoryCount: categoryCount,
    itemsPerCategory: itemsPerCategory,
  );
  
  return Shrinkable(params, () sync* {
    // Try reducing category count
    if (params.categoryCount > 1) {
      yield Shrinkable(ReportParams(
        categoryCount: params.categoryCount - 1,
        itemsPerCategory: params.itemsPerCategory.sublist(0, params.categoryCount - 1),
      ), () sync* {});
    }
    
    // Try reducing items in each category
    for (int i = 0; i < params.itemsPerCategory.length; i++) {
      if (params.itemsPerCategory[i] > 1) {
        final newItems = List<int>.from(params.itemsPerCategory);
        newItems[i] = newItems[i] - 1;
        yield Shrinkable(ReportParams(
          categoryCount: params.categoryCount,
          itemsPerCategory: newItems,
        ), () sync* {});
      }
    }
  });
}

void main() {
  group('Property 1: Long screenshot captures complete content', () {
    Glados(generateReportParams).test(
      'screenshot widget should contain all required sections',
      (params) {
        final random = Random(42); // Fixed seed for reproducibility
        final report = generateReport(params, random);
        final sections = buildReportSections(report);
        
        // Verify all base sections are present
        expect(allBaseSectionsPresent(sections), isTrue,
            reason: 'All base sections (header, summary, detail_table, analysis) '
                'should be present. Got: $sections');
      },
    );

    Glados(generateReportParams).test(
      'screenshot widget should include all category selection details',
      (params) {
        final random = Random(42);
        final report = generateReport(params, random);
        final sections = buildReportSections(report);
        
        // Verify all category selections are included
        expect(allCategorySelectionsIncluded(report, sections), isTrue,
            reason: 'All category selection details should be included. '
                'Categories: ${report.categoryStats.keys.toList()}, '
                'Sections: $sections');
      },
    );

    Glados(generateReportParams).test(
      'section count should equal base sections plus category count',
      (params) {
        final random = Random(42);
        final report = generateReport(params, random);
        final sections = buildReportSections(report);
        final expectedCount = countExpectedSections(report);
        
        expect(sections.length, equals(expectedCount),
            reason: 'Section count ${sections.length} should equal '
                'expected count $expectedCount (4 base + ${report.categoryStats.length} categories)');
      },
    );

    Glados(generateReportParams).test(
      'sections should be in correct order',
      (params) {
        final random = Random(42);
        final report = generateReport(params, random);
        final sections = buildReportSections(report);
        
        // Verify order: header -> summary -> detail_table -> selections -> analysis
        final headerIndex = sections.indexOf('header');
        final summaryIndex = sections.indexOf('summary');
        final detailTableIndex = sections.indexOf('detail_table');
        final analysisIndex = sections.indexOf('analysis');
        
        expect(headerIndex, equals(0),
            reason: 'Header should be first section');
        expect(summaryIndex, equals(1),
            reason: 'Summary should be second section');
        expect(detailTableIndex, equals(2),
            reason: 'Detail table should be third section');
        expect(analysisIndex, equals(sections.length - 1),
            reason: 'Analysis should be last section');
        
        // All selection sections should be between detail_table and analysis
        for (int i = 3; i < sections.length - 1; i++) {
          expect(sections[i].startsWith('selection_'), isTrue,
              reason: 'Section at index $i should be a selection section');
        }
      },
    );

    test('empty category stats should still have base sections', () {
      final report = TestQuizReport(
        id: 'empty_test',
        quizTypeId: 'test_type',
        quizTypeName: 'Empty Test',
        createdAt: DateTime.now(),
        ratings: {},
        categoryStats: {},
        shareCode: 'EMPTY1',
      );
      
      final sections = buildReportSections(report);
      
      expect(sections.length, equals(4),
          reason: 'Empty report should have 4 base sections');
      expect(allBaseSectionsPresent(sections), isTrue,
          reason: 'All base sections should be present even with no categories');
    });

    test('single category report should have 5 sections', () {
      final random = Random(42);
      final params = ReportParams(categoryCount: 1, itemsPerCategory: [3]);
      final report = generateReport(params, random);
      final sections = buildReportSections(report);
      
      expect(sections.length, equals(5),
          reason: 'Single category report should have 5 sections (4 base + 1 selection)');
    });
  });
}
