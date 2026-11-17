import Foundation

extension TaskStore {
    public static let csharpTasks: [CodingTask] = [
        CodingTask(
            id: "cs_task_sum_two",
            language: .csharp,
            titleRU: "Сумма двух чисел",
            titleEN: "Sum of Two Numbers",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Сложение двух чисел a и b.",
            summaryEN: "Sum two numbers a and b.",
            descriptionRU: ##"""
### Условие
Напишите метод `Add(int a, int b)`.
Сложение двух чисел a и b.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `Add(int a, int b)`.
Sum two numbers a and b.
"""##,
            requirementsRU: ["Сигнатура: public static int Add(int a, int b)"],
            requirementsEN: ["Signature: public static int Add(int a, int b)"],
            starterCode: ##"""
public static int Add(int a, int b) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Add(3, 7)", expectedOutput: "10", validationCode: "Add(3, 7) == 10"),
                    TaskTestCase(title: "Тест 2", inputDescription: "Add(-5, 5)", expectedOutput: "0", validationCode: "Add(-5, 5) == 0"),
                    TaskTestCase(title: "Тест 3", inputDescription: "Add(-12, -8)", expectedOutput: "-20", validationCode: "Add(-12, -8) == -20")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int Add(int a, int b) {
    return a + b;
}
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "cs_task_is_even",
            language: .csharp,
            titleRU: "Проверка на чётность",
            titleEN: "Check if Even",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Проверка делимости на 2 без остатка.",
            summaryEN: "Check divisibility by 2 without remainder.",
            descriptionRU: ##"""
### Условие
Напишите метод `IsEven(int n)`.
Проверка делимости на 2 без остатка.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `IsEven(int n)`.
Check divisibility by 2 without remainder.
"""##,
            requirementsRU: ["Сигнатура: public static bool IsEven(int n)"],
            requirementsEN: ["Signature: public static bool IsEven(int n)"],
            starterCode: ##"""
public static bool IsEven(int n) {
    // Ваш код на C#
    return false;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "IsEven(4)", expectedOutput: "true", validationCode: "IsEven(4) == true"),
                    TaskTestCase(title: "Тест 2", inputDescription: "IsEven(7)", expectedOutput: "false", validationCode: "IsEven(7) == false"),
                    TaskTestCase(title: "Тест 3", inputDescription: "IsEven(0)", expectedOutput: "true", validationCode: "IsEven(0) == true")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static bool IsEven(int n) {
    return n % 2 == 0;
}
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "cs_task_celsius_to_fahr",
            language: .csharp,
            titleRU: "Цельсий в Фаренгейт",
            titleEN: "Celsius to Fahrenheit",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Формула: c * 9 / 5 + 32.",
            summaryEN: "Formula: c * 9 / 5 + 32.",
            descriptionRU: ##"""
### Условие
Напишите метод `ToFahrenheit(int c)`.
Формула: c * 9 / 5 + 32.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `ToFahrenheit(int c)`.
Formula: c * 9 / 5 + 32.
"""##,
            requirementsRU: ["Сигнатура: public static int ToFahrenheit(int c)"],
            requirementsEN: ["Signature: public static int ToFahrenheit(int c)"],
            starterCode: ##"""
public static int ToFahrenheit(int c) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "ToFahrenheit(0)", expectedOutput: "32", validationCode: "ToFahrenheit(0) == 32"),
                    TaskTestCase(title: "Тест 2", inputDescription: "ToFahrenheit(100)", expectedOutput: "212", validationCode: "ToFahrenheit(100) == 212"),
                    TaskTestCase(title: "Тест 3", inputDescription: "ToFahrenheit(20)", expectedOutput: "68", validationCode: "ToFahrenheit(20) == 68")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int ToFahrenheit(int c) {
    return c * 9 / 5 + 32;
}
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "cs_task_perimeter_rect",
            language: .csharp,
            titleRU: "Периметр прямоугольника",
            titleEN: "Rectangle Perimeter",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Формула: 2 * (w + h).",
            summaryEN: "Formula: 2 * (w + h).",
            descriptionRU: ##"""
### Условие
Напишите метод `Perimeter(int w, int h)`.
Формула: 2 * (w + h).
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `Perimeter(int w, int h)`.
Formula: 2 * (w + h).
"""##,
            requirementsRU: ["Сигнатура: public static int Perimeter(int w, int h)"],
            requirementsEN: ["Signature: public static int Perimeter(int w, int h)"],
            starterCode: ##"""
public static int Perimeter(int w, int h) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Perimeter(5, 10)", expectedOutput: "30", validationCode: "Perimeter(5, 10) == 30"),
                    TaskTestCase(title: "Тест 2", inputDescription: "Perimeter(3, 4)", expectedOutput: "14", validationCode: "Perimeter(3, 4) == 14"),
                    TaskTestCase(title: "Тест 3", inputDescription: "Perimeter(1, 1)", expectedOutput: "4", validationCode: "Perimeter(1, 1) == 4")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int Perimeter(int w, int h) {
    return 2 * (w + h);
}
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "cs_task_max_of_three",
            language: .csharp,
            titleRU: "Максимум из трёх чисел",
            titleEN: "Maximum of Three Numbers",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Поиск наибольшего из трех аргументов.",
            summaryEN: "Find largest of three arguments.",
            descriptionRU: ##"""
### Условие
Напишите метод `MaxOfThree(int a, int b, int c)`.
Поиск наибольшего из трех аргументов.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `MaxOfThree(int a, int b, int c)`.
Find largest of three arguments.
"""##,
            requirementsRU: ["Сигнатура: public static int MaxOfThree(int a, int b, int c)"],
            requirementsEN: ["Signature: public static int MaxOfThree(int a, int b, int c)"],
            starterCode: ##"""
public static int MaxOfThree(int a, int b, int c) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "MaxOfThree(1, 5, 3)", expectedOutput: "5", validationCode: "MaxOfThree(1, 5, 3) == 5"),
                    TaskTestCase(title: "Тест 2", inputDescription: "MaxOfThree(10, 2, 7)", expectedOutput: "10", validationCode: "MaxOfThree(10, 2, 7) == 10"),
                    TaskTestCase(title: "Тест 3", inputDescription: "MaxOfThree(-5, -2, -9)", expectedOutput: "-2", validationCode: "MaxOfThree(-5, -2, -9) == -2")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int MaxOfThree(int a, int b, int c) {
    return max(a, max(b, c));
}
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "cs_task_is_divisible",
            language: .csharp,
            titleRU: "Проверка делимости",
            titleEN: "Check Divisibility",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Определение кратности n числу d без остатка.",
            summaryEN: "Check if n is divisible by d.",
            descriptionRU: ##"""
### Условие
Напишите метод `IsDivisible(int n, int d)`.
Определение кратности n числу d без остатка.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `IsDivisible(int n, int d)`.
Check if n is divisible by d.
"""##,
            requirementsRU: ["Сигнатура: public static bool IsDivisible(int n, int d)"],
            requirementsEN: ["Signature: public static bool IsDivisible(int n, int d)"],
            starterCode: ##"""
public static bool IsDivisible(int n, int d) {
    // Ваш код на C#
    return false;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "IsDivisible(15, 3)", expectedOutput: "true", validationCode: "IsDivisible(15, 3) == true"),
                    TaskTestCase(title: "Тест 2", inputDescription: "IsDivisible(10, 3)", expectedOutput: "false", validationCode: "IsDivisible(10, 3) == false"),
                    TaskTestCase(title: "Тест 3", inputDescription: "IsDivisible(100, 25)", expectedOutput: "true", validationCode: "IsDivisible(100, 25) == true")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static bool IsDivisible(int n, int d) {
    return n % d == 0;
}
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "cs_task_hypotenuse_sq",
            language: .csharp,
            titleRU: "Квадрат гипотенузы",
            titleEN: "Hypotenuse Squared",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Теорема Пифагора: a*a + b*b.",
            summaryEN: "Pythagorean theorem: a*a + b*b.",
            descriptionRU: ##"""
### Условие
Напишите метод `HypotSq(int a, int b)`.
Теорема Пифагора: a*a + b*b.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `HypotSq(int a, int b)`.
Pythagorean theorem: a*a + b*b.
"""##,
            requirementsRU: ["Сигнатура: public static int HypotSq(int a, int b)"],
            requirementsEN: ["Signature: public static int HypotSq(int a, int b)"],
            starterCode: ##"""
public static int HypotSq(int a, int b) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "HypotSq(3, 4)", expectedOutput: "25", validationCode: "HypotSq(3, 4) == 25"),
                    TaskTestCase(title: "Тест 2", inputDescription: "HypotSq(5, 12)", expectedOutput: "169", validationCode: "HypotSq(5, 12) == 169"),
                    TaskTestCase(title: "Тест 3", inputDescription: "HypotSq(6, 8)", expectedOutput: "100", validationCode: "HypotSq(6, 8) == 100")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int HypotSq(int a, int b) {
    return a * a + b * b;
}
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "cs_task_sum_to_n",
            language: .csharp,
            titleRU: "Сумма чисел от 1 до N",
            titleEN: "Sum from 1 to N",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Арифметическая сумма: n * (n + 1) / 2.",
            summaryEN: "Sum: n * (n + 1) / 2.",
            descriptionRU: ##"""
### Условие
Напишите метод `SumToN(int n)`.
Арифметическая сумма: n * (n + 1) / 2.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `SumToN(int n)`.
Sum: n * (n + 1) / 2.
"""##,
            requirementsRU: ["Сигнатура: public static int SumToN(int n)"],
            requirementsEN: ["Signature: public static int SumToN(int n)"],
            starterCode: ##"""
public static int SumToN(int n) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "SumToN(5)", expectedOutput: "15", validationCode: "SumToN(5) == 15"),
                    TaskTestCase(title: "Тест 2", inputDescription: "SumToN(10)", expectedOutput: "55", validationCode: "SumToN(10) == 55"),
                    TaskTestCase(title: "Тест 3", inputDescription: "SumToN(1)", expectedOutput: "1", validationCode: "SumToN(1) == 1")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int SumToN(int n) {
    return n * (n + 1) / 2;
}
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "cs_task_abs_diff",
            language: .csharp,
            titleRU: "Абсолютная разность",
            titleEN: "Absolute Difference",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Модуль разности |a - b|.",
            summaryEN: "Absolute difference |a - b|.",
            descriptionRU: ##"""
### Условие
Напишите метод `AbsDiff(int a, int b)`.
Модуль разности |a - b|.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `AbsDiff(int a, int b)`.
Absolute difference |a - b|.
"""##,
            requirementsRU: ["Сигнатура: public static int AbsDiff(int a, int b)"],
            requirementsEN: ["Signature: public static int AbsDiff(int a, int b)"],
            starterCode: ##"""
public static int AbsDiff(int a, int b) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "AbsDiff(10, 4)", expectedOutput: "6", validationCode: "AbsDiff(10, 4) == 6"),
                    TaskTestCase(title: "Тест 2", inputDescription: "AbsDiff(4, 10)", expectedOutput: "6", validationCode: "AbsDiff(4, 10) == 6"),
                    TaskTestCase(title: "Тест 3", inputDescription: "AbsDiff(-5, 5)", expectedOutput: "10", validationCode: "AbsDiff(-5, 5) == 10")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int AbsDiff(int a, int b) {
    return abs(a - b);
}
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "cs_task_last_digit",
            language: .csharp,
            titleRU: "Последняя цифра числа",
            titleEN: "Last Digit of a Number",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Остаток от деления модуля числа на 10.",
            summaryEN: "Modulo 10 of absolute value.",
            descriptionRU: ##"""
### Условие
Напишите метод `LastDigit(int n)`.
Остаток от деления модуля числа на 10.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `LastDigit(int n)`.
Modulo 10 of absolute value.
"""##,
            requirementsRU: ["Сигнатура: public static int LastDigit(int n)"],
            requirementsEN: ["Signature: public static int LastDigit(int n)"],
            starterCode: ##"""
public static int LastDigit(int n) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "LastDigit(147)", expectedOutput: "7", validationCode: "LastDigit(147) == 7"),
                    TaskTestCase(title: "Тест 2", inputDescription: "LastDigit(-42)", expectedOutput: "2", validationCode: "LastDigit(-42) == 2"),
                    TaskTestCase(title: "Тест 3", inputDescription: "LastDigit(0)", expectedOutput: "0", validationCode: "LastDigit(0) == 0")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int LastDigit(int n) {
    return abs(n) % 10;
}
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "cs_task_power",
            language: .csharp,
            titleRU: "Возведение в степень",
            titleEN: "Power Function",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Умножение числа base самого на себя exp раз.",
            summaryEN: "Multiply base by itself exp times.",
            descriptionRU: ##"""
