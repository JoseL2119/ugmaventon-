import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MainPageExample extends StatelessWidget {
  const MainPageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Main()),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> with OSMMixinObserver {
  late MapController controller;

  @override
  void initState() {
    super.initState();
    controller = MapController(
      initPosition: GeoPoint(
        latitude: 8.315955,
        longitude: -62.720164,
      ),
    );
    controller.addObserver(this);
  }

  @override
  Future<void> mapIsReady(bool isReady) async {
    // Callback cuando el mapa está listo
  }

  @override
  void dispose() {
    controller.removeObserver(this);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            width: 300, // Ancho del cuadro del mapa
            height: 300, // Alto del cuadro del mapa
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2), // Borde opcional
              borderRadius: BorderRadius.circular(12), // Esquinas redondeadas opcionales
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Map(
                controller: controller,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: FloatingActionButton(
            onPressed: () async {
              await controller.zoomIn();
            },
            child: const Icon(Icons.add),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: () async {
              await controller.zoomOut();
            },
            child: const Icon(Icons.remove),
          ),
        ),
      ],
    );
  }
}

class Map extends StatelessWidget {
  const Map({
    super.key,
    required this.controller,
  });
  final MapController controller;

  @override
  Widget build(BuildContext context) {
    return OSMFlutter(
      controller: controller,
      osmOption: OSMOption(
        enableRotationByGesture: true,
        zoomOption: const ZoomOption(
          initZoom: 16,
          minZoomLevel: 3,
          maxZoomLevel: 19,
        ),
        showDefaultInfoWindow: false,
      ),
    );
  }
}