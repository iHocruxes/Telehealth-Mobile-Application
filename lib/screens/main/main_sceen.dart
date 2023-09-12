// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/components/side_menu.dart';
import 'package:healthline/screens/main/health_info/healthinfo_screen.dart';
import 'package:healthline/screens/main/home/home_screen.dart';
import 'package:healthline/screens/main/message/message_screen.dart';
import 'package:healthline/screens/main/schedule/schedule_screen.dart';
import 'package:healthline/utils/keyboard.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  var _currentIndex = 0;

  bool isSideMenuClosed = true;

  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scalAnimation;
  late Animation<double> hideAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });

    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));

    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.fastOutSlowIn),
    );
    hideAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.fastOutSlowIn),
    );
    super.initState();
  }

  @override
  void deactivate() {
    _animationController.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _pageDetail = [
      {
        "page": HomeScreen(
          press: () {
            if (isSideMenuClosed) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
            KeyboardUtil.hideKeyboard(context);

            setState(() {
              isSideMenuClosed = !isSideMenuClosed;
            });
          },
        ),
        "title": "Home",
        "icon": FontAwesomeIcons.heartPulse
      },
      {
        "page": const ScheduleScreen(),
        "title": "Schedule",
        "icon": FontAwesomeIcons.calendar
      },
      {
        "page": const MessageScreen(),
        "title": "Message",
        "icon": FontAwesomeIcons.comment
      },
      {
        "page": const HealthInfoScreen(),
        "title": "Health info",
        "icon": FontAwesomeIcons.bookMedical
      },
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: secondary,
      bottomNavigationBar: Transform.translate(
        offset: Offset(0, dimensWidth() * 12 * animation.value),
        child: Container(
          margin: EdgeInsets.all(dimensWidth() * 2.5),
          height: dimensWidth() * 7.8,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
            borderRadius: BorderRadius.circular(dimensImage() * 6),
          ),
          child: ListView.builder(
            itemCount: _pageDetail.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 1),
            itemBuilder: (context, index) => InkWell(
              onTap: () => setState(() {
                _currentIndex = index;
                HapticFeedback.lightImpact();
              }),
              splashColor: transparent,
              highlightColor: transparent,
              child: Stack(children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == _currentIndex ? dimensWidth() * 16.5 : 9,
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    decoration: BoxDecoration(
                        color: index == _currentIndex
                            ? primary.withOpacity(.2)
                            : transparent,
                        borderRadius: BorderRadius.circular(dimensWidth() * 6)),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: index == _currentIndex ? dimensWidth() * 6 : 0,
                    width: index == _currentIndex ? dimensWidth() * 16.5 : 0,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == _currentIndex
                      ? dimensWidth() * 15.5
                      : dimensWidth() * 9,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width: index == _currentIndex
                                ? dimensWidth() * 6.5
                                : 0,
                          ),
                          AnimatedOpacity(
                            opacity: index == _currentIndex ? 1 : 0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                              index == _currentIndex
                                  ? _pageDetail[index]['title']
                                  : '',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: primary),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width: index == _currentIndex
                                ? dimensWidth() * 1.5
                                : 20,
                          ),
                          FaIcon(
                            _pageDetail[index]['icon'],
                            size: dimensWidth() * 3.8,
                            color: index == _currentIndex
                                ? primary
                                : Colors.black26,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: isSideMenuClosed ? -dimensWidth() * 35 : 0,
            width: dimensWidth() * 45,
            height: MediaQuery.of(context).size.height,
            child: const SideMenu(),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(animation.value - 30 * animation.value * pi / 180),
            child: Transform.translate(
                offset: Offset(animation.value * dimensWidth() * 35, 0),
                child: Transform.scale(
                  scale: scalAnimation.value,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(isSideMenuClosed ? 0 : dimensWidth() * 3),
                    ),
                    child: InkWell(
                      onTap: () {
                        if (!isSideMenuClosed) {
                          _animationController.reverse();
                        }
                        KeyboardUtil.hideKeyboard(context);
                        setState(() {
                          isSideMenuClosed = true;
                        });
                      },
                      child: AbsorbPointer(
                        child: _pageDetail[_currentIndex]['page'],
                        absorbing: !isSideMenuClosed,
                      ),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}