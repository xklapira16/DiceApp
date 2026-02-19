import 'package:flutter/material.dart';
import 'dart:math';
import 'package:confetti/confetti.dart';

void main() {
  runApp(const DiceApp());
}

class DiceApp extends StatelessWidget {
  const DiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DiceHomePage(),
    );
  }
}

class DiceHomePage extends StatefulWidget {
  const DiceHomePage({super.key});

  @override
  State<DiceHomePage> createState() => _DiceHomePageState();
}

class _DiceHomePageState extends State<DiceHomePage> {
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;

  final Random random = Random();

  late ConfettiController confettiController;

  @override
  void initState() {
    super.initState();
    confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  void rollDice() {
    setState(() {
      leftDiceNumber = random.nextInt(6) + 1; // 1-6
      rightDiceNumber = random.nextInt(6) + 1; // 1-6
    });

    // Trigger confetti if jackpot (total = 7)
    if (leftDiceNumber + rightDiceNumber == 7) {
      confettiController.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    int total = leftDiceNumber + rightDiceNumber;

    // Determine color based on total
    Color totalColor;
    if (total > 6) {
      totalColor = Colors.blue;
    } else if (total == 6) {
      totalColor = Colors.yellow;
    } else {
      totalColor = Colors.red;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Two Dice App'), centerTitle: true),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Dice row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/dice$leftDiceNumber.png',
                      width: 160,
                    ),
                    const SizedBox(width: 20),
                    Image.asset(
                      'assets/images/dice$rightDiceNumber.png',
                      width: 160,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Total text with dynamic color
                Text(
                  'Total: $total',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: totalColor,
                  ),
                ),
                const SizedBox(height: 10),
                // Jackpot message
                if (total == 7)
                  const Text(
                    '🎉 Congratulations! You won the jackpot! 🎉',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 30),
                // Roll button
                ElevatedButton(
                  onPressed: rollDice,
                  child: const Text('Roll Dice'),
                ),
              ],
            ),
          ),
          // Confetti widget
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
                Colors.yellow,
              ],
              numberOfParticles: 30,
              gravity: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
