import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mask_map/Home/MainViewModel.dart';
import 'package:flutter_mask_map/Home/MaskDataService.dart';
import 'package:flutter_mask_map/Api/StateResponse.dart';
import 'package:flutter_mask_map/Bean/mask_bean.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Home/HomeAcitvity.dart';

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
      home: HomeActivity(key: Key("HomeActivity"),),
    );
  }
}
