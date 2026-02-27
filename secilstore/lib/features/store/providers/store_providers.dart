import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/core_providers.dart';
import '../data/models/campaign.dart';
import '../data/models/campaign_selection_state.dart';
import '../data/store_repository.dart';

part 'store_providers.g.dart';

@riverpod
StoreRepository storeRepository(Ref ref) {
  return StoreRepository(ref.watch(dioClientProvider));
}

@riverpod
Future<List<Campaign>> activeCampaigns(Ref ref) async {
  return ref.watch(storeRepositoryProvider).getActiveCampaigns();
}

@riverpod
class StoreSelectionNotifier extends _$StoreSelectionNotifier {
  @override
  CampaignSelectionState build() => const CampaignSelectionState();

  void selectCoinPercentage(int pct, double totalBalance) {
    final amount = (totalBalance * pct / 100).floorToDouble();
    state = state.copyWith(
      coinPercentage: pct,
      coinAmount: amount,
    );
  }

  ConflictType? toggleCampaign(Campaign campaign) {
    final selected = state.selectedCampaigns;

    // Deselect if already selected
    if (selected.any((c) => c.id == campaign.id)) {
      state = state.copyWith(
        selectedCampaigns: selected.where((c) => c.id != campaign.id).toList(),
        pendingConflictCampaign: null,
        conflictType: null,
      );
      return null;
    }

    // SCENARIO 1: Selecting NON-COMBINABLE while COMBINABLE(s) are selected
    if (!campaign.isCombinable &&
        selected.isNotEmpty &&
        selected.any((c) => c.isCombinable)) {
      state = state.copyWith(
        pendingConflictCampaign: campaign,
        conflictType: ConflictType.nonCombinableOverCombinables,
      );
      return ConflictType.nonCombinableOverCombinables;
    }

    // SCENARIO 2: Selecting COMBINABLE while a NON-COMBINABLE is selected
    if (campaign.isCombinable &&
        selected.isNotEmpty &&
        selected.any((c) => !c.isCombinable)) {
      state = state.copyWith(
        pendingConflictCampaign: campaign,
        conflictType: ConflictType.combinableOverNonCombinable,
      );
      return ConflictType.combinableOverNonCombinable;
    }

    // SCENARIO 3: Selecting COMBINABLE while COMBINABLE(s) are selected — no conflict
    // Or selecting first campaign — no conflict
    state = state.copyWith(
      selectedCampaigns: [...selected, campaign],
      pendingConflictCampaign: null,
      conflictType: null,
    );
    return null;
  }

  void confirmConflictResolution() {
    final pending = state.pendingConflictCampaign;
    if (pending == null) return;

    state = state.copyWith(
      selectedCampaigns: [pending],
      pendingConflictCampaign: null,
      conflictType: null,
    );
  }

  void cancelConflict() {
    state = state.copyWith(
      pendingConflictCampaign: null,
      conflictType: null,
    );
  }

  void clearAll() {
    state = const CampaignSelectionState();
  }
}