### Условие
Напишите метод `Power(int base, int exp)`.
Умножение числа base самого на себя exp раз.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `Power(int base, int exp)`.
Multiply base by itself exp times.
"""##,
            requirementsRU: ["Сигнатура: public static int Power(int base, int exp)"],
            requirementsEN: ["Signature: public static int Power(int base, int exp)"],
            starterCode: ##"""
public static int Power(int base, int exp) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Power(2, 3)", expectedOutput: "8", validationCode: "Power(2, 3) == 8"),
                    TaskTestCase(title: "Тест 2", inputDescription: "Power(5, 2)", expectedOutput: "25", validationCode: "Power(5, 2) == 25"),
                    TaskTestCase(title: "Тест 3", inputDescription: "Power(7, 0)", expectedOutput: "1", validationCode: "Power(7, 0) == 1")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int Power(int base, int exp) {
    res = 1
    for i in 1...exp:
        res = res * base
    return res
}
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "cs_task_is_multiple_of_5",
            language: .csharp,
            titleRU: "Кратность 5",
            titleEN: "Is Multiple of 5",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Проверка делимости на 5: n % 5 == 0.",
            summaryEN: "Check divisibility by 5.",
            descriptionRU: ##"""
### Условие
Напишите метод `IsMultiple5(int n)`.
Проверка делимости на 5: n % 5 == 0.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `IsMultiple5(int n)`.
Check divisibility by 5.
"""##,
            requirementsRU: ["Сигнатура: public static bool IsMultiple5(int n)"],
            requirementsEN: ["Signature: public static bool IsMultiple5(int n)"],
            starterCode: ##"""
public static bool IsMultiple5(int n) {
    // Ваш код на C#
    return false;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "IsMultiple5(25)", expectedOutput: "true", validationCode: "IsMultiple5(25) == true"),
                    TaskTestCase(title: "Тест 2", inputDescription: "IsMultiple5(12)", expectedOutput: "false", validationCode: "IsMultiple5(12) == false"),
                    TaskTestCase(title: "Тест 3", inputDescription: "IsMultiple5(0)", expectedOutput: "true", validationCode: "IsMultiple5(0) == true")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static bool IsMultiple5(int n) {
    return n % 5 == 0;
}
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "cs_task_cube_number",
            language: .csharp,
            titleRU: "Куб числа",
            titleEN: "Cube of Number",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Возведение числа в третью степень n * n * n.",
            summaryEN: "Cube of integer n * n * n.",
            descriptionRU: ##"""
### Условие
Напишите метод `Cube(int n)`.
Возведение числа в третью степень n * n * n.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `Cube(int n)`.
Cube of integer n * n * n.
"""##,
            requirementsRU: ["Сигнатура: public static int Cube(int n)"],
            requirementsEN: ["Signature: public static int Cube(int n)"],
            starterCode: ##"""
public static int Cube(int n) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Cube(3)", expectedOutput: "27", validationCode: "Cube(3) == 27"),
                    TaskTestCase(title: "Тест 2", inputDescription: "Cube(-2)", expectedOutput: "-8", validationCode: "Cube(-2) == -8"),
                    TaskTestCase(title: "Тест 3", inputDescription: "Cube(0)", expectedOutput: "0", validationCode: "Cube(0) == 0")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int Cube(int n) {
    return n * n * n;
}
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "cs_task_average_of_two",
            language: .csharp,
            titleRU: "Среднее двух чисел",
            titleEN: "Average of Two Numbers",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Вычисление (a + b) / 2.",
            summaryEN: "Calculate (a + b) / 2.",
            descriptionRU: ##"""
### Условие
Напишите метод `AvgTwo(int a, int b)`.
Вычисление (a + b) / 2.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `AvgTwo(int a, int b)`.
Calculate (a + b) / 2.
"""##,
            requirementsRU: ["Сигнатура: public static int AvgTwo(int a, int b)"],
            requirementsEN: ["Signature: public static int AvgTwo(int a, int b)"],
            starterCode: ##"""
public static int AvgTwo(int a, int b) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "AvgTwo(10, 20)", expectedOutput: "15", validationCode: "AvgTwo(10, 20) == 15"),
                    TaskTestCase(title: "Тест 2", inputDescription: "AvgTwo(4, 6)", expectedOutput: "5", validationCode: "AvgTwo(4, 6) == 5"),
                    TaskTestCase(title: "Тест 3", inputDescription: "AvgTwo(0, 100)", expectedOutput: "50", validationCode: "AvgTwo(0, 100) == 50")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int AvgTwo(int a, int b) {
    return (a + b) / 2;
}
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "cs_task_is_positive",
            language: .csharp,
            titleRU: "Проверка на положительность",
            titleEN: "Check if Positive",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Число строго больше 0: n > 0.",
            summaryEN: "Number strictly greater than 0.",
            descriptionRU: ##"""
### Условие
Напишите метод `IsPositive(int n)`.
Число строго больше 0: n > 0.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `IsPositive(int n)`.
Number strictly greater than 0.
"""##,
            requirementsRU: ["Сигнатура: public static bool IsPositive(int n)"],
            requirementsEN: ["Signature: public static bool IsPositive(int n)"],
            starterCode: ##"""
public static bool IsPositive(int n) {
    // Ваш код на C#
    return false;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "IsPositive(42)", expectedOutput: "true", validationCode: "IsPositive(42) == true"),
                    TaskTestCase(title: "Тест 2", inputDescription: "IsPositive(-5)", expectedOutput: "false", validationCode: "IsPositive(-5) == false"),
                    TaskTestCase(title: "Тест 3", inputDescription: "IsPositive(0)", expectedOutput: "false", validationCode: "IsPositive(0) == false")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static bool IsPositive(int n) {
    return n > 0;
}
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "cs_task_clamp_val",
            language: .csharp,
            titleRU: "Ограничение значения (Clamp)",
            titleEN: "Clamp Value in Range",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Ограничение числа между low и high.",
            summaryEN: "Keep number between low and high.",
            descriptionRU: ##"""
### Условие
Напишите метод `Clamp(int val, int low, int high)`.
Ограничение числа между low и high.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `Clamp(int val, int low, int high)`.
Keep number between low and high.
"""##,
            requirementsRU: ["Сигнатура: public static int Clamp(int val, int low, int high)"],
            requirementsEN: ["Signature: public static int Clamp(int val, int low, int high)"],
            starterCode: ##"""
public static int Clamp(int val, int low, int high) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Clamp(15, 0, 10)", expectedOutput: "10", validationCode: "Clamp(15, 0, 10) == 10"),
                    TaskTestCase(title: "Тест 2", inputDescription: "Clamp(-5, 0, 10)", expectedOutput: "0", validationCode: "Clamp(-5, 0, 10) == 0"),
                    TaskTestCase(title: "Тест 3", inputDescription: "Clamp(7, 0, 10)", expectedOutput: "7", validationCode: "Clamp(7, 0, 10) == 7")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int Clamp(int val, int low, int high) {
    return min(high, max(low, val));
}
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "cs_task_leap_year",
            language: .csharp,
            titleRU: "Високосный год",
            titleEN: "Leap Year Checker",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Делимость на 400 или (на 4 и не на 100).",
            summaryEN: "Divisible by 400 or (by 4 and not 100).",
            descriptionRU: ##"""
### Условие
Напишите метод `IsLeapYear(int year)`.
Делимость на 400 или (на 4 и не на 100).
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `IsLeapYear(int year)`.
Divisible by 400 or (by 4 and not 100).
"""##,
            requirementsRU: ["Сигнатура: public static bool IsLeapYear(int year)"],
            requirementsEN: ["Signature: public static bool IsLeapYear(int year)"],
            starterCode: ##"""
public static bool IsLeapYear(int year) {
    // Ваш код на C#
    return false;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "IsLeapYear(2024)", expectedOutput: "true", validationCode: "IsLeapYear(2024) == true"),
                    TaskTestCase(title: "Тест 2", inputDescription: "IsLeapYear(1900)", expectedOutput: "false", validationCode: "IsLeapYear(1900) == false"),
                    TaskTestCase(title: "Тест 3", inputDescription: "IsLeapYear(2000)", expectedOutput: "true", validationCode: "IsLeapYear(2000) == true")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static bool IsLeapYear(int year) {
    if year % 400 == 0:
        return true
    if year % 100 == 0:
        return false
    return year % 4 == 0
}
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "cs_task_fibonacci",
            language: .csharp,
            titleRU: "N-ое число Фибоначчи",
            titleEN: "Nth Fibonacci Number",
            difficulty: .medium,
            category: .basicsAndMath,
            summaryRU: "Последовательность 0, 1, 1, 2, 3, 5, 8...",
            summaryEN: "Fibonacci sequence.",
            descriptionRU: ##"""
### Условие
Напишите метод `Fibonacci(int n)`.
Последовательность 0, 1, 1, 2, 3, 5, 8...
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `Fibonacci(int n)`.
Fibonacci sequence.
"""##,
            requirementsRU: ["Сигнатура: public static int Fibonacci(int n)"],
            requirementsEN: ["Signature: public static int Fibonacci(int n)"],
            starterCode: ##"""
public static int Fibonacci(int n) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Fibonacci(0)", expectedOutput: "0", validationCode: "Fibonacci(0) == 0"),
                    TaskTestCase(title: "Тест 2", inputDescription: "Fibonacci(1)", expectedOutput: "1", validationCode: "Fibonacci(1) == 1"),
                    TaskTestCase(title: "Тест 3", inputDescription: "Fibonacci(6)", expectedOutput: "8", validationCode: "Fibonacci(6) == 8")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int Fibonacci(int n) {
    if n == 0:
        return 0
    if n == 1:
        return 1
    a = 0
    b = 1
    for i in 2...n:
        c = a + b
        a = b
        b = c
    return b
}
"""##,
            xpReward: 40
        ),
        CodingTask(
            id: "cs_task_factorial",
            language: .csharp,
            titleRU: "Факториал числа N!",
            titleEN: "Factorial of N",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Произведение всех чисел от 1 до N.",
            summaryEN: "Product of integers from 1 to N.",
            descriptionRU: ##"""
### Условие
Напишите метод `Factorial(int n)`.
Произведение всех чисел от 1 до N.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `Factorial(int n)`.
Product of integers from 1 to N.
"""##,
            requirementsRU: ["Сигнатура: public static int Factorial(int n)"],
            requirementsEN: ["Signature: public static int Factorial(int n)"],
            starterCode: ##"""
public static int Factorial(int n) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Factorial(5)", expectedOutput: "120", validationCode: "Factorial(5) == 120"),
                    TaskTestCase(title: "Тест 2", inputDescription: "Factorial(3)", expectedOutput: "6", validationCode: "Factorial(3) == 6"),
                    TaskTestCase(title: "Тест 3", inputDescription: "Factorial(0)", expectedOutput: "1", validationCode: "Factorial(0) == 1")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int Factorial(int n) {
    res = 1
    for i in 1...n:
        res = res * i
    return res
}
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "cs_task_is_prime",
            language: .csharp,
            titleRU: "Проверка простого числа",
            titleEN: "Check Prime Number",
            difficulty: .medium,
            category: .basicsAndMath,
            summaryRU: "Число больше 1 без делителей.",
            summaryEN: "Integer > 1 with no divisors.",
            descriptionRU: ##"""
### Условие
Напишите метод `IsPrime(int n)`.
Число больше 1 без делителей.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `IsPrime(int n)`.
Integer > 1 with no divisors.
"""##,
            requirementsRU: ["Сигнатура: public static bool IsPrime(int n)"],
            requirementsEN: ["Signature: public static bool IsPrime(int n)"],
            starterCode: ##"""
