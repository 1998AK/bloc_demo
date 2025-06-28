import 'package:bloc_demo/utils/screen_width_dynamic.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';


class TextFormFieldStyle{
  static InputDecoration commonStyle({String? hindText,Color? hindColor,double? hindFontSize,String? text}){
    return InputDecoration(
      labelText: text,
      labelStyle: textFormFieldStyle.copyWith(fontSize: 14,color: blackColor),
      hintText: hindText,
      fillColor: borderColor,
      hintStyle: GoogleFonts.montserrat(
          fontSize: hindFontSize ?? 16,
          fontWeight: FontWeight.w500,
          color: hindColor ?? blackColor
      ),
      prefix: SizedBox(width: 10),
      border:OutlineInputBorder(
        borderSide: BorderSide(color: blackColor, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: blackColor, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: blackColor, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: blackColor, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),

    );
  }

  static InputDecoration commonStyleApp({
    String? hindText,
    Color? hindColor,
    double? hindFontSize,
    String? text,
    Widget? prefix,
  }) {
    return InputDecoration(
      labelText: text,
      // isDense: true,
      labelStyle: textFormFieldStyle.copyWith(fontSize: sizeOfReturnValue(size: 14), color: blackColor),
      hintText: hindText,
      fillColor: borderColor,
      contentPadding: EdgeInsets.symmetric(vertical: sizeOfReturnValue(size: 13)),
      hintStyle: GoogleFonts.montserrat(
        fontSize: sizeOfReturnValue(size: hindFontSize ?? 14),
        fontWeight: FontWeight.w500,
        color: hindColor ?? inputFieldHintColor,
      ),

      prefixIcon: prefix,
      prefixIconConstraints: BoxConstraints(
        minHeight: sizeOfReturnValue(size: 20),
        minWidth: sizeOfReturnValue(size: 20),
      ),

      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: inputFieldBorderColor),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: inputFieldBorderColor),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: inputFieldBorderColor),
      ),
      disabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: inputFieldBorderColor),
      ),
    );
  }

}

TextStyle textFormFieldStyle = GoogleFonts.montserrat(
    fontSize: sizeOfReturnValue(size: 14),
    fontWeight: FontWeight.w500,
    color: blackColor
);

class Validation {

  static String? validationIsEmpty(String val) {
    if (val.isEmpty) {
      return 'This is a required field.';
    }
    else {
      return null;
    }
  }
}

class SmartTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool autofocus;
  final bool obscureText;
  final bool? autocorrect;
  final bool enableSuggestions;
  final int maxLines;
  final int? minLines;
  final bool expands;
  final bool readOnly;
  // final ToolbarOptions? toolbarOptions;
  final bool? showCursor;
  final int? maxLength;
  final bool maxLengthEnforced;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final double? cursorWidth;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets? scrollPadding;
  final bool? enableInteractiveSelection;
  final DragStartBehavior? dragStartBehavior;
  final GestureTapCallback? onTap;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final ScrollController? scrollController;
  final FocusNode? nextNode;
  final Iterable<String>? autofillHints;
  final String? hintText;
  final VoidCallback? onCancel;
  final FormFieldValidator<String>? validator;

  /// Icon [Icons.visibility] at right of text field
  /// If true then [Icons.visibility]
  /// And if false then [Icons.visibility_off]
  /// Click icon to change show or hide password
  final bool showEyeIcon;

  /// Icon [Icons.cancel] at right of text field
  /// When text is not empty then icon will be shown
  /// And if text is empty then icon will be hide
  final bool showCancelIcon;

  const SmartTextField({super.key,
    this.controller,
    this.focusNode,
    this.decoration,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.readOnly = false,
    // this.toolbarOptions,
    this.showCursor,
    this.autofocus = false,
    this.obscureText = false,
    this.autocorrect = false,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforced = true,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding,
    this.dragStartBehavior,
    this.enableInteractiveSelection,
    this.onTap,
    this.buildCounter,
    this.scrollController,
    this.scrollPhysics,
    this.nextNode,
    this.autofillHints,
    this.hintText,
    this.showCancelIcon = false,
    this.onCancel,
    this.showEyeIcon = false,
    this.validator,
  })  : assert(
  !(showEyeIcon == showCancelIcon) || (!showEyeIcon || !showCancelIcon),
  'only one of them',
  );

  @override
  State<SmartTextField> createState() => _SmartTextFieldState();
}

