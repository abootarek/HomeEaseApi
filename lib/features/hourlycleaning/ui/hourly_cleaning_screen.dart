// ignore_for_file: unused_element, unrelated_type_equality_checks, library_private_types_in_public_api, depend_on_referenced_packages, unnecessary_import

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_ease/core/theming/colors.dart';
import 'package:home_ease/core/theming/text_styles%20.dart';
import 'package:home_ease/core/widgets/custom_button.dart';
import 'package:home_ease/features/hourlycleaning/ui/widget/container_step.3.dart';
import 'package:home_ease/features/hourlycleaning/ui/widget/container_step_2.dart';
import 'package:home_ease/features/hourlycleaning/ui/widget/containet_step_1.dart';

class HourlyCleaningScreen extends StatefulWidget {
  const HourlyCleaningScreen({
    key,
  }) : super(key: key);

  @override
  _HourlyCleaningScreen createState() => _HourlyCleaningScreen();
}

class _HourlyCleaningScreen extends State<HourlyCleaningScreen> {
  int _currentStep = 0;
  bool isCompleted = false; //check completeness of inputs
  final formKey =
      GlobalKey<FormState>(); //form object to be used for form validation

  final numberOfHours = TextEditingController();

  final nationality = TextEditingController();

  final city = TextEditingController();

  final numberOfVisits = TextEditingController();

  void _goToNextStep() {
    final isLastStep = _currentStep == _mySteps().length - 1;
    formKey.currentState!.validate();
    bool isDetailValid =
        isDetailComplete(); //this check if ok to move on to next screen

    if (isDetailValid) {
      if (isLastStep) {
        setState(() {
          isCompleted = true;
          log("doneeeeeeeeeeeeeeeeeeee");
        });
      } else {
        setState(() {
          _currentStep += 1;
        });
      }
    }
  }

  void _goToPreviousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.lightGreen,
      appBar: AppBar(
        backgroundColor: ColorsApp.white,
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: ColorsApp.mainGreen)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 24.w, right: 20),
              child: Container(
                color: ColorsApp.white,
                child: Row(
                  children: [
                    Text(
                      'Hourly cleaning'.tr(),
                      style: TextStyles.font24mainGreen700,
                    ),
                    const Spacer(),
                    Image.asset(
                      'assets/images/flat.png',
                      width: 100,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Form(
                key: formKey,
                child: Stepper(
                  elevation: 0,
                  type: StepperType.horizontal,
                  steps: _mySteps(),
                  currentStep: _currentStep,
                  onStepTapped: (step) {
                    formKey.currentState!
                        .validate(); //this will trigger validation
                    setState(() {
                      _currentStep = step;
                    });
                  },
                  onStepContinue: () {
                    setState(
                      () {
                        _goToNextStep();
                      },
                    );
                  },
                  onStepCancel: () {
                    setState(() {
                      _goToPreviousStep();
                    });
                  },
                  controlsBuilder:
                      (BuildContext context, ControlsDetails controlsDetails) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          if (_currentStep >= 1)
                            Expanded(
                              child: CustomButton(
                                text: 'Back'.tr(),
                                onPressed: _goToPreviousStep,
                              ),
                            ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: CustomButton(
                              onPressed: _goToNextStep,
                              text: 'Next'.tr(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  bool isDetailComplete() {
    if (_currentStep == 0) {
      //check sender fields
      if (numberOfHours.text.isEmpty ||
          nationality.text.isEmpty ||
          city.text.isEmpty) {
        return false;
      } else {
        return true; //if all fields are not empty
      }
    } else if (_currentStep == 1) {
      //check receiver fields
      // if (receiverName.text.isEmpty || receiverAddress.text.isEmpty) {
      //   return false;
      // } else {
      return true;

      // }
    } else if (_currentStep == 2) {
      //check receiver fields
      if (numberOfVisits.text.isEmpty) {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }



  List<Step> _mySteps() {
    List<Step> steps = [
      Step(
        title: Text(
          'Step 1'.tr(),
          style: TextStyles.font12mainGreen700,
        ),
        content: ContainerStepOne(
          City: city,
          Nationality: nationality,
          numberOfHours: numberOfHours,
        ),
        isActive: _currentStep >= 0,
        state: _currentStep >= 0 ? StepState.indexed : StepState.disabled,
      ),
      Step(
        title: Text(
          'Step 2'.tr(),
          style: TextStyles.font12mainGreen700,
        ),
        content: const ContainerStep2(),
        isActive: _currentStep >= 1,
      ),
      Step(
        title: Text(
          'Step 3'.tr(),
          style: TextStyles.font12mainGreen700,
        ),
        content: ContainerStep3(
          numberOfVisits: numberOfVisits,
        ),
        isActive: _currentStep >= 2,
      ),
    ];
    return steps;
  }
}
