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
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFlagItem(
                      () {
                        context.push(
                          "${RouteValue.home.path}/${RouteValue.achievements.path}",
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
              RoundedPieChart(
                isHomeScreen: true,
                points: state.user.points,
                value: state.user.points.toDouble() /
                    state.puzzles.fold(
                      0,
                      (sum, element) => sum + element.scoreReward,
                    ),
              ),
              //  CustomProgressIndicator(
              //    value: state.user.points.toDouble(),
              //  ),

              const Gap(15),
              const AppButton(),
            ],
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
            context.push("${RouteValue.home.path}/${RouteValue.select.path}");
          },
          child: const Text("Select Level"),
        ),
        ElevatedButton(
          onPressed: () {
            context.push(
              "${RouteValue.home.path}/${RouteValue.dayli.path}",
              extra: "d${DateTime.now().weekday}",
            );
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          child: const Text("Everyday Riddle"),
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
                  shadows: const [
                    BoxShadow(
                      color: Color(0xFF2A004A),
                      offset: Offset(0, 4),
                    ),
                  ],
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
                      child: Row(children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              IconProvider.coins.buildImageUrl(),
                              width: 52,
                              height: 61,
                              fit: BoxFit.fill,
                            ),
                            TextWithBorder(
                              text: "15",
                              borderColor: Colors.black,
                              fontSize: 34,
                            )
                          ],
                        ),
                        const Spacer(),
                        Icon(Icons.arrow_right_alt,
                            color: Colors.white, size: 45),
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
                            TextWithBorder(
                              text: "1",
                              borderColor: Colors.black,
                              fontSize: 34,
                            )
                          ],
                        )
                      ]),
                    ),
                  ],
                ),
              ),
              Container(
                width: 295,
                height: 95,
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
              //  Positioned(bottom: 0, child: AppButton())
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
  final double value; // Прогресс в диапазоне 0..1
  final bool isHomeScreen; // Условие для iPad-разметки (ваше логика)
  final int points;

  const RoundedPieChart({
    Key? key,
    required this.value,
    required this.points,
    this.isHomeScreen = false,
  }) : super(key: key);

  @override
  _RoundedPieChartState createState() => _RoundedPieChartState();
}

class _RoundedPieChartState extends State<RoundedPieChart>
    with TickerProviderStateMixin {
  // Основная анимация "значения" (прогресса)
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  late double _previousValue;

  // Дополнительная анимация для «дышащей» белой обводки
  late AnimationController _borderController;
  late Animation<double> _borderWidthAnimation;

  @override
  void initState() {
    super.initState();

    // 1) Контроллер для «значения прогресса»
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _previousValue = widget.value;
    _setupProgressAnimation();

    // 2) Контроллер для «дышащей» белой обводки
    _borderController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _borderWidthAnimation = Tween<double>(begin: 8, end: 12).animate(
      CurvedAnimation(
        parent: _borderController,
        curve: Curves.easeInOut,
      ),
    );

    // Запускаем анимацию прогресса при первом показе
    _progressController.forward();
  }

  void _setupProgressAnimation() {
    _progressAnimation = Tween<double>(
      begin: _previousValue,
      end: widget.value,
    ).animate(
      CurvedAnimation(
        parent: _progressController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant RoundedPieChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _previousValue = oldWidget.value;
      _setupProgressAnimation();
      _progressController
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    _borderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Вместо того, чтобы рисовать текст в `CustomPainter`,
    // удобнее обернуть всё в Stack: CustomPaint + Text по центру
    final size = isIpad(context) && widget.isHomeScreen
        ? const Size(460, 460)
        : const Size(230, 230);

    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, child) {
        return SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 1) Наш кастомный прогресс-индикатор
              AnimatedBuilder(
                animation: _borderWidthAnimation,
                builder: (context, _) {
                  return CustomPaint(
                    size: size,
                    painter: PieChartPainter(
                      progressValue: _progressAnimation.value,
                      borderWidth: _borderWidthAnimation.value,
                      context: context,
                      isHomeScreen: widget.isHomeScreen,
                    ),
                  );
                },
              ),
              // 2) Текст в центре (числовое значение)
              GradientText(widget.points.toString(), fontSize: 47)
            ],
          ),
        );
      },
    );
  }
}

class PieChartPainter extends CustomPainter {
  final double progressValue; // 0..1 — какую часть круга закрашивать
  final double borderWidth; // Анимированная толщина белой обводки
  final BuildContext context;
  final bool isHomeScreen;

  PieChartPainter({
    required this.progressValue,
    required this.borderWidth,
    required this.context,
    required this.isHomeScreen,
  });

