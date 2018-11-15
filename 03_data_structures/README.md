# Data structures

## Lists

List is an advanced data type Qore uses for storing multiple values with a defined order.

```
list empty = ();
list also_empty = list();
list words = ("lorem", "ipsum", "dolor", "sit", "amet");
list numbers = (42, 3.14, "seven", (1, 2, 3));
```

As you can see in the last example items in a list doesn't necessarily need to be of the same type and lists can even
contain other lists. Qore programming language supports also typed lists however, as you can see below.

### List operators

Elements in a list can be accessed using square brackets operator (`[]`) like this:
```
printf("Second word: %s\n", words[1]);     # indices start with zero
```

**Warning:** Please be aware that if you try and access an element using an index that doesn't exist in the list (i.e.
is out of its bounds), you will not get an error but `NOTHING` will be returned instead.

```
list words = ("lorem", "ipsum");

*string a = words[0];      # a contains "lorem" now
a = words[1];              # a contains "ipsum" now
a = words[2];              # no error, a contains NOTHING now
a = words[256];            # no error, a contains NOTHING now
```

Other useful list operators are these:

- `elements` returns the number of elements in a list
    ```
    list numbers = (42, 3.14, "seven", (1, 2, 3));

    # prints "There are 4 elements in the list."
    printf("There are %d elements in the list.\n", elements numbers);
    ```
- `push` or `=+` add an element to the end of the list
    ```
    list words = ("lorem", "ipsum", "dolor");
    push words, "sit";
    words += "amet";

    # words now contains ("lorem", "ipsum", "dolor", "sit", "amet")
    ```
- `pop` removes and returns the last element of the list
    ```
    list words = ("lorem", "ipsum", "dolor");

    string a = pop words;

    # a now contains "dolor"
    # words now contains ("lorem", "ipsum")
    ```

- `+` concatenates lists
    ```
    list words = ("lorem", "ipsum");
    list numbers = (42, 3.14, "seven");

    list together = words + numbers;

    # together now contains ("lorem", "ipsum", 42, 3.14, "seven")
    ```

