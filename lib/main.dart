import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/routes/routes.dart';
import 'features/home/home_page.dart';


main() {
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.copyWith(
          bodyMedium:GoogleFonts.roboto(fontSize: 14)
        ),
      ),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case Routes.homeScreen:
            return MaterialPageRoute(builder: (context) => const HomePage());
          // case Routes.profileScreen:
          //   return MaterialPageRoute(
          //     builder: (context) => const ProfilePage(),
          //   );
          default:
            return MaterialPageRoute(builder: (context) => const HomePage());
        }
      },
    );
  }
}
