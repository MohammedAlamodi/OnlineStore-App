import 'package:flutter/material.dart';

class DropDwon extends StatefulWidget {
  @override
  _DropDwonState createState() => _DropDwonState();
}

class _DropDwonState extends State<DropDwon> {
  final _formKey = GlobalKey<FormState>();

  final listOfPets = ["Cats", "Dogs", "Rabbits"];

  String dropdownValue = 'Cats';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: DropdownButtonFormField(
            value: dropdownValue,
            icon: Icon(Icons.arrow_downward),
            decoration: InputDecoration(
              labelText: "Select Pet Type",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            items: listOfPets.map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Select Pet';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
