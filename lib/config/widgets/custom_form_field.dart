
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final bool? isPassword;
  final String? hint;
  final bool? enabled;
  final int? maxLines, minLines, maxLength;
  final String? obscuringCharacter, value;
  final String? Function(String?)? onValidate;
  final void Function(String?)? onChanged, onFieldSubmitted, onSaved;
  final void Function()? onEditingComplete, onTap;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixWidget, prefixIcon;
  final IconData? icon;
  final TextInputAction? action;
  final FocusNode? focusNode;
  final Color? color;

  const CustomTextField({
    super.key,
    this.controller,
    this.isPassword,
    this.hint,
    this.enabled,
    this.obscuringCharacter,
    this.value,
    this.onValidate,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.onSaved,
    this.onTap,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.inputFormatters,
    this.suffixWidget,
    this.icon,
    this.prefixIcon,
    this.action,
    this.focusNode,
    this.color,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return TextFormField(
      cursorErrorColor: widget.color,
      controller: widget.controller,
      initialValue: widget.value,
      validator: widget.onValidate,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      onTap: widget.onTap,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      obscureText: widget.isPassword ?? false ? obscureText : false,
      obscuringCharacter: '*',
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      style: theme.textTheme.bodySmall?.copyWith(
          color: Colors.black
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: widget.action ?? TextInputAction.next,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        suffixIcon: widget.isPassword ?? false
            ? InkWell(
          onTap: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
        )
            : widget.suffixWidget,
        prefixIcon: widget.prefixIcon,
        hintText: widget.hint,
        hintStyle: const TextStyle(
          fontSize: 14,

        ),
        counterText: "",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black12,
            width: 1,
          ),
        ),
        // suffix: isPass widget.suffixWidget,
        contentPadding: const EdgeInsets.only(left: 15, right: 15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black12,
            width: 1,
          ),
        ),
      ),
    );
  }
}
