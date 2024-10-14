import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;

  const ExpandableTextWidget({super.key, required this.text});

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  bool isExpanded = false;

  void _toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isExpanded ? _buildExpanded() : _buildCollapsed(),
      ],
    );
  }

  Widget _buildCollapsed() {
    const int maxLength = 46;
    bool isTextLong = widget.text.length > maxLength;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            isTextLong
                ? '${widget.text.substring(0, maxLength)}...'
                : widget.text,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        if (isTextLong)
          InkWell(
            onTap: _toggleExpand,
            child: Text(
              'more',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.blue,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildExpanded() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            widget.text,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        InkWell(
          onTap: _toggleExpand,
          child: Text(
            'less',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
