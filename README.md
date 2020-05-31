# auto_validating_text_field

A Flutter package which validates text field dynamically as soon as value changes. You can give list of validators as shown below in example to dynamically validate according to the validators. 

## Usage
To use this package, add              

  **auto_validating_text_field** :  

as a dependency in your pubspec.yaml file.

## Example
   
    AutoValidatingTextFormField(
      decoration: InputDecoration(
      hintText: "Full Name",
      ),
      focusNode: _fullNameFocusNode,
      controller: _fullNameController,
      validators: [
        Validators.required(),
        Validators.pattern("^[a-zA-Z ]*\$",
          errorText: "Full Name cannot contains special characters."),
      ]
    );

Please see the example app of this package for a full example in 
https://github.com/rmsh03dhj/auto_validating_text_field/tree/master/example/lib.
