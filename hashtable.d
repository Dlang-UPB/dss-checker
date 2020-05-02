
struct Hashtable
{
    this(size_t initialLength)
    {
        hashtable.length = initialLength;
    }

    size_t idx(string word)
    {
        return hashtable.length ? word.hashOf() % hashtable.length : 0;
    }

    void add(string word, size_t occ = 1)
    {
        int i = find(word);
        if (i == -1)
        {
            hashtable[idx(word)] ~= Pair(word, occ);
        }
        else
        {
            hashtable[idx(word)][i].occ += occ;
        }
    }

    int find(string word)
    {
        size_t idx = idx(word);
        if (!hashtable.length || (hashtable[idx].length == 0)) return -1;

        foreach (i, ref elem; hashtable[idx])
        {
            if (elem.key == word)
            {
                return cast(int) i;
            }
        }
        return -1;
    }

    void remove(string word)
    {
        size_t idx = idx(word);
        int i = find(word);
        if (i == -1) return;

        //import std.stdio;
        foreach(j; i .. hashtable[idx].length - 1)
        {
            //writefln("Word %s i %s len %s", word, i, hashtable[idx].length);
            hashtable[idx][j] = hashtable[idx][(j + 1)];
        }
        //hashtable[idx][i .. ($ - 1)] = hashtable[idx][(i + 1) .. $];
        --hashtable[idx].length;
    }

    size_t get(string word, size_t defaultValue = 0)
    {
        size_t idx = idx(word);
        int i = find(word);
        if (i == -1) return defaultValue;
        return hashtable[idx][i].occ;
    }

    void clear()
    {
        hashtable.length = 0;
    }

    void resize(size_t newSize)
    {
        auto h = new Hashtable(newSize);
        foreach (ref bucket; hashtable)
        {
            foreach (ref elem; bucket)
            {
                h.add(elem.key, elem.occ);
            }
        }
        hashtable = h.hashtable;
    }

    void resizeDouble()
    {
        resize(hashtable.length * 2);
    }

    void resizeHalve()
    {
        resize(hashtable.length / 2);
    }

    string bucketToString(size_t indexBucket)
    {
        import std.conv;

        if (hashtable[indexBucket].length == 0) return "";

        string res;
        foreach(ref elem; hashtable[indexBucket])
        {
            res ~= "<" ~ elem.key ~ ", " ~ to!string(elem.occ) ~ "> ";
        }
        return res;
    }

    string toString()
    {
        string res;
        foreach(i; 0 .. hashtable.length)
        {
            res ~= bucketToString(i);
            res ~= "\n";
        }
        return res;
    }

    static struct Pair
    {
        string key;
        size_t occ;
    }

    size_t length()
    {
        return hashtable.length;
    }

    alias Bucket = Pair[];
    private Bucket[] hashtable;
}
