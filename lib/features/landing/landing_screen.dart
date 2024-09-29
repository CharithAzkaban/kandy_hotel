import 'package:flutter/material.dart';
import 'package:kandy_hotel/services/system_services.dart';
import 'package:kandy_hotel/utils/enums.dart';
import 'package:kandy_hotel/utils/methods.dart';
import 'package:kandy_hotel/widgets/gap.dart';
import 'package:kandy_hotel/widgets/unfocus_wrapper.dart';
import 'package:kandy_hotel/widgets/vaaru_button.dart';
import 'package:kandy_hotel/widgets/vaaru_text.dart';
import 'package:kandy_hotel/widgets/vaaru_text_button.dart';
import 'package:kandy_hotel/widgets/vaaru_tff.dart';

class LandingScreen extends StatefulWidget {
  static const page = Routes.landing;
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => UnfocusWrapper(
        child: Scaffold(
          floatingActionButton: VaaruTextButton(
            label: 'CHECK FOR UPDATES',
            onPressed: () => checkForUpdates(),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const VaaruText(
                        'New Orchid Cafe',
                        size: 30.0,
                      ),
                      const Gap(v: 20.0),
                      VaaruTff(
                        width: 400.0,
                        controller: _passwordController,
                        labelText: 'Password',
                        obscureText: true,
                        showEye: true,
                        validator: (text) {
                          if (textOrEmpty(text).isEmpty) {
                            return 'Password required!';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) => _next(context),
                      ),
                      const Gap(v: 5.0),
                      SizedBox(
                        width: 400.0,
                        child: Row(
                          children: [
                            Expanded(
                              child: VaaruTextButton(
                                label: 'Forgot Password?',
                                onPressed: () {},
                              ),
                            ),
                            Expanded(
                              child: VaaruTextButton(
                                label: 'Create Password',
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(v: 15.0),
                      VaaruButton(
                        label: 'SIGN IN',
                        width: 400.0,
                        onPressed: () => _next(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  void _next(BuildContext context) {
    if (_formKey.currentState!.validate()) {}
  }
}
