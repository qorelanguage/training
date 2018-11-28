# Exceptions

Exceptions are a way to handle errors and they work similarly to how exceptions work in e.g. Python or Java.
Information about the exception in Qore, including the context in which the exception occurred, is saved in
the exception hash. The most frequently used keys in the hash are `err` (used for exception code) and `desc` (used for
description). For more information please read
the [documentation](https://docs.qore.org/current/lang/html/struct_qore_1_1_exception_info.html).

## `try` ... `catch` block

Any exception that is thrown in a `try` block will immediately cause execution of the `catch` block, which can capture
information about the exception.

```
try {
    do_something();
} catch () {
    # this gets executed when do_something() throws an exception
    printf("ERROR!\n");
}
```

A single variable can be specified in the catch block to be instantiated with the exception hash, giving information
about the exception that has occurred.

```
try {
    do_something();
} catch (hash<ExceptionInfo> ex) {
    # now we can print more useful information
    printf("Exception with code %s and description %s was thrown.\n", ex.err, ex.desc);
}
```

If no variable is given in the catch declaration, it will not be possible to access any information about the exception
in the catch block.

## `throw` statement

To throw an exception explicitly, Qore programming language provides `throw` keyword. According to Qore convention
a direct list follows after the keyword and it should at least contain two string elements - an error code and
a description. All system exceptions have this format.

```
throw "FILE-FORMAT-ERROR", "The file doesn't follow the supported format."
```

If the `throw` is executed in a `try` block, the information about the exception will be passed to the respective
`catch` block. Otherwise the exception will be either passed to the next higher-level `catch` block, or to the system
default exception handler.

# `rethrow` statement

A `rethrow` statement can be used to rethrow an exception in a `catch` block which will pass the exception to the next
higher-level `catch` block, or to the system default exception handler.

```
try {
    do_something();
} catch (hash<ExceptionInfo> ex) {
    # print an error message and pass the exception higher
    printf("Exception with code %s and description %s was thrown.\n", ex.err, ex.desc);
    rethrow;
}
```

The rethrow statement can be used even if there is no variable given in the `catch` block.

```
try {
    do_something();
} catch () {
    # print an error message and pass the exception higher
    printf("ERROR!\n");
    rethrow;
}
```

Note that it is an error to use the rethrow statement outside of a catch block.

---

| [&larr; Go Back to: Modules](../07_modules/) |
| --- |

<!--        |[Next:  &rarr;](../)</td> | -->

