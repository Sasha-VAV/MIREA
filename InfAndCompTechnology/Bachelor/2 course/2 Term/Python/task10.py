def remove_duplicates(data):
    seen = set()
    unique_data = []
    for row in data:
        row_tuple = tuple(row)
        if row_tuple not in seen:
            seen.add(row_tuple)
            unique_data.append(list(row_tuple))
    return unique_data


def process_phone(phone_str):
    number, name = phone_str.split("#")
    clean_num = number[3:]
    formatted_num = f"({clean_num[:3]}){clean_num[3:]}"
    name = name[0] + "." + name[name.find(" ") + 1 :]
    return formatted_num, name


def process_value(value):
    if "#" in value:
        return process_phone(value)
    elif value == "true":
        return "1"
    elif value == "false":
        return "0"
    elif "%" in value:
        return f"{float(value[:-1]) / 100:.4f}"
    return value


def process_row(row):
    processed = []
    for val in row:
        res = process_value(val)
        if isinstance(res, tuple):
            processed.extend(res)
        else:
            processed.append(res)
    return processed


def transpose(matrix):
    return [list(col) for col in zip(*matrix)] if matrix else []


def main(data):
    unique_rows = remove_duplicates(data)

    processed_data = [process_row(row) for row in unique_rows]

    transposed = transpose(processed_data)
    unique_cols = remove_duplicates(transposed)

    bools, numbers, names, scores = unique_cols
    result = [bools, names, scores, numbers]

    return result


arr = [
    ["false", "+7 556 567-38-34#Федор М. Фезин", "70%", "70%"],
    ["true", "+7 435 061-07-22#Родион Р. Булорянц", "80%", "80%"],
    ["true", "+7 758 186-75-81#Арсений Л. Бешочов", "39%", "39%"],
    ["false", "+7 155 971-68-97#Дамир У. Кений", "99%", "99%"],
    ["true", "+7 758 186-75-81#Арсений Л. Бешочов", "39%", "39%"],
]
ans = main(arr)
print(ans)
print("\n\n")
print(ans[0])
