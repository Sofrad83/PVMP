/// Fichier de configuration de l'application
class PVMPConfig {
  /// URL de base du serveur
  static const String BASE_URL =
      "";

  /// L'id du commerçant
  static const String MERCHAND_ID = 'Ql5rYEviIio26CrgpzZifGjY';

  /// La clé d'API
  static const String API_KEY =
      'hIPmEiIopIr1MPC9EYRDaTvShfbukYGAd3pVytOav356KD8tKbzLkMXVeYELrWtN';

  /// Le type d'autorisation de l'API
  static const String AUTHORIZATION =
      'Basic ZGV2ZWxvcHBlbWVudEBjb3NtZWRpdGVycmFuZWUuY29tOndWWkl0UVRnRTZIREV0MnI=';

  /// Stockage global du type de device (Scanner ou Smartphone/Tablette)
  /// Initialisé depuis les shared parameters au niveau du splash screen
  /// 0: Smartphone/Tablette
  /// 1: Scanner
  // ignore: non_constant_identifier_names
  static int? DEVICE_TYPE;
}
