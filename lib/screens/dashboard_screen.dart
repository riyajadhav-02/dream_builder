import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  final String dream;

  const DashboardScreen({
    super.key,
    required this.dream,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<String> tasks = [];
  List<bool> completed = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    Map<String, List<String>> roadmaps = {
      "embedded": [
        "Learn C Programming",
        "Learn 8051",
        "Learn Arduino",
        "Learn Embedded C",
        "Build 3 Projects",
      ],
      "ai": [
        "Learn Python",
        "Learn Mathematics",
        "Learn Machine Learning",
        "Learn Deep Learning",
        "Build AI Projects",
      ],
      "shop": [
        "Study Market",
        "Find Products",
        "Find Suppliers",
        "Learn Marketing",
        "Start Business",
      ],
      "robotics": [
        "Learn C++",
        "Learn Arduino",
        "Learn Sensors",
        "Learn Raspberry Pi",
        "Learn ROS",
        "Build Robot Projects",
      ],

      "cloud": [
        "Learn Linux",
        "Learn Networking",
        "Learn AWS",
        "Learn Docker",
        "Learn Kubernetes",
        "Build Cloud Projects",
      ],

      "datascience": [
        "Learn Python",
        "Learn Statistics",
        "Learn Pandas",
        "Learn Machine Learning",
        "Build Projects",
      ],

      "genai": [
        "Learn Python",
        "Learn Machine Learning",
        "Learn Deep Learning",
        "Learn LLMs",
        "Learn Prompt Engineering",
        "Build GenAI Projects",
      ],
    };

    tasks = roadmaps[widget.dream] ?? ["No roadmap found"];

    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    completed = List.generate(
      tasks.length,
      (index) =>
          prefs.getBool("${widget.dream}_$index") ??
          false,
    );

    setState(() {});
  }

  Future<void> saveTask(
      int index, bool value) async {
    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    await prefs.setBool(
      "${widget.dream}_$index",
      value,
    );
  }

  @override
  Widget build(BuildContext context) {
    int done =
        completed.where((item) => item).length;

    double progress =
        tasks.isEmpty ? 0 : done / tasks.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dream Dashboard"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: tasks.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Card(
                    elevation: 5,
                    child: Padding(
                      padding:
                          const EdgeInsets.all(16),
                      child: Column(
                        children: [

                          Text(
                            widget.dream
                                .toUpperCase(),
                            style:
                                const TextStyle(
                              fontSize: 24,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(
                              height: 15),

                          Text(
                            "Progress ${(progress * 100).toInt()}%",
                            style:
                                const TextStyle(
                              fontSize: 18,
                            ),
                          ),

                          const SizedBox(
                              height: 10),

                          LinearProgressIndicator(
                            value: progress,
                            minHeight: 10,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Roadmap",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder:
                          (context, index) {
                        return Card(
                          elevation: 3,
                          child:
                              CheckboxListTile(
                            secondary:
                                const Icon(
                              Icons.school,
                            ),
                            title: Text(
                                tasks[index]),
                            value:
                                completed[index],
                            onChanged:
                                (value) {
                              setState(() {
                                completed[index] =
                                    value ??
                                        false;
                              });

                              saveTask(
                                index,
                                value ?? false,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}