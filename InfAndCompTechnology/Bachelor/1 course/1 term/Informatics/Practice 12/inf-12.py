import numpy

print("Введите размер M квадратной матрицы MxM")
M = input("M=")  # ввод размера матрицы
while True:  # проверка корректности размера введенной матрицы
    try:
        M = float(M)
        if M > 8 or M < 2 or int(M) % 2 != 0 or float(M)!=int(M):
            print("Некорректный размер матрицы, введите снова")
            M = input("M=")
        else:
            M = int(M)
            break
    except:
        print("Некорректный размер матрицы, введите снова")
        M = input("M=")
print("Вы хотите ввести значения элементов матрицы, иначе они заполнятся случайными числами?\nДа/Нет")
# получение от пользователя вида заполнения матрицы элементами
while True:
    answer = input("Ваш ответ: ")
    if answer == "Да" or answer == "Нет":
        random_input = answer == "Нет"
        break
    else:
        print("Некорректный ввод, попробуйте снова")
matrix = [[0] * M for i in range(M)]  # инициализация двумерного массива и заполнение его нулями
if random_input:
    for i in range(M):
        for j in range(M):
            matrix[i][j] = int(numpy.random.random() * 99 + 1)  # генерация для каждого элемента
            # случайного числа в диапазоне от 1 до 100 включительно
else:
    print(f"Введите матрицу размера {M}x{M}")
    for i in range(M):
        value = list(input().split())  # считывание новой строки матрицы
        for j in range(M):
            # проверка корректности введенных данных
            try:
                if int(value[j]) == float(value[j]) and 1 <= int(value[j]) <= 100:
                    matrix[i][j] = int(value[j])
                else:
                    raise Exception
            except Exception:
                print(f"Некорректное значение в {i + 1} строке {j + 1} столбце")
                while True:  # ожидание, пока пользователь не введет корректное значение
                    try:
                        new_value = input("Новое значение:")
                        if int(new_value) == float(new_value) and 1 <= int(new_value) <= 100:
                            matrix[i][j] = int(new_value)
                            break
                        else:
                            print(f"Некорректное значение в {i + 1} строке {j + 1} столбце")
                    except:
                        print(f"Некорректное значение в {i + 1} строке {j + 1} столбце")
sort_matrix = [0] * M * M  # инициализация и заполнение сортировочного массива нулями
for i in range(M):
    for j in range(M):
        sort_matrix[i * M + j] = matrix[i][j]  # преобразование двумерного массива в одномерный
for i in range(M * M):  # сортировка одномерного массива по убыванию по условию
    current_index_max = i
    for j in range(i + 1, M * M):
        if sort_matrix[j] > sort_matrix[current_index_max]:
            current_index_max = j
    sort_matrix[i], sort_matrix[current_index_max] = sort_matrix[current_index_max], sort_matrix[i]
sort_matrix = sort_matrix[::-1]  # инвертирование массива
# Преобразование одномерного отсортированного массива в заданный
for i in range(M):
    for j in range(M // 2):
        matrix[i][j] = sort_matrix[i * M // 2 + j]
    for j in range(M // 2, M):
        matrix[i][j] = sort_matrix[M * M // 2 + i * M // 2 + j - M // 2]
print("Отсортированная матрица")  # вывод отсортированного массива
for i in range(M):
    for j in range(M):
        print(matrix[i][j], end=" ")
    print("")
