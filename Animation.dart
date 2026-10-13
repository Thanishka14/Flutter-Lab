a.import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AnimationPage(),
    );
  }
}

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    // Animation Controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Size Animation
    _sizeAnimation = Tween<double>(
      begin: 100,
      end: 250,
    ).animate(_controller);

    // Color Animation
    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(_controller);
  }

  void startAnimation() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Animation'),
        backgroundColor: Colors.blue,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Animated UI Element
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  width: _sizeAnimation.value,
                  height: _sizeAnimation.value,
                  color: _colorAnimation.value,
                  child: const Center(
                    child: Text(
                      'Animate Me',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 50),

            ElevatedButton(
              onPressed: startAnimation,
              child: const Text('Start Animation'),
            ),
          ],
        ),
      ),
    );
  }
}
