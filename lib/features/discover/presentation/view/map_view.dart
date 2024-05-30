import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_arena/core/widget/appbar.dart';

class FutsalMapView extends ConsumerStatefulWidget {
  const FutsalMapView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FutsalMapViewState();
}

class _FutsalMapViewState extends ConsumerState<FutsalMapView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Map View',
        context: context,
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(
                  6.927079,
                  79.861244,
                ),
                initialZoom: 16,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