public static bool IsPrime(int n) {
    // Ваш код на C#
    return false;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "IsPrime(7)", expectedOutput: "true", validationCode: "IsPrime(7) == true"),
                    TaskTestCase(title: "Тест 2", inputDescription: "IsPrime(4)", expectedOutput: "false", validationCode: "IsPrime(4) == false"),
                    TaskTestCase(title: "Тест 3", inputDescription: "IsPrime(13)", expectedOutput: "true", validationCode: "IsPrime(13) == true")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static bool IsPrime(int n) {
    if n <= 1:
        return false
    for i in 2...n:
        if i != n and n % i == 0:
            return false
    return true
}
"""##,
            xpReward: 40
        ),
        CodingTask(
            id: "cs_task_reverse_string",
            language: .csharp,
            titleRU: "Разворот строки",
            titleEN: "Reverse a String",
            difficulty: .easy,
            category: .stringsAndCollections,
            summaryRU: "Чтение строки задом наперед.",
            summaryEN: "Reverse string characters.",
            descriptionRU: ##"""
### Условие
Напишите метод `ReverseString(string s)`.
Чтение строки задом наперед.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `ReverseString(string s)`.
Reverse string characters.
"""##,
            requirementsRU: ["Сигнатура: public static string ReverseString(string s)"],
            requirementsEN: ["Signature: public static string ReverseString(string s)"],
            starterCode: ##"""
public static string ReverseString(string s) {
    // Ваш код на C#
    return "";
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "ReverseString(\"hello\")", expectedOutput: "\"olleh\"", validationCode: "ReverseString(\"hello\") == \"olleh\""),
                    TaskTestCase(title: "Тест 2", inputDescription: "ReverseString(\"Swift\")", expectedOutput: "\"tfiwS\"", validationCode: "ReverseString(\"Swift\") == \"tfiwS\""),
                    TaskTestCase(title: "Тест 3", inputDescription: "ReverseString(\"\")", expectedOutput: "\"\"", validationCode: "ReverseString(\"\") == \"\"")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static string ReverseString(string s) {
    return s.reversed();
}
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "cs_task_is_palindrome",
            language: .csharp,
            titleRU: "Проверка палиндрома",
            titleEN: "Palindrome Check",
            difficulty: .easy,
            category: .stringsAndCollections,
            summaryRU: "Строка равна своему развороту.",
            summaryEN: "String equals its reverse.",
            descriptionRU: ##"""
### Условие
Напишите метод `IsPalindrome(string s)`.
Строка равна своему развороту.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `IsPalindrome(string s)`.
String equals its reverse.
"""##,
            requirementsRU: ["Сигнатура: public static bool IsPalindrome(string s)"],
            requirementsEN: ["Signature: public static bool IsPalindrome(string s)"],
            starterCode: ##"""
public static bool IsPalindrome(string s) {
    // Ваш код на C#
    return false;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "IsPalindrome(\"radar\")", expectedOutput: "true", validationCode: "IsPalindrome(\"radar\") == true"),
                    TaskTestCase(title: "Тест 2", inputDescription: "IsPalindrome(\"code\")", expectedOutput: "false", validationCode: "IsPalindrome(\"code\") == false"),
                    TaskTestCase(title: "Тест 3", inputDescription: "IsPalindrome(\"level\")", expectedOutput: "true", validationCode: "IsPalindrome(\"level\") == true")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static bool IsPalindrome(string s) {
    return s == s.reversed();
}
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "cs_task_first_and_last",
            language: .csharp,
            titleRU: "Первый и последний элемент",
            titleEN: "First and Last Element",
            difficulty: .easy,
            category: .stringsAndCollections,
            summaryRU: "Сумма lst.first + lst.last.",
            summaryEN: "Sum of first and last elements.",
            descriptionRU: ##"""
### Условие
Напишите метод `FirstAndLast(int[] lst)`.
Сумма lst.first + lst.last.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `FirstAndLast(int[] lst)`.
Sum of first and last elements.
"""##,
            requirementsRU: ["Сигнатура: public static int FirstAndLast(int[] lst)"],
            requirementsEN: ["Signature: public static int FirstAndLast(int[] lst)"],
            starterCode: ##"""
public static int FirstAndLast(int[] lst) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "FirstAndLast([10, 20, 30])", expectedOutput: "40", validationCode: "FirstAndLast([10, 20, 30]) == 40"),
                    TaskTestCase(title: "Тест 2", inputDescription: "FirstAndLast([5, 5])", expectedOutput: "10", validationCode: "FirstAndLast([5, 5]) == 10"),
                    TaskTestCase(title: "Тест 3", inputDescription: "FirstAndLast([1, 2, 3, 4, 9])", expectedOutput: "10", validationCode: "FirstAndLast([1, 2, 3, 4, 9]) == 10")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int FirstAndLast(int[] lst) {
    return lst.first + lst.last;
}
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "cs_task_sum_list",
            language: .csharp,
            titleRU: "Сумма элементов списка",
            titleEN: "Sum of List Elements",
            difficulty: .easy,
            category: .stringsAndCollections,
            summaryRU: "Сложение всех чисел в списке.",
            summaryEN: "Sum all numbers in list.",
            descriptionRU: ##"""
### Условие
Напишите метод `SumList(int[] lst)`.
Сложение всех чисел в списке.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `SumList(int[] lst)`.
Sum all numbers in list.
"""##,
            requirementsRU: ["Сигнатура: public static int SumList(int[] lst)"],
            requirementsEN: ["Signature: public static int SumList(int[] lst)"],
            starterCode: ##"""
public static int SumList(int[] lst) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "SumList([1, 2, 3, 4])", expectedOutput: "10", validationCode: "SumList([1, 2, 3, 4]) == 10"),
                    TaskTestCase(title: "Тест 2", inputDescription: "SumList([10, -5, 5])", expectedOutput: "10", validationCode: "SumList([10, -5, 5]) == 10"),
                    TaskTestCase(title: "Тест 3", inputDescription: "SumList([])", expectedOutput: "0", validationCode: "SumList([]) == 0")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int SumList(int[] lst) {
    total = 0
    for x in lst:
        total = total + x
    return total
}
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "cs_task_find_max",
            language: .csharp,
            titleRU: "Максимальный элемент списка",
            titleEN: "Maximum in List",
            difficulty: .medium,
            category: .stringsAndCollections,
            summaryRU: "Поиск наибольшего значения.",
            summaryEN: "Find max value.",
            descriptionRU: ##"""
### Условие
Напишите метод `FindMax(int[] lst)`.
Поиск наибольшего значения.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `FindMax(int[] lst)`.
Find max value.
"""##,
            requirementsRU: ["Сигнатура: public static int FindMax(int[] lst)"],
            requirementsEN: ["Signature: public static int FindMax(int[] lst)"],
            starterCode: ##"""
public static int FindMax(int[] lst) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "FindMax([3, 7, 2, 9, 5])", expectedOutput: "9", validationCode: "FindMax([3, 7, 2, 9, 5]) == 9"),
                    TaskTestCase(title: "Тест 2", inputDescription: "FindMax([-10, -3, -50])", expectedOutput: "-3", validationCode: "FindMax([-10, -3, -50]) == -3"),
                    TaskTestCase(title: "Тест 3", inputDescription: "FindMax([42])", expectedOutput: "42", validationCode: "FindMax([42]) == 42")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int FindMax(int[] lst) {
    best = lst.first
    for x in lst:
        if x > best:
            best = x
    return best
}
"""##,
            xpReward: 35
        ),
        CodingTask(
            id: "cs_task_find_min",
            language: .csharp,
            titleRU: "Минимальный элемент списка",
            titleEN: "Minimum in List",
            difficulty: .medium,
            category: .stringsAndCollections,
            summaryRU: "Поиск наименьшего значения.",
            summaryEN: "Find min value.",
            descriptionRU: ##"""
### Условие
Напишите метод `FindMin(int[] lst)`.
Поиск наименьшего значения.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `FindMin(int[] lst)`.
Find min value.
"""##,
            requirementsRU: ["Сигнатура: public static int FindMin(int[] lst)"],
            requirementsEN: ["Signature: public static int FindMin(int[] lst)"],
            starterCode: ##"""
public static int FindMin(int[] lst) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "FindMin([3, 7, 2, 9, 5])", expectedOutput: "2", validationCode: "FindMin([3, 7, 2, 9, 5]) == 2"),
                    TaskTestCase(title: "Тест 2", inputDescription: "FindMin([-10, -3, -50])", expectedOutput: "-50", validationCode: "FindMin([-10, -3, -50]) == -50"),
                    TaskTestCase(title: "Тест 3", inputDescription: "FindMin([99])", expectedOutput: "99", validationCode: "FindMin([99]) == 99")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int FindMin(int[] lst) {
    best = lst.first
    for x in lst:
        if x < best:
            best = x
    return best
}
"""##,
            xpReward: 35
        ),
        CodingTask(
            id: "cs_task_filter_evens",
            language: .csharp,
            titleRU: "Фильтрация чётных чисел",
            titleEN: "Filter Even Numbers",
            difficulty: .medium,
            category: .stringsAndCollections,
            summaryRU: "Оставить только чётные числа.",
            summaryEN: "Keep only even numbers.",
            descriptionRU: ##"""
### Условие
Напишите метод `FilterEvens(int[] lst)`.
Оставить только чётные числа.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `FilterEvens(int[] lst)`.
Keep only even numbers.
"""##,
            requirementsRU: ["Сигнатура: public static int[] FilterEvens(int[] lst)"],
            requirementsEN: ["Signature: public static int[] FilterEvens(int[] lst)"],
            starterCode: ##"""
public static int[] FilterEvens(int[] lst) {
    // Ваш код на C#
    return new int[0];
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "FilterEvens([1, 2, 3, 4, 5, 6])", expectedOutput: "[2, 4, 6]", validationCode: "FilterEvens([1, 2, 3, 4, 5, 6]) == [2, 4, 6]"),
                    TaskTestCase(title: "Тест 2", inputDescription: "FilterEvens([1, 3, 5])", expectedOutput: "[]", validationCode: "FilterEvens([1, 3, 5]) == []"),
                    TaskTestCase(title: "Тест 3", inputDescription: "FilterEvens([8, 10])", expectedOutput: "[8, 10]", validationCode: "FilterEvens([8, 10]) == [8, 10]")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int[] FilterEvens(int[] lst) {
    return lst.filter { $0 % 2 == 0 };
}
"""##,
            xpReward: 35
        ),
        CodingTask(
            id: "cs_task_filter_odds",
            language: .csharp,
            titleRU: "Фильтрация нечётных чисел",
            titleEN: "Filter Odd Numbers",
            difficulty: .medium,
            category: .stringsAndCollections,
            summaryRU: "Оставить только нечётные числа.",
            summaryEN: "Keep only odd numbers.",
            descriptionRU: ##"""
### Условие
Напишите метод `FilterOdds(int[] lst)`.
Оставить только нечётные числа.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `FilterOdds(int[] lst)`.
Keep only odd numbers.
"""##,
            requirementsRU: ["Сигнатура: public static int[] FilterOdds(int[] lst)"],
            requirementsEN: ["Signature: public static int[] FilterOdds(int[] lst)"],
            starterCode: ##"""
public static int[] FilterOdds(int[] lst) {
    // Ваш код на C#
    return new int[0];
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "FilterOdds([1, 2, 3, 4, 5])", expectedOutput: "[1, 3, 5]", validationCode: "FilterOdds([1, 2, 3, 4, 5]) == [1, 3, 5]"),
                    TaskTestCase(title: "Тест 2", inputDescription: "FilterOdds([2, 4, 6])", expectedOutput: "[]", validationCode: "FilterOdds([2, 4, 6]) == []"),
                    TaskTestCase(title: "Тест 3", inputDescription: "FilterOdds([7, 9])", expectedOutput: "[7, 9]", validationCode: "FilterOdds([7, 9]) == [7, 9]")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int[] FilterOdds(int[] lst) {
    return lst.filter { $0 % 2 != 0 };
}
"""##,
            xpReward: 35
        ),
        CodingTask(
            id: "cs_task_str_length",
            language: .csharp,
            titleRU: "Длина строки",
            titleEN: "String Length",
            difficulty: .easy,
            category: .stringsAndCollections,
            summaryRU: "Количество символов в строке.",
            summaryEN: "Count characters in string.",
            descriptionRU: ##"""
### Условие
Напишите метод `StrLength(string s)`.
Количество символов в строке.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `StrLength(string s)`.
Count characters in string.
"""##,
            requirementsRU: ["Сигнатура: public static int StrLength(string s)"],
            requirementsEN: ["Signature: public static int StrLength(string s)"],
            starterCode: ##"""
