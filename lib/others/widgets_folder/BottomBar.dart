import 'package:ecommerce_app/others/back/app_global/front_end/BottomBarCubit.dart';
import 'package:ecommerce_app/others/back/app_global/front_end/app_bar/AppBarCubit.dart';
import 'package:ecommerce_app/ui/product/product_page.dart';
import 'package:ecommerce_app/others/widgets_folder/AppBar1.dart';
import 'package:ecommerce_app/others/widgets_folder/Drawer1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/core/config/AppSizes.dart';
import 'package:ecommerce_app/core/utils/AppConstants.dart';
import 'package:ecommerce_app/core/config/l10n/app_localizations.dart';

//-------------------------------------------------------------------------- Used Bottom Bar
class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    //-------------------------------------------------------------------------- regular update method + variables
    AppConstants.setDeviceSize(context);
    final tr = AppLocalizations.of(context)!;
    return Builder(
      builder: (context) {
        final cubit = context.read<AppBarCubit>();
        return SafeArea(
          //-------------------------------------------------------------------------- scaffold with appbar and others
          child: Scaffold(
            key: cubit.key,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(AppSizes.appBarHeight()),
              child: AppBar1(isSignPage: false),
            ),
            drawer: const Drawer1(),
            //-------------------------------------------------------------------------- body and pages
            body: BlocBuilder<BottomBarCubit, int>(
              builder: (context, state) {
                final pages = [
                  const ProductPage(),
                  const Placeholder(),
                  const Placeholder(),
                  const Placeholder(),
                ];
                return pages[state];
              },
            ),
            //-------------------------------------------------------------------------- main code
            bottomNavigationBar: BlocBuilder<BottomBarCubit, int>(
              builder: (context, state) {
                return NavigationBar(
                  selectedIndex: state,
                  onDestinationSelected: (index) =>
                      context.read<BottomBarCubit>().ChangeIndex(index),
                  destinations: [
                    //-------------------------------------------------------------------------- destinations
                    NavigationDestination(
                      icon: const Icon(Icons.home_outlined),
                      selectedIcon: const Icon(Icons.home),
                      label: "Home",
                      tooltip: tr.messageAreYouSure,
                    ),
                    const NavigationDestination(
                      icon: Icon(Icons.search_outlined),
                      selectedIcon: Icon(Icons.search),
                      label: "Search",
                      tooltip: "",
                    ),
                    const NavigationDestination(
                      icon: Icon(Icons.favorite_outline),
                      selectedIcon: Icon(Icons.favorite),
                      label: "Favourite",
                      tooltip: "",
                    ),
                    const NavigationDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: "Profile",
                      tooltip: "",
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

//-------------------------------------------------------------------------- note : but be careful check normal and floating button navbar generally specially from theme and statefull and update device

//-------------------------------------------------------------------------- normal navbar

// import 'package:flutter/material.dart';
// import 'package:motorcycles_app/core/utils/AppConstants.dart';
// import 'package:motorcycles_app/front_end/AppGlobal/AppBar1.dart';
// import 'package:motorcycles_app/front_end/HomePage/HomePage.dart';

// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({super.key});

//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   int _currentIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> _pages = [
//       HomePage(),
//       Container(color: const Color.fromARGB(255, 16, 58, 92)),
//       Container(color: const Color.fromARGB(255, 40, 115, 176)),
//       Container(color: Colors.blue),
//     ];
//     return SafeArea(
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(
//             AppConstants.screenSize(context).height * 0.09,
//           ),
//           child: AppBar1(),
//         ),
//         body: IndexedStack(index: _currentIndex, children: _pages),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: Colors.amber,
//           onPressed: () {},
//           child: Icon(Icons.qr_code, color: Colors.purple),
//         ),
//         bottomNavigationBar: BottomAppBar(
//           shape: CircularNotchedRectangle(),
//           notchMargin: 8,
//           child: Theme(
//             data: Theme.of(
//               context,
//             ).copyWith(splashFactory: NoSplash.splashFactory),
//             child: SizedBox(
//               height: 40,
//               child: BottomNavigationBar(
//                 // bottomNavigationBar:
//                 // Theme(
//                 //   data: Theme.of(
//                 //     context,
//                 //   ).copyWith(splashFactory: NoSplash.splashFactory),
//                 //   child: Container(
//                 //     child: BottomNavigationBar(
//                 currentIndex: _currentIndex,
//                 onTap: (index) {
//                   setState(() {
//                     _currentIndex = index;
//                   });
//                 },
//                 items: const [
//                   BottomNavigationBarItem(
//                     icon: Icon(Icons.home),
//                     label: 'Home',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: Icon(Icons.search),
//                     label: 'Search',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: Icon(Icons.favorite),
//                     label: 'Favourites',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: Icon(Icons.person),
//                     label: 'Profile',
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//-------------------------------------------------------------------------- bar with centered floating button
// import 'package:flutter/material.dart';
// import 'package:motorcycles_app/core/utils/AppConstants.dart';
// import 'package:motorcycles_app/front_end/AppGlobal/AppBar1.dart';
// import 'package:motorcycles_app/front_end/HomePage/HomePage.dart';

// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({super.key});

//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   int _currentIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> _pages = [
//       HomePage(),
//       Container(),
//       Container(),
//       Container(),
//     ];
//     // build
//     return SafeArea(
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(
//             AppConstants.screenSize(context).height * 0.09,
//           ),
//           child: AppBar1(),
//         ),
//         // pages
//         body: _pages[_currentIndex],
//         // floating action button
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         floatingActionButton: FloatingActionButton(
//           shape: CircleBorder(),
//           backgroundColor: Colors.white,
//           onPressed: () {},
//           tooltip: "qr-code",
//           child: Icon(Icons.add, color: Colors.black),
//         ),
//         // navbar
//         bottomNavigationBar: BottomAppBar(
//           color: Colors.white,
//           notchMargin: 8,
//           shape: CircularNotchedRectangle(),
//           child: Container(
//             height: kBottomNavigationBarHeight, // Standard height
//             // color: Colors.transparent,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 IconButton(
//                   onPressed: () => setState(() => _currentIndex = 0),
//                   icon: Icon(
//                     Icons.home,
//                     color: _currentIndex == 0 ? Colors.black : Colors.grey,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () => setState(() => _currentIndex = 1),
//                   icon: Icon(
//                     Icons.search,
//                     color: _currentIndex == 1 ? Colors.black : Colors.grey,
//                   ),
//                 ),
//                 SizedBox(width: 40), // Space for FAB
//                 IconButton(
//                   onPressed: () => setState(() => _currentIndex = 2),
//                   icon: Icon(
//                     Icons.favorite,
//                     color: _currentIndex == 2 ? Colors.black : Colors.grey,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () => setState(() => _currentIndex = 3),
//                   icon: Icon(
//                     Icons.person,
//                     color: _currentIndex == 3 ? Colors.black : Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Theme(
//           //   data: Theme.of(
//           //     context,
//           //   ).copyWith(splashFactory: NoSplash.splashFactory),
//           //   child: SizedBox(
//           //     height: 40,
//           //     child: BottomNavigationBar(
//           //       // bottomNavigationBar:
//           //       // Theme(
//           //       //   data: Theme.of(
//           //       //     context,
//           //       //   ).copyWith(splashFactory: NoSplash.splashFactory),
//           //       //   child: Container(
//           //       //     child: BottomNavigationBar(
//           //       currentIndex: _currentIndex,
//           //       onTap: (index) {
//           //         setState(() {
//           //           _currentIndex = index;
//           //         });
//           //       },
//           //       items: const [
//           //         BottomNavigationBarItem(
//           //           icon: Icon(Icons.home),
//           //           label: 'Home',
//           //         ),
//           //         BottomNavigationBarItem(
//           //           icon: Icon(Icons.search),
//           //           label: 'Search',
//           //         ),
//           //         BottomNavigationBarItem(
//           //           icon: Icon(Icons.favorite),
//           //           label: 'Favourites',
//           //         ),
//           //         BottomNavigationBarItem(
//           //           icon: Icon(Icons.person),
//           //           label: 'Profile',
//           //         ),
//           //       ],
//           //     ),
//           //   ),
//           // ),
//         ),
//       ),
//     );
//   }
// }

//-------------------------------------------------------------------------- curved navbar

// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({super.key});
//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   //------------------------------------------------------ main
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   int _currentIndex = 0;
//   final List<Widget> _pages = [
//     const HomePage(),
//     Container(),
//     Container(),
//     Container(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final items = <Widget>[
//       Icon(
//         Icons.home,
//         size: 10, //BottomNavBarSizes.iconSize,
//         color: Colors.yellow,
//       ),
//       Icon(
//         Icons.person,
//         size: 10, //BottomNavBarSizes.iconSize,
//         color: Colors.yellow,
//       ),
//       Icon(
//         Icons.search,
//         size: 10, //BottomNavBarSizes.iconSize,
//         color: Colors.yellow,
//       ),
//       Icon(
//         Icons.favorite,
//         size: 10, //BottomNavBarSizes.iconSize,
//         color: Colors.yellow,
//       ),
//     ];
//     //------------------------------------------------------ Build
//     return SafeArea(
//       child: Scaffold(
//         key: _scaffoldKey,
//         backgroundColor: Colors.grey,
//         drawer: const Drawer1(),
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(
//             100, //AppBarSizes.height
//           ),

//           child:
//               //AppBar1(scaffoldKey: _scaffoldKey),
//               AppBar(),
//         ),
//         // pages
//         body: _pages[_currentIndex],
//         // navbar
//         bottomNavigationBar: CurvedNavigationBar(
//           height: 80, //BottomNavBarSizes.height,
//           backgroundColor: Colors.transparent,
//           items: items,
//           index: _currentIndex,
//           onTap: (index) => setState(() => _currentIndex = index),
//         ),
//       ),
//     );
//   }
// }