More operators are described in
the [documentation](https://docs.qore.org/current/lang/html/container_data_types.html#list).

### List functions

There are also useful functions for working with lists such as these:

- `inlist()`, `inlist_hard()` check whether a value is in a list using *soft* or *hard* comparison respectively
  (which means with or without type conversions - more on *soft* or *hard* comparisons will be explained in the
  [next chapter](04_flow_control))
    ```
    if (inlist(42, some_list)) {
        printf("The list contains 42.\n");
    }

    ```

- `min()`, `max()` return the minimum/maximum value in the list
    ```
    list numbers = (1, 12, 42, 7, 12);
    printf("The maximum value is %d.\n", max(numbers));
    ```

- `range` returns a list containing an arithmetic progression of integers
    ```
    list numbers = range(6, 15, 2);
    # numbers now contains (6, 8, 10, 12, 14)

    # or
    numbers = range(1,5);
    # numbers now contains (1, 2, 3, 4, 5)

    # or
    numbers = range(3);
    # numbers now contains (0, 1, 2, 3)
    ```

- `reverse` creates a new list with the same elements in reverse order
    ```
    list numbers = (1, 2, 3);
    list reversed = reverse(numbers);
    # reversed now contains (3, 2, 1)
    ```

- `sort` sorts the list in ascending order and returns a new list
    ```
    list numbers = (1, 12, 42, 7, 12);
    list sorted = sort(numbers);
    # sorted now contains (1, 7, 12, 12, 42)
    ```

More functions are described in
the [documentation](https://docs.qore.org/current/lang/html/group__list__functions.html).

### List with declared value type

The list type supports one type argument in angle brackets to specify the value type. This results in a list where
the elements must always be of the declared type.

```
list<int> numbers = (1, 12, 42, 7, 12);

numbers += 2018;        # this is OK, we can add more integers
numbers += 3.14;        # this is not OK, we can't add a float, it will throw an error
numbers += "5";         # this is not OK, we can't add a string, it will throw an error
numbers += int("5");    # this is OK, as we're using an explicit conversion
```

### `softlist`

Similarly as e.g. `softint` or `softstring` (explained in [chapter 02](../02_variables_data_types)) there is also
`softlist`, a data type that will accept lists or types that can be converted to a list.

- if a list is assigned to a softlist, it's unchanged
    ```
    softlist a = (1, 2, 3);

    # a now contains (1, 2, 3)
    ```

- if `NOTHING` is assigned to a softlist, an empty list is created
    ```
    softlist a = NOTHING;

    # a now contains ()
    ```

- a value of any other type will create a new list with that value as its first element
    ```
    softlist a = 42;

    # a now contains (42,)
    ```

Softlists can also have value type declared - for example:
```
softlist<int> numbers;
```

### `*list`

Similarly as e.g. `*int` or `*string` (explained in [chapter 02](../02_variables_data_types)) there is also `*list`,
a data type that will accept a list or `NOTHING`.

A `*list` can also have value type declared - for example:
```
*list<int> numbers;
```

## Hashes

Hashes are containers (associative arrays similar to Maps in Java or dictionaries in Python) that assigns values to
a key and also preserve key order for consistent data serialization/deserialization (so they are actually more like
ordered dictionaries in Python). Currently only strings are used as keys but you can use other data types as well if
they can be implicitly converted to strings and stored as strings inside the hash. The same conversion is applied when
accessing value associated with a key. The values in general don't need to be of the same type.

```
hash h = {
    "apple": 2,
    "pear": 3,
    "orange": 2,
    "lemon": "none",
};

hash empty = {};

hash also_empty = hash();
```

There are multiple ways to access elements in hash: `h{"apple"}`, `h.apple`, `h.{"app" + "le"}` and `h{a_key}` are all
equivalent ways to access the value associated with the key "apple" (as long as `a_key` is a variable containing
"apple").

**Warning:** Similarly to how lists work, an attempt to access a key that doesn't exist in a hash will throw no error
(as you could expect) and will return `NOTHING` instead.

Other useful hash operators are:

- `keys` returns a list representing the keys in a hash
    ```
    hash h = {
        "apple": 2,
        "pear": 3,
        "orange": 2,
        "lemon": "none",
    };

    list k = keys h;        # k now contains ("apple", "pear", "orange", "lemon")
    ```
- `+` concatenates hashes
    ```
    hash h1 = {
        "a": "b",
        "b": "c"
    };

    hash h2 = {
        "b": "d",
        "e": 42
    };

    hash h = h1 + h2;

    # h now contains
    # {
    #     "a": "b",
    #     "b": "d",
    #     "e": 42
    # }
    ```
- `-` deletes key(s) from the hash (more precisely it creates a new copy of the hash without the key(s) and returns
  the new hash without modifying the original one)
    ```
    hash h = {
        "apple": 2,
        "pear": 3,
        "orange": 2,
        "lemon": "none",
    };

    # if there is a string key on the right side, that key is removed
    hash x = h - "apple";

    # x now contains
    # {
    #     "pear": 3,
    #     "orange": 2,
    #     "lemon": "none"
    # }
    #
    # h stays unmodified

    # if there is a list of keys on the right sides, all of them are removed
    hash y = h - ("apple", "pear", "lemon");

    # y now contains {"orange": 2}

    # it's of course possible to modify the original hash like this:
    h = h - ("apple", "lemon", "orange");

    # h now contains {"pear": 3}

    # an attempt to remove a key that isn't in the hash will return the same hash and no error is thrown
    h = h - "there_is_no_hash_like_this";

    # h still contains {"pear": 3}
    ```

- `+=` and `-=` work as you would probably expect:
    ```
    some_hash += another_hash;

    # is equivalent to

    some_hash = some_hash + another_hash;
    ```

    ```
    some_hash -= "a_key";

    # is equivalent to

    some_hash = some_hash - "a_key";
    ```

- slicing will return a new hash containing just the specified keys (and their respective values)
    ```
    hash h = {
        "apple": 2,
        "pear": 3,
        "orange": 2,
        "lemon": "none",
    };

    hash nh = h.("apple", "pear");

    # nh now contains {"apple": 2, "pear": 3}
    ```

### Hash with declared value type

The hash type supports two type arguments in angle brackets to specify the key and value data types, however the key
type can only be string currently.

```
hash<string, int> h = {"apple": 11};

h += {"pear": 2};      # this is OK, we can add more string: integer key value pairs
h += {"xyz": 2.1};     # this is not OK, we can't add a float value, it will throw an error
h += {"abc": "5"};     # this is not OK, we can't add a string value, it will throw an error
h += {"x": int("5")};  # this is OK, as we're using an explicit conversion
```

### Type-safe hash (`hashdecl`)

There is also another way to make hashes stricter and more specific. Keyword `hashdecl` allows to specify keys, value
types and default values.

```
hashdecl ResponseHash {
    int code = 200;
    string msg = "OK";
}
```

Now we can create hashes of type `ResponseHash`, the hashes will be automatically populated with given by
the initialization expressions in the `hashdecl` declaration.

```
# immediate value with implicit construction: default values are assigned from the declaration
auto ah1 = hash<ResponseHash>{};

# immediate value with implicit construction: default values are assigned from the declaration
auto ah2 = <ResponseHash>{};

# immediate value with implicit construction: overrides the initial values
auto ah3 = <ResponseHash>{"code": 404, "msg": "Not Found"};

# implicit construction: default values are assigned from the declaration
hash<ResponseHash> h1();

# implicit construction: overrides the initial values
hash<ResponseHash> h2(("code": 500, "msg": "Internal Server Error"));

# "new" construction: default values are assigned from the declaration
hash<ResponseHash> h3 = new hash<ResponseHash>();

# "new" construction: overrides the initial values
hash<ResponseHash> h4 = new hash<ResponseHash>(("code": 301, "msg": "Moved Permanently"));
```

It's not possible to violate the declared type constrains.

```
hashdecl ResponseHash {
    int code = 200;
    string msg = "OK";
}

hash<ResponseHash> h1();

h1{"code"} = "400";         # will throw an error; code has to be an integer, not a string
```

It's not possible to add an unknown key to a type-safe hash.

```
hashdecl ResponseHash {
    int code = 200;
    string msg = "OK";
}

hash<ResponseHash> h1();

h1{"Content-Encoding"} = "gzip";   # will throw an error; key "Content-Encoding" is not supported
```

### `*hash`

Similarly to list and basic data types there is also a data type `*hash` which accepts a hash or `NOTHING`.

---

| [&larr; Go Back to: Variables and data types](../02_variables_data_types/) | [Next: Flow control &rarr;](../04_flow_control/) |
| --- | --- |
