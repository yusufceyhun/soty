import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:secilstore/features/store/data/models/campaign.dart';
import 'package:secilstore/features/store/data/models/campaign_selection_state.dart';
import 'package:secilstore/features/store/providers/store_providers.dart';

void main() {
  late ProviderContainer container;

  final combinableA = Campaign(
    id: 'c1',
    name: 'Combinable A',
    description: 'Desc A',
    isCombinable: true,
    endDate: DateTime(2026, 12, 31),
  );

  final combinableB = Campaign(
    id: 'c2',
    name: 'Combinable B',
    description: 'Desc B',
    isCombinable: true,
    endDate: DateTime(2026, 12, 31),
  );

  final nonCombinable = Campaign(
    id: 'nc1',
    name: 'Non-Combinable',
    description: 'Desc NC',
    isCombinable: false,
    endDate: DateTime(2026, 12, 31),
  );

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  group('StoreSelectionNotifier — Campaign Selection', () {
    test('selecting first combinable campaign adds directly, no conflict', () {
      final notifier = container.read(storeSelectionNotifierProvider.notifier);
      final conflict = notifier.toggleCampaign(combinableA);

      expect(conflict, isNull);
      expect(
        container.read(storeSelectionNotifierProvider).selectedCampaigns,
        [combinableA],
      );
    });

    test('selecting multiple combinable campaigns adds all, no conflict', () {
      final notifier = container.read(storeSelectionNotifierProvider.notifier);
      notifier.toggleCampaign(combinableA);
      final conflict = notifier.toggleCampaign(combinableB);

      expect(conflict, isNull);
      expect(
        container.read(storeSelectionNotifierProvider).selectedCampaigns.length,
        2,
      );
    });

    test(
        'selecting non-combinable while combinable(s) selected returns nonCombinableOverCombinables',
        () {
      final notifier = container.read(storeSelectionNotifierProvider.notifier);
      notifier.toggleCampaign(combinableA);

      final conflict = notifier.toggleCampaign(nonCombinable);

      expect(conflict, ConflictType.nonCombinableOverCombinables);
      // State should NOT change until confirm
      expect(
        container.read(storeSelectionNotifierProvider).selectedCampaigns,
        [combinableA],
      );
    });

    test(
        'selecting combinable while non-combinable selected returns combinableOverNonCombinable',
        () {
      final notifier = container.read(storeSelectionNotifierProvider.notifier);
      notifier.toggleCampaign(nonCombinable);

      final conflict = notifier.toggleCampaign(combinableA);

      expect(conflict, ConflictType.combinableOverNonCombinable);
      // State should NOT change until confirm
      expect(
        container.read(storeSelectionNotifierProvider).selectedCampaigns,
        [nonCombinable],
      );
    });

    test('confirmConflictResolution clears all and selects pending campaign',
        () {
      final notifier = container.read(storeSelectionNotifierProvider.notifier);
      notifier.toggleCampaign(combinableA);
      notifier.toggleCampaign(nonCombinable); // triggers conflict

      notifier.confirmConflictResolution();

      final state = container.read(storeSelectionNotifierProvider);
      expect(state.selectedCampaigns, [nonCombinable]);
      expect(state.pendingConflictCampaign, isNull);
      expect(state.conflictType, isNull);
    });

    test('cancelConflict leaves state unchanged', () {
      final notifier = container.read(storeSelectionNotifierProvider.notifier);
      notifier.toggleCampaign(combinableA);
      notifier.toggleCampaign(nonCombinable); // triggers conflict

      notifier.cancelConflict();

      final state = container.read(storeSelectionNotifierProvider);
      expect(state.selectedCampaigns, [combinableA]);
      expect(state.pendingConflictCampaign, isNull);
      expect(state.conflictType, isNull);
    });

    test('deselecting an already-selected campaign removes it', () {
      final notifier = container.read(storeSelectionNotifierProvider.notifier);
      notifier.toggleCampaign(combinableA);
      notifier.toggleCampaign(combinableB);

      final conflict = notifier.toggleCampaign(combinableA); // deselect

      expect(conflict, isNull);
      expect(
        container.read(storeSelectionNotifierProvider).selectedCampaigns,
        [combinableB],
      );
    });

    test('selecting same non-combinable again deselects it', () {
      final notifier = container.read(storeSelectionNotifierProvider.notifier);
      notifier.toggleCampaign(nonCombinable);

      final conflict = notifier.toggleCampaign(nonCombinable); // deselect

      expect(conflict, isNull);
      expect(
        container.read(storeSelectionNotifierProvider).selectedCampaigns,
        isEmpty,
      );
    });
  });

  group('StoreSelectionNotifier — Coin Percentage', () {
    test('selectCoinPercentage calculates amount correctly', () {
      final notifier = container.read(storeSelectionNotifierProvider.notifier);

      notifier.selectCoinPercentage(25, 50000);

      final state = container.read(storeSelectionNotifierProvider);
      expect(state.coinPercentage, 25);
      expect(state.coinAmount, 12500);
    });

    test('selectCoinPercentage at 100% returns full balance', () {
      final notifier = container.read(storeSelectionNotifierProvider.notifier);

      notifier.selectCoinPercentage(100, 50000);

      final state = container.read(storeSelectionNotifierProvider);
      expect(state.coinPercentage, 100);
      expect(state.coinAmount, 50000);
    });

    test('setCoinAmount sets exact amount and clears percentage when unmatched',
        () {
      final notifier = container.read(storeSelectionNotifierProvider.notifier);

      notifier.setCoinAmount(73, 100);

      final state = container.read(storeSelectionNotifierProvider);
      expect(state.coinAmount, 73);
      expect(state.coinPercentage, isNull);
    });

    test('setCoinAmount matches percentage when amount equals ratio bucket',
        () {
      final notifier = container.read(storeSelectionNotifierProvider.notifier);

      notifier.setCoinAmount(50, 100);

      final state = container.read(storeSelectionNotifierProvider);
      expect(state.coinAmount, 50);
      expect(state.coinPercentage, 50);
    });

    test('setCoinAmount clamps amount to available balance', () {
      final notifier = container.read(storeSelectionNotifierProvider.notifier);

      notifier.setCoinAmount(999, 100);

      final state = container.read(storeSelectionNotifierProvider);
      expect(state.coinAmount, 100);
      expect(state.coinPercentage, 100);
    });
  });
}
