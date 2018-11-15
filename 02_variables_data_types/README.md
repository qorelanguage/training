# Data types

There are several basic data types supported by Qore programming language and these are probably the most frequently
used ones:

- **Boolean** [[docs]](https://docs.qore.org/current/lang/html/basic_data_types.html#boolean)
    - declared as `bool`
    - `True` or `False` values
    - default value: `False`
- **Integer** [[docs]](https://docs.qore.org/current/lang/html/basic_data_types.html#integer)
    - declared as `int`
    - a 64-bit signed integer
    - default value: `0`
- **Float** [[docs]](https://docs.qore.org/current/lang/html/basic_data_types.html#float)
    - declared as `float`
    - a double precision floating-point number
    - default value: `0.0`
- **String** [[docs]](https://docs.qore.org/current/lang/html/basic_data_types.html#string)
    - declared as `string`
    - a sequence of characters
    - characters encoding depends on a special `QORE_CHARSET` environment variable if set or locale (`LANG`
      environment variable); default is `UTF-8` (if neither variable is set)
    - default value: `""` (empty string)
- **NOTHING** [[docs]](https://docs.qore.org/current/lang/html/basic_data_types.html#nothing)
    - declared as `NOTHING`
    - represents no value
    - default value: `NOTHING`

There are also a few others mentioned here just for the sake of completness:
- **Number** - an arbitrary precision number
- **Date** - an absolute or relative date/time value
- **Binary** - a binary object
- **NULL** - corresponds to `NULL` in a database (not equivalent to `NOTHING`)

## Conversions

Boolean, integer, float and string (number and date as well actually) can be converted one type to another. Data loss is
possible depending on the conversion (e.g. when converting float to integer, the decimal part will be lost).

A few examples:

- integer to float
    ```
    int a = 42;
    float b = float(a);        # b contains 42.0 now
    ```

- float to integer
    ```
    float a = 3.14;
    int b = int(a);            # b containst 3 now (decimal part lost)
    ```

- integer to string
    ```
    int a = 42;
    string b = string(a);      # b contains "42" now
    ```

- string to float
    ```
    string a = "3.14";
    float b = float(a);        # b contains 3.14 now
    ```

There are some catches though, be aware of them:

- String to a number type (any of float, integer or number) conversion will only read and convert numbers until
  the first non-number character is found.
    ```
    string a;
    int b;

    a = "123a456";
    b = int(a);            # b contains 123 now

    a = "3.14";
    b = int(a);            # b contains 3 now

    a = "3.14.78";
    float c = float(a);    # c contains 3.14 now
    ```

- When a certain data type is required in an expression and the provided data type can't be converted to the requested
  one, it won't produce an error and the default value for the desired data type will be used instead.
    ```
    string a;
    int b;

    a = "a word";
    b = int(a);     # no error, b contains 0 now

    a = "R2D2";
    b = int(a);     # no error, b contains 0 because even though the string contains numbers, it doesn't start with them
    ```

- `NOTHING` and `NULL` are not equivalent and can't generally be converted one to the other

## *Soft* types

Along with the basic types mentioned above the Qore programming language also provides their *soft* variants:
`softbool`, `softint`, `softfloat`, `softstring` (and also  `softnumber` and `softdate`). The difference between a type
and its *soft* alternative is that the latter accepts also values of other supported types and tries to convert it
automatically.

A few examples:

- we can assign an integer to a softstring without an explicit conversion
    ```
    int a = 42;
    softstring b = a;        # b contains "42" now
    ```

- float to softint (the decimal part is still lost)
    ```
    float a = 3.14;
    softint b = a;           # b containst 3 now (decimal part lost)
    ```

- a string can be assigned to softint too with the came behavior as explained above
    ```
    string a = "42a";
    softint b = a;           # b containst 42
    ```

- at the same time if the conversion is not possible, we get the default value again
    ```
    string a = "Hello!";
    softint b = a;           # b containst 0
    ```

It's good to know about those types and how they work but always be aware of the possible surprises.

## `auto`

A variable can also be declared as `auto`. Then the variable accepts all types and returns the same value.

- for example:
    ```
    auto a = "Hello!";      # Now a contains a string
    ```

In general it's usually better to use specific data types though.


## *Star* types

The basic data types can also be defined with a star (`*int`, `*string`, `*float`, etc.) which means that the variable
can contain a value of the specified data type or `NOTHING`.

- this assignment will throw an error
    ```
    int a = NOTHING;
    ```

- however this is correct
    ```
    *int a = NOTHING;
    ```

- as well as this
    ```
    *int a = 42;
    ```

More information about basic data types can be found in
the [documentation](https://docs.qore.org/current/lang/html/basic_data_types.html).

# Variables

The Qore programming language supports both local and global variables. With `%new-style` parse directive, variables are
assumed to be local unless explicitly specified as global using a keyword `our`.

- Example:
    ```
    # this is a global variable
    our int a;

    sub greet_world() {
        # this is a local variable
        string greeting = "Hello world!";
        printf(greeting);
    }

    ```

Local variables are also recommended in most cases since they lead to a cleaner design and are more effective.

## Lexical scopes

Local variables are local to a scope in which they are declared as illustrated in the examples
[variables_local_global.q](variables_local_global.q) and [variables_scope.q](variables_scope.q).

**Warning:** Please note that the second script will generate warnings (since we're using the `%enable-all-warnings`
parse directive) and it is not a good practice to declare variables with the same name in different lexical scopes as it
can be very confusing. This example script only does it to illustrate how block lexical scopes work.

---

| [&larr; Go Back to: Parse directives](../01_parse_directives/) | [Next: Data structures &rarr;](../03_data_structures) |
| --- | --- |
