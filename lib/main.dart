// libraries
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

//pages
import 'package:celebstar/Login.dart';
import 'package:celebstar/appBar.dart';
import 'package:celebstar/home.dart';
import 'package:celebstar/explore.dart';
import 'package:celebstar/profile.dart';

//providers
import 'package:celebstar/providers/PageIndex.dart';
import 'package:celebstar/providers/GoogleSignin.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PageIndexProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => GoogleSigninProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

class MyApp extends StatelessWidget {
  var pages = [
    HomePage(),
    ExplorePage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    var currentIndex = context.watch<PageIndexProvider>().index;
    var user = context.watch<GoogleSigninProvider>().user;
    if (user == null) {
      return MaterialApp(
        title: 'Celebstar',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const Scaffold(
          body: Login(),
        ),
      );
    } else {
      return MaterialApp(
        home: Scaffold(
          body: pages[currentIndex],
          appBar: const AppBarWidget(),
          drawer: const NavDrawer(),
          bottomNavigationBar: BottomNavBar(),
        ),
        theme: ThemeData.dark(),
      );
    }
  }
}
