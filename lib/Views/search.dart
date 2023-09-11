// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

//   final searchController = TextEditingController();
 
//   List searchResult = [];

//   void searchFromDB(String query) async {

//  final result = await
//       FirebaseFirestore.instance.collection('attendees').doc('serial_no').snapshots();

//   setState(() async {
//         searchResult = await result.map((e) => e.data).toList();
//   });
    
// }

// final ref= FirebaseFirestore.instance.collection('attendee').snapshots();  
 

  @override
  Widget build(BuildContext context) {

    String serial = '' ;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search ' ,style: TextStyle(fontSize: 22 , fontWeight: FontWeight.w500),),
          
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal : MediaQuery.of(context).size.width * 0.050 ,  vertical: MediaQuery.of(context).size.width * 0.06 ),
          child: Column(children: [
            TextFormField(
            
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: InkWell(
                   
                    child: Icon(Icons.clear)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  hintText: 'Search Serial Number'),
                  onChanged: (query){
                    setState(() {
                      serial = query;
                    });
                  } ,
                 validator: (value) {
                  if (value!.isEmpty) {
                    return ('Enter Serial No');
                  }
                 },
                            ),
           Expanded(
               child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('attendees').snapshots(),
                builder: (context , snapshot){
                  return(snapshot.connectionState == ConnectionState.waiting) ? 
                  Center(child: CircularProgressIndicator())
                  :
                  ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    // ignore: curly_braces_in_flow_control_structures, curly_braces_in_flow_control_structures
                    itemBuilder: (context, index) { 
                      var data = snapshot.data!.docs[index].data() as Map<String , dynamic>;
                      if (serial.isEmpty){
                        return
                        ListTile(
                          title: data['serial_no'],
                        ) ;
                        // SizedBox(child: Text ('Search Serial Number'),);
                      }
                      var search = data['serial_no'].toString().contains(serial); 
                      if(search){
                        return ListTile(
                          title:  Text(data['name']),
                        
                        );
                      } 
                      return Container();
                    },);
                } ))
               ]),
        )
        
        
      ),
    );
  }
}