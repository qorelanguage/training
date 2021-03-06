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

If you need to check a value against `NOTHING` and distinguish it from zero, you should always use the *hard* operators
or [exists operator](https://docs.qore.org/current/lang/html/operators.html#exists) like
- `(exists 0)` is True
- `(exists False)` is True
- `(exists NOTHING)` is False.

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
case all code up to a break statement is executed, at which time execution flow exits the switch statement. Unless
relational operators are used, the comparisons are *hard* comparisons (no implicit type conversions are done). When
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

While statements in Qore are similar to while statements in Perl, C and Java. They are used to loop while a given
condition is evaluated to True.

```
int a = 1;
while (a < 10) {
    a++;
}
```

## `do` ... `while` loop

This loop is similar to do-while statement in C. The `do` ... `while` statements guarantee at least one iteration and
then loop until a given expression evaluates to False. Therefore it's like a `while` loop except that the condition is
checked at the end of the loop instead of the beginning.

## `for` loop

The Qore for statement is most similar to the for statement in C and Java. This statement is ideal for loops that should
execute a given number of times, then complete.

```
for (int i = 0; i < 10; i++) {
    printf("%d\n", i);
}
```

In general there are three statements in the parentheses after the `for` keyword:
- initial expression which is executed only once at the start of a for loop
    - e.g. `int i = 0;` initializes the loop variable to zero
- test expression which is executed at the start of each iteration and if it's evaluated to False, the loop ends
    - e.g. `i < 10` checks whether the loop variable is still less than 10
- the iterator expression which is executed at the end of every iteration
    - e.g. `i++` increments the value of the loop variable

## `foreach` loop

The Qore foreach statement is similar to the foreach array iterator statement in Perl. It loops through the given
expression and executes the loop for each *element* once.

```
list words = ("lorem", "ipsum", "dolor");

foreach string w in (words) {
    printf("%s\n", w);
}
```

Depending on the expression in the parentheses, the `foreach` loop will work differently:
- if the expression is a list like in the example above, the loop iterates through its items
- if the expression evaluates to an object inheriting the `AbstractIterator` class, the foreach operator iterates
the object by calling `AbstractIterator::next()`, and the values assigned to the iterator variable on each iteration are
the container values returned by `AbstractIterator::getValue()`
- if the expression evaluates to `NOTHING`, then the loop is not executed
- otherwise the variable will be assigned the value of the expression evaluation and the statement will only execute
once

An example of an object inheriting the `AbstractIterator` class is a hash:

```
hash h = {
    "a": 1,
    "b": 2
};

foreach hash iter_hash in (h.pairIterator()) {
    printf("%s = %y\n", iter_hash.key, iter_hash.value);
}
```

## `break` statement

Exits immediately from a loop statement or a switch block. We could see the latter case in the section about
the `switch` statement above and here is an example of `break` usage in loops:

```
list words = ("lorem", "ipsum", "dolor", "END", "sit", "amet");

# this loop will print all words until it finds "END", then the loop will end
foreach string w in (words) {
    if (w == "END") {
        break;
    }

    printf("%s\n", w);
}
```

## `continue` statement

Skips the rest of the current loop iteration and jumps right to evaluation of the iteration expression.

```
int count = 0;
list words = ("lorem", "ipsum", "dolor", "END", "sit", "END", "amet");

# this loop will print and count all words except "END"
foreach string w in (words) {
    if (w == "END") {
        continue;
    }

    printf("%s\n", w);
    count++;
}

printf("There are %d valid words in the list.\n", count);     # count is 5 now
```

## `on_exit`, `on_error`, `on_success` statements

- `on_exit` - precedes a statement or a block that is executed when the current lexical scope (e.g. a function or
a block) ends either successfully or with an error
- `on_error` - precedes a statement or a block that is executed when exception is thrown in the current lexical scope
- `on_success` - precedes a statement or a block that is executed when the current lexical scope ends successfully

```
sub do_something() {
    SomeClass resource = get_some_resource();
    on_exit {
        resource.cleanup();
    }
    on_error {
        printf("Error. Something went wrong.\n");
    }
    on_success {
        printf("Success!\n");
    }

    # now do something useful
}
```

Now whatever happens in the `do_something()` function,  the resource will be cleaned up. On top of that, if there is
an error during doing *something useful*, the error message will be printed and on the other hand if there is no error,
the success message will be printed.

This is related to exceptions which are explained in more detail in [chapter 8](../08_exceptions/).

# Functions

A function in Qore programming language is declared by using the keyword `sub` (for subroutine) which can be preceded by
a return type declaration if the function is supposed to return something. If the function won't return anything, there
is no declaration of the type (unlike e.g. `void` in C). Function parameters are specified in the parentheses after
the function name.

```
# this function accepts one string parameter and doesn't return anything
sub do_something(string a) {
    # here is the code defining the function
}
```

```
# this function accepts no parameters and returns an integer
int sub do_something_else() {
    # here is the code defining the function

    int res;

    # do something to determine the result

    # this is how we return the result
    return res;
}
```

---

| [&larr; Go Back to: Data structures](../03_data_structures/) | [Next: Input, output &rarr;](../05_input_output/) |
| --- | --- |
