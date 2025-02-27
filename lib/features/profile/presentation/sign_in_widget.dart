import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_connect/core/core.dart';
import 'package:pharma_connect/features/profile/model/user_details.dart';
import 'package:pharma_connect/features/profile/presentation/bloc/profile_details/profile_details_cubit.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({super.key});

  @override
  State<SignInWidget> createState() => _SignInWidgetState();

  static Future<bool> prompt(BuildContext context) async {
    return await showModalBottomSheet<bool?>(
          context: context,
          backgroundColor: Colors.white,
          isScrollControlled: true,
          isDismissible: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          builder: (_) => SignInWidget(),
        ) ??
        false;
  }
}

class _SignInWidgetState extends State<SignInWidget> {
  final nameCtlr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileDetailsCubit, ProfileDetailsState>(
      listener: (_, state) {
        final overlay = LoadingOverlay.of(context);
        state.maybeWhen(
          orElse: () {},
          success: (details) {
            overlay.hide();
            if (details == null) return;
            context.showSnackbar(
              'Profile Updated Successfully..!',
              AppSnackBarType.success,
            );
            context.close(true);
          },
          loading: overlay.show,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          spacing: 14.0,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(AppIcons.appIcon, height: 48),
                ),
                IconButton(
                  onPressed: context.close,
                  icon: Icon(Icons.close, color: Colors.red),
                ),
              ],
            ),
            const Divider(color: AppColors.divider),
            Text(
              'To place your order, please SIGN IN',
              style: context.textTheme.titleMedium?.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.viewInsetsOf(context).bottom,
              ),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppTextField(
                    title: 'Name',
                    controller: nameCtlr,
                    hintText: 'Enter Your Name',
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.deepteal,
                      foregroundColor: AppColors.white,
                      shape: BeveledRectangleBorder(),
                    ),
                    onPressed: () {
                      if (nameCtlr.text.trim().isEmpty) {
                        context.showSnackbar('Please Enter Your Name');
                        return;
                      }
                      final details = UserDetails(
                        name: nameCtlr.text,
                        greetings: 'MR',
                      );
                      context.bloc<ProfileDetailsCubit>().updateDetails(
                        details,
                      );
                    },
                    child: Text(
                      'SUBMIT',
                      style: context.textTheme.labelLarge?.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
