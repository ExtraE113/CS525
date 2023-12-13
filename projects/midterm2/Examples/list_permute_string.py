# Function to take out elements from the list
# Lazy version of takeouts using generator
def takeouts(lst):
    for i in range(len(lst)):
        yield (lst[i], lst[:i] + lst[i+1:])

# Generate permutations of the given list in the specified order
def ordered_permute(lst):
    if not lst:
        yield []
    else:
        for elem, remainder in takeouts(lst):
            for p in ordered_permute(remainder):
                yield [elem] + p

permutes_output = []

# Main function
def main():
    xs0 = ["a", "b", "c"]
    permutations = ordered_permute(xs0)
    for _ in range(24):
        out = next(permutations)
        permutes_output.append(str(out))
        print(out)

    permutes_output_correct_order = permutes_output.copy()
    permutes_output_correct_order.sort()
    for i in range(len(permutes_output)):
        if permutes_output[i] != permutes_output_correct_order[i]:
            print("you done did fucked up")


# Test the implementation
if __name__ == "__main__":
    main()

