
import 'package:flutter/material.dart';

void main() {
  runApp(const SmartWaterApp());
}

class SmartWaterApp extends StatelessWidget {
  const SmartWaterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Water Tracker',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F9FF),
      ),
      home: const HomePage(),
    );
  }
}

// ------------------------------------------------------------
// HOME PAGE
// ------------------------------------------------------------

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _waterController =
      TextEditingController();

  // Daily hydration goal
  final double dailyGoal = 2000;

  // Total water consumed
  double totalConsumed = 0;

  // Number of entries
  int entryCount = 0;

  // ----------------------------------------------------------
  // ADD WATER
  // ----------------------------------------------------------

  void _addWater() {
    final String input = _waterController.text.trim();

    // Empty input validation
    if (input.isEmpty) {
      _showMessage('Please enter the amount of water.');
      return;
    }

    final double? amount = double.tryParse(input);

    // Invalid number validation
    if (amount == null) {
      _showMessage('Please enter a valid number.');
      return;
    }

    // Zero and negative validation
    if (amount <= 0) {
      _showMessage(
        'Water amount must be greater than 0 mL.',
      );
      return;
    }

    setState(() {
      totalConsumed += amount;
      entryCount++;
    });

    _waterController.clear();

    _showMessage(
      '${amount.toStringAsFixed(0)} mL added successfully!',
    );
  }

  // ----------------------------------------------------------
  // RESET WITH CONFIRMATION
  // ----------------------------------------------------------

  Future<void> _confirmReset() async {
    if (totalConsumed == 0 && entryCount == 0) {
      _showMessage('There is no intake data to reset.');
      return;
    }

    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.orange,
              ),
              SizedBox(width: 10),
              Text('Reset Intake?'),
            ],
          ),
          content: const Text(
            'Are you sure you want to reset today\'s '
            'water intake?\n\nThis action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('CANCEL'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('RESET'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      setState(() {
        totalConsumed = 0;
        entryCount = 0;
      });

      _showMessage('Today\'s water intake has been reset.');
    }
  }

  // ----------------------------------------------------------
  // MESSAGE
  // ----------------------------------------------------------

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ----------------------------------------------------------
  // REMAINING WATER
  // ----------------------------------------------------------

  double get remainingWater {
    final double remaining = dailyGoal - totalConsumed;
    return remaining > 0 ? remaining : 0;
  }

  // ----------------------------------------------------------
  // COMPLETION PERCENTAGE
  // ----------------------------------------------------------

  double get completionPercentage {
    final double percentage =
        (totalConsumed / dailyGoal) * 100;

    return percentage.clamp(0, 100);
  }

  // ----------------------------------------------------------
  // PROGRESS
  // ----------------------------------------------------------

  double get progress {
    return (totalConsumed / dailyGoal).clamp(0, 1);
  }

  @override
  void dispose() {
    _waterController.dispose();
    super.dispose();
  }

  // ----------------------------------------------------------
  // BUILD
  // ----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Smart Water Tracker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Reset',
            onPressed: _confirmReset,
            icon: const Icon(
              Icons.refresh_rounded,
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // ------------------------------------------------
              // WATER ICON
              // ------------------------------------------------

              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.water_drop_rounded,
                  size: 60,
                  color: Colors.blue.shade600,
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                'Stay Hydrated!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF12304A),
                ),
              ),

              const SizedBox(height: 6),

              Text(
                'Track your daily water intake',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // PROGRESS CARD
              // ------------------------------------------------

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade600,
                      Colors.lightBlue.shade400,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(),
                      blurRadius: 15,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'TODAY\'S PROGRESS',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      '${totalConsumed.toStringAsFixed(0)} mL',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      'of ${dailyGoal.toStringAsFixed(0)} mL goal',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 20),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 12,
                        backgroundColor:
                            Colors.white.withValues(),
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      '${completionPercentage.toStringAsFixed(0)}% completed',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ------------------------------------------------
              // STATISTICS
              // ------------------------------------------------

              Row(
                children: [
                  Expanded(
                    child: _statCard(
                      icon: Icons.local_drink_rounded,
                      title: 'Entries',
                      value: '$entryCount',
                      color: Colors.indigo,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _statCard(
                      icon: Icons.water_drop_rounded,
                      title: 'Remaining',
                      value:
                          '${remainingWater.toStringAsFixed(0)} mL',
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // INPUT SECTION
              // ------------------------------------------------

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add Water Intake',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF12304A),
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'Enter the amount of water you just drank.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 18),

                    TextField(
                      controller: _waterController,
                      keyboardType:
                          const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Water amount',
                        hintText: 'Example: 250',
                        suffixText: 'mL',
                        prefixIcon: const Icon(
                          Icons.water_drop_outlined,
                          color: Colors.blue,
                        ),
                        filled: true,
                        fillColor: Colors.blue.shade50,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: (_) {
                        _addWater();
                      },
                    ),

                    const SizedBox(height: 15),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton.icon(
                        onPressed: _addWater,
                        icon: const Icon(
                          Icons.add_rounded,
                        ),
                        label: const Text(
                          'ADD WATER',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ------------------------------------------------
              // DAILY GOAL INFORMATION
              // ------------------------------------------------

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.blue.shade100,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.flag_rounded,
                      color: Colors.blue.shade700,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Your daily hydration goal is '
                        '${dailyGoal.toStringAsFixed(0)} mL.',
                        style: TextStyle(
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // FOOTER
              // ------------------------------------------------

              Text(
                'Small sips. Big difference. 💧',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // STAT CARD
  // ----------------------------------------------------------

  Widget _statCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 30,
          ),

          const SizedBox(height: 8),

          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
