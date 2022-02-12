import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/screens/loading.dart';
import 'package:weatherapp/screens/todoPlan.dart';
import 'package:weatherapp/screens/weather_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Loading(),
    Home(), // class 호출
    TodoPlan(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Flutter'),
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
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

            if (_selectedIndex == 0) {
              // Get.to(() => WeatherScreen());
              print("Weahter");
            } else if (_selectedIndex == 1) {
              // Get.to(() => Home());
              print("Home");
            } else {
              // Get.to(() => TodoPlan());
              print("TodoPlan");
            }
          });
        },
        items: [
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
      ),
    );
  }
}
