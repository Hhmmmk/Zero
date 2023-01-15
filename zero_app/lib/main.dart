import 'package:zero_app/providers/end_provider.dart';
import 'package:zero_app/providers/start_provider.dart';
import 'package:zero_app/screens/home_screen.dart';
import 'package:zero_app/screens/review_screen.dart';
import 'package:zero_app/screens/setting_screen.dart';
import 'package:zero_app/screens/splash_screen.dart';
import 'package:zero_app/screens/sync_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';


void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => StartAttendanceProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => EndAttendanceProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //<FOR THE BREAKPOINTS IN EVERY DEVICES>//
      builder: (context, child) => ResponsiveWrapper.builder(
        BouncingScrollWrapper(child: child!),
        maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(560, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Inter, Poppins',
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Colors.white),
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 9, 50, 111),
        ),
      ),
      home: HomePage(),
    );
  }
}

//Real Drawer
class RealDrawer extends StatelessWidget {
  //
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 9, 50, 111),
          ),
          child: Center(
              child: Text(
            'Sample',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w800),
          )),
        ),
        ListTile(
          title: const Text('Home Page',
              style: TextStyle(
                  fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
        ListTile(
          title: const Text(
            'Sync Page',
            style:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SyncPage()),
            );
          },
        ),
        ListTile(
          title: const Text(
            'Setting Page',
            style:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingPage()),
            );
          },
        ),
        ListTile(
          title: const Text(
            'Review Page',
            style:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ReviewPage()),
            );
          },
        ),
      ],
    ));
  }
}
