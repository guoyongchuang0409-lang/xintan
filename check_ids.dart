// Script to check QuizItem IDs for format compliance, duplicates, and sequential numbering
import 'lib/core/constants/quiz_data.dart';

void main() {
  final quizTypes = QuizData.getAllQuizTypes();
  
  final allIds = <String>[];
  final idsByCategory = <String, List<String>>{};
  
  for (final quizType in quizTypes) {
    for (final category in quizType.categories) {
      for (final item in category.items) {
        final id = item.id;
        allIds.add(id);
        
        // Extract category from ID (everything except the last _XX part)
        final parts = id.split('_');
        if (parts.length >= 3) {
          final categoryKey = parts.sublist(0, parts.length - 1).join('_');
          idsByCategory.putIfAbsent(categoryKey, () => []);
          idsByCategory[categoryKey]!.add(id);
        }
      }
    }
  }
  
  print('=== ID规范性检查报告 ===\n');
  print('总共检查了 ${allIds.length} 个QuizItem ID\n');
  
  // Check 1: Format compliance (类型_分类_序号)
  print('--- 1. ID格式检查 ---');
  final formatPattern = RegExp(r'^[a-z_]+_[a-z_]+_\d{2}$');
  final invalidFormat = <String>[];
  for (final id in allIds) {
    if (!formatPattern.hasMatch(id)) {
      invalidFormat.add(id);
    }
  }
  if (invalidFormat.isEmpty) {
    print('✓ 所有ID格式符合规范（类型_分类_序号）');
  } else {
    print('✗ 发现 ${invalidFormat.length} 个格式不规范的ID:');
    for (final id in invalidFormat) {
      print('  - $id');
    }
  }
  print('');
  
  // Check 2: Duplicate IDs
  print('--- 2. 重复ID检查 ---');
  final idCounts = <String, int>{};
  for (final id in allIds) {
    idCounts[id] = (idCounts[id] ?? 0) + 1;
  }
  final duplicates = idCounts.entries.where((e) => e.value > 1).toList();
  if (duplicates.isEmpty) {
    print('✓ 没有发现重复ID');
  } else {
    print('✗ 发现 ${duplicates.length} 个重复ID:');
    for (final dup in duplicates) {
      print('  - ${dup.key} (出现 ${dup.value} 次)');
    }
  }
  print('');
  
  // Check 3: Sequential numbering within each category
  print('--- 3. ID序号连续性检查 ---');
  final nonSequential = <String, List<String>>{};
  
  for (final entry in idsByCategory.entries) {
    final category = entry.key;
    final ids = entry.value;
    
    // Extract numbers and sort
    final numbers = <int>[];
    for (final id in ids) {
      final numMatch = RegExp(r'_(\d+)$').firstMatch(id);
      if (numMatch != null) {
        numbers.add(int.parse(numMatch.group(1)!));
      }
    }
    numbers.sort();
    
    // Check for gaps
    final gaps = <String>[];
    for (int i = 0; i < numbers.length - 1; i++) {
      if (numbers[i + 1] - numbers[i] > 1) {
        gaps.add('${numbers[i]} -> ${numbers[i + 1]}');
      }
    }
    
    // Check if starts from 01
    if (numbers.isNotEmpty && numbers.first != 1) {
      gaps.insert(0, '起始序号为 ${numbers.first.toString().padLeft(2, '0')} (应为 01)');
    }
    
    if (gaps.isNotEmpty) {
      nonSequential[category] = gaps;
    }
  }
  
  if (nonSequential.isEmpty) {
    print('✓ 所有分类的ID序号连续');
  } else {
    print('✗ 发现 ${nonSequential.length} 个分类的ID序号不连续:');
    for (final entry in nonSequential.entries) {
      print('  分类: ${entry.key}');
      for (final gap in entry.value) {
        print('    - $gap');
      }
    }
  }
  print('');
  
  // Summary by category
  print('--- 4. 各分类ID数量统计 ---');
  final sortedCategories = idsByCategory.keys.toList()..sort();
  for (final category in sortedCategories) {
    print('  $category: ${idsByCategory[category]!.length} 个');
  }
  
  print('\n=== 检查完成 ===');
}
