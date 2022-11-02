import 'package:flutter/material.dart';
import 'package:test_docker/model/approach.dart';

class ApproachPage extends StatefulWidget {
  const ApproachPage({Key? key}) : super(key: key);


  @override
  State<ApproachPage> createState() => _ApproachPageState();
}

class _ApproachPageState extends State<ApproachPage> {
  late ApproachWeight _approach;
  TextEditingController _weightController = TextEditingController();
  TextEditingController _repeatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _approach = ApproachWeight(countRepeat: 0, weight: 0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WorkoutNote"),
        actions: [
          IconButton(onPressed: (){
            _approach.weight = int.parse(_weightController.text.isNotEmpty ? _weightController.text : "0");
            _approach.countRepeat = int.parse(_repeatController.text.isNotEmpty ? _repeatController.text : "0");
            Navigator.pop(context, _approach);
          }, icon: Icon(Icons.save))
        ],
      ),
      body: Form(
        child: Column(
          children: [
            TextField(
              controller: _weightController,
              decoration: InputDecoration(labelText: 'weight'),
            ),
            TextField(
              controller: _repeatController,
              decoration: InputDecoration(labelText: 'repeat'),
            ),
          ],
        ),
      ),
    );
  }
}
