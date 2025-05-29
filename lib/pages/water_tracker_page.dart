import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WaterTrackerPage extends StatefulWidget {
  const WaterTrackerPage({super.key});

  @override
  State<WaterTrackerPage> createState() => _WaterTrackerPageState();
}

class _WaterTrackerPageState extends State<WaterTrackerPage> {
  final waterValue = ['100ml', '200ml', '400ml', '500ml', '800ml'];
  String? selectedValue;
  int currentWater = 0;
  int goal = 2000;

  void _addWater(int amount) {
    setState(() {
      currentWater = (currentWater + amount).clamp(0, goal);
    });
  }

  void _resetWater() {
    setState(() {
      currentWater = 0;
      if (waterValue.isNotEmpty) {
        selectedValue = waterValue.first;
      }
    });
  }

  void _showGoalInput() {
    TextEditingController goalController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter New Goal'),
          content: TextField(
            controller: goalController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Enter new goal'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  goal = int.parse(goalController.text);
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        child: Text(
          item,
          style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.blue.shade800,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (waterValue.isNotEmpty) {
      selectedValue = waterValue.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Welcome',
          style: GoogleFonts.rubik(
            textStyle: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _resetWater(),
            icon: Icon(Icons.restart_alt, color: Colors.white),
          ),
          IconButton(
            onPressed: () => _showGoalInput(),
            icon: Icon(Icons.edit, color: Colors.white),
          ),
        ],
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: CircularProgressIndicator(
                    value: currentWater / goal,
                    backgroundColor: Colors.white30,
                    color: Colors.white,
                    strokeWidth: 10,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '${((currentWater / goal) * 100).toStringAsFixed(0)}%',
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '/day',
                      style: GoogleFonts.rubik(
                        fontSize: 16,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              decoration: BoxDecoration(
                color: Colors.blue.shade700,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        '$currentWater ml',
                        style: GoogleFonts.rubik(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'NOW',
                        style: GoogleFonts.rubik(
                          fontSize: 18,
                          color: Colors.yellowAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 60,
                    child: VerticalDivider(
                      color: Colors.white.withValues(alpha: 0.5),
                      thickness: 1.5,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        '$goal ml',
                        style: GoogleFonts.rubik(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'GOAL',
                        style: GoogleFonts.rubik(
                          fontSize: 18,
                          color: Colors.yellowAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedValue,

                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 30,
                  ),
                  dropdownColor: Colors.white,
                  selectedItemBuilder: (BuildContext context) {
                    return waterValue.map((String item) {
                      return Row(
                        children: [
                          const Icon(
                            Icons.local_drink_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            item,
                            style: GoogleFonts.rubik(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    }).toList();
                  },
                  items: waterValue.map(buildMenuItem).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (selectedValue != null) {
            final amount = int.parse(selectedValue!.replaceAll('ml', ''));
            _addWater(amount);
          }
        },
        backgroundColor: Colors.lightBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        icon: const Icon(Icons.add, color: Colors.white, size: 30),
        label: Text(
          "Add",
          style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