public static int StrLength(string s) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "StrLength(\"Python\")", expectedOutput: "6", validationCode: "StrLength(\"Python\") == 6"),
                    TaskTestCase(title: "Тест 2", inputDescription: "StrLength(\"\")", expectedOutput: "0", validationCode: "StrLength(\"\") == 0"),
                    TaskTestCase(title: "Тест 3", inputDescription: "StrLength(\"Hello\")", expectedOutput: "5", validationCode: "StrLength(\"Hello\") == 5")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int StrLength(string s) {
    return len(s);
}
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "cs_task_repeat_string",
            language: .csharp,
            titleRU: "Повторение строки N раз",
            titleEN: "Repeat String N Times",
            difficulty: .easy,
            category: .stringsAndCollections,
            summaryRU: "Конкатенация строки саму с собой N раз.",
            summaryEN: "Repeat string N times.",
            descriptionRU: ##"""
### Условие
Напишите метод `RepeatString(string s, int n)`.
Конкатенация строки саму с собой N раз.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `RepeatString(string s, int n)`.
Repeat string N times.
"""##,
            requirementsRU: ["Сигнатура: public static string RepeatString(string s, int n)"],
            requirementsEN: ["Signature: public static string RepeatString(string s, int n)"],
            starterCode: ##"""
public static string RepeatString(string s, int n) {
    // Ваш код на C#
    return "";
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "RepeatString(\"hi\", 3)", expectedOutput: "\"hihihi\"", validationCode: "RepeatString(\"hi\", 3) == \"hihihi\""),
                    TaskTestCase(title: "Тест 2", inputDescription: "RepeatString(\"A\", 1)", expectedOutput: "\"A\"", validationCode: "RepeatString(\"A\", 1) == \"A\""),
                    TaskTestCase(title: "Тест 3", inputDescription: "RepeatString(\"x\", 0)", expectedOutput: "\"\"", validationCode: "RepeatString(\"x\", 0) == \"\"")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static string RepeatString(string s, int n) {
    res = ""
    for i in 1...n:
        res = res + s
    return res
}
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "cs_task_contains_element",
            language: .csharp,
            titleRU: "Проверка наличия элемента",
            titleEN: "Contains Element",
            difficulty: .easy,
            category: .stringsAndCollections,
            summaryRU: "Линейный поиск совпадения.",
            summaryEN: "Check if target in list.",
            descriptionRU: ##"""
### Условие
Напишите метод `Contains(int[] lst, int target)`.
Линейный поиск совпадения.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `Contains(int[] lst, int target)`.
Check if target in list.
"""##,
            requirementsRU: ["Сигнатура: public static bool Contains(int[] lst, int target)"],
            requirementsEN: ["Signature: public static bool Contains(int[] lst, int target)"],
            starterCode: ##"""
public static bool Contains(int[] lst, int target) {
    // Ваш код на C#
    return false;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Contains([1, 2, 3, 4], 3)", expectedOutput: "true", validationCode: "Contains([1, 2, 3, 4], 3) == true"),
                    TaskTestCase(title: "Тест 2", inputDescription: "Contains([1, 2, 3, 4], 9)", expectedOutput: "false", validationCode: "Contains([1, 2, 3, 4], 9) == false"),
                    TaskTestCase(title: "Тест 3", inputDescription: "Contains([], 1)", expectedOutput: "false", validationCode: "Contains([], 1) == false")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static bool Contains(int[] lst, int target) {
    for x in lst:
        if x == target:
            return true
    return false
}
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "cs_task_find_index",
            language: .csharp,
            titleRU: "Поиск индекса элемента",
            titleEN: "Find Element Index",
            difficulty: .medium,
            category: .stringsAndCollections,
            summaryRU: "Индекс первого совпадения или -1.",
            summaryEN: "First matching index or -1.",
            descriptionRU: ##"""
### Условие
Напишите метод `FindIndex(int[] lst, int target)`.
Индекс первого совпадения или -1.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `FindIndex(int[] lst, int target)`.
First matching index or -1.
"""##,
            requirementsRU: ["Сигнатура: public static int FindIndex(int[] lst, int target)"],
            requirementsEN: ["Signature: public static int FindIndex(int[] lst, int target)"],
            starterCode: ##"""
public static int FindIndex(int[] lst, int target) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "FindIndex([10, 20, 30, 40], 30)", expectedOutput: "2", validationCode: "FindIndex([10, 20, 30, 40], 30) == 2"),
                    TaskTestCase(title: "Тест 2", inputDescription: "FindIndex([10, 20, 30], 99)", expectedOutput: "-1", validationCode: "FindIndex([10, 20, 30], 99) == -1"),
                    TaskTestCase(title: "Тест 3", inputDescription: "FindIndex([5], 5)", expectedOutput: "0", validationCode: "FindIndex([5], 5) == 0")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int FindIndex(int[] lst, int target) {
    idx = 0
    for x in lst:
        if x == target:
            return idx
        idx = idx + 1
    return -1
}
"""##,
            xpReward: 35
        ),
        CodingTask(
            id: "cs_task_count_matches",
            language: .csharp,
            titleRU: "Подсчет вхождений элемента",
            titleEN: "Count Occurrences",
            difficulty: .easy,
            category: .stringsAndCollections,
            summaryRU: "Количество появлений target в списке.",
            summaryEN: "Count of target in list.",
            descriptionRU: ##"""
### Условие
Напишите метод `CountMatches(int[] lst, int target)`.
Количество появлений target в списке.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `CountMatches(int[] lst, int target)`.
Count of target in list.
"""##,
            requirementsRU: ["Сигнатура: public static int CountMatches(int[] lst, int target)"],
            requirementsEN: ["Signature: public static int CountMatches(int[] lst, int target)"],
            starterCode: ##"""
public static int CountMatches(int[] lst, int target) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "CountMatches([1, 2, 2, 3, 2], 2)", expectedOutput: "3", validationCode: "CountMatches([1, 2, 2, 3, 2], 2) == 3"),
                    TaskTestCase(title: "Тест 2", inputDescription: "CountMatches([1, 2, 3], 9)", expectedOutput: "0", validationCode: "CountMatches([1, 2, 3], 9) == 0"),
                    TaskTestCase(title: "Тест 3", inputDescription: "CountMatches([7, 7, 7, 7], 7)", expectedOutput: "4", validationCode: "CountMatches([7, 7, 7, 7], 7) == 4")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int CountMatches(int[] lst, int target) {
    count = 0
    for x in lst:
        if x == target:
            count = count + 1
    return count
}
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "cs_task_is_sorted",
            language: .csharp,
            titleRU: "Проверка отсортированности",
            titleEN: "Check if Sorted",
            difficulty: .medium,
            category: .stringsAndCollections,
            summaryRU: "Список упорядочен по возрастанию.",
            summaryEN: "List is sorted ascending.",
            descriptionRU: ##"""
### Условие
Напишите метод `IsSorted(int[] lst)`.
Список упорядочен по возрастанию.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `IsSorted(int[] lst)`.
List is sorted ascending.
"""##,
            requirementsRU: ["Сигнатура: public static bool IsSorted(int[] lst)"],
            requirementsEN: ["Signature: public static bool IsSorted(int[] lst)"],
            starterCode: ##"""
public static bool IsSorted(int[] lst) {
    // Ваш код на C#
    return false;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "IsSorted([1, 2, 3, 4])", expectedOutput: "true", validationCode: "IsSorted([1, 2, 3, 4]) == true"),
                    TaskTestCase(title: "Тест 2", inputDescription: "IsSorted([1, 3, 2])", expectedOutput: "false", validationCode: "IsSorted([1, 3, 2]) == false"),
                    TaskTestCase(title: "Тест 3", inputDescription: "IsSorted([5])", expectedOutput: "true", validationCode: "IsSorted([5]) == true")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static bool IsSorted(int[] lst) {
    return lst == lst.sorted();
}
"""##,
            xpReward: 35
        ),
        CodingTask(
            id: "cs_task_square_elements",
            language: .csharp,
            titleRU: "Квадраты элементов списка",
            titleEN: "Squares of List Elements",
            difficulty: .medium,
            category: .stringsAndCollections,
            summaryRU: "Отображение x -> x * x.",
            summaryEN: "Map x -> x * x.",
            descriptionRU: ##"""
### Условие
Напишите метод `SquareElements(int[] lst)`.
Отображение x -> x * x.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `SquareElements(int[] lst)`.
Map x -> x * x.
"""##,
            requirementsRU: ["Сигнатура: public static int[] SquareElements(int[] lst)"],
            requirementsEN: ["Signature: public static int[] SquareElements(int[] lst)"],
            starterCode: ##"""
public static int[] SquareElements(int[] lst) {
    // Ваш код на C#
    return new int[0];
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "SquareElements([1, 2, 3])", expectedOutput: "[1, 4, 9]", validationCode: "SquareElements([1, 2, 3]) == [1, 4, 9]"),
                    TaskTestCase(title: "Тест 2", inputDescription: "SquareElements([4, 5])", expectedOutput: "[16, 25]", validationCode: "SquareElements([4, 5]) == [16, 25]"),
                    TaskTestCase(title: "Тест 3", inputDescription: "SquareElements([])", expectedOutput: "[]", validationCode: "SquareElements([]) == []")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int[] SquareElements(int[] lst) {
    return lst.map { $0 * $0 };
}
"""##,
            xpReward: 35
        ),
        CodingTask(
            id: "cs_task_join_words",
            language: .csharp,
            titleRU: "Конкатенация двух строк",
            titleEN: "Concatenate Strings",
            difficulty: .easy,
            category: .stringsAndCollections,
            summaryRU: "Склеивание w1 + ' ' + w2.",
            summaryEN: "Join w1 + ' ' + w2.",
            descriptionRU: ##"""
### Условие
Напишите метод `JoinWords(string w1, string w2)`.
Склеивание w1 + ' ' + w2.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `JoinWords(string w1, string w2)`.
Join w1 + ' ' + w2.
"""##,
            requirementsRU: ["Сигнатура: public static string JoinWords(string w1, string w2)"],
            requirementsEN: ["Signature: public static string JoinWords(string w1, string w2)"],
            starterCode: ##"""
public static string JoinWords(string w1, string w2) {
    // Ваш код на C#
    return "";
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "JoinWords(\"Hello\", \"World\")", expectedOutput: "\"Hello World\"", validationCode: "JoinWords(\"Hello\", \"World\") == \"Hello World\""),
                    TaskTestCase(title: "Тест 2", inputDescription: "JoinWords(\"Code\", \"Base\")", expectedOutput: "\"Code Base\"", validationCode: "JoinWords(\"Code\", \"Base\") == \"Code Base\""),
                    TaskTestCase(title: "Тест 3", inputDescription: "JoinWords(\"A\", \"B\")", expectedOutput: "\"A B\"", validationCode: "JoinWords(\"A\", \"B\") == \"A B\"")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static string JoinWords(string w1, string w2) {
    return w1 + " " + w2;
}
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "cs_task_reverse_list",
            language: .csharp,
            titleRU: "Разворот списка",
            titleEN: "Reverse a List",
            difficulty: .easy,
            category: .stringsAndCollections,
            summaryRU: "Элементы в обратном порядке.",
            summaryEN: "Elements in reverse order.",
            descriptionRU: ##"""
### Условие
Напишите метод `ReverseList(int[] lst)`.
Элементы в обратном порядке.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `ReverseList(int[] lst)`.
Elements in reverse order.
"""##,
            requirementsRU: ["Сигнатура: public static int[] ReverseList(int[] lst)"],
            requirementsEN: ["Signature: public static int[] ReverseList(int[] lst)"],
            starterCode: ##"""
public static int[] ReverseList(int[] lst) {
    // Ваш код на C#
    return new int[0];
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "ReverseList([1, 2, 3])", expectedOutput: "[3, 2, 1]", validationCode: "ReverseList([1, 2, 3]) == [3, 2, 1]"),
                    TaskTestCase(title: "Тест 2", inputDescription: "ReverseList([10, 20])", expectedOutput: "[20, 10]", validationCode: "ReverseList([10, 20]) == [20, 10]"),
                    TaskTestCase(title: "Тест 3", inputDescription: "ReverseList([])", expectedOutput: "[]", validationCode: "ReverseList([]) == []")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int[] ReverseList(int[] lst) {
    return lst.reversed();
}
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "cs_task_double_all",
            language: .csharp,
            titleRU: "Удвоение элементов списка",
            titleEN: "Double All Elements",
            difficulty: .easy,
            category: .stringsAndCollections,
            summaryRU: "Отображение x -> x * 2.",
            summaryEN: "Map x -> x * 2.",
            descriptionRU: ##"""
