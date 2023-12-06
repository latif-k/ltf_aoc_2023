import argparse
import random
import string
import sys
from pathlib import Path


def generate_samples(line_count):
    # Generate 7 lines of text
    lines = []
    digits = []
    while len(lines) <= line_count:
        # Generate a random length for the line
        line_length = random.randint(2, 20)

        # Elements to choose from
        numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
        words = [
            "one",
            "two",
            "three",
            "four",
            "five",
            "six",
            "seven",
            "eight",
            "nine",
        ]
        first_num = None
        last_num = None
        # Create a mixed line with more randomness
        line = []
        for _ in range(line_length):
            choice = random.randint(0, 5)
            if choice == 0:
                # Add a number
                choice = random.choice(words)
                line.append(choice)
            elif choice == 1:
                # Add a word
                choice = random.choice(numbers)
                line.append(choice)
            else:
                # Add gibberish
                gibberish_length = random.randint(1, 5)  # Keeping gibberish short
                gibberish = "".join(
                    random.choices(string.ascii_lowercase, k=gibberish_length)
                )
                line.append(gibberish)

        line_str = "".join(line)

        first_num = None
        last_num = None

        for i, ch in enumerate(line_str):
            skip = False
            for num in numbers:
                if num != ch:
                    continue
                if first_num is None:
                    first_num = numbers.index(ch) + 1
                last_num = numbers.index(ch) + 1
                skip = True
            if skip:
                continue
            for word in words:
                if not line_str[i:].startswith(word):
                    continue
                if first_num is None:
                    first_num = words.index(word) + 1
                last_num = words.index(word) + 1

        if not first_num or not last_num:
            continue
        # Convert line to string
        lines.append(f"{line_str} {first_num}{last_num}")
    return lines + ["\n"]


# Generate and print the lines
if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog="aoc_day1_gen",
        description="Generate advent of code day 1 sample",
    )

    parser.add_argument("-l", "--count", default=10, type=int)  # positional argument
    parser.add_argument("-o", "--output")  # option that takes a value
    args = parser.parse_args()
    lines = digits = generate_samples(args.count)
    if args.output:
        Path(args.output).write_text("\n".join(lines))
    else:
        print("\n".join(lines))
