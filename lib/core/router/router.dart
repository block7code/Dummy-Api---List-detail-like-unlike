import 'package:dummy_api/views/screens/users/user_widget.dart';
import 'package:dummy_api/views/screens/navigator.dart';
import 'package:dummy_api/views/screens/posts/post_widget.dart';
import 'package:dummy_api/views/screens/users/user_detail.dart';
import 'package:dummy_api/views/screens/likes/like_widget.dart';

import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigatorDashoard.routeName:
        return MaterialPageRoute(
            settings: const RouteSettings(name: NavigatorDashoard.routeName),
            builder: (_) => const NavigatorDashoard());
      case UsersWidget.routeName:
        return MaterialPageRoute(
            settings: const RouteSettings(name: UsersWidget.routeName),
            builder: (_) => const UsersWidget());
      case PostWidget.routeName:
        return MaterialPageRoute(
            settings: const RouteSettings(name: PostWidget.routeName),
            builder: (_) => const PostWidget());

      case YourLikeWidget.routeName:
        return MaterialPageRoute(
            settings: const RouteSettings(name: YourLikeWidget.routeName),
            builder: (_) => const YourLikeWidget());

      case UserDetail.routeName:
        Map<String, Object>? param = settings.arguments as Map<String, Object>?;
        return MaterialPageRoute(
            settings: const RouteSettings(name: UserDetail.routeName),
            builder: (_) => UserDetail(param: param));

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
