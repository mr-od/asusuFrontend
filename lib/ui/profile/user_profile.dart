import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/logic.dart';
import '../../shared/shared.dart';
import '../../shared/styles/shared_colors.dart' as a4_style;
import '../login/login.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            PreferredSize(
              preferredSize: const Size.fromHeight(30),
              child: AppBar(
                backgroundColor: a4_style.lavenderBlush,
                leading: const Padding(
                  padding: EdgeInsets.all(0.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://afia4.oss-cn-beijing.aliyuncs.com/profile-images/placeholder.png"),
                  ),
                ),
                title: BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserLoadingState) {
                      debugPrint('App Bar LoadingState : $state');
                      return appLoadingState();
                    } else if (state is UserLoadedState) {
                      debugPrint('AppBarState : $state');
                      return _vendorAppBarDetails(context, state.userModel);
                    } else if (state is UserErrorState) {
                      debugPrint('App Bar Error State : $state');
                      return const Text(
                          'There was an error loading your details.');
                    } else {
                      return Container();
                    }
                  },
                ),
                actions: [
                  IconButton(
                      icon: const Icon(
                        EvaIcons.logOutOutline,
                        size: 20,
                      ),
                      onPressed: () {
                        BlocProvider.of<AuthenticationBloc>(context).add(
                          LoggedOut(),
                        );
                        goTo(context, const LoginScreen());
                      })
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: pureBlack, border: Border.all(color: amaranth)),
                child: _accountPanel(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: pureBlack, border: Border.all(color: amaranth)),
                child: _buildVendorProfile(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: pureBlack, border: Border.all(color: amaranth)),
                child: _userFunctionsPanel(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: pureBlack, border: Border.all(color: amaranth)),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/promoted');
                  },
                  child: const Text('Go to Products'),
                ),
              ),
            ),
          ],
        ),
      ),
      // body: _buildVendorProfile(),
    );
  }

  Widget _buildVendorProfile(BuildContext _) {
    // BlocProvider.of<UserBloc>(_).add(FetchUserDetailsEvent());

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 80.0),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              debugPrint('LoadingState : $state');
              return appLoadingState();
            } else if (state is UserLoadedState) {
              debugPrint('LoadedState : $state');
              return _vendorDetails(context, state.userModel);
            } else if (state is UserErrorState) {
              debugPrint('Error State : $state');
              return const Text('There was an error loading your details.');
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _vendorAppBarDetails(BuildContext context, SingleUserModel model) {
    return Row(
      children: [
        Expanded(
            child: Text("Username : ${model.username}",
                style: const TextStyle(fontSize: 10))),
        const SizedBox(
          width: 10,
        ),
        // Expanded(
        //   child: Text(
        //     "ShopperID : ${model.id.toString()}",
        //     style: const TextStyle(fontSize: 10),
        //   ),
        // )
      ],
    );
  }

  Widget _vendorDetails(BuildContext context, SingleUserModel model) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'User Details',
                style: TextStyle(
                    fontSize: 12.0,
                    color: a4_style.amaranth,
                    fontWeight: FontWeight.w500),
              ),
              // defaultTextContainer(
              //     prefixtext: 'Vendor ID', text: model.id.toString()),
              defaultTextContainer(
                  prefixtext: 'Username', text: model.username),
              defaultTextContainer(prefixtext: 'Email', text: model.email),
            ],
          ),
        ),
      ),
    );
  }

  Widget _accountPanel() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _accountPanelContainer(
              panelContentIcon: Icons.abc_rounded,
              panelContentName: "Account Details"),
          const Divider(
            color: Colors.black,
          ),
          _accountPanelContainer(
              panelContentIcon: Icons.settings,
              panelContentName: "Account Settings"),
          const Divider(
            color: Colors.black,
          ),
          _accountPanelContainer(
              panelContentIcon: Icons.child_care_outlined,
              panelContentName: "Customer Support"),
        ],
      ),
    );
  }

  Widget _accountPanelContainer(
      {required String panelContentName, required IconData panelContentIcon}) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Expanded(
              child: Row(
            children: [
              Text(
                panelContentName,
                style: TextStyle(color: lavenderBlush),
              ),
              Icon(
                panelContentIcon,
                color: amaranth,
              ),
            ],
          )),
          const Expanded(child: Icon(Icons.forward))
        ],
      ),
    );
  }

  Widget _userFunctionsPanel() {
    return Row();
  }
}
