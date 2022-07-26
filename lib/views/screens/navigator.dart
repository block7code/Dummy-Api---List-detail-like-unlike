import 'package:dummy_api/views/screens/posts/post_widget.dart';
import 'package:dummy_api/views/screens/users/user_widget.dart';
import 'package:dummy_api/views/screens/likes/like_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavigatorDashoard extends StatefulWidget {
  static const routeName = '/navigatorDashoard';

  const NavigatorDashoard({Key? key}) : super(key: key);

  @override
  State<NavigatorDashoard> createState() => _NavigatorDashoardState();
}

class _NavigatorDashoardState extends State<NavigatorDashoard> {
  int _selectedIndex = 0;

  @override
  void initState() {
    // _getNotif();
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: showPage(context),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Container(
          height: size.height * 0.11,
          decoration: BoxDecoration(
            color: Colors.transparent,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 15,
                  offset: const Offset(0, 5))
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                icon: _selectedIndex == 0
                    ? const Icon(FontAwesomeIcons.user)
                    : const Icon(FontAwesomeIcons.user),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 1
                    ? const Icon(FontAwesomeIcons.solidNewspaper)
                    : const Icon(
                        FontAwesomeIcons.solidNewspaper,
                      ),
                label: 'Posts',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 2
                    ? const Icon(
                        Icons.favorite,
                        size: 32,
                      )
                    : const Icon(
                        Icons.favorite,
                        size: 32,
                      ),
                label: 'Your Like',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.purple,
            onTap: _onItemTapped,
            selectedFontSize: 16,
            showUnselectedLabels: true,
          ),
        ),
      ),
    );
  }

  showPage(context) {
    switch (_selectedIndex) {
      case 0:
        return const UsersWidget();
      case 1:
        return const PostWidget();
      case 2:
        return const YourLikeWidget();
    }
    return widget;
  }
}
