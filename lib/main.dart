import 'package:flutter/material.dart';

void main() {
  runApp(const QuizBandeirasApp());
}

class QuizBandeirasApp extends StatelessWidget {
  const QuizBandeirasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Bandeiras',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const TelaInicial(),
        '/jogo': (context) => const TelaJogo(),
      },
    );
  }
}

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Bandeiras'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bem-vindo ao Quiz Bandeiras!',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/jogo');
              },
              child: const Text('Iniciar'),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaJogo extends StatefulWidget {
  const TelaJogo({super.key});

  @override
  State<TelaJogo> createState() => _TelaJogoState();
}

class _TelaJogoState extends State<TelaJogo> {
  final List<Map<String, String>> _perguntas = [
    {'bandeira': 'assets/brasil.png', 'resposta': 'Brasil'},
    {'bandeira': 'assets/venezuela.png', 'resposta': 'Venezuela'},
    {'bandeira': 'assets/argentina.png', 'resposta': 'Argentina'},
    {'bandeira': 'assets/paraguai.png', 'resposta': 'Paraguai'},
  ];

  int _indiceAtual = 0;
  String? _respostaSelecionada;
  bool _acertou = false;

  void _verificarResposta(String resposta) {
    setState(() {
      _respostaSelecionada = resposta;
      _acertou = _perguntas[_indiceAtual]['resposta'] == resposta;
    });
  }

  void _proximaPergunta() {
    setState(() {
      _indiceAtual = (_indiceAtual + 1) % _perguntas.length;
      _respostaSelecionada = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final perguntaAtual = _perguntas[_indiceAtual];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Bandeiras'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              perguntaAtual['bandeira']!,
              height: 200,
            ),
            const SizedBox(height: 20),
            if (_respostaSelecionada == null)
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () => _verificarResposta('Brasil'),
                    child: const Text('Brasil'),
                  ),
                  ElevatedButton(
                    onPressed: () => _verificarResposta('Venezuela'),
                    child: const Text('Venezuela'),
                  ),
                  ElevatedButton(
                    onPressed: () => _verificarResposta('Argentina'),
                    child: const Text('Argentina'),
                  ),
                  ElevatedButton(
                    onPressed: () => _verificarResposta('Paraguai'),
                    child: const Text('Paraguai'),
                  ),
                ],
              )
            else
              Column(
                children: [
                  Text(
                    _acertou ? 'Você acertou!' : 'Você errou!',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _proximaPergunta,
                    child: const Text('Próxima Bandeira'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
