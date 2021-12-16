import 'package:flutter/material.dart';

class ShowData extends StatefulWidget {

  String date;
  String time;
  String title;
  String des;
  String priority;


  ShowData(this.date, this.time, this.title, this.des, this.priority);

  @override
  _ShowDataState createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  @override
  Widget build(BuildContext context) {
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
                        child: Text(widget.priority,style: TextStyle(color: Colors.white,fontSize: 18),)
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Expanded(child: Text(widget.title,style: TextStyle(color: Colors.white,fontSize: 22),)),
                          Expanded(child: Text(widget.des,style: TextStyle(color: Colors.white,fontSize: 14),)),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Text(widget.time,textAlign: TextAlign.right,style: TextStyle(color: Colors.white,fontSize: 18),)
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
}
