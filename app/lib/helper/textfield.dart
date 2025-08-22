import 'package:app/helper/fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final VoidCallback? iconButtonOnTap; // <-- Add this line
  final IconData? iconButtonIcon;      // <-- Add this line

  const CustomTextField({
    super.key,
    required this.label,
    required this.icon,
    this.isPassword = false,
    required this.controller,
    required this.hintText,
    this.validator,
    this.onChanged,
    this.iconButtonOnTap,   // <-- Add this line
    this.iconButtonIcon,    // <-- Add this line
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          
          
          cursorColor: Colors.black,
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          validator: widget.validator,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
      
            hintText: widget.hintText,
            hintStyle: CustomFonts.texfield,
            prefixIcon: Icon(widget.icon, color: Colors.white),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      
                    },
                  )
                : widget.iconButtonOnTap != null && widget.iconButtonIcon != null
                    ? IconButton(
                        icon: Icon(widget.iconButtonIcon, color: Colors.white),
                        onPressed: widget.iconButtonOnTap,
                      )
                    : null,
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            filled: true,
            fillColor: Colors.black,
            border: OutlineInputBorder(
              
              borderRadius: BorderRadius.circular(16),
              
               
              borderSide: BorderSide(color: Colors.blue)

            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.blue,width: 2),
              
            ),
            
            
            
            
             

            
          ),
          style: GoogleFonts.poppins(fontSize:15 ,color: Colors.white),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
