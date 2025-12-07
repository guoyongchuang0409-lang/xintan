// Property-based tests for internal element scaling ratio consistency
// **Feature: personality-quiz-app, Property 14: 内部元素缩放比例一致性**
// **Validates: Requirements 11.4**

import 'dart:math';
import 'package:test/test.dart';
import 'package:glados/glados.dart';

/// Pure calculation functions extracted from ResponsiveUtils for testing
/// These mirror the logic in ResponsiveUtils but without BuildContext dependency

/// Base card height for scaling calculations
const double baseCardHeight = 100.0;

/// Get the scale factor for a given card height
double getCardScaleFactor(double cardHeight) {
  return cardHeight / baseCardHeight;
}

/// Get adaptive icon size based on card height
/// Constrained to 36-52px range
double getAdaptiveIconSize(double cardHeight) {
  final scaleFactor = getCardScaleFactor(cardHeight);
  return (48 * scaleFactor).clamp(36.0, 52.0);
}

/// Get adaptive title font size based on card height
/// Constrained to 14-17px range
double getAdaptiveTitleFontSize(double cardHeight) {
  final scaleFactor = getCardScaleFactor(cardHeight);
  return (16 * scaleFactor).clamp(14.0, 17.0);
}

/// Get adaptive description font size based on card height
/// Constrained to 11-13px range
double getAdaptiveDescFontSize(double cardHeight) {
  final scaleFactor = getCardScaleFactor(cardHeight);
  return (12 * scaleFactor).clamp(11.0, 13.0);
}

/// Input parameters for element scaling property tests
class ElementScalingParams {
  final double cardHeight;

  ElementScalingParams({required this.cardHeight});

  @override
  String toString() => 'ElementScalingParams(cardHeight: $cardHeight)';
}

/// Generator function for ElementScalingParams
/// Card height is constrained to 70-120px as per design spec
Shrinkable<ElementScalingParams> generateElementScalingParams(Random random, int size) {
  // Card height: 70-120 pixels (valid range from design spec)
  final cardHeight = 70.0 + random.nextDouble() * 50.0;
  
  final params = ElementScalingParams(cardHeight: cardHeight);
  
  return Shrinkable(params, () sync* {
    // Try shrinking towards minimum card height
    if (params.cardHeight > 70.0) {
      yield Shrinkable(ElementScalingParams(
        cardHeight: ((params.cardHeight - 10.0).clamp(70.0, 120.0)),
      ), () sync* {});
    }
  });
}

/// Generator for pairs of card heights to test ratio consistency
class CardHeightPair {
  final double cardHeight1;
  final double cardHeight2;

  CardHeightPair({required this.cardHeight1, required this.cardHeight2});

  @override
  String toString() => 
      'CardHeightPair(cardHeight1: $cardHeight1, cardHeight2: $cardHeight2)';
}

Shrinkable<CardHeightPair> generateCardHeightPair(Random random, int size) {
  // Card heights: 70-120 pixels (valid range from design spec)
  final cardHeight1 = 70.0 + random.nextDouble() * 50.0;
  final cardHeight2 = 70.0 + random.nextDouble() * 50.0;
  
  final params = CardHeightPair(
    cardHeight1: cardHeight1,
    cardHeight2: cardHeight2,
  );
  
  return Shrinkable(params, () sync* {
    if (params.cardHeight1 > 70.0) {
      yield Shrinkable(CardHeightPair(
        cardHeight1: (params.cardHeight1 - 10.0).clamp(70.0, 120.0),
        cardHeight2: params.cardHeight2,
      ), () sync* {});
    }
    if (params.cardHeight2 > 70.0) {
      yield Shrinkable(CardHeightPair(
        cardHeight1: params.cardHeight1,
        cardHeight2: (params.cardHeight2 - 10.0).clamp(70.0, 120.0),
      ), () sync* {});
    }
  });
}

