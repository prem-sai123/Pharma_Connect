import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_connect/core/context_ext.dart';
import 'package:pharma_connect/core/string_ext.dart';
import 'package:pharma_connect/core/styles/app_colors.dart';
import 'package:pharma_connect/core/widgets/app_text_field.dart';
import 'package:pharma_connect/core/widgets/loading_overlay.dart';
import 'package:pharma_connect/core/widgets/simple_app_bar.dart';
import 'package:pharma_connect/features/home_page/presentation/home_page.dart';
import 'package:pharma_connect/features/profile/model/user_details.dart';
import 'package:pharma_connect/features/profile/presentation/bloc/profile_details/profile_details_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  final nameCtlr = TextEditingController();
  final phoneCtlr = TextEditingController();
  final emailCtlr = TextEditingController();
  final prationerIdCtlr = TextEditingController();
  final billingAddCtlr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'Profile',
        onPop: () => globalPageController.jumpToPage(0),
      ),
      body: BlocConsumer<ProfileDetailsCubit, ProfileDetailsState>(
        listener: (_, state) {
          final overlay = LoadingOverlay.of(context);
          state.maybeWhen(
            orElse: () {},
            loading: () => overlay.show(),
            success: (details) {
              overlay.hide();
              if (details == null) return;
              context.showSnackbar(
                'Profile Details Updated Seccessfully..!',
                AppSnackBarType.success,
              );
              setState(() {
                nameCtlr.text = details.name.valueOrEmpty;
                phoneCtlr.text = details.phone.valueOrEmpty;
                emailCtlr.text = details.email.valueOrEmpty;
                prationerIdCtlr.text = details.practionerId.valueOrEmpty;
                billingAddCtlr.text = details.address.valueOrEmpty;
              });
            },
          );
        },

        builder:
            (_, state) => SingleChildScrollView(
              padding: EdgeInsets.all(18.0),
              child: Column(
                spacing: 18.0,
                children: [
                  AppTextField(title: 'Name', controller: nameCtlr),
                  AppTextField(
                    title: 'Phone',
                    controller: phoneCtlr,
                    inputType: TextInputType.number,
                    maxLength: 10,
                  ),
                  AppTextField(title: 'Email', controller: emailCtlr),
                  AppTextField(
                    title: 'Practioner ID',
                    controller: prationerIdCtlr,
                  ),
                  AppTextField(
                    title: 'Billing Address',
                    controller: billingAddCtlr,
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
                        address: billingAddCtlr.text,
                        email: emailCtlr.text,
                        phone: phoneCtlr.text,
                        practionerId: prationerIdCtlr.text,
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
