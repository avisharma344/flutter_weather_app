import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main () => runApp(
  MaterialApp(
    title: "Weather App",
    home: Home(),
  )
);

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _HomeState();
  }
}


class _HomeState extends State<Home>{

  var temp;
  var description;
  var currently;
  var humidity;
  var WindSpeed;

  Future getWeather () async {
    http.Response response = await http.get("api.openweathermap.org/data/2.5/weather?q=Mumbai&units=imperial&appid=eb87489820c77d659f9e42d30cbb0404");
    var results = jsonDecode(response.body);
    setState((){
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['wind']['speed'];
    });
  }

  @override
  void initState (){
    super.initState();
    this.getWeather();
  }

  @override
    Widget build (buildContext){
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height /3,
            width:MediaQuery.of(context).size.width,
            color: Colors.lightGreenAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Currently in Mumbai",
                    style:TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),

                  Text(
                    temp != null? temp.toString() + "\n00B0" : "Loading",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      currently != null? currently.toString() : "Loading",
                      style:TextStyle(
                          color: Colors.black87,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child:ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Temperature"),
                    trailing: Text( temp != null? temp.toString() + "\n00B0" : ""),
                  ),
                  ListTile(
                  leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                  title: Text("Weather"),
                  trailing: Text(description != null? description.toString(): ""),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text(humidity != null ? humidity.toString(): ""),
                    trailing: Text("12"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Wind Speed"),
                    trailing: Text(WindSpeed != null ? WindSpeed.toString(): ""),
                  )
                ],
              ),
            ),
          )
        ],
       ),
    );
  }
}