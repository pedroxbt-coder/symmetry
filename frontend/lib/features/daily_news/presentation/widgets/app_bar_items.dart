import 'package:flutter/material.dart';

class AppBarItems extends StatelessWidget {
  final bool user;
  final BuildContext context;

  const AppBarItems({
    Key? key,
    required this.user,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return user
        ? Row(
            children: [
              GestureDetector(
                onTap: () => _onShowSavedArticlesViewTapped(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Icon(Icons.bookmark, color: Colors.black),
                ),
              ),
              GestureDetector(
                onTap: () => _onShowMyArticlesViewTapped(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Icon(Icons.article, color: Colors.black),
                ),
              ),
            ],
          )
        : Row(
            children: [
              GestureDetector(
                onTap: () => _onLoginTapped(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Icon(Icons.login, color: Colors.black),
                ),
              ),
              GestureDetector(
                onTap: () => _onSignupTapped(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Icon(Icons.app_registration, color: Colors.black),
                ),
              ),
            ],
          );
  }

  void _onLoginTapped(BuildContext context) {
    Navigator.pushNamed(context, '/LogIn');
  }

  void _onSignupTapped(BuildContext context) {
    Navigator.pushNamed(context, '/SignUp');
  }

  void _onShowSavedArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/SavedArticles');
  }

  void _onShowMyArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/MyArticles');
  }
}
