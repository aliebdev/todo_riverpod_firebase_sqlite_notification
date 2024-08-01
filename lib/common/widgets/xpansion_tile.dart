// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'titles.dart';

class XpansionTile extends StatelessWidget {
  const XpansionTile({
    super.key,
    required this.text,
    required this.text2,
    this.onExpansionChanged,
    this.trailing,
    required this.children,
  });

  final String text;
  final String text2;
  final void Function(bool expaned)? onExpansionChanged;
  final Widget? trailing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Constants.kBkLight,
        borderRadius: BorderRadius.circular(Constants.kRadius),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          clipBehavior: Clip.hardEdge,
          title: BottomTitles(
            text: text,
            text2: text2,
          ),
          tilePadding: EdgeInsets.zero,
          childrenPadding: EdgeInsets.zero,
          onExpansionChanged: onExpansionChanged,
          controlAffinity: ListTileControlAffinity.trailing,
          trailing: trailing,
          children: children,
        ),
      ),
    );
  }
}