### Условие
Напишите метод `DoubleAll(int[] lst)`.
Отображение x -> x * 2.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `DoubleAll(int[] lst)`.
Map x -> x * 2.
"""##,
            requirementsRU: ["Сигнатура: public static int[] DoubleAll(int[] lst)"],
            requirementsEN: ["Signature: public static int[] DoubleAll(int[] lst)"],
            starterCode: ##"""
public static int[] DoubleAll(int[] lst) {
    // Ваш код на C#
    return new int[0];
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "DoubleAll([1, 2, 3])", expectedOutput: "[2, 4, 6]", validationCode: "DoubleAll([1, 2, 3]) == [2, 4, 6]"),
                    TaskTestCase(title: "Тест 2", inputDescription: "DoubleAll([10, -5])", expectedOutput: "[20, -10]", validationCode: "DoubleAll([10, -5]) == [20, -10]"),
                    TaskTestCase(title: "Тест 3", inputDescription: "DoubleAll([])", expectedOutput: "[]", validationCode: "DoubleAll([]) == []")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int[] DoubleAll(int[] lst) {
    return lst.map { $0 * 2 };
}
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "cs_task_all_positive",
            language: .csharp,
            titleRU: "Все ли числа положительные",
            titleEN: "Are All Numbers Positive",
            difficulty: .easy,
            category: .stringsAndCollections,
            summaryRU: "Проверка x > 0 для всех элементов.",
            summaryEN: "Check x > 0 for all items.",
            descriptionRU: ##"""
### Условие
Напишите метод `AllPositive(int[] lst)`.
Проверка x > 0 для всех элементов.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `AllPositive(int[] lst)`.
Check x > 0 for all items.
"""##,
            requirementsRU: ["Сигнатура: public static bool AllPositive(int[] lst)"],
            requirementsEN: ["Signature: public static bool AllPositive(int[] lst)"],
            starterCode: ##"""
public static bool AllPositive(int[] lst) {
    // Ваш код на C#
    return false;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "AllPositive([1, 5, 10])", expectedOutput: "true", validationCode: "AllPositive([1, 5, 10]) == true"),
                    TaskTestCase(title: "Тест 2", inputDescription: "AllPositive([1, -2, 3])", expectedOutput: "false", validationCode: "AllPositive([1, -2, 3]) == false"),
                    TaskTestCase(title: "Тест 3", inputDescription: "AllPositive([])", expectedOutput: "true", validationCode: "AllPositive([]) == true")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static bool AllPositive(int[] lst) {
    for x in lst:
        if x <= 0:
            return false
    return true
}
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "cs_task_any_negative",
            language: .csharp,
            titleRU: "Есть ли отрицательные числа",
            titleEN: "Has Any Negative Number",
            difficulty: .easy,
            category: .stringsAndCollections,
            summaryRU: "Проверка x < 0 хотя бы для одного элемента.",
            summaryEN: "Check x < 0 for any item.",
            descriptionRU: ##"""
### Условие
Напишите метод `AnyNegative(int[] lst)`.
Проверка x < 0 хотя бы для одного элемента.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `AnyNegative(int[] lst)`.
Check x < 0 for any item.
"""##,
            requirementsRU: ["Сигнатура: public static bool AnyNegative(int[] lst)"],
            requirementsEN: ["Signature: public static bool AnyNegative(int[] lst)"],
            starterCode: ##"""
public static bool AnyNegative(int[] lst) {
    // Ваш код на C#
    return false;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "AnyNegative([1, -2, 3])", expectedOutput: "true", validationCode: "AnyNegative([1, -2, 3]) == true"),
                    TaskTestCase(title: "Тест 2", inputDescription: "AnyNegative([1, 2, 3])", expectedOutput: "false", validationCode: "AnyNegative([1, 2, 3]) == false"),
                    TaskTestCase(title: "Тест 3", inputDescription: "AnyNegative([])", expectedOutput: "false", validationCode: "AnyNegative([]) == false")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static bool AnyNegative(int[] lst) {
    for x in lst:
        if x < 0:
            return true
    return false
}
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "cs_task_linear_search",
            language: .csharp,
            titleRU: "Линейный поиск",
            titleEN: "Linear Search",
            difficulty: .easy,
            category: .algorithms,
            summaryRU: "Последовательный поиск элемента в массиве.",
            summaryEN: "Sequential array search.",
            descriptionRU: ##"""
### Условие
Напишите метод `LinearSearch(int[] arr, int target)`.
Последовательный поиск элемента в массиве.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `LinearSearch(int[] arr, int target)`.
Sequential array search.
"""##,
            requirementsRU: ["Сигнатура: public static int LinearSearch(int[] arr, int target)"],
            requirementsEN: ["Signature: public static int LinearSearch(int[] arr, int target)"],
            starterCode: ##"""
public static int LinearSearch(int[] arr, int target) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "LinearSearch([4, 2, 7, 1], 7)", expectedOutput: "2", validationCode: "LinearSearch([4, 2, 7, 1], 7) == 2"),
                    TaskTestCase(title: "Тест 2", inputDescription: "LinearSearch([4, 2, 7, 1], 9)", expectedOutput: "-1", validationCode: "LinearSearch([4, 2, 7, 1], 9) == -1"),
                    TaskTestCase(title: "Тест 3", inputDescription: "LinearSearch([5], 5)", expectedOutput: "0", validationCode: "LinearSearch([5], 5) == 0")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int LinearSearch(int[] arr, int target) {
    idx = 0
    for x in arr:
        if x == target:
            return idx
        idx = idx + 1
    return -1
}
"""##,
            xpReward: 35
        ),
        CodingTask(
            id: "cs_task_two_sum",
            language: .csharp,
            titleRU: "Сумма двух слагаемых (Two Sum)",
            titleEN: "Two Sum Problem",
            difficulty: .medium,
            category: .algorithms,
            summaryRU: "Поиск пары элементов с суммой target.",
            summaryEN: "Check if pair sums to target.",
            descriptionRU: ##"""
### Условие
Напишите метод `HasTwoSum(int[] nums, int target)`.
Поиск пары элементов с суммой target.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `HasTwoSum(int[] nums, int target)`.
Check if pair sums to target.
"""##,
            requirementsRU: ["Сигнатура: public static bool HasTwoSum(int[] nums, int target)"],
            requirementsEN: ["Signature: public static bool HasTwoSum(int[] nums, int target)"],
            starterCode: ##"""
public static bool HasTwoSum(int[] nums, int target) {
    // Ваш код на C#
    return false;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "HasTwoSum([2, 7, 11, 15], 9)", expectedOutput: "true", validationCode: "HasTwoSum([2, 7, 11, 15], 9) == true"),
                    TaskTestCase(title: "Тест 2", inputDescription: "HasTwoSum([3, 2, 4], 6)", expectedOutput: "true", validationCode: "HasTwoSum([3, 2, 4], 6) == true"),
                    TaskTestCase(title: "Тест 3", inputDescription: "HasTwoSum([1, 2, 3], 99)", expectedOutput: "false", validationCode: "HasTwoSum([1, 2, 3], 99) == false")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static bool HasTwoSum(int[] nums, int target) {
    n = len(nums)
    for i in 0...n:
        for j in 0...n:
            if i != j and nums[i] + nums[j] == target:
                return true
    return false
}
"""##,
            xpReward: 45
        ),
        CodingTask(
            id: "cs_task_second_largest",
            language: .csharp,
            titleRU: "Второй по величине элемент",
            titleEN: "Second Largest Element",
            difficulty: .medium,
            category: .algorithms,
            summaryRU: "Предпоследний элемент в отсортированном виде.",
            summaryEN: "Second from end in sorted list.",
            descriptionRU: ##"""
### Условие
Напишите метод `SecondLargest(int[] arr)`.
Предпоследний элемент в отсортированном виде.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `SecondLargest(int[] arr)`.
Second from end in sorted list.
"""##,
            requirementsRU: ["Сигнатура: public static int SecondLargest(int[] arr)"],
            requirementsEN: ["Signature: public static int SecondLargest(int[] arr)"],
            starterCode: ##"""
public static int SecondLargest(int[] arr) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "SecondLargest([10, 40, 20, 30])", expectedOutput: "30", validationCode: "SecondLargest([10, 40, 20, 30]) == 30"),
                    TaskTestCase(title: "Тест 2", inputDescription: "SecondLargest([5, 1, 9])", expectedOutput: "5", validationCode: "SecondLargest([5, 1, 9]) == 5"),
                    TaskTestCase(title: "Тест 3", inputDescription: "SecondLargest([100, 200])", expectedOutput: "100", validationCode: "SecondLargest([100, 200]) == 100")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int SecondLargest(int[] arr) {
    s = arr.sorted()
    idx = len(s) - 2
    return s[idx]
}
"""##,
            xpReward: 40
        ),
        CodingTask(
            id: "cs_task_missing_number",
            language: .csharp,
            titleRU: "Поиск пропущенного числа",
            titleEN: "Find Missing Number",
            difficulty: .medium,
            category: .algorithms,
            summaryRU: "Ожидаемая сумма N*(N+1)/2 минус фактическая.",
            summaryEN: "Expected sum minus actual sum.",
            descriptionRU: ##"""
### Условие
Напишите метод `MissingNumber(int[] arr)`.
Ожидаемая сумма N*(N+1)/2 минус фактическая.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `MissingNumber(int[] arr)`.
Expected sum minus actual sum.
"""##,
            requirementsRU: ["Сигнатура: public static int MissingNumber(int[] arr)"],
            requirementsEN: ["Signature: public static int MissingNumber(int[] arr)"],
            starterCode: ##"""
public static int MissingNumber(int[] arr) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "MissingNumber([3, 0, 1])", expectedOutput: "2", validationCode: "MissingNumber([3, 0, 1]) == 2"),
                    TaskTestCase(title: "Тест 2", inputDescription: "MissingNumber([0, 1])", expectedOutput: "2", validationCode: "MissingNumber([0, 1]) == 2"),
                    TaskTestCase(title: "Тест 3", inputDescription: "MissingNumber([9, 6, 4, 2, 3, 5, 7, 0, 1])", expectedOutput: "8", validationCode: "MissingNumber([9, 6, 4, 2, 3, 5, 7, 0, 1]) == 8")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int MissingNumber(int[] arr) {
    n = len(arr)
    expected = n * (n + 1) / 2
    actual = 0
    for x in arr:
        actual = actual + x
    return expected - actual
}
"""##,
            xpReward: 45
        ),
        CodingTask(
            id: "cs_task_count_non_zeroes",
            language: .csharp,
            titleRU: "Количество ненулевых элементов",
            titleEN: "Count Non-Zero Elements",
            difficulty: .easy,
            category: .algorithms,
            summaryRU: "Подсчет элементов, не равных 0.",
            summaryEN: "Count elements != 0.",
            descriptionRU: ##"""
### Условие
Напишите метод `CountNonZeroes(int[] arr)`.
Подсчет элементов, не равных 0.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `CountNonZeroes(int[] arr)`.
Count elements != 0.
"""##,
            requirementsRU: ["Сигнатура: public static int CountNonZeroes(int[] arr)"],
            requirementsEN: ["Signature: public static int CountNonZeroes(int[] arr)"],
            starterCode: ##"""
public static int CountNonZeroes(int[] arr) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "CountNonZeroes([0, 1, 0, 3, 12])", expectedOutput: "3", validationCode: "CountNonZeroes([0, 1, 0, 3, 12]) == 3"),
                    TaskTestCase(title: "Тест 2", inputDescription: "CountNonZeroes([0, 0, 0])", expectedOutput: "0", validationCode: "CountNonZeroes([0, 0, 0]) == 0"),
                    TaskTestCase(title: "Тест 3", inputDescription: "CountNonZeroes([1, 2, 3])", expectedOutput: "3", validationCode: "CountNonZeroes([1, 2, 3]) == 3")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int CountNonZeroes(int[] arr) {
    c = 0
    for x in arr:
        if x != 0:
            c = c + 1
    return c
}
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "cs_task_max_sub_array",
            language: .csharp,
            titleRU: "Алгоритм Кадане (Max Subarray)",
            titleEN: "Kadane's Algorithm",
            difficulty: .hard,
            category: .algorithms,
            summaryRU: "Максимальная сумма непрерывного подмассива.",
            summaryEN: "Maximum sum contiguous subarray.",
            descriptionRU: ##"""
