import 'package:evently/core/provider/app_provider.dart';
import 'package:evently/modules/events/pages/details_event.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MappSceen extends StatelessWidget {
  const MappSceen({super.key});

  @override
  Widget build(BuildContext context) {
    var myTheme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            // buildingsEnabled: true,
            // cameraTargetBounds: CameraTargetBounds(
            //   LatLngBounds(
            //     southwest: LatLng(29.983677849091034, 32.470367365379744),
            //     northeast: LatLng(29.99635265419765, 32.53585618102101),
            //   ),
            // ),
            initialCameraPosition: CameraPosition(
              zoom: 15,
              target: LatLng(29.96683, 32.54981),
            ),
          ),
          SizedBox(width: 16),
          Positioned(
            top: 32,
            left: 16,
            child: CustomIconAppBar(
              color1: myTheme.primaryColor,
              color2: Colors.white,
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: appProvider.isDark ? Colors.white : myTheme.primaryColor,
              ),

              onTap: () => Navigator.pop(context),
              appProvider: appProvider,
            ),
          ),
        ],
      ),
    );
  }
}
