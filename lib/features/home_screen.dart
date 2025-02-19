import 'package:chatbot_ai/features/leadboard/leadboard.dart';
import 'package:chatbot_ai/features/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'siginin/signin_screen.dart';
import '../theme/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });

    super.initState();
    Future.delayed(
        const Duration(
          milliseconds: 100,
        ), () {
      User? currentUser = Supabase.instance.client.auth.currentUser;
      if (currentUser == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SigninScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          _tabController.index == 2 ? 'Profile' : 'Chat Bot',
          style: const TextStyle(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
            color: onSecondaryColor,
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              Column(
                children: [],
              ),
              LeadboardScreen(),
              Profile(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13, right: 13, bottom: 18),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                gradient: LinearGradient(
                    colors: [Colors.blue, Colors.purple]), // Border Gradient
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3), blurRadius: 4),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomNavBarItem(
                          isActive: _tabController.index == 0,
                          onTap: () {
                            _tabController.animateTo(0);
                          },
                          iconData: Icons.home_outlined,
                        ),
                        CustomNavBarItem(
                          isActive: _tabController.index == 1,
                          iconData: Icons.leaderboard,
                          onTap: () {
                            _tabController.animateTo(1);
                          },
                        ),
                        CustomNavBarItem(
                          isActive: _tabController.index == 2,
                          iconData: Icons.person_rounded,
                          onTap: () {
                            _tabController.animateTo(2);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomNavBarItem extends StatelessWidget {
  final Function() onTap;
  final IconData iconData;
  final bool isActive;
  const CustomNavBarItem({
    super.key,
    required this.iconData,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconData,
                color: Colors.white,
                size: 30,
              ),
              if (isActive)
                const CircleAvatar(
                  radius: 2,
                  backgroundColor: Colors.white,
                )
            ],
          ),
        ),
      ),
    );
  }
}
