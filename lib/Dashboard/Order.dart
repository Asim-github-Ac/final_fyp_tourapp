import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/universal_variables.dart';
import 'DetailsTours.dart';
class OrderClass extends StatefulWidget {
  const OrderClass({Key? key}) : super(key: key);

  @override
  State<OrderClass> createState() => _OrderClassState();
}

class _OrderClassState extends State<OrderClass> {
  String name= "";
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Bookedtour').where("username",isGreaterThanOrEqualTo: name.toString()).snapshots();
    return Scaffold(

      appBar: AppBar(
        backgroundColor:UniversalVariables.orangeColor,
        title: Card(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText:'Search here',
            ),
            onChanged: (val){
              setState(() {
                name=val;
              });
            },
          ),
        ),),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Bookedtour').where("username",isGreaterThanOrEqualTo: name.toString()).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }


          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return Card(
                margin: EdgeInsets.all(10),
                elevation: 10,
                child: ListTile(
                  title: Column(
                    children: [
                      Container(
                          height: 200,
                          width: 200,
                          child: Image.network(data['SlipUrl'])),
                      SizedBox(height: 10,),
                      Row(children: [Text("User Name: ",style: TextStyle(color: Colors.blue,fontSize: 20),),Text(data['username'])],)
                    ],
                  ),
                  subtitle: Column(
                    children: [
                      Row(children: [Text("User Email: ",style: TextStyle(color: Colors.blue,fontSize: 18),),Text(data['useremail'])],),
                      Row(children: [Text("Address: ",style: TextStyle(color: Colors.blue,fontSize: 18),),Text(data['useraddress'])],),
                      //    Row(children: [Text("Place Stay: ",style: TextStyle(color: Colors.blue,fontSize: 18),),Text(data['stay'])],),
                      new SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:UniversalVariables.orangeColor,
                          shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          maximumSize: const Size(200, 45),
                          minimumSize: const Size(200, 45),
                        ),
                        child: const Text("More Details"),
                        onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsTours(url:data['SlipUrl'],place: data['desplace'],desplace: data['stay'],expense: data['expense'],date: data['city'],stay: data['stay'],city: data['city'],)));},
                      ),
                      SizedBox(height: 10,)
                    ],
                  ),
                ),
              );
            }).toList(),

          );
        },
      ),
    );
  }
}
