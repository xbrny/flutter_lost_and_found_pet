import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lost_found_pet_prototype/model/post.dart';
import 'package:lost_found_pet_prototype/theme/theme_constant.dart';
import 'package:lost_found_pet_prototype/util/form_helpers.dart';
import 'package:lost_found_pet_prototype/util/toast.dart';
import 'package:lost_found_pet_prototype/util/ui_helpers.dart';
import 'package:lost_found_pet_prototype/util/util.dart';
import 'package:lost_found_pet_prototype/util/validation.dart';
import 'package:lost_found_pet_prototype/view_model/post_list_model.dart';
import 'package:lost_found_pet_prototype/view_model/post_model.dart';
import 'package:lost_found_pet_prototype/widget/app_bar_title.dart';
import 'package:lost_found_pet_prototype/widget/reusable_app_bar.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';

enum Field {
  name,
  breed,
  location,
  dateTimeLost,
  phoneNumber,
  additionalDetails,
}

class PostCreateScreen extends StatefulWidget {
  @override
  _PostCreateScreenState createState() => _PostCreateScreenState();
}

class _PostCreateScreenState extends State<PostCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _post = Post(postType: PostType.lost, notifyMe: false);
  final _format = DateFormat("yyyy-MM-dd HH:mm");

  final _focusNodes = FormHelper.generateFocusNodeMap<Field>(Field.values);
  final _fieldKeys = FormHelper.generateFormFieldKeyMap<Field>(Field.values);
  final _autoValidates =
      FormHelper.generateAutoValidateMap<Field>(Field.values);
  final _textControllers =
      FormHelper.generateTextControllerMap<Field>(Field.values);

  List<Asset> _images = List<Asset>();
  String _error;
  bool _isSubmitting = false;

  CreatePostModel _createPostNotifier;
  FoundPostListModel _foundPostListNotifier;
  LostPostListModel _lostPostListNotifier;
  UserPostListModel _currentUserPostListNotifier;

  @override
  void initState() {
    super.initState();
    _attachFocusesListener(_focusNodes);
    _createPostNotifier = Provider.of<CreatePostModel>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    FormHelper.disposeFocusNodes(_focusNodes);
    FormHelper.disposeTextControllers(_textControllers);
  }

  @override
  Widget build(BuildContext context) {
    final _currentUser = Provider.of<FirebaseUser>(context);
    _foundPostListNotifier = Provider.of<FoundPostListModel>(context);
    _lostPostListNotifier = Provider.of<LostPostListModel>(context);
    _currentUserPostListNotifier = Provider.of<UserPostListModel>(context);

    return ModalProgressHUD(
      inAsyncCall: _isSubmitting,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: ReusableAppBar(
          title: AppBarTitle(
            'Create New Post',
          ),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(LineIcons.close),
              onPressed: () {
                Navigator.maybePop(context);
              },
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: ListView(
              children: <Widget>[
                UIHelper.verticalSpaceMedium(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1),
                  child: CupertinoSegmentedControl<PostType>(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 24),
                    groupValue: _post.postType,
                    children: {
                      PostType.lost: Text('I lost a pet'),
                      PostType.found: Text('I found a pet')
                    },
                    onValueChanged: (value) =>
                        setState(() => _post.postType = value),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1),
                  child: _buildImageRow(),
                ),
                UIHelper.verticalSpaceSmall(),
                _buildTextFormField(
                  label: 'Name',
                  field: Field.name,
                  nextField: Field.breed,
                  onSaved: (value) => _post.name = value,
                  validator: Validator.validateNotEmpty,
                ),
                _buildTextFormField(
                  label: 'Breed',
                  field: Field.breed,
                  nextField: Field.location,
                  onSaved: (value) => _post.breed = value,
                ),
                _buildTextFormField(
                  label: 'Location',
                  field: Field.location,
                  onSaved: (value) => _post.location = value,
                  validator: Validator.validateNotEmpty,
                  onEditingComplete: (FocusNode currentFocus) {
                    currentFocus.unfocus();
                  },
                  textInputAction: TextInputAction.next,
                ),
                CheckboxListTile(
                  dense: true,
                  onChanged: (bool value) =>
                      setState(() => _post.notifyMe = value),
                  value: _post.notifyMe,
                  title: Text('Notify me when there\'s new post in this area'),
                ),
                _buildDateTimeFormField(
                  label: 'Date and time lost/found',
                  field: Field.dateTimeLost,
                  nextField: Field.phoneNumber,
                  onSaved: (DateTime value) => _post.dateTimeLost = value,
                  validator: Validator.validateDateTime,
                ),
                _buildTextFormField(
                  label: 'Contact number',
                  field: Field.phoneNumber,
                  nextField: Field.additionalDetails,
                  onSaved: (value) => _post.phoneNumber = value,
                  validator: Validator.validatePhoneNumber,
                  keyboardType: TextInputType.number,
                ),
                _buildTextFormField(
                  label: 'Additional details',
                  field: Field.additionalDetails,
                  onSaved: (value) => _post.additionalDetails = value,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: (FocusNode currentFocus) {
                    currentFocus.unfocus();
                  },
                  maxLines: 4,
                ),
                UIHelper.verticalSpaceLarge(),
                RaisedButton(
                  textColor: Colors.white,
                  child: Text('Submit'),
                  onPressed: () async {
                    await _handleFormSubmission(
                      _currentUser,
                      context,
                    );
                  },
                ),
                UIHelper.verticalSpaceLarge(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loadAssets() async {
    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 3,
        enableCamera: true,
      );
    } on PlatformException catch (e) {
      error = e.message;
    }

    if (!mounted) return;

    setState(() {
      _images.addAll(resultList);
      if (error != null) _error = error;
    });
  }

  void _attachFocusesListener(Map<Field, FocusNode> focusNodes) {
    _focusNodes.forEach((field, focusNode) {
      focusNode.addListener(() {
        if (!focusNode.hasFocus) {
          _fieldKeys[field].currentState.validate();
          _fieldKeys[field].currentState.save();
          setState(() {
            _autoValidates[field] = true;
          });
        }
      });
    });
  }

  Future _handleFormSubmission(
    FirebaseUser _currentUser,
    BuildContext context,
  ) async {
    _formKey.currentState.save();

    setState(() {
      _autoValidates.forEach((field, _) => _autoValidates[field] = true);
    });

    if (_formKey.currentState.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      _post.uid = _currentUser.uid;

      TypedPostListModel _postListNotifierToBeUpdated;

      if (_post.postType == PostType.lost) {
        _postListNotifierToBeUpdated = _lostPostListNotifier;
      } else {
        _postListNotifierToBeUpdated = _foundPostListNotifier;
      }

      await _createPostNotifier.createPost(
          _post, _images, _postListNotifierToBeUpdated);

      setState(() {
        _isSubmitting = false;
      });

      Navigator.pop(context);

      Toast.createSuccess(
        message: 'Post created successfully',
      ).show(context);
    } else {
      Toast.createError(
        message: 'Invalid input, please check your form again',
      ).show(context);
    }
  }

  Widget _buildImageRow() {
    if (_error != null && _error.isNotEmpty) {
      return Text(_error);
    }

    if (_images == null || _images.length == 0) {
      return OutlineButton(
        onPressed: _loadAssets,
        child: Icon(LineIcons.camera),
      );
    }

    return Row(
      children: List.generate(
        _images.length,
        (index) {
          Asset asset = _images[index];
          return Padding(
            padding: EdgeInsets.only(right: 24),
            child: _buildImageThumb(asset, index),
          );
        },
      )..add(
          GestureDetector(
            onTap: _loadAssets,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54, width: 1),
              ),
              child: Icon(LineIcons.camera),
            ),
          ),
        ),
    );
  }

  Widget _buildImageThumb(Asset asset, int index) {
    return Stack(
      alignment: Alignment(1.4, -1.4),
      children: <Widget>[
        AssetThumb(asset: asset, width: 50, height: 50),
        GestureDetector(
          child: Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              LineIcons.close,
              color: Colors.white,
              size: 18,
            ),
          ),
          onTap: () {
            setState(() {
              _images.removeAt(index);
            });
          },
        )
      ],
    );
  }

  Widget _buildTextFormField({
    Field field,
    Field nextField,
    String label,
    FormFieldValidator<String> validator,
    TextInputAction textInputAction = TextInputAction.next,
    Function onEditingComplete,
    TextInputType keyboardType,
    int maxLines,
    FormFieldSetter<String> onSaved,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kSpaceSmall),
      child: TextFormField(
        key: _fieldKeys[field],
        focusNode: _focusNodes[field],
        autovalidate: _autoValidates[field],
        controller: _textControllers[field],
        keyboardType: keyboardType,
        validator: validator,
        maxLines: maxLines,
        onSaved: onSaved,
        onEditingComplete: (onEditingComplete != null)
            ? () {
                onEditingComplete(_focusNodes[field]);
              }
            : () {
                if (nextField != null) {
                  _focusNodes[nextField].requestFocus();
                }
              },
        decoration: kInputDecoration(label),
        textInputAction: textInputAction,
      ),
    );
  }

  Widget _buildDateTimeFormField({
    Field field,
    Field nextField,
    String label,
    FormFieldValidator<DateTime> validator,
    TextInputAction textInputAction = TextInputAction.next,
    Function onEditingComplete,
    FormFieldSetter<DateTime> onSaved,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kSpaceSmall),
      child: DateTimeField(
        key: _fieldKeys[field],
        focusNode: _focusNodes[field],
        autovalidate: _autoValidates[field],
        validator: validator,
        onSaved: onSaved,
        onEditingComplete: (onEditingComplete != null)
            ? () {
                onEditingComplete(_focusNodes[field]);
              }
            : () {
                if (nextField != null) {
                  _focusNodes[nextField].requestFocus();
                }
              },
        decoration: kInputDecoration(label),
        textInputAction: textInputAction,
        format: _format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
    );
  }
}
