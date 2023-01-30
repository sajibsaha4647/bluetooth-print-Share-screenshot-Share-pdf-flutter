import 'package:flutter/material.dart';

class esposScreen extends StatefulWidget {
  const esposScreen({Key? key}) : super(key: key);

  @override
  State<esposScreen> createState() => _esposScreenState();
}

class _esposScreenState extends State<esposScreen> {

  var  data = [
    {
      "title":"product 1",
      "price":"50",
      "qyt":2,
      "total":"2000"
    },{
      "title":"product 1",
      "price":"50",
      "qyt":2,
      "total":"2000"
    },{
      "title":"product 1",
      "price":"50",
      "qyt":2,
      "total":"2000"
    },{
      "title":"product 1",
      "price":"50",
      "qyt":2,
      "total":"2000"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Column(
        children: [
          Expanded(child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (content,index){
                return ListTile(
                  title: Text("${data[index]["title"]}"),
                  subtitle: Text("${data[index]["price"]}"),
                );
          })),
          ElevatedButton(onPressed: (){
            // Navigator.push(
            //     context,
                // MaterialPageRoute(builder: (context) => const PrintScreen()));
          }, child: Text("print"))
        ],
      ),
    ));
  }
}
