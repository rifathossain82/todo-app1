import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_demo/Add_task_page.dart';
import 'package:todo_app_demo/store_data/Data.dart';
import 'package:todo_app_demo/test.dart';
import 'package:todo_app_demo/widget/ShowData.dart';

import 'constraints/string.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DateTime _dateTime = DateTime.now();

  List<Test> datalist=[];

  String getText(DateTime date) {
    if (date == null) {
      return "Select Date";
    } else {
      return '${date.day}-${date.month}-${date.year}';
    }
  }

  @override
  void initState(){
    super.initState();
    _dateTime=DateTime.now();
    String date=getText(_dateTime);
    data_search(date);
    data_search1(date);
  }

  @override
  void onchanged(){

  }


  void data_search(String date){
    print(date);
    ///to find high priority data
    final Query databaseReference1=FirebaseDatabase.instance.reference().child('data').child(date).orderByChild('priority').equalTo('High'); //.child('14-12-2021')
    databaseReference1.once().then((DataSnapshot snapshot){
      datalist.clear();
      var keys=snapshot.value.keys;
      var value=snapshot.value;
      for (var key in keys){
        Test test=new Test(
          value [key]['date'],
          value [key]['time'],
          value [key]['title'],
          value [key]['des'],
          value [key]['priority'],
        );
        datalist.add(test);
      }
      setState(() {

      });
    });

  }

  void data_search1(String date){
    ///to find high priority data
    final Query databaseReference2=FirebaseDatabase.instance.reference().child('data').child(date).orderByChild('priority').equalTo('Normal');
    databaseReference2.once().then((DataSnapshot snapshot){
      var keys=snapshot.value.keys;
      var value=snapshot.value;
      for (var key in keys){
        Test test=new Test(
          value [key]['date'],
          value [key]['time'],
          value [key]['title'],
          value [key]['des'],
          value [key]['priority'],
        );
        datalist.add(test);
      }
      setState(() {

      });
    });

  }


  //to search low priority data
  void data_search2(String date){
    ///to find low priority data
    final Query databaseReference3=FirebaseDatabase.instance.reference().child('data').child(date).orderByChild('priority').equalTo('Low');
    databaseReference3.once().then((DataSnapshot snapshot){
      var keys=snapshot.value.keys;
      var value=snapshot.value;
      for (var key in keys){
        Test test=new Test(
          value [key]['date'],
          value [key]['time'],
          value [key]['title'],
          value [key]['des'],
          value [key]['priority'],
        );
        datalist.add(test);
      }
      setState(() {

      });
    });
  }

  late Widget show_data1=Center();
  late Widget show_data2=Center();
  late Widget show_data3=Center();



  TextEditingController controller=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyString().app_name),
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.teal, Colors.cyan],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
        ),
      ),
      body: datalist.length==0?Center(child: Text('No data found'),):
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView.builder(
            itemCount: datalist.length,
            itemBuilder: (_,index){
              return CardUi(datalist[index].date,datalist[index].time,datalist[index].title,datalist[index].des,datalist[index].priority);
            },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTask()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}





Widget CardUi(String date,String time,String title,String des,String priority){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
    child: Card(
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
                colors: [Colors.teal, Colors.cyan],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)
        ),
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: (){},
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                      child: Text(priority,style: TextStyle(color: Colors.white,fontSize: 18),)
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Expanded(child: Text(title,style: TextStyle(color: Colors.white,fontSize: 22),)),
                        Expanded(child: Text(des,style: TextStyle(color: Colors.white,fontSize: 14),)),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                      child: Text(time,textAlign: TextAlign.right,style: TextStyle(color: Colors.white,fontSize: 18),)
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}



/*
Column(
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueGrey, Colors.lightBlueAccent],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
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
                            /*
                            show_data1=Center();
                            show_data2=Center();
                            show_data3=Center();
                            SearchData_high(getText(_dateTime));
                             */

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
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                      child:
                      ElevatedButton(
                          onPressed: (){
                            setState(() {
                              SearchData_high(getText(_dateTime));
                              SearchData_normal(getText(_dateTime));
                              SearchData_low(getText(_dateTime));
                            });
                          },
                          child: Text('search')),
                  ),

                ],
              ),
            ),
          ),
          SizedBox(height: 50,),
          Container(
            child: datalist.length==0?Center(child: Text('No data found'),):
            ListView.builder(
              itemCount: datalist.length,
                itemBuilder: (_,index){
                return CardUi(datalist[index].date,datalist[index].time,datalist[index].title,datalist[index].des,datalist[index].priority);
                }
            ),
          )
        ],
      ),
 */

