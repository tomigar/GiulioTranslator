import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as aut;
import 'package:flutter/material.dart';
import 'package:translator_app/widgets/Languages/LanguagesList.dart';

class EditProfile extends StatefulWidget {
  final String name;
  final String photoURL;
  final String selectedLanguageName;
  const EditProfile({
    this.name,
    this.photoURL,
    this.selectedLanguageName,
    Key key,
  }) : super(key: key);
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final aut.FirebaseAuth auth = aut.FirebaseAuth.instance;

  String selectedLanguageName = "Set Your Language";
  bool isLanguageSet = true;
  TextEditingController _nameController = TextEditingController();
  String photoURL;

  @override
  void initState() {
    _nameController.text = widget.name;
    selectedLanguageName = widget.selectedLanguageName;
    photoURL = widget.photoURL;
    super.initState();
  }

  void updateInfo() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser.uid)
        .update({
      "displayName": _nameController.text,
      "nativeLanguage": selectedLanguageName,
      "photoURL": photoURL,
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile Settings"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Stack(children: [
                Container(
                  width: 150,
                  height: 150,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(photoURL),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 120.0, left: 45),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Edit"),
                  ),
                )
              ]),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(label: Text("Nickname")),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          (selectedLanguageName == "Set Your Language")
                              ? Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 15),
                                  child: Icon(
                                    Icons.flag_outlined,
                                    color: Theme.of(context).hintColor,
                                  ),
                                )
                              : Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 15),
                                  child: Icon(
                                    Icons.flag,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                          (selectedLanguageName == "Set Your Language")
                              ? Text(selectedLanguageName,
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Theme.of(context).hintColor))
                              : Text(selectedLanguageName,
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black)),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).hintColor,
                          )
                        ],
                      ),
                      (!isLanguageSet)
                          ? Divider(
                              color: Colors.red[600],
                              thickness: 1,
                            )
                          : Container(),
                      (!isLanguageSet)
                          ? Text(
                              "Please set your native language",
                              style: TextStyle(color: Colors.red[700]),
                            )
                          : Container(),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 6,
                      primary: Colors.white,
                      minimumSize: Size(_size.width * .9, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                            title: Text("Set your native language"),
                          ),
                          body: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: languages.length - 1,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                    //+1 to skip automatically
                                    languages[index + 1]["name"]),
                                trailing: (selectedLanguageName ==
                                        languages[index + 1]["name"])
                                    ? Icon(Icons.done)
                                    : Text(''),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  setState(
                                    () {
                                      selectedLanguageName =
                                          languages[index + 1]["name"];
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton.icon(
                      onPressed: () {
                        updateInfo();
                      },
                      label: Text(
                        "Save",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      icon: Icon(
                        Icons.save_alt,
                        color: Colors.black,
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(200, 50),
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
