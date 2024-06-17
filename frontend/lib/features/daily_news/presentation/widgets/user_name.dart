import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/bloc/auth/local/local_user_bloc.dart';
import '../../../auth/presentation/bloc/auth/local/local_user_state.dart';

class UserNameWidget extends StatelessWidget {
  const UserNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalUserBloc, LocalUserState>(
      builder: (context, state) {
        if (state is LocalUserDone) {
          return GestureDetector(
            onTap: () => _showLogoutDialog(context),
            child: Text(
              '${state.user.email}!',
              style: const TextStyle(color: Colors.black),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close the dialog
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // BlocProvider.of<LocalUserBloc>(context).add(LogoutEvent());
                Navigator.of(context).pop();
              },
              child: const Text('Log Out'),
            ),
          ],
        );
      },
    );
  }
}
