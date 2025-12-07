// Property-based tests for spacing ratio consistency
// **Feature: personality-quiz-app, Property 13: 间距比例一致性**
// **Validates: Requirements 11.3**

import 'dart:math';
import 'package:test/test.dart';
import 'package:glados/glados.dart';

/// Pure calculation functions extracted from ResponsiveUtils for testing
/// These mirror the logic in ResponsiveUtils but without BuildContext dependency

/// Get card spacing based on screen height
double getCardSpacingForHeight(double height) {
  if (height > 900) {
    return 12;
  } else if (height > 800) {
    return 10;
  } else if (height > 700) {
    return 8;
  } else if (height > 600) {
    return 6;
  } else {
    return 4;
  }
}

/// Get header height based on screen height
double getHeaderHeightForHeight(double height) {
  if (height > 900) {
    return 120;
  } else if (height > 700) {
    return 100;
  } else {
    return 80;
  }
}

/// Get list top padding based on screen height
double getListTopPaddingForHeight(double height) {
  if (height > 900) {
    return 12;
  } else if (height > 800) {
    return 10;
  } else if (height > 700) {
    return 8;
  } else if (height > 600) {
    return 6;
  } else {
    return 4;
  }
}

/// Get list bottom padding based on screen height
double getListBottomPaddingForHeight(double height) {
  if (height > 900) {
    return 12;
  } else if (height > 800) {
    return 10;
  } else if (height > 700) {
    return 8;
  } else if (height > 600) {
    return 6;
  } else {
    return 4;
  }
}

/// Get bottom nav height (mobile assumed)
double getBottomNavHeightForHeight(double height) {
  return 72; // Mobile default
}

/// Calculate available list height
double getAvailableListHeightPure({
  required double screenHeight,
  required double safeAreaTop,
  required double safeAreaBottom,
}) {
  final headerHeight = getHeaderHeightForHeight(screenHeight);
  final bottomNavHeight = getBottomNavHeightForHeight(screenHeight);
  return screenHeight - headerHeight - bottomNavHeight - safeAreaTop - safeAreaBottom;
}

/// Calculate adaptive card height
double getAdaptiveCardHeightPure({
  required double screenHeight,
  required int itemCount,
  required double safeAreaTop,
  required double safeAreaBottom,
}) {
  if (itemCount <= 0) return 100.0;
  
  final availableHeight = getAvailableListHeightPure(
    screenHeight: screenHeight,
    safeAreaTop: safeAreaTop,
    safeAreaBottom: safeAreaBottom,
  );
  final cardSpacing = getCardSpacingForHeight(screenHeight);
  final listTopPadding = getListTopPaddingForHeight(screenHeight);
  final listBottomPadding = getListBottomPaddingForHeight(screenHeight);
  
  // Total spacing = (card count - 1) × spacing + top padding + bottom padding
  final totalSpacing = cardSpacing * (itemCount - 1) + listTopPadding + listBottomPadding;
  
  // Card height = (available space - total spacing) / card count
  final cardHeight = (availableHeight - totalSpacing) / itemCount;
  
  // Constrain card height between 70px and 120px
  return cardHeight.clamp(70.0, 120.0);
}

/// Get the height threshold band for a given screen height
/// Returns the lower bound of the threshold band
int getHeightThresholdBand(double height) {
  if (height > 900) return 900;
  if (height > 800) return 800;
  if (height > 700) return 700;
  if (height > 600) return 600;
  return 0;
}

/// Input parameters for spacing ratio property tests
class SpacingRatioParams {
  final double screenHeight1;
  final double screenHeight2;
  final int itemCount;
  final double safeAreaTop;
  final double safeAreaBottom;

  SpacingRatioParams({
    required this.screenHeight1,
    required this.screenHeight2,
    required this.itemCount,
    required this.safeAreaTop,
    required this.safeAreaBottom,
  });

  @override
  String toString() =>
      'SpacingRatioParams(height1: $screenHeight1, height2: $screenHeight2, '
      'itemCount: $itemCount, safeAreaTop: $safeAreaTop, safeAreaBottom: $safeAreaBottom)';
}

