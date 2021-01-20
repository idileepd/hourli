import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:hourli/models/user_deatils_model.dart';

class UserRankCardComponent extends StatefulWidget {
  const UserRankCardComponent({
    Key key,
    @required this.showContent,
    @required this.userDetailsModel,
    @required this.rank,
  }) : super(key: key);

  final UserDetailsModel userDetailsModel;
  final bool showContent;
  final int rank;

  @override
  _UserRankCardComponentState createState() => _UserRankCardComponentState();
}

class _UserRankCardComponentState extends State<UserRankCardComponent> {
  bool showContent;
  @override
  void initState() {
    showContent = widget.showContent;
    super.initState();
  }

  void toggleShowContent() {
    setState(() {
      showContent = !showContent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(16),
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                showContent = !showContent;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.userDetailsModel.photoUrl),
                  ),
                  title: Text('${widget.userDetailsModel.displayName}'),
                  subtitle: Text(
                      "Today Score: ${NumberFormat.compact().format(widget.userDetailsModel.today.todayScore)}"),
                  trailing: Text(widget.rank != 0 ? "#${widget.rank}" : ''),
                ),
              ),
            ),
          ),

          /// show or hide content.
          if (showContent == true)
            Container(
              margin: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed('/hourlieUserDetailsPage',
                      arguments: widget.userDetailsModel.uid);
                },
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '@${widget.userDetailsModel.userName}',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        Text(
                          'Current Task:- ${widget.userDetailsModel.currentTask.taskName ?? 'No task'}',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        Text(
                          'Status:- ${widget.userDetailsModel.currentTask.status ?? 'Idle'}',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        Text(
                          'Started At:- ${widget.userDetailsModel.currentTask?.startedOn != null ? DateFormat.jm().format(widget.userDetailsModel.currentTask.startedOn.toDate()) : 'Idle'}',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        Text(
                          'Ends At:- ${widget.userDetailsModel.currentTask?.endsOn != null ? DateFormat.jm().format(widget.userDetailsModel.currentTask.endsOn.toDate()) : 'Idle'}',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        Text(
                          'Ended At:- ${widget.userDetailsModel.currentTask?.endedAt != null ? DateFormat.jm().format(widget.userDetailsModel.currentTask.endedAt.toDate()) : 'Loading...'}',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      LineAwesomeIcons.arrow_circle_right,
                      size: 25.0,
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
