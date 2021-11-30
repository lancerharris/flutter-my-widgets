import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen>
    with TickerProviderStateMixin {
  final _topContainerHeight = 400.0;
  final _bottomContainerHeight = 250.0;

  // matches duration in multi_modal.dart showMultiModal function
  final Duration _animationDuration = const Duration(seconds: 1);
  final Duration _reverseAnimDuration = const Duration(milliseconds: 500);

  late final AnimationController _bottomModalController = AnimationController(
    duration: _animationDuration,
    reverseDuration: _reverseAnimDuration,
    vsync: this,
  );
  late final AnimationController _topModalController = AnimationController(
    duration: _animationDuration,
    reverseDuration: _reverseAnimDuration,
    vsync: this,
  );
  late final AnimationController _fadeController = AnimationController(
    duration: _animationDuration,
    reverseDuration: _reverseAnimDuration,
    vsync: this,
  );

  late final Animation<Offset> _offsetBottomAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, -1.05),
  ).animate(
    CurvedAnimation(
      parent: _bottomModalController,
      curve: Curves.bounceOut,
      reverseCurve: Curves.easeOutCubic,
    ),
  );

  late final Animation<Offset> _offsetTopAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, 1.05),
  ).animate(
    CurvedAnimation(
      parent: _topModalController,
      curve: Curves.bounceOut,
      reverseCurve: Curves.easeOutCubic,
    ),
  );

  late final Animation<double> _fadeAnimation = Tween<double>(
    begin: 0,
    end: 1.0,
  ).animate(
    CurvedAnimation(
      parent: _fadeController,
      curve: Curves.linear,
    ),
  );

  @override
  void initState() {
    super.initState();
    _bottomModalController.forward();
    _topModalController.forward();
    _fadeController.forward();
  }

  void _reverseAnimations() {
    _bottomModalController.reverse();
    _topModalController.reverse();
    _fadeController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                alignment: Alignment.topCenter,
                color: Colors.black38,
              ),
            ),
            onTap: () {
              _reverseAnimations();
              Navigator.pop(context, 'User tapped the backdrop');
            },
          ),
          Positioned(
            // minus a bit since it wasn't covering whole top area
            top: -_topContainerHeight - 50,
            child: SlideTransition(
              position: _offsetTopAnimation,
              child: Container(
                height: _topContainerHeight,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Hero(
                      tag: 'user_avatar',
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: Colors.amber,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const FlutterLogo(
                          size: 100,
                        ),
                      ),
                    ),
                    const Text(
                      'Allen Abbott',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              // minus a bit since it wasn't covering whole bottom area
              bottom: -_bottomContainerHeight - 50,
              child: SlideTransition(
                position: _offsetBottomAnimation,
                child: Container(
                  height: _bottomContainerHeight,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'Select this user?',
                        style: TextStyle(fontSize: 20),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _reverseAnimations();
                              Navigator.pop(
                                  context, 'User Selected Allen Abbott');
                            },
                            child: const Text('Yes'),
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton(
                            onPressed: () {
                              _reverseAnimations();
                              Navigator.pop(
                                  context, 'User hit the cancel button');
                            },
                            child: const Text('Cancel'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 100)
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _bottomModalController.dispose();
    _topModalController.dispose();
    _fadeController.dispose();
    super.dispose();
  }
}
