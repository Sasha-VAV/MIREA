def ultra_simple_increasing(arr):
    n = len(arr)
    max_start = 0
    max_len = 1
    curr_start = 0
    curr_len = 1
    i = 1
    prev = arr[0]

    while i < n:
        curr = arr[i]
        if curr > prev:
            curr_len += 1
        else:
            if curr_len > max_len:
                max_start = curr_start
                max_len = curr_len
            curr_start = i
            curr_len = 1
        prev = curr
        i = i + 1
    if curr_len > max_len:
        max_start = curr_start
        max_len = curr_len

    return arr[max_start:max_start + max_len]


arr = [5, 3, 7, 1, 8, 2, 9, 6, 4, 10]
print(f"Res: {ultra_simple_increasing(arr)}")