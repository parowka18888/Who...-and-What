import 'package:detective_task/AppTemplates/AppSize/AppSize.dart';
import 'package:detective_task/GameScreens/PopUps/GameMode/GameMode_GUI.dart';
import 'package:detective_task/GameScreens/PopUps/PopUpBackground/PopUpBackground.dart';
import 'package:detective_task/GameScreens/MainMenu/MainMenu_GUI_Buttons.dart';
import 'package:detective_task/GameScreens/PopUps/Chest/Chest_GUI.dart';
import 'package:detective_task/GameScreens/PopUps/Customization/Customize_GUI.dart';
import 'package:detective_task/GameScreens/MainMenu/MainMenu_GUI.dart';
import 'package:detective_task/GameScreens/PopUps/Result/Result_GUI.dart';
import 'package:detective_task/ViewModel/Mechanics/Getter/ResultGetter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../AppTemplates/Ads/AdTypes/AdReward.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}
class _MainMenuState extends State<MainMenu> with TickerProviderStateMixin {
  late final AnimationController _fadeCtrl;
  late final AnimationController _SlowCtrl;
  late final AnimationController _MoveCtrl;
  late final Animation<double>  _opacityAnim;
  late final Animation<Alignment>  _moveAnim;


  int rewardForAd = ResultGetter.getGoldByMysteryTier(2);

  @override
  void initState() {
    super.initState();
    AdRewardedFullScreen.loadAd();

    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _SlowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: false);
    _MoveCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat(reverse: true);

    const double minOpacity = 0.30;
    const double maxOpacity = 1.0;

    _opacityAnim = Tween<double>(
      begin: minOpacity,
      end:   maxOpacity,
    ).animate(
      CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeInOut),
    );

    _moveAnim = AlignmentTween(
      begin: const Alignment(-0.4, 0.0),
      end: const Alignment(0.1, 0.0),
    ).animate(CurvedAnimation(
      parent: _MoveCtrl,
      curve: Curves.easeInOut,
    ));


  }


  @override
  Widget build(BuildContext context) {
    double height = AppSize.getAppHeight(context);
    double width = AppSize.getAppWidth(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
            child: Container(height: height, width: width,
              child: Stack(
                children: [
                  MainMenu_GUI.getBackground(context, _moveAnim),
                  MainMenu_GUI.getLogo(context),
                  MainMenu_GUI.getDetective(context),
                  PopUpBackground.getPopUpBackground(context),
                  Result_GUI.getResultPopUp(context),
                  MainMenu_GUI_Buttons.getBottomIcons(context, _opacityAnim),
                  Customize_GUI.getCustomizePopUp(context),
                  Chest_GUI.getChestPopUp(context, _SlowCtrl),
                  GameMode_GUI.getGameModePicker(context)
                ],
              ),
            )
        ),
      )
    );
  }
}