class _SmartTextFieldState extends State<SmartTextField>
    with SingleTickerProviderStateMixin {
  final _defaultTextController = TextEditingController();

  TextEditingController get controller =>
      widget.controller ?? _defaultTextController;

  FocusNode? get focusNode => widget.focusNode;

  TextInputType? get keyboardType => widget.keyboardType;

  TextInputAction? get textInputAction => widget.textInputAction;

  TextCapitalization get textCapitalization => widget.textCapitalization;

  TextStyle? get style => widget.style;

  StrutStyle? get strutStyle => widget.strutStyle;

  TextAlign get textAlign => widget.textAlign;

  TextAlignVertical? get textAlignVertical => widget.textAlignVertical;

  TextDirection? get textDirection => widget.textDirection;

  bool get autofocus => widget.autofocus;

  bool get obscureText => widget.obscureText;

  bool? get autocorrect => widget.autocorrect;

  bool get enableSuggestions => widget.enableSuggestions;

  bool get expands => widget.expands;

  bool get readOnly => widget.readOnly;

  // ToolbarOptions? get toolbarOptions => widget.toolbarOptions;

  bool? get showCursor => widget.showCursor;

  int? get maxLength => widget.maxLength;

  bool get maxLengthEnforced => widget.maxLengthEnforced;

  ValueChanged<String>? get onChanged => widget.onChanged;

  VoidCallback? get onEditingComplete => widget.onEditingComplete;

  ValueChanged<String>? get onSubmitted => widget.onSubmitted;

  List<TextInputFormatter>? get inputFormatters => widget.inputFormatters;

  bool? get enabled => widget.enabled;

  double? get cursorWidth => widget.cursorWidth;

  Radius? get cursorRadius => widget.cursorRadius;

  Brightness? get keyboardAppearance => widget.keyboardAppearance;

  EdgeInsets? get scrollPadding => widget.scrollPadding;

  bool? get enableInteractiveSelection => widget.enableInteractiveSelection;

  DragStartBehavior? get dragStartBehavior => widget.dragStartBehavior;

  GestureTapCallback? get onTap => widget.onTap;

  InputCounterWidgetBuilder? get buildCounter => widget.buildCounter;

  ScrollPhysics? get scrollPhysics => widget.scrollPhysics;

  ScrollController? get scrollController => widget.scrollController;

  InputDecoration? get decoration => widget.decoration;

  FocusNode? get nextNode => widget.nextNode;

  Iterable<String>? get autofillHints => widget.autofillHints;

  int get maxLines => widget.maxLines;

  int? get minLines => widget.minLines;

  Color? get cursorColor => widget.cursorColor;

  bool get showCancelIcon => widget.showCancelIcon;

  bool get showEyeIcon => widget.showEyeIcon;

  bool _showCancelIconInState = false;

  bool? _showPasswordInState;

  @override
  void initState() {
    super.initState();
    controller.addListener(handleHideCancelIcon);
    if (showEyeIcon) {
      _showPasswordInState = true;
    }
  }

  void handleHideCancelIcon() {
    if (controller.text.isEmpty && showCancelIcon) {
      if (_showCancelIconInState) {
        setState(() {
          _showCancelIconInState = false;
        });
      }
    } else {
      if (!_showCancelIconInState && showCancelIcon) {
        setState(() {
          _showCancelIconInState = true;
        });
      }
    }
  }

  void handleHidePassword() {
    if (showEyeIcon) {
      setState(() {
        _showPasswordInState = !_showPasswordInState!;
      });
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: controller,
      focusNode: focusNode,
      decoration: decoration != null
          ? decoration!.copyWith(
        suffixIcon: buildSuffixIconDecoration(),
      )
          : const InputDecoration(),
      keyboardType: keyboardType,
      textInputAction: nextNode != null
          ? TextInputAction.next
          : (textInputAction ?? TextInputAction.done),
      textCapitalization: textCapitalization,
      style: style,
      strutStyle: strutStyle,
      textAlign: TextAlign.start,
      textAlignVertical: textAlignVertical,
      textDirection: textDirection,
      readOnly: widget.readOnly,
      // toolbarOptions: toolbarOptions,
      showCursor: showCursor,
      autofocus: autofocus,
      obscureText: _showPasswordInState ?? obscureText,
      autocorrect: autocorrect ?? true,
      enableSuggestions: enableSuggestions,
      maxLines: maxLines,
      minLines: minLines,
      expands: expands,
      maxLength: maxLength,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      // onSubmitted: nextNode == null
      //     ? onSubmitted
      //     : (value) {
      //         FocusScope.of(context).requestFocus(nextNode);
      //         if (onSubmitted != null) {
      //           onSubmitted!(value);
      //         }
      //       },
      inputFormatters: inputFormatters,
      autofillHints: autofillHints,
      enabled: enabled,
      cursorWidth: cursorWidth ?? 2.0,
      cursorRadius: cursorRadius,
      cursorColor: cursorColor,
      keyboardAppearance: keyboardAppearance,
      scrollPadding: scrollPadding ?? const EdgeInsets.all(20.0),
      dragStartBehavior: dragStartBehavior ?? DragStartBehavior.start,
      enableInteractiveSelection: enableInteractiveSelection ?? true,
      onTap: onTap,
      buildCounter: buildCounter,
      scrollController: scrollController,
      scrollPhysics: scrollPhysics,

    );
  }

  Widget? buildSuffixIconDecoration() {
    if (_showCancelIconInState) {
      return buildCloseIcon();
    } else if (showEyeIcon) {
      if (_showPasswordInState!) {
        return buildEyeShowIcon();
      }
      return buildEyeHideIcon();
    }
    return decoration!.suffixIcon;
  }

  Widget buildCloseIcon() {
    return GestureDetector(
      onTap: () {
        if(widget.readOnly == false){
          controller.clear();
          widget.onCancel?.call();
        }
      },
      child: Container(
        color: Colors.transparent,
        child: Icon(
          Icons.cancel,
          size: sizeOfReturnValue(size: 16),
          // color: Colors.grey,
        ),
      ),
    );
  }

  Widget buildEyeShowIcon() {
    return GestureDetector(
      onTap: handleHidePassword,
      child: Container(
        color: Colors.transparent,
        child: Icon(
          Icons.visibility_off,
          size: sizeOfReturnValue(size: 16),
          // color: Colors.grey,
        ),
      ),
    );
  }

  Widget buildEyeHideIcon() {
    return GestureDetector(
      onTap: handleHidePassword,
      child: Container(
        color: Colors.transparent,
        child: Icon(
          Icons.visibility,
          size: sizeOfReturnValue(size: 16),
          // color: Colors.grey,
        ),
      ),
    );
  }
}
