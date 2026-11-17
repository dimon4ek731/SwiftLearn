import Foundation

extension TaskStore {
    public static let pythonTasks: [CodingTask] = [
        CodingTask(
            id: "py_task_sum_two",
            language: .python,
            titleRU: "Сумма двух чисел",
            titleEN: "Sum of Two Numbers",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Сложение двух чисел a и b.",
            summaryEN: "Sum two numbers a and b.",
            descriptionRU: ##"""
### Условие
Напишите функцию `add(a, b)`.
Сложение двух чисел a и b.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `add(a, b)`.
Sum two numbers a and b.
"""##,
            requirementsRU: ["Сигнатура: def add(a, b)"],
            requirementsEN: ["Signature: def add(a, b)"],
            starterCode: ##"""
def add(a, b):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "add(3, 7)", expectedOutput: "10", validationCode: "add(3, 7) == 10"),
                    TaskTestCase(title: "Тест 2", inputDescription: "add(-5, 5)", expectedOutput: "0", validationCode: "add(-5, 5) == 0"),
                    TaskTestCase(title: "Тест 3", inputDescription: "add(-12, -8)", expectedOutput: "-20", validationCode: "add(-12, -8) == -20")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def add(a, b):
    return a + b
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "py_task_is_even",
            language: .python,
            titleRU: "Проверка на чётность",
            titleEN: "Check if Even",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Проверка делимости на 2 без остатка.",
            summaryEN: "Check divisibility by 2 without remainder.",
            descriptionRU: ##"""
### Условие
Напишите функцию `is_even(n)`.
Проверка делимости на 2 без остатка.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `is_even(n)`.
Check divisibility by 2 without remainder.
"""##,
            requirementsRU: ["Сигнатура: def is_even(n)"],
            requirementsEN: ["Signature: def is_even(n)"],
            starterCode: ##"""
def is_even(n):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "is_even(4)", expectedOutput: "True", validationCode: "is_even(4) == True"),
                    TaskTestCase(title: "Тест 2", inputDescription: "is_even(7)", expectedOutput: "False", validationCode: "is_even(7) == False"),
                    TaskTestCase(title: "Тест 3", inputDescription: "is_even(0)", expectedOutput: "True", validationCode: "is_even(0) == True")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def is_even(n):
    return n % 2 == 0
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "py_task_celsius_to_fahr",
            language: .python,
            titleRU: "Цельсий в Фаренгейт",
            titleEN: "Celsius to Fahrenheit",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Формула: c * 9 / 5 + 32.",
            summaryEN: "Formula: c * 9 / 5 + 32.",
            descriptionRU: ##"""
### Условие
Напишите функцию `to_fahrenheit(c)`.
Формула: c * 9 / 5 + 32.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `to_fahrenheit(c)`.
Formula: c * 9 / 5 + 32.
"""##,
            requirementsRU: ["Сигнатура: def to_fahrenheit(c)"],
            requirementsEN: ["Signature: def to_fahrenheit(c)"],
            starterCode: ##"""
def to_fahrenheit(c):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "to_fahrenheit(0)", expectedOutput: "32", validationCode: "to_fahrenheit(0) == 32"),
                    TaskTestCase(title: "Тест 2", inputDescription: "to_fahrenheit(100)", expectedOutput: "212", validationCode: "to_fahrenheit(100) == 212"),
                    TaskTestCase(title: "Тест 3", inputDescription: "to_fahrenheit(20)", expectedOutput: "68", validationCode: "to_fahrenheit(20) == 68")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def to_fahrenheit(c):
    return c * 9 / 5 + 32
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "py_task_perimeter_rect",
            language: .python,
            titleRU: "Периметр прямоугольника",
            titleEN: "Rectangle Perimeter",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Формула: 2 * (w + h).",
            summaryEN: "Formula: 2 * (w + h).",
            descriptionRU: ##"""
### Условие
Напишите функцию `perimeter(w, h)`.
Формула: 2 * (w + h).
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `perimeter(w, h)`.
Formula: 2 * (w + h).
"""##,
            requirementsRU: ["Сигнатура: def perimeter(w, h)"],
            requirementsEN: ["Signature: def perimeter(w, h)"],
            starterCode: ##"""
def perimeter(w, h):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "perimeter(5, 10)", expectedOutput: "30", validationCode: "perimeter(5, 10) == 30"),
                    TaskTestCase(title: "Тест 2", inputDescription: "perimeter(3, 4)", expectedOutput: "14", validationCode: "perimeter(3, 4) == 14"),
                    TaskTestCase(title: "Тест 3", inputDescription: "perimeter(1, 1)", expectedOutput: "4", validationCode: "perimeter(1, 1) == 4")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def perimeter(w, h):
    return 2 * (w + h)
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "py_task_max_of_three",
            language: .python,
            titleRU: "Максимум из трёх чисел",
            titleEN: "Maximum of Three Numbers",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Поиск наибольшего из трех аргументов.",
            summaryEN: "Find largest of three arguments.",
            descriptionRU: ##"""
### Условие
Напишите функцию `max_of_three(a, b, c)`.
Поиск наибольшего из трех аргументов.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `max_of_three(a, b, c)`.
Find largest of three arguments.
"""##,
            requirementsRU: ["Сигнатура: def max_of_three(a, b, c)"],
            requirementsEN: ["Signature: def max_of_three(a, b, c)"],
            starterCode: ##"""
def max_of_three(a, b, c):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "max_of_three(1, 5, 3)", expectedOutput: "5", validationCode: "max_of_three(1, 5, 3) == 5"),
                    TaskTestCase(title: "Тест 2", inputDescription: "max_of_three(10, 2, 7)", expectedOutput: "10", validationCode: "max_of_three(10, 2, 7) == 10"),
                    TaskTestCase(title: "Тест 3", inputDescription: "max_of_three(-5, -2, -9)", expectedOutput: "-2", validationCode: "max_of_three(-5, -2, -9) == -2")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def max_of_three(a, b, c):
    return max(a, max(b, c))
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "py_task_is_divisible",
            language: .python,
            titleRU: "Проверка делимости",
            titleEN: "Check Divisibility",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Определение кратности n числу d без остатка.",
            summaryEN: "Check if n is divisible by d.",
            descriptionRU: ##"""
### Условие
Напишите функцию `is_divisible(n, d)`.
Определение кратности n числу d без остатка.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `is_divisible(n, d)`.
Check if n is divisible by d.
"""##,
            requirementsRU: ["Сигнатура: def is_divisible(n, d)"],
            requirementsEN: ["Signature: def is_divisible(n, d)"],
            starterCode: ##"""
def is_divisible(n, d):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "is_divisible(15, 3)", expectedOutput: "True", validationCode: "is_divisible(15, 3) == True"),
                    TaskTestCase(title: "Тест 2", inputDescription: "is_divisible(10, 3)", expectedOutput: "False", validationCode: "is_divisible(10, 3) == False"),
                    TaskTestCase(title: "Тест 3", inputDescription: "is_divisible(100, 25)", expectedOutput: "True", validationCode: "is_divisible(100, 25) == True")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def is_divisible(n, d):
    return n % d == 0
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "py_task_hypotenuse_sq",
            language: .python,
            titleRU: "Квадрат гипотенузы",
            titleEN: "Hypotenuse Squared",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Теорема Пифагора: a*a + b*b.",
            summaryEN: "Pythagorean theorem: a*a + b*b.",
            descriptionRU: ##"""
### Условие
Напишите функцию `hypot_sq(a, b)`.
Теорема Пифагора: a*a + b*b.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `hypot_sq(a, b)`.
Pythagorean theorem: a*a + b*b.
"""##,
            requirementsRU: ["Сигнатура: def hypot_sq(a, b)"],
            requirementsEN: ["Signature: def hypot_sq(a, b)"],
            starterCode: ##"""
def hypot_sq(a, b):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "hypot_sq(3, 4)", expectedOutput: "25", validationCode: "hypot_sq(3, 4) == 25"),
                    TaskTestCase(title: "Тест 2", inputDescription: "hypot_sq(5, 12)", expectedOutput: "169", validationCode: "hypot_sq(5, 12) == 169"),
                    TaskTestCase(title: "Тест 3", inputDescription: "hypot_sq(6, 8)", expectedOutput: "100", validationCode: "hypot_sq(6, 8) == 100")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def hypot_sq(a, b):
    return a * a + b * b
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "py_task_sum_to_n",
            language: .python,
            titleRU: "Сумма чисел от 1 до N",
            titleEN: "Sum from 1 to N",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Арифметическая сумма: n * (n + 1) / 2.",
            summaryEN: "Sum: n * (n + 1) / 2.",
            descriptionRU: ##"""
### Условие
Напишите функцию `sum_to_n(n)`.
Арифметическая сумма: n * (n + 1) / 2.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `sum_to_n(n)`.
Sum: n * (n + 1) / 2.
"""##,
            requirementsRU: ["Сигнатура: def sum_to_n(n)"],
            requirementsEN: ["Signature: def sum_to_n(n)"],
            starterCode: ##"""
def sum_to_n(n):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "sum_to_n(5)", expectedOutput: "15", validationCode: "sum_to_n(5) == 15"),
                    TaskTestCase(title: "Тест 2", inputDescription: "sum_to_n(10)", expectedOutput: "55", validationCode: "sum_to_n(10) == 55"),
                    TaskTestCase(title: "Тест 3", inputDescription: "sum_to_n(1)", expectedOutput: "1", validationCode: "sum_to_n(1) == 1")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def sum_to_n(n):
    return n * (n + 1) / 2
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "py_task_abs_diff",
            language: .python,
            titleRU: "Абсолютная разность",
            titleEN: "Absolute Difference",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Модуль разности |a - b|.",
            summaryEN: "Absolute difference |a - b|.",
            descriptionRU: ##"""
### Условие
Напишите функцию `abs_diff(a, b)`.
Модуль разности |a - b|.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `abs_diff(a, b)`.
Absolute difference |a - b|.
"""##,
            requirementsRU: ["Сигнатура: def abs_diff(a, b)"],
            requirementsEN: ["Signature: def abs_diff(a, b)"],
            starterCode: ##"""
def abs_diff(a, b):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "abs_diff(10, 4)", expectedOutput: "6", validationCode: "abs_diff(10, 4) == 6"),
                    TaskTestCase(title: "Тест 2", inputDescription: "abs_diff(4, 10)", expectedOutput: "6", validationCode: "abs_diff(4, 10) == 6"),
                    TaskTestCase(title: "Тест 3", inputDescription: "abs_diff(-5, 5)", expectedOutput: "10", validationCode: "abs_diff(-5, 5) == 10")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def abs_diff(a, b):
    return abs(a - b)
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "py_task_last_digit",
            language: .python,
            titleRU: "Последняя цифра числа",
            titleEN: "Last Digit of a Number",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Остаток от деления модуля числа на 10.",
            summaryEN: "Modulo 10 of absolute value.",
            descriptionRU: ##"""
### Условие
Напишите функцию `last_digit(n)`.
Остаток от деления модуля числа на 10.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `last_digit(n)`.
Modulo 10 of absolute value.
"""##,
            requirementsRU: ["Сигнатура: def last_digit(n)"],
            requirementsEN: ["Signature: def last_digit(n)"],
            starterCode: ##"""
