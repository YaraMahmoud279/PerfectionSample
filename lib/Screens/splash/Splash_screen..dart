import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _particleAnimation;

  List<Particle> particles = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _fadeAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _rotateAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _particleAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _controller.forward();

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        particles = generateParticles();
      });
    });

    Future.delayed(Duration(seconds: 3), () {
      Get.offNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Stack(
        children: [
          ...particles
              .map((particle) => Positioned(
                    left: particle.x,
                    top: particle.y,
                    child: Opacity(
                      opacity: _particleAnimation.value.clamp(0.0, 1.0),
                      child: Container(
                        width: particle.size,
                        height: particle.size,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ))
              .toList(),
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: RotationTransition(
                turns: _rotateAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset(
                      'assets/images/perfection_logo.png',
                      fit: BoxFit.fill,
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

  List<Particle> generateParticles() {
    List<Particle> generatedParticles = [];
    for (int i = 0; i < 10; i++) {
      double angle = Random().nextDouble() * 2 * pi;
      double distance = Random().nextDouble() * 50 + 20;
      generatedParticles.add(Particle(
        x: MediaQuery.of(context).size.width / 2 + cos(angle) * distance,
        y: MediaQuery.of(context).size.height / 2 + sin(angle) * distance,
        size: Random().nextDouble() * 10 + 5,
      ));
    }
    return generatedParticles;
  }
}

class Particle {
  final double x;
  final double y;
  final double size;

  Particle({
    required this.x,
    required this.y,
    required this.size,
  });
}
