# Command line interface

Besides writing and running scripts one can also use the Qore programming language from the command line which is
especially handy for verifying how something works, what a function returns, whether a type conversion will be
automatically performed, etc.

```
$ qore -e 'printf("Hello world!\n");'
Hello world!
```

## Execute

The `-e` command line argument is very useful. It accepts a string that should be a valid Qore code and executes it.
Usually you will want to use `-n` as well which is an argument for new style syntax which is the supported one (see
the [next chapter](01_parse_directives/) for more details).

```
$ qore -n -e 'printf("Hello world!\n");'
Hello world!
```
is equivalent to

```
$ qore -ne 'printf("Hello world!\n");'
Hello world!
```

You can also chain multiple commands to be executed...

```
$ qore -ne 'string name = "John Doe"; printf("Hello %s!\n", name);'
Hello John Doe!
```

...or use loops
```
$ qore -ne 'int num = 0; while (num < 10) { printf("%d\n", num); num += 2;}'
0
2
4
6
8
```

## Evaluate

There is also a `-X` argument which can be used for evaluating expressions instead of executing statements.

```
$ qore -X '1 + 1'
2
```

```
$ qore -X '1 == 1'
True
```

```
$ qore -X '()'
<EMPTY LIST>
```

## Loading modules

Qore modules provide additional functionality to the language. If you want to load modules on CLI to try something out,
you can use `-l` argument.

```
$ qore -l FsUtil -X 'path_exists("/")'
True
```

This wouldn't work without the argument because function `path_exists()` is provided by `FsUtil` module.

```
$ qore -X 'path_exists("/")'
unhandled QORE System exception thrown in TID 1 at 2018-11-19 12:47:31.071138 Mon +01:00 (CET) at <command-line>:1
PARSE-EXCEPTION: function 'path_exists()' cannot be found
```

---

| [&larr; Go Back to: Introduction](../README.md) | [Next: Parse directives &rarr;](01_parse_directives/) |
| --- | --- |
