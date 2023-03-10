import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // latitude - 위도, longitude - 경도
  static const LatLng companyLatLng = LatLng(37.5233273, 126.921252);
  static const CameraPosition initialPosition = CameraPosition(
    target: companyLatLng,
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: Column(
        children: const [
          _CustomGoogleMap(
            initialPosition: initialPosition,
          ),
          _ChoolCheckButton(),
        ],
      ),
    );
  }

  AppBar renderAppBar() {
    return AppBar(
      title: const Text(
        '오늘도 출근',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class _CustomGoogleMap extends StatelessWidget {
  final CameraPosition initialPosition;

  const _CustomGoogleMap({
    required this.initialPosition,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: GoogleMap(
        // MapType
        // normal - 일반 지도
        // hybrid - 위성 지도
        // satellite - 위성 지도 (표시 없이)
        // terrain - 지형 높낮이 일반 지도
        mapType: MapType.normal,
        initialCameraPosition: initialPosition,
      ),
    );
  }
}

class _ChoolCheckButton extends StatelessWidget {
  const _ChoolCheckButton();

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Text('출근'),
    );
  }
}
