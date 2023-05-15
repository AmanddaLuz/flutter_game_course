
import 'package:flutter/material.dart';
import 'package:flutter_game_course/components/task.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool opacity = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: Container(),
        title: const Text(style: TextStyle(color: Colors.white), 'Tarefas'),
      ),
      body: AnimatedOpacity(
        opacity: opacity ? 1 : 0,
        duration: const Duration(milliseconds: 800),
        child: ListView(
          children: const [
            Task(
                'Aprender Flutter',
                'https://pbs.twimg.com/media/Eu7m692XIAEvxxP?format=png&name=large',
                5),
            Task(
                'Andar de bike',
                'https://tswbike.com/wp-content/uploads/2020/09/108034687_626160478000800_2490880540739582681_n-e1600200953343.jpg',
                2),
            Task(
                'Meditar',
                'https://cdn2.gnarususercontent.com.br/1/1150020/205b6519-72ca-43c4-a8f3-feab05243db8.png',
                3),
            Task(
                'Ler',
                'https://thebogotapost.com/wp-content/uploads/2017/06/636052464065850579-137719760_flyer-image-1.jpg',
                4),
            SizedBox(
              height: 80,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            opacity = !opacity;
          });
        },
        child: const Icon(Icons.remove_red_eye),
      ),
    );
  }
}