// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:Expense_app/app/commons/commons.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// class SocialLoginRepositoryImpl implements SocialLoginRepository {
//   SocialLoginRepositoryImpl({required this.repository});

//   final ApiRepository repository;
//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

//   @override
//   Future<UserEntity> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//       final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );

//       final response = await firebaseAuth.signInWithCredential(credential);
//       final token = await response.user!.getIdToken();
//       if (token != null) {
//         return _syncSocialLogin(token);
//       } else {
//         throw Exception('Invalid accessToken');
//       }
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'account-exists-with-different-credential') {
//         throw Exception('Email already register with another provider');
//       } else if (e.code == 'invalid-credential') {
//         throw Exception('Invalid credentials');
//       }
//       throw Exception('Failed to sync with google provider');
//     }
//   }

//   @override
//   Future<UserEntity> signInWithApple() async {
//     try {
//       final appleUser = await SignInWithApple.getAppleIDCredential(
//         scopes: [
//           AppleIDAuthorizationScopes.email,
//           AppleIDAuthorizationScopes.fullName,
//         ],
//       );

//       final AuthCredential credential = OAuthProvider('apple.com').credential(
//         accessToken: appleUser.authorizationCode,
//         idToken: appleUser.identityToken,
//       );

//       final response = await firebaseAuth.signInWithCredential(credential);

//       final appleFirstName = appleUser.givenName;
//       final appleLastName = appleUser.familyName;

//       final token = await response.user!.getIdToken();
//       if (token != null) {
//         final user = await _syncSocialLogin(token);
//         if (isNullOrEmpty(user.firstName)) {
//           return user.copyWith(firstName: appleFirstName, lastName: appleLastName);
//         } else {
//           return user;
//         }
//       } else {
//         throw Exception('Invalid accessToken');
//       }
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'account-exists-with-different-credential') {
//         throw Exception('Email already register with another provider');
//       } else if (e.code == 'invalid-credential') {
//         throw Exception('Invalid credentials');
//       }
//       throw Exception('Failed to sync with apple provider');
//     }
//   }

//   Future<UserEntity> _syncSocialLogin(String token) async {
//     try {
//       return repository.socialLoginAuth(token);
//     } catch (e) {
//       throw Exception('Failed to sync social login');
//     }
//   }

//   @override
//   void signOut() {
//     firebaseAuth.signOut();
//   }
// }