def last_digit(n):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "last_digit(147)", expectedOutput: "7", validationCode: "last_digit(147) == 7"),
                    TaskTestCase(title: "Тест 2", inputDescription: "last_digit(-42)", expectedOutput: "2", validationCode: "last_digit(-42) == 2"),
                    TaskTestCase(title: "Тест 3", inputDescription: "last_digit(0)", expectedOutput: "0", validationCode: "last_digit(0) == 0")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def last_digit(n):
    return abs(n) % 10
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "py_task_power",
            language: .python,
            titleRU: "Возведение в степень",
            titleEN: "Power Function",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Умножение числа base самого на себя exp раз.",
            summaryEN: "Multiply base by itself exp times.",
            descriptionRU: ##"""
### Условие
Напишите функцию `power(base, exp)`.
Умножение числа base самого на себя exp раз.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `power(base, exp)`.
Multiply base by itself exp times.
"""##,
            requirementsRU: ["Сигнатура: def power(base, exp)"],
            requirementsEN: ["Signature: def power(base, exp)"],
            starterCode: ##"""
def power(base, exp):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "power(2, 3)", expectedOutput: "8", validationCode: "power(2, 3) == 8"),
                    TaskTestCase(title: "Тест 2", inputDescription: "power(5, 2)", expectedOutput: "25", validationCode: "power(5, 2) == 25"),
                    TaskTestCase(title: "Тест 3", inputDescription: "power(7, 0)", expectedOutput: "1", validationCode: "power(7, 0) == 1")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def power(base, exp):
    res = 1
    for i in 1...exp:
        res = res * base
    return res
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "py_task_is_multiple_of_5",
            language: .python,
            titleRU: "Кратность 5",
            titleEN: "Is Multiple of 5",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Проверка делимости на 5: n % 5 == 0.",
            summaryEN: "Check divisibility by 5.",
            descriptionRU: ##"""
### Условие
Напишите функцию `is_multiple_5(n)`.
Проверка делимости на 5: n % 5 == 0.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `is_multiple_5(n)`.
Check divisibility by 5.
"""##,
            requirementsRU: ["Сигнатура: def is_multiple_5(n)"],
            requirementsEN: ["Signature: def is_multiple_5(n)"],
            starterCode: ##"""
def is_multiple_5(n):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "is_multiple_5(25)", expectedOutput: "True", validationCode: "is_multiple_5(25) == True"),
                    TaskTestCase(title: "Тест 2", inputDescription: "is_multiple_5(12)", expectedOutput: "False", validationCode: "is_multiple_5(12) == False"),
                    TaskTestCase(title: "Тест 3", inputDescription: "is_multiple_5(0)", expectedOutput: "True", validationCode: "is_multiple_5(0) == True")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def is_multiple_5(n):
    return n % 5 == 0
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "py_task_cube_number",
            language: .python,
            titleRU: "Куб числа",
            titleEN: "Cube of Number",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Возведение числа в третью степень n * n * n.",
            summaryEN: "Cube of integer n * n * n.",
            descriptionRU: ##"""
### Условие
Напишите функцию `cube(n)`.
Возведение числа в третью степень n * n * n.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `cube(n)`.
Cube of integer n * n * n.
"""##,
            requirementsRU: ["Сигнатура: def cube(n)"],
            requirementsEN: ["Signature: def cube(n)"],
            starterCode: ##"""
def cube(n):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "cube(3)", expectedOutput: "27", validationCode: "cube(3) == 27"),
                    TaskTestCase(title: "Тест 2", inputDescription: "cube(-2)", expectedOutput: "-8", validationCode: "cube(-2) == -8"),
                    TaskTestCase(title: "Тест 3", inputDescription: "cube(0)", expectedOutput: "0", validationCode: "cube(0) == 0")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def cube(n):
    return n * n * n
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "py_task_average_of_two",
            language: .python,
            titleRU: "Среднее двух чисел",
            titleEN: "Average of Two Numbers",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Вычисление (a + b) / 2.",
            summaryEN: "Calculate (a + b) / 2.",
            descriptionRU: ##"""
### Условие
Напишите функцию `avg_two(a, b)`.
Вычисление (a + b) / 2.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `avg_two(a, b)`.
Calculate (a + b) / 2.
"""##,
            requirementsRU: ["Сигнатура: def avg_two(a, b)"],
            requirementsEN: ["Signature: def avg_two(a, b)"],
            starterCode: ##"""
def avg_two(a, b):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "avg_two(10, 20)", expectedOutput: "15", validationCode: "avg_two(10, 20) == 15"),
                    TaskTestCase(title: "Тест 2", inputDescription: "avg_two(4, 6)", expectedOutput: "5", validationCode: "avg_two(4, 6) == 5"),
                    TaskTestCase(title: "Тест 3", inputDescription: "avg_two(0, 100)", expectedOutput: "50", validationCode: "avg_two(0, 100) == 50")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def avg_two(a, b):
    return (a + b) / 2
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "py_task_is_positive",
            language: .python,
            titleRU: "Проверка на положительность",
            titleEN: "Check if Positive",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Число строго больше 0: n > 0.",
            summaryEN: "Number strictly greater than 0.",
            descriptionRU: ##"""
### Условие
Напишите функцию `is_positive(n)`.
Число строго больше 0: n > 0.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `is_positive(n)`.
Number strictly greater than 0.
"""##,
            requirementsRU: ["Сигнатура: def is_positive(n)"],
            requirementsEN: ["Signature: def is_positive(n)"],
            starterCode: ##"""
def is_positive(n):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "is_positive(42)", expectedOutput: "True", validationCode: "is_positive(42) == True"),
                    TaskTestCase(title: "Тест 2", inputDescription: "is_positive(-5)", expectedOutput: "False", validationCode: "is_positive(-5) == False"),
                    TaskTestCase(title: "Тест 3", inputDescription: "is_positive(0)", expectedOutput: "False", validationCode: "is_positive(0) == False")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def is_positive(n):
    return n > 0
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "py_task_clamp_val",
            language: .python,
            titleRU: "Ограничение значения (Clamp)",
            titleEN: "Clamp Value in Range",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Ограничение числа между low и high.",
            summaryEN: "Keep number between low and high.",
            descriptionRU: ##"""
### Условие
Напишите функцию `clamp(val, low, high)`.
Ограничение числа между low и high.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `clamp(val, low, high)`.
Keep number between low and high.
"""##,
            requirementsRU: ["Сигнатура: def clamp(val, low, high)"],
            requirementsEN: ["Signature: def clamp(val, low, high)"],
            starterCode: ##"""
def clamp(val, low, high):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "clamp(15, 0, 10)", expectedOutput: "10", validationCode: "clamp(15, 0, 10) == 10"),
                    TaskTestCase(title: "Тест 2", inputDescription: "clamp(-5, 0, 10)", expectedOutput: "0", validationCode: "clamp(-5, 0, 10) == 0"),
                    TaskTestCase(title: "Тест 3", inputDescription: "clamp(7, 0, 10)", expectedOutput: "7", validationCode: "clamp(7, 0, 10) == 7")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def clamp(val, low, high):
    return min(high, max(low, val))
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "py_task_leap_year",
            language: .python,
            titleRU: "Високосный год",
            titleEN: "Leap Year Checker",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Делимость на 400 или (на 4 и не на 100).",
            summaryEN: "Divisible by 400 or (by 4 and not 100).",
            descriptionRU: ##"""
### Условие
Напишите функцию `is_leap_year(year)`.
Делимость на 400 или (на 4 и не на 100).
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `is_leap_year(year)`.
Divisible by 400 or (by 4 and not 100).
"""##,
            requirementsRU: ["Сигнатура: def is_leap_year(year)"],
            requirementsEN: ["Signature: def is_leap_year(year)"],
            starterCode: ##"""
def is_leap_year(year):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "is_leap_year(2024)", expectedOutput: "True", validationCode: "is_leap_year(2024) == True"),
                    TaskTestCase(title: "Тест 2", inputDescription: "is_leap_year(1900)", expectedOutput: "False", validationCode: "is_leap_year(1900) == False"),
                    TaskTestCase(title: "Тест 3", inputDescription: "is_leap_year(2000)", expectedOutput: "True", validationCode: "is_leap_year(2000) == True")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def is_leap_year(year):
    if year % 400 == 0:
        return True
    if year % 100 == 0:
        return False
    return year % 4 == 0
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "py_task_fibonacci",
            language: .python,
            titleRU: "N-ое число Фибоначчи",
            titleEN: "Nth Fibonacci Number",
            difficulty: .medium,
            category: .basicsAndMath,
            summaryRU: "Последовательность 0, 1, 1, 2, 3, 5, 8...",
            summaryEN: "Fibonacci sequence.",
            descriptionRU: ##"""
### Условие
Напишите функцию `fibonacci(n)`.
Последовательность 0, 1, 1, 2, 3, 5, 8...
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `fibonacci(n)`.
Fibonacci sequence.
"""##,
            requirementsRU: ["Сигнатура: def fibonacci(n)"],
            requirementsEN: ["Signature: def fibonacci(n)"],
            starterCode: ##"""
def fibonacci(n):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "fibonacci(0)", expectedOutput: "0", validationCode: "fibonacci(0) == 0"),
                    TaskTestCase(title: "Тест 2", inputDescription: "fibonacci(1)", expectedOutput: "1", validationCode: "fibonacci(1) == 1"),
                    TaskTestCase(title: "Тест 3", inputDescription: "fibonacci(6)", expectedOutput: "8", validationCode: "fibonacci(6) == 8")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def fibonacci(n):
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
"""##,
            xpReward: 40
        ),
        CodingTask(
            id: "py_task_factorial",
            language: .python,
            titleRU: "Факториал числа N!",
            titleEN: "Factorial of N",
            difficulty: .easy,
            category: .basicsAndMath,
            summaryRU: "Произведение всех чисел от 1 до N.",
            summaryEN: "Product of integers from 1 to N.",
            descriptionRU: ##"""
### Условие
Напишите функцию `factorial(n)`.
Произведение всех чисел от 1 до N.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `factorial(n)`.
Product of integers from 1 to N.
"""##,
            requirementsRU: ["Сигнатура: def factorial(n)"],
            requirementsEN: ["Signature: def factorial(n)"],
            starterCode: ##"""
def factorial(n):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "factorial(5)", expectedOutput: "120", validationCode: "factorial(5) == 120"),
                    TaskTestCase(title: "Тест 2", inputDescription: "factorial(3)", expectedOutput: "6", validationCode: "factorial(3) == 6"),
                    TaskTestCase(title: "Тест 3", inputDescription: "factorial(0)", expectedOutput: "1", validationCode: "factorial(0) == 1")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def factorial(n):
    res = 1
    for i in 1...n:
        res = res * i
    return res
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "py_task_is_prime",
            language: .python,
            titleRU: "Проверка простого числа",
            titleEN: "Check Prime Number",
            difficulty: .medium,
            category: .basicsAndMath,
            summaryRU: "Число больше 1 без делителей.",
            summaryEN: "Integer > 1 with no divisors.",
            descriptionRU: ##"""
### Условие
Напишите функцию `is_prime(n)`.
Число больше 1 без делителей.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `is_prime(n)`.
Integer > 1 with no divisors.
"""##,
            requirementsRU: ["Сигнатура: def is_prime(n)"],
            requirementsEN: ["Signature: def is_prime(n)"],
            starterCode: ##"""
