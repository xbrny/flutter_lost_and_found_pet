import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lost_found_pet_prototype/router.dart';
import 'package:lost_found_pet_prototype/theme/theme_constant.dart';
import 'package:lost_found_pet_prototype/util/toast.dart';
import 'package:lost_found_pet_prototype/util/validation.dart';
import 'package:lost_found_pet_prototype/view_model/login_model.dart';
import 'package:lost_found_pet_prototype/widget/button_with_loading.dart';
import 'package:lost_found_pet_prototype/widget/close_icon_button.dart';
import 'package:lost_found_pet_prototype/widget/tappable_text.dart';
import 'package:provider/provider.dart';

class UserLoginScreen extends StatefulWidget {
  @override
  _UserLoginScreenState createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    final loginModel = Provider.of<LoginModel>(context, listen: false);

    loginModel.error$.listen((error) {
      if (error != null) {
        Toast.createError(message: error).show(context);
      }
    });

    loginModel.success$.listen((isSuccess) {
      if (isSuccess) {
        Navigator.pushReplacementNamed(context, Router.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginModel = Provider.of<LoginModel>(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    Widget _buildFormTitle() {
      return Text(
        'Login',
        style: textTheme.display1,
      );
    }

    Widget _buildEmailField() {
      return TextFormField(
        decoration: InputDecoration(
          labelText: 'Email',
        ),
        validator: Validator.validateEmail,
        controller: loginModel.emailController,
      );
    }

    Widget _buildPasswordField() {
      return TextFormField(
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        validator: Validator.validatePassword,
        controller: loginModel.passwordController,
      );
    }

    Widget _buildBottomLink() {
      return Padding(
        padding: const EdgeInsets.only(top: kSpaceExtraSmall),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextWithTap(
              onTap: () {},
              text: Text(
                'Forgot password'.toUpperCase(),
                style:
                    Theme.of(context).textTheme.button.copyWith(fontSize: 11),
              ),
            ),
            TextWithTap(
              onTap: () {
                Navigator.pushReplacementNamed(context, Router.userRegister);
              },
              text: Text(
                'Register'.toUpperCase(),
                style:
                    Theme.of(context).textTheme.button.copyWith(fontSize: 11),
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildButton() {
      return ButtonWithLoading(
        onPressed:
            loginModel.isSubmitting ? null : loginModel.submitButtonPressed,
        label: 'Login',
        isLoading: loginModel.isSubmitting,
      );
    }

    Widget _buildForm() {
      return Form(
        key: loginModel.formKey,
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
                  _buildEmailField(),
                  SizedBox(height: kSpaceExtraSmall),
                  _buildPasswordField(),
                  SizedBox(height: kSpaceExtraSmall),
                  _buildBottomLink(),
                ],
              ),
            ),
            _buildButton(),
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
                  child: _buildForm(),
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
