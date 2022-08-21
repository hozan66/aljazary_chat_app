import 'package:flutter/material.dart';
import '../../../shared/components/components.dart';
import '../../../shared/constants/default_values.dart';
import '../../widgets/build_form_field.dart';
import '../../widgets/primary_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController(text: userEmail);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: myDefaultPadding),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Profile Setting",
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.8),
                    ),
              ),
              const SizedBox(
                height: 60.0,
              ),
              BuildFormField(
                controller: emailController,
                label: 'Email Address',
                type: TextInputType.emailAddress,
                prefix: Icons.email_outlined,
                validate: (_) {
                  return null;
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              PrimaryButton(
                text: 'Sign Out',
                press: () {
                  signOut(context);
                },
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