def is_prime(n):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "is_prime(7)", expectedOutput: "True", validationCode: "is_prime(7) == True"),
                    TaskTestCase(title: "Тест 2", inputDescription: "is_prime(4)", expectedOutput: "False", validationCode: "is_prime(4) == False"),
                    TaskTestCase(title: "Тест 3", inputDescription: "is_prime(13)", expectedOutput: "True", validationCode: "is_prime(13) == True")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def is_prime(n):
    if n <= 1:
        return False
    for i in 2...n:
        if i != n and n % i == 0:
            return False
    return True
"""##,
            xpReward: 40
        ),
        CodingTask(
            id: "py_task_reverse_string",
            language: .python,
            titleRU: "Разворот строки",
            titleEN: "Reverse a String",
            difficulty: .easy,
            category: .stringsAndCollections,
            summaryRU: "Чтение строки задом наперед.",
            summaryEN: "Reverse string characters.",
            descriptionRU: ##"""
### Условие
Напишите функцию `reverse_string(s)`.
Чтение строки задом наперед.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `reverse_string(s)`.
Reverse string characters.
"""##,
            requirementsRU: ["Сигнатура: def reverse_string(s)"],
            requirementsEN: ["Signature: def reverse_string(s)"],
            starterCode: ##"""
def reverse_string(s):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "reverse_string(\"hello\")", expectedOutput: "\"olleh\"", validationCode: "reverse_string(\"hello\") == \"olleh\""),
                    TaskTestCase(title: "Тест 2", inputDescription: "reverse_string(\"Swift\")", expectedOutput: "\"tfiwS\"", validationCode: "reverse_string(\"Swift\") == \"tfiwS\""),
                    TaskTestCase(title: "Тест 3", inputDescription: "reverse_string(\"\")", expectedOutput: "\"\"", validationCode: "reverse_string(\"\") == \"\"")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def reverse_string(s):
    return s.reversed()
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "py_task_is_palindrome",
            language: .python,
            titleRU: "Проверка палиндрома",
            titleEN: "Palindrome Check",
            difficulty: .easy,
            category: .stringsAndCollections,
            summaryRU: "Строка равна своему развороту.",
            summaryEN: "String equals its reverse.",
            descriptionRU: ##"""
### Условие
Напишите функцию `is_palindrome(s)`.
Строка равна своему развороту.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `is_palindrome(s)`.
String equals its reverse.
"""##,
            requirementsRU: ["Сигнатура: def is_palindrome(s)"],
            requirementsEN: ["Signature: def is_palindrome(s)"],
            starterCode: ##"""
def is_palindrome(s):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "is_palindrome(\"radar\")", expectedOutput: "True", validationCode: "is_palindrome(\"radar\") == True"),
                    TaskTestCase(title: "Тест 2", inputDescription: "is_palindrome(\"code\")", expectedOutput: "False", validationCode: "is_palindrome(\"code\") == False"),
                    TaskTestCase(title: "Тест 3", inputDescription: "is_palindrome(\"level\")", expectedOutput: "True", validationCode: "is_palindrome(\"level\") == True")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def is_palindrome(s):
    return s == s.reversed()
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "py_task_first_and_last",
            language: .python,
            titleRU: "Первый и последний элемент",
            titleEN: "First and Last Element",
            difficulty: .easy,
            category: .stringsAndCollections,
            summaryRU: "Сумма lst.first + lst.last.",
            summaryEN: "Sum of first and last elements.",
            descriptionRU: ##"""
### Условие
Напишите функцию `first_and_last(lst)`.
Сумма lst.first + lst.last.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `first_and_last(lst)`.
Sum of first and last elements.
"""##,
            requirementsRU: ["Сигнатура: def first_and_last(lst)"],
            requirementsEN: ["Signature: def first_and_last(lst)"],
            starterCode: ##"""
def first_and_last(lst):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "first_and_last([10, 20, 30])", expectedOutput: "40", validationCode: "first_and_last([10, 20, 30]) == 40"),
                    TaskTestCase(title: "Тест 2", inputDescription: "first_and_last([5, 5])", expectedOutput: "10", validationCode: "first_and_last([5, 5]) == 10"),
                    TaskTestCase(title: "Тест 3", inputDescription: "first_and_last([1, 2, 3, 4, 9])", expectedOutput: "10", validationCode: "first_and_last([1, 2, 3, 4, 9]) == 10")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def first_and_last(lst):
    return lst.first + lst.last
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "py_task_sum_list",
            language: .python,
            titleRU: "Сумма элементов списка",
            titleEN: "Sum of List Elements",
            difficulty: .easy,
            category: .stringsAndCollections,
            summaryRU: "Сложение всех чисел в списке.",
            summaryEN: "Sum all numbers in list.",
            descriptionRU: ##"""
### Условие
Напишите функцию `sum_list(lst)`.
Сложение всех чисел в списке.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `sum_list(lst)`.
Sum all numbers in list.
"""##,
            requirementsRU: ["Сигнатура: def sum_list(lst)"],
            requirementsEN: ["Signature: def sum_list(lst)"],
            starterCode: ##"""
def sum_list(lst):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "sum_list([1, 2, 3, 4])", expectedOutput: "10", validationCode: "sum_list([1, 2, 3, 4]) == 10"),
                    TaskTestCase(title: "Тест 2", inputDescription: "sum_list([10, -5, 5])", expectedOutput: "10", validationCode: "sum_list([10, -5, 5]) == 10"),
                    TaskTestCase(title: "Тест 3", inputDescription: "sum_list([])", expectedOutput: "0", validationCode: "sum_list([]) == 0")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def sum_list(lst):
    total = 0
    for x in lst:
        total = total + x
    return total
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "py_task_find_max",
            language: .python,
            titleRU: "Максимальный элемент списка",
            titleEN: "Maximum in List",
            difficulty: .medium,
            category: .stringsAndCollections,
            summaryRU: "Поиск наибольшего значения.",
            summaryEN: "Find max value.",
            descriptionRU: ##"""
### Условие
Напишите функцию `find_max(lst)`.
Поиск наибольшего значения.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `find_max(lst)`.
Find max value.
"""##,
            requirementsRU: ["Сигнатура: def find_max(lst)"],
            requirementsEN: ["Signature: def find_max(lst)"],
            starterCode: ##"""
def find_max(lst):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "find_max([3, 7, 2, 9, 5])", expectedOutput: "9", validationCode: "find_max([3, 7, 2, 9, 5]) == 9"),
                    TaskTestCase(title: "Тест 2", inputDescription: "find_max([-10, -3, -50])", expectedOutput: "-3", validationCode: "find_max([-10, -3, -50]) == -3"),
                    TaskTestCase(title: "Тест 3", inputDescription: "find_max([42])", expectedOutput: "42", validationCode: "find_max([42]) == 42")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def find_max(lst):
    best = lst.first
    for x in lst:
        if x > best:
            best = x
    return best
"""##,
            xpReward: 35
        ),
        CodingTask(
            id: "py_task_find_min",
            language: .python,
            titleRU: "Минимальный элемент списка",
            titleEN: "Minimum in List",
            difficulty: .medium,
            category: .stringsAndCollections,
            summaryRU: "Поиск наименьшего значения.",
            summaryEN: "Find min value.",
            descriptionRU: ##"""
### Условие
Напишите функцию `find_min(lst)`.
Поиск наименьшего значения.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `find_min(lst)`.
Find min value.
"""##,
            requirementsRU: ["Сигнатура: def find_min(lst)"],
            requirementsEN: ["Signature: def find_min(lst)"],
            starterCode: ##"""
def find_min(lst):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "find_min([3, 7, 2, 9, 5])", expectedOutput: "2", validationCode: "find_min([3, 7, 2, 9, 5]) == 2"),
                    TaskTestCase(title: "Тест 2", inputDescription: "find_min([-10, -3, -50])", expectedOutput: "-50", validationCode: "find_min([-10, -3, -50]) == -50"),
                    TaskTestCase(title: "Тест 3", inputDescription: "find_min([99])", expectedOutput: "99", validationCode: "find_min([99]) == 99")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def find_min(lst):
    best = lst.first
    for x in lst:
        if x < best:
            best = x
    return best
"""##,
            xpReward: 35
        ),
        CodingTask(
            id: "py_task_filter_evens",
            language: .python,
            titleRU: "Фильтрация чётных чисел",
            titleEN: "Filter Even Numbers",
            difficulty: .medium,
            category: .stringsAndCollections,
            summaryRU: "Оставить только чётные числа.",
            summaryEN: "Keep only even numbers.",
            descriptionRU: ##"""
### Условие
Напишите функцию `filter_evens(lst)`.
Оставить только чётные числа.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `filter_evens(lst)`.
Keep only even numbers.
"""##,
            requirementsRU: ["Сигнатура: def filter_evens(lst)"],
            requirementsEN: ["Signature: def filter_evens(lst)"],
            starterCode: ##"""
def filter_evens(lst):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "filter_evens([1, 2, 3, 4, 5, 6])", expectedOutput: "[2, 4, 6]", validationCode: "filter_evens([1, 2, 3, 4, 5, 6]) == [2, 4, 6]"),
                    TaskTestCase(title: "Тест 2", inputDescription: "filter_evens([1, 3, 5])", expectedOutput: "[]", validationCode: "filter_evens([1, 3, 5]) == []"),
                    TaskTestCase(title: "Тест 3", inputDescription: "filter_evens([8, 10])", expectedOutput: "[8, 10]", validationCode: "filter_evens([8, 10]) == [8, 10]")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def filter_evens(lst):
    return lst.filter { $0 % 2 == 0 }
"""##,
            xpReward: 35
        ),
        CodingTask(
            id: "py_task_filter_odds",
            language: .python,
            titleRU: "Фильтрация нечётных чисел",
            titleEN: "Filter Odd Numbers",
            difficulty: .medium,
            category: .stringsAndCollections,
            summaryRU: "Оставить только нечётные числа.",
            summaryEN: "Keep only odd numbers.",
            descriptionRU: ##"""
### Условие
Напишите функцию `filter_odds(lst)`.
Оставить только нечётные числа.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `filter_odds(lst)`.
Keep only odd numbers.
"""##,
            requirementsRU: ["Сигнатура: def filter_odds(lst)"],
            requirementsEN: ["Signature: def filter_odds(lst)"],
            starterCode: ##"""
def filter_odds(lst):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "filter_odds([1, 2, 3, 4, 5])", expectedOutput: "[1, 3, 5]", validationCode: "filter_odds([1, 2, 3, 4, 5]) == [1, 3, 5]"),
                    TaskTestCase(title: "Тест 2", inputDescription: "filter_odds([2, 4, 6])", expectedOutput: "[]", validationCode: "filter_odds([2, 4, 6]) == []"),
                    TaskTestCase(title: "Тест 3", inputDescription: "filter_odds([7, 9])", expectedOutput: "[7, 9]", validationCode: "filter_odds([7, 9]) == [7, 9]")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def filter_odds(lst):
    return lst.filter { $0 % 2 != 0 }
"""##,
            xpReward: 35
        ),
        CodingTask(
            id: "py_task_str_length",
            language: .python,
            titleRU: "Длина строки",
            titleEN: "String Length",
            difficulty: .easy,
            category: .stringsAndCollections,
            summaryRU: "Количество символов в строке.",
            summaryEN: "Count characters in string.",
            descriptionRU: ##"""
