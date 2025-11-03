def ultra_simple_increasing(arr):
    max_start = 0
    max_len = 1
    curr_start = 0
    curr_len = 1
    n = len(arr)

    for i in range(1, n + 1):
        if i < n and arr[i] > arr[i - 1]:
            curr_len += 1
        else:
            if curr_len > max_len:
                max_start = curr_start
                max_len = curr_len
            curr_start = i
            curr_len = 1

    return arr[max_start:max_start + max_len]


arr = [5, 3, 7, 1, 8, 2, 9, 6, 4, 10]
print(f"Res: {ultra_simple_increasing(arr)}")