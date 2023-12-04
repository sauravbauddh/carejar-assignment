import 'package:flutter/material.dart';
import 'package:intern_assignment/screens/Details_View.dart';
import 'package:intern_assignment/utils/routes/routes_name.dart';

import '../../screens/Home_View.dart';


class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return _buildPageRoute( HomeView());
      case RoutesName.detail:
        return _buildPageRoute( DetailsView());
      default:
        return _buildPageRoute(
          const Scaffold(
            body: Center(
              child: Text("No route defined"),
            ),
          ),
        );
    }
  }

  static MaterialPageRoute<dynamic> _buildPageRoute(Widget page) {
    return MaterialPageRoute<dynamic>(builder: (ctx) => page);
  }
}
