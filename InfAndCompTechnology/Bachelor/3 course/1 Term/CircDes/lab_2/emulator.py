from algorithm import ultra_simple_increasing
def emulate_assembly_from_file(filename="commands.txt"):
    # Инициализация памяти и регистров
    mem = [0] * 1024
    RF = [0] * 16
    RF[1] = 1  # регистр 1 всегда содержит 1

    # Инициализация массива
    arr = [5, 3, 7, 1, 8, 2, 9, 6, 4, 10]

    # Словарь команд
    opcode_dict = {
        'NOP': 0, 'LTM': 1, 'MTR': 2, 'RTR': 3, 'SUB': 4,
        'JUMP_LESS': 5, 'MTRK': 6, 'RTMK': 7, 'JMP': 8, 'SUM': 9
    }

    # Парсинг файла с командами
    def parse_commands_file(filename):
        program = []
        with open(filename, 'r', encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if not line or line.startswith(';'):
                    continue

                # Удаляем комментарии в конце строки
                if ';' in line:
                    line = line.split(';')[0].strip()

                parts = line.split()
                if not parts:
                    continue

                opcode_str = parts[0]
                if opcode_str not in opcode_dict:
                    continue

                opcode = opcode_dict[opcode_str]
                operands = []

                # Парсинг операндов
                for part in parts[1:]:
                    if part.endswith(','):
                        part = part[:-1]
                    try:
                        operands.append(int(part))
                    except ValueError:
                        continue

                program.append((opcode, operands))

        return program

    # Эмулятор процессора
    def execute_instruction(opcode, operands):
        if opcode == 0:  # NOP
            pass
        elif opcode == 1:  # LTM
            literal, adr_m = operands
            mem[adr_m] = literal
        elif opcode == 2:  # MTR
            adr_r1, adr_m1 = operands
            RF[adr_r1] = mem[adr_m1]
        elif opcode == 3:  # RTR
            adr_r1, adr_r2 = operands
            RF[adr_r1] = RF[adr_r2]
        elif opcode == 4:  # SUB
            adr_r1, adr_r2, adr_r3 = operands
            RF[adr_r3] = RF[adr_r1] - RF[adr_r2]
        elif opcode == 5:  # JUMP_LESS
            adr_r1, adr_r2, adr_jump = operands
            if RF[adr_r1] >= RF[adr_r2]:
                return adr_jump
        elif opcode == 6:  # MTRK
            adr_r1, adr_r2 = operands
            RF[adr_r1] = mem[RF[adr_r2]]
        elif opcode == 7:  # RTMK
            adr_r1, adr_r2 = operands
            mem[RF[adr_r1]] = RF[adr_r2]
        elif opcode == 8:  # JMP
            adr_jump = operands[0]
            return adr_jump
        elif opcode == 9:  # SUM
            adr_r1, adr_r2, adr_r3 = operands
            RF[adr_r3] = RF[adr_r1] + RF[adr_r2]
        return None

    # Загрузка и выполнение программы
    program = parse_commands_file(filename)

    print(f"Загружено {len(program)} команд")

    # Выполнение программы
    pc = 0
    max_steps = 1000  # защита от бесконечного цикла
    step_count = 0

    while pc < len(program) and step_count < max_steps:
        opcode, operands = program[pc]
        jump_addr = execute_instruction(opcode, operands)

        if jump_addr is not None:
            pc = jump_addr
        else:
            pc += 1

        step_count += 1

        # Отладочный вывод (можно закомментировать)
        print(f"{pc=}, i={RF[7]}, prev={RF[8]}, curr_len={RF[6]}, max_len={RF[4]}")

    if step_count >= max_steps:
        print("Предупреждение: достигнуто максимальное количество шагов")

    # Проверка результата
    max_start = mem[0]
    max_len = mem[1]
    result = arr[max_start:max_start + max_len]

    print(f"\nРезультат выполнения:")
    print(f"max_start: {max_start}, max_len: {max_len}")
    print(f"Найденная подпоследовательность: {result}")


    expected = ultra_simple_increasing(arr)
    print(f"Ожидаемый результат: {expected}")
    print(f"Результаты совпадают: {result == expected}")

    # Дополнительная отладочная информация
    print(f"\nОтладочная информация:")
    print(f"Регистры: RF[2]={RF[2]}(n), RF[3]={RF[3]}(max_start), RF[4]={RF[4]}(max_len)")
    print(f"RF[5]={RF[5]}(curr_start), RF[6]={RF[6]}(curr_len), RF[7]={RF[7]}(i), RF[8]={RF[8]}(prev)")
    print(f"Память: mem[10]={mem[10]}, mem[11]={mem[11]}")


if __name__ == "__main__":
    emulate_assembly_from_file("commands.txt")