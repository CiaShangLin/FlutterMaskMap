import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mask_map/Bean/mask_bean.dart';
import 'package:flutter_mask_map/GoogleMap/MarkerInfoWidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class GoogleMapActivity extends StatefulWidget {
  GoogleMapActivity(this.features);

  List<Features> features;

  @override
  State<StatefulWidget> createState() => _GoogleMapActivityState();
}

class _GoogleMapActivityState extends State<GoogleMapActivity> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.163032717608935, 120.64115664129679),
    zoom: 16.0,
  );

  var markers = Set<Marker>();
  OverlayEntry? markerInfo;

  @override
  void initState() {
    super.initState();
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }
    setMarkers();
    getLocationPermission();
  }

  void setMarkers() {
    widget.features.forEach((element) {
      var latLng = LatLng(element.geometry?.coordinates?[1] ?? 0.0,
          element.geometry?.coordinates?[0] ?? 0.0);
      var marker = Marker(
        infoWindow: InfoWindow(
            title: element.properties?.name,
            snippet:
                "大人口罩:${element.properties?.maskAdult}\n小孩口罩:${element.properties?.maskChild}"),
        markerId: MarkerId("${element.properties?.id}"),
        position: latLng,
        // consumeTapEvents: true,
        // onTap: () async {
        //   var controller = await _controller.future.then((value) => value);
        //   var info = await controller
        //       .getScreenCoordinate(latLng)
        //       .then((value) => value);
        //   if (markerInfo != null) {
        //     markerInfo?.remove();
        //     markerInfo = null;
        //   } else {
        //     markerInfo = OverlayEntry(builder: (BuildContext context) {
        //       return MarkerInfoWidget(
        //           element, Offset(info.x.toDouble(), info.y.toDouble()));
        //     });
        //     Overlay.of(context)?.insert(markerInfo!);
        //   }
        // },
      );
      markers.add(marker);
    });
  }

  Future<void> getLocationPermission() async {
    var status = await Permission.location.status;
    if (status != PermissionStatus.granted) {
      var isGranted = await Permission.location.request().isGranted;
      if (isGranted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Google Map"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    // controller.animateCamera(CameraUpdate.newCameraPosition(
    //   _kGooglePlex,
    // ));
  }
}
