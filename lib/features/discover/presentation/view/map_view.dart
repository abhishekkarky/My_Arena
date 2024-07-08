import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_arena/core/widget/appbar.dart';
import 'package:my_arena/features/discover/domain/entity/futsal_entity.dart';

class FutsalMapView extends ConsumerStatefulWidget {
  const FutsalMapView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FutsalMapViewState();
}

class _FutsalMapViewState extends ConsumerState<FutsalMapView> {
  @override
  Widget build(BuildContext context) {
    final futsal = ModalRoute.of(context)!.settings.arguments as FutsalEntity;
    final double latitude = (futsal.lat != null) ? futsal.lat!.toDouble() : 0.0;
    final double longitude =
        (futsal.long != null) ? futsal.long!.toDouble() : 0.0;

    return Scaffold(
      appBar: MyAppBar(
        title: 'Map View',
        context: context,
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(
                  latitude,
                  longitude,
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
