import 'package:flutter/material.dart';
import 'package:school_app/app/size_extensions.dart';
import 'package:school_app/app/theme/app_colours.dart';

class CustomTextField extends StatefulWidget {
  TextEditingController textController;
  String hint;
  IconData? prefixIcon;
  IconData? suffixIcon;
  TextInputType? type;
  int? maxLines;
  bool? disable;
  int? maxLength;
  double? width;
  FocusNode? focus;
  List<FocusNode>? focusList;
  ValueChanged<String>? onTextChanged;
  Function()? onTap;
  Widget? prefix;
  Widget? suffix;
  Color? prefixIconColor;
  Color? suffixIconColor;
  String? Function(String?)? validator;
  Function(PointerDownEvent)? onTapOutside;
  CustomTextField(
      {super.key,
      required this.textController,
      required this.hint,
      this.prefixIcon,
      this.suffixIcon,
      this.type,
      this.maxLines,
      this.disable,
      this.maxLength,
      this.focus,
      this.onTap,
      this.width,
      this.prefix,
      this.suffix,
      this.validator,
      this.suffixIconColor,
      this.prefixIconColor,
      this.onTapOutside,
      this.onTextChanged});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Color focusColor = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? context.w,
      decoration: BoxDecoration(
        color:  AppColors.textFieldColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        validator: widget.validator,
        onTap: widget.onTap,
        onTapOutside: widget.onTapOutside,
        focusNode: widget.focus,
        maxLines: widget.maxLines ?? 1,
        obscureText:
            widget.type == TextInputType.visiblePassword ? true : false,
        controller: widget.textController,
        enabled: widget.disable ?? widget.disable,
        maxLength: widget.maxLength,
        keyboardType: widget.type ?? TextInputType.text,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontSize: 16,
            color: AppColors.textBlackColor,
            fontWeight: FontWeight.w600),
        onChanged: (text) {
          if (widget.onTextChanged != null) {
            widget.onTextChanged!(text);
          }
        },
        decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(
                fontFamily: "Gellix",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.2125,
                color: AppColors.textGreyColor),
            prefix: widget.prefix,
            suffix: widget.suffix,
            prefixIconColor: widget.textController.text.isNotEmpty
                ? Colors.black
                : const Color(0xffa8aaac),
            suffixIconColor: widget.suffixIconColor,
            prefixIcon: widget.prefixIcon == null
                ? null
                : Icon(
                    widget.prefixIcon,
                    size: 20,
                    color: widget.focus?.hasFocus ?? false
                        ? AppColors.primaryColor
                        : widget.textController.text.isNotEmpty
                            ? Colors.black
                            : const Color(0xffa8aaac),
                  ),
            suffixIcon: widget.suffixIcon == null
                ? null
                : Icon(
                    widget.suffixIcon,
                    size: 20,
                    color: widget.focus?.hasFocus ?? false
                        ? AppColors.primaryColor
                        : widget.textController.text.isNotEmpty
                            ? Colors.black
                            : const Color(0xffa8aaac),
                  ),
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1)),
            contentPadding: const EdgeInsets.only(
                left: 16, right: 16, top: 16, bottom: 16)),
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  PasswordTextField({
    super.key,
    required this.controller,
    required this.focus,
    required this.isObscureText,
    required this.hint,
    this.onTap,
    this.onTextChanged,
    this.validator,
  });

  TextEditingController controller;
  FocusNode focus;
  bool isObscureText;
  String hint;
  ValueChanged<String>? onTextChanged;
  Function()? onTap;
  String? Function(String?)? validator;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        validator: widget.validator,
        onTap: widget.onTap,
        onTextChanged: widget.onTextChanged,
        focus: widget.focus,
        type: widget.isObscureText
            ? TextInputType.visiblePassword
            : TextInputType.text,
        suffix: GestureDetector(
            onTap: () {
              widget.isObscureText = !widget.isObscureText;
              setState(() {});
            },
            child: widget.isObscureText
                ? Icon(Icons.password)
                    
                : Icon(
                    Icons.remove_red_eye,
                    color: widget.focus.hasFocus ?? false
                        ? AppColors.primaryColor
                        : widget.controller.text.isNotEmpty
                            ? Colors.black
                            : const Color(0xffa8aaac),
                  )),
        textController: widget.controller,
        hint: widget.hint);
  }
}
