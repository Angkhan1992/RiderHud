class UserModel {
  String avatar_path = '';
  String channel_id = '';
  String company_id = '';
  String date_created = '';
  String date_last_online = '';
  String date_updated = '';
  String deviceToken = '';
  String email = '';
  String first_login = '';
  String full_name = '';
  String guid = '';
  String id = '';
  String is_avatar = '';
  String is_blocked = '';
  String is_verified = '';
  String language = '';
  String latitude = '';
  String longitude = '';
  String phone_number = '';
  String rate = '';
  String regional_zone_id = '';
  String rhid = '';
  String short_name = '';
  String step = '';
  String thumb_path = '';
  String tutorial_progress = '';
  int user_type = 0;
  String verified_number = '';

  UserModel(
      {this.avatar_path,
      this.channel_id,
      this.company_id,
      this.date_created,
      this.date_last_online,
      this.date_updated,
      this.deviceToken,
      this.email,
      this.first_login,
      this.full_name,
      this.guid,
      this.id,
      this.is_avatar,
      this.is_blocked,
      this.is_verified,
      this.language,
      this.latitude,
      this.longitude,
      this.phone_number,
      this.rate,
      this.regional_zone_id,
      this.rhid,
      this.short_name,
      this.step,
      this.thumb_path,
      this.tutorial_progress,
      this.user_type,
      this.verified_number});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return new UserModel(
      avatar_path: map['avatar_path'] as String,
      channel_id: map['channel_id'] as String,
      company_id: map['company_id'] as String,
      date_created: map['date_created'] as String,
      date_last_online: map['date_last_online'] as String,
      date_updated: map['date_updated'] as String,
      deviceToken: map['deviceToken'] as String,
      email: map['email'] as String,
      first_login: map['first_login'] as String,
      full_name: map['full_name'] as String,
      guid: map['guid'] as String,
      id: map['id'] as String,
      is_avatar: map['is_avatar'] as String,
      is_blocked: map['is_blocked'] as String,
      is_verified: map['is_verified'] as String,
      language: map['language'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
      phone_number: map['phone_number'] as String,
      rate: map['rate'] as String,
      regional_zone_id: map['regional_zone_id'] as String,
      rhid: map['rhid'] as String,
      short_name: map['short_name'] as String,
      step: map['step'] as String,
      thumb_path: map['thumb_path'] as String,
      tutorial_progress: map['tutorial_progress'] as String,
      user_type: map['user_type'] as int,
      verified_number: map['verified_number'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'avatar_path': this.avatar_path,
      'channel_id': this.channel_id,
      'company_id': this.company_id,
      'date_created': this.date_created,
      'date_last_online': this.date_last_online,
      'date_updated': this.date_updated,
      'deviceToken': this.deviceToken,
      'email': this.email,
      'first_login': this.first_login,
      'full_name': this.full_name,
      'guid': this.guid,
      'id': this.id,
      'is_avatar': this.is_avatar,
      'is_blocked': this.is_blocked,
      'is_verified': this.is_verified,
      'language': this.language,
      'latitude': this.latitude,
      'longitude': this.longitude,
      'phone_number': this.phone_number,
      'rate': this.rate,
      'regional_zone_id': this.regional_zone_id,
      'rhid': this.rhid,
      'short_name': this.short_name,
      'step': this.step,
      'thumb_path': this.thumb_path,
      'tutorial_progress': this.tutorial_progress,
      'user_type': this.user_type,
      'verified_number': this.verified_number,
    };
  }

  bool isEnglish() {
    if (language == null) return true;
    return (language.toLowerCase() == 'en');
  }
}