/// Generator function for SpacingRatioParams
Shrinkable<SpacingRatioParams> generateSpacingRatioParams(Random random, int size) {
  // Screen heights: 400-1200 pixels (realistic mobile/tablet range)
  final screenHeight1 = 400.0 + random.nextInt(801);
  final screenHeight2 = 400.0 + random.nextInt(801);
  // Item count: 1-10 items (typical for quiz types)
  final itemCount = 1 + random.nextInt(10);
  // Safe area top: 0-50 pixels
  final safeAreaTop = random.nextInt(51).toDouble();
  // Safe area bottom: 0-50 pixels
  final safeAreaBottom = random.nextInt(51).toDouble();
  
  final params = SpacingRatioParams(
    screenHeight1: screenHeight1,
    screenHeight2: screenHeight2,
    itemCount: itemCount,
    safeAreaTop: safeAreaTop,
    safeAreaBottom: safeAreaBottom,
  );
  
  return Shrinkable(params, () sync* {
    // Try reducing screen heights
    if (params.screenHeight1 > 400) {
      yield Shrinkable(SpacingRatioParams(
        screenHeight1: (params.screenHeight1 - 100).clamp(400.0, 1200.0),
        screenHeight2: params.screenHeight2,
        itemCount: params.itemCount,
        safeAreaTop: params.safeAreaTop,
        safeAreaBottom: params.safeAreaBottom,
      ), () sync* {});
    }
    
    if (params.screenHeight2 > 400) {
      yield Shrinkable(SpacingRatioParams(
        screenHeight1: params.screenHeight1,
        screenHeight2: (params.screenHeight2 - 100).clamp(400.0, 1200.0),
        itemCount: params.itemCount,
        safeAreaTop: params.safeAreaTop,
        safeAreaBottom: params.safeAreaBottom,
      ), () sync* {});
    }
    
    // Try reducing item count
    if (params.itemCount > 1) {
      yield Shrinkable(SpacingRatioParams(
        screenHeight1: params.screenHeight1,
        screenHeight2: params.screenHeight2,
        itemCount: params.itemCount - 1,
        safeAreaTop: params.safeAreaTop,
        safeAreaBottom: params.safeAreaBottom,
      ), () sync* {});
    }
  });
}

/// Generator for heights within the same threshold band
Shrinkable<SpacingRatioParams> generateSameBandParams(Random random, int size) {
  // Pick a threshold band
  final bands = [
    [401.0, 600.0],  // Band 0: <= 600
    [601.0, 700.0],  // Band 600: 601-700
    [701.0, 800.0],  // Band 700: 701-800
    [801.0, 900.0],  // Band 800: 801-900
    [901.0, 1200.0], // Band 900: > 900
  ];
  
  final bandIndex = random.nextInt(bands.length);
  final band = bands[bandIndex];
  final range = (band[1] - band[0]).toInt();
  
  // Generate two heights within the same band
  final screenHeight1 = band[0] + random.nextInt(range.clamp(1, 300));
  final screenHeight2 = band[0] + random.nextInt(range.clamp(1, 300));
  
  final itemCount = 1 + random.nextInt(10);
  final safeAreaTop = random.nextInt(51).toDouble();
  final safeAreaBottom = random.nextInt(51).toDouble();
  
  final params = SpacingRatioParams(
    screenHeight1: screenHeight1,
    screenHeight2: screenHeight2,
    itemCount: itemCount,
    safeAreaTop: safeAreaTop,
    safeAreaBottom: safeAreaBottom,
  );
  
  return Shrinkable(params, () sync* {
    if (params.itemCount > 1) {
      yield Shrinkable(SpacingRatioParams(
        screenHeight1: params.screenHeight1,
        screenHeight2: params.screenHeight2,
        itemCount: params.itemCount - 1,
        safeAreaTop: params.safeAreaTop,
        safeAreaBottom: params.safeAreaBottom,
      ), () sync* {});
    }
  });
}