### Условие
Напишите метод `MaxSubArray(int[] nums)`.
Максимальная сумма непрерывного подмассива.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `MaxSubArray(int[] nums)`.
Maximum sum contiguous subarray.
"""##,
            requirementsRU: ["Сигнатура: public static int MaxSubArray(int[] nums)"],
            requirementsEN: ["Signature: public static int MaxSubArray(int[] nums)"],
            starterCode: ##"""
public static int MaxSubArray(int[] nums) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "MaxSubArray([-2, 1, -3, 4, -1, 2, 1, -5, 4])", expectedOutput: "6", validationCode: "MaxSubArray([-2, 1, -3, 4, -1, 2, 1, -5, 4]) == 6"),
                    TaskTestCase(title: "Тест 2", inputDescription: "MaxSubArray([1])", expectedOutput: "1", validationCode: "MaxSubArray([1]) == 1"),
                    TaskTestCase(title: "Тест 3", inputDescription: "MaxSubArray([5, 4, -1, 7, 8])", expectedOutput: "23", validationCode: "MaxSubArray([5, 4, -1, 7, 8]) == 23")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int MaxSubArray(int[] nums) {
    best = nums.first
    curr = nums.first
    for x in nums:
        curr = max(x, curr + x)
        best = max(best, curr)
    return best
}
"""##,
            xpReward: 60
        ),
        CodingTask(
            id: "cs_task_binary_search",
            language: .csharp,
            titleRU: "Бинарный поиск",
            titleEN: "Binary Search",
            difficulty: .medium,
            category: .algorithms,
            summaryRU: "Поиск индекса в отсортированном массиве за O(log N).",
            summaryEN: "Search in sorted array.",
            descriptionRU: ##"""
### Условие
Напишите метод `BinarySearch(int[] arr, int target)`.
Поиск индекса в отсортированном массиве за O(log N).
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `BinarySearch(int[] arr, int target)`.
Search in sorted array.
"""##,
            requirementsRU: ["Сигнатура: public static int BinarySearch(int[] arr, int target)"],
            requirementsEN: ["Signature: public static int BinarySearch(int[] arr, int target)"],
            starterCode: ##"""
public static int BinarySearch(int[] arr, int target) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "BinarySearch([1, 3, 5, 7, 9], 5)", expectedOutput: "2", validationCode: "BinarySearch([1, 3, 5, 7, 9], 5) == 2"),
                    TaskTestCase(title: "Тест 2", inputDescription: "BinarySearch([1, 3, 5, 7, 9], 1)", expectedOutput: "0", validationCode: "BinarySearch([1, 3, 5, 7, 9], 1) == 0"),
                    TaskTestCase(title: "Тест 3", inputDescription: "BinarySearch([1, 3, 5, 7, 9], 8)", expectedOutput: "-1", validationCode: "BinarySearch([1, 3, 5, 7, 9], 8) == -1")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int BinarySearch(int[] arr, int target) {
    left = 0
    right = len(arr) - 1
    for step in 0...len(arr):
        if left <= right:
            mid = (left + right) / 2
            if arr[mid] == target:
                return mid
            if arr[mid] < target:
                left = mid + 1
            else:
                right = mid - 1
    return -1
}
"""##,
            xpReward: 50
        ),
        CodingTask(
            id: "cs_task_sort_array",
            language: .csharp,
            titleRU: "Сортировка массива",
            titleEN: "Sort Array",
            difficulty: .easy,
            category: .algorithms,
            summaryRU: "Возврат отсортированной копии.",
            summaryEN: "Return sorted array copy.",
            descriptionRU: ##"""
### Условие
Напишите метод `SortArray(int[] arr)`.
Возврат отсортированной копии.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `SortArray(int[] arr)`.
Return sorted array copy.
"""##,
            requirementsRU: ["Сигнатура: public static int[] SortArray(int[] arr)"],
            requirementsEN: ["Signature: public static int[] SortArray(int[] arr)"],
            starterCode: ##"""
public static int[] SortArray(int[] arr) {
    // Ваш код на C#
    return new int[0];
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "SortArray([5, 2, 8, 1, 9])", expectedOutput: "[1, 2, 5, 8, 9]", validationCode: "SortArray([5, 2, 8, 1, 9]) == [1, 2, 5, 8, 9]"),
                    TaskTestCase(title: "Тест 2", inputDescription: "SortArray([3, 1])", expectedOutput: "[1, 3]", validationCode: "SortArray([3, 1]) == [1, 3]"),
                    TaskTestCase(title: "Тест 3", inputDescription: "SortArray([10])", expectedOutput: "[10]", validationCode: "SortArray([10]) == [10]")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int[] SortArray(int[] arr) {
    return arr.sorted();
}
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "cs_task_majority_element",
            language: .csharp,
            titleRU: "Мажоритарный элемент",
            titleEN: "Majority Element",
            difficulty: .hard,
            category: .algorithms,
            summaryRU: "Элемент, встречающийся > n/2 раз.",
            summaryEN: "Element appearing > n/2 times.",
            descriptionRU: ##"""
### Условие
Напишите метод `MajorityElement(int[] arr)`.
Элемент, встречающийся > n/2 раз.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `MajorityElement(int[] arr)`.
Element appearing > n/2 times.
"""##,
            requirementsRU: ["Сигнатура: public static int MajorityElement(int[] arr)"],
            requirementsEN: ["Signature: public static int MajorityElement(int[] arr)"],
            starterCode: ##"""
public static int MajorityElement(int[] arr) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "MajorityElement([3, 2, 3])", expectedOutput: "3", validationCode: "MajorityElement([3, 2, 3]) == 3"),
                    TaskTestCase(title: "Тест 2", inputDescription: "MajorityElement([2, 2, 1, 1, 1, 2, 2])", expectedOutput: "2", validationCode: "MajorityElement([2, 2, 1, 1, 1, 2, 2]) == 2"),
                    TaskTestCase(title: "Тест 3", inputDescription: "MajorityElement([5])", expectedOutput: "5", validationCode: "MajorityElement([5]) == 5")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int MajorityElement(int[] arr) {
    s = arr.sorted()
    mid = len(s) / 2
    return s[mid]
}
"""##,
            xpReward: 55
        ),
        CodingTask(
            id: "cs_task_gcd",
            language: .csharp,
            titleRU: "Наибольший общий делитель (НОД)",
            titleEN: "Greatest Common Divisor (GCD)",
            difficulty: .medium,
            category: .algorithms,
            summaryRU: "Алгоритм Евклида.",
            summaryEN: "Euclidean algorithm.",
            descriptionRU: ##"""
### Условие
Напишите метод `Gcd(int a, int b)`.
Алгоритм Евклида.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `Gcd(int a, int b)`.
Euclidean algorithm.
"""##,
            requirementsRU: ["Сигнатура: public static int Gcd(int a, int b)"],
            requirementsEN: ["Signature: public static int Gcd(int a, int b)"],
            starterCode: ##"""
public static int Gcd(int a, int b) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Gcd(48, 18)", expectedOutput: "6", validationCode: "Gcd(48, 18) == 6"),
                    TaskTestCase(title: "Тест 2", inputDescription: "Gcd(20, 10)", expectedOutput: "10", validationCode: "Gcd(20, 10) == 10"),
                    TaskTestCase(title: "Тест 3", inputDescription: "Gcd(7, 3)", expectedOutput: "1", validationCode: "Gcd(7, 3) == 1")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int Gcd(int a, int b) {
    x = a
    y = b
    for i in 0...100:
        if y != 0:
            rem = x % y
            x = y
            y = rem
    return x
}
"""##,
            xpReward: 45
        ),
        CodingTask(
            id: "cs_task_lcm",
            language: .csharp,
            titleRU: "Наименьшее общее кратное (НОК)",
            titleEN: "Least Common Multiple (LCM)",
            difficulty: .medium,
            category: .algorithms,
            summaryRU: "(a * b) / gcd(a, b).",
            summaryEN: "(a * b) / gcd(a, b).",
            descriptionRU: ##"""
### Условие
Напишите метод `Lcm(int a, int b)`.
(a * b) / gcd(a, b).
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `Lcm(int a, int b)`.
(a * b) / gcd(a, b).
"""##,
            requirementsRU: ["Сигнатура: public static int Lcm(int a, int b)"],
            requirementsEN: ["Signature: public static int Lcm(int a, int b)"],
            starterCode: ##"""
public static int Lcm(int a, int b) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Lcm(4, 6)", expectedOutput: "12", validationCode: "Lcm(4, 6) == 12"),
                    TaskTestCase(title: "Тест 2", inputDescription: "Lcm(5, 7)", expectedOutput: "35", validationCode: "Lcm(5, 7) == 35"),
                    TaskTestCase(title: "Тест 3", inputDescription: "Lcm(10, 15)", expectedOutput: "30", validationCode: "Lcm(10, 15) == 30")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int Lcm(int a, int b) {
    x = a
    y = b
    for i in 0...100:
        if y != 0:
            rem = x % y
            x = y
            y = rem
    return (a * b) / x
}
"""##,
            xpReward: 45
        ),
        CodingTask(
            id: "cs_task_climb_stairs",
            language: .csharp,
            titleRU: "Подъем по лестнице",
            titleEN: "Climbing Stairs",
            difficulty: .medium,
            category: .algorithms,
            summaryRU: "Количество способов подняться на N ступеней.",
            summaryEN: "Ways to climb N stairs.",
            descriptionRU: ##"""
### Условие
Напишите метод `ClimbStairs(int n)`.
Количество способов подняться на N ступеней.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `ClimbStairs(int n)`.
Ways to climb N stairs.
"""##,
            requirementsRU: ["Сигнатура: public static int ClimbStairs(int n)"],
            requirementsEN: ["Signature: public static int ClimbStairs(int n)"],
            starterCode: ##"""
public static int ClimbStairs(int n) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "ClimbStairs(2)", expectedOutput: "2", validationCode: "ClimbStairs(2) == 2"),
                    TaskTestCase(title: "Тест 2", inputDescription: "ClimbStairs(3)", expectedOutput: "3", validationCode: "ClimbStairs(3) == 3"),
                    TaskTestCase(title: "Тест 3", inputDescription: "ClimbStairs(4)", expectedOutput: "5", validationCode: "ClimbStairs(4) == 5")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int ClimbStairs(int n) {
    if n <= 1:
        return 1
    if n == 2:
        return 2
    a = 1
    b = 2
    for i in 3...n:
        c = a + b
        a = b
        b = c
    return b
}
"""##,
            xpReward: 50
        ),
        CodingTask(
            id: "cs_task_last_element",
            language: .csharp,
            titleRU: "Последний элемент массива",
            titleEN: "Last Element of Array",
            difficulty: .easy,
            category: .algorithms,
            summaryRU: "Значение arr.last.",
            summaryEN: "Value of arr.last.",
            descriptionRU: ##"""
### Условие
Напишите метод `LastElement(int[] arr)`.
Значение arr.last.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `LastElement(int[] arr)`.
Value of arr.last.
"""##,
            requirementsRU: ["Сигнатура: public static int LastElement(int[] arr)"],
            requirementsEN: ["Signature: public static int LastElement(int[] arr)"],
            starterCode: ##"""
public static int LastElement(int[] arr) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "LastElement([1, 2, 3, 4])", expectedOutput: "4", validationCode: "LastElement([1, 2, 3, 4]) == 4"),
                    TaskTestCase(title: "Тест 2", inputDescription: "LastElement([10, 20])", expectedOutput: "20", validationCode: "LastElement([10, 20]) == 20"),
                    TaskTestCase(title: "Тест 3", inputDescription: "LastElement([99])", expectedOutput: "99", validationCode: "LastElement([99]) == 99")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int LastElement(int[] arr) {
    return arr.last;
}
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "cs_task_tribonacci",
            language: .csharp,
            titleRU: "Числа Трибоначчи",
            titleEN: "Tribonacci Numbers",
            difficulty: .medium,
            category: .algorithms,
            summaryRU: "T(n) = T(n-1) + T(n-2) + T(n-3).",
            summaryEN: "Tribonacci sequence.",
            descriptionRU: ##"""
