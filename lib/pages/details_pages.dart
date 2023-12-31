import 'package:flutter/material.dart';
import 'package:lerproject/model/doctor_model.dart';

class DetailsPage extends StatelessWidget {
   DetailsPage({Key? key,required this.data}) : super(key: key);
  Data data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details page"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("name"),
            Text("${data.name}"),



        ],
        ),
      ),
    );
  }
}