  @override
void paint(Canvas canvas, Size size) {
  final radius = size.width / 2;
  final center = Offset(radius, radius);

  // 1) Сначала РОЗОВЫЙ и ФИОЛЕТОВЫЙ
  // -------------------------------
  final pinkSweepAngle = progressValue * 2 * pi;
  final pinkPaint = Paint()
    ..color = Colors.pink
    ..style = PaintingStyle.stroke
    ..strokeWidth = isIpad(context) && isHomeScreen ? 100 : 50
    ..strokeCap = StrokeCap.round;

  final arcRect = Rect.fromCircle(center: center, radius: radius * 0.8);
  
  // Рисуем розовый сектор
  canvas.drawArc(
    arcRect,
    -pi / 2,
    pinkSweepAngle,
    false,
    pinkPaint,
  );

  // Фиолетовый сектор
  final purpleSweepAngle = 2 * pi - pinkSweepAngle;
  final purplePaint = Paint()
    ..color = Colors.deepPurpleAccent
    ..style = PaintingStyle.stroke
    ..strokeWidth = isIpad(context) && isHomeScreen ? 100 : 50
    ..strokeCap = StrokeCap.round;

  final purpleStartAngle = -pi / 2 + pinkSweepAngle;
  canvas.drawArc(
    arcRect,
    purpleStartAngle,
    purpleSweepAngle,
    false,
    purplePaint,
  );

  // 2) Теперь БЕЛАЯ «дышащая» обводка поверх
  // ----------------------------------------
  final whitePaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = borderWidth // Анимированная толщина
    ..strokeCap = StrokeCap.round;

  // Рисуем полный круг белой обводкой поверх дуг
  canvas.drawCircle(
    center,
    radius - borderWidth / 2, 
    whitePaint,
  );
}


  @override
  bool shouldRepaint(covariant PieChartPainter oldDelegate) {
    return oldDelegate.progressValue != progressValue ||
        oldDelegate.borderWidth != borderWidth;
  }
}

class CustomProgressIndicator extends StatefulWidget {
  final double value; // Значение, которое хотим отобразить (например, 1000).
  final double size; // Размер всего круга.

  const CustomProgressIndicator({
    Key? key,
    required this.value,
    this.size = 200,
  }) : super(key: key);

  @override
  State<CustomProgressIndicator> createState() =>
      _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _whiteBorderAnimation;

  @override
  void initState() {
    super.initState();
    // Контроллер для анимации белой обводки
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true); // Повторяем туда-сюда

    // Анимация будет «дышать» в диапазоне от 8 до 12
    _whiteBorderAnimation = Tween<double>(begin: 8, end: 12).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Чтобы получать обновления анимации, используем AnimatedBuilder
    return AnimatedBuilder(
      animation: _whiteBorderAnimation,
      builder: (context, child) {
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: CustomPaint(
            painter: _ProgressPainter(
              pinkArcSweep: 270, // Пример: розовая дуга ~ 270°
              purpleArcSweep: 90, // Оставшиеся 90° – фиолетовая
              whiteStrokeWidth: _whiteBorderAnimation.value,
            ),
            child: Center(
                child: GradientText(widget.value.toString(), fontSize: 47)),
          ),
        );
      },
    );
  }
}

/// Кастомный Painter для отрисовки двух дуг и белой обводки
class _ProgressPainter extends CustomPainter {
  final double pinkArcSweep; // длина розовой дуги, в градусах
  final double purpleArcSweep; // длина фиолетовой дуги, в градусах
  final double whiteStrokeWidth;

  _ProgressPainter({
    required this.pinkArcSweep,
    required this.purpleArcSweep,
    required this.whiteStrokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    // ---------- 1) Рисуем белый круг (обводку), которую будем анимировать ----------
    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = whiteStrokeWidth
      ..strokeCap = StrokeCap.round;

    // Полный круг (360°) белой обводки
    canvas.drawCircle(center, radius - whiteStrokeWidth / 2, whitePaint);

    // ---------- 2) Рисуем розовую дугу ----------
    final pinkPaint = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.6 // толщина розового «сектора»
      ..strokeCap = StrokeCap.round;

    // Преобразуем градусы в радианы: угол = градусов * (pi / 180)
    final pinkStartAngle = -pi / 2; // начинаем с верхней точки (-90°)
    final pinkSweepRads = pinkArcSweep * pi / 180;

    // Прямоугольник, описывающий нашу дугу
    final arcRect = Rect.fromCircle(center: center, radius: radius * 0.7);

    canvas.drawArc(
      arcRect,
      pinkStartAngle,
      pinkSweepRads,
      false,
      pinkPaint,
    );

    // ---------- 3) Рисуем фиолетовую дугу ----------
    final purplePaint = Paint()
      ..color = Colors.deepPurpleAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.6
      ..strokeCap = StrokeCap.round;

    final purpleStartAngle = pinkStartAngle + pinkSweepRads;
    final purpleSweepRads = purpleArcSweep * pi / 180;

    canvas.drawArc(
      arcRect,
      purpleStartAngle,
      purpleSweepRads,
      false,
      purplePaint,
    );
  }

  @override
  bool shouldRepaint(_ProgressPainter oldDelegate) {
    // Перерисовываем, если изменились параметры
    return oldDelegate.pinkArcSweep != pinkArcSweep ||
        oldDelegate.purpleArcSweep != purpleArcSweep ||
        oldDelegate.whiteStrokeWidth != whiteStrokeWidth;
  }
}
