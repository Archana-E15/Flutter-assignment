import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stock_watchlist/DatabaseHelper.dart';
import 'package:stock_watchlist/page/Homepage.dart';
import 'package:stock_watchlist/page/WatchList.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
//  import 'package:my_database_library/my_database_library.dart';

// Now you can use databaseFactoryFfiWeb


void main() async{
  //  databaseFactory = databaseFactoryFfi;
    //  DatabaseHelper stockDB=DatabaseHelper();
  //  final Database database = await openDatabase(stockDB.database as String);
  // sqfliteFfiInit();
//  databaseFactory = databaseFactoryFfi;
sqfliteFfiInit(); 
 runApp(MyApp());
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    // First Tab Content
   HomePage(),
   
   

    // Second Tab Content
    StockListPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
        // title: Text('Bottom Navigation Example'),
      // ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Watchlist',
          ),
        ],
      ),
    );
  }
}












