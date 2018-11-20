#!/usr/bin/env qore

%new-style
%strict-args
%require-types
%enable-all-warnings

%requires ./People.qm

People::Person jane = new People::Person("Jane");
jane.introduce();

People::Employee john = new People::Employee("John", 10);
john.introduce();
printf("John has been working here for %d months.\n", john.months_working());

People::Employee jane_employed = new People::Employee(jane);
jane_employed.introduce();

People::Person alex = new People::Employee("Alex", 2);
alex.introduce();