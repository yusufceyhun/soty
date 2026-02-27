import 'package:freezed_annotation/freezed_annotation.dart';

part 'campaign.freezed.dart';
part 'campaign.g.dart';

@freezed
class Campaign with _$Campaign {
  const factory Campaign({
    required String id,
    required String name,
    required String description,
    required bool isCombinable,
    required DateTime endDate,
    String? imageUrl,
    String? brandLogoUrl,
    String? discountLabel,
    @Default(true) bool isActive,
  }) = _Campaign;

  factory Campaign.fromJson(Map<String, dynamic> json) =>
      _$CampaignFromJson(json);
}
