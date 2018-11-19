# Classes


Classes define types of Qore objects. Classes can define members (attributes) and methods which are functions that
operate only on the objects of that class.

A basic class can look like this:

```
class Person {
    public {
         string name;
    }

    constructor(string person_name) {
        name = person_name;
    }

    introduce() {
        printf("Hello I am %s.\n", name);
    }
}
```

Now we can create an object of that class and call the `introduce()` method:

```
Person jane = new Person("Jane");
jane.introduce();
```

An object of that class will represent one person who is given a name in the constructor and can introduce themselves.
A constructor is called anytime a new object of a class is created.

Classes support inheritance and so we can create another class like this:

```
class Employee inherits Person {
    public {
         int career_length;
    }

    constructor(string person_name, int length) : Person(person_name) {
        career_length = length;
    }

    introduce() {
        printf("Hello I am %s and I've been working here for %d years.\n", name, career_length);
    }
}
```

This is how we would create an instance of `Employee` class:

```
Employee john = new Employee("John", 10);
john.introduce();
```

As you can see the class `Employee` inherits from `Person` and calls `Person`'s constructor whenever `Employee`'s
constructor is called because storing the name is already implemented there.

You can also notice that `Employee` overrides `Person`'s `introduce()` method. That's because an employee will introduce
himself/herself differently than an ordinary person.

The `introduce()` method doesn't return anything but it's of course possible to have methods that do return something.
Let's add such method to the `Employee` class:

```
class Employee inherits Person {
    public {
         int career_length;
    }

    constructor(string person_name, int length) : Person(person_name) {
        career_length = length;
    }

    int months_working() {
        return career_length * 12;
    }

    introduce() {
        printf("Hello I am %s and I've been working here for %d years.\n", name, career_length);
    }
}
```

Using John from the example above we can call the new method just like any other:

```
printf("John has been working here for %d months.\n", john.months_working());
```

We can also overload a method (including constructor) so that there are two methods of the same name accepting different
arguments. Let's add another constructor to the `Employee` class:

```
class Employee inherits Person {
    public {
         int career_length;
    }

    constructor(string person_name, int length) : Person(person_name) {
        career_length = length;
    }

    constructor(Person p) : Person(p.name) {
        career_length = 0;
    }

    int months_working() {
        return career_length * 12;
    }

    introduce() {
        printf("Hello I am %s and I've been working here for %d years.\n", name, career_length);
    }
}
```

Let's say we want to employ Jane from the example above. This is how we can use the new constructor conveniently:

```
Employee jane_employed = new Employee(jane);
jane_employed.introduce();
```

By the way you can also do this:

```
Person alex = new Employee("Alex", 2);
alex.introduce();
```

Notice that `alex` is a `Person` variable but the introduce method is from the `Employee` class. That's because we
created an `Employee` object, not a `Person` object. We can assign it to a `Person` variable because `Employee` inherits
from `Person` (in other words... an employee is also a person).

Classes in the Qore programming language also support destructors, private members and methods, static methods, abstract
methods and other features but since this is suposed to be a basic tutorial, please read
[the documentation](https://docs.qore.org/current/lang/html/qore_classes.html) if you need to know more.

---

| [&larr; Go Back to: Input, output](../05_input_output/) | [Next: Modules &rarr;](../07_modules/) |
| --- | --- |
