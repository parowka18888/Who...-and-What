import 'package:detective_task/Database/Enums/AppData/Mode.dart';
import 'package:detective_task/Database/Enums/AppData/PopUpWindow.dart';
import 'package:detective_task/GameScreens/GameScreen/GameScreen.dart';
import 'package:detective_task/GameScreens/GameScreen/GameScreen_Getter.dart';
import 'package:detective_task/ViewModel/Mechanics/Checking_Conditions/CheckConditions_Game.dart';
import 'package:detective_task/ViewModel/Mechanics/Getter/ViewModel_Getter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../AppTemplates/AppSize/AppSize.dart';
import '../../../ViewModel/GameScreen_ViewModel.dart';

class CategoryPicker{

  static getCategoryPicker(BuildContext context, double top, double containerHeight) {
    var gameScreen_viewModel = context.watch<GameScreen_ViewModel>();
    var width = AppSize.getAppWidth(context);

    double circleHeight_Main = containerHeight * 0.55;
    double circleHeight_Unselected = containerHeight * 0.3;
    double middleLocation_Width = (width - circleHeight_Unselected) / 2;
    double middleLocation_Height = (containerHeight - circleHeight_Unselected) / 2;
    double padding_Width = circleHeight_Unselected;
    return Positioned(
        top: top,
        child: AnimatedOpacity( opacity: gameScreen_viewModel.popUpWindow == PopUpWindow.QUESTION ? 0.0 : 1.0,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut,
          child: IgnorePointer(
            ignoring: gameScreen_viewModel.popUpWindow == PopUpWindow.QUESTION ? true : false,
            child: Container(
            height: containerHeight, width: width,
            child: Stack(
              alignment: Alignment(0, 0),
              children: [
                Positioned(top: 0, left: middleLocation_Width - padding_Width,
                    child: getCircleCategory(context, circleHeight_Unselected, Mode.CHARACTERS)),
                Positioned(top: middleLocation_Height, left: middleLocation_Width - padding_Width * 1.5,
                    child: getCircleCategory(context, circleHeight_Unselected, Mode.MOTIVES)),
                Positioned(bottom: 0, left: middleLocation_Width - padding_Width,
                    child: getCircleCategory(context, circleHeight_Unselected, Mode.TOOLS)),

                Positioned(top: 0, left: middleLocation_Width + padding_Width,
                    child: getCircleCategory(context, circleHeight_Unselected, Mode.VICTIMS)),
                Positioned(top: middleLocation_Height, left: middleLocation_Width + padding_Width * 1.5,
                    child: getCircleCategory(context, circleHeight_Unselected, Mode.CRIMETYPES)),
                Positioned(bottom: 0, left: middleLocation_Width + padding_Width,
                    child: getCircleCategory(context, circleHeight_Unselected, Mode.PLACES)),

                Positioned(
                    child: getCircleCategory(context, circleHeight_Main, gameScreen_viewModel.chosenMode)),

              ],
            ),
          ),
          ),
        )
    );
  }

  static getCircleCategory(BuildContext context, double height, Mode mode) {
    var gameScreen_viewModel = context.watch<GameScreen_ViewModel>();
    return GestureDetector(
      onTap: () {
        gameScreen_viewModel.setMode_Delayed(mode);
        print(gameScreen_viewModel.chosenMode);
      },
      child: Container(
        width: height, height: height,
        child: Stack(
          alignment: Alignment(0, 0),
          children: [
            Image.asset('assets/MenuAssets/ButtonSmall.png'),
            Container(
              height: height * 0.8, width: height  * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(height * height),
              ),
              clipBehavior: Clip.hardEdge,
              child: Stack(alignment: Alignment(0, 0),
                children: [
                  Opacity(opacity: CheckConditions_Game.checkIfEntityListGotOneLeft(GameScreen_Getter.getEntityList(mode, gameScreen_viewModel)) == true ? 1 : 0.7,
                  child: Image.asset(//GameScreen_Getter.getEntityList(mode, gameScreen_viewModel)[0].value.icon,
                    CheckConditions_Game.checkIfEntityListGotOneLeft(GameScreen_Getter.getEntityList(mode, gameScreen_viewModel)) == true ?
                    ViewModel_Getter.getImageOfSuspected(GameScreen_Getter.getEntityList(mode, gameScreen_viewModel), mode):
                    'assets/MenuAssets/unknown_${mode.name}.png',
                    fit: BoxFit.fitHeight,
                  ),
                  ),
                  if(CheckConditions_Game.checkIfEntityListGotOneLeft(GameScreen_Getter.getEntityList(mode, gameScreen_viewModel)) == false)
                    Image.asset(
                      'assets/MenuAssets/questionMark.png',
                      height: height * 0.6,
                    ),
                ],
              )
            ),

            Image.asset('assets/MenuAssets/Button_Frame.png'),
          ],
        ),
      ),
    );
  }

}