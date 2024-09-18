//auth
const String authRoute = '/auth';
const String signIn = '$authRoute/sign-in';
const String signUp = '$authRoute/sign-up';
const String resetPassword = '$authRoute/reset-password';
const String changePassword = '$authRoute/change-password';

//todo
const todoRoute = '/todo';
const todoCreate = '$todoRoute/create';
const todoList = '$todoRoute/list';
const todoDetail = '$todoRoute/detail';

//category
const categoryRoute = '/card';
const categorySelect = '$categoryRoute/select';

const List<String> publicRoutes = [
  signIn,
  signUp,
  resetPassword,
];

const String mainEndpoint = categorySelect;
