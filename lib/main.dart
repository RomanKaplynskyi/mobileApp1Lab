import 'package:flutter/material.dart';

// Конструктор класу
class Counter with Decrement {
  int _increment = 1; // приватне поле (починається з _)
  bool canDecrement = true;
  Counter({int increment = 1}) { Використання параметрів за замовчуванням
    assert(increment > 0);     // Використання assert 
    this._increment = increment;
  }
  Counter.initialization(incr) : _increment = incr; // конструктор ініціалізації
  int _counter = 0;
  int get getCounter => _counter; // getter  // Використання лямбда-функцій
  set setIncrement(int val) {     // setter
    assert(val > 0);
    _increment = val;
  }

  int increment() => _counter += _increment; // Синтаксичний цукор (+=)  // Використання лямбда-функцій
}

// Фабричний конструктор
class FactoryCounter extends Counter {
  int _increment = 1;
  static FactoryCounter _factoryCounter = FactoryCounter.start(1);

  FactoryCounter.start(this._increment);

  factory FactoryCounter({int increment = 1}) { // Використання параметрів за замовчуванням
    _factoryCounter.setIncrement = increment;
    return _factoryCounter;
  }
}

mixin Decrement {       // Використання міксинів
  bool canDecrement = true;
  int _counter = 0;
  void decrement() {
    if (canDecrement) {
      _counter--;      // Синтаксичний цукор (--)
    }
  }
}

Map<String, Function> CounterClosure({int increment = 1}) {  // Робота з колекціями
  int counter = 0;
  Map<String, Function> obj = new Map()
    ..["getCounter"] = (() => counter) // Cascade notation  // Використання лямбда-функцій
    ..["increment"] = (() => counter += increment);  // Синтаксичний цукор (+=)
  // obj["getCounter"] = () => counter;
  // obj["increment"] = () => counter += increment;
  return obj;
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Kaplynskyi Roman IP-83'), // Застосунок містити Ім’я Прізвище
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Counter counter = new Counter(increment: 1);
  // FactoryCounter counter = FactoryCounter(increment: 6);
  var counterClosure = CounterClosure(increment: 3);
  void _incrementCounter() {
    setState(() {
      counterClosure["increment"]();
      // counter.increment();
    });
  }

  void _decrementCounter() {
    setState(() {
      // counter.decrement();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                // '${counter.getCounter}',
                '${counterClosure["getCounter"]()}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: _decrementCounter,
              tooltip: 'Decrement',
              child: Icon(Icons.remove),
            ),
          ],
        ));
  }
}
