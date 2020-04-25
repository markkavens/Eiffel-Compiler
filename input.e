class PERSON

create
    make

feature   -- Initialization
    
    make (n: STRING)
        -- Create with name 'n'.
        require
            name_exists: not n.is_empty
        do
            set_name (n)
            create known_programming_languages.make (0)
            known_programming_languages.compare_objects
        ensure
            name_set: name = n
        end
        
feature    -- Status
    
    name: STRING
    
    age: INTEGER
    
    known_programming_languages: ARRAYED_LIST [STRING]
    
    personal_code: STRING
    
        -- Personal code of current person.
        do
            Result := name + age.out
        ensure
            personal_code_correct: Result ~ (name + age.out)
        end
        
feature  -- Setters

    set_age  (n: STRING)
    
        -- Set 'name' to 'n'.
        require
            name_exists: not n.is_empty
        do
            name := n
        ensure
            name_set: name = n
        end
        
    set_age  (a: INTEGER)
        -- Set 'age' to 'a'.
        require
            age_acceptable: a >= 0
        do
            age := a
        ensure
            age_set: age = a
        end
        
    add_programming_language  (lang: STRING)
        -- Add 'lang' to 'known_programming_languages'.
        require
            language_unique: not known_programming_languages.has (lang)
        do
            known_programming_languages.extend (lang)
        ensure
            language_added: known_programming_languages.has (lang)
            one_more_language: known_programming_languages.count = old known_programming_languages.count + 1
        end
end
