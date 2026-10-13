import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Animations",
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
  
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animation Effects"),
        backgroundColor: Colors.blue,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Fade
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: controller,
                  child: const Icon(
                    Icons.favorite,
                    size: 70,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 15),
                const Text(
                  "Fade",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Slide
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1, 0),
                    end: Offset.zero,
                  ).animate(controller),
                  child: const Icon(
                    Icons.star,
                    size: 70,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 15),
                const Text(
                  "Slide",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Scale
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: controller,
                  child: const Icon(
                    Icons.circle,
                    size: 70,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 15),
                const Text(
                  "Scale",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Rotate
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RotationTransition(
                  turns: controller,
                  child: const Icon(
                    Icons.settings,
                    size: 70,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 15),
                const Text(
                  "Rotate",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                controller.forward(from: 0);
              },
              child: const Text("Start Animation"),
            ),
          ],
        ),
      ),
    );
  }
}
