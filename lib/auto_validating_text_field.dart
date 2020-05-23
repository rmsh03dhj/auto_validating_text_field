library auto_validating_text_field;

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class AutoValidatingTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final List<FormFieldValidator> validators;
  final Key key;
  final FocusNode focusNode;

  final String initialValue;
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextDirection textDirection;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final autoFocus;
  final readOnly;
  final ToolbarOptions toolbarOptions;
  final showCursor;
  final obscureText;
  final autoCorrect;
  final SmartDashesType smartDashesType;
  final SmartQuotesType smartQuotesType;
  final enableSuggestions;
  final autoValidate;
  final maxLengthEnforced;
  final int maxLines;
  final int minLines;
  final expands;
  final int maxLength;
  final ValueChanged<String> onChanged;
  final GestureTapCallback onTap;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onFieldSubmitted;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final List<TextInputFormatter> inputFormatters;
  final enabled;
  final double cursorWidth;
  final Radius cursorRadius;
  final Color cursorColor;
  final Brightness keyboardAppearance;
  final EdgeInsets scrollPadding;
  final enableInteractiveSelection;
  final InputCounterWidgetBuilder buildCounter;
  final ScrollPhysics scrollPhysics;

  AutoValidatingTextFormField({
    this.controller,
    this.validators = const [],
    this.key,
    this.focusNode,
    this.initialValue,
    this.decoration = const InputDecoration(),
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.autoFocus = false,
    this.readOnly = false,
    this.toolbarOptions,
    this.showCursor,
    this.obscureText = false,
    this.autoCorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.autoValidate = false,
    this.maxLengthEnforced = true,
    this.expands = false,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.enabled = true,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.buildCounter,
    this.scrollPhysics,
    this.maxLines = 1,
    this.minLines,
  });

  @override
  _AutoValidatingTextFormFieldState createState() =>
      _AutoValidatingTextFormFieldState();
}

class _AutoValidatingTextFormFieldState
    extends State<AutoValidatingTextFormField> {
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  bool _autoValidate = false;
  final _validationRequired = BehaviorSubject<bool>(seedValue: false);

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      if (widget.controller.text.isNotEmpty) {
        _validationRequired.add(true);
      }
      if (_validationRequired.value && widget.focusNode.hasFocus) {
        if (!_fieldKey.currentState.validate()) {
          setState(() {
            _autoValidate = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _fieldKey,
      focusNode: widget.focusNode,
      autovalidate: _autoValidate,
      controller: widget.controller,
      validator: (val) {
        for (int i = 0; i < widget.validators.length; i++) {
          if (widget.validators[i](val) != null)
            return widget.validators[i](val);
        }
        return null;
      },
      decoration: widget.decoration,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      style: widget.style,
      strutStyle: widget.strutStyle,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      textDirection: widget.textDirection,
      textCapitalization: widget.textCapitalization,
      autofocus: widget.autoFocus,
      toolbarOptions: widget.toolbarOptions,
      readOnly: widget.readOnly,
      showCursor: widget.showCursor,
      obscureText: widget.obscureText,
      autocorrect: widget.autoCorrect,
      smartDashesType: widget.smartDashesType,
      smartQuotesType: widget.smartQuotesType,
      enableSuggestions: widget.enableSuggestions,
      maxLengthEnforced: widget.maxLengthEnforced,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      expands: widget.expands,
      maxLength: widget.maxLength,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      cursorWidth: widget.cursorWidth,
      cursorRadius: widget.cursorRadius,
      cursorColor: widget.cursorColor,
      scrollPadding: widget.scrollPadding,
      scrollPhysics: widget.scrollPhysics,
      keyboardAppearance: widget.keyboardAppearance,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      buildCounter: widget.buildCounter,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _validationRequired.close();
  }
}