### Условие
Напишите функцию `str_length(s)`.
Количество символов в строке.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `str_length(s)`.
Count characters in string.
"""##,
            requirementsRU: ["Сигнатура: def str_length(s)"],
            requirementsEN: ["Signature: def str_length(s)"],
            starterCode: ##"""
def str_length(s):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "str_length(\"Python\")", expectedOutput: "6", validationCode: "str_length(\"Python\") == 6"),
                    TaskTestCase(title: "Тест 2", inputDescription: "str_length(\"\")", expectedOutput: "0", validationCode: "str_length(\"\") == 0"),
                    TaskTestCase(title: "Тест 3", inputDescription: "str_length(\"Hello\")", expectedOutput: "5", validationCode: "str_length(\"Hello\") == 5")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def str_length(s):
    return len(s)
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "py_task_repeat_string",
            language: .python,
            titleRU: "Повторение строки N раз",
            titleEN: "Repeat String N Times",
            difficulty: .easy,
            category: .stringsAndCollections,
            summaryRU: "Конкатенация строки саму с собой N раз.",
            summaryEN: "Repeat string N times.",
            descriptionRU: ##"""
### Условие
Напишите функцию `repeat_string(s, n)`.
Конкатенация строки саму с собой N раз.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `repeat_string(s, n)`.
Repeat string N times.
"""##,
            requirementsRU: ["Сигнатура: def repeat_string(s, n)"],
            requirementsEN: ["Signature: def repeat_string(s, n)"],
            starterCode: ##"""
def repeat_string(s, n):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "repeat_string(\"hi\", 3)", expectedOutput: "\"hihihi\"", validationCode: "repeat_string(\"hi\", 3) == \"hihihi\""),
                    TaskTestCase(title: "Тест 2", inputDescription: "repeat_string(\"A\", 1)", expectedOutput: "\"A\"", validationCode: "repeat_string(\"A\", 1) == \"A\""),
                    TaskTestCase(title: "Тест 3", inputDescription: "repeat_string(\"x\", 0)", expectedOutput: "\"\"", validationCode: "repeat_string(\"x\", 0) == \"\"")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def repeat_string(s, n):
    res = ""
    for i in 1...n:
        res = res + s
    return res
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "py_task_contains_element",
            language: .python,
            titleRU: "Проверка наличия элемента",
            titleEN: "Contains Element",
            difficulty: .easy,
            category: .stringsAndCollections,
            summaryRU: "Линейный поиск совпадения.",
            summaryEN: "Check if target in list.",
            descriptionRU: ##"""
### Условие
Напишите функцию `contains(lst, target)`.
Линейный поиск совпадения.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `contains(lst, target)`.
Check if target in list.
"""##,
            requirementsRU: ["Сигнатура: def contains(lst, target)"],
            requirementsEN: ["Signature: def contains(lst, target)"],
            starterCode: ##"""
def contains(lst, target):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "contains([1, 2, 3, 4], 3)", expectedOutput: "True", validationCode: "contains([1, 2, 3, 4], 3) == True"),
                    TaskTestCase(title: "Тест 2", inputDescription: "contains([1, 2, 3, 4], 9)", expectedOutput: "False", validationCode: "contains([1, 2, 3, 4], 9) == False"),
                    TaskTestCase(title: "Тест 3", inputDescription: "contains([], 1)", expectedOutput: "False", validationCode: "contains([], 1) == False")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def contains(lst, target):
    for x in lst:
        if x == target:
            return True
    return False
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "py_task_find_index",
            language: .python,
            titleRU: "Поиск индекса элемента",
            titleEN: "Find Element Index",
            difficulty: .medium,
            category: .stringsAndCollections,
            summaryRU: "Индекс первого совпадения или -1.",
            summaryEN: "First matching index or -1.",
            descriptionRU: ##"""
### Условие
Напишите функцию `find_index(lst, target)`.
Индекс первого совпадения или -1.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `find_index(lst, target)`.
First matching index or -1.
"""##,
            requirementsRU: ["Сигнатура: def find_index(lst, target)"],
            requirementsEN: ["Signature: def find_index(lst, target)"],
            starterCode: ##"""
def find_index(lst, target):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "find_index([10, 20, 30, 40], 30)", expectedOutput: "2", validationCode: "find_index([10, 20, 30, 40], 30) == 2"),
                    TaskTestCase(title: "Тест 2", inputDescription: "find_index([10, 20, 30], 99)", expectedOutput: "-1", validationCode: "find_index([10, 20, 30], 99) == -1"),
                    TaskTestCase(title: "Тест 3", inputDescription: "find_index([5], 5)", expectedOutput: "0", validationCode: "find_index([5], 5) == 0")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def find_index(lst, target):
    idx = 0
    for x in lst:
        if x == target:
            return idx
        idx = idx + 1
    return -1
"""##,
            xpReward: 35
        ),
        CodingTask(
            id: "py_task_count_matches",
            language: .python,
            titleRU: "Подсчет вхождений элемента",
            titleEN: "Count Occurrences",
            difficulty: .easy,
            category: .stringsAndCollections,
            summaryRU: "Количество появлений target в списке.",
            summaryEN: "Count of target in list.",
            descriptionRU: ##"""
### Условие
Напишите функцию `count_matches(lst, target)`.
Количество появлений target в списке.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `count_matches(lst, target)`.
Count of target in list.
"""##,
            requirementsRU: ["Сигнатура: def count_matches(lst, target)"],
            requirementsEN: ["Signature: def count_matches(lst, target)"],
            starterCode: ##"""
def count_matches(lst, target):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "count_matches([1, 2, 2, 3, 2], 2)", expectedOutput: "3", validationCode: "count_matches([1, 2, 2, 3, 2], 2) == 3"),
                    TaskTestCase(title: "Тест 2", inputDescription: "count_matches([1, 2, 3], 9)", expectedOutput: "0", validationCode: "count_matches([1, 2, 3], 9) == 0"),
                    TaskTestCase(title: "Тест 3", inputDescription: "count_matches([7, 7, 7, 7], 7)", expectedOutput: "4", validationCode: "count_matches([7, 7, 7, 7], 7) == 4")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def count_matches(lst, target):
    count = 0
    for x in lst:
        if x == target:
            count = count + 1
    return count
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "py_task_is_sorted",
            language: .python,
            titleRU: "Проверка отсортированности",
            titleEN: "Check if Sorted",
            difficulty: .medium,
            category: .stringsAndCollections,
            summaryRU: "Список упорядочен по возрастанию.",
            summaryEN: "List is sorted ascending.",
            descriptionRU: ##"""
### Условие
Напишите функцию `is_sorted(lst)`.
Список упорядочен по возрастанию.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `is_sorted(lst)`.
List is sorted ascending.
"""##,
            requirementsRU: ["Сигнатура: def is_sorted(lst)"],
            requirementsEN: ["Signature: def is_sorted(lst)"],
            starterCode: ##"""
def is_sorted(lst):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "is_sorted([1, 2, 3, 4])", expectedOutput: "True", validationCode: "is_sorted([1, 2, 3, 4]) == True"),
                    TaskTestCase(title: "Тест 2", inputDescription: "is_sorted([1, 3, 2])", expectedOutput: "False", validationCode: "is_sorted([1, 3, 2]) == False"),
                    TaskTestCase(title: "Тест 3", inputDescription: "is_sorted([5])", expectedOutput: "True", validationCode: "is_sorted([5]) == True")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def is_sorted(lst):
    return lst == lst.sorted()
"""##,
            xpReward: 35
        ),
        CodingTask(
            id: "py_task_square_elements",
            language: .python,
            titleRU: "Квадраты элементов списка",
            titleEN: "Squares of List Elements",
            difficulty: .medium,
            category: .stringsAndCollections,
            summaryRU: "Отображение x -> x * x.",
            summaryEN: "Map x -> x * x.",
            descriptionRU: ##"""
### Условие
Напишите функцию `square_elements(lst)`.
Отображение x -> x * x.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `square_elements(lst)`.
Map x -> x * x.
"""##,
            requirementsRU: ["Сигнатура: def square_elements(lst)"],
            requirementsEN: ["Signature: def square_elements(lst)"],
            starterCode: ##"""
def square_elements(lst):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "square_elements([1, 2, 3])", expectedOutput: "[1, 4, 9]", validationCode: "square_elements([1, 2, 3]) == [1, 4, 9]"),
                    TaskTestCase(title: "Тест 2", inputDescription: "square_elements([4, 5])", expectedOutput: "[16, 25]", validationCode: "square_elements([4, 5]) == [16, 25]"),
                    TaskTestCase(title: "Тест 3", inputDescription: "square_elements([])", expectedOutput: "[]", validationCode: "square_elements([]) == []")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def square_elements(lst):
    return lst.map { $0 * $0 }
"""##,
            xpReward: 35
        ),
        CodingTask(
            id: "py_task_join_words",
            language: .python,
            titleRU: "Конкатенация двух строк",
            titleEN: "Concatenate Strings",
            difficulty: .easy,
            category: .stringsAndCollections,
            summaryRU: "Склеивание w1 + ' ' + w2.",
            summaryEN: "Join w1 + ' ' + w2.",
            descriptionRU: ##"""
### Условие
Напишите функцию `join_words(w1, w2)`.
Склеивание w1 + ' ' + w2.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `join_words(w1, w2)`.
Join w1 + ' ' + w2.
"""##,
            requirementsRU: ["Сигнатура: def join_words(w1, w2)"],
            requirementsEN: ["Signature: def join_words(w1, w2)"],
            starterCode: ##"""
def join_words(w1, w2):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "join_words(\"Hello\", \"World\")", expectedOutput: "\"Hello World\"", validationCode: "join_words(\"Hello\", \"World\") == \"Hello World\""),
                    TaskTestCase(title: "Тест 2", inputDescription: "join_words(\"Code\", \"Base\")", expectedOutput: "\"Code Base\"", validationCode: "join_words(\"Code\", \"Base\") == \"Code Base\""),
                    TaskTestCase(title: "Тест 3", inputDescription: "join_words(\"A\", \"B\")", expectedOutput: "\"A B\"", validationCode: "join_words(\"A\", \"B\") == \"A B\"")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def join_words(w1, w2):
    return w1 + " " + w2
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "py_task_reverse_list",
            language: .python,
            titleRU: "Разворот списка",
            titleEN: "Reverse a List",
            difficulty: .easy,
            category: .stringsAndCollections,
            summaryRU: "Элементы в обратном порядке.",
            summaryEN: "Elements in reverse order.",
            descriptionRU: ##"""
### Условие
Напишите функцию `reverse_list(lst)`.
Элементы в обратном порядке.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `reverse_list(lst)`.
Elements in reverse order.
"""##,
            requirementsRU: ["Сигнатура: def reverse_list(lst)"],
            requirementsEN: ["Signature: def reverse_list(lst)"],
            starterCode: ##"""
def reverse_list(lst):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "reverse_list([1, 2, 3])", expectedOutput: "[3, 2, 1]", validationCode: "reverse_list([1, 2, 3]) == [3, 2, 1]"),
                    TaskTestCase(title: "Тест 2", inputDescription: "reverse_list([10, 20])", expectedOutput: "[20, 10]", validationCode: "reverse_list([10, 20]) == [20, 10]"),
                    TaskTestCase(title: "Тест 3", inputDescription: "reverse_list([])", expectedOutput: "[]", validationCode: "reverse_list([]) == []")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def reverse_list(lst):
    return lst.reversed()
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "py_task_double_all",
            language: .python,
            titleRU: "Удвоение элементов списка",
            titleEN: "Double All Elements",
            difficulty: .easy,
            category: .stringsAndCollections,
            summaryRU: "Отображение x -> x * 2.",
            summaryEN: "Map x -> x * 2.",
            descriptionRU: ##"""
