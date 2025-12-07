// Property-based tests for ResponsiveUtils card height calculations
// **Feature: personality-quiz-app, Property 12: 卡片高度填充计算正确性**
// **Validates: Requirements 11.1, 11.2**

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

/// Calculate total height used by cards and spacing
double calculateTotalUsedHeight({
  required double screenHeight,
  required int itemCount,
  required double safeAreaTop,
  required double safeAreaBottom,
}) {
  if (itemCount <= 0) return 0;
  
  final cardHeight = getAdaptiveCardHeightPure(
    screenHeight: screenHeight,
    itemCount: itemCount,
    safeAreaTop: safeAreaTop,
    safeAreaBottom: safeAreaBottom,
  );
  final cardSpacing = getCardSpacingForHeight(screenHeight);
  final listTopPadding = getListTopPaddingForHeight(screenHeight);
  final listBottomPadding = getListBottomPaddingForHeight(screenHeight);
  
  // Total used = cards + spacing between cards + top/bottom padding
  final totalSpacing = cardSpacing * (itemCount - 1) + listTopPadding + listBottomPadding;
  return (cardHeight * itemCount) + totalSpacing;
}

/// Input parameters for property tests
class CardLayoutParams {
  final double screenHeight;
  final int itemCount;
  final double safeAreaTop;
  final double safeAreaBottom;

  CardLayoutParams({
    required this.screenHeight,
    required this.itemCount,
    required this.safeAreaTop,
    required this.safeAreaBottom,
  });

  @override
  String toString() =>
      'CardLayoutParams(screenHeight: $screenHeight, itemCount: $itemCount, '
      'safeAreaTop: $safeAreaTop, safeAreaBottom: $safeAreaBottom)';
}

/// Generator function for CardLayoutParams
Shrinkable<CardLayoutParams> generateCardLayoutParams(Random random, int size) {
  // Screen height: 400-1200 pixels (realistic mobile/tablet range)
  final screenHeight = 400.0 + random.nextInt(801);
  // Item count: 1-10 items (typical for quiz types)
  final itemCount = 1 + random.nextInt(10);
  // Safe area top: 0-50 pixels
  final safeAreaTop = random.nextInt(51).toDouble();
  // Safe area bottom: 0-50 pixels
  final safeAreaBottom = random.nextInt(51).toDouble();
  
  final params = CardLayoutParams(
    screenHeight: screenHeight,
    itemCount: itemCount,
    safeAreaTop: safeAreaTop,
    safeAreaBottom: safeAreaBottom,
  );
  
  return Shrinkable(params, () sync* {
    // Try reducing screen height
    if (params.screenHeight > 400) {
      yield Shrinkable(CardLayoutParams(
        screenHeight: (params.screenHeight - 100).clamp(400.0, 1200.0),
        itemCount: params.itemCount,
        safeAreaTop: params.safeAreaTop,
        safeAreaBottom: params.safeAreaBottom,
      ), () sync* {});
    }
    
    // Try reducing item count
    if (params.itemCount > 1) {
      yield Shrinkable(CardLayoutParams(
        screenHeight: params.screenHeight,
        itemCount: params.itemCount - 1,
        safeAreaTop: params.safeAreaTop,
        safeAreaBottom: params.safeAreaBottom,
      ), () sync* {});
    }
    
    // Try reducing safe areas
    if (params.safeAreaTop > 0) {
      yield Shrinkable(CardLayoutParams(
        screenHeight: params.screenHeight,
        itemCount: params.itemCount,
        safeAreaTop: (params.safeAreaTop - 10).clamp(0.0, 50.0),
        safeAreaBottom: params.safeAreaBottom,
      ), () sync* {});
    }
    
    if (params.safeAreaBottom > 0) {
      yield Shrinkable(CardLayoutParams(
        screenHeight: params.screenHeight,
        itemCount: params.itemCount,
        safeAreaTop: params.safeAreaTop,
        safeAreaBottom: (params.safeAreaBottom - 10).clamp(0.0, 50.0),
      ), () sync* {});
    }
  });
}

