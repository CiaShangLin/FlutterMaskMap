import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mask_map/GoogleMap/GoogleMapActivity.dart';
import 'package:flutter_mask_map/main.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';

import 'MainViewModel.dart';
import 'MaskDataService.dart';
import '../Api/StateResponse.dart';
import '../Bean/mask_bean.dart';

class HomeActivity extends StatefulWidget {
  HomeActivity({Key? key}) : super(key: key);

  MainViewModel mainViewModel = MainViewModel(MaskDataService());

  @override
  State<HomeActivity> createState() {
    return _HomeActivityState();
  }
}

class _HomeActivityState extends State<HomeActivity> {
  MainViewModel get mainViewModel => widget.mainViewModel;

  TextStyle _titleStyle =
      TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold);
  TextStyle _countStyle =
      TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    // mainViewModel.getMaskData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => mainViewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("口罩地圖"),
        ),
        body: BlocBuilder<MainViewModel, StateResponse<MaskBean>>(
          builder: (context, stateResponse) {
            switch (stateResponse.status) {
              case Status.LOADING:
                return Center(
                  child: SpinKitPouringHourGlass(color: Colors.blue),
                );
              case Status.ERROR:
                return Center(
                  child: Text("${stateResponse.error}"),
                );
              case Status.SUCCESS:
                return _buildSuccess();
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        GoogleMapActivity(mainViewModel.filterMaskData())));
          },
          child: const Icon(Icons.map),
        ),
      ),
    );
  }

  Widget _buildSuccess() {
    return NestedScrollView(
        headerSliverBuilder: (_, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: false,
              backgroundColor: Colors.white,
              flexibleSpace: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCountryButton(),
                  _buildTownButton(),
                ],
              ),
            ),
          ];
        },
        body: _buildMaskList());
  }

  DropdownButton _buildCountryButton() {
    return DropdownButton(
      value: mainViewModel.selectCounty,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: MainViewModel.country.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: (value) {
        mainViewModel.switchCountry(value);
      },
    );
  }

  DropdownButton _buildTownButton() {
    return DropdownButton(
      value: mainViewModel.selectTown,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: mainViewModel.getTownList().map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: (value) {
        mainViewModel.switchTown(value);
      },
    );
  }

  Widget _buildMaskList() {
    var dataList = mainViewModel.filterMaskData();
    return Container(
      color: Colors.white,
      child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return _buildMaskItem(dataList[index]);
          },
          separatorBuilder: (_, index) {
            return SizedBox(
              height: 8,
            );
          },
          itemCount: dataList.length),
    );
  }

  Widget _buildMaskItem(Features? features) {
    return Container(
      margin: EdgeInsets.all(16),
      height: 100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black26),
          boxShadow: [BoxShadow(blurRadius: 4, offset: Offset(0, 2))]),
      child: Column(
        children: [
          Text(
            '${features?.properties?.name ?? ""}',
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    '大人口罩',
                    style: _titleStyle,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${features?.properties?.maskAdult ?? 0}',
                    style: _countStyle,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    '小孩口罩',
                    style: _titleStyle,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${features?.properties?.maskChild ?? 0}',
                    style: _countStyle,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
