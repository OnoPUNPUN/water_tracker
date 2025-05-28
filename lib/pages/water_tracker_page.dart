import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WaterTrackerPage extends StatefulWidget {
  const WaterTrackerPage({super.key});

  @override
  State<WaterTrackerPage> createState() => _WaterTrackerPageState();
}

class _WaterTrackerPageState extends State<WaterTrackerPage> {
  final waterValue = ['100 ml', '200 ml', '400 ml', '500 ml', '800 ml'];
  String? selectedValue;

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        child: Text(
          item,
          style: GoogleFonts.rubik(
            textStyle: TextStyle(color: Colors.blue.shade800, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (waterValue.isNotEmpty) {
      selectedValue = waterValue[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color dropdownBackgroundColor = Color(0xFF32B5FF);

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Text(
          'Welcome',
          style: GoogleFonts.rubik(
            textStyle: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (waterValue.isNotEmpty) {
                  selectedValue = waterValue[0];
                }
              });
            },
            icon: const Icon(Icons.restart_alt, color: Colors.white, size: 28),
          ),
        ],
      ),
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
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
                      value: 0.5,
                      backgroundColor: Colors.white30,
                      color: Colors.white,
                      strokeWidth: 12,
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        '50%',
                        style: GoogleFonts.rubik(
                          textStyle: const TextStyle(fontSize: 45, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '/ DAY',
                        style: GoogleFonts.rubik(
                          fontSize: 16,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Container(
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
                          '900ml',
                          style: GoogleFonts.rubik(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'CURRENT',
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
                          '2000ml',
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
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: dropdownBackgroundColor,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedValue,
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 30),
                    dropdownColor: Colors.white,
                    selectedItemBuilder: (BuildContext context) {
                      return waterValue.map<Widget>((String item) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Icon(Icons.local_drink_rounded, color: Colors.white, size: 24),
                            const SizedBox(width: 12),
                            Text(
                              item,
                              style: GoogleFonts.rubik(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
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
                        // TODO: HAVE TO ADD LOGIC OF ADD WATER
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
