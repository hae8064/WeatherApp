import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/model/model.dart';
import 'package:weatherapp/screens/home.dart';
import 'package:weatherapp/screens/loading.dart';
import 'package:get/get.dart';
import 'package:weatherapp/screens/todoPlan.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.parseWeatherData, this.parseAirPollution});
  final parseWeatherData; //타입은 dynamic타입인데 생략 가능
  final dynamic parseAirPollution;

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  //대기질 상태를 보여주는 이미지 아이콘 출력용도 변수
  Widget? airIcon;
  Widget? airState;

  //미세먼지, 초미세먼지 수치
  double? dust1;
  double? dust2;

  late String cityName;
  late int temp;
  Widget? icon;
  String? des;
  Model model = Model();

  var date = DateTime.now();

  int _selectedIndex = 0; //BottomNavigation인덱스

  static List<Widget> _widgetOptions = <Widget>[
    WeatherScreen(),
    Home(), // class 호출
    TodoPlan(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateData(widget.parseWeatherData, widget.parseAirPollution);
  }

  void updateData(dynamic weatherData, dynamic airData) {
    double temp2 = weatherData['main']['temp']; //기본적인 기온은 화씨온도로 나타내짐
    int condition = weatherData['weather'][0]['id'];
    int index = airData['list'][0]['main']['aqi'];
    temp = temp2.round(); //반올림
    cityName = weatherData['name'];
    icon = model.getWeatherIcon(condition)!;
    des = weatherData['weather'][0]['description']!;
    airIcon = model.getAirIcon(index);
    airState = model.getAirCondition(index);
    dust1 = airData['list'][0]['components']['pm10'];
    dust2 = airData['list'][0]['components']['pm2_5'];

    print(temp);
    print(cityName);
  }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("h:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0, //앱바 음영 없애주기
        //`title: Text(""),
        leading: IconButton(
          icon: Icon(Icons.near_me),
          onPressed: () {
            // Future<Position> getCurrentLocation() async {
            //   Position position = await Geolocator.getCurrentPosition(
            //       desiredAccuracy: LocationAccuracy.high);
            //   return position;
            // }

            // setState(() {
            //   updateData(widget.parseWeatherData, widget.parseAirPollution);
            // });
          },
          iconSize: 30.0,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.location_searching,
            ),
            iconSize: 30.0,
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'image/background.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              // padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$cityName',
                                style: GoogleFonts.lato(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  TimerBuilder.periodic(
                                    (Duration(minutes: 1)),
                                    builder: (context) {
                                      print('${getSystemTime()}');
                                      return Text(
                                        '${getSystemTime()}',
                                        style: GoogleFonts.lato(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                  ),
                                  Text(
                                    //요일
                                    DateFormat(' - EEEE').format(date),
                                    style: GoogleFonts.lato(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    //날짜
                                    DateFormat('  d MMM, yyy').format(date),
                                    style: GoogleFonts.lato(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$temp\u2103',
                                style: GoogleFonts.lato(
                                  fontSize: 85,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  icon!,
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    '$des',
                                    style: GoogleFonts.lato(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Divider(
                        height: 15.0,
                        thickness: 2.0,
                        color: Colors.white30,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'AQI (대기질지수)',
                                  style: GoogleFonts.lato(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                airIcon!,
                                SizedBox(
                                  height: 10.0,
                                ),
                                airState!,
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '미세먼지',
                                  style: GoogleFonts.lato(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '$dust1',
                                  style: GoogleFonts.lato(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'ug/m3',
                                  style: GoogleFonts.lato(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '초미세먼지',
                                  style: GoogleFonts.lato(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '$dust2',
                                  style: GoogleFonts.lato(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'ug/m3',
                                  style: GoogleFonts.lato(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                    ],
                  ),
                  BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.grey,
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.white.withOpacity(.60),
                    selectedFontSize: 14,
                    unselectedFontSize: 14,
                    currentIndex: _selectedIndex, //현재 선택된 Index
                    onTap: (int index) {
                      setState(() {
                        _selectedIndex = index;

                        // if (_selectedIndex == 0) {
                        //   Get.to(() => WeatherScreen());
                        // } else if (_selectedIndex == 1) {
                        //   Get.to(() => Home());
                        // } else {
                        //   Get.to(() => TodoPlan());
                        // }
                      });
                    },
                    items: const <BottomNavigationBarItem>[
                      //index 0
                      BottomNavigationBarItem(
                        title: Text('Weather'),
                        icon: Icon(Icons.filter_drama),
                      ),
                      //index 1
                      BottomNavigationBarItem(
                        title: Text('Home'),
                        icon: Icon(
                          Icons.home,
                        ),
                      ),
                      //index 2
                      BottomNavigationBarItem(
                        title: Text('Todo'),
                        icon: Icon(
                          Icons.create,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
