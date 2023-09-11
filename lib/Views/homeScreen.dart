import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ubitevents/Utils/utils.dart';
import 'package:ubitevents/Views/records.dart';
import 'package:ubitevents/Views/signin.dart';
import 'package:ubitevents/auth/loginScreen.dart';
import 'package:ubitevents/widgets/round_button.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({
    super.key,
  });

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  bool loading = false;
  // Controllers
  final serailNoController = TextEditingController();
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final signatureController = TextEditingController();

  // clear text field

  void clearTextFields() {
    serailNoController.clear();
    nameController.clear();
    contactController.clear();
    signatureController.clear();
  }

  // form key
  final _formKey = GlobalKey<FormState>();

  // Firestore instance
  final attendees = FirebaseFirestore.instance.collection('attendees');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                const SizedBox(
                  height: 28,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => loginScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * .02),
                          child: const Text(
                            'Login as admin',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Register',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .06),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .08),
                          child: const Text(
                            'Serial No:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          )),
                      const SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        controller: serailNoController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.numbers),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            hintText: 'Enter Serial No'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ('Enter Serial No');
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .06),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .08),
                          child: const Text(
                            'Name:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          )),
                      const SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: nameController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.person),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            hintText: 'Enter Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ('Enter Name');
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .06),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .08),
                          child: const Text(
                            'Contact No:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          )),
                      const SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: contactController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.phone),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            hintText: 'Enter Contact Number'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ('Enter Contact Number.');
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .06),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .08),
                          child: const Text(
                            'Signature:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          )),
                      const SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: signatureController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(
                              CupertinoIcons.signature,
                              color: Colors.black,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            hintText: 'Enter Signature'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ('Enter Signature');
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                RoundButton(
                    title: 'Done',
                    loading: loading,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        String id =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        attendees.doc(id).set({
                          'id': id,
                          'name': nameController.text.toString(),
                          'serial_no': serailNoController.text.toString(),
                          'contact_no': contactController.text.toString(),
                          'signature': signatureController.text.toString(),
                        }).then((value) {
                          Navigator.pop(
                            context,
                          );
                          clearTextFields();
                          setState(() {
                            loading = false;
                          });
                          Utils().toastMessage('Record Added Successfully');
                        }).onError((error, stackTrace) {
                          setState(() {
                            loading = false;
                          });
                          Utils().toastMessage('Record not added');
                        });
                      }
                    }),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
