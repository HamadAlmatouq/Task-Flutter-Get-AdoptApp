import 'dart:async';
import 'dart:io';
import 'package:adopt_app/models/pet.dart';
import 'package:adopt_app/providers/pets_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

final _picker = ImagePicker();

class AddPetForm extends StatefulWidget {
  const AddPetForm({Key? key}) : super(key: key);

  @override
  State<AddPetForm> createState() => _AddPetFormState();
}

class _AddPetFormState extends State<AddPetForm> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  int age = 0;
  String gender = "";
  var _image;
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Name',
            ),
            onSaved: (value) {
              name = value!;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Please fill this field!";
              } else {
                return null;
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Age',
            ),
            onSaved: (value) {
              age = int.parse(value!);
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Please fill this field!";
              } else if (int.tryParse(value) == null) {
                return "please enter a number";
              }
              return null;
            },
            maxLines: null,
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Gender',
            ),
            onSaved: (value) {
              gender = value!;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Please fill this field!";
              } else if (value != "Male" && value != "Female") {
                return "Please enter either Male or Female";
              }
              return null;
            },
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    _image = File(image!.path);
                  });
                },
                child: Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(color: Colors.blue[20]),
                  child: Container(
                    width: 200,
                    height: 200,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text("Image"),
              )
            ],
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Provider.of<PetsProvider>(context, listen: false).createPet(
                      Pet(name: name, image: _image, age: age, gender: gender));
                  GoRouter.of(context).pop();
                }
              },
              child: const Text("Add"),
            ),
          ),
        ],
      ),
    );
  }
}
