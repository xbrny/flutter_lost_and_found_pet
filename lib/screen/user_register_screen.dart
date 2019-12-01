import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lost_found_pet_prototype/router.dart';
import 'package:lost_found_pet_prototype/theme/theme_constant.dart';
import 'package:lost_found_pet_prototype/util/toast.dart';
import 'package:lost_found_pet_prototype/util/validation.dart';
import 'package:lost_found_pet_prototype/view_model/register_model.dart';
import 'package:lost_found_pet_prototype/widget/button_with_loading.dart';
import 'package:lost_found_pet_prototype/widget/close_icon_button.dart';
import 'package:lost_found_pet_prototype/widget/tappable_text.dart';
import 'package:provider/provider.dart';

class UserRegisterScreen extends StatefulWidget {
  @override
  _UserRegisterScreenState createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    final registerModel = Provider.of<RegisterModel>(context, listen: false);

    registerModel.error$.listen((error) {
      if (error != null) {
        Toast.createError(message: error).show(context);
      }
    });

    registerModel.success$.listen((isSuccess) {
      if (isSuccess) {
        Navigator.pushReplacementNamed(context, Router.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final registerModel = Provider.of<RegisterModel>(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    Widget _buildFormTitle() {
      return Text(
        'Register',
        style: textTheme.display1,
      );
    }

    Widget _buildEmailField(RegisterModel loginModel) {
      return TextFormField(
        decoration: InputDecoration(
          labelText: 'Email',
        ),
        validator: Validator.validateEmail,
        controller: loginModel.emailController,
      );
    }

    Widget _buildPasswordField(RegisterModel registerModel) {
      return TextFormField(
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        validator: Validator.validatePassword,
        controller: registerModel.passwordController,
      );
    }

    Widget _buildButton(RegisterModel registerModel) {
      return ButtonWithLoading(
        onPressed: registerModel.isSubmitting
            ? null
            : registerModel.submitButtonPressed,
        label: 'Register',
        isLoading: registerModel.isSubmitting,
      );
    }

    Widget _buildBottomLink() {
      return Padding(
        padding: const EdgeInsets.only(top: kSpaceExtraSmall),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextWithTap(
              onTap: () {
                Navigator.pushReplacementNamed(context, Router.userLogin);
              },
              text: Text(
                'Login'.toUpperCase(),
                style:
                    Theme.of(context).textTheme.button.copyWith(fontSize: 11),
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildForm(RegisterModel registerModel) {
      return Form(
        key: registerModel.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: kSpaceExtremeLarge),
                  _buildFormTitle(),
                  SizedBox(height: kSpaceLarge),
                  _buildEmailField(registerModel),
                  SizedBox(height: kSpaceExtraSmall),
                  _buildPasswordField(registerModel),
                  SizedBox(height: kSpaceExtraSmall),
                  _buildBottomLink(),
                ],
              ),
            ),
            _buildButton(registerModel),
          ],
        ),
      );
    }

    Container _buildBackButtonRow() {
      return Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: CloseIconButton(
          back: true,
          color: theme.primaryColor,
        ),
      );
    }

    return Scaffold(
      key: scaffoldKey,
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints boxConstraints) {
        return SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                alignment: Alignment.topRight,
                child: Image.asset(
                  'images/pattern/top-right.png',
                  height: 100,
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                alignment: Alignment(-1, 0),
                child: Image.asset(
                  'images/pattern/center-left.png',
                  height: 100,
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                alignment: Alignment(1, 0.3),
                child: Image.asset(
                  'images/pattern/center-right.png',
                  height: 90,
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  'images/pattern/bottom-left.png',
                  height: 180,
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  minHeight: boxConstraints.maxHeight,
                ),
                decoration: BoxDecoration(),
                padding: EdgeInsets.all(kSpaceExtraLarge),
                child: IntrinsicHeight(
                  child: _buildForm(registerModel),
                ),
              ),
              _buildBackButtonRow(),
            ],
          ),
        );
      }),
    );
  }
}
