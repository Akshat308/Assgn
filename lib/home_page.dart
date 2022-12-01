import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
     
   late Map mr;
   late List ls;
   var isloaded=false;
  Future getdata() async{
  http.Response response;
  response =await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
  if(response.statusCode ==200)
 {
  setState(() {
    
    mr= jsonDecode(response.body);
    ls=mr['data'];
    isloaded=true;
  });
 }
  }
  @override
  void initState() {
  
     getdata();
    super.initState();
    
  }
 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('User Detail')),
          
      body: Visibility(
        visible: isloaded,
        child: Center(
          child: ListView.builder(
            itemCount: ls==null? 0 : ls.length,
            itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(10),
              height: 300,
              
              decoration: BoxDecoration( shape: BoxShape.rectangle,
                     color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)
                    ),
              child: Column(
                children: [
                  
                  Image.network(ls[index]['avatar']),
                  
                  Text(ls[index]['id'].toString()),
                  Text(ls[index]['first_name'].toString(),
                  style: TextStyle(
                    color: Colors.amber
                  ),),
                  Text(ls[index]['last_name'].toString(),
                  style: TextStyle(
                    color:  Colors.amber
                  ),),
                  Text(ls[index]['email'].toString()),
                ],
              ),
            );
          }),
        ),
        replacement: const Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}

