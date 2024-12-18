enum RouteValue {
  splash(
    path: '/',
  ),
  home(
    path: '/home',
  ),
  dayli(
    path: 'dayli',
  ),
  select(
    path: 'select',
  ),
  achievements(
    path: 'achievements',
  ),
  level(
    path: 'level',
  ),
  quiz(
    path: 'quiz',
  ),

  unknown(
    path: '',
  );

  final String path;
  const RouteValue({
    required this.path,
  });
}
