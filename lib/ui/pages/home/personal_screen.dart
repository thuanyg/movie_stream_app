import 'package:flutter/material.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_styles.dart';
import 'package:movie_stream/dto/response/user_info_response.dart';
import 'package:movie_stream/helpers/image_helper.dart';
import 'package:movie_stream/providers/user/user_provider.dart';
import 'package:movie_stream/ui/pages/login/login_page.dart';
import 'package:movie_stream/utils/app_utils.dart';
import 'package:provider/provider.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<PersonalScreen> {
  late UserProvider userProvider;
  late UserInfo userInfo;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    userInfo = userProvider.getUser!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bottomNavColor,
        title: Text("Settings", style: AppStyles.titleAppBar),
        centerTitle: true,
        leading: null,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              _buildUserInfoWidget(),
              const Divider(
                color: Colors.grey,
                thickness: .5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const CategorySetting("Account"),
                    ItemSetting(
                      iconAssetPath: "assets/images/ic_personal_setting.png",
                      settingName: "Personal Data",
                      onTapItemSetting: () => {print("ss")},
                    ),
                    ItemSetting(
                      iconAssetPath: "assets/images/ic_set_pin.png",
                      settingName: "Set up Payment PIN",
                      onTapItemSetting: () => {print("ss")},
                    ),
                    ItemSetting(
                      iconAssetPath: "assets/images/ic_delete_account.png",
                      settingName: "Deactivate Account",
                      onTapItemSetting: () => {print("ss")},
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: .5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const CategorySetting("App Settings"),
                    ItemSetting(
                      iconAssetPath: "assets/images/ic_personal_setting.png",
                      settingName: "Theme",
                      onTapItemSetting: () => {print("ss")},
                    ),
                    ItemSetting(
                      iconAssetPath: "assets/images/ic_set_pin.png",
                      settingName: "Notification",
                      onTapItemSetting: () => {print("ss")},
                    ),
                    ItemSetting(
                      iconAssetPath: "assets/images/ic_delete_account.png",
                      settingName: "History",
                      onTapItemSetting: () => {print("ss")},
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: .5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const CategorySetting("Privacy & Policy"),
                    ItemSetting(
                      iconAssetPath: "assets/images/ic_personal_setting.png",
                      settingName: "About us",
                      onTapItemSetting: () => {print("ss")},
                    ),
                    ItemSetting(
                      iconAssetPath: "assets/images/ic_logout_setting.png",
                      settingName: "Logout",
                      onTapItemSetting: logOutAction,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Widget _buildUserInfoWidget() {
    return SizedBox(
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        // Avatar
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey, width: .3)),
            child: userInfo.avatarUrl != null
                ? ImageHelper.loadNetworkImage(userInfo.avatarUrl.toString(),
                    radius: BorderRadius.circular(12), width: 48, height: 48)
                : ImageHelper.loadAssetImage("assets/images/ic_launcher.png",
                    radius: BorderRadius.circular(12), width: 48, height: 48),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userInfo.firstName == null && userInfo.lastName == null
                    ? "Anonymous"
                    : '${userInfo.firstName} ${userInfo.lastName}',
                style: AppStyles.heading3.copyWith(
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '@${userInfo.username}',
                style:
                    AppStyles.heading4.copyWith(color: AppColors.textHintColor),
              ),
            ],
          )
        ],
        // Name
      ),
    );
  }

  logOutAction() async {
    AppUtil.showLoadingDialog(context, "Logging out...");
    try {
      bool isLoggedOut = await userProvider.logOut();
      if (isLoggedOut) {
        await Future.delayed(const Duration(seconds: 2));
        AppUtil.hideLoadingDialog(context);
        Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
      }
    } catch (e) {
      print('Error during logout: $e');
    } finally {
      AppUtil.hideLoadingDialog(context);
    }
  }
}

class ItemSetting extends StatelessWidget {
  final String iconAssetPath, settingName;
  final VoidCallback onTapItemSetting;

  const ItemSetting({
    required this.iconAssetPath,
    required this.settingName,
    required this.onTapItemSetting,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTapItemSetting,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ImageHelper.loadAssetImage(
              iconAssetPath,
              height: 36,
              fit: BoxFit.cover,
              radius: BorderRadius.circular(10),
            ),
            const SizedBox(width: 8),
            Text(
              settingName,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CategorySetting extends StatelessWidget {
  final String categoryName;

  const CategorySetting(this.categoryName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          categoryName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
