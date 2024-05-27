import 'package:flutter/material.dart';
import 'package:my_arena/config/constants/theme_constants.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onPress,
      this.endIcon = true,
      this.textColor,
      this.iconColor,
      this.subTitle,
      this.toggle})
      : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;
  final Color? iconColor;
  final String? subTitle;
  final Switch? toggle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(
          icon,
          color: iconColor ?? ThemeConstant.buttonColor,
          size: 25,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
          ),
          Text(
            subTitle ?? '',
            style: const TextStyle(
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}