import hashtable;

version(TEST1)
{
    unittest
    {
        auto h = new Hashtable(20);
        assert(h.length == 20);
    }
}

version(TEST2)
{
    unittest
    {
        auto h = new Hashtable(10);
        assert(h.length == 10);

        h.add("test");
        h.add("test");
        h.add("test2");
        assert(h.get("test") == 2);
        assert(h.get("test2") == 1);
        assert(h.get("nope") == 0);
        assert(h.get("nope", -1) == -1);
    }
}

version(TEST3)
{
    unittest
    {
        import std.conv;

        auto h = new Hashtable(10);
        assert(h.length == 10);

        foreach (i; 0 .. 100)
        {
            h.add("test" ~ to!string(i));
        }
        foreach (i; 0 .. 100)
        {
            assert(h.get("test" ~ to!string(i)) == 1);
        }
        foreach (i; 0 .. 15)
        {
            h.add("test" ~ to!string(i));
            assert(h.get("test" ~ to!string(i)) == 2);
        }
        foreach (i; 0 .. 50)
        {
            h.remove("test" ~ to!string(2 * i));
            assert(h.get("test" ~ to!string(2 * i)) == 0);
        }
        h.clear();
        //assert(h.length == 0);
        assert(h.get("test91") == 0);
        //h.add("test");
        //assert(h.get("test") == 1);
    }
}

version(TEST4)
{
    unittest
    {
        import std.conv;

        auto h = new Hashtable(21);
        assert(h.length == 21);
        foreach (i; 0 .. 10)
        {
            h.add("test" ~ to!string(i));
        }
        foreach (i; 0 .. 10)
        {
            assert(h.get("test" ~ to!string(i)) == 1);
        }

        h.resizeDouble();
        assert(h.length == 42);
        foreach (i; 0 .. 10)
        {
            assert(h.get("test" ~ to!string(i)) == 1);
        }
        h.add("test9");
        assert(h.get("test9") == 2);

        h.resizeHalve();
        assert(h.length == 21);
        foreach (i; 0 .. 9)
        {
            assert(h.get("test" ~ to!string(i)) == 1);
        }
        h.add("test9");
        assert(h.get("test9") == 3);
    }
}

version(TEST5)
{
    unittest
    {
        import std.conv;
        import std.string;
        import std.format : format;

        auto h = new Hashtable(1);
        assert(h.length == 1);
        foreach (i; 0 .. 10)
        {
            h.add("test" ~ to!string(i));
        }
        string expected;
        foreach (i; 0 .. 10)
        {
            assert(h.get("test" ~ to!string(i)) == 1);
            expected ~= "<test" ~ to!string(i) ~ ", 1> ";
        }
        assert(strip(h.toString()) == strip(expected),
               format!"[Hashtable.toString] Expected:\n%s\nGot:\n%s"(strip(expected), strip(h.toString())));

        h.resizeDouble();
        assert(h.length == 2);
        expected = "<test0, 1> <test1, 1> <test5, 1> <test7, 1>";
        assert(strip(h.bucketToString(0)) == expected,
               format!"[Hashtable.bucketToString] Expected:\n%s\nGot:\n%s"(expected, strip(h.bucketToString(0))));
        h.resizeHalve();
        assert(h.length == 1);
        expected = "<test0, 1> <test1, 1> <test5, 1> <test7, 1> <test2, 1> <test3, 1> <test4, 1> <test6, 1> <test8, 1> <test9, 1>";
        assert(strip(h.toString()) == expected,
               format!"[Hashtable.toString] Expected:\n%s\nGot:\n%s"(expected, strip(h.toString())));
    }
}
