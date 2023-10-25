import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final IconButton? suffixIcon;
  final bool isPassword;
  final Function(String)? onChanged;
  final Function? onSubmit;
  final bool isEnabled;
  final int maxLines;
  final TextCapitalization capitalization;
  final Icon? prefixIcon;
  final double prefixSize;
  final bool divider;
  final TextAlign textAlign;
  final bool isAmount;
  final bool isNumber;
  final bool obscureText;
  final bool showTitle;
  final Color? fillColor;
  final OutlineInputBorder? border;
  final OutlineInputBorder? activeBorder;
  final OutlineInputBorder? enabledBorder;

  CustomTextField({
    this.hintText = 'Write something...',
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.isEnabled = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.onSubmit,
    this.border,
    this.activeBorder,
    this.enabledBorder,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.capitalization = TextCapitalization.none,
    this.isPassword = false,
    this.prefixSize = 10,
    this.divider = false,
    this.textAlign = TextAlign.start,
    this.isAmount = false,
    this.isNumber = false,
    this.obscureText = false,
    this.showTitle = false,
    this.fillColor,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.showTitle
            ? Text(widget.hintText,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ))
            : SizedBox(),
        SizedBox(height: widget.showTitle ? 5 : 0),
        TextField(
          maxLines: widget.maxLines,
          controller: widget.controller,
          focusNode: widget.focusNode,
          textAlign: widget.textAlign,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
          textInputAction: widget.nextFocus == null
              ? TextInputAction.done
              : widget.inputAction,
          keyboardType:
              widget.isAmount ? TextInputType.number : widget.inputType,
          cursorColor: Theme.of(context).primaryColor,
          textCapitalization: widget.capitalization,
          enabled: widget.isEnabled,
          autofocus: false,
          obscureText: widget.isPassword ? widget.obscureText : false,
          inputFormatters: widget.inputType == TextInputType.phone
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                ]
              : widget.isAmount
                  ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))]
                  : widget.isNumber
                      ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))]
                      : null,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8),
            border: widget.border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(style: BorderStyle.none, width: 0),
                ),
            focusedBorder: widget.activeBorder,
            enabledBorder: widget.enabledBorder,
            isDense: true,
            hintText: widget.hintText,
            fillColor: widget.fillColor ?? Theme.of(context).cardColor,
            hintStyle: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Theme.of(context).hintColor),
            filled: true,
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: widget.prefixSize),
                    child: widget.prefixIcon,
                  )
                : null,
            suffixIcon: widget.suffixIcon ?? null,
          ),
          onSubmitted: (text) => widget.nextFocus != null
              ? FocusScope.of(context).requestFocus(widget.nextFocus)
              : widget.onSubmit != null
                  ? widget.onSubmit!(text)
                  : null,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