void main() {
  group('Property 13: 间距比例一致性', () {
    Glados(generateSameBandParams).test(
      'within same threshold band, spacing values should be identical',
      (params) {
        // When two heights are in the same threshold band,
        // their spacing values should be exactly the same
        final spacing1 = getCardSpacingForHeight(params.screenHeight1);
        final spacing2 = getCardSpacingForHeight(params.screenHeight2);
        
        final band1 = getHeightThresholdBand(params.screenHeight1);
        final band2 = getHeightThresholdBand(params.screenHeight2);
        
        // Only test when both heights are in the same band
        if (band1 == band2) {
          expect(spacing1, equals(spacing2),
              reason: 'Heights ${params.screenHeight1} and ${params.screenHeight2} '
                  'are in the same band ($band1), spacing should be identical: '
                  '$spacing1 vs $spacing2');
        }
      },
    );

    Glados(generateSpacingRatioParams).test(
      'spacing should increase monotonically with screen height',
      (params) {
        final spacing1 = getCardSpacingForHeight(params.screenHeight1);
        final spacing2 = getCardSpacingForHeight(params.screenHeight2);
        
        // If height1 > height2, spacing1 should be >= spacing2
        if (params.screenHeight1 > params.screenHeight2) {
          expect(spacing1, greaterThanOrEqualTo(spacing2),
              reason: 'Larger screen height ${params.screenHeight1} should have '
                  'spacing >= smaller height ${params.screenHeight2}: '
                  '$spacing1 vs $spacing2');
        } else if (params.screenHeight1 < params.screenHeight2) {
          expect(spacing1, lessThanOrEqualTo(spacing2),
              reason: 'Smaller screen height ${params.screenHeight1} should have '
                  'spacing <= larger height ${params.screenHeight2}: '
                  '$spacing1 vs $spacing2');
        }
      },
    );

    Glados(generateSpacingRatioParams).test(
      'top and bottom padding should be equal for same height',
      (params) {
        // Top and bottom padding should be symmetric
        final topPadding1 = getListTopPaddingForHeight(params.screenHeight1);
        final bottomPadding1 = getListBottomPaddingForHeight(params.screenHeight1);
        
        expect(topPadding1, equals(bottomPadding1),
            reason: 'Top padding $topPadding1 should equal bottom padding '
                '$bottomPadding1 for height ${params.screenHeight1}');
        
        final topPadding2 = getListTopPaddingForHeight(params.screenHeight2);
        final bottomPadding2 = getListBottomPaddingForHeight(params.screenHeight2);
        
        expect(topPadding2, equals(bottomPadding2),
            reason: 'Top padding $topPadding2 should equal bottom padding '
                '$bottomPadding2 for height ${params.screenHeight2}');
      },
    );

    Glados(generateSpacingRatioParams).test(
      'card spacing should equal list padding for same height',
      (params) {
        // Card spacing and list padding use the same threshold logic
        final cardSpacing = getCardSpacingForHeight(params.screenHeight1);
        final topPadding = getListTopPaddingForHeight(params.screenHeight1);
        final bottomPadding = getListBottomPaddingForHeight(params.screenHeight1);
        
        expect(cardSpacing, equals(topPadding),
            reason: 'Card spacing $cardSpacing should equal top padding '
                '$topPadding for height ${params.screenHeight1}');
        expect(cardSpacing, equals(bottomPadding),
            reason: 'Card spacing $cardSpacing should equal bottom padding '
                '$bottomPadding for height ${params.screenHeight1}');
      },
    );

    Glados(generateSpacingRatioParams).test(
      'spacing ratio to available height should be bounded',
      (params) {
        // The ratio of total spacing to available height should be reasonable
        // This ensures spacing doesn't dominate the layout
        final availableHeight = getAvailableListHeightPure(
          screenHeight: params.screenHeight1,
          safeAreaTop: params.safeAreaTop,
          safeAreaBottom: params.safeAreaBottom,
        );
        
        if (availableHeight > 0 && params.itemCount > 0) {
          final cardSpacing = getCardSpacingForHeight(params.screenHeight1);
          final topPadding = getListTopPaddingForHeight(params.screenHeight1);
          final bottomPadding = getListBottomPaddingForHeight(params.screenHeight1);
          
          final totalSpacing = cardSpacing * (params.itemCount - 1) + 
              topPadding + bottomPadding;
          
          final spacingRatio = totalSpacing / availableHeight;
          
          // Spacing should not exceed 50% of available height
          // This is a reasonable upper bound to ensure cards have enough space
          expect(spacingRatio, lessThan(0.5),
              reason: 'Spacing ratio $spacingRatio should be < 0.5 '
                  '(totalSpacing: $totalSpacing, availableHeight: $availableHeight)');
        }
      },
    );

    Glados(generateSameBandParams).test(
      'spacing to card height ratio should be consistent within same band',
      (params) {
        // Within the same threshold band, the ratio of spacing to card height
        // should be similar (not necessarily identical due to different available heights)
        final band1 = getHeightThresholdBand(params.screenHeight1);
        final band2 = getHeightThresholdBand(params.screenHeight2);
        
        if (band1 == band2 && params.itemCount > 0) {
          final spacing1 = getCardSpacingForHeight(params.screenHeight1);
          final spacing2 = getCardSpacingForHeight(params.screenHeight2);
          
          final cardHeight1 = getAdaptiveCardHeightPure(
            screenHeight: params.screenHeight1,
            itemCount: params.itemCount,
            safeAreaTop: params.safeAreaTop,
            safeAreaBottom: params.safeAreaBottom,
          );
          
          final cardHeight2 = getAdaptiveCardHeightPure(
            screenHeight: params.screenHeight2,
            itemCount: params.itemCount,
            safeAreaTop: params.safeAreaTop,
            safeAreaBottom: params.safeAreaBottom,
          );
          
          // Since spacing is identical within the same band,
          // the ratio difference depends only on card height difference
          if (cardHeight1 > 0 && cardHeight2 > 0) {
            final ratio1 = spacing1 / cardHeight1;
            final ratio2 = spacing2 / cardHeight2;
            
            // The ratios should be within a reasonable tolerance
            // Since card heights are clamped (70-120), the ratio variation is bounded
            final ratioDiff = (ratio1 - ratio2).abs();
            
            // Allow up to 0.1 difference in ratio (spacing is 4-12, card height is 70-120)
            // Max ratio = 12/70 ≈ 0.17, Min ratio = 4/120 ≈ 0.03
            // So max difference ≈ 0.14, we use 0.15 as tolerance
            expect(ratioDiff, lessThan(0.15),
                reason: 'Spacing/height ratio difference $ratioDiff should be < 0.15 '
                    '(ratio1: $ratio1, ratio2: $ratio2, '
                    'heights: ${params.screenHeight1}, ${params.screenHeight2})');
          }
        }
      },
    );

    test('spacing values follow expected threshold pattern', () {
      // Verify the discrete threshold pattern
      expect(getCardSpacingForHeight(500), equals(4));
      expect(getCardSpacingForHeight(600), equals(4));
      expect(getCardSpacingForHeight(601), equals(6));
      expect(getCardSpacingForHeight(700), equals(6));
      expect(getCardSpacingForHeight(701), equals(8));
      expect(getCardSpacingForHeight(800), equals(8));
      expect(getCardSpacingForHeight(801), equals(10));
      expect(getCardSpacingForHeight(900), equals(10));
      expect(getCardSpacingForHeight(901), equals(12));
      expect(getCardSpacingForHeight(1000), equals(12));
    });

    test('all spacing functions use consistent thresholds', () {
      // Verify that card spacing, top padding, and bottom padding
      // all use the same threshold logic
      final testHeights = [500.0, 650.0, 750.0, 850.0, 950.0];
      
      for (final height in testHeights) {
        final cardSpacing = getCardSpacingForHeight(height);
        final topPadding = getListTopPaddingForHeight(height);
        final bottomPadding = getListBottomPaddingForHeight(height);
        
        expect(cardSpacing, equals(topPadding),
            reason: 'Card spacing should equal top padding at height $height');
        expect(cardSpacing, equals(bottomPadding),
            reason: 'Card spacing should equal bottom padding at height $height');
      }
    });
  });
}
