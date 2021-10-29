import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mask_map/mask_bean.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropdownvalue = '基隆市';
  var items = [
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
    '連江縣'
  ];

  var init = false;
  var map = Map<String, Set<String>>();

  @override
  void initState() {
    items.forEach((element) {
      map.putIfAbsent(element, () => Set());
    });

    rootBundle.loadString("assets/mask.json").then((value) {
      var bean = MaskBean.fromJson(jsonDecode(value));
      bean.features?.forEach((element) {
        var country = element.properties?.county ?? "";
        var town = element.properties?.town ?? "";
        map[country]?.add(town);
      });

      setState(() {
        init = true;
      });
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("口罩地圖"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPopupMenuButton(),
                _buildPopupMenuButton2(),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.map),
      ),
    );
  }

  Widget _buildPopupMenuButton() {
    return DropdownButton(
      value: dropdownvalue,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          dropdownvalue = value.toString();
        });
      },
    );
  }

  Widget _buildPopupMenuButton2() {
    if (!init) {
      return SizedBox();
    }

    var list = map[dropdownvalue]?.toList() ?? [];
    print(list);
    
    return DropdownButton(
      value: list[0],
      icon: const Icon(Icons.keyboard_arrow_down),
      items: List.generate(list.length, (index) {
        print(list[index]);
       return DropdownMenuItem(child: Text(list[index]),value: list[index],);
      }),
      onChanged: (value) {
        setState(() {

        });
      },
    );
  }
}
