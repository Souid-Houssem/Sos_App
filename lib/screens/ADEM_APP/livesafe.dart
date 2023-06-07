import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ServiceCard extends StatelessWidget {
  final Function onTapFunc;
  final String imagePath;
  final String serviceName;

  const ServiceCard({
    Key? key,
    required this.onTapFunc,
    required this.imagePath,
    required this.serviceName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: () => onTapFunc(),
              child: Container(
                height: 100,
                width: 100,
                child: Center(
                  child: Image.asset(
                    imagePath,
                    height: 70,
                  ),
                ),
              ),
            ),
          ),
          Text(serviceName, style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}

class LiveSafe extends StatelessWidget {
  const LiveSafe({Key? key}) : super(key: key);

  static Future<void> openMap(String location) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$location';
    try {
      await launch(googleUrl);
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
        msg: "Quelque chose s'est mal passé! Appelez les numéros d'urgence.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Safe'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
         Padding(
  padding: EdgeInsets.all(20.0),
  child: Text(
    'Find Your Nearest Emergency Stations', 
    style: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.center,
  ),
),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 2),
              children: <Widget>[
                ServiceCard(onTapFunc: () => openMap("Station police à proximité"), imagePath: "assets/images/police.png", serviceName: "Police"),
                ServiceCard(onTapFunc: () => openMap("Hôpitaux à proximité"), imagePath: "assets/images/hospital.png", serviceName: "Hospital"),
                ServiceCard(onTapFunc: () => openMap(" bus à proximité"), imagePath: "assets/images/bus-stop.png", serviceName: "Bus Stop"),
                ServiceCard(onTapFunc: () => openMap("kiosque à proximité"), imagePath: "assets/images/kiosque.PNG", serviceName: "Kiosque"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
