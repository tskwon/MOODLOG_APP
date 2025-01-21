import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:get/get.dart';
import '../controller/auth_controller.dart';
import '../widgets/btn/label_textfield.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final authController = Get.find<AuthController>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _nameController = TextEditingController();

  File? _profileImage;
  //이미지 스케일링 기능 추가
  /*
  Future<void> _pickAndResizeImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);

      // 이미지 리사이즈
      File resizedImage =
          await _resizeImage(imageFile, width: 800, height: 800);

      setState(() {
        _profileImage = resizedImage; // 리사이즈된 이미지를 설정
      });
    }
  }
*/
/*
  Future<void> _pickAndResizeImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);

      // 비율 유지하며 리사이즈 (최대 300x300)
      File resizedImage =
          await _resizeImage(imageFile, maxWidth: 300, maxHeight: 300);

      setState(() {
        _profileImage = resizedImage; // 리사이즈된 이미지를 설정
      });
    }
  }

  Future<File> _resizeImage(File file,
      {required int maxWidth, required int maxHeight}) async {
    // 파일 데이터를 읽고 이미지를 디코딩
    final rawImage = await file.readAsBytes();
    final decodedImage = img.decodeImage(rawImage);

    if (decodedImage == null) {
      throw Exception('이미지를 디코딩할 수 없습니다.');
    }

    // 원본 이미지 크기
    final originalWidth = decodedImage.width;
    final originalHeight = decodedImage.height;

    // 비율 유지하면서 크기 계산
    final aspectRatio = originalWidth / originalHeight;
    int targetWidth = maxWidth;
    int targetHeight = maxHeight;

    if (originalWidth > originalHeight) {
      targetHeight = (maxWidth / aspectRatio).round();
    } else {
      targetWidth = (maxHeight * aspectRatio).round();
    }

    // 이미지 크기 조정
    final resizedImage = img.copyResize(
      decodedImage,
      width: targetWidth,
      height: targetHeight,
    );

    // 조정된 이미지를 파일로 저장
    final resizedBytes = img.encodeJpg(resizedImage);
    final resizedFile = File(file.path)..writeAsBytesSync(resizedBytes);

    return resizedFile;
  }
  */
  /*
  Future<File> _resizeImage(File file, {required double screenWidth}) async {
    // 파일 데이터를 읽고 이미지를 디코딩
    final rawImage = await file.readAsBytes();
    final decodedImage = img.decodeImage(rawImage);

    if (decodedImage == null) {
      throw Exception('이미지를 디코딩할 수 없습니다.');
    }

    // 원본 이미지 크기
    final originalWidth = decodedImage.width;
    final originalHeight = decodedImage.height;

    // CircleAvatar의 반지름(screenWidth * 0.1) 기준으로 최대 크기 계산
    final maxDimension = (screenWidth * 0.2).round(); // 2배 반지름으로 설정
    final aspectRatio = originalWidth / originalHeight;

    int targetWidth = maxDimension;
    int targetHeight = maxDimension;

    if (originalWidth > originalHeight) {
      targetHeight = (maxDimension / aspectRatio).round();
    } else {
      targetWidth = (maxDimension * aspectRatio).round();
    }

    // 이미지 크기 조정
    final resizedImage = img.copyResize(
      decodedImage,
      width: targetWidth,
      height: targetHeight,
    );

    // 조정된 이미지를 파일로 저장
    final resizedBytes = img.encodeJpg(resizedImage);
    final resizedFile = File(file.path)..writeAsBytesSync(resizedBytes);

    return resizedFile;
  }*/
  Future<File> _resizeImage(File file,
      {required int maxWidth, required int maxHeight}) async {
    final rawImage = await file.readAsBytes();
    final decodedImage = img.decodeImage(rawImage);

    if (decodedImage == null) {
      throw Exception('이미지를 디코딩할 수 없습니다.');
    }

    // 이미지 비율 유지하면서 크롭
    final resizedImage = img.copyResizeCropSquare(
      decodedImage,
      size: maxWidth > maxHeight ? maxHeight : maxWidth, // 최대값으로 크롭
    );

    // 조정된 이미지를 파일로 저장
    final resizedBytes = img.encodeJpg(resizedImage);
    final resizedFile = File(file.path)..writeAsBytesSync(resizedBytes);

    return resizedFile;
  }

  Future<void> _pickAndResizeImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);

      final screenWidth = MediaQuery.of(context).size.width;

      // 화면 크기를 기준으로 이미지 크기 조정
      File resizedImage = await _resizeImage(
        imageFile,
        maxWidth: (screenWidth * 2).toInt(), // CircleAvatar 크기보다 2배로 설정
        maxHeight: (screenWidth * 2).toInt(),
        //screenWidth: MediaQuery.of(context).size.width, // 화면의 너비 전달
      );
      if (!mounted) return;

      setState(() {
        _profileImage = resizedImage; // 리사이즈된 이미지를 설정
      });
    }
  }

  /*
  Future<File> _resizeImage(File file,
      {required int width, required int height}) async {
    final rawImage = await file.readAsBytes();
    final decodedImage = img.decodeImage(rawImage);

    if (decodedImage == null) {
      throw Exception('이미지를 디코딩할 수 없습니다.');
    }

    final resizedImage =
        img.copyResize(decodedImage, width: width, height: height);
    final resizedBytes = img.encodeJpg(resizedImage);

    // 기존 파일 경로에 덮어쓰기
    final resizedFile = File(file.path)..writeAsBytesSync(resizedBytes);

    return resizedFile;
  }
  */
  //이미지 관련
  /*
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickImage != null) {
      setState(() {
        _profileImage = File(pickImage.path);
      });
    }
  }
  */

  // 회원가입 요청 처리
  Future<void> _submit() async {
    if (_passwordController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _passwordConfirmController.text.isEmpty) {
      Get.snackbar(
        'Error',
        '모든 필드를 입력해주세요.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (_passwordController.text != _passwordConfirmController.text) {
      Get.snackbar(
        'Error',
        '비밀번호가 일치하지 않습니다.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    bool result = await authController.register(
      _emailController.text.trim(),
      _passwordController.text.trim(),
      _nameController.text.trim(),
      _profileImage,
    );

    if (result) {
      Get.snackbar(
        'Success',
        '회원가입이 완료되었습니다!',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAllNamed('/home'); // 회원가입 완료 후 홈 화면으로 이동
    } else {
      Get.snackbar(
        'Error',
        '회원가입에 실패했습니다. 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '회원가입',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFFF8CF1A), // 밝은 노란색
          ),
        ),
        backgroundColor: const Color(0xFF8CA8AC),
        elevation: 0,
      ),
      /*
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: screenWidth * 0.1,
              backgroundColor: Colors.grey.shade300,
              child: Icon(
                Icons.camera_alt,
                color: Colors.grey.shade700,
                size: screenWidth * 0.08,
              ),
            ),*/
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _pickAndResizeImage, //_pickImage,
              child: CircleAvatar(
                  radius: screenWidth * 0.1,
                  backgroundColor: Colors.grey.shade300,
                  child: _profileImage != null
                      ? ClipOval(
                          child: Image.file(
                            _profileImage!,
                            fit: BoxFit.cover,
                            width: screenWidth * 0.2,
                            height: screenWidth * 0.2,
                          ),
                        ) //? FileImage(_profileImage!,) // 선택된 이미지 표시
                      : Icon(
                          Icons.camera_alt,
                          color: Colors.grey.shade700,
                          size: screenWidth * 0.08,
                        )),
            ),
            const SizedBox(height: 20),
            LabelTextField(
              label: '이름',
              hintText: '이름을 입력해주세요.',
              controller: _nameController,
              height: 50,
              keyboardType: TextInputType.name,
              isObscure: false,
            ),
            LabelTextField(
              label: '이메일',
              hintText: '이메일을 입력해주세요.',
              controller: _emailController,
              height: 50,
              keyboardType: TextInputType.emailAddress,
              isObscure: false,
            ),
            LabelTextField(
              label: '비밀번호',
              hintText: '비밀번호를 입력해주세요.',
              controller: _passwordController,
              height: 50,
              keyboardType: TextInputType.visiblePassword,
              isObscure: true,
            ),
            LabelTextField(
              label: '비밀번호 확인',
              hintText: '비밀번호를 한번 더 입력해주세요.',
              controller: _passwordConfirmController,
              height: 50,
              keyboardType: TextInputType.visiblePassword,
              isObscure: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8CA8AC),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: _submit,
              child: const Text('회원가입', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
