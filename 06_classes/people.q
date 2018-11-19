#!/usr/bin/env qore

%new-style
%strict-args
%require-types
%enable-all-warnings

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

Person jane = new Person("Jane");
jane.introduce();

Employee john = new Employee("John", 10);
john.introduce();
printf("John has been working here for %d months.\n", john.months_working());

Employee jane_employed = new Employee(jane);
jane_employed.introduce();

Person alex = new Employee("Alex", 2);
alex.introduce();
