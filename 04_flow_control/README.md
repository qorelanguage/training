# Flow control

## `if` statement

The if statement allows for conditional logic in a Qore program's flow; the syntax is similar to that of C, C++, or
Java.

```
# rand() is a Qore function returning a random number
int x = rand();

if (x % 2 == 0) {
    print("x is an even number\n");
} else {
    print("x is an odd number\n");
}

```

The `else` part is optional.

### Operators

Comparison operators are often used in a condition used by `if` statement. The operators are usually similar to what
you may know from other programming languages but there is one thing to keep in mind. The Qore programming language
provides *soft* and *hard* operators and it's good to be aware of the difference between them.

#### *soft* operators

- perform a type conversion if needed - i.e. `(1 == "1")` is True even though we compare two different types
  (an integer and a string)
- e.g. `==`, `>`, `<`, `!=`, `>=`, `<=`

#### *hard* operators

- do not perform any implicit type conversions and if the types are different the result is always False - i.e.
  `(1 === "1")` is False
- e.g. `===`, `!==`

A good example for using the *hard* operators may be checking for `NOTHING`:
- `(NOTHING == 0)` is True
- `(NOTHING === 0)` is False

If you need to check a value against `NOTHING` and distinguish it from zero, you should always use the *hard* operators.

#### Regular expression operators

Quite useful are also regular expression operators that can be used e.g. in `if` statement conditions. Operator `=~`
returns True if the string on the left side matches the regular expression on the right side of the operator.

```
if (some_string =~ /hello/) {
    printf("some_string contains 'hello'\n");
}
```

```
if (some_string =~ /^hello.*world$/) {
    printf("some_string starts with 'hello' and ends with 'world'\n");
}
```

Opposite operator for *does not match* is `!~`.

There are also modifiers for e.g. case insensitive matching but for that please consult
the [documentation](https://docs.qore.org/current/lang/html/operators.html#regex_match_operator).


## `switch` statement

The Qore switch statement is similar to the switch statement in C and C++, except that the case values can be any
expression that does not need run-time evaluation and can also be expressions with simple relational operators or
regular expressions.

```
printf("value is ");
switch (value) {
    case < -1:
        printf("less than -1\n");
        break;
    case 25:
        printf("25\n");
        break;
    case "string":
        printf("'string'\n");
        break;
    case > 2007-01-22T15:00:00:
        printf("greater than 2007-01-22 15:00:00\n");
        break;
    case /abc/:
        printf("a string with 'abc' inside\n");
        break;
    default:
        printf("something else\n");
        break;
}
```

The switch-expression is compared against individual case-expression until one of them is evaluated to True. In this
case all code up to a break statement is executed, at which time execution flow exits the switch statement. Unless relational operators are used, the comparisons are *hard* comparisons (no implicit type conversions are done). When
relational operators are used, the operators are executed exactly as they are in the rest of Qore, so type conversions
may be performed if nesessary.

Therefore there is a difference between the following two examples:

```
switch (42) {
    case "42":
        printf("Matched.\n");
        break;
```

```
switch (42) {
    case == "42":
        printf("Matched.\n");
        break;
```

In the first one the case-statement is not evaluated to True because it compares a string to an integer, while in
the second example the case-statement is evaluated to True because an implicit type conversion is performed with `==`.

These operators can be used in a `case` statement:
- `>`
- `>=`
- `<`
- `<=`
- `==`
- `=~`
- `!~`

## `while` loop

## `for` loop

## `foreach` loop

## `break` statement

## `continue` statement

## `throw` statement

## `on_exit`, `on_error`, `on_success` statements


# Functions


---

<table>
    <tr>
        <td>[&larr; Go Back to: Data structures](../03_data_structures/)</td>
        <td>[Next: Input, output &rarr;](../05_input_output/)</td>
    </tr>
</table>
