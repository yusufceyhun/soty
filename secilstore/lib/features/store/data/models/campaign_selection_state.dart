import 'package:freezed_annotation/freezed_annotation.dart';

import 'campaign.dart';

part 'campaign_selection_state.freezed.dart';

enum ConflictType {
  nonCombinableOverCombinables,
  combinableOverNonCombinable,
}

@freezed
class CampaignSelectionState with _$CampaignSelectionState {
  const factory CampaignSelectionState({
    @Default([]) List<Campaign> selectedCampaigns,
    @Default(null) int? coinPercentage,
    @Default(0) double coinAmount,
    Campaign? pendingConflictCampaign,
    ConflictType? conflictType,
  }) = _CampaignSelectionState;
}
