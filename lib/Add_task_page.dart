import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_demo/store_data/Data.dart';
import 'package:todo_app_demo/store_data/Data_dao.dart';


class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

bool h = false;
bool n = false;
bool l = false;



TextEditingController controller1=TextEditingController();
TextEditingController controller2=TextEditingController();
Data_dao data_dao=new Data_dao();

class _AddTaskState extends State<AddTask> {

  Color setcolor(bool n) {
    if (n == true) {
      return Colors.orange;
    } else {
      return Colors.black45.withOpacity(0.3);
    }
  }

  Color txtColor(bool n) {
    if (n == true) {
      return Colors.white;
    } else {
      return Colors.white60;
    }
  }

  late DateTime _dateTime = DateTime.now();
  TimeOfDay time=TimeOfDay.now();

  String getText(DateTime date) {
    if (date == null) {
      return "Select Date";
    } else {
      return '${date.day}-${date.month}-${date.year}';
    }
  }

  String getTime_(TimeOfDay time){
    if(time==null){
      return 'Select Time';
    }
    else{
      return "${time.format(context)}";
    }
  }


  late String priority="";



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new task'),
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.teal, Colors.cyan],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    showTimePicker(
                        context: context,
                        initialTime: time ?? TimeOfDay.now(),
                    ).then((tt){
                      setState(() {
                        time=tt!;
                      });
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Row(
                      children: [
                        SizedBox(width: 8,),
                        Icon(Icons.access_time),
                        SizedBox(width: 8,),
                        Text(
                          getTime_(time),
                          style: TextStyle(fontSize: 20, color: Colors.black45),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.transparent,
                        border: Border.all(width: 1, color: Colors.blueGrey)),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: controller1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                    labelText: 'Title',
                    labelStyle: TextStyle(
                      fontSize: 20,
                    ),
                    hintText: 'Enter task title',
                    prefixIcon: Icon(
                      Icons.title,
                      size: 30,
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: controller2,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      fontSize: 20,
                    ),
                    hintText: 'Enter task description',
                    prefixIcon: Icon(Icons.description),
                  ),
                  keyboardType: TextInputType.text,
                  maxLines: 5,
                ),
                SizedBox(
                  height: 26,
                ),
                Text(
                  'Priority',
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        setState(() {
                          priority="High";
                          if (h == false) {
                            h = true;
                            n = false;
                            l = false;
                          } else {
                            h = false;
                            n = false;
                            l = false;
                          }
                        });
                      },
                      child: Container(
                        width: 80,
                        height: 40,
                        child: Center(
                            child: Text(
                          'High',
                          style: TextStyle(fontSize: 18, color: txtColor(h)),
                        )),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: setcolor(h),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        setState(() {
                          priority="Normal";
                          if (n == false) {
                            n = true;
                            h = false;
                            l = false;
                          } else {
                            n = false;
                            h = false;
                            l = false;
                          }
                        });
                      },
                      child: Container(
                        width: 80,
                        height: 40,
                        child: Center(
                            child: Text(
                          'Normal',
                          style: TextStyle(fontSize: 18, color: txtColor(n)),
                        )),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: setcolor(n),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    setState(() {
                      String date_=getText(_dateTime).toString();
                      String time_=getTime_(time).toString();
                      String title=controller1.text.toString();
                      String des=controller2.text.toString();
                      createRecord(date_,time_,title,des,priority);
                      Navigator.pop(context);
                      _dateTime=DateTime.now();
                      time=TimeOfDay.now();

                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width-20,
                    height: 40,
                    child: Center(
                        child: Text(
                          'Save',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(8),

                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void createRecord(String date,String time,String title,String des,String priority){
  final data=Data(date,time,title,des,priority);
  final DatabaseReference databaseReference=FirebaseDatabase.instance.reference().child('data').child(date);
  databaseReference.push().set(data.toJson());
  controller1.clear();
  controller2.clear();
}


//to get date from user
/*
 InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: _dateTime ?? DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 5),
                      lastDate: DateTime(DateTime.now().year + 5),
                    ).then((date) {
                      setState(() {
                        _dateTime = date!;
                      });
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Row(
                      children: [
                        SizedBox(width: 8,),
                        Icon(Icons.date_range),
                        SizedBox(width: 8,),
                        Text(
                          getText(_dateTime),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.black45),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.transparent,
                        border: Border.all(width: 1, color: Colors.blueGrey)),
                  ),
                ),
 */


//low priority
/*
SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        setState(() {
                          priority="Low";
                          if (l == false) {
                            l = true;
                            n = false;
                            h = false;
                          } else {
                            l = false;
                            n = false;
                            h = false;
                          }
                        });
                      },
                      child: Container(
                        width: 80,
                        height: 40,
                        child: Center(
                            child: Text(
                          'Low',
                          style: TextStyle(fontSize: 18, color: txtColor(l)),
                        )),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: setcolor(l),
                        ),
                      ),
                    ),
 */