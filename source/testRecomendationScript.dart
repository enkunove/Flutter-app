import 'package:project/widgets/testRecomendation.dart';
import 'testsHolder.dart';
import 'dart:math';

class Generate {
  final List<String> symptoms;

  const Generate(this.symptoms);

  List<Test> matchesSymptoms(List<String> selectedSymptoms) {
    Map<String, List<String>> symptomMapping = {
      'PTSD': [
        "Флешбэки",
        "Триггеры",
        "Возбудимость нервной системы",
        "Перевозбуждение",
        "Амнезия",
        "Фобии",
        "Изменения в поведении",
        "Нарушения внимания",
        "Эмоциональная нестабильность",
        "Нарушения сна"
      ],
      'Dysthymia': [
        "Сниженное настроение",
        "Сниженная самооценка",
        "Отсутствие удовольствия"
      ],
      'ADHD': [
        "Гиперактивность",
        "Нарушение внимания",
        "Легкие неврологические нарушения",
        "Эмоциональная лабильность",
        "Нарушение восприятия",
        "Повышенная импульсивность",
        "Утомляемость",
        "Нарушения речи"
      ],
      'Burnout': [
        "Утомляемость",
        "Истощение",
        "Потеря интереса к работе",
        "Безразличие к задачам",
        "Снижение работоспособности"
      ],
      'Depression': [
        "Утомляемость",
        "Навязчивые мысли",
        "Нарушения сна",
        "Снижение концентрации",
        "Изменение аппетита",
        "Отсутствие удовольствия"
      ],
      'Anxiety': [
        "Страх",
        "Перепады настроения",
        "Плаксивость",
        "Раздражительность",
        "Пониженное настроение",
        "Нарушения сна",
        "Слабость",
        "Снижение интересов",
        "Головная боль",
        "Ощущение кома",
        "Боли",
        "Вегетативные симптомы"
      ],
      'Self-Doubt': [
        "Неуверенность",
        "Пассивность",
        "Несамостоятельность",
        "Инфантилизм",
        "Агрессивность",
        "Низкая самооценка",
        "Боязнь общения",
        "Эгоизм",
        "Страх",
        "Вина",
        "Стыд"
      ],
      'NervousStrain': [
        "Эмоциональные реакции",
        "Агрессия",
        "Нарушения сна",
        "Истощение",
        "Рассеянность",
        "Низкая продуктивность",
        "Память",
        "Неспособность расслабиться"
      ],
      'PsychologicalInstability': [
        "Самоконтроль",
        "Стресс",
        "Импульсивность",
        "Смена настроения",
        "Гнев",
        "Фрустрация",
        "Растерянность",
        "Нарушение мышления"
      ]
    };

    Map<String, List<Test>> disorderTests = {
      'PTSD': ptsrTests,
      'Dysthymia': distTests,
      'ADHD': sdvgTests,
      'Burnout': burnoutTests,
      'Depression': depressionTests,
      'Anxiety': trevTests,
      'Self-Doubt': neuverennostTests,
      'NervousStrain': napryazhenieTests,
      'PsychologicalInstability': ustoichTests
    };

    List<Test> matchingTests = [];

    symptomMapping.forEach((disorder, symptoms) {
      int matchingCount = selectedSymptoms
          .where((symptom) => symptoms.contains(symptom))
          .length;

      if (matchingCount > 0) {
        List<Test> tests = disorderTests[disorder]!;

        if (matchingCount >= 4) {
          matchingTests.addAll(tests);
        } else if (matchingCount == 3) {
          matchingTests.addAll(tests.take(2));
        } else {
          matchingTests.add(tests[0]);
        }
      }
    });

    matchingTests = matchingTests.toSet().toList();

    matchingTests.shuffle(Random());

    return matchingTests;
  }
}
