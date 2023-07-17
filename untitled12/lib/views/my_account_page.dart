import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:untitled12/controllers/user_controller.dart';

import '../models/user.dart';

class MyAccountPage extends StatelessWidget {
  MyAccountPage({Key? key}) : super(key: key);

  final _controllerUsername = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerCity = TextEditingController();
  final _controllerCountry = TextEditingController();
  final _controllerFirstName = TextEditingController();
  final _controllerLastName = TextEditingController();
  final _controllerPhone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit profile"),
      ),
      body: FutureBuilder(
        future: UserController().getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _controllerUsername.text = snapshot.data!.username;
            _controllerEmail.text = snapshot.data!.email;
            _controllerCity.text = snapshot.data!.city;
            _controllerCountry.text = snapshot.data!.country;
            _controllerFirstName.text = snapshot.data!.firstName;
            _controllerLastName.text = snapshot.data!.lastName;
            _controllerPhone.text = snapshot.data!.phone;
            return SingleChildScrollView(


              child: Container(


                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(

                    children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.blue,
                              size: 70,
                            ),
                          ],
                        ),



                      TextFormField(
                        controller: _controllerUsername,
                        validator: (value) {
                          if (value == null || value.length < 2) {
                            return "The username is required";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.account_circle_rounded),
                          labelText: "Username",
                        ),
                      ),
                      TextFormField(
                        controller: _controllerEmail,
                        validator: (value) {
                          if (!EmailValidator.validate(value!)) {
                            return "The email must be correct";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.email),
                          labelText: "Email",
                        ),
                      ),
                      TextFormField(
                        controller: _controllerPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return null;
                          }
                          if (value.length < 7) {
                            return "The password must be strong";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.password),
                          labelText: "Password",
                        ),
                      ),
                      TextFormField(
                        controller: _controllerCity,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.location_city),
                          labelText: "City",
                        ),
                      ),
                      TextFormField(
                        controller: _controllerCountry,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.public),
                          labelText: "Country",
                        ),
                      ),
                      TextFormField(
                        controller: _controllerFirstName,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.person),
                          labelText: "First Name",
                        ),
                      ),
                      TextFormField(
                        controller: _controllerLastName,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.person),
                          labelText: "Last Name",
                        ),
                      ),
                      TextFormField(
                        controller: _controllerPhone,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.phone),
                          labelText: "Phone",
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _handleSubmitAction(context);
                          },
                          child: const Text("Submit"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Error: ${snapshot.error}",
                    style: TextStyle(color: Colors.red),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _retryRequest();
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  void _handleSubmitAction(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: "Loading");
      UserController().update(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
        username: _controllerUsername.text,
        city: _controllerCity.text,
        country: _controllerCountry.text,
        firstName: _controllerFirstName.text,
        lastName: _controllerLastName.text,
        phone: _controllerPhone.text,
      ).then((value) {
        EasyLoading.dismiss();
        EasyLoading.showSuccess("Done");
        Navigator.pop(context); // Navigate back to the previous screen
      }).catchError((ex) {
        EasyLoading.dismiss();
        EasyLoading.showError(ex.toString());
      });
    }
  }

  void _retryRequest() {
    UserController().getUser().then((user) {
      _controllerUsername.text = user.username;
      _controllerEmail.text = user.email;
      _controllerCity.text = user.city;
      _controllerCountry.text = user.country;
      _controllerFirstName.text = user.firstName;
      _controllerLastName.text = user.lastName;
      _controllerPhone.text = user.phone;
    }).catchError((error) {
      EasyLoading.showError(error.toString());
    });
  }
}