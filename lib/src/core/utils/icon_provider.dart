enum IconProvider {
  splash(imageName: 'splash.png'),
  aab(imageName: 'aab.png'),
  achievement(imageName: 'achivement.png'),
  alertL(imageName: 'alertl.png'),
  alertW(imageName: 'alertw.png'),
  back(imageName: 'back.png'),
  background(imageName: 'background.png'),
  close(imageName: 'close.png'),
  coins(imageName: 'coins.png'),
  confetti(imageName: 'confetti.png'),
  greenB(imageName: 'greenb.png'),
  hint(imageName: 'hint.png'),
  hp(imageName: 'hp.png'),
  logo(imageName: 'logo.png'),
  redB(imageName: 'redb.png'),
  score(imageName: 'score.png'),
  timer(imageName: 'timer.png'),
  yellowB(imageName: 'yellowb.png'),

  unknown(imageName: '');

  const IconProvider({
    required this.imageName,
  });

  final String imageName;
  static const _imageFolderPath = 'assets/images';

  String buildImageUrl() => '$_imageFolderPath/$imageName';
  static String buildImageByName(String name) => '$_imageFolderPath/$name';
}
