# Input/output

For input one can choose from a few reading functions. Let's mention three of them.
- `stdin.getchar()` - reads one character from the standard input
    ```
    # read characters (and print them) until "q" is on the input
    string c = stdin.getchar();
    while (c != "q") {
        printf("%s, ", c);
        c = stdin.getchar();
    }
    ```

- `stdin.read()` - reads specified number of characters from the standard input
    ```
    # read 10 character pairs and print them
    for (int i = 0; i < 10; i++) {
        string pair = stdin.read(2);
        printf("%s, ", pair);
    }
    ```

- `stdin.readLine()` - reads the whole line (until it finds an end of line)
    ```
    # read the user's name and greet him/her
    printf("What is your name?");
    string name = stdin.readLine();
    printf("Hello %s!\n", name);
    ```


The basic output function is `printf()` which accepts a format string and arguments. You can see some examples above
(and in other chapters of this tutorial) so let's just briefly go through the options.

```
printf("It's possible to print a string without any arguments.\n");
```

```
printf("You can print an integer like this: %d\n", number);        # number is an integer variable
```

```
printf("It's possible to print a float like this: %f\n", number);  # number is a float variable
```

More about formatting the output can be found in
the [documentation](https://docs.qore.org/current/lang/html/group__string__functions.html#string_formatting).

---

| [&larr; Go Back to: Flow control](../04_flow_control/) | [Next: Classes &rarr;](../06_classes/) |
| --- | --- |
