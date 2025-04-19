abstract class Routes {
  static const root = Paths.root;

  // Splash
  static const splash = Paths.splash;
  static const specialGuest = Paths.specialGuest;

  // SignUp Flow
  static const signUp = Paths.signUp;
  static const emailInputSignUp = signUp + Paths.emailInput;
  static const codeInputSignUp = signUp + Paths.codeInput;
  static const aboutYouSignUp = signUp + Paths.aboutYou;
  static const locationSignUp = signUp + Paths.location;
  static const contactSignUp = signUp + Paths.contact;
  static const welcome = signUp + Paths.welcome;

  // SignIn Flow
  static const signIn = Paths.signIn;
  static const emailInputSignIn = signIn + Paths.emailInput;
  static const codeInputSignIn = signIn + Paths.codeInput;

  // Content
  static const content = Paths.content;

  // Home
  static const home = content + Paths.home;

  // Profile
  static const profile = content + Paths.profile;
  static const profileUpsell = Paths.profileUpsell;
  static const account = Paths.account;
  static const requestData = Paths.requestData;
  static const deleteAccount = Paths.deleteAccount;

  // Journey
  static const journey = Paths.journey;
  static const player = journey + Paths.player;
  static const journeyReview = journey + Paths.journeyReview;
  static const reviews = journey + Paths.reviews;
  static const videoPlayer = journey + Paths.videoPlayer;

  // Community
  static const community = content + Paths.community;
  static const leaders = Paths.leaders;
  static const experience = Paths.experience;
  static const communityUpsell = Paths.communityUpsell;

  // Onboarding
  static const onboarding = Paths.onboarding;
  // static const onboardingIntroduce = onboarding + Paths.onboardingIntroduc;
  static const onboardingQuestion = onboarding + Paths.onboardingQuestion;

  // Hotel
  static const hotel = Paths.hotel;
  static const hotelPlace = Paths.hotelPlace;
  static const expert = Paths.expert;
}

abstract class Paths {
  static const root = '/';

  // Splash
  static const splash = '/splash/';
  static const specialGuest = '/special-guest/';

  // SignUp Flow
  static const signUp = '/sign_up';
  static const aboutYou = '/about-you';
  static const location = '/location';
  static const contact = '/contact';
  static const welcome = '/welcome';

  // SignIn Flow
  static const signIn = '/sign_in';

  // Auth Common
  static const emailInput = '/email/';
  static const codeInput = '/code/';

  // Content
  static const content = '/content';

  // Home
  static const home = '/home/';

  // Profile
  static const profile = '/profile';
  static const account = '/account';
  static const profileUpsell = '/upsell/';
  static const requestData = '/request-data/';
  static const deleteAccount = '/delete-account/';

  // Journey
  static const journey = '/journey';
  static const player = '/player/';
  static const journeyReview = '/review/';
  static const reviews = '/reviews/';
  static const videoPlayer = '/video-player/';

  // Community
  static const community = '/community';
  static const leaders = '/leaders';
  static const experience = '/experience';
  static const communityUpsell = '/communityUpsell/';

  // Onboarding
  static const onboarding = '/onboarding';
  // static const onboardingIntroduceOne = '/introduce-one';
  static const onboardingQuestion = '/question';

  // Hotel
  static const hotel = '/hotel';
  static const hotelPlace = '/place/';
  static const expert = '/expert/';
}
