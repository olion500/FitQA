import 'package:firebase_core/firebase_core.dart';
import 'package:fitqa/screen/screen_login.dart';
import 'package:fitqa/screen/screen_request.dart';
import 'package:fitqa/theme/color.dart';
import 'package:fitqa/widget/fitqa_appbar.dart';
import 'package:flutter/material.dart';

import 'screen/screen_home.dart';
import 'screen/screen_notification.dart';
import 'screen/screen_setting.dart';
import 'screen/screen_trainer_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDurbYv7HNqW4fKJqceFbzP3BAEUk3M9po",
          authDomain: "fitqa-6b0d2.firebaseapp.com",
          projectId: "fitqa-6b0d2",
          storageBucket: "fitqa-6b0d2.appspot.com",
          messagingSenderId: "980187310835",
          appId: "1:980187310835:web:c70f006f297a6f39942586",
          measurementId: "G-47M6G3M7MB"));
  // runApp(const MyApp());
  runApp(ScreenLogin());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitQA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'FitQA'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  final List<Widget> _screens = [
    const ScreenHome(),
    const ScreenNotification(),
    const ScreenTrainerList(),
    const ScreenSetting()
  ];

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedNavigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: FColors.appBackground,
      appBar: FAppbar(widget.title),
      body: widget._screens.elementAt(_selectedNavigationIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(label: 'home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'notification', icon: Icon(Icons.notifications)),
          BottomNavigationBarItem(label: 'trainer', icon: Icon(Icons.groups)),
          BottomNavigationBarItem(label: 'setting', icon: Icon(Icons.settings))
        ],
        backgroundColor: FColors.appBarBackground,
        currentIndex: _selectedNavigationIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: _onNavigationTapped,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenRequest()));
        },
      ),
    ));
  }

  void _onNavigationTapped(int index) {
    setState(() {
      _selectedNavigationIndex = index;
    });
  }
}
