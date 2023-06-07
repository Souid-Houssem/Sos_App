import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:oumayma/helpers/shared_prefs.dart';
import 'package:oumayma/widget/show_snack_bar.dart';

class Mapp extends StatefulWidget {
  const Mapp({Key? key}) : super(key: key);

  @override
  State<Mapp> createState() => _MappState();
}

class _MappState extends State<Mapp> {
  LatLng pickedPos = LatLng(0, 0);
  double long = 0;
  double lat = 0;







  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Location'),
      ),
      body: OpenStreetMapSearchAndPick(
          center: LatLong(35.82540835008711, 10.637583690859989),
          buttonColor: Colors.blue,
          buttonText: 'Set Current Location',
          hintText: 'Search Location',
          onPicked: (pickedData)  {
            print(pickedData.latLong.latitude);
            print(pickedData.latLong.longitude);
            print(pickedData.address);

            
          }),
      
    );
  }

  Future<Map<String, dynamic>> station(
      double latitude, double longitude) async {
    String? token = await SharedPreferencesHelper.getString('token');

    var response = await http.get(
      Uri.parse("http://10.0.2.2:8000/api/user/stations"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    String dataa = response.body;
    var jsondataa = json.decode(dataa);

    print(response.statusCode);
    if (response.statusCode == 200) {
      print("success");
      ShowSnackBar.showSnackBar(text: "Nearest Stations");
      print(jsondataa);
      return jsondataa;
    } else {
      throw Exception('Failed to load stations');
    }
  }
}
