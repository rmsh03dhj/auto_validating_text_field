import 'package:flutter/material.dart';

import 'package:auto_validating_text_field/auto_validating_text_field.dart';
import 'Validators.dart';
import 'sign_up_dto.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();
  TextEditingController _emailAddressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  FocusNode _fullNameFocusNode = FocusNode();
  FocusNode _phoneNumberFocusNode = FocusNode();
  FocusNode _emailAddressFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  SignUpDto signUpDetails;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Container(
                width: 250,
                child: AutoValidatingTextFormField(
                  decoration: InputDecoration(
                    hintText: "Full Name",
                  ),
                  focusNode: _fullNameFocusNode,
                  controller: _fullNameController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  validators: [
                    Validators.required(),
                    Validators.pattern("^[a-zA-Z ]*\$",
                        errorText:
                        "Full Name cannot contains special characters."),
                  ],
                  onFieldSubmitted: (_) {
                    fieldFocusChange(
                        context, _fullNameFocusNode, _phoneNumberFocusNode);
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 250,
                child: AutoValidatingTextFormField(
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                  ),
                  controller: _phoneNoController,
                  focusNode: _phoneNumberFocusNode,
                  keyboardType: TextInputType.number,
                  validators: [
                    Validators.required(),
                    Validators.validLength(5,
                        errorText: "Phone number should be of length 5"),
                  ],
                  onFieldSubmitted: (_) {
                    fieldFocusChange(
                        context, _phoneNumberFocusNode, _emailAddressFocusNode);
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 250,
                child: AutoValidatingTextFormField(
                  decoration: InputDecoration(
                    hintText: "Email Addres",
                  ),
                  focusNode: _emailAddressFocusNode,
                  controller: _emailAddressController,
                  keyboardType: TextInputType.emailAddress,
                  validators: [
                    Validators.required(),
                    Validators.pattern(
                        "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$",
                        errorText: "Invalid email address."),
                  ],
                  onFieldSubmitted: (_) {
                    fieldFocusChange(
                        context, _emailAddressFocusNode, _passwordFocusNode);
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 250,
                child: AutoValidatingTextFormField(
                  decoration: InputDecoration(
                    hintText: "Password",
                  ),
                  obscureText: true,
                  focusNode: _passwordFocusNode,
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  validators: [
                    Validators.required(),
                  ],
                  onFieldSubmitted: (_) {
                    fieldFocusChange(
                        context, _passwordFocusNode, _confirmPasswordFocusNode);
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 250,
                child: AutoValidatingTextFormField(
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                  ),
                  keyboardType: TextInputType.text,
                  focusNode: _confirmPasswordFocusNode,
                  controller: _confirmPasswordController,
                  obscureText: true,
                  validators: [
                    Validators.required(),
                    Validators.matches(
                      _passwordController,
                    )
                  ],
                ),
              ),
              SizedBox(height: 40),
              RaisedButton(
                child: Text(
                  "Sign Up",
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        content: Text(
                          "Signing up",
                        ),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

void fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}


