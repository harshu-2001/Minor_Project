

//import 'dart:io';

//import 'dart:html';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart ' as firebase_storage;

class MyApp extends StatefulWidget {
  

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  getUser() async {
    User? firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;
  }
   @override
  void initState(){
    super.initState();
    this.getUser();
  }
  FirebaseFirestore firestore = FirebaseFirestore.instance;
   List <XFile> fileImage=[];
   final picker = ImagePicker();
   final _formKey = GlobalKey<FormState>();
    var  _name;
    // ignore: unused_field
    var _category;
    // ignore: unused_field
    var _quantity;
    // ignore: unused_field
    var _price;
    var productid=DateTime.now().millisecondsSinceEpoch.toString()+DateTime.now().microsecond.toString();
    bool uploading=false,boli=false;
  @override
  Widget build(BuildContext context) {
    return boli!=true?displayhome():displayform();
    
  }

   displayhome(){
    return Scaffold(
      appBar: AppBar(
          title: Text("Products",
          style: GoogleFonts.lato(
                        fontWeight: FontWeight.w600,
    
                      ),),
      ),
      body: Center(
        child: Card(
          elevation: 50,
          shadowColor: Colors.blue,
          child: Container(
            width: MediaQuery.of(context).size.width-50,
            height: MediaQuery.of(context).size.height-200,
            child: Column(children: <Widget>[
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width-50,
                child:IconButton(
                  onPressed:() => selectPic(context),
                icon: Padding(
                  padding: const EdgeInsets.fromLTRB(2, 115, 2, 10),
                  child: Column(
                    children: [
                      Icon( 
                        Icons.add_a_photo,
                        size: 30,
                        color: Colors.black,
                        ),
                        SizedBox(height: 5,),
                        Text("Add Pics",
                        style:GoogleFonts.lato(
                                            fontSize: 12,
                                            color:Colors.grey,
                                            fontWeight: FontWeight.w600,
                        
                                          ),),
                    ],
                  ),
                ),
        
                ),
              ),
              
              ]
            ,
            ),
          ),
        ),
      ),
      
    );
  }
  selectPic(mcontext){
    return showDialog(
      context: mcontext, 
      builder: (con){
        return SimpleDialog(
          title: Text("Item Images",
          style: GoogleFonts.lato(
            color: Colors.blue,
            fontWeight: FontWeight.w600,
          ),
          ),
          children: <Widget>[
            SimpleDialogOption(
              child: Text("Capture with camera",
          style: GoogleFonts.lato(
            color: Colors.blue,
            fontWeight: FontWeight.w600,
          ),
          ),
              onPressed: capturewithcamera,
            ),
            SimpleDialogOption(
              child: Text("Select from gallery",
              style: GoogleFonts.lato(
            color: Colors.blue,
            fontWeight: FontWeight.w600,
          ),
          
          ),
          onPressed: photofromgallery,
            )
          ],
        );
      }
      );
  }
  capturewithcamera() async {
    Navigator.pop(context);
    XFile? imageFile=await picker.pickImage(source:ImageSource.camera ,imageQuality: 50 );
    setState(() {
      fileImage.add(XFile(imageFile!.path));
      boli=true;
    });
  }
  photofromgallery() async {
    Navigator.pop(context);
    XFile? imageFile=await picker.pickImage(source:ImageSource.gallery ,imageQuality: 50);
    setState(() {
      fileImage.add(XFile(imageFile!.path));
      boli=true;
    });
  }


  displayform(){
    print((fileImage[0].path));
    return Scaffold(
      appBar: AppBar(
          title: Text("Products",
          style: GoogleFonts.lato(
                        fontWeight: FontWeight.w600,
    
                      ),),
      ),
      body: Center(
        child: Card(
          elevation: 50,
          shadowColor: Colors.blue,
          child: uploading?Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top:8.0),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            )
            )
            :Container(
              width: MediaQuery.of(context).size.width,
              
              height: MediaQuery.of(context).size.height,

              child: Column(
                children: <Widget>[
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 5,),

                      Expanded(
                        child: Container(
                          height: 230,
                          width:MediaQuery.of(context).size.width*0.8,
                          child: ListView.builder(
                            itemCount: fileImage.length,
                            scrollDirection:Axis.horizontal,
                            itemBuilder: (context,index){
                            return Container(
                              width:MediaQuery.of(context).size.width*0.8 ,
                              height: 230,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(
                                    File(fileImage[index].path)
                                  )
                            
                                )
                              ),
                            );
                              }
                            ,),
                        ),
                      ),
                         SizedBox(width: 5,),
                                IconButton(
                            onPressed:() => selectPic(context),
                          icon: Icon( 
                            Icons.add_a_photo,
                            size: 30,
                            color: Colors.black,
                        ),
        
                      ),
                    ],
                  ),
                ),
                Center(
             child: Card(
               elevation: 0,
               shadowColor: Colors.yellowAccent,
               child: Container(
                 width: MediaQuery.of(context).size.width-20,
                 child: Form(
                   key: _formKey,
                   child: Column(
                     children: [
                       TextFormField(
                         validator: (input)
                                       {
                                         if(input!.isEmpty){
                                             return "Empty";
                                       }
                                       },
                                         onSaved: (input)=>_name=input!,
                                       decoration: InputDecoration(
                                         prefixIcon: Icon(Icons.person ,
                                         color: Colors.black,),
                                         hintText: "Name",
                                         
                                         hintStyle: GoogleFonts.lato(
                                         fontSize: 14,
                                         color:Colors.grey,
                                         fontWeight: FontWeight.w600,
                     
                                       ),
                                         border: InputBorder.none
                                       ),
               
               
                       ),
                       TextFormField(
                         validator: (input)
                                   {
                                     if(input!.isEmpty){
                                         return "Empty";
                                   }
                                   },
                                         onSaved: (input)=>_category=input!,
                                       decoration: InputDecoration(
                                         prefixIcon: Icon(Icons.category_outlined,
                                         color: Colors.black,),
                                         hintText: "Categories",
                                         
                                         hintStyle: GoogleFonts.lato(
                                         fontSize: 14,
                                         color:Colors.grey,
                                         fontWeight: FontWeight.w600,
                     
                                       ),
                                         border: InputBorder.none
                                       ),
               
               
                       ),
                       TextFormField(
                         validator: (input)
                                       {
                                         if(input!.isEmpty){
                                             return "Empty";
                                       }
                                       },
                                         onSaved: (input)=>_quantity=input!,
                                       decoration: InputDecoration(
                                         prefixIcon: Icon(Icons.shopping_basket,
                                         color: Colors.black,),
                                         hintText: "Quantity",
                                         
                                         hintStyle: GoogleFonts.lato(
                                         fontSize: 14,
                                         color:Colors.grey,
                                         fontWeight: FontWeight.w600,
                     
                                       ),
                                         border: InputBorder.none
                                       ),
               
               
                       ),
                       TextFormField(
                         validator: (input)
                                       {
                                         if(input!.isEmpty){
                                             return "Empty";
                                       }
                                       },
                                         onSaved: (input)=>_price=input!,
                                       decoration: InputDecoration(
                                         prefixIcon: Icon(Icons.price_change_sharp ,
                                         color: Colors.black,),
                                         hintText: "Price",
                                         
                                         hintStyle: GoogleFonts.lato(
                                         fontSize: 14,
                                         color:Colors.grey,
                                         fontWeight: FontWeight.w600,
                     
                                       ),
                                         border: InputBorder.none
                                       ),
                                       
               
               
                       ),
                     
                     ],
                   ),
                   ),
               ),
             ),
                ),
                TextButton(
                  onPressed: uploaddetails,
                 child: Text("Upload"),
                 
                 ),
                ]
              ,
              ),
                 ),
        ),
      ),
      
    );
  }
  uploaddetails()async{
   dynamic imageDownloadurl=await uploaddetai(fileImage);
    saveItemInfo(imageDownloadurl);
    //saveItemInfo();
  }
  Future<List<String>> uploaddetai(List<XFile> fileImag)async{
    var storageReference=firebase_storage.FirebaseStorage.instance.ref().child("items");
    firebase_storage.UploadTask uploadTask;
    List<String> download=[];
    if(_formKey.currentState!.validate()){
       _formKey.currentState?.save();
    for(int i=0;i<fileImag.length;i++){
     uploadTask=storageReference.child("product_$_name($i).jpg").putFile(File(fileImag[i].path));
     var tasksnapshot=await uploadTask;
     download.add(await tasksnapshot.ref.getDownloadURL());
    }
    }
    //print(download);
  return download;
  }
  saveItemInfo(List<dynamic>image){
    if(_formKey.currentState!.validate()){
       _formKey.currentState?.save();
      String images='';
    for(int i=0;i<image.length;i++){
      images+='@'+image[i];
    }
    //print("$_price $_name $_quantity $_category");
    final itemRef=FirebaseFirestore.instance.collection("items");
    itemRef.add(
      { 'product_id':productid,
        'product_name': _name,
        'price':int.parse(_price),
        'quantity':_quantity,
        'category':_category,
        'imageUrl':images,
        'status':"available",
        'published_date':DateTime.now(),
        
      }
    )
    .then((value) => print("User Added"))
    
    .catchError((error) => print("Failed to add user: $error"));
  }
  setState(() {
  fileImage.clear();
  boli=false;
  });
    }
  }
