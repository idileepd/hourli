import 'package:flutter/material.dart';
import 'package:hourli/global_module/utils/hl_colors.dart';

enum MessageType { sent, received, achievement }

class FlatChatMessage extends StatelessWidget {
  final String message;
  final MessageType messageType;
  final Color backgroundColor;
  final Color textColor;
  final String time;
  final bool showTime;
  final double maxWidth;
  final double minWidth;

  FlatChatMessage(
      {this.message,
      this.messageType,
      this.backgroundColor,
      this.textColor,
      this.time,
      this.showTime,
      this.minWidth,
      this.maxWidth});

  CrossAxisAlignment messageAlignment() {
    if (messageType == null || messageType == MessageType.received) {
      return CrossAxisAlignment.start;
    } else if (messageType == MessageType.achievement) {
      return CrossAxisAlignment.center;
    } else {
      return CrossAxisAlignment.end;
    }
  }

  double topLeftRadius() {
    if (messageType == null || messageType == MessageType.received) {
      return 0.0;
    } else {
      return 12.0;
    }
  }

  double topRightRadius() {
    if (messageType == null || messageType == MessageType.received) {
      return 12.0;
    } else {
      return 0.0;
    }
  }

  Color messageBgColor(BuildContext context) {
    if (messageType == null || messageType == MessageType.received) {
      return Theme.of(context).primaryColor;
    } else {
      return Theme.of(context).primaryColorDark.withOpacity(0.1);
    }
  }

  Color messageTextColor(BuildContext context) {
    if (messageType == null || messageType == MessageType.received) {
      return Colors.white;
    } else {
      return Theme.of(context).primaryColorDark;
    }
  }

  Text messageTime() {
    if (showTime != null && showTime == true) {
      return Text(
        time ?? "Time",
        style: TextStyle(
          fontSize: 12.0,
          color: Color(0xFF666666),
        ),
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 24.0,
      ),
      child: Column(
        crossAxisAlignment: messageAlignment(),
        children: [
          messageType == MessageType.achievement
              ? _buildAchievementMsg(context)
              : _buildMsgSendRecvd(context),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 12.0,
            ),
            child: messageTime(),
          ),
        ],
      ),
    );
  }

  Container _buildAchievementMsg(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          minWidth: minWidth ?? 100.0, maxWidth: maxWidth ?? 250.0),
      decoration: BoxDecoration(
        color: HLColors.secondaryGradient.colors[1],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 16.0,
      ),
      child: Text(
        message ?? "Message here...",
        style: TextStyle(
          color: textColor ?? messageTextColor(context),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Container _buildMsgSendRecvd(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          minWidth: minWidth ?? 100.0, maxWidth: maxWidth ?? 250.0),
      decoration: BoxDecoration(
        color: backgroundColor ?? messageBgColor(context),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeftRadius()),
          topRight: Radius.circular(topRightRadius()),
          bottomLeft: Radius.circular(12.0),
          bottomRight: Radius.circular(12.0),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 16.0,
      ),
      child: Text(
        message ?? "Message here...",
        style: TextStyle(
          color: textColor ?? messageTextColor(context),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
