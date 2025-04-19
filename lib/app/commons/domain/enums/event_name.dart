enum EventName {
  createAccountSucess('create_account_success'),
  createAccountFailed('create_account_failed'),
  loginSuccess('login_success'),
  loginFailed('login_failed'),
  journeyPlayClick('journey_play_click'),
  journeyPracticeFinished('journey_practice_finished'),
  experienceRegisterClick('experience_register_click'),
  profileDeleteClick('profile_delete_click');

  final String value;
  const EventName(this.value);
}
