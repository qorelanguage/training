# Modules

Modules allow to extend the Qore programming language. You can think of them as of libraries. There are two types of
modules:

- Binary modules are written in C++ and delivered in binary form. They must conform to the Qore Module API and have
the file extension `*.qmod`.

- User modules are written in Qore and delivered in source form. They must have the extension `*.qm`.

Since this is a basic tutorial, the rest of this chapter will be dealing with user modules although some of
the information mentioned in this chapter is valid for binary modules as well.

## Loading modules

### Parse-time

There are two parse directives to load modules at parse-time.

#### `%requires` [[docs](https://docs.qore.org/current/lang/html/parse_directives.html#requires)]

Loads a Qore module immediately.

```
%requires MyModule
```

To be able to load a module, it should be in a directory listed in the `QORE_MODULE_DIR` environment variable. There are
also other directories that are searched when looking for modules but those are listed and mentioned in
the [documentation](https://docs.qore.org/current/lang/html/qore_modules.html).

Another option is to specify an absolute or a relative path to the module.

```
%requires ./modules/MyModule.qm
```

```
%requires ./People.qm
```

You can also specify a comparison operator (one of `<`, `<=`, `=`, `>=`, or `>`) and version information after
the module name as well.

```
%requires MyModule >= 2.0.3
```

To load a module on command line, you can use the `-l` or `--load` arguments.

```
$ qore -l MyModule -e '...`
```

Even on command line it's possible to specify path to a module.

```
$ qore -l ./People.qm -e '...`
```

#### `%try-module` [[docs](https://docs.qore.org/current/lang/html/parse_directives.html#try-module)]

Tries to load a Qore module immediately; if an error occurs loading the module, then the variable declared in
parentheses after `%try-module` is instantiated with the exception information, and the code up to the `%endtry` parse
declaration is parsed into the program, allowing for the qore script/program to handle module loading errors at
parse time for modules that must be loaded at parse time.

```
%try-module ./Unknown.qm
printf("Module could not be loaded.\n");
exit(1);
%endtry
```

### Run-time loading

There is also a `load_module()` function to load Qore modules at run-time; however, note that any module providing parse
 support (classes, constants, functions, etc) must be loaded at parse time using the %requires or %try-module parse directive.

More about `load_module()` can be found in the
[documentation](https://docs.qore.org/current/lang/html/group__misc__functions.html#gae8e72e38355f6fcd037ca65945377c96).

## Implementing modules

### Declaration

User modules are declared with a special syntax in Qore:

```
module name {
    version = "version string";
    desc = "description string";
    author = "author string";
    [url = "URL string";]
    [license = "license string";]
    [init = initialization closure;]
    [del = deletion closure;]
}
```

For example:

```
module MyModule {
    version = "1.0";
    desc = "My test module";
    author = "John Doe";
    init = sub () {
        printf("MyModule is initialized.\n");
    };
}
```

This module will print a message when it's loaded and initialized.

### Objects are `private` by default

Objects (namespaces, classes, functions, etc.) need to be declared as `public` to make them available in programs that
will require and use our module.  All other declarations and definitions are private to the module.

### Module example

You can see a simple example module in [People.qm](People.qm). It's actually the same example as in
the [chapter](../06_classes/) on classes but this time implemented as a module. Thus you can require and use it as you
can see in the simple example script [people.q](people.q).

### Implement a simple module

See a simple example script [unknown-module.q](unknown-module.q) - it tried to load a module called `Unknown.qm` from
the current directory. If it doesn't find it, it will print that the module wasn't loaded and exits. Otherwise it will
print a message that the module was loaded. You can try and implement such module and see if it's loaded correctly then.

More detailed information on modules can be found in
the [documentation](https://docs.qore.org/current/lang/html/qore_modules.html).

---

| [&larr; Go Back to: Classes](../06_classes/) | [Next: Exceptions &rarr;](../08_exceptions/) |
| --- | --- |
