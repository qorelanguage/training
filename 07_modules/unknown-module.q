#!/usr/bin/env qore

%new-style
%strict-args
%require-types
%enable-all-warnings

%try-module ./Unknown.qm
printf("Module not loaded.\n");
exit(1);
%endtry

printf("Module loaded.\n");
