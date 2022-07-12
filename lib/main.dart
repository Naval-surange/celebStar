// libraries
import 'package:firebase_auth/firebase_auth.dart';
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
      child: const MyApp(),
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (Provider.of<GoogleSigninProvider>(context).user == null) {
          // remove after deployment
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
        } else if (snapshot.hasData) {
          var pages = [
            HomePage(),
            ExplorePage(),
            ProfilePage(),
          ];
          return MaterialApp(
            home: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Scaffold(
                body: pages[context.watch<PageIndexProvider>().index],
                appBar: const AppBarWidget(),
                // drawer: const NavDrawer(),
                bottomNavigationBar: const BottomNavBar(),
              ),
            ),
            theme: ThemeData.dark(),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text("something went wrong"));
        } else {
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
        }
      },
    );
  }
}