### Условие
Напишите функцию `double_all(lst)`.
Отображение x -> x * 2.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `double_all(lst)`.
Map x -> x * 2.
"""##,
            requirementsRU: ["Сигнатура: def double_all(lst)"],
            requirementsEN: ["Signature: def double_all(lst)"],
            starterCode: ##"""
def double_all(lst):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "double_all([1, 2, 3])", expectedOutput: "[2, 4, 6]", validationCode: "double_all([1, 2, 3]) == [2, 4, 6]"),
                    TaskTestCase(title: "Тест 2", inputDescription: "double_all([10, -5])", expectedOutput: "[20, -10]", validationCode: "double_all([10, -5]) == [20, -10]"),
                    TaskTestCase(title: "Тест 3", inputDescription: "double_all([])", expectedOutput: "[]", validationCode: "double_all([]) == []")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def double_all(lst):
    return lst.map { $0 * 2 }
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "py_task_all_positive",
            language: .python,
            titleRU: "Все ли числа положительные",
            titleEN: "Are All Numbers Positive",
            difficulty: .easy,
            category: .stringsAndCollections,
            summaryRU: "Проверка x > 0 для всех элементов.",
            summaryEN: "Check x > 0 for all items.",
            descriptionRU: ##"""
### Условие
Напишите функцию `all_positive(lst)`.
Проверка x > 0 для всех элементов.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `all_positive(lst)`.
Check x > 0 for all items.
"""##,
            requirementsRU: ["Сигнатура: def all_positive(lst)"],
            requirementsEN: ["Signature: def all_positive(lst)"],
            starterCode: ##"""
def all_positive(lst):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "all_positive([1, 5, 10])", expectedOutput: "True", validationCode: "all_positive([1, 5, 10]) == True"),
                    TaskTestCase(title: "Тест 2", inputDescription: "all_positive([1, -2, 3])", expectedOutput: "False", validationCode: "all_positive([1, -2, 3]) == False"),
                    TaskTestCase(title: "Тест 3", inputDescription: "all_positive([])", expectedOutput: "True", validationCode: "all_positive([]) == True")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def all_positive(lst):
    for x in lst:
        if x <= 0:
            return False
    return True
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "py_task_any_negative",
            language: .python,
            titleRU: "Есть ли отрицательные числа",
            titleEN: "Has Any Negative Number",
            difficulty: .easy,
            category: .stringsAndCollections,
            summaryRU: "Проверка x < 0 хотя бы для одного элемента.",
            summaryEN: "Check x < 0 for any item.",
            descriptionRU: ##"""
### Условие
Напишите функцию `any_negative(lst)`.
Проверка x < 0 хотя бы для одного элемента.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `any_negative(lst)`.
Check x < 0 for any item.
"""##,
            requirementsRU: ["Сигнатура: def any_negative(lst)"],
            requirementsEN: ["Signature: def any_negative(lst)"],
            starterCode: ##"""
def any_negative(lst):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "any_negative([1, -2, 3])", expectedOutput: "True", validationCode: "any_negative([1, -2, 3]) == True"),
                    TaskTestCase(title: "Тест 2", inputDescription: "any_negative([1, 2, 3])", expectedOutput: "False", validationCode: "any_negative([1, 2, 3]) == False"),
                    TaskTestCase(title: "Тест 3", inputDescription: "any_negative([])", expectedOutput: "False", validationCode: "any_negative([]) == False")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def any_negative(lst):
    for x in lst:
        if x < 0:
            return True
    return False
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "py_task_linear_search",
            language: .python,
            titleRU: "Линейный поиск",
            titleEN: "Linear Search",
            difficulty: .easy,
            category: .algorithms,
            summaryRU: "Последовательный поиск элемента в массиве.",
            summaryEN: "Sequential array search.",
            descriptionRU: ##"""
### Условие
Напишите функцию `linear_search(arr, target)`.
Последовательный поиск элемента в массиве.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `linear_search(arr, target)`.
Sequential array search.
"""##,
            requirementsRU: ["Сигнатура: def linear_search(arr, target)"],
            requirementsEN: ["Signature: def linear_search(arr, target)"],
            starterCode: ##"""
def linear_search(arr, target):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "linear_search([4, 2, 7, 1], 7)", expectedOutput: "2", validationCode: "linear_search([4, 2, 7, 1], 7) == 2"),
                    TaskTestCase(title: "Тест 2", inputDescription: "linear_search([4, 2, 7, 1], 9)", expectedOutput: "-1", validationCode: "linear_search([4, 2, 7, 1], 9) == -1"),
                    TaskTestCase(title: "Тест 3", inputDescription: "linear_search([5], 5)", expectedOutput: "0", validationCode: "linear_search([5], 5) == 0")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def linear_search(arr, target):
    idx = 0
    for x in arr:
        if x == target:
            return idx
        idx = idx + 1
    return -1
"""##,
            xpReward: 35
        ),
        CodingTask(
            id: "py_task_two_sum",
            language: .python,
            titleRU: "Сумма двух слагаемых (Two Sum)",
            titleEN: "Two Sum Problem",
            difficulty: .medium,
            category: .algorithms,
            summaryRU: "Поиск пары элементов с суммой target.",
            summaryEN: "Check if pair sums to target.",
            descriptionRU: ##"""
### Условие
Напишите функцию `has_two_sum(nums, target)`.
Поиск пары элементов с суммой target.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `has_two_sum(nums, target)`.
Check if pair sums to target.
"""##,
            requirementsRU: ["Сигнатура: def has_two_sum(nums, target)"],
            requirementsEN: ["Signature: def has_two_sum(nums, target)"],
            starterCode: ##"""
def has_two_sum(nums, target):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "has_two_sum([2, 7, 11, 15], 9)", expectedOutput: "True", validationCode: "has_two_sum([2, 7, 11, 15], 9) == True"),
                    TaskTestCase(title: "Тест 2", inputDescription: "has_two_sum([3, 2, 4], 6)", expectedOutput: "True", validationCode: "has_two_sum([3, 2, 4], 6) == True"),
                    TaskTestCase(title: "Тест 3", inputDescription: "has_two_sum([1, 2, 3], 99)", expectedOutput: "False", validationCode: "has_two_sum([1, 2, 3], 99) == False")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def has_two_sum(nums, target):
    n = len(nums)
    for i in 0...n:
        for j in 0...n:
            if i != j and nums[i] + nums[j] == target:
                return True
    return False
"""##,
            xpReward: 45
        ),
        CodingTask(
            id: "py_task_second_largest",
            language: .python,
            titleRU: "Второй по величине элемент",
            titleEN: "Second Largest Element",
            difficulty: .medium,
            category: .algorithms,
            summaryRU: "Предпоследний элемент в отсортированном виде.",
            summaryEN: "Second from end in sorted list.",
            descriptionRU: ##"""
### Условие
Напишите функцию `second_largest(arr)`.
Предпоследний элемент в отсортированном виде.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `second_largest(arr)`.
Second from end in sorted list.
"""##,
            requirementsRU: ["Сигнатура: def second_largest(arr)"],
            requirementsEN: ["Signature: def second_largest(arr)"],
            starterCode: ##"""
def second_largest(arr):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "second_largest([10, 40, 20, 30])", expectedOutput: "30", validationCode: "second_largest([10, 40, 20, 30]) == 30"),
                    TaskTestCase(title: "Тест 2", inputDescription: "second_largest([5, 1, 9])", expectedOutput: "5", validationCode: "second_largest([5, 1, 9]) == 5"),
                    TaskTestCase(title: "Тест 3", inputDescription: "second_largest([100, 200])", expectedOutput: "100", validationCode: "second_largest([100, 200]) == 100")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def second_largest(arr):
    s = arr.sorted()
    idx = len(s) - 2
    return s[idx]
"""##,
            xpReward: 40
        ),
        CodingTask(
            id: "py_task_missing_number",
            language: .python,
            titleRU: "Поиск пропущенного числа",
            titleEN: "Find Missing Number",
            difficulty: .medium,
            category: .algorithms,
            summaryRU: "Ожидаемая сумма N*(N+1)/2 минус фактическая.",
            summaryEN: "Expected sum minus actual sum.",
            descriptionRU: ##"""
### Условие
Напишите функцию `missing_number(arr)`.
Ожидаемая сумма N*(N+1)/2 минус фактическая.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `missing_number(arr)`.
Expected sum minus actual sum.
"""##,
            requirementsRU: ["Сигнатура: def missing_number(arr)"],
            requirementsEN: ["Signature: def missing_number(arr)"],
            starterCode: ##"""
def missing_number(arr):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "missing_number([3, 0, 1])", expectedOutput: "2", validationCode: "missing_number([3, 0, 1]) == 2"),
                    TaskTestCase(title: "Тест 2", inputDescription: "missing_number([0, 1])", expectedOutput: "2", validationCode: "missing_number([0, 1]) == 2"),
                    TaskTestCase(title: "Тест 3", inputDescription: "missing_number([9, 6, 4, 2, 3, 5, 7, 0, 1])", expectedOutput: "8", validationCode: "missing_number([9, 6, 4, 2, 3, 5, 7, 0, 1]) == 8")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def missing_number(arr):
    n = len(arr)
    expected = n * (n + 1) / 2
    actual = 0
    for x in arr:
        actual = actual + x
    return expected - actual
"""##,
            xpReward: 45
        ),
        CodingTask(
            id: "py_task_count_non_zeroes",
            language: .python,
            titleRU: "Количество ненулевых элементов",
            titleEN: "Count Non-Zero Elements",
            difficulty: .easy,
            category: .algorithms,
            summaryRU: "Подсчет элементов, не равных 0.",
            summaryEN: "Count elements != 0.",
            descriptionRU: ##"""
### Условие
Напишите функцию `count_non_zeroes(arr)`.
Подсчет элементов, не равных 0.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `count_non_zeroes(arr)`.
Count elements != 0.
"""##,
            requirementsRU: ["Сигнатура: def count_non_zeroes(arr)"],
            requirementsEN: ["Signature: def count_non_zeroes(arr)"],
            starterCode: ##"""
def count_non_zeroes(arr):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "count_non_zeroes([0, 1, 0, 3, 12])", expectedOutput: "3", validationCode: "count_non_zeroes([0, 1, 0, 3, 12]) == 3"),
                    TaskTestCase(title: "Тест 2", inputDescription: "count_non_zeroes([0, 0, 0])", expectedOutput: "0", validationCode: "count_non_zeroes([0, 0, 0]) == 0"),
                    TaskTestCase(title: "Тест 3", inputDescription: "count_non_zeroes([1, 2, 3])", expectedOutput: "3", validationCode: "count_non_zeroes([1, 2, 3]) == 3")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def count_non_zeroes(arr):
    c = 0
    for x in arr:
        if x != 0:
            c = c + 1
    return c
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "py_task_max_sub_array",
            language: .python,
            titleRU: "Алгоритм Кадане (Max Subarray)",
            titleEN: "Kadane's Algorithm",
            difficulty: .hard,
            category: .algorithms,
            summaryRU: "Максимальная сумма непрерывного подмассива.",
            summaryEN: "Maximum sum contiguous subarray.",
            descriptionRU: ##"""
