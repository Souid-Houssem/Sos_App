import 'package:flutter/material.dart';
import 'package:get/get.dart';

class kioStationCard extends StatelessWidget {
  const kioStationCard({Key? key, this.openMapFunc}) : super(key: key);

    final Function? openMapFunc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: (){
                openMapFunc!("kiosque à proximité");
              },
              child: Container(
                  height: 50,
                  width: 50,
                  child: Center(
                      child: Image.asset(
                    "assets/images/kiosque.PNG",
                    height: 32,
                  ))),
            ),
          ),
          Text("Carburants")
        ],
      ),
    );
  }
}
