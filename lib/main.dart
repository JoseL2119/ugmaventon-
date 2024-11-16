import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'src/home/main_example.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      initialRoute: "/home",
      routes: {
        "/home": (context) => const MainPageExample(),
        "/simple": (context) => Scaffold(
              body: OSMViewer(
                controller: SimpleMapController(
                  initPosition: GeoPoint(
                    latitude: 47.4358055,
                    longitude: 8.4737324,
                  ),
                  markerHome: const MarkerIcon(
                    icon: Icon(Icons.home),
                  ),
                ),
                zoomOption: const ZoomOption(
                  initZoom: 16,
                  minZoomLevel: 11,
                ),
              ),
            ),
      },
    );
  }
}
