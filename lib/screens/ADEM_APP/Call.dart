import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// Import url_launcher package

class HelplineNumbers extends StatefulWidget {
  const HelplineNumbers({Key? key}) : super(key: key);

  @override
  State<HelplineNumbers> createState() => _HelplineNumbersState();
}

class _HelplineNumbersState extends State<HelplineNumbers> {
  // Method to launch the phone dialer
  void launchPhoneDialer(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunch(phoneUri.toString())) {
      await launch(phoneUri.toString());
    } else {
      // Handle error: Unable to launch the phone dialer
      print('Error launching phone dialer');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Helpline Numbers"),
      ),
      body: ListView(
        children: [
         
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(
                      Icons.local_police,
                      size: 30,
                    ),
                    Text(
                      "Police",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 150,
                    ),
                    Text(
                      "197",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(
                      Icons.healing,
                      size: 30,
                    ),
                    Text(
                      "Ambulance",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 105,
                    ),
                    Text(
                      "190",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(
                      Icons.fire_truck,
                      size: 30,
                    ),
                    Text(
                      "Fire Brigade",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Text(
                      "198",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(
                      Icons.woman,
                      size: 30,
                    ),
                    Text(
                      "Women Helpline",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    Text(
                      "1899",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
          ),
           Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(
                      Icons.local_taxi,
                      size: 30,
                    ),
                    Text(
                      "Taxi",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      "                       71 783 311",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(
                      Icons.car_crash,
                      size: 30,
                    ),
                    Text(
                      "Towing",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 90,
                    ),
                    Text(
                      "   22 368 844",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
