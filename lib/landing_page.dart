
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:thrust_landing_page/model.dart';

class LandingPage extends StatefulWidget {

  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  //http://geojson.io/
  //https://geojson-maps.ash.ms/
  //https://help.syncfusion.com/flutter/maps/overview

  late List<Model> _data;
  late MapShapeSource _mapSource;

  late Timer _timer;

  String _hoursStr = '00';
  String _minutesStr = '00';
  String _secondsStr = '00';
  int _start = 75600000;

  @override
  void initState() {
    _init();
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _init() {
    _data = <Model>[
      Model(country: 'Brazil', color: Color.fromRGBO(60, 120, 255, 0.8)),
    ];

    _mapSource = MapShapeSource.asset(
      'assets/json/world.geo.json',
      shapeDataField: 'name',
      dataCount: _data.length,
      primaryValueMapper: (int index) => _data[index].country,
      shapeColorValueMapper: (int index) => _data[index].color,
    );
  }

  _startTimer() async {
    var oneSec = Duration(milliseconds: 1); //microseconds: 1000

    _timer = Timer.periodic(
        oneSec, (Timer timer) {
      if(mounted) {
        setState(() {
          if(timer.tick <= 0) {
            timer.cancel();
          } else {
            _start -= 5;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Material(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Thrust", style: TextStyle(color: Colors.white, fontSize: 25, decoration: TextDecoration.none)),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder(
                    stream: Stream.value(_start),
                    builder: (context, snapshot) {

                      if(snapshot.hasData) {

                        int value = snapshot.data as int;

                        _hoursStr = (((value / 1000) / (60 * 60)) % 60)
                            .floor()
                            .toString()
                            .padLeft(2, '0');

                        _minutesStr = (((value / 1000) / 60) % 60)
                            .floor()
                            .toString()
                            .padLeft(2, '0');

                        _secondsStr = ((value / 1000) % 60).floor().toString().padLeft(2, '0');

                        return Text('${ _hoursStr }:${ _minutesStr }:${ _secondsStr }', style: TextStyle(color: Colors.white, fontSize: 50));
                      }

                      return Text('00:00:00', style: TextStyle(color: Colors.white, fontSize: 50));
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

    /*return Material(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 100, right: 100),
            color: Colors.transparent,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Thrust", style: TextStyle(color: Colors.black, decoration: TextDecoration.none, fontSize: 25, fontWeight: FontWeight.normal, fontFamily: "Roboto"),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("English", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, decoration: TextDecoration.none)),
                        Icon(Icons.arrow_drop_down, color: Colors.grey, size: 25),
                      ],
                    ),
                    SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 40, right: 40),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2.5),
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                        color: Colors.white
                      ),
                      child: Text("GET THRUST", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, decoration: TextDecoration.none)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: Color.fromRGBO(248, 248, 246, 1.0),
            height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("600k Users", style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold, decoration: TextDecoration.none)),
                SfMaps(
                  layers: [
                    MapShapeLayer(
                      source: _mapSource,
                      loadingBuilder: (BuildContext context) {
                        return Container(
                          height: 25,
                          width: 25,
                          child: const CircularProgressIndicator(
                            strokeWidth: 3,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );*/
  }

}
