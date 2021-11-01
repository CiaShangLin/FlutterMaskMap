import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mask_map/MainViewModel.dart';
import 'package:flutter_mask_map/MaskDataService.dart';
import 'package:flutter_mask_map/StateResponse.dart';
import 'package:flutter_mask_map/mask_bean.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mask Map',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  MainViewModel mainViewModel = MainViewModel(MaskDataService());

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MainViewModel get mainViewModel => widget.mainViewModel;

  @override
  void initState() {
    super.initState();
    mainViewModel.getMaskData();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => mainViewModel),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text("口罩地圖"),
          ),
          body: BlocBuilder<MainViewModel, StateResponse<MaskBean>>(
            builder: (context, stateResponse) {
              print("BlocBuilder:${stateResponse.status}");
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
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildCountryButton(),
                            _buildTownButton(),
                          ],
                        )
                      ],
                    ),
                  );
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.map),
          ),
        ));
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
}
