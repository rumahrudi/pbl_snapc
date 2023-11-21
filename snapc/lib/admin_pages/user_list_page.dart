import 'package:flutter/material.dart';
import 'package:snapc/components/my_app_bar.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: MyAppBar(text: 'U S E R S'),
        backgroundColor: Colors.white,
        body: Scaffold());
  }
}
