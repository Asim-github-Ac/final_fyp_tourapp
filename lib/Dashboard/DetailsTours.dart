import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsTours extends StatefulWidget {
  const DetailsTours({Key? key,required this.url, required this.place, required this.desplace, required this.expense, required this.date, required this.stay, required this.city}) : super(key: key);
   final String url;
   final String place;
   final String desplace;
   final String expense;
   final String date;
   final String stay;
   final String city;


  @override
  State<DetailsTours> createState() => _DetailsToursState();
}

class _DetailsToursState extends State<DetailsTours> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tour Details"),),
      body: Card(
        elevation: 8,
        margin: EdgeInsets.all(10),
        child: Container(
          height: 500,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 200,
                      child: Image.network('${widget.url}')),
                  SizedBox(height: 10,),
                  Row(
                    children: [Text("Place Name: ",style: TextStyle(color: Colors.blue,fontSize: 20),),Text('${widget.place}')],),
                  SizedBox(height: 10,),
                  Row(
                    children: [Text("Place Des: ",style: TextStyle(color: Colors.blue,fontSize: 20),),Text('${widget.desplace}')],),
                  SizedBox(height: 10,),
                  Row(
                    children: [Text("Place Name: ",style: TextStyle(color: Colors.blue,fontSize: 20),),Text('${widget.place}')],),
                  SizedBox(height: 10,),
                  Row(
                    children: [Text("City: ",style: TextStyle(color: Colors.blue,fontSize: 20),),Text('${widget.city}')],),
                  SizedBox(height: 10,),
                  Row(
                    children: [Text("Tour Date: ",style: TextStyle(color: Colors.blue,fontSize: 20),),Text('${widget.date}')],),
                  SizedBox(height: 10,),
                  Row(
                    children: [Text("Tour Expense: ",style: TextStyle(color: Colors.blue,fontSize: 20),),Text('${widget.expense}')],),
                  SizedBox(height: 10,),
                  Row(
                    children: [Text("Tour Stay: ",style: TextStyle(color: Colors.blue,fontSize: 20),),Text('${widget.stay}')],),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
