import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:celebstar/providers/PageIndex.dart';
import 'package:celebstar/providers/GoogleSignin.dart';
import 'package:celebstar/providers/User.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  const AppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 10,
      title: Text(
        "CelebStar",
        style: GoogleFonts.kaushanScript(
            fontSize: 25, fontWeight: FontWeight.bold),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(40),
        ),
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/navDrawer.jpeg'))),
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.input),
            title: const Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.verified_user),
            title: const Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.border_color),
            title: const Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () => {
              Provider.of<GoogleSigninProvider>(context, listen: false)
                  .logout()
                  .then((_) {
                Navigator.of(context).pop();
                Provider.of<PageIndexProvider>(context, listen: false)
                    .setIndex(0);
              })
            },
          ),
        ],
      ),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var _currentindex = 0;
  final user = UserClass(FirebaseAuth.instance.currentUser?.uid);
  @override
  Widget build(BuildContext context) {
    user.loadFromFirebase();
    return BottomNavigationBar(
      currentIndex: _currentindex,
      onTap: (index) => setState(
        () {
          context.read<PageIndexProvider>().setIndex(index);
          _currentindex = index;
        },
      ),
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: StreamBuilder<UserClass>(
              stream: user.getUserStream(),
              builder: (context, snapshot) {
                return Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        user.photoUrl ??
                            'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50',
                      ),
                    ),
                  ),
                );
              }),
          label: 'Profile',
        ),
      ],
    );
  }
}
