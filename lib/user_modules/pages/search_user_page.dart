import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hourli/auth_module/controllers/auth_controller.dart';
import 'package:hourli/models/user_deatils_model.dart';
import 'package:hourli/user_modules/controllers/search_user_controller.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SearchUserPage extends StatefulWidget {
  @override
  _SearchUserPageState createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  String searchUserName = "";

  SearchUserController _searchUserController;
  final _authController = Get.find<AuthController>();

  @override
  void initState() {
    _searchUserController =
        Get.put<SearchUserController>(SearchUserController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: SafeArea(
        top: false,
        child: Scaffold(
          body: Column(
            children: [
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.fromLTRB(15.0, 35.0, 15.0, 10.0),
                child: Material(
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.white,
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                      contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                      hintText: 'Enter username',
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                    onChanged: (val) {
                      setState(() {
                        searchUserName = val;
                      });
                      // _searchUserController.searchUserNameStream = val;
                    },
                  ),
                ),
              ),
              _buildList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    return Expanded(
      child: StreamBuilder<List<UserDetailsModel>>(
        stream:
            _searchUserController.searchUsersStream(userName: searchUserName),
        builder: (context, snap) {
          if (snap.hasData) {
            return _buildListOfUsers(snap.data);
          } else {
            return Center(
              child: Container(
                width: 60.0,
                height: 60.0,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballPulse,
                  color: Colors.cyan,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildListOfUsers(List<UserDetailsModel> users) {
    //remove this user ! ;;
    users.removeWhere(
      (UserDetailsModel user) =>
          user.uid == _authController.firebaseUserStream.value.uid,
    );

    if (users.length == 0) {
      return Center(
        child: Text(
          searchUserName != ''
              ? 'No user found with this username'
              : 'Enter username of user',
        ),
      );
    }

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        UserDetailsModel user = users[index];
        // if (user.uid == Get.find<AuthController>().currentFirebaseUser.uid) {
        //   return Container();
        // }
        // debugPrint(user.toJson());
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(user.photoUrl),
          ),
          title: Text("@${user.userName}"),
          subtitle: Text('${user.displayName}'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            FocusScope.of(context).unfocus();
            Get.toNamed('/hourlieUserDetailsPage', arguments: user.uid);
          },
        );
      },
    );
  }
}