void main() {
  group('Property 12: 卡片高度填充计算正确性', () {
    Glados(generateCardLayoutParams).test(
      'card height should be within valid range (70-120px)',
      (params) {
        final cardHeight = getAdaptiveCardHeightPure(
          screenHeight: params.screenHeight,
          itemCount: params.itemCount,
          safeAreaTop: params.safeAreaTop,
          safeAreaBottom: params.safeAreaBottom,
        );
        
        expect(cardHeight, greaterThanOrEqualTo(70.0),
            reason: 'Card height $cardHeight should be >= 70.0');
        expect(cardHeight, lessThanOrEqualTo(120.0),
            reason: 'Card height $cardHeight should be <= 120.0');
      },
    );

    Glados(generateCardLayoutParams).test(
      'total used height should not exceed available space when unconstrained',
      (params) {
        final availableHeight = getAvailableListHeightPure(
          screenHeight: params.screenHeight,
          safeAreaTop: params.safeAreaTop,
          safeAreaBottom: params.safeAreaBottom,
        );
        
        final cardSpacing = getCardSpacingForHeight(params.screenHeight);
        final listTopPadding = getListTopPaddingForHeight(params.screenHeight);
        final listBottomPadding = getListBottomPaddingForHeight(params.screenHeight);
        final totalSpacing = cardSpacing * (params.itemCount - 1) + 
            listTopPadding + listBottomPadding;
        
        // Calculate unconstrained card height
        final unconstrainedCardHeight = 
            (availableHeight - totalSpacing) / params.itemCount;
        
        // Only test when the unconstrained height is within bounds (70-120)
        // When constrained, overflow is expected behavior
        if (unconstrainedCardHeight >= 70.0 && unconstrainedCardHeight <= 120.0) {
          final totalUsedHeight = calculateTotalUsedHeight(
            screenHeight: params.screenHeight,
            itemCount: params.itemCount,
            safeAreaTop: params.safeAreaTop,
            safeAreaBottom: params.safeAreaBottom,
          );
          
          // Total used height should not exceed available space
          // Allow small floating point tolerance
          expect(totalUsedHeight, lessThanOrEqualTo(availableHeight + 0.01),
              reason: 'Total used height $totalUsedHeight should not exceed '
                  'available height $availableHeight');
        }
      },
    );

    Glados(generateCardLayoutParams).test(
      'when unconstrained, cards should fill available space exactly',
      (params) {
        final availableHeight = getAvailableListHeightPure(
          screenHeight: params.screenHeight,
          safeAreaTop: params.safeAreaTop,
          safeAreaBottom: params.safeAreaBottom,
        );
        
        final cardSpacing = getCardSpacingForHeight(params.screenHeight);
        final listTopPadding = getListTopPaddingForHeight(params.screenHeight);
        final listBottomPadding = getListBottomPaddingForHeight(params.screenHeight);
        final totalSpacing = cardSpacing * (params.itemCount - 1) + 
            listTopPadding + listBottomPadding;
        
        // Calculate unconstrained card height
        final unconstrainedCardHeight = 
            (availableHeight - totalSpacing) / params.itemCount;
        
        // If unconstrained height is within bounds (70-120), cards should fill exactly
        if (unconstrainedCardHeight >= 70.0 && unconstrainedCardHeight <= 120.0) {
          final totalUsedHeight = calculateTotalUsedHeight(
            screenHeight: params.screenHeight,
            itemCount: params.itemCount,
            safeAreaTop: params.safeAreaTop,
            safeAreaBottom: params.safeAreaBottom,
          );
          
          // Should fill available space exactly (within floating point tolerance)
          final diff = (totalUsedHeight - availableHeight).abs();
          expect(diff, lessThan(0.01),
              reason: 'When unconstrained, total used height $totalUsedHeight '
                  'should equal available height $availableHeight (diff: $diff)');
        }
      },
    );

    Glados(generateCardLayoutParams).test(
      'available height should be positive for reasonable screen sizes',
      (params) {
        final availableHeight = getAvailableListHeightPure(
          screenHeight: params.screenHeight,
          safeAreaTop: params.safeAreaTop,
          safeAreaBottom: params.safeAreaBottom,
        );
        
        // For screens >= 400px, available height should be positive
        // (accounting for header ~80-120px, bottom nav ~72px, safe areas)
        if (params.screenHeight >= 400) {
          expect(availableHeight, greaterThan(0),
              reason: 'Available height $availableHeight should be positive '
                  'for screen height ${params.screenHeight}');
        }
      },
    );

    Glados(generateCardLayoutParams).test(
      'spacing values should be consistent with height thresholds',
      (params) {
        final cardSpacing = getCardSpacingForHeight(params.screenHeight);
        final topPadding = getListTopPaddingForHeight(params.screenHeight);
        final bottomPadding = getListBottomPaddingForHeight(params.screenHeight);
        
        // All spacing values should be positive
        expect(cardSpacing, greaterThan(0),
            reason: 'Card spacing $cardSpacing should be positive');
        expect(topPadding, greaterThan(0),
            reason: 'Top padding $topPadding should be positive');
        expect(bottomPadding, greaterThan(0),
            reason: 'Bottom padding $bottomPadding should be positive');
        
        // Spacing should be within expected range (4-12)
        expect(cardSpacing, greaterThanOrEqualTo(4),
            reason: 'Card spacing $cardSpacing should be >= 4');
        expect(cardSpacing, lessThanOrEqualTo(12),
            reason: 'Card spacing $cardSpacing should be <= 12');
      },
    );

    test('zero or negative item count returns default height', () {
      final zeroResult = getAdaptiveCardHeightPure(
        screenHeight: 800,
        itemCount: 0,
        safeAreaTop: 0,
        safeAreaBottom: 0,
      );
      expect(zeroResult, equals(100.0),
          reason: 'Zero item count should return default height 100.0');
      
      final negativeResult = getAdaptiveCardHeightPure(
        screenHeight: 800,
        itemCount: -1,
        safeAreaTop: 0,
        safeAreaBottom: 0,
      );
      expect(negativeResult, equals(100.0),
          reason: 'Negative item count should return default height 100.0');
    });
  });
}
