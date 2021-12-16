class Data{
  String date;
  String time;
  String title;
  String des;
  String priority;

  Data(this.date, this.time, this.title, this.des, this.priority);

  Data.fromJson(Map<dynamic,dynamic> json):
      date=json['date'] as String,
      time=json['time'] as String,
      title=json['title'] as String,
      des=json['des'] as String,
      priority=json['priority'] as String;

  Map<String, dynamic> toJson(){
    final Map<String,dynamic> data=new Map<String,dynamic>();
    data['date']=this.date.toString();
    data['time']=this.time.toString();
    data['title']=this.title.toString();
    data['des']=this.des.toString();
    data['priority']=this.priority.toString();

    return data;
  }

}