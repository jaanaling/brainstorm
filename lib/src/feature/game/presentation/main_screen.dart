import 'dart:math';

import 'package:brainstorm_quest/main.dart';
import 'package:brainstorm_quest/routes/go_router_config.dart';
import 'package:brainstorm_quest/routes/route_value.dart';
import 'package:brainstorm_quest/src/core/utils/app_icon.dart';
import 'package:brainstorm_quest/src/core/utils/icon_provider.dart';
import 'package:brainstorm_quest/src/core/utils/size_utils.dart';
import 'package:brainstorm_quest/src/feature/game/bloc/app_bloc.dart';
import 'package:brainstorm_quest/src/feature/game/model/puzzle.dart';
import 'package:brainstorm_quest/src/feature/game/model/user.dart';
import 'package:brainstorm_quest/ui_kit/app_button/app_button.dart';
import 'package:brainstorm_quest/ui_kit/app_card.dart';
import 'package:brainstorm_quest/ui_kit/gradient_text_with_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state is AppLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is AppError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }
        if (state is AppLoaded) {
          return SafeArea(
            top: false,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFlagItem(
                        () {
                          context.push(
                            '${RouteValue.home.path}/${RouteValue.achievements.path}',
                          );
                        },
                        AppIcon(
                          asset: IconProvider.achievement.buildImageUrl(),
                          width: 64,
                          height: 64,
                        ),
                        [
                          const Color(0xFF14A8E8),
                          const Color(0xFF00438F),
                        ],
                        context,
                        const Color(0xFF01336e),
                        width: 75,
                        height: 118,
                      ),
                      const Spacer(),
                      _buildFlagItem(
                        () {
                          showBuyHintDialog(context);
                        },
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                AppIcon(
                                  asset: IconProvider.hint.buildImageUrl(),
                                  width: 35,
                                  height: 66,
                                ),
                                Positioned(
                                  left: -11,
                                  bottom: 15,
                                  child: AppIcon(
                                    asset: IconProvider.plus.buildImageUrl(),
                                    width: 23,
                                    height: 23,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(8),
                            TextWithBorder(
                              text: state.user.hints.toString(),
                              borderColor: const Color(0xFF00520F),
                              fontSize: 34,
                            ),
                          ],
                        ),
                        [
                          const Color(0xFF14E83B),
                          const Color(0xFF008F11),
                        ],
                        context,
                        const Color(0xFF006f0f),
                      ),
                      const Gap(15),
                      _buildFlagItem(
                        null,
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppIcon(
                              asset: IconProvider.coins.buildImageUrl(),
                              width: 52,
                              height: 61,
                            ),
                            const Gap(8),
                            TextWithBorder(
                              text: state.user.coins.toString(),
                              borderColor: const Color(0xFF521600),
                              fontSize: 34,
                            ),
                          ],
                        ),
                        [
                          const Color(0xFFE89E14),
                          const Color(0xFFFF4400),
                        ],
                        context,
                        const Color(0xFFbf3500),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Center(
                  child: RoundedPieChart(
                    isHomeScreen: true,
                    value: state.user.points.toDouble() /
                        state.puzzles.fold(
                          0,
                          (sum, element) => sum + element.scoreReward,
                        ),
                        point: state.user.points,
                  ),
                ),
                const Spacer(),
                AppButton(
                  text: 'select riddle',
                  color: ButtonColors.purple,
                  onPressed: () => context.push(
                    '${RouteValue.home.path}/${RouteValue.select.path}',
                  ),
                ),
                const Gap(14),
                AppButton(
                  color: ButtonColors.yellow,
                  text: 'everyday riddle',
                  onPressed: () => context.push(
                    '${RouteValue.home.path}/${RouteValue.dayli.path}',
                    extra: 'd${DateTime.now().weekday}',
                  ),
                ),
                const Gap(14),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildFlagItem(
    void Function()? onTap,
    Widget icon,
    List<Color> gradient,
    BuildContext context,
    Color borderColor, {
    double width = 72,
    double height = 145,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(width, height + 4 + MediaQuery.of(context).padding.top),
            painter: FlagPainter(borderColor, gradientColors: [borderColor]),
          ),
          Positioned(
            top: 0,
            child: CustomPaint(
              size: Size(width, height + MediaQuery.of(context).padding.top),
              painter: FlagPainter(null, gradientColors: gradient),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: icon,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCircle() {
    return const Center(
      child: SizedBox(
        height: 150,
        width: 150,
        child: CircularProgressIndicator(
          value: 0.7,
          strokeWidth: 12,
          color: Colors.pink,
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            context.push('${RouteValue.home.path}/${RouteValue.select.path}');
          },
          child: const Text('Select Level'),
        ),
        ElevatedButton(
          onPressed: () {
            context.push(
              '${RouteValue.home.path}/${RouteValue.dayli.path}',
              extra: 'd${DateTime.now().weekday}',
            );
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          child: const Text('Everyday Riddle'),
        ),
      ],
    );
  }
}

void showBuyHintDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        content: SizedBox(
          width: 295,
          height: 416,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF34018E), Color(0xFF43008B)],
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 2,
                      color: Color(0xFF5621A3),
                    ),
                    borderRadius: BorderRadius.circular(31),
                  ),
                ),
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: getWidth(percent: 100, context),
                      height: 89,
                      margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF230162),
                        borderRadius: BorderRadius.circular(18),
                        border: const Border(
                          left: BorderSide(
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: Color(0xFF6123CE),
                          ),
                          top: BorderSide(
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: Color(0xFF6123CE),
                          ),
                          right: BorderSide(
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: Color(0xFF6123CE),
                          ),
                          bottom: BorderSide(
                            width: 2,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: Color(0xFF6123CE),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                IconProvider.coins.buildImageUrl(),
                                width: 52,
                                height: 61,
                                fit: BoxFit.fill,
                              ),
                              const TextWithBorder(
                                text: '15',
                                borderColor: Colors.black,
                                fontSize: 34,
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_right_alt,
                            color: Colors.white,
                            size: 45,
                          ),
                          const Spacer(),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                IconProvider.hint.buildImageUrl(),
                                width: 35,
                                height: 61,
                                fit: BoxFit.fill,
                              ),
                              const TextWithBorder(
                                text: '1',
                                borderColor: Colors.black,
                                fontSize: 34,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                child: Container(
                  width: 295,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        IconProvider.aab.buildImageUrl(),
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  child: const Center(
                    child: GradientText(
                      'BUY A HINT',
                      fontSize: 33,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 8.39,
                child: Transform(
                  transform: Matrix4.identity()
                    ..translate(0.0)
                    ..rotateZ(-0.20),
                  child: Container(
                    width: 17,
                    height: 6,
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: OvalBorder(),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 7,
                top: 18.01,
                child: Transform(
                  transform: Matrix4.identity()
                    ..translate(0.0)
                    ..rotateZ(-0.62),
                  child: Container(
                    width: 8.63,
                    height: 6,
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: OvalBorder(),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                child: AppButton(
                  color: ButtonColors.yellow,
                  text: (context.read<AppBloc>().state as AppLoaded).user.coins > 15 ?'buy' : 'not enough coins',
                  width: 183,
                  height: 69,
                  onPressed: () {
                    context.pop();
                    if( (context.read<AppBloc>().state  as AppLoaded).user.coins > 15) {
                      context.read<AppBloc>().add(BuyHint());
                    }

                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class FlagPainter extends CustomPainter {
  final List<Color> gradientColors;
  final Color? color;

  FlagPainter(this.color, {super.repaint, required this.gradientColors});

  @override
  void paint(Canvas canvas, Size size) {
    // Градиент для флага
    final gradient = LinearGradient(
      colors: gradientColors, // Цвета из SVG
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    // Прямоугольная область для градиента
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Кисть для градиента
    final paint = Paint()..style = PaintingStyle.fill;

    if (color != null) {
      paint.color = color!;
    } else {
      paint.shader = gradient.createShader(rect);
    }

    // Создаём путь для формы флага
    final path = Path();
    path.moveTo(0, 0); // Верхний левый угол
    path.lineTo(size.width, 0); // Верхний правый угол
    path.lineTo(size.width, size.height); // Нижний правый угол
    path.lineTo(size.width / 2, size.height - 15); // Вершина треугольника
    path.lineTo(0, size.height); // Нижний левый угол
    path.close();

    // Рисуем флаг с градиентом
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class RoundedPieChart extends StatefulWidget {
  final double value;
  final int point;
  final bool isHomeScreen;

  const RoundedPieChart(
      {Key? key,
      required this.value,
      this.isHomeScreen = false,
      required this.point})
      : super(key: key);

  @override
  _RoundedPieChartState createState() => _RoundedPieChartState();
}

class _RoundedPieChartState extends State<RoundedPieChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late double _previousValue;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _previousValue = widget.value;
    _setupAnimation();
  }

  void _setupAnimation() {
    _animation = Tween<double>(
      begin: _previousValue,
      end: widget.value,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(covariant RoundedPieChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _previousValue = oldWidget.value;
      _setupAnimation();
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Stack(
          children: [
            AppIcon(
                asset: IconProvider.diagram.buildImageUrl(),
                width: 313,
                height: 326),
            Padding(
              padding: const EdgeInsets.only(top: 21, left: 11),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GradientText(widget.point.toString(), fontSize: 43),
                  CustomPaint(
                    size:
                         Size(294, 294),
                    painter: PieChartPainter(_animation.value, context,
                        isHomeScreen: widget.isHomeScreen),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class PieChartPainter extends CustomPainter {
  final double value;
  final BuildContext context;
  final bool isHomeScreen;

  PieChartPainter(this.value, this.context, {this.isHomeScreen = false});

  @override
  void paint(Canvas canvas, Size size) {
    final double radius =
        (size.width / 2) - (isIpad(context) && isHomeScreen ? 66 : 66) / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    // Background Section (Always full circle)
    final backgroundPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.transparent, Colors.transparent],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = isIpad(context) && isHomeScreen ? 66 : 66;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      2 * pi,
      false,
      backgroundPaint,
    );

    // Foreground Section (Yellow Arc)
    final sweepAngle = value * 2 * pi;
    final foregroundPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFFFF00A1),
          Color(0xFFFF5CCE),
        ],
      ).createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = isIpad(context) && isHomeScreen ? 67 : 67
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Start at top center
      sweepAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Перерисовка при изменении данных
  }
}
