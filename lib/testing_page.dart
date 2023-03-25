import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:post_project/controller/theme_controller.dart';

class TestingPage extends StatefulWidget {
  const TestingPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _TestingPageState createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  bool isSwitched = false;
  bool _isChecked = false;
  bool isLoading = false;
  String? selectedOption; // To keep track of selected option
  final box = GetStorage();
  final themeController = Get.find<ThemeController>();
  
  @override
  void initState() {
    super.initState();
    isSwitched = box.read('switch_value') ?? false;
    _isChecked = box.read('check_value') ?? false;
    selectedOption = box.read('radio_value') ?? "Option 1";
    // selectedOption = "Option 1";
  }

  setSelectedOption(String option) {
    setState(() {
      selectedOption = option;
      box.write('radio_value', selectedOption);
    });
  }

  Map<String, dynamic> myMap = {
    'name': 'Jamshaid',
    'job': 'Application developer',
    'sallery': "300000",
    'double_value': 3.14,
    'int_value': 1,
    'bool_value': true,
    'list_value_int': [1, 2, 3],
    'list_value_string': ['a', 'b', 'c'],
  };

  addOfflineData() {
    box.write('key_bool', true);
    box.write('key_int', 10);
    box.write('key_double', 3.14);
    box.write('key_string', 'Hello, world!');
    box.write('key_list', [1, 2, 3]);
    box.write('key_map', myMap);
  }

  fetchOfflineData() {
    bool myBool = box.read('key_bool') ?? false;
    int myInt = box.read('key_int') ?? 0;
    double myDouble = box.read('key_double') ?? 0.0;
    String myString = box.read('key_string');
    List<int> myList = box.read('key_list')?.cast<int>() ?? [];
    Map<String, dynamic> myMap = box.read('key_map')?.cast<String, dynamic>() ?? {};
    dynamic nameFetch = myMap['name'];
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  addOfflineData();
                },
                icon: const Icon(Icons.add)),
            IconButton(
                onPressed: () {
                  fetchOfflineData();
                },
                icon: const Icon(Icons.picture_as_pdf)),
          ],
          title: const Text('store value now'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Obx(() => Switch(
                value: themeController.isDark,
                onChanged: (value) => themeController.toggleTheme(),
              )),
              const SizedBox(
                height: 10,
              ),
              Checkbox(
                value: _isChecked,
                onChanged: (value) {
                  setState(() {
                    _isChecked = value!;
                    box.write('check_value', _isChecked);
                  });
                },
                activeColor: Colors.green,
                checkColor: Colors.white,
                materialTapTargetSize: MaterialTapTargetSize.padded,
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: const Text(
                  "Option 1",
                ),
                leading: Radio(
                  value: "Option 1",
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setSelectedOption(value!);
                  },
                ),
              ),
              ListTile(
                title: const Text(
                  "Option 2",
                ),
                leading: Radio(
                  value: "Option 2",
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setSelectedOption(value!);
                  },
                ),
              ),
              ListTile(
                title: const Text(
                  "Option 3",
                ),
                leading: Radio(
                  value: "Option 3",
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setSelectedOption(value!);
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
