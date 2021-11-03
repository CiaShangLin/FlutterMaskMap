import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mask_map/Bean/mask_bean.dart';

class MarkerInfoWidget extends StatelessWidget {
  Features _features;
  Offset _offset;

  MarkerInfoWidget(this._features, this._offset);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        width: 150,
        height: 100,
        color: Colors.yellow,
      ),
      top: _offset.dy + 15,
      left: _offset.dx - 25,
    );
  }
}
