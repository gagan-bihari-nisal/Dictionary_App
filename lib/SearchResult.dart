import 'package:dictionary_app/GetResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchResult extends  StatefulWidget {
  String searched;
  SearchResult(this.searched);

 // const SearchResult({Key key}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState(this.searched);
}

class _SearchResultState extends State<SearchResult> {

  String searched;
  _SearchResultState(this.searched);

  @override
  void initState() {
    // TODO: implement initState
    //GetResult.getResult(searched.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold( 
      appBar: AppBar(
        title: Text("$searched".toUpperCase()),
        backgroundColor: Color(0x4000ff48),
      ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width*0.9,
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder(builder: (BuildContext context,AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(itemBuilder: (c, index) {
                  var result = snapshot.data[index];
                  return InkWell(
                    onTap: (){
                      var data=snapshot.data[index];
                      print(data);
                      Navigator.push(context,
                      MaterialPageRoute(builder: (c)=>NextPage(data))
                      );
                    },
                    child: ListTile(
                      title: Text("${result['word']}"),
                    ),
                  );
                },
                  itemCount: snapshot.data.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text("error"),);
              }
              else if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              else if (snapshot.data == null) {
                return Center(child: Text("$error"),);
              } else {
                return Center(child: CircularProgressIndicator());
              }

            },future: GetResult.getResult("$searched"),),
          ),
        ),
      ),
    );
  }
}

class NextPage extends StatefulWidget {
  var data;
  NextPage(this.data);

  //const NextPage({Key key}) : super(key: key);

  @override
  _NextPageState createState() => _NextPageState(this.data);
}

class _NextPageState extends State<NextPage> {

  var data;
  _NextPageState(this.data);
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // ignore: file_names
      child: Scaffold(
        appBar: AppBar(
          title: Text("Meaning".toUpperCase()),
          backgroundColor: Color(0x4000ff48),
        ),   
        body: ListView.builder(itemBuilder: (c,index){
          var meanings=data["meanings"][index];
          return ListView.builder(itemBuilder: (c,index){
            var definitions=meanings["definitions"][index];
            print(definitions);
            var definition=definitions["definition"];
            return ListTile(
              leading:Icon(Icons.api),
              title: Text("$definition"),
            );
          },
            itemCount: meanings["definitions"].length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
          );
        },
        itemCount: data["meanings"].length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
        ),
      ),
    );
  }
}