### Условие
Напишите функцию `max_sub_array(nums)`.
Максимальная сумма непрерывного подмассива.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `max_sub_array(nums)`.
Maximum sum contiguous subarray.
"""##,
            requirementsRU: ["Сигнатура: def max_sub_array(nums)"],
            requirementsEN: ["Signature: def max_sub_array(nums)"],
            starterCode: ##"""
def max_sub_array(nums):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "max_sub_array([-2, 1, -3, 4, -1, 2, 1, -5, 4])", expectedOutput: "6", validationCode: "max_sub_array([-2, 1, -3, 4, -1, 2, 1, -5, 4]) == 6"),
                    TaskTestCase(title: "Тест 2", inputDescription: "max_sub_array([1])", expectedOutput: "1", validationCode: "max_sub_array([1]) == 1"),
                    TaskTestCase(title: "Тест 3", inputDescription: "max_sub_array([5, 4, -1, 7, 8])", expectedOutput: "23", validationCode: "max_sub_array([5, 4, -1, 7, 8]) == 23")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def max_sub_array(nums):
    best = nums.first
    curr = nums.first
    for x in nums:
        curr = max(x, curr + x)
        best = max(best, curr)
    return best
"""##,
            xpReward: 60
        ),
        CodingTask(
            id: "py_task_binary_search",
            language: .python,
            titleRU: "Бинарный поиск",
            titleEN: "Binary Search",
            difficulty: .medium,
            category: .algorithms,
            summaryRU: "Поиск индекса в отсортированном массиве за O(log N).",
            summaryEN: "Search in sorted array.",
            descriptionRU: ##"""
### Условие
Напишите функцию `binary_search(arr, target)`.
Поиск индекса в отсортированном массиве за O(log N).
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `binary_search(arr, target)`.
Search in sorted array.
"""##,
            requirementsRU: ["Сигнатура: def binary_search(arr, target)"],
            requirementsEN: ["Signature: def binary_search(arr, target)"],
            starterCode: ##"""
def binary_search(arr, target):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "binary_search([1, 3, 5, 7, 9], 5)", expectedOutput: "2", validationCode: "binary_search([1, 3, 5, 7, 9], 5) == 2"),
                    TaskTestCase(title: "Тест 2", inputDescription: "binary_search([1, 3, 5, 7, 9], 1)", expectedOutput: "0", validationCode: "binary_search([1, 3, 5, 7, 9], 1) == 0"),
                    TaskTestCase(title: "Тест 3", inputDescription: "binary_search([1, 3, 5, 7, 9], 8)", expectedOutput: "-1", validationCode: "binary_search([1, 3, 5, 7, 9], 8) == -1")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def binary_search(arr, target):
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
"""##,
            xpReward: 50
        ),
        CodingTask(
            id: "py_task_sort_array",
            language: .python,
            titleRU: "Сортировка массива",
            titleEN: "Sort Array",
            difficulty: .easy,
            category: .algorithms,
            summaryRU: "Возврат отсортированной копии.",
            summaryEN: "Return sorted array copy.",
            descriptionRU: ##"""
### Условие
Напишите функцию `sort_array(arr)`.
Возврат отсортированной копии.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `sort_array(arr)`.
Return sorted array copy.
"""##,
            requirementsRU: ["Сигнатура: def sort_array(arr)"],
            requirementsEN: ["Signature: def sort_array(arr)"],
            starterCode: ##"""
def sort_array(arr):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "sort_array([5, 2, 8, 1, 9])", expectedOutput: "[1, 2, 5, 8, 9]", validationCode: "sort_array([5, 2, 8, 1, 9]) == [1, 2, 5, 8, 9]"),
                    TaskTestCase(title: "Тест 2", inputDescription: "sort_array([3, 1])", expectedOutput: "[1, 3]", validationCode: "sort_array([3, 1]) == [1, 3]"),
                    TaskTestCase(title: "Тест 3", inputDescription: "sort_array([10])", expectedOutput: "[10]", validationCode: "sort_array([10]) == [10]")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def sort_array(arr):
    return arr.sorted()
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "py_task_majority_element",
            language: .python,
            titleRU: "Мажоритарный элемент",
            titleEN: "Majority Element",
            difficulty: .hard,
            category: .algorithms,
            summaryRU: "Элемент, встречающийся > n/2 раз.",
            summaryEN: "Element appearing > n/2 times.",
            descriptionRU: ##"""
### Условие
Напишите функцию `majority_element(arr)`.
Элемент, встречающийся > n/2 раз.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `majority_element(arr)`.
Element appearing > n/2 times.
"""##,
            requirementsRU: ["Сигнатура: def majority_element(arr)"],
            requirementsEN: ["Signature: def majority_element(arr)"],
            starterCode: ##"""
def majority_element(arr):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "majority_element([3, 2, 3])", expectedOutput: "3", validationCode: "majority_element([3, 2, 3]) == 3"),
                    TaskTestCase(title: "Тест 2", inputDescription: "majority_element([2, 2, 1, 1, 1, 2, 2])", expectedOutput: "2", validationCode: "majority_element([2, 2, 1, 1, 1, 2, 2]) == 2"),
                    TaskTestCase(title: "Тест 3", inputDescription: "majority_element([5])", expectedOutput: "5", validationCode: "majority_element([5]) == 5")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def majority_element(arr):
    s = arr.sorted()
    mid = len(s) / 2
    return s[mid]
"""##,
            xpReward: 55
        ),
        CodingTask(
            id: "py_task_gcd",
            language: .python,
            titleRU: "Наибольший общий делитель (НОД)",
            titleEN: "Greatest Common Divisor (GCD)",
            difficulty: .medium,
            category: .algorithms,
            summaryRU: "Алгоритм Евклида.",
            summaryEN: "Euclidean algorithm.",
            descriptionRU: ##"""
### Условие
Напишите функцию `gcd(a, b)`.
Алгоритм Евклида.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `gcd(a, b)`.
Euclidean algorithm.
"""##,
            requirementsRU: ["Сигнатура: def gcd(a, b)"],
            requirementsEN: ["Signature: def gcd(a, b)"],
            starterCode: ##"""
def gcd(a, b):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "gcd(48, 18)", expectedOutput: "6", validationCode: "gcd(48, 18) == 6"),
                    TaskTestCase(title: "Тест 2", inputDescription: "gcd(20, 10)", expectedOutput: "10", validationCode: "gcd(20, 10) == 10"),
                    TaskTestCase(title: "Тест 3", inputDescription: "gcd(7, 3)", expectedOutput: "1", validationCode: "gcd(7, 3) == 1")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def gcd(a, b):
    x = a
    y = b
    for i in 0...100:
        if y != 0:
            rem = x % y
            x = y
            y = rem
    return x
"""##,
            xpReward: 45
        ),
        CodingTask(
            id: "py_task_lcm",
            language: .python,
            titleRU: "Наименьшее общее кратное (НОК)",
            titleEN: "Least Common Multiple (LCM)",
            difficulty: .medium,
            category: .algorithms,
            summaryRU: "(a * b) / gcd(a, b).",
            summaryEN: "(a * b) / gcd(a, b).",
            descriptionRU: ##"""
### Условие
Напишите функцию `lcm(a, b)`.
(a * b) / gcd(a, b).
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `lcm(a, b)`.
(a * b) / gcd(a, b).
"""##,
            requirementsRU: ["Сигнатура: def lcm(a, b)"],
            requirementsEN: ["Signature: def lcm(a, b)"],
            starterCode: ##"""
def lcm(a, b):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "lcm(4, 6)", expectedOutput: "12", validationCode: "lcm(4, 6) == 12"),
                    TaskTestCase(title: "Тест 2", inputDescription: "lcm(5, 7)", expectedOutput: "35", validationCode: "lcm(5, 7) == 35"),
                    TaskTestCase(title: "Тест 3", inputDescription: "lcm(10, 15)", expectedOutput: "30", validationCode: "lcm(10, 15) == 30")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def lcm(a, b):
    x = a
    y = b
    for i in 0...100:
        if y != 0:
            rem = x % y
            x = y
            y = rem
    return (a * b) / x
"""##,
            xpReward: 45
        ),
        CodingTask(
            id: "py_task_climb_stairs",
            language: .python,
            titleRU: "Подъем по лестнице",
            titleEN: "Climbing Stairs",
            difficulty: .medium,
            category: .algorithms,
            summaryRU: "Количество способов подняться на N ступеней.",
            summaryEN: "Ways to climb N stairs.",
            descriptionRU: ##"""
### Условие
Напишите функцию `climb_stairs(n)`.
Количество способов подняться на N ступеней.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `climb_stairs(n)`.
Ways to climb N stairs.
"""##,
            requirementsRU: ["Сигнатура: def climb_stairs(n)"],
            requirementsEN: ["Signature: def climb_stairs(n)"],
            starterCode: ##"""
def climb_stairs(n):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "climb_stairs(2)", expectedOutput: "2", validationCode: "climb_stairs(2) == 2"),
                    TaskTestCase(title: "Тест 2", inputDescription: "climb_stairs(3)", expectedOutput: "3", validationCode: "climb_stairs(3) == 3"),
                    TaskTestCase(title: "Тест 3", inputDescription: "climb_stairs(4)", expectedOutput: "5", validationCode: "climb_stairs(4) == 5")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def climb_stairs(n):
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
"""##,
            xpReward: 50
        ),
        CodingTask(
            id: "py_task_last_element",
            language: .python,
            titleRU: "Последний элемент массива",
            titleEN: "Last Element of Array",
            difficulty: .easy,
            category: .algorithms,
            summaryRU: "Значение arr.last.",
            summaryEN: "Value of arr.last.",
            descriptionRU: ##"""
### Условие
Напишите функцию `last_element(arr)`.
Значение arr.last.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `last_element(arr)`.
Value of arr.last.
"""##,
            requirementsRU: ["Сигнатура: def last_element(arr)"],
            requirementsEN: ["Signature: def last_element(arr)"],
            starterCode: ##"""
def last_element(arr):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "last_element([1, 2, 3, 4])", expectedOutput: "4", validationCode: "last_element([1, 2, 3, 4]) == 4"),
                    TaskTestCase(title: "Тест 2", inputDescription: "last_element([10, 20])", expectedOutput: "20", validationCode: "last_element([10, 20]) == 20"),
                    TaskTestCase(title: "Тест 3", inputDescription: "last_element([99])", expectedOutput: "99", validationCode: "last_element([99]) == 99")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def last_element(arr):
    return arr.last
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "py_task_tribonacci",
            language: .python,
            titleRU: "Числа Трибоначчи",
            titleEN: "Tribonacci Numbers",
            difficulty: .medium,
            category: .algorithms,
            summaryRU: "T(n) = T(n-1) + T(n-2) + T(n-3).",
            summaryEN: "Tribonacci sequence.",
            descriptionRU: ##"""
### Условие
Напишите функцию `tribonacci(n)`.
T(n) = T(n-1) + T(n-2) + T(n-3).
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `tribonacci(n)`.
Tribonacci sequence.
"""##,
            requirementsRU: ["Сигнатура: def tribonacci(n)"],
            requirementsEN: ["Signature: def tribonacci(n)"],
            starterCode: ##"""