### Условие
Напишите метод `Tribonacci(int n)`.
T(n) = T(n-1) + T(n-2) + T(n-3).
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `Tribonacci(int n)`.
Tribonacci sequence.
"""##,
            requirementsRU: ["Сигнатура: public static int Tribonacci(int n)"],
            requirementsEN: ["Signature: public static int Tribonacci(int n)"],
            starterCode: ##"""
public static int Tribonacci(int n) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Tribonacci(0)", expectedOutput: "0", validationCode: "Tribonacci(0) == 0"),
                    TaskTestCase(title: "Тест 2", inputDescription: "Tribonacci(3)", expectedOutput: "2", validationCode: "Tribonacci(3) == 2"),
                    TaskTestCase(title: "Тест 3", inputDescription: "Tribonacci(4)", expectedOutput: "4", validationCode: "Tribonacci(4) == 4")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int Tribonacci(int n) {
    if n == 0:
        return 0
    if n == 1 or n == 2:
        return 1
    a = 0
    b = 1
    c = 1
    for i in 3...n:
        nxt = a + b + c
        a = b
        b = c
        c = nxt
    return c
}
"""##,
            xpReward: 45
        ),
        CodingTask(
            id: "cs_task_find_single",
            language: .csharp,
            titleRU: "Одиночное число",
            titleEN: "Single Number",
            difficulty: .hard,
            category: .algorithms,
            summaryRU: "Поиск элемента без пары.",
            summaryEN: "Find element with no pair.",
            descriptionRU: ##"""
### Условие
Напишите метод `FindSingle(int[] arr)`.
Поиск элемента без пары.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `FindSingle(int[] arr)`.
Find element with no pair.
"""##,
            requirementsRU: ["Сигнатура: public static int FindSingle(int[] arr)"],
            requirementsEN: ["Signature: public static int FindSingle(int[] arr)"],
            starterCode: ##"""
public static int FindSingle(int[] arr) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "FindSingle([2, 2, 1])", expectedOutput: "1", validationCode: "FindSingle([2, 2, 1]) == 1"),
                    TaskTestCase(title: "Тест 2", inputDescription: "FindSingle([4, 1, 2, 1, 2])", expectedOutput: "4", validationCode: "FindSingle([4, 1, 2, 1, 2]) == 4"),
                    TaskTestCase(title: "Тест 3", inputDescription: "FindSingle([1])", expectedOutput: "1", validationCode: "FindSingle([1]) == 1")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int FindSingle(int[] arr) {
    for x in arr:
        c = 0
        for y in arr:
            if x == y:
                c = c + 1
        if c == 1:
            return x
    return 0
}
"""##,
            xpReward: 60
        ),
        CodingTask(
            id: "cs_task_count_above_threshold",
            language: .csharp,
            titleRU: "Количество элементов выше порога",
            titleEN: "Count Elements Above Threshold",
            difficulty: .medium,
            category: .algorithms,
            summaryRU: "Подсчет элементов x > threshold.",
            summaryEN: "Count items x > threshold.",
            descriptionRU: ##"""
### Условие
Напишите метод `CountAbove(int[] arr, int threshold)`.
Подсчет элементов x > threshold.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `CountAbove(int[] arr, int threshold)`.
Count items x > threshold.
"""##,
            requirementsRU: ["Сигнатура: public static int CountAbove(int[] arr, int threshold)"],
            requirementsEN: ["Signature: public static int CountAbove(int[] arr, int threshold)"],
            starterCode: ##"""
public static int CountAbove(int[] arr, int threshold) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "CountAbove([1, 10, 5, 20], 8)", expectedOutput: "2", validationCode: "CountAbove([1, 10, 5, 20], 8) == 2"),
                    TaskTestCase(title: "Тест 2", inputDescription: "CountAbove([1, 2, 3], 10)", expectedOutput: "0", validationCode: "CountAbove([1, 2, 3], 10) == 0"),
                    TaskTestCase(title: "Тест 3", inputDescription: "CountAbove([5, 5, 5], 4)", expectedOutput: "3", validationCode: "CountAbove([5, 5, 5], 4) == 3")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int CountAbove(int[] arr, int threshold) {
    c = 0
    for x in arr:
        if x > threshold:
            c = c + 1
    return c
}
"""##,
            xpReward: 35
        ),
        CodingTask(
            id: "cs_task_array_diff_max_min",
            language: .csharp,
            titleRU: "Разность между максимумом и минимумом",
            titleEN: "Array Amplitude (Max - Min)",
            difficulty: .medium,
            category: .algorithms,
            summaryRU: "Разность крайних значений списка.",
            summaryEN: "Difference between max and min.",
            descriptionRU: ##"""
### Условие
Напишите метод `Amplitude(int[] arr)`.
Разность крайних значений списка.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `Amplitude(int[] arr)`.
Difference between max and min.
"""##,
            requirementsRU: ["Сигнатура: public static int Amplitude(int[] arr)"],
            requirementsEN: ["Signature: public static int Amplitude(int[] arr)"],
            starterCode: ##"""
public static int Amplitude(int[] arr) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Amplitude([10, 2, 8, 1, 9])", expectedOutput: "9", validationCode: "Amplitude([10, 2, 8, 1, 9]) == 9"),
                    TaskTestCase(title: "Тест 2", inputDescription: "Amplitude([5, 5])", expectedOutput: "0", validationCode: "Amplitude([5, 5]) == 0"),
                    TaskTestCase(title: "Тест 3", inputDescription: "Amplitude([100, 20])", expectedOutput: "80", validationCode: "Amplitude([100, 20]) == 80")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int Amplitude(int[] arr) {
    s = arr.sorted()
    return s.last - s.first
}
"""##,
            xpReward: 40
        ),
        CodingTask(
            id: "cs_task_count_even_elements",
            language: .csharp,
            titleRU: "Количество чётных элементов",
            titleEN: "Count Even Elements",
            difficulty: .easy,
            category: .algorithms,
            summaryRU: "Подсчет элементов с x % 2 == 0.",
            summaryEN: "Count even numbers.",
            descriptionRU: ##"""
### Условие
Напишите метод `CountEvens(int[] arr)`.
Подсчет элементов с x % 2 == 0.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `CountEvens(int[] arr)`.
Count even numbers.
"""##,
            requirementsRU: ["Сигнатура: public static int CountEvens(int[] arr)"],
            requirementsEN: ["Signature: public static int CountEvens(int[] arr)"],
            starterCode: ##"""
public static int CountEvens(int[] arr) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "CountEvens([1, 2, 3, 4, 6])", expectedOutput: "3", validationCode: "CountEvens([1, 2, 3, 4, 6]) == 3"),
                    TaskTestCase(title: "Тест 2", inputDescription: "CountEvens([1, 3, 5])", expectedOutput: "0", validationCode: "CountEvens([1, 3, 5]) == 0"),
                    TaskTestCase(title: "Тест 3", inputDescription: "CountEvens([2, 4, 8])", expectedOutput: "3", validationCode: "CountEvens([2, 4, 8]) == 3")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int CountEvens(int[] arr) {
    c = 0
    for x in arr:
        if x % 2 == 0:
            c = c + 1
    return c
}
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "cs_task_sum_even_squares",
            language: .csharp,
            titleRU: "Сумма квадратов чётных чисел",
            titleEN: "Sum of Even Squares",
            difficulty: .medium,
            category: .algorithms,
            summaryRU: "Суммирование x*x для x % 2 == 0.",
            summaryEN: "Sum x*x for even numbers.",
            descriptionRU: ##"""
### Условие
Напишите метод `SumEvenSq(int[] arr)`.
Суммирование x*x для x % 2 == 0.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `SumEvenSq(int[] arr)`.
Sum x*x for even numbers.
"""##,
            requirementsRU: ["Сигнатура: public static int SumEvenSq(int[] arr)"],
            requirementsEN: ["Signature: public static int SumEvenSq(int[] arr)"],
            starterCode: ##"""
public static int SumEvenSq(int[] arr) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "SumEvenSq([1, 2, 3, 4])", expectedOutput: "20", validationCode: "SumEvenSq([1, 2, 3, 4]) == 20"),
                    TaskTestCase(title: "Тест 2", inputDescription: "SumEvenSq([1, 3, 5])", expectedOutput: "0", validationCode: "SumEvenSq([1, 3, 5]) == 0"),
                    TaskTestCase(title: "Тест 3", inputDescription: "SumEvenSq([2])", expectedOutput: "4", validationCode: "SumEvenSq([2]) == 4")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int SumEvenSq(int[] arr) {
    tot = 0
    for x in arr:
        if x % 2 == 0:
            tot = tot + (x * x)
    return tot
}
"""##,
            xpReward: 40
        ),
        CodingTask(
            id: "cs_task_is_increasing",
            language: .csharp,
            titleRU: "Строго возрастающая последовательность",
            titleEN: "Strictly Increasing Array",
            difficulty: .medium,
            category: .algorithms,
            summaryRU: "Каждый следующий элемент строго больше предыдущего.",
            summaryEN: "Each element strictly greater than previous.",
            descriptionRU: ##"""
### Условие
Напишите метод `IsIncreasing(int[] arr)`.
Каждый следующий элемент строго больше предыдущего.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `IsIncreasing(int[] arr)`.
Each element strictly greater than previous.
"""##,
            requirementsRU: ["Сигнатура: public static bool IsIncreasing(int[] arr)"],
            requirementsEN: ["Signature: public static bool IsIncreasing(int[] arr)"],
            starterCode: ##"""
public static bool IsIncreasing(int[] arr) {
    // Ваш код на C#
    return false;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "IsIncreasing([1, 2, 5, 8])", expectedOutput: "true", validationCode: "IsIncreasing([1, 2, 5, 8]) == true"),
                    TaskTestCase(title: "Тест 2", inputDescription: "IsIncreasing([1, 2, 2, 4])", expectedOutput: "false", validationCode: "IsIncreasing([1, 2, 2, 4]) == false"),
                    TaskTestCase(title: "Тест 3", inputDescription: "IsIncreasing([10])", expectedOutput: "true", validationCode: "IsIncreasing([10]) == true")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static bool IsIncreasing(int[] arr) {
    n = len(arr)
    if n <= 1:
        return true
    for i in 1...n:
        if arr[i] <= arr[i - 1]:
            return false
    return true
}
"""##,
            xpReward: 40
        ),
        CodingTask(
            id: "cs_task_point_dist_sq",
            language: .csharp,
            titleRU: "Квадрат расстояния точки до начала",
            titleEN: "Point Distance Squared",
            difficulty: .easy,
            category: .oopAndPop,
            summaryRU: "Формула x*x + y*y.",
            summaryEN: "Formula x*x + y*y.",
            descriptionRU: ##"""
### Условие
Напишите метод `PointDistSq(int x, int y)`.
Формула x*x + y*y.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `PointDistSq(int x, int y)`.
Formula x*x + y*y.
"""##,
            requirementsRU: ["Сигнатура: public static int PointDistSq(int x, int y)"],
            requirementsEN: ["Signature: public static int PointDistSq(int x, int y)"],
            starterCode: ##"""
public static int PointDistSq(int x, int y) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "PointDistSq(3, 4)", expectedOutput: "25", validationCode: "PointDistSq(3, 4) == 25"),
                    TaskTestCase(title: "Тест 2", inputDescription: "PointDistSq(0, 5)", expectedOutput: "25", validationCode: "PointDistSq(0, 5) == 25"),
                    TaskTestCase(title: "Тест 3", inputDescription: "PointDistSq(1, 1)", expectedOutput: "2", validationCode: "PointDistSq(1, 1) == 2")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int PointDistSq(int x, int y) {
    return x * x + y * y;
}
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "cs_task_rect_area",
            language: .csharp,
            titleRU: "Площадь прямоугольника",
            titleEN: "Rectangle Area",
            difficulty: .easy,
            category: .oopAndPop,
            summaryRU: "Произведение w * h.",
            summaryEN: "Product w * h.",
            descriptionRU: ##"""
### Условие
Напишите метод `RectArea(int w, int h)`.
Произведение w * h.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `RectArea(int w, int h)`.
Product w * h.
"""##,
            requirementsRU: ["Сигнатура: public static int RectArea(int w, int h)"],
            requirementsEN: ["Signature: public static int RectArea(int w, int h)"],
            starterCode: ##"""
