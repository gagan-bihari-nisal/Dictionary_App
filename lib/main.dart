import 'package:dictionary_app/SearchResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp( MaterialApp(
    home: Myapp(),
    debugShowCheckedModeBanner: false,
  ));
}

class Myapp extends StatefulWidget {

  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  TextEditingController search=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green.shade200,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Dictionary",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30
              ),),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: TextFormField(
                    controller: search,
                    decoration: InputDecoration(
                      hintText: "Enter the word",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      focusedBorder:  OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.redAccent,
                          ),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      focusColor: Colors.green,
                    ),
                    autofocus: false,
                    autocorrect: true,
                  ),
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width*0.4,
                child: ElevatedButton(onPressed: (){
                  if(search.text=="" || search.text==null){
                    Fluttertoast.showToast(msg: "Type something",toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.SNACKBAR,
                      backgroundColor: Colors.white,
                      textColor: Colors.black
                    );
                  }
                  else{
                    print("good to go");
                    Navigator.push(context,
                    MaterialPageRoute(builder: (c)=>SearchResult(search.text.toString())));
                  }
                }, 
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                      backgroundColor: MaterialStateProperty.all(Colors.red.shade200)

                    ),
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Search"),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.search),
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
