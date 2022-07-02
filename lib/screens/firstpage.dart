import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:jiffy/jiffy.dart';
import 'package:weatherr_app_2_0/screens/detalpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getDatafromApi()async{
    var responseWeather = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&exclude=hourly%2Cdaily&appid=cc93193086a048993d938d8583ede38a&fbclid=IwAR3DD4zFU_h8TTgdM8YXKgs0IJuTjF3znUHQyiF2S4V9XBqICxICCAvifVI"));
    var responseForcast = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&units=metric&appid=cc93193086a048993d938d8583ede38a&fbclid=IwAR33qu_23YmppyIkRADDtfii6J-a0lEj9PoUK7oto5Xepq4vTYI9I580qU4"));

    setState(() {
      weatherapi= Map<String,dynamic>.from(jsonDecode(responseWeather.body));
      forcastapi= Map<String,dynamic>.from(jsonDecode(responseForcast.body));
    });
    print(responseWeather.body);
    print(responseForcast.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    _determinePosition();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff27293F),
      appBar: AppBar(
        backgroundColor: Colors.black54,
        centerTitle: true,
        title: Text("Weather app"),
        leading: IconButton(
          onPressed: (){},
          icon: Icon(Icons.settings_suggest),
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.notification_add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            //margin: EdgeInsets.all(18.0),
            child: Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.0),
                    color: Colors.black26,
                  ),
                  child: Column(
                    children: [
                     Container(
                       margin: EdgeInsets.only(
                         top: 10,
                         left: 10
                       ),
                       child:  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                           Text("${Jiffy("${forcastapi!["list"][0]["dt_txt"]}").format("EE ,d MMM")}",
                             style: TextStyle(
                                 color: Colors.white60,
                                 fontSize: 20
                             ),
                           ),
                           Text("Today",
                             style: TextStyle(
                                 color: Colors.white60,
                                 fontSize: 20
                             ),
                           ),
                         ],
                       ),
                     ),
                      Container(
                        child:  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("${weatherapi!["sys"]["country"]}",
                              style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 18
                              ),
                            ),
                            Text("${Jiffy("${forcastapi!["list"][0]["dt_txt"]}").format("h:mm a")}",
                              style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 18
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child:  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("${forcastapi!["list"][0]["main"]["temp"]}°C",
                              style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 50,
                              ),
                            ),
                           Image.network("https://freepngimg.com/thumb/weather/86940-forecasting-weather-sky-atmosphere-rain-png-download-free.png",
                           height: 100,
                           width: 90,)
                          ],
                        ),
                      ),
                      Text("${weatherapi!["weather"][0]["description"]}",
                        style: TextStyle(
                            color: Colors.white60,
                            fontSize: 20
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),   //1st container
             Container(
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   TextButton(
                     onPressed: (){},
                     child: Text("Today"),
                   ),
                   TextButton(
                     onPressed: (){},
                     child: Text("Next 7 Days >"),
                   ),
                 ],
               )
             ),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.0),
                    color: Colors.black26,
                  ),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: forcastapi!.length,
                      itemBuilder: (context,index){
                    return InkWell(
                      onTap: (){
                        setState(() {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>
                          DetailsPagee()));
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        alignment: Alignment.center,
                        height: 10,
                          width: 120,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xffDC6F50),
                              Color(0xffffab91),
                            ],
                            begin:Alignment.topRight,
                            end: Alignment.bottomCenter
                          ),
                          borderRadius: BorderRadius.circular(18.0),
                          color: Color(0xffDC6F50),
                        ),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network("https://freepngimg.com/thumb/weather/86940-forecasting-weather-sky-atmosphere-rain-png-download-free.png",
                              height: 100,
                              width: 90,),
                            Text("${forcastapi!["list"][index]["main"]["temp_min"]}°",
                              style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 18
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text("${forcastapi!["list"][index]["weather"][0]["description"]}°",
                              style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: (){},
                          child: Text("Tempetature"),
                        ),
                      ],
                    )
                ),
                Container(                                   //second listview
                  height: 210,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.0),
                    color: Colors.black26,
                  ),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: forcastapi!.length,
                      itemBuilder: (context,index){
                        return Container(
                          margin: EdgeInsets.all(10.0),
                          alignment: Alignment.center,
                          height: 10,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xffDC6F50),
                                  Color(0xffffab91),
                                ],
                                begin:Alignment.topRight,
                                end: Alignment.bottomCenter
                            ),
                          ),
                          child: Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${forcastapi!["list"][index]["main"]["temp_min"]}°",
                                style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 18
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Image.network("https://freepngimg.com/thumb/weather/86940-forecasting-weather-sky-atmosphere-rain-png-download-free.png",
                                height: 100,
                                width: 90,),

                              Text("${Jiffy("${forcastapi!["list"][0]["dt_txt"]}").format("h:mm ")}",
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text("wind speed ${forcastapi!["list"][0]["wind"]["speed"]}",
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
     position= await Geolocator.getCurrentPosition();
    setState(() {
      latitude= position.latitude;
      longitude= position.longitude;
    });
    getDatafromApi();
    print("my latitude is $latitude & my longitude is $longitude");
  }
  Map <String,dynamic> ?weatherapi;
  Map<String,dynamic> ?forcastapi;

  late Position position;
  double ?latitude;
  double ?longitude;
}