def tribonacci(n):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "tribonacci(0)", expectedOutput: "0", validationCode: "tribonacci(0) == 0"),
                    TaskTestCase(title: "Тест 2", inputDescription: "tribonacci(3)", expectedOutput: "2", validationCode: "tribonacci(3) == 2"),
                    TaskTestCase(title: "Тест 3", inputDescription: "tribonacci(4)", expectedOutput: "4", validationCode: "tribonacci(4) == 4")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def tribonacci(n):
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
"""##,
            xpReward: 45
        ),
        CodingTask(
            id: "py_task_find_single",
            language: .python,
            titleRU: "Одиночное число",
            titleEN: "Single Number",
            difficulty: .hard,
            category: .algorithms,
            summaryRU: "Поиск элемента без пары.",
            summaryEN: "Find element with no pair.",
            descriptionRU: ##"""
### Условие
Напишите функцию `find_single(arr)`.
Поиск элемента без пары.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `find_single(arr)`.
Find element with no pair.
"""##,
            requirementsRU: ["Сигнатура: def find_single(arr)"],
            requirementsEN: ["Signature: def find_single(arr)"],
            starterCode: ##"""
def find_single(arr):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "find_single([2, 2, 1])", expectedOutput: "1", validationCode: "find_single([2, 2, 1]) == 1"),
                    TaskTestCase(title: "Тест 2", inputDescription: "find_single([4, 1, 2, 1, 2])", expectedOutput: "4", validationCode: "find_single([4, 1, 2, 1, 2]) == 4"),
                    TaskTestCase(title: "Тест 3", inputDescription: "find_single([1])", expectedOutput: "1", validationCode: "find_single([1]) == 1")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def find_single(arr):
    for x in arr:
        c = 0
        for y in arr:
            if x == y:
                c = c + 1
        if c == 1:
            return x
    return 0
"""##,
            xpReward: 60
        ),
        CodingTask(
            id: "py_task_count_above_threshold",
            language: .python,
            titleRU: "Количество элементов выше порога",
            titleEN: "Count Elements Above Threshold",
            difficulty: .medium,
            category: .algorithms,
            summaryRU: "Подсчет элементов x > threshold.",
            summaryEN: "Count items x > threshold.",
            descriptionRU: ##"""
### Условие
Напишите функцию `count_above(arr, threshold)`.
Подсчет элементов x > threshold.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `count_above(arr, threshold)`.
Count items x > threshold.
"""##,
            requirementsRU: ["Сигнатура: def count_above(arr, threshold)"],
            requirementsEN: ["Signature: def count_above(arr, threshold)"],
            starterCode: ##"""
def count_above(arr, threshold):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "count_above([1, 10, 5, 20], 8)", expectedOutput: "2", validationCode: "count_above([1, 10, 5, 20], 8) == 2"),
                    TaskTestCase(title: "Тест 2", inputDescription: "count_above([1, 2, 3], 10)", expectedOutput: "0", validationCode: "count_above([1, 2, 3], 10) == 0"),
                    TaskTestCase(title: "Тест 3", inputDescription: "count_above([5, 5, 5], 4)", expectedOutput: "3", validationCode: "count_above([5, 5, 5], 4) == 3")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def count_above(arr, threshold):
    c = 0
    for x in arr:
        if x > threshold:
            c = c + 1
    return c
"""##,
            xpReward: 35
        ),
        CodingTask(
            id: "py_task_array_diff_max_min",
            language: .python,
            titleRU: "Разность между максимумом и минимумом",
            titleEN: "Array Amplitude (Max - Min)",
            difficulty: .medium,
            category: .algorithms,
            summaryRU: "Разность крайних значений списка.",
            summaryEN: "Difference between max and min.",
            descriptionRU: ##"""
### Условие
Напишите функцию `amplitude(arr)`.
Разность крайних значений списка.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `amplitude(arr)`.
Difference between max and min.
"""##,
            requirementsRU: ["Сигнатура: def amplitude(arr)"],
            requirementsEN: ["Signature: def amplitude(arr)"],
            starterCode: ##"""
def amplitude(arr):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "amplitude([10, 2, 8, 1, 9])", expectedOutput: "9", validationCode: "amplitude([10, 2, 8, 1, 9]) == 9"),
                    TaskTestCase(title: "Тест 2", inputDescription: "amplitude([5, 5])", expectedOutput: "0", validationCode: "amplitude([5, 5]) == 0"),
                    TaskTestCase(title: "Тест 3", inputDescription: "amplitude([100, 20])", expectedOutput: "80", validationCode: "amplitude([100, 20]) == 80")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def amplitude(arr):
    s = arr.sorted()
    return s.last - s.first
"""##,
            xpReward: 40
        ),
        CodingTask(
            id: "py_task_count_even_elements",
            language: .python,
            titleRU: "Количество чётных элементов",
            titleEN: "Count Even Elements",
            difficulty: .easy,
            category: .algorithms,
            summaryRU: "Подсчет элементов с x % 2 == 0.",
            summaryEN: "Count even numbers.",
            descriptionRU: ##"""
### Условие
Напишите функцию `count_evens(arr)`.
Подсчет элементов с x % 2 == 0.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `count_evens(arr)`.
Count even numbers.
"""##,
            requirementsRU: ["Сигнатура: def count_evens(arr)"],
            requirementsEN: ["Signature: def count_evens(arr)"],
            starterCode: ##"""
def count_evens(arr):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "count_evens([1, 2, 3, 4, 6])", expectedOutput: "3", validationCode: "count_evens([1, 2, 3, 4, 6]) == 3"),
                    TaskTestCase(title: "Тест 2", inputDescription: "count_evens([1, 3, 5])", expectedOutput: "0", validationCode: "count_evens([1, 3, 5]) == 0"),
                    TaskTestCase(title: "Тест 3", inputDescription: "count_evens([2, 4, 8])", expectedOutput: "3", validationCode: "count_evens([2, 4, 8]) == 3")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def count_evens(arr):
    c = 0
    for x in arr:
        if x % 2 == 0:
            c = c + 1
    return c
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "py_task_sum_even_squares",
            language: .python,
            titleRU: "Сумма квадратов чётных чисел",
            titleEN: "Sum of Even Squares",
            difficulty: .medium,
            category: .algorithms,
            summaryRU: "Суммирование x*x для x % 2 == 0.",
            summaryEN: "Sum x*x for even numbers.",
            descriptionRU: ##"""
### Условие
Напишите функцию `sum_even_sq(arr)`.
Суммирование x*x для x % 2 == 0.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `sum_even_sq(arr)`.
Sum x*x for even numbers.
"""##,
            requirementsRU: ["Сигнатура: def sum_even_sq(arr)"],
            requirementsEN: ["Signature: def sum_even_sq(arr)"],
            starterCode: ##"""
def sum_even_sq(arr):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "sum_even_sq([1, 2, 3, 4])", expectedOutput: "20", validationCode: "sum_even_sq([1, 2, 3, 4]) == 20"),
                    TaskTestCase(title: "Тест 2", inputDescription: "sum_even_sq([1, 3, 5])", expectedOutput: "0", validationCode: "sum_even_sq([1, 3, 5]) == 0"),
                    TaskTestCase(title: "Тест 3", inputDescription: "sum_even_sq([2])", expectedOutput: "4", validationCode: "sum_even_sq([2]) == 4")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def sum_even_sq(arr):
    tot = 0
    for x in arr:
        if x % 2 == 0:
            tot = tot + (x * x)
    return tot
"""##,
            xpReward: 40
        ),
        CodingTask(
            id: "py_task_is_increasing",
            language: .python,
            titleRU: "Строго возрастающая последовательность",
            titleEN: "Strictly Increasing Array",
            difficulty: .medium,
            category: .algorithms,
            summaryRU: "Каждый следующий элемент строго больше предыдущего.",
            summaryEN: "Each element strictly greater than previous.",
            descriptionRU: ##"""
### Условие
Напишите функцию `is_increasing(arr)`.
Каждый следующий элемент строго больше предыдущего.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `is_increasing(arr)`.
Each element strictly greater than previous.
"""##,
            requirementsRU: ["Сигнатура: def is_increasing(arr)"],
            requirementsEN: ["Signature: def is_increasing(arr)"],
            starterCode: ##"""
def is_increasing(arr):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "is_increasing([1, 2, 5, 8])", expectedOutput: "True", validationCode: "is_increasing([1, 2, 5, 8]) == True"),
                    TaskTestCase(title: "Тест 2", inputDescription: "is_increasing([1, 2, 2, 4])", expectedOutput: "False", validationCode: "is_increasing([1, 2, 2, 4]) == False"),
                    TaskTestCase(title: "Тест 3", inputDescription: "is_increasing([10])", expectedOutput: "True", validationCode: "is_increasing([10]) == True")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def is_increasing(arr):
    n = len(arr)
    if n <= 1:
        return True
    for i in 1...n:
        if arr[i] <= arr[i - 1]:
            return False
    return True
"""##,
            xpReward: 40
        ),
        CodingTask(
            id: "py_task_point_dist_sq",
            language: .python,
            titleRU: "Квадрат расстояния точки до начала",
            titleEN: "Point Distance Squared",
            difficulty: .easy,
            category: .oopAndPop,
            summaryRU: "Формула x*x + y*y.",
            summaryEN: "Formula x*x + y*y.",
            descriptionRU: ##"""
### Условие
Напишите функцию `point_dist_sq(x, y)`.
Формула x*x + y*y.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `point_dist_sq(x, y)`.
Formula x*x + y*y.
"""##,
            requirementsRU: ["Сигнатура: def point_dist_sq(x, y)"],
            requirementsEN: ["Signature: def point_dist_sq(x, y)"],
            starterCode: ##"""
def point_dist_sq(x, y):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "point_dist_sq(3, 4)", expectedOutput: "25", validationCode: "point_dist_sq(3, 4) == 25"),
                    TaskTestCase(title: "Тест 2", inputDescription: "point_dist_sq(0, 5)", expectedOutput: "25", validationCode: "point_dist_sq(0, 5) == 25"),
                    TaskTestCase(title: "Тест 3", inputDescription: "point_dist_sq(1, 1)", expectedOutput: "2", validationCode: "point_dist_sq(1, 1) == 2")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def point_dist_sq(x, y):
    return x * x + y * y
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "py_task_rect_area",
            language: .python,
            titleRU: "Площадь прямоугольника",
            titleEN: "Rectangle Area",
            difficulty: .easy,
            category: .oopAndPop,
            summaryRU: "Произведение w * h.",
            summaryEN: "Product w * h.",
            descriptionRU: ##"""
### Условие
Напишите функцию `rect_area(w, h)`.
Произведение w * h.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `rect_area(w, h)`.
Product w * h.
"""##,
            requirementsRU: ["Сигнатура: def rect_area(w, h)"],
            requirementsEN: ["Signature: def rect_area(w, h)"],
            starterCode: ##"""
