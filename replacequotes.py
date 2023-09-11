def replace_double_quotes_with_parentheses(s: str) -> str:
    """Replaces every pair of double quotes in a string with open and closed parentheses."""
    stack = []
    result = []
    for char in s:
        if char == '"':
            if not stack:
                result.append('(')
                stack.append('"')
            else:
                result.append(')')
                stack.pop()
        else:
            result.append(char)
    return ''.join(result)

# Example usage:
input_string = """This is a "test" string with "quotes". and, here! is. some? (more.) stuf'f to 'test' "about"."""
output_string = replace_double_quotes_with_parentheses(input_string)
print(output_string)  # Expected: This is a (test) string with (quotes).
