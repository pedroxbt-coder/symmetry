import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/auth/presentation/bloc/auth/local/local_user_event.dart';
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
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${state.user.name}',
                style: const TextStyle(color: Colors.black),
              ),
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
          title: const Text('Settings'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Feature not implemented yet'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.brightness_2),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<LocalUserBloc>(context)
                            .add(const SignOut());
                        Navigator.of(context).pop();
                      },
                      child: const Text('Log Out'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
