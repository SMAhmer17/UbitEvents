import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  const RoundButton({super.key, 
  required this.title, required this.onTap, 
  required this.loading
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .24),
        child: Container(
          
          height: 50,
          decoration: BoxDecoration(
            
            color: Color.fromARGB(255, 255, 161, 11),
            borderRadius: BorderRadius.circular(24)
          ),
          
          child: Center(child:loading ? CircularProgressIndicator(strokeWidth: 3, color: Colors.white,) : Text(title , style :  TextStyle(color: Colors.white , fontWeight: FontWeight.w600 , fontSize: 16 )))
        ),
      ),
    );
  }
}