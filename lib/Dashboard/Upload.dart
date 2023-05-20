import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class UploadClass extends StatefulWidget {
  const UploadClass({Key? key}) : super(key: key);

  @override
  State<UploadClass> createState() => _UploadClassState();
}

class _UploadClassState extends State<UploadClass> {
   Item? selectedUser;
   late String cityname;

   TextEditingController placecontroler=new TextEditingController();
   TextEditingController descontroler=new TextEditingController();
   TextEditingController expensecontroler=new TextEditingController();
   TextEditingController datecontroler=new TextEditingController();
   TextEditingController staycontroler=new TextEditingController();

  List<Item> users =<Item>[
    const Item("Islamabad"),
    const Item("Karachi"),
    const Item("Kashmir"),
    const Item("Skardu"),
    const Item("Quetta"),
    const Item("Lahore"),
  ];
  File? _image;
  late String downurl;
  final _picker = ImagePicker();
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

   sendData() async {
    SnakBar("Wait a Minute");
// to upload the image to firebase storage
     var storageimage = FirebaseStorage.instance.ref().child(_image!.path);
     UploadTask task1 = storageimage.putFile(_image!);

// to get the url of the image from firebase storage
     downurl = await (await task1).ref.getDownloadURL();
     uploadFirestore(placecontroler.text.toString(), descontroler.text.toString(),expensecontroler.text.toString(), datecontroler.text.toString(), staycontroler.text.toString(), downurl, cityname.toString(),context);
// you can save the url as a text in you firebase store collection now
   }

   void SnakBar(String message){
     ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           content: Text(message),
         )
     );
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle:true,
        title: Text("Tourists Admin",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),),
        backgroundColor:Colors.lightBlue,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget> [
              GestureDetector(
                onTap: _openImagePicker,
                child: new Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 200,
                  color: Colors.white,
                  child: _image != null
                      ? Image.file(_image!,fit: BoxFit.cover,)
                      : const Text("Please Select an Image"),
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: placecontroler,
                decoration: InputDecoration(
                  hintText: 'Enter Place Name',
                  prefixIcon: Icon(Icons.place_outlined),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
               controller: descontroler,
                decoration: InputDecoration(
                  hintText: 'Enter Place Des',
                  prefixIcon: Icon(Icons.description),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                 controller: expensecontroler,
                decoration: InputDecoration(
                  hintText: 'Expense',
                  prefixIcon: Icon(Icons.price_change),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                 controller: datecontroler,
                decoration: InputDecoration(
                  hintText: 'dd/mm/yy',
                  prefixIcon: Icon(Icons.date_range),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: staycontroler,
                decoration: InputDecoration(
                  hintText: 'Stay',
                  prefixIcon: Icon(Icons.stay_current_landscape),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              new Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: DropdownButton<Item>(
                    elevation: 8,
                    isExpanded: true,
                    style: TextStyle(fontSize: 18),
                    hint: Text("Select city"),
                    value: selectedUser,
                    onChanged: (Value){
                        setState(() {
                          selectedUser=Value;
                          cityname=selectedUser!.name;
                          print('city__________________'+cityname);
                      });
                    },
                    items: users.map((Item user) {

                      return  DropdownMenuItem<Item>(
                        value: user,
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 10,),
                            Text(
                              user.name,
                              style:  TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              new SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary:Colors.lightBlue,
                  shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  maximumSize: const Size(200, 45),
                  minimumSize: const Size(200, 45),
                ),
                child: const Text("Upload"),
                onPressed: (){sendData();},
              )
            ],
          ),
        ),
      ),
    );
  }
}
Future<void> uploadFirestore(String placename,String desplace,String expense,String date,String stay,String url,String city,BuildContext context)async {
  CollectionReference addtours = FirebaseFirestore.instance.collection('Tours');

   addtours
      .add({
    'placename': placename, // John Doe
    'desplace': desplace, // Stokes and Sons
    'expense': expense ,
    'date': date ,
    'stay': stay ,
    'url': url ,
    'city': city // 42
  })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Your Tour is Added"),
      )
  );
}

class Item{
  const Item(this.name);
  final String name;
}