import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

const String _title = 'Get Started';

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_title),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final List<FormQuestion> _data = formQuestion;
  int _currentTimeValue = 1;
  String selectedEmploymentSector = "";
  // ignore: prefer_final_fields
  final _buttonOptions = [
    TimeValue(30, "Agriculture"),
    TimeValue(60, "Mining"),
    TimeValue(120, "Manufacturing"),
    TimeValue(240, "Construction"),
    TimeValue(480, "Wholesale Trade"),
    TimeValue(720, "Retail Trade"),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: _buildPanel()),
          ),
        ],
      ),
    );
  }

  Widget _buildPanel() {
    // Using ExpansionPanelList to display multiple ExpansionPanel
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          for (int i = 0; i < _data.length; i++) {
            // equals to the index of the pressed button
            _data[i].isExpanded = false;
          }
          // set the pressed button to the opposite of its current state
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((FormQuestion formQuestion) {
        return ExpansionPanel(
          backgroundColor: Colors.black,
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                  selectedEmploymentSector == ""
                      ? formQuestion.description
                      : selectedEmploymentSector,
                  style: const TextStyle(color: Colors.white)),
              leading: Icon(formQuestion.icon, color: Colors.white),
            );
          },
          body: SizedBox(
            height: _buttonOptions.length * 57.0,
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: _buttonOptions
                  .map((timeValue) => RadioListTile<int>(
                        groupValue: _currentTimeValue,
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: Text(timeValue._value.toUpperCase(),
                            style: const TextStyle(color: Colors.white)),
                        value: timeValue._key,
                        activeColor: Colors.white,
                        onChanged: (val) {
                          setState(() {
                            selectedEmploymentSector = timeValue._value;
                            debugPrint('VAL = $val');
                            _currentTimeValue = val!;
                            formQuestion.isExpanded = false;
                          });
                        },
                      ))
                  .toList(),
            ),
          ),
          isExpanded: formQuestion.isExpanded,
        );
      }).toList(),
    );
  }
}

class FormQuestion {
  String description;
  IconData icon;
  bool isExpanded;

  FormQuestion({
    required this.description,
    required this.icon,
    this.isExpanded = false,
  });
}

List<FormQuestion> formQuestion = [
  FormQuestion(
    description: 'Select Employment Sector',
    icon: Icons.work_outline_rounded,
  ),
];

class TimeValue {
  final int _key;
  final String _value;
  TimeValue(this._key, this._value);
}
