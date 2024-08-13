class Validators {
    static final RegExp _emailRegExp = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+$',
    );
  
    static String? validateEmail(String? value) {
      if (value == null || value.isEmpty) {
        return '이메일을 입력하세요';
      }
      if (!_emailRegExp.hasMatch(value)) {
        return '유효한 이메일 주소를 입력하세요';
      }
      return null;
    }
  
    static String? validatePassword(String? value) {
      if (value == null || value.isEmpty) {
        return '비밀번호를 입력하세요';
      }
      if (value.length < 6) {
        return '비밀번호는 최소 6자 이상이어야 합니다';
      }
      return null;
    }
  
    static String? validateConfirmPassword(String? value, String password) {
      if (value == null || value.isEmpty) {
        return '비밀번호 확인을 입력하세요';
      }
      if (value != password) {
        return '비밀번호가 일치하지 않습니다';
      }
      return null;
    }
  }
  