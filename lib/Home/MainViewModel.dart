import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mask_map/Home/MaskDataService.dart';
import 'package:flutter_mask_map/Api/StateResponse.dart';
import 'package:flutter_mask_map/Bean/mask_bean.dart';

class MainViewModel extends Cubit<StateResponse<MaskBean>> {
  static List<String> country = [
    '基隆市',
    '臺北市',
    '新北市',
    '桃園市',
    '新竹市',
    '新竹縣',
    '苗栗縣',
    '臺中市',
    '彰化縣',
    '南投縣',
    '雲林縣',
    '嘉義市',
    '嘉義縣',
    '臺南市',
    '高雄市',
    '屏東縣',
    '宜蘭縣',
    '花蓮縣',
    '臺東縣',
    '澎湖縣',
    '金門縣',
    '連江縣',
  ];

  MainViewModel(this._maskDataService) : super(StateResponse.Loading()) {
    getMaskData();
  }

  //注入DataService
  IMaskDataService _maskDataService;

  StateResponse<MaskBean> _response = StateResponse.Loading();
  String _selectCounty = MainViewModel.country[0];
  String _selectTown = "";
  Map<String, List<String>> _countryTown = Map();

  StateResponse<MaskBean> get response => _response;

  String get selectCounty => _selectCounty;

  String get selectTown => _selectTown;

  //讀檔json
  void getMaskData() {
    if (_response.data != null) {
      return;
    }
    _maskDataService.getMaskData().then((value) {
      var bean = MaskBean.fromJson(jsonDecode(value.toString()));
      _response = StateResponse.Success(bean);
      _initCountryMap();
      _initTown(bean.features);

      //測試用
      _selectCounty = "臺中市";
      _selectTown = "西屯區";

      emit(_response);
    }).onError((error, stackTrace) {
      _response = StateResponse.Error(error.toString());
      emit(_response);
    });
  }

  //初始化縣市
  void _initCountryMap() {
    MainViewModel.country.forEach((element) {
      _countryTown.putIfAbsent(element, () => []);
    });
  }

  void _initTown(List<Features>? features) {
    features?.forEach((element) {
      var country = element.properties?.county;
      var town = element.properties?.town;
      if (country != null &&
          town != null &&
          _countryTown[country]?.contains(town) == false) {
        _countryTown[country]?.add(town);
      }
    });
    _selectTown = _countryTown[_selectCounty]?[0] ?? "";
  }

  List<String> getTownList() {
    return _countryTown[_selectCounty] ?? [];
  }

  List<Features> filterMaskData() {
    List<Features> list = [];
    response.data?.features
        ?.where((element) =>
            element.properties?.county == _selectCounty &&
            element.properties?.town == _selectTown)
        .forEach((element) {
      list.add(element);
    });
    return list;
  }

  void switchCountry(String country) {
    _selectCounty = country;
    _selectTown = _countryTown[_selectCounty]![0];
    emit(StateResponse.Success(_response.data));
  }

  void switchTown(String town) {
    _selectTown = town;
    emit(StateResponse.Success(_response.data));
  }
}
