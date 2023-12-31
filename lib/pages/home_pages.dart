import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lerproject/pages/details_pages.dart';

import '../model/doctor_model.dart';
import '../service/doctor_service.dart';
import '../service/notificaiton_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller=TextEditingController();
  List<Data> doctor=[];
  List<Data> fo=[];
  DoctorListService doctorListService = DoctorListService();
  List<Map<String,dynamic>>_foundUser=[];
  fetchDoctorList() async {
    doctor = await doctorListService.getDoctorList(context);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDoctorList();
    fo=doctor;
    Noti.initialize(flutterLocalNotificationsPlugin);
    Noti.showBigTextNotification(
        title: "hey nazmul",
        body: "how going your life", fln: flutterLocalNotificationsPlugin);

  }
  List<Data>?result;

  void runFilter(String name){

    if(name.isEmpty){
      result=doctor!;
    }else{
      result=doctor!.where((element) => element.name!
      .toLowerCase().contains(name.toLowerCase())).toList();
    }
    setState(() {
      fo=result!;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor"),
        leading: ElevatedButton(onPressed: (){
          Noti.showBigTextNotification(
              title: "Message title",
              body: "your long body", fln: flutterLocalNotificationsPlugin);
        },
            child: Text("Send")),
        centerTitle: true,
      ),
      body: doctor == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [

                TextField(
                  onChanged: (value)=>runFilter(value),
                  decoration: InputDecoration(
                    hintText: "Search",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),

                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),

                    ),
                  ),
                ),
                SizedBox(height: 10,),


                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView.builder(
                        itemCount:fo.isNotEmpty? fo.length:doctor.length,
                        itemBuilder: (context, index) {
                      final data =fo.isNotEmpty?fo[index]:doctor[index];

                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailsPage(data: data)));
                          Noti.showBigTextNotification(
                              title: "${data.name}",
                              body: "${data.title}", fln: flutterLocalNotificationsPlugin);

                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(8)),
                          child: ListTile(
                            title: Text("${data.name}"),
                            subtitle: Text("${data.title}"),

                          ),
                        ),
                      );
                    }),
                  ),
              ],
            ),
          ),
    );
  }
}
