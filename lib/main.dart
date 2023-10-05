import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
void main () async{
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'Medicine Schedule Form',
      //     style: TextStyle(
      //       color: Color.fromARGB(255, 0, 0, 0),
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      backgroundColor: const Color(0xffDAFEFA),
      //   elevation: 0,
      // ),
      body: _getPage(_selectedIndex), // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xffbbf2ec),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.black),
            label: 'Find',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_information, color: Colors.black),
            label: 'Pills',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_applications_outlined,
              color: Colors.black,
            ),
            label: 'App',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.track_changes,
              color: Colors.black,
            ),
            label: 'Track',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return Page1();
      case 1:
        return MedicineScheduleForm();
      case 2:
        return Dashboard();
      case 3:
        return Page4(); // Display MedicineScheduleForm for "Track" button
      case 4:
        return Page5();
      default:
        return Page1(); // Default to Page1 if the index is out of range
    }
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'FIND',
        style: TextStyle(fontSize: 50),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('PILLS', style: TextStyle(fontSize: 50)),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('HEALATHYMEME', style: TextStyle(fontSize: 50)),
    );
  }
}

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('TRACK', style: TextStyle(fontSize: 50)),
    );
  }
}

class Page5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('PROFILE', style: TextStyle(fontSize: 50)),
    );
  }
}

class MedicineScheduleForm extends StatefulWidget {
  const MedicineScheduleForm({Key? key}) : super(key: key);

  @override
  _MedicineScheduleFormState createState() => _MedicineScheduleFormState();
}

class _MedicineScheduleFormState extends State<MedicineScheduleForm> {
  // Define variables to store user input
  String medicineName = '';
  String duration = '';
  String amount = '';
  TimeOfDay? alarmTime; // New variable to store the alarm time

  // Dropdown values and selected values
  List<String> dosageOptions = ['5mg', '10mg', '20mg', 'Other'];
  List<String> scheduleOptions = ['Once a day', 'Twice a day', 'Custom'];

  String selectedDosage = '5mg';
  String selectedSchedule = 'Once a day';

  InputDecoration _getInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(), // Use OutlineInputBorder for input fields
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppBar(
              title: Text(
                "Medicine Schedule",
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Color(0xFFdafefa),
              elevation: 0),
          Image.asset(
            'assets/images/MainImage.png',
            width: 500,
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: _getInputDecoration('Medicine Name'),
              onChanged: (value) {
                setState(() {
                  medicineName = value;
                });
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: _getInputDecoration('Duration'),
              onChanged: (value) {
                setState(() {
                  duration = value;
                });
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: _getInputDecoration('Amount'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                setState(() {
                  amount = value;
                });
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              decoration: _getInputDecoration('Dosage'),
              value: selectedDosage,
              onChanged: (value) {
                setState(() {
                  selectedDosage = value!;
                });
              },
              items: dosageOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              decoration: _getInputDecoration('Schedule'),
              value: selectedSchedule,
              onChanged: (value) {
                setState(() {
                  selectedSchedule = value!;
                });
              },
              items: scheduleOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle form submission here
                // You can access medicineName, selectedDosage, selectedSchedule, and alarmTime
                // and perform any necessary actions with the input data.
                print('Medicine Name: $medicineName');
                print('Duration: $duration');
                print('Amount: $amount');
                print('Dosage: $selectedDosage');
                print('Schedule: $selectedSchedule');
                if (alarmTime != null) {
                  print('Alarm Time: ${alarmTime!.format(context)}');
                }
              },
              child: Text('Submit'),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                final selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (selectedTime != null) {
                  setState(() {
                    alarmTime = selectedTime;
                  });
                }
              },
              child: Text('Pick Alarm Time'),
            ),
          ),
          // Display selected alarm time
          if (alarmTime != null)
            Container(
              padding: EdgeInsets.all(8.0),
              child: Text('Selected Alarm Time: ${alarmTime!.format(context)}'),
            ),
        ],
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal, // Change the primary color as needed
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "DashBoard",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color(0xFFdafefa),
          elevation: 0,
          actions: [
            // Bell Icon Button
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                // Implement notification icon functionality here
              },
            ),
          ],
        ),
        body: Container(
          color: const Color(0xFFDAFEFA), // Set the background color here
          child: ListView(
            children: [
              // Calendar Widget Here
              Padding(
              padding: const EdgeInsets.all(16.0),
              child: DatePicker(
                DateTime.now(),
                height:100,
                width: 80,
                initialSelectedDate: DateTime.now(),
                selectionColor:Colors.teal,
                selectedTextColor: Colors.white,
                dateTextStyle: const TextStyle(
                  fontSize:20,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal
                ),
              )
            ),
              // First Subheading
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Your Pills',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Pill-style List
              Container(
                height: 400, // Set the height as needed (increased from 300)
                child: ListView.builder(
                  itemCount: 5, // Replace with your item count
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 130, // Increase the height of the item boxes
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20), // Pill shape
                          color: const Color(0xFF10A19D),
                          // Change the color as needed
                        ),
                        child: Text(
                          'Pill A', // Replace with your item text
                          style: TextStyle(
                            color: Colors.white, // Text color
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Another Topic
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Others',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Horizontal List (Scrollable)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 280,
                        width: 300,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20), // Pill shape
                          color: const Color(
                              0xFF10A19D), // Change the color as needed
                        ),
                        child: Text(
                          'Blood Sugar', // Replace with your item text
                          style: TextStyle(
                            color: Colors.white, // Text color
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              // Rest of your content here, e.g., HomePage
            ],
          ),
        ),
      ),
    );
  }
}
