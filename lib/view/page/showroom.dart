import 'package:flutter/material.dart';
import 'package:rent/view/page/booklistpage.dart';
import 'package:rent/view/page/homepage.dart';
import 'package:rent/view/page/profilepage.dart';
import './constants.dart';
import './data.dart';
import 'package:rent/utils/context_utils.dart';

class Showroom extends StatefulWidget {
  @override
  _ShowroomState createState() => _ShowroomState();
}

class _ShowroomState extends State<Showroom> with TickerProviderStateMixin {
  List<Car> cars = getCarList();
  List<Dealer> dealers = getDealerList();
  TabController _tabController;
  int currentTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        currentTab = _tabController.index;
      });
    });
    Future.wait([context.mainProvider.loadHistoryBook()]);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
        title: Text(
          "Rental",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        actions: [
          // Padding(
          //   padding: EdgeInsets.only(right: 16),
          //   child: Icon(
          //     Icons.menu,
          //     color: Colors.black,
          //     size: 28,
          //   ),
          // )
        ],
      ),
      body: TabBarView(controller: _tabController, children: [
        HomePage(),
        BookListPage(),
        ProfilePage(),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        selectedItemColor: kPrimaryColor,
        onTap: (value) => _tabController.animateTo(value),
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: "booking"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile"),
        ],
      ),
    );
  }
}
