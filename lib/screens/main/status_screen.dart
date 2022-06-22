import 'dart:async';
import 'dart:collection';

import 'package:cached_network_marker/cached_network_marker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riderhub/generated/l10n.dart';
import 'package:riderhub/main.dart';
import 'package:riderhub/models/order_model.dart';
import 'package:riderhub/models/region_model.dart';
import 'package:riderhub/services/location_service.dart';
import 'package:riderhub/services/navigator_service.dart';
import 'package:riderhub/services/network_service.dart';
import 'package:riderhub/themes/colors.dart';
import 'package:riderhub/themes/dimens.dart';
import 'package:riderhub/themes/textstyle.dart';
import 'package:riderhub/utils/constants.dart';
import 'package:riderhub/utils/params.dart';
import 'package:riderhub/widgets/main/accept_order_widget.dart';
import 'package:riderhub/widgets/main/accepted_order_widget.dart';
import 'package:riderhub/widgets/main/before_dialog_widget.dart';
import 'package:riderhub/widgets/main/confirm_item_widget.dart';
import 'package:riderhub/widgets/main/delivery_order_widget.dart';

class StatusScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function() actionNotification;
  final bool isEnglish;

  const StatusScreen({
    Key key,
    this.scaffoldKey,
    this.actionNotification,
    this.isEnglish,
  }) : super(key: key);

  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  var isAcceptSheet = false;
  var isAcceptedSheet = false;
  var isConfirmSheet = false;
  var isDirectionSheet = false;

  List<RegionModel> regions = [];

  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(17.037834473969383, 54.14773519468366),
    zoom: 16,
  );
  Position currentLocation;

  Set<Polygon> _polygons = HashSet<Polygon>();
  Set<Marker> _markers = Set<Marker>();

  BitmapDescriptor sourceIcon;

  var zoneName = '';
  var streetName = '';

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  StreamSubscription<Position> positionStream;

  @override
  void initState() {
    super.initState();

    Timer.run(() {
      asyncData();
    });
    _getCurrentPosition();
    _addStatusListener();
  }

  void _addStatusListener() {
    socketService.addStatusListener(
      hotspot: (val) {},
      driverSchedule: (val) {},
    );
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    currentLocation = await _geolocatorPlatform.getCurrentPosition();
    getLocationData();
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  void asyncData() async {
    print('[status] ===> asyncData');
    await LocationService.checkPermission();
    await getRegionData();
    await _setPolygon();

    setState(() {});
  }

  Future<void> getLocationData() async {
    var param = {
      'format': 'jsonv2',
      'lat': Constants.isUITestMode
          ? '17.037834473969383'
          : '${currentLocation.latitude}',
      'lon': Constants.isUITestMode
          ? '54.14773519468366'
          : '${currentLocation.longitude}',
      'zoom': '21',
    };
    var resp = await NetworkService(context).ajax(
      'reverse',
      param,
      isPost: false,
      isFullUrl: true,
      isUseToken: false,
    );
    if (resp['type'] == Constants.response_type_success) {
      setState(() {
        zoneName = resp['name'];
        streetName = resp['address']['road'];
      });
    }
  }

  Future<void> _setMarkers(LatLng point) async {
    print('[Person] current User: ${Params.currentUser.toMap()}');
    if (Params.currentUser.avatar_path == null ||
        Params.currentUser.avatar_path.isEmpty) {
      _markers.add(
        Marker(
          markerId: MarkerId('marker${Params.currentUser.id}'),
          position: point,
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    } else {
      final generator = CachedNetworkMarker(
        url: Params.currentUser.avatar_path,
        dpr: MediaQuery.of(context).devicePixelRatio,
      );

      final bitmap = await generator
          .circleAvatar(CircleAvatarParams(color: Colors.lightBlue));

      _markers.add(
        Marker(
          markerId: MarkerId('marker${Params.currentUser.id}'),
          position: point,
          icon: BitmapDescriptor.fromBytes(bitmap),
        ),
      );
    }
  }

  Future<void> _setPolygon() async {
    var region = RegionModel();
    for (var item in regions) {
      if (item.id == Params.currentUser.regional_zone_id) {
        region = item;
      }

      final String polygonIdVal = 'polygon_id_${item.id}';
      List<LatLng> latLngs = [];
      var latValue = 0.0;
      var lngValue = 0.0;
      for (var position in item.vertices) {
        latValue = latValue + position.lat;
        lngValue = lngValue + position.lng;
        latLngs.add(LatLng(position.lat, position.lng));
      }

      _polygons.add(
        Polygon(
          polygonId: PolygonId(polygonIdVal),
          strokeWidth: 2,
          strokeColor: mainColor,
          fillColor: mainColor.withOpacity(0.15),
          points: latLngs,
        ),
      );
    }

    List<LatLng> latLngs = [];
    var latValue = 0.0;
    var lngValue = 0.0;
    for (var position in region.vertices) {
      latValue = latValue + position.lat;
      lngValue = lngValue + position.lng;
      latLngs.add(LatLng(position.lat, position.lng));
    }

    CameraPosition _updatePlex = CameraPosition(
      target: LatLng(
          latValue / region.vertices.length, lngValue / region.vertices.length),
      zoom: 15,
    );

    await _setMarkers(LatLng(
        latValue / region.vertices.length, lngValue / region.vertices.length));

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_updatePlex));
  }

  Future getRegionData() async {
    var param = {
      'r': 'v1/service',
      'action': 'area_zones',
      'params[regional_zone_id]': '2',
    };

    var resp =
        await NetworkService(context).ajax('api.php', param, isPost: false);
    if (resp['type'] == Constants.response_type_success) {
      var jsonArray = resp['data']['area_zones'];
      regions.clear();
      for (var json in jsonArray) {
        regions.add(RegionModel.fromMap(json));
      }
    } else {
      NavigatorService(context).showSnackbar(
          resp['message'], widget.scaffoldKey,
          type: SnackBarType.ERROR);
    }

    print('regions ===> ${regions.length}');
  }

  Future changeBusyStatus() async {
    Position position = await LocationService.determinePosition();
    var param = {
      'action': 'change_busy_v2',
      'params[is_busy]': '0',
      'params[latitude]': '${position.latitude}',
      'params[longitude]': '${position.longitude}',
    };
    var resp =
        await NetworkService(context).ajax('service', param, isProgress: true);
    if (resp['type'] == Constants.response_type_success) {
    } else {
      NavigatorService(context).showSnackbar(
          resp['message'], widget.scaffoldKey,
          type: SnackBarType.ERROR);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            polygons: _polygons,
            markers: _markers,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: offsetBase, vertical: offsetXMd),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => widget.actionNotification(),
                    child: Container(
                      padding: EdgeInsets.all(offsetSm),
                      width: 36.0,
                      height: 36.0,
                      decoration: BoxDecoration(
                          color: purpleColor,
                          borderRadius: BorderRadius.all(Radius.circular(18.0)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.45),
                                blurRadius: 4.0,
                                offset: Offset(0, 2))
                          ]),
                      child: Image.asset('assets/icons/ic_notification.png'),
                    ),
                  ),
                  SizedBox(
                    width: offsetBase,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: offsetBase, vertical: offsetSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(offsetSm)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.35),
                            blurRadius: 4.0),
                      ],
                    ),
                    child: Text(
                      zoneName.isEmpty
                          ? S.of(context).new_salalah_zone
                          : zoneName,
                      style: boldText.copyWith(
                          fontSize: 14.0, color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: offsetBase,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: offsetBase, vertical: offsetSm),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(offsetSm)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.24),
                          blurRadius: 4.0),
                    ]),
                child: Text(
                  '${S.of(context).timezone_detail_one} $zoneName ${S.of(context).timezone_detail_two} 10:00 am - 17:00 pm',
                  style:
                      boldText.copyWith(fontSize: 13.0, color: greyTextColor),
                ),
              ),
              Spacer(),
              Container(
                width: double.infinity,
                height: 75.0,
                padding: EdgeInsets.symmetric(
                    horizontal: offsetBase, vertical: offsetSm),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(offsetSm)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.24),
                          blurRadius: 4.0),
                    ]),
                child: Text(
                  streetName.isEmpty
                      ? S.of(context).new_salalah_zone
                      : streetName,
                  style:
                      boldText.copyWith(fontSize: 13.0, color: greyTextColor),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return BeforeDialogWidget(
                      onActionStart: () async {
                        await changeBusyStatus();
                      },
                    );
                  });
            },
            child: Container(
              margin: EdgeInsets.only(bottom: offsetBase),
              padding: EdgeInsets.all(offsetBase),
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.all(Radius.circular(offsetBase)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 4.0,
                    offset: Offset(0, 4.0),
                  )
                ],
              ),
              child: Text(
                S.of(context).start_riding,
                style: boldText.copyWith(fontSize: 17.0),
              ),
            ),
          ),
        ),
        if (isAcceptSheet)
          Align(
            alignment: Alignment.bottomCenter,
            child: AcceptOrderWidget(
              title: 'Snacks ’N’ More - Saada',
              count: 6,
              price: '14.500 OMR',
              timeout: () {
                setState(() {
                  isAcceptSheet = false;
                });
              },
              accept: () {
                setState(() {
                  isAcceptSheet = false;
                  isAcceptedSheet = true;
                });
              },
            ),
          ),
        if (isAcceptedSheet)
          Align(
            alignment: Alignment.bottomCenter,
            child: AcceptedOrderWidget(
              order: OrderModel(),
              directions: () {},
              arrival: () {
                setState(() {
                  isAcceptedSheet = false;
                  isConfirmSheet = true;
                });
              },
            ),
          ),
        if (isConfirmSheet)
          ConfirmItemWidget(
            context,
            orderModel: OrderModel(),
            confirm: () {
              setState(() {
                isDirectionSheet = true;
                isConfirmSheet = false;
              });
            },
            goBack: () {
              setState(() {
                isAcceptedSheet = true;
                isConfirmSheet = false;
              });
            },
          ),
        if (isDirectionSheet)
          Align(
            alignment: Alignment.bottomCenter,
            child: DeliveryOrderWidget(
              arrival: () {
                setState(() {
                  isDirectionSheet = false;
                });
              },
              directions: () {},
              call: () {},
              message: () {},
            ),
          ),
      ],
    );
  }
}
