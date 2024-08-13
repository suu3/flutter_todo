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

//card
const cardRoute = '/card';
const cardSelect = '$cardRoute/select';
const cardList = '$cardRoute/list';
const cardDetail = '$cardRoute/detail';

const List<String> publicRoutes = [
  signIn,
  signUp,
  resetPassword,
];

const String mainEndpoint = todoCreate;
