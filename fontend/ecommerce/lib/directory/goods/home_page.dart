//import 'dart:html';
import 'package:ecommerce/directory/pages/account/account_page.dart';
import 'package:ecommerce/directory/pages/address/add_address_page.dart';
import 'package:ecommerce/directory/pages/cart/cart_history.dart';
import 'package:ecommerce/directory/pages/main_goods_page.dart';
import 'package:ecommerce/directory/pages/sign_in/sign_in.dart';
import 'package:ecommerce/directory/pages/sign_up/authenticate_email.dart';
import 'package:ecommerce/directory/pages/sign_up/sigh_up_page.dart';
import 'package:ecommerce/util/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomePage extends StatefulWidget {
  final String token;
  const HomePage({Key? key, required this.token}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PersistentTabController _controller;

  late String _token;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);

    _token = widget.token;
  }

  List<Widget> _buildScreens() {
    return [
      MainGoodPage(
        token: _token,
      ),
      const AddAddressPage(),
      CartHistory(
        token: _token,
      ),
      const AccountPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("หน้าหลัก"),
        textStyle: GoogleFonts.mali(fontWeight: FontWeight.bold),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.amber,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.archivebox_fill),
        title: "ประวัติ",
        textStyle: GoogleFonts.mali(fontWeight: FontWeight.bold),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.amber,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.cart_fill),
        title: ("รายการ"),
        textStyle: GoogleFonts.mali(fontWeight: FontWeight.bold),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.amber,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: ("ฉัน"),
        textStyle: GoogleFonts.mali(fontWeight: FontWeight.bold),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.amber,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }

  /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.mainColor,
          unselectedItemColor: Colors.amber,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          /*unselectedFontSize: 0.0,
          selectedFontSize: 0.0,*/
          currentIndex: _selectedIndex,
          onTap: onTapNav,
          items: [
            const BottomNavigationBarItem(
                label: "home", icon: Icon(Icons.home_outlined)),
            const BottomNavigationBarItem(
                label: "history", icon: Icon(Icons.archive)),
            const BottomNavigationBarItem(
                label: "cart", icon: Icon(Icons.shopping_cart)),
            const BottomNavigationBarItem(
                label: "me", icon: Icon(Icons.person)),
          ]),
    );
  }*/

}
