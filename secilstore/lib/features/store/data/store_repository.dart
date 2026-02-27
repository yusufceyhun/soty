import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/error/app_exception.dart';
import '../../../core/error/error_handler.dart';
import '../../../core/network/api_endpoints.dart';
import 'models/campaign.dart';

class StoreRepository {
  StoreRepository(this._dio);

  final Dio _dio;

  Future<List<Campaign>> getActiveCampaigns() async {
    try {
      final response = await _dio.get(
        ApiEndpoints.activeCampaigns(AppConstants.brandId),
        queryParameters: {
          'IsAllUsers': true,
          'ChannelType': 2,
          'PageNumber': 1,
          'PageSize': AppConstants.pageSize,
          'SortDirection': 0,
        },
      );

      var data = response.data;
      if (data is String) {
        try {
          data = jsonDecode(data);
        } catch (_) {}
      }

      if (data == null || data is! Map) return [];

      final mapData = data;
      final responseData = mapData['responseData'] ?? mapData['ResponseData'];

      if (responseData is List) {
        return responseData
            .map((e) => _parseCampaign(e as Map<String, dynamic>))
            .toList();
      }

      final items =
          mapData['items'] as List? ?? mapData['Items'] as List? ?? [];
      return items
          .map((e) => _parseCampaign(e as Map<String, dynamic>))
          .toList();
    } on AppException {
      rethrow;
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (e) {
      if (e is AppException) rethrow;
      throw const UnknownException();
    }
  }

  Campaign _parseCampaign(Map<String, dynamic> json) {
    return Campaign(
      id: (json['id'] ?? json['Id'] ?? json['campaignId'] ?? '').toString(),
      name: json['name'] as String? ??
          json['Name'] as String? ??
          json['campaignName'] as String? ??
          'Kampanya',
      description: json['description'] as String? ??
          json['Description'] as String? ??
          '',
      isCombinable: json['isCombinable'] as bool? ??
          json['IsCombinable'] as bool? ??
          true,
      endDate: _parseEndDate(json),
      imageUrl: json['image'] as String? ??
          json['Image'] as String? ??
          json['imageUrl'] as String? ??
          json['ImageUrl'] as String?,
      brandLogoUrl: json['brandLogoUrl'] as String? ??
          json['BrandLogoUrl'] as String? ??
          json['image'] as String? ??
          json['Image'] as String? ??
          json['imageUrl'] as String? ??
          json['ImageUrl'] as String?,
      discountLabel: _parseDiscountLabel(json),
      isActive: json['isActive'] as bool? ?? json['IsActive'] as bool? ?? true,
    );
  }

  DateTime _parseEndDate(Map<String, dynamic> json) {
    final raw = (json['endDate'] ?? json['EndDate'] ?? '').toString();
    final parsed = DateTime.tryParse(raw);

    if (parsed == null || parsed.year <= 1) {
      return DateTime.utc(1, 1, 1);
    }
    return parsed;
  }

  String? _parseDiscountLabel(Map<String, dynamic> json) {
    final campaignType = json['campaignType'];
    final campaignTypeName = campaignType is Map<String, dynamic>
        ? campaignType['name'] as String?
        : null;
    final campaignTypeUpper = json['CampaignType'];
    final campaignTypeUpperName = campaignTypeUpper is Map<String, dynamic>
        ? campaignTypeUpper['Name'] as String?
        : null;

    final direct = json['discountLabel'] as String? ??
        json['DiscountLabel'] as String? ??
        campaignTypeName ??
        campaignTypeUpperName ??
        json['discountRate'] as String?;
    if (direct != null && direct.trim().isNotEmpty) {
      return direct;
    }

    final gainRaw = json['gain'] ?? json['Gain'];
    final gain =
        gainRaw is num ? gainRaw.toDouble() : double.tryParse('$gainRaw');
    if (gain == null || gain <= 0) return null;

    final category =
        (json['gainCategoryName'] ?? json['GainCategoryName'] ?? '')
            .toString()
            .toLowerCase();
    if (category.contains('coin')) {
      return '${gain.toInt()} Coin';
    }
    if (category.contains('oran') || category.contains('rate')) {
      return '%${gain.toInt()} İndirim';
    }

    return '${gain.toInt()} İndirim';
  }
}