void main() {
  group('Property 14: 内部元素缩放比例一致性', () {
    Glados(generateElementScalingParams).test(
      'icon size should be within valid range (36-52px)',
      (params) {
        final iconSize = getAdaptiveIconSize(params.cardHeight);
        
        expect(iconSize, greaterThanOrEqualTo(36.0),
            reason: 'Icon size $iconSize should be >= 36.0 '
                'for card height ${params.cardHeight}');
        expect(iconSize, lessThanOrEqualTo(52.0),
            reason: 'Icon size $iconSize should be <= 52.0 '
                'for card height ${params.cardHeight}');
      },
    );

    Glados(generateElementScalingParams).test(
      'title font size should be within valid range (14-17px)',
      (params) {
        final titleSize = getAdaptiveTitleFontSize(params.cardHeight);
        
        expect(titleSize, greaterThanOrEqualTo(14.0),
            reason: 'Title font size $titleSize should be >= 14.0 '
                'for card height ${params.cardHeight}');
        expect(titleSize, lessThanOrEqualTo(17.0),
            reason: 'Title font size $titleSize should be <= 17.0 '
                'for card height ${params.cardHeight}');
      },
    );

    Glados(generateElementScalingParams).test(
      'description font size should be within valid range (11-13px)',
      (params) {
        final descSize = getAdaptiveDescFontSize(params.cardHeight);
        
        expect(descSize, greaterThanOrEqualTo(11.0),
            reason: 'Description font size $descSize should be >= 11.0 '
                'for card height ${params.cardHeight}');
        expect(descSize, lessThanOrEqualTo(13.0),
            reason: 'Description font size $descSize should be <= 13.0 '
                'for card height ${params.cardHeight}');
      },
    );

    Glados(generateCardHeightPair).test(
      'icon size ratio should match card height ratio (within constraints)',
      (params) {
        final iconSize1 = getAdaptiveIconSize(params.cardHeight1);
        final iconSize2 = getAdaptiveIconSize(params.cardHeight2);
        
        // Calculate expected ratio based on card heights
        final cardHeightRatio = params.cardHeight1 / params.cardHeight2;
        
        // Calculate actual icon size ratio
        final iconSizeRatio = iconSize1 / iconSize2;
        
        // When both icon sizes are within unconstrained range,
        // the ratio should match the card height ratio
        final unconstrainedIcon1 = 48 * (params.cardHeight1 / baseCardHeight);
        final unconstrainedIcon2 = 48 * (params.cardHeight2 / baseCardHeight);
        
        // If both are unconstrained (within 36-52 range), ratios should match
        if (unconstrainedIcon1 >= 36.0 && unconstrainedIcon1 <= 52.0 &&
            unconstrainedIcon2 >= 36.0 && unconstrainedIcon2 <= 52.0) {
          final ratioDiff = (iconSizeRatio - cardHeightRatio).abs();
          expect(ratioDiff, lessThan(0.01),
              reason: 'Icon size ratio $iconSizeRatio should match '
                  'card height ratio $cardHeightRatio (diff: $ratioDiff)');
        }
      },
    );

    Glados(generateCardHeightPair).test(
      'title font size ratio should match card height ratio (within constraints)',
      (params) {
        final titleSize1 = getAdaptiveTitleFontSize(params.cardHeight1);
        final titleSize2 = getAdaptiveTitleFontSize(params.cardHeight2);
        
        final cardHeightRatio = params.cardHeight1 / params.cardHeight2;
        final titleSizeRatio = titleSize1 / titleSize2;
        
        // Calculate unconstrained values
        final unconstrainedTitle1 = 16 * (params.cardHeight1 / baseCardHeight);
        final unconstrainedTitle2 = 16 * (params.cardHeight2 / baseCardHeight);
        
        // If both are unconstrained (within 14-17 range), ratios should match
        if (unconstrainedTitle1 >= 14.0 && unconstrainedTitle1 <= 17.0 &&
            unconstrainedTitle2 >= 14.0 && unconstrainedTitle2 <= 17.0) {
          final ratioDiff = (titleSizeRatio - cardHeightRatio).abs();
          expect(ratioDiff, lessThan(0.01),
              reason: 'Title font size ratio $titleSizeRatio should match '
                  'card height ratio $cardHeightRatio (diff: $ratioDiff)');
        }
      },
    );

    Glados(generateCardHeightPair).test(
      'description font size ratio should match card height ratio (within constraints)',
      (params) {
        final descSize1 = getAdaptiveDescFontSize(params.cardHeight1);
        final descSize2 = getAdaptiveDescFontSize(params.cardHeight2);
        
        final cardHeightRatio = params.cardHeight1 / params.cardHeight2;
        final descSizeRatio = descSize1 / descSize2;
        
        // Calculate unconstrained values
        final unconstrainedDesc1 = 12 * (params.cardHeight1 / baseCardHeight);
        final unconstrainedDesc2 = 12 * (params.cardHeight2 / baseCardHeight);
        
        // If both are unconstrained (within 11-13 range), ratios should match
        if (unconstrainedDesc1 >= 11.0 && unconstrainedDesc1 <= 13.0 &&
            unconstrainedDesc2 >= 11.0 && unconstrainedDesc2 <= 13.0) {
          final ratioDiff = (descSizeRatio - cardHeightRatio).abs();
          expect(ratioDiff, lessThan(0.01),
              reason: 'Description font size ratio $descSizeRatio should match '
                  'card height ratio $cardHeightRatio (diff: $ratioDiff)');
        }
      },
    );

    Glados(generateElementScalingParams).test(
      'element sizes should increase monotonically with card height',
      (params) {
        // Test with a slightly larger card height
        final largerCardHeight = (params.cardHeight + 5.0).clamp(70.0, 120.0);
        
        if (largerCardHeight > params.cardHeight) {
          final iconSize1 = getAdaptiveIconSize(params.cardHeight);
          final iconSize2 = getAdaptiveIconSize(largerCardHeight);
          
          final titleSize1 = getAdaptiveTitleFontSize(params.cardHeight);
          final titleSize2 = getAdaptiveTitleFontSize(largerCardHeight);
          
          final descSize1 = getAdaptiveDescFontSize(params.cardHeight);
          final descSize2 = getAdaptiveDescFontSize(largerCardHeight);
          
          // Larger card height should result in >= element sizes
          expect(iconSize2, greaterThanOrEqualTo(iconSize1),
              reason: 'Icon size should increase with card height: '
                  '$iconSize1 -> $iconSize2 for heights '
                  '${params.cardHeight} -> $largerCardHeight');
          expect(titleSize2, greaterThanOrEqualTo(titleSize1),
              reason: 'Title size should increase with card height: '
                  '$titleSize1 -> $titleSize2 for heights '
                  '${params.cardHeight} -> $largerCardHeight');
          expect(descSize2, greaterThanOrEqualTo(descSize1),
              reason: 'Description size should increase with card height: '
                  '$descSize1 -> $descSize2 for heights '
                  '${params.cardHeight} -> $largerCardHeight');
        }
      },
    );

    Glados(generateElementScalingParams).test(
      'all element sizes should use consistent scale factor',
      (params) {
        final scaleFactor = getCardScaleFactor(params.cardHeight);
        
        // Calculate expected unconstrained values
        final expectedIcon = 48 * scaleFactor;
        final expectedTitle = 16 * scaleFactor;
        final expectedDesc = 12 * scaleFactor;
        
        // Get actual values
        final actualIcon = getAdaptiveIconSize(params.cardHeight);
        final actualTitle = getAdaptiveTitleFontSize(params.cardHeight);
        final actualDesc = getAdaptiveDescFontSize(params.cardHeight);
        
        // Verify clamping is applied correctly
        expect(actualIcon, equals(expectedIcon.clamp(36.0, 52.0)),
            reason: 'Icon size $actualIcon should equal clamped expected '
                '${expectedIcon.clamp(36.0, 52.0)}');
        expect(actualTitle, equals(expectedTitle.clamp(14.0, 17.0)),
            reason: 'Title size $actualTitle should equal clamped expected '
                '${expectedTitle.clamp(14.0, 17.0)}');
        expect(actualDesc, equals(expectedDesc.clamp(11.0, 13.0)),
            reason: 'Description size $actualDesc should equal clamped expected '
                '${expectedDesc.clamp(11.0, 13.0)}');
      },
    );

    Glados(generateElementScalingParams).test(
      'icon to title size ratio should be approximately 3:1',
      (params) {
        final iconSize = getAdaptiveIconSize(params.cardHeight);
        final titleSize = getAdaptiveTitleFontSize(params.cardHeight);
        
        // Base ratio is 48:16 = 3:1
        // Due to different clamping ranges, actual ratio may vary
        // Icon: 36-52, Title: 14-17
        // Min ratio: 36/17 ≈ 2.12, Max ratio: 52/14 ≈ 3.71
        final ratio = iconSize / titleSize;
        
        expect(ratio, greaterThanOrEqualTo(2.0),
            reason: 'Icon/title ratio $ratio should be >= 2.0');
        expect(ratio, lessThanOrEqualTo(4.0),
            reason: 'Icon/title ratio $ratio should be <= 4.0');
      },
    );

    Glados(generateElementScalingParams).test(
      'title to description size ratio should be approximately 4:3',
      (params) {
        final titleSize = getAdaptiveTitleFontSize(params.cardHeight);
        final descSize = getAdaptiveDescFontSize(params.cardHeight);
        
        // Base ratio is 16:12 = 4:3 ≈ 1.33
        // Due to different clamping ranges, actual ratio may vary
        // Title: 14-17, Desc: 11-13
        // Min ratio: 14/13 ≈ 1.08, Max ratio: 17/11 ≈ 1.55
        final ratio = titleSize / descSize;
        
        expect(ratio, greaterThanOrEqualTo(1.0),
            reason: 'Title/desc ratio $ratio should be >= 1.0');
        expect(ratio, lessThanOrEqualTo(1.6),
            reason: 'Title/desc ratio $ratio should be <= 1.6');
      },
    );

    test('scale factor at base height (100px) should be 1.0', () {
      final scaleFactor = getCardScaleFactor(100.0);
      expect(scaleFactor, equals(1.0),
          reason: 'Scale factor at base height 100px should be 1.0');
    });

    test('element sizes at base height should match base values', () {
      // At base height 100px, scale factor is 1.0
      // So unconstrained values are: icon=48, title=16, desc=12
      // All within their respective ranges, so no clamping
      final iconSize = getAdaptiveIconSize(100.0);
      final titleSize = getAdaptiveTitleFontSize(100.0);
      final descSize = getAdaptiveDescFontSize(100.0);
      
      expect(iconSize, equals(48.0),
          reason: 'Icon size at base height should be 48.0');
      expect(titleSize, equals(16.0),
          reason: 'Title size at base height should be 16.0');
      expect(descSize, equals(12.0),
          reason: 'Description size at base height should be 12.0');
    });

    test('element sizes at minimum card height (70px)', () {
      final iconSize = getAdaptiveIconSize(70.0);
      final titleSize = getAdaptiveTitleFontSize(70.0);
      final descSize = getAdaptiveDescFontSize(70.0);
      
      // Scale factor = 70/100 = 0.7
      // Icon: 48 * 0.7 = 33.6 -> clamped to 36
      // Title: 16 * 0.7 = 11.2 -> clamped to 14
      // Desc: 12 * 0.7 = 8.4 -> clamped to 11
      expect(iconSize, equals(36.0),
          reason: 'Icon size at min height should be clamped to 36.0');
      expect(titleSize, equals(14.0),
          reason: 'Title size at min height should be clamped to 14.0');
      expect(descSize, equals(11.0),
          reason: 'Description size at min height should be clamped to 11.0');
    });

    test('element sizes at maximum card height (120px)', () {
      final iconSize = getAdaptiveIconSize(120.0);
      final titleSize = getAdaptiveTitleFontSize(120.0);
      final descSize = getAdaptiveDescFontSize(120.0);
      
      // Scale factor = 120/100 = 1.2
      // Icon: 48 * 1.2 = 57.6 -> clamped to 52
      // Title: 16 * 1.2 = 19.2 -> clamped to 17
      // Desc: 12 * 1.2 = 14.4 -> clamped to 13
      expect(iconSize, equals(52.0),
          reason: 'Icon size at max height should be clamped to 52.0');
      expect(titleSize, equals(17.0),
          reason: 'Title size at max height should be clamped to 17.0');
      expect(descSize, equals(13.0),
          reason: 'Description size at max height should be clamped to 13.0');
    });
  });
}
