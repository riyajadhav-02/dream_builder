import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class DreamScreen extends StatefulWidget {
  const DreamScreen({super.key});

  @override
  State<DreamScreen> createState() => _DreamScreenState();
}

class _DreamScreenState extends State<DreamScreen> {

  String selectedDream = "embedded";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dream Builder"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 30),

            const Text(
              "Select Your Dream",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            DropdownButton<String>(
              value: selectedDream,
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                  value: "embedded",
                  child: Text("Embedded Engineer"),
                ),
                DropdownMenuItem(
                  value: "ai",
                  child: Text("AI Engineer"),
                ),
                DropdownMenuItem(
                  value: "shop",
                  child: Text("Shop Owner"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedDream = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardScreen(
                      dream: selectedDream,
                    ),
                  ),
                );
              },
              child: const Text("Generate Roadmap"),
            ),
          ],
        ),
      ),
    );
  }
}