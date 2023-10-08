import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../Utils/utils.dart';

class testSearch extends StatefulWidget {
  const testSearch({super.key, required this.role});
  final String role;

  @override
  State<testSearch> createState() => _testSearchState();
}

class _testSearchState extends State<testSearch> {
  


  // Firestore instance  -- to update and delete
  CollectionReference ref = FirebaseFirestore.instance.collection('attendees');
  final attendees = FirebaseFirestore.instance.collection('attendees').snapshots();



  final _formKey = GlobalKey<FormState>();

  // Controllers
  String serailNoController = "";
  String nameController = "";
  String contactController = "";
  String signatureController = "";

  var SearchController = TextEditingController();


  // Search Controller
  // final searchController = TextEditingController();
  String search = '';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Search',
        style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal :  MediaQuery.of(context).size.width * 0.02 , vertical: MediaQuery.of(context).size.height * 0.02),
        child: Column(
          children: [


              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.search),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    hintText: 'Search Serial Number'),
                    onChanged: (value){
                      setState(() {
                       search = value;
                      });
                    } ,
                   validator: (value) {
                    if (value!.isEmpty) {
                      return ('Enter Serial No');
                    }
                    return null;
                   },
                  
                ),
                SizedBox(height: 8,),





            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('attendees').snapshots(),
                builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshots){
                  return (snapshots.connectionState == ConnectionState.waiting) ?
                  Center(child: CircularProgressIndicator()) :
                  ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context , index){
                      var data = snapshots.data!.docs[index].data() as Map<String , dynamic>;
                      if(search.isEmpty){
                        return Card(
                          child: ListTile(
                            title: Text(data['name']),
                            subtitle: Text(data['serial_no']),
                              //   //Update
                                    trailing: Visibility(
                                      child: IconButton(
                                          icon: const Icon(
                                            Icons.more_vert,
                                            color: Color.fromARGB(
                                                255, 255, 197, 36),
                                          ),
                                          onPressed: () {
                                            showModalBottomSheet(
                                                isScrollControlled: true,
                                                context: context,
                                                // ignore: prefer_const_constructors
                                                builder: (BuildContext ctx) {
                                                  return Form(
                                                    key: _formKey,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 20,
                                                          left: 20,
                                                          right: 20,
                                                          bottom: MediaQuery.of(ctx)
                                                                  .viewInsets.bottom + 20),
                                                      child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          crossAxisAlignment:CrossAxisAlignment.start,
                                                          children: [
                                                            //Serial No.
                                                            TextFormField(
                                                              initialValue: snapshots.data!.docs[index]['serial_no'],
                                                              onChanged:(value) {
                                                                serailNoController = value.toString();
                                                              },
                                                              keyboardType:TextInputType.number,
                                                              decoration:const InputDecoration(
                                                                labelText:'Serial No.',
                                                              ),
                                                              validator:(value) {
                                                                if (value!.isEmpty) {
                                                                  return ('Enter Serial No');
                                                                }
                                                                return null;
                                                              },
                                                            ),

                                                            //Name
                                                            TextFormField(
                                                              initialValue: snapshots.data!.docs[index]
                                                                  ['name'],
                                                              onChanged:(value) {
                                                                nameController = value.toString();
                                                              },
                                                              keyboardType:TextInputType.text,
                                                              decoration:const InputDecoration(
                                                                      labelText:'Name'),
                                                              validator:
                                                                  (value) {
                                                                if (value!.isEmpty) {
                                                                  return ('Enter Name');
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                            //Contact No

                                                            TextFormField(
                                                              initialValue: snapshots.data!.docs[index]['contact_no'],
                                                              onChanged:(value) {
                                                                contactController =value.toString();
                                                              },
                                                              keyboardType:TextInputType.number,
                                                              decoration:const InputDecoration(
                                                                labelText:'Contact No.',
                                                              ),
                                                              validator: (value) {
                                                                if (value!.isEmpty) {
                                                                  return ('Enter Contact No.');
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                            //Signature No
                                                            TextFormField(
                                                              initialValue: snapshots.data!.docs[index]['signature'],
                                                              onChanged:(value) {
                                                                signatureController =value.toString();
                                                              },
                                                              keyboardType: TextInputType.text,
                                                              decoration:
                                                                  const InputDecoration(
                                                                labelText:'Signature.',
                                                              ),
                                                              validator:(value) {
                                                                if (value!.isEmpty) {
                                                                return ('Enter signature');
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Visibility(
                                                              visible:
                                                                  widget.role == "admin",
                                                              child: Row(
                                                                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                                                crossAxisAlignment:CrossAxisAlignment.center,
                                                                children: [
                                                                  IconButton(
                                                                      onPressed:() async {
                                                                        if (true) {
                                                                          await ref.doc(snapshots.data!.docs[index]['id']).delete();
                                                                          String id = DateTime.now().millisecondsSinceEpoch.toString();

                                                                          await ref.doc(id).set({
                                                                            'id':id,
                                                                            'name': nameController,
                                                                            'serial_no': serailNoController,
                                                                            'contact_no': contactController,
                                                                            'signature': signatureController,
                                                                          });
                                                                        }

                                                                        Utils().toastMessage(
                                                                            'Record Updated');
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      icon:
                                                                          Icon(Icons.edit,
                                                                        size:40,
                                                                        color: Colors.green,
                                                                      )),
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        // Delete

                                                                        ref.doc(snapshots.data!.docs[index]['id'])
                                                                            .delete().then((value) {
                                                                          Utils().toastMessage('Record Deleted');
                                                                        });
                                                                        Navigator.pop(context);
                                                                      },
                                                                      icon:Icon(
                                                                        Icons.delete,
                                                                        size:40,
                                                                        color: Colors.red,
                                                                      ))
                                                                ],
                                                              ),
                                                            )
                                                          ]),
                                                    ),
                                                  );
                                                });
                                          }),
                                    ),
                            
                          ),
                        );
                      }  
                        if(data['serial_no'].toString().contains(search)){
                          return InkWell(
                            onTap: (){

                            },
                            child: ListTile(
                            title: Text(data['name']),
                            subtitle: Text(data['serial_no']),
                              //   //Update
                                    trailing: Visibility(
                                      child: IconButton(
                                          icon: const Icon(
                                            Icons.more_vert,
                                            color: Color.fromARGB(
                                                255, 255, 197, 36),
                                          ),
                                          onPressed: () {
                                            showModalBottomSheet(
                                                isScrollControlled: true,
                                                context: context,
                                                // ignore: prefer_const_constructors
                                                builder: (BuildContext ctx) {
                                                  return Form(
                                                    key: _formKey,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 20,
                                                          left: 20,
                                                          right: 20,
                                                          bottom: MediaQuery.of(ctx)
                                                                  .viewInsets.bottom + 20),
                                                      child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          crossAxisAlignment:CrossAxisAlignment.start,
                                                          children: [
                                                            //Serial No.
                                                            TextFormField(
                                                              initialValue: snapshots.data!.docs[index]['serial_no'],
                                                              onChanged:(value) {
                                                                serailNoController = value.toString();
                                                              },
                                                              keyboardType:TextInputType.number,
                                                              decoration:const InputDecoration(
                                                                labelText:'Serial No.',
                                                              ),
                                                              validator:(value) {
                                                                if (value!.isEmpty) {
                                                                  return ('Enter Serial No');
                                                                }
                                                                return null;
                                                              },
                                                            ),

                                                            //Name
                                                            TextFormField(
                                                              initialValue: snapshots.data!.docs[index]
                                                                  ['name'],
                                                              onChanged:(value) {
                                                                nameController = value.toString();
                                                              },
                                                              keyboardType:TextInputType.text,
                                                              decoration:const InputDecoration(
                                                                      labelText:'Name'),
                                                              validator:
                                                                  (value) {
                                                                if (value!.isEmpty) {
                                                                  return ('Enter Name');
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                            //Contact No

                                                            TextFormField(
                                                              initialValue: snapshots.data!.docs[index]['contact_no'],
                                                              onChanged:(value) {
                                                                contactController =value.toString();
                                                              },
                                                              keyboardType:TextInputType.number,
                                                              decoration:const InputDecoration(
                                                                labelText:'Contact No.',
                                                              ),
                                                              validator: (value) {
                                                                if (value!.isEmpty) {
                                                                  return ('Enter Contact No.');
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                            //Signature No
                                                            TextFormField(
                                                              initialValue: snapshots.data!.docs[index]['signature'],
                                                              onChanged:(value) {
                                                                signatureController =value.toString();
                                                              },
                                                              keyboardType: TextInputType.text,
                                                              decoration:
                                                                  const InputDecoration(
                                                                labelText:'Signature.',
                                                              ),
                                                              validator:(value) {
                                                                if (value!.isEmpty) {
                                                                return ('Enter signature');
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Visibility(
                                                              visible:
                                                                  widget.role == "admin",
                                                              child: Row(
                                                                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                                                crossAxisAlignment:CrossAxisAlignment.center,
                                                                children: [
                                                                  IconButton(
                                                                      onPressed:() async {
                                                                        if (true) {
                                                                          await ref.doc(snapshots.data!.docs[index]['id']).delete();
                                                                          String id = DateTime.now().millisecondsSinceEpoch.toString();

                                                                          await ref.doc(id).set({
                                                                            'id':id,
                                                                            'name': nameController,
                                                                            'serial_no': serailNoController,
                                                                            'contact_no': contactController,
                                                                            'signature': signatureController,
                                                                          });
                                                                        }

                                                                        Utils().toastMessage(
                                                                            'Record Updated');
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      icon:
                                                                          Icon(Icons.edit,
                                                                        size:40,
                                                                        color: Colors.green,
                                                                      )),
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        // Delete

                                                                        ref.doc(snapshots.data!.docs[index]['id'])
                                                                            .delete().then((value) {
                                                                          Utils().toastMessage('Record Deleted');
                                                                        });
                                                                        Navigator.pop(context);
                                                                      },
                                                                      icon:Icon(
                                                                        Icons.delete,
                                                                        size:40,
                                                                        color: Colors.red,
                                                                      ))
                                                                ],
                                                              ),
                                                            )
                                                          ]),
                                                    ),
                                                  );
                                                });
                                          }),
                                    ),
                            
                            ),
                          );
                        }
                      return Container(
                        
                      );                    
                  });
      
                }))
          ],
        ),
      )
      ,
    );
  }
}