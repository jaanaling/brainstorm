import 'package:brainstorm_quest/main.dart';
import 'package:brainstorm_quest/routes/go_router_config.dart';
import 'package:brainstorm_quest/routes/route_value.dart';
import 'package:brainstorm_quest/src/feature/game/bloc/app_bloc.dart';
import 'package:brainstorm_quest/src/feature/game/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state is AppLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        if (state is AppError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }
        if (state is AppLoaded) {
          return ScreenLayout(
            topSection: _buildHeader(context, state.user),
            middleSection: _buildProgressCircle(),
            bottomSection: _buildButtons(context),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildHeader(BuildContext context, User user) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CupertinoButton(
              onPressed: () => context.push(
                  "${RouteValue.home.path}/${RouteValue.achievements.path}"),
              child: Icon(Icons.emoji_events, color: Colors.orange)),
          CupertinoButton(
            onPressed: () => showBuyHintDialog(context),
            child: Column(children: [
              Text(user.hints.toString(),
                  style: TextStyle(color: Colors.yellow, fontSize: 20)),
              Icon(Icons.lightbulb, color: Colors.green),
            ]),
          ),
          Column(
            children: [
              Text(user.coins.toString(),
                  style: TextStyle(color: Colors.yellow, fontSize: 20)),
              Icon(Icons.monetization_on, color: Colors.yellow),
            ],
          ),
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
            child: Text("Select Level")),
        ElevatedButton(
          onPressed: () {
            context.push("${RouteValue.home.path}/${RouteValue.dayli.path}", extra: "d${DateTime.now().weekday}");
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
