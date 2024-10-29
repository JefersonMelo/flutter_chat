import 'package:flutter_test/flutter_test.dart'; // substitua pelo caminho correto
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_flutter/services/counter_service.dart';

void main() {
  late CounterService counterService;

  setUp(() {
    // Configura o SharedPreferences com valores iniciais vazios
    SharedPreferences.setMockInitialValues({});
    counterService = CounterService();
  });

  test('Inicializa o contador com 0 se não houver valor salvo', () async {
    counterService = CounterService(); // Chama o método de inicialização
    expect(counterService.value, 0);
  });

  test('Inicializa o contador com valor salvo em SharedPreferences', () async {
    // Define um valor inicial no SharedPreferences simulado
    SharedPreferences.setMockInitialValues({CounterService.keyCounter: 5});

    // Inicializa o serviço e verifica o valor
    counterService = CounterService();
    expect(counterService.value, 5);
  });

  test('Incrementa o contador e salva em SharedPreferences', () async {
    await counterService.increment(); // Incrementa o contador

    // Verifica se o valor incrementado é 1
    expect(counterService.value, 1);

    // Carrega o SharedPreferences para verificar o valor salvo
    final prefs = await SharedPreferences.getInstance();
    final savedValue = prefs.getInt(CounterService.keyCounter);
    expect(savedValue, 1);
  });

  test('Incrementa o contador a partir de um valor inicial', () async {
    // Define um valor inicial
    SharedPreferences.setMockInitialValues({CounterService.keyCounter: 3});

    // Inicializa o serviço e incrementa
    CounterService();
    await counterService.increment();

    // Verifica se o contador foi incrementado corretamente
    expect(counterService.value, 4);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getInt(CounterService.keyCounter), 4);
  });
}
