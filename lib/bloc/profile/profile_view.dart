import 'package:flutter/material.dart';

import '../../utils/common_text_widget.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CommonTextWidget(text: "Message")),);
  }
}
