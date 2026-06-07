import 'package:evently/core/provider/app_provider.dart';
import 'package:evently/modules/events/pages/details_event.dart';
import 'package:evently/modules/events/provider/google_map_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MappSceen extends StatelessWidget {
  const MappSceen({super.key});

  @override
  Widget build(BuildContext context) {
    var myTheme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context, listen: false);
    String mode = appProvider.isDark
        ? "assets/map_styles/night_map_style.json"
        : "assets/map_styles/light_map_style.json";
    return ChangeNotifierProvider<GoogleMapProvider>(
      create: (context) {
        final provider = GoogleMapProvider();
        provider.initMapStyle(mode);

        return provider;
      },

      builder: (context, child) {
        var mapProvider = Provider.of<GoogleMapProvider>(context);
        return Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                markers: mapProvider.myMarkers,
                style: mapProvider.mapStyle,
                initialCameraPosition: mapProvider.cameraPosition,
                onMapCreated: (controller) async {
                  mapProvider.controller = controller;
                  mapProvider.streamMyLocation();
                },
              ),
              // SizedBox(width: 16),
              Positioned(
                top: 32,
                left: 16,
                child: CustomIconAppBar(
                  color1: myTheme.primaryColor,
                  color2: Colors.white,
                  icon: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: appProvider.isDark
                        ? Colors.white
                        : myTheme.primaryColor,
                  ),

                  onTap: () => Navigator.pop(context),
                  appProvider: appProvider,
                ),
              ),
              Positioned(
                bottom: 32,
                right: 16,
                left: 16,
                child: ElevatedButton(
                  onPressed: () {
                    mapProvider.controller!.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng(30.00215055954124, 32.48562377042668),
                          zoom: 14,
                        ),
                      ),
                      duration: Duration(seconds: 1),
                    );
                  },
                  child: Center(child: Text('Select Place')),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
