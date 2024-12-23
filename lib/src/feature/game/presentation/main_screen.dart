import 'package:brainstorm_quest/main.dart';
import 'package:brainstorm_quest/routes/go_router_config.dart';
import 'package:brainstorm_quest/routes/route_value.dart';
import 'package:brainstorm_quest/src/core/utils/app_icon.dart';
import 'package:brainstorm_quest/src/core/utils/icon_provider.dart';
import 'package:brainstorm_quest/src/feature/game/bloc/app_bloc.dart';
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
                    _buildFlagItem(() {
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
                          Color(0xFF14A8E8),
                          Color(0xFF00438F),
                        ],
                        context,
                        Color(0xFF01336e),
                        width: 75,
                        height: 118),
                    Spacer(),
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
                          Gap(8),
                          TextWithBorder(
                              text: state.user.hints.toString(),
                              borderColor: Color(0xFF00520F),
                              fontSize: 34)
                        ],
                      ),
                      [
                        Color(0xFF14E83B),
                        Color(0xFF008F11),
                      ],
                      context,
                      Color(0xFF006f0f),
                    ),
                    Gap(15),
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
                          Gap(8),
                          TextWithBorder(
                              text: state.user.coins.toString(),
                              borderColor: Color(0xFF521600),
                              fontSize: 34)
                        ],
                      ),
                      [
                        Color(0xFFE89E14),
                        Color(0xFFFF4400),
                      ],
                      context,
                      Color(0xFFbf3500),
                    ),
                  ],
                ),
              ),
              AppButton()
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
          )
        ],
      ),
    );
  }

  Widget _buildProgressCircle() {
    return Center(
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
          child: Text("Select Level"),
        ),
        ElevatedButton(
          onPressed: () {
            context.push(
              "${RouteValue.home.path}/${RouteValue.dayli.path}",
              extra: "d${DateTime.now().weekday}",
            );
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          child: Text("Everyday Riddle"),
        ),
      ],
    );
  }
}

void showBuyHintDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Center(
          child: Text(
            "BUY A HINT",
            style: TextStyle(color: Colors.yellow, fontSize: 22),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.monetization_on, color: Colors.orange, size: 30),
                SizedBox(width: 8),
                Text(
                  "10",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Icon(Icons.arrow_forward, color: Colors.white, size: 30),
                SizedBox(width: 8),
                Icon(Icons.lightbulb, color: Colors.yellow, size: 30),
                SizedBox(width: 4),
                Text(
                  "1",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<AppBloc>().add(BuyHint());
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: Text("Buy"),
            ),
          ],
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
