import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Myhome(),
    );
  }
}
class Myhome extends StatefulWidget {
  const Myhome({Key? key}) : super(key: key);

  @override
  State<Myhome> createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  TextEditingController _TitleController = TextEditingController();
  TextEditingController _DescriptionController = TextEditingController();
  TextEditingController _DaysController = TextEditingController();
  List<AddTask> Task = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tesk Management'),
        ),
      body: ListView.builder(
          itemCount: Task.length,
          itemBuilder: (context, index){
            return ListTile(
              onLongPress: (){
                showBottomSheet(context: context, builder: (context){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Task Details', style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Title: ${Task[index].title}'),
                        Text('Description: ${Task[index].description}'),
                        Text('Days Required: ${Task[index].days}'),

                        SizedBox(
                          height: 10,
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              ElevatedButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: Text('OK')),
                              SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(onPressed: (){
                                Task.removeAt(index);
                                setState(() {
                                  Navigator.pop(context);
                                });
                              }, child:const Text('Delete')),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                });
              },
              title: Text(Task[index].title),
              subtitle: Text(Task[index].description),
            );
          }),
      floatingActionButton: FloatingActionButton(onPressed: (){
        showDialog(context: context, builder: (context){
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Add Task'),
                SizedBox(height: 20,),
                TextFormField(
                  controller: _TitleController,
                  decoration: InputDecoration(
                    label: Text('Title'),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  maxLines: 4,
                  controller: _DescriptionController,
                  decoration: InputDecoration(
                    label: Text('Description'),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _DaysController,
                  decoration: InputDecoration(
                    label: Text('Days Required'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),

            actions: [
              TextButton(onPressed: (){
                if(_TitleController.text.trim().isNotEmpty&&
                _DescriptionController.text.trim().isNotEmpty&&
                    _DaysController.text.trim().isNotEmpty
                ){
                  Task.add(AddTask(_TitleController.text, _DescriptionController.text,
                      _DaysController.text));
                }
                _TitleController.clear();
                _DescriptionController.clear();
                _DaysController.clear();
                if(mounted){
                  setState(() {

                  });
                }
                Navigator.pop(context);
              }, child: Text('Save')),
            ],
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),),
          );
        });
      },
        child: Icon(Icons.add),),
    );
  }
}
class AddTask{
  String title;
  String description;
  String days;

  AddTask(this.title,this.description,this.days);
}