def rect_area(w, h):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "rect_area(5, 4)", expectedOutput: "20", validationCode: "rect_area(5, 4) == 20"),
                    TaskTestCase(title: "Тест 2", inputDescription: "rect_area(10, 10)", expectedOutput: "100", validationCode: "rect_area(10, 10) == 100"),
                    TaskTestCase(title: "Тест 3", inputDescription: "rect_area(7, 3)", expectedOutput: "21", validationCode: "rect_area(7, 3) == 21")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def rect_area(w, h):
    return w * h
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "py_task_step_counter",
            language: .python,
            titleRU: "Инкремент счетчика",
            titleEN: "Counter Increment",
            difficulty: .easy,
            category: .oopAndPop,
            summaryRU: "Шаг счетчика init_val + step.",
            summaryEN: "Counter step init_val + step.",
            descriptionRU: ##"""
### Условие
Напишите функцию `step_counter(init_val, step)`.
Шаг счетчика init_val + step.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `step_counter(init_val, step)`.
Counter step init_val + step.
"""##,
            requirementsRU: ["Сигнатура: def step_counter(init_val, step)"],
            requirementsEN: ["Signature: def step_counter(init_val, step)"],
            starterCode: ##"""
def step_counter(init_val, step):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "step_counter(0, 1)", expectedOutput: "1", validationCode: "step_counter(0, 1) == 1"),
                    TaskTestCase(title: "Тест 2", inputDescription: "step_counter(10, 5)", expectedOutput: "15", validationCode: "step_counter(10, 5) == 15"),
                    TaskTestCase(title: "Тест 3", inputDescription: "step_counter(100, -10)", expectedOutput: "90", validationCode: "step_counter(100, -10) == 90")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def step_counter(init_val, step):
    return init_val + step
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "py_task_calc_balance",
            language: .python,
            titleRU: "Баланс банковского счета",
            titleEN: "Bank Account Balance",
            difficulty: .medium,
            category: .oopAndPop,
            summaryRU: "Проверка баланса перед снятием средств.",
            summaryEN: "Validate balance before withdrawal.",
            descriptionRU: ##"""
### Условие
Напишите функцию `calc_balance(initial, deposit, withdraw)`.
Проверка баланса перед снятием средств.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `calc_balance(initial, deposit, withdraw)`.
Validate balance before withdrawal.
"""##,
            requirementsRU: ["Сигнатура: def calc_balance(initial, deposit, withdraw)"],
            requirementsEN: ["Signature: def calc_balance(initial, deposit, withdraw)"],
            starterCode: ##"""
def calc_balance(initial, deposit, withdraw):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "calc_balance(100, 50, 30)", expectedOutput: "120", validationCode: "calc_balance(100, 50, 30) == 120"),
                    TaskTestCase(title: "Тест 2", inputDescription: "calc_balance(100, 50, 200)", expectedOutput: "150", validationCode: "calc_balance(100, 50, 200) == 150"),
                    TaskTestCase(title: "Тест 3", inputDescription: "calc_balance(0, 100, 100)", expectedOutput: "0", validationCode: "calc_balance(0, 100, 100) == 0")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def calc_balance(initial, deposit, withdraw):
    b = initial + deposit
    if b >= withdraw:
        return b - withdraw
    return b
"""##,
            xpReward: 35
        ),
        CodingTask(
            id: "py_task_calc_gpa",
            language: .python,
            titleRU: "Средний балл оценок",
            titleEN: "Average Grade (GPA)",
            difficulty: .medium,
            category: .oopAndPop,
            summaryRU: "Сумма оценок деленная на их количество.",
            summaryEN: "Sum of grades divided by count.",
            descriptionRU: ##"""
### Условие
Напишите функцию `calc_gpa(grades)`.
Сумма оценок деленная на их количество.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `calc_gpa(grades)`.
Sum of grades divided by count.
"""##,
            requirementsRU: ["Сигнатура: def calc_gpa(grades)"],
            requirementsEN: ["Signature: def calc_gpa(grades)"],
            starterCode: ##"""
def calc_gpa(grades):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "calc_gpa([5, 4, 3])", expectedOutput: "4", validationCode: "calc_gpa([5, 4, 3]) == 4"),
                    TaskTestCase(title: "Тест 2", inputDescription: "calc_gpa([5, 5, 5, 5])", expectedOutput: "5", validationCode: "calc_gpa([5, 5, 5, 5]) == 5"),
                    TaskTestCase(title: "Тест 3", inputDescription: "calc_gpa([10, 20])", expectedOutput: "15", validationCode: "calc_gpa([10, 20]) == 15")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def calc_gpa(grades):
    tot = 0
    for g in grades:
        tot = tot + g
    return tot / len(grades)
"""##,
            xpReward: 35
        ),
        CodingTask(
            id: "py_task_circle_circumference",
            language: .python,
            titleRU: "Длина окружности (6 * r)",
            titleEN: "Circle Circumference",
            difficulty: .easy,
            category: .oopAndPop,
            summaryRU: "Формула 6 * r при pi = 3.",
            summaryEN: "Formula 6 * r with pi = 3.",
            descriptionRU: ##"""
### Условие
Напишите функцию `circumference(r)`.
Формула 6 * r при pi = 3.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `circumference(r)`.
Formula 6 * r with pi = 3.
"""##,
            requirementsRU: ["Сигнатура: def circumference(r)"],
            requirementsEN: ["Signature: def circumference(r)"],
            starterCode: ##"""
def circumference(r):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "circumference(5)", expectedOutput: "30", validationCode: "circumference(5) == 30"),
                    TaskTestCase(title: "Тест 2", inputDescription: "circumference(1)", expectedOutput: "6", validationCode: "circumference(1) == 6"),
                    TaskTestCase(title: "Тест 3", inputDescription: "circumference(10)", expectedOutput: "60", validationCode: "circumference(10) == 60")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def circumference(r):
    return 6 * r
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "py_task_car_accelerate",
            language: .python,
            titleRU: "Ускорение автомобиля",
            titleEN: "Car Acceleration",
            difficulty: .easy,
            category: .oopAndPop,
            summaryRU: "Ограничение максимальной скорости min(speed + delta, max_speed).",
            summaryEN: "Cap at max_speed.",
            descriptionRU: ##"""
### Условие
Напишите функцию `accelerate(speed, delta, max_speed)`.
Ограничение максимальной скорости min(speed + delta, max_speed).
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `accelerate(speed, delta, max_speed)`.
Cap at max_speed.
"""##,
            requirementsRU: ["Сигнатура: def accelerate(speed, delta, max_speed)"],
            requirementsEN: ["Signature: def accelerate(speed, delta, max_speed)"],
            starterCode: ##"""
def accelerate(speed, delta, max_speed):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "accelerate(60, 20, 100)", expectedOutput: "80", validationCode: "accelerate(60, 20, 100) == 80"),
                    TaskTestCase(title: "Тест 2", inputDescription: "accelerate(90, 30, 100)", expectedOutput: "100", validationCode: "accelerate(90, 30, 100) == 100"),
                    TaskTestCase(title: "Тест 3", inputDescription: "accelerate(0, 50, 120)", expectedOutput: "50", validationCode: "accelerate(0, 50, 120) == 50")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def accelerate(speed, delta, max_speed):
    return min(speed + delta, max_speed)
"""##,
            xpReward: 30
        ),
        CodingTask(
            id: "py_task_seconds_remainder",
            language: .python,
            titleRU: "Остаток секунд таймера",
            titleEN: "Timer Seconds Remainder",
            difficulty: .easy,
            category: .oopAndPop,
            summaryRU: "Вычисление seconds % 60.",
            summaryEN: "Calculate seconds % 60.",
            descriptionRU: ##"""
### Условие
Напишите функцию `seconds_remainder(seconds)`.
Вычисление seconds % 60.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `seconds_remainder(seconds)`.
Calculate seconds % 60.
"""##,
            requirementsRU: ["Сигнатура: def seconds_remainder(seconds)"],
            requirementsEN: ["Signature: def seconds_remainder(seconds)"],
            starterCode: ##"""
def seconds_remainder(seconds):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "seconds_remainder(125)", expectedOutput: "5", validationCode: "seconds_remainder(125) == 5"),
                    TaskTestCase(title: "Тест 2", inputDescription: "seconds_remainder(60)", expectedOutput: "0", validationCode: "seconds_remainder(60) == 0"),
                    TaskTestCase(title: "Тест 3", inputDescription: "seconds_remainder(59)", expectedOutput: "59", validationCode: "seconds_remainder(59) == 59")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def seconds_remainder(seconds):
    return seconds % 60
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "py_task_format_book",
            language: .python,
            titleRU: "Форматирование названия книги",
            titleEN: "Format Book Title",
            difficulty: .easy,
            category: .oopAndPop,
            summaryRU: "Строка вида title + ' by ' + author.",
            summaryEN: "Format as title + ' by ' + author.",
            descriptionRU: ##"""
### Условие
Напишите функцию `format_book(title, author)`.
Строка вида title + ' by ' + author.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `format_book(title, author)`.
Format as title + ' by ' + author.
"""##,
            requirementsRU: ["Сигнатура: def format_book(title, author)"],
            requirementsEN: ["Signature: def format_book(title, author)"],
            starterCode: ##"""
def format_book(title, author):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "format_book(\"1984\", \"Orwell\")", expectedOutput: "\"1984 by Orwell\"", validationCode: "format_book(\"1984\", \"Orwell\") == \"1984 by Orwell\""),
                    TaskTestCase(title: "Тест 2", inputDescription: "format_book(\"Hamlet\", \"Shakespeare\")", expectedOutput: "\"Hamlet by Shakespeare\"", validationCode: "format_book(\"Hamlet\", \"Shakespeare\") == \"Hamlet by Shakespeare\""),
                    TaskTestCase(title: "Тест 3", inputDescription: "format_book(\"Clean Code\", \"Martin\")", expectedOutput: "\"Clean Code by Martin\"", validationCode: "format_book(\"Clean Code\", \"Martin\") == \"Clean Code by Martin\"")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def format_book(title, author):
    return title + " by " + author
"""##,
            xpReward: 25
        ),
        CodingTask(
            id: "py_task_item_cost",
            language: .python,
            titleRU: "Стоимость товара в заказе",
            titleEN: "Order Item Cost",
            difficulty: .easy,
            category: .oopAndPop,
            summaryRU: "Произведение цены на количество price * quantity.",
            summaryEN: "Calculate price * quantity.",
            descriptionRU: ##"""
### Условие
Напишите функцию `item_cost(price, quantity)`.
Произведение цены на количество price * quantity.
"""##,
            descriptionEN: ##"""
### Problem Statement
Implement `item_cost(price, quantity)`.
Calculate price * quantity.
"""##,
            requirementsRU: ["Сигнатура: def item_cost(price, quantity)"],
            requirementsEN: ["Signature: def item_cost(price, quantity)"],
            starterCode: ##"""
def item_cost(price, quantity):
    # Ваш код на Python
    pass
"""##,
            testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "item_cost(25, 4)", expectedOutput: "100", validationCode: "item_cost(25, 4) == 100"),
                    TaskTestCase(title: "Тест 2", inputDescription: "item_cost(10, 0)", expectedOutput: "0", validationCode: "item_cost(10, 0) == 0"),
                    TaskTestCase(title: "Тест 3", inputDescription: "item_cost(15, 3)", expectedOutput: "45", validationCode: "item_cost(15, 3) == 45")
            ],
            hintsRU: ["Внимательно проверьте граничные условия."],
            hintsEN: ["Check edge cases carefully."],
            solutionCode: ##"""
def item_cost(price, quantity):
    return price * quantity
"""##,
            xpReward: 25
        )
    ]
}
