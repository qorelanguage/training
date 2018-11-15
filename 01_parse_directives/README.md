# Parse directives

Qore programming language supports parse directives in order to set parsing options, load modules, control warnings, and
include other files. They are supposed to be placed at the top of every Qore file as you can see in
the example [hello_world.q](hello_world.q) script.

## Recommended parse directives

The four directives used in the script are recommended for Qore programming and their meaning is as follows:

#### `%new-style` [[docs]](https://docs.qore.org/current/lang/html/parse_directives.html#new-style)

Sets the *new style* syntax which is similar to C++ or Java and is considered the supported one for Qore programming.
The *old style* syntax on the other hand makes Qore programming language look more like Perl for example (there is
`%old-style` parse directive as well). This whole tutorial will be using the new style syntax.

#### `%strict-args` [[docs]](https://docs.qore.org/current/lang/html/parse_directives.html#strict-args)

Prohibits calling a function with excess arguments that the function doesn't handle which is otherwise possible in Qore.

E.g. the following code would be legal and working without the `%strict-args` parse directive:
```
%new-style

sub greet_world() {
    printf("Hello world!\n");
}

greet_world(42);
```

#### `%require-types` [[docs]](https://docs.qore.org/current/lang/html/parse_directives.html#require-types)

Requires type declarations for all function and method parameters, return types, variables, and object members.

#### `%enable-all-warnings` [[docs]](https://docs.qore.org/current/lang/html/parse_directives.html#enable-all-warnings)

This one probably doesn't need to be explained much - it simply enables all warnings while parsing Qore code.

## Other interesting parse directives

A few other parse directives worth mentioning:

- `%enable-warning` enables a particular type of warning
- `%requires`, `%try-module` and `%end-try` for loading modules (see the chapter on modules for more information)

There are also directives that prohibit using particular features of Qore programming language which is useful for
sandboxing - e.g. `%no-network` to forbid network access or `%no-new` that prohibits use of `new` operator.

When a change in Qore programming language would break a backwards incompatibility, a new parse directive can be
introduced to keep existing code working.

For more information about parse directives please see the
[documentation](https://docs.qore.org/current/lang/html/parse_directives.html).

# Comments

Comments are not really parse directives per se but it is related to parsing and it's good to mention this early. Qore
programming language supports both line and block comments and you can see both in the following examples:

```
# This is a line comment.

printf("Hello world!");    # this will print "Hello world!"
```

```
/*

This is a block comment and the following command will not get executed:

printf("Hello world!");

*/
```

---

| [&larr; Go Back to: Introduction](../) | [Next: Variables and data types &rarr;](../02_variables_data_types/) |
| --- | --- |