public static int RectArea(int w, int h) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "RectArea(5, 4)", expectedOutput: "20", validationCode: "RectArea(5, 4) == 20"),
                    TaskTestCase(title: "Тест 2", inputDescription: "RectArea(10, 10)", expectedOutput: "100", validationCode: "RectArea(10, 10) == 100"),
                    TaskTestCase(title: "Тест 3", inputDescription: "RectArea(7, 3)", expectedOutput: "21", validationCode: "RectArea(7, 3) == 21")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int RectArea(int w, int h) {
    return w * h;
}
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "cs_task_step_counter",
            language: .csharp,
            titleRU: "Инкремент счетчика",
            titleEN: "Counter Increment",
            difficulty: .easy,
            category: .oopAndPop,
            summaryRU: "Шаг счетчика init_val + step.",
            summaryEN: "Counter step init_val + step.",
            descriptionRU: ##"""
### Условие
Напишите метод `StepCounter(int init_val, int step)`.
Шаг счетчика init_val + step.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `StepCounter(int init_val, int step)`.
Counter step init_val + step.
"""##,
            requirementsRU: ["Сигнатура: public static int StepCounter(int init_val, int step)"],
            requirementsEN: ["Signature: public static int StepCounter(int init_val, int step)"],
            starterCode: ##"""
public static int StepCounter(int init_val, int step) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "StepCounter(0, 1)", expectedOutput: "1", validationCode: "StepCounter(0, 1) == 1"),
                    TaskTestCase(title: "Тест 2", inputDescription: "StepCounter(10, 5)", expectedOutput: "15", validationCode: "StepCounter(10, 5) == 15"),
                    TaskTestCase(title: "Тест 3", inputDescription: "StepCounter(100, -10)", expectedOutput: "90", validationCode: "StepCounter(100, -10) == 90")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int StepCounter(int init_val, int step) {
    return init_val + step;
}
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "cs_task_calc_balance",
            language: .csharp,
            titleRU: "Баланс банковского счета",
            titleEN: "Bank Account Balance",
            difficulty: .medium,
            category: .oopAndPop,
            summaryRU: "Проверка баланса перед снятием средств.",
            summaryEN: "Validate balance before withdrawal.",
            descriptionRU: ##"""
### Условие
Напишите метод `CalcBalance(int initial, int deposit, int withdraw)`.
Проверка баланса перед снятием средств.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `CalcBalance(int initial, int deposit, int withdraw)`.
Validate balance before withdrawal.
"""##,
            requirementsRU: ["Сигнатура: public static int CalcBalance(int initial, int deposit, int withdraw)"],
            requirementsEN: ["Signature: public static int CalcBalance(int initial, int deposit, int withdraw)"],
            starterCode: ##"""
public static int CalcBalance(int initial, int deposit, int withdraw) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "CalcBalance(100, 50, 30)", expectedOutput: "120", validationCode: "CalcBalance(100, 50, 30) == 120"),
                    TaskTestCase(title: "Тест 2", inputDescription: "CalcBalance(100, 50, 200)", expectedOutput: "150", validationCode: "CalcBalance(100, 50, 200) == 150"),
                    TaskTestCase(title: "Тест 3", inputDescription: "CalcBalance(0, 100, 100)", expectedOutput: "0", validationCode: "CalcBalance(0, 100, 100) == 0")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int CalcBalance(int initial, int deposit, int withdraw) {
    b = initial + deposit
    if b >= withdraw:
        return b - withdraw
    return b
}
"""##,
            xpReward: 35
        ),
        CodingTask(
            id: "cs_task_calc_gpa",
            language: .csharp,
            titleRU: "Средний балл оценок",
            titleEN: "Average Grade (GPA)",
            difficulty: .medium,
            category: .oopAndPop,
            summaryRU: "Сумма оценок деленная на их количество.",
            summaryEN: "Sum of grades divided by count.",
            descriptionRU: ##"""
### Условие
Напишите метод `CalcGpa(int[] grades)`.
Сумма оценок деленная на их количество.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `CalcGpa(int[] grades)`.
Sum of grades divided by count.
"""##,
            requirementsRU: ["Сигнатура: public static int CalcGpa(int[] grades)"],
            requirementsEN: ["Signature: public static int CalcGpa(int[] grades)"],
            starterCode: ##"""
public static int CalcGpa(int[] grades) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "CalcGpa([5, 4, 3])", expectedOutput: "4", validationCode: "CalcGpa([5, 4, 3]) == 4"),
                    TaskTestCase(title: "Тест 2", inputDescription: "CalcGpa([5, 5, 5, 5])", expectedOutput: "5", validationCode: "CalcGpa([5, 5, 5, 5]) == 5"),
                    TaskTestCase(title: "Тест 3", inputDescription: "CalcGpa([10, 20])", expectedOutput: "15", validationCode: "CalcGpa([10, 20]) == 15")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int CalcGpa(int[] grades) {
    tot = 0
    for g in grades:
        tot = tot + g
    return tot / len(grades)
}
"""##,
            xpReward: 35
        ),
        CodingTask(
            id: "cs_task_circle_circumference",
            language: .csharp,
            titleRU: "Длина окружности (6 * r)",
            titleEN: "Circle Circumference",
            difficulty: .easy,
            category: .oopAndPop,
            summaryRU: "Формула 6 * r при pi = 3.",
            summaryEN: "Formula 6 * r with pi = 3.",
            descriptionRU: ##"""
### Условие
Напишите метод `Circumference(int r)`.
Формула 6 * r при pi = 3.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `Circumference(int r)`.
Formula 6 * r with pi = 3.
"""##,
            requirementsRU: ["Сигнатура: public static int Circumference(int r)"],
            requirementsEN: ["Signature: public static int Circumference(int r)"],
            starterCode: ##"""
public static int Circumference(int r) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Circumference(5)", expectedOutput: "30", validationCode: "Circumference(5) == 30"),
                    TaskTestCase(title: "Тест 2", inputDescription: "Circumference(1)", expectedOutput: "6", validationCode: "Circumference(1) == 6"),
                    TaskTestCase(title: "Тест 3", inputDescription: "Circumference(10)", expectedOutput: "60", validationCode: "Circumference(10) == 60")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int Circumference(int r) {
    return 6 * r;
}
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "cs_task_car_accelerate",
            language: .csharp,
            titleRU: "Ускорение автомобиля",
            titleEN: "Car Acceleration",
            difficulty: .easy,
            category: .oopAndPop,
            summaryRU: "Ограничение максимальной скорости min(speed + delta, max_speed).",
            summaryEN: "Cap at max_speed.",
            descriptionRU: ##"""
### Условие
Напишите метод `Accelerate(int speed, int delta, int max_speed)`.
Ограничение максимальной скорости min(speed + delta, max_speed).
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `Accelerate(int speed, int delta, int max_speed)`.
Cap at max_speed.
"""##,
            requirementsRU: ["Сигнатура: public static int Accelerate(int speed, int delta, int max_speed)"],
            requirementsEN: ["Signature: public static int Accelerate(int speed, int delta, int max_speed)"],
            starterCode: ##"""
public static int Accelerate(int speed, int delta, int max_speed) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Accelerate(60, 20, 100)", expectedOutput: "80", validationCode: "Accelerate(60, 20, 100) == 80"),
                    TaskTestCase(title: "Тест 2", inputDescription: "Accelerate(90, 30, 100)", expectedOutput: "100", validationCode: "Accelerate(90, 30, 100) == 100"),
                    TaskTestCase(title: "Тест 3", inputDescription: "Accelerate(0, 50, 120)", expectedOutput: "50", validationCode: "Accelerate(0, 50, 120) == 50")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int Accelerate(int speed, int delta, int max_speed) {
    return min(speed + delta, max_speed);
}
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "cs_task_seconds_remainder",
            language: .csharp,
            titleRU: "Остаток секунд таймера",
            titleEN: "Timer Seconds Remainder",
            difficulty: .easy,
            category: .oopAndPop,
            summaryRU: "Вычисление seconds % 60.",
            summaryEN: "Calculate seconds % 60.",
            descriptionRU: ##"""
### Условие
Напишите метод `SecondsRemainder(int seconds)`.
Вычисление seconds % 60.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `SecondsRemainder(int seconds)`.
Calculate seconds % 60.
"""##,
            requirementsRU: ["Сигнатура: public static int SecondsRemainder(int seconds)"],
            requirementsEN: ["Signature: public static int SecondsRemainder(int seconds)"],
            starterCode: ##"""
public static int SecondsRemainder(int seconds) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "SecondsRemainder(125)", expectedOutput: "5", validationCode: "SecondsRemainder(125) == 5"),
                    TaskTestCase(title: "Тест 2", inputDescription: "SecondsRemainder(60)", expectedOutput: "0", validationCode: "SecondsRemainder(60) == 0"),
                    TaskTestCase(title: "Тест 3", inputDescription: "SecondsRemainder(59)", expectedOutput: "59", validationCode: "SecondsRemainder(59) == 59")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int SecondsRemainder(int seconds) {
    return seconds % 60;
}
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "cs_task_format_book",
            language: .csharp,
            titleRU: "Форматирование названия книги",
            titleEN: "Format Book Title",
            difficulty: .easy,
            category: .oopAndPop,
            summaryRU: "Строка вида title + ' by ' + author.",
            summaryEN: "Format as title + ' by ' + author.",
            descriptionRU: ##"""
### Условие
Напишите метод `FormatBook(string title, string author)`.
Строка вида title + ' by ' + author.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `FormatBook(string title, string author)`.
Format as title + ' by ' + author.
"""##,
            requirementsRU: ["Сигнатура: public static string FormatBook(string title, string author)"],
            requirementsEN: ["Signature: public static string FormatBook(string title, string author)"],
            starterCode: ##"""
public static string FormatBook(string title, string author) {
    // Ваш код на C#
    return "";
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "FormatBook(\"1984\", \"Orwell\")", expectedOutput: "\"1984 by Orwell\"", validationCode: "FormatBook(\"1984\", \"Orwell\") == \"1984 by Orwell\""),
                    TaskTestCase(title: "Тест 2", inputDescription: "FormatBook(\"Hamlet\", \"Shakespeare\")", expectedOutput: "\"Hamlet by Shakespeare\"", validationCode: "FormatBook(\"Hamlet\", \"Shakespeare\") == \"Hamlet by Shakespeare\""),
                    TaskTestCase(title: "Тест 3", inputDescription: "FormatBook(\"Clean Code\", \"Martin\")", expectedOutput: "\"Clean Code by Martin\"", validationCode: "FormatBook(\"Clean Code\", \"Martin\") == \"Clean Code by Martin\"")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static string FormatBook(string title, string author) {
    return title + " by " + author;
}
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "cs_task_item_cost",
            language: .csharp,
            titleRU: "Стоимость товара в заказе",
            titleEN: "Order Item Cost",
            difficulty: .easy,
            category: .oopAndPop,
            summaryRU: "Произведение цены на количество price * quantity.",
            summaryEN: "Calculate price * quantity.",
            descriptionRU: ##"""
### Условие
Напишите метод `ItemCost(int price, int quantity)`.
Произведение цены на количество price * quantity.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `ItemCost(int price, int quantity)`.
Calculate price * quantity.
"""##,
            requirementsRU: ["Сигнатура: public static int ItemCost(int price, int quantity)"],
            requirementsEN: ["Signature: public static int ItemCost(int price, int quantity)"],
            starterCode: ##"""
public static int ItemCost(int price, int quantity) {
    // Ваш код на C#
    return 0;
}
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "ItemCost(25, 4)", expectedOutput: "100", validationCode: "ItemCost(25, 4) == 100"),
                    TaskTestCase(title: "Тест 2", inputDescription: "ItemCost(10, 0)", expectedOutput: "0", validationCode: "ItemCost(10, 0) == 0"),
                    TaskTestCase(title: "Тест 3", inputDescription: "ItemCost(15, 3)", expectedOutput: "45", validationCode: "ItemCost(15, 3) == 45")
            ],
            hintsRU: ["Внимательно проверьте типы возвращаемого значения и аргументов."],
            hintsEN: ["Check return types and argument signatures."],
            solutionCode: ##"""
public static int ItemCost(int price, int quantity) {
    return price * quantity;
}
"""##,
            xpReward: 25
        )
    ]
}
