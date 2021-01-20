import 'package:flutter/material.dart';
import 'package:hourli/models/user_deatils_model.dart';

class LeaderBoardCardComponent extends StatelessWidget {
  final UserDetailsModel userDetailsModel;
  final void Function() onTap;
  const LeaderBoardCardComponent({Key key, this.userDetailsModel, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(userDetailsModel.photoUrl),
        backgroundColor: Colors.grey,
      ),
      title: Text("@${userDetailsModel.userName}"),
      subtitle: Text('${userDetailsModel.displayName}'),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: onTap,
    );
  }
}
