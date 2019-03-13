-- Adds a new Link to the beginning of the list, or it could be the endOfLit 
data List α = EndOfList | Link α (List α)

-- Creates an empty list
empty = EndOfList
-- Creates a list with one elem
oneWord = Link "apple" EndOfList
-- Creates a list of two elems
twoWords = Link "banana" (Link "cantaloupe" EndOfList)

-- Creates a list with one elem
mystery1 = Link "pear" empty
-- Links peach to the begining of the oneWord list
mystery2 = Link "peach" oneWord

-- Creates an infini list of pineapples 
    -- Haskell can do this b/c it's lazy
    -- The list is not evaluated unless it needs to be
mystery3 = Link "pineapple" mystery3

-- Comp Error raised for heterogenous list type
mystery4 = Link 42 (Link "apple" EndOfList)


-- Pattern matches on a list, if it's the endoflist, just return endoflist
    -- otherwise just the rest of the list is returned.
dropOne :: List α -> List α
dropOne (Link first rest) = rest
dropOne EndOfList = EndOfList

-- Pattern match on a list, if it's the endoflist, just return endoflist
    -- otherwise just return the first elem of the list as a new list
justOne :: List α -> List α
justOne (Link a _) = Link a EndOfList
justOne EndOfList = EndOfList


---------- Standard way of doing it --------------
-- data [] a = [] | a : [a] -- this is in the standard library
-- infixr 5 :
-- empty = []
-- oneWord = "apple" : []
-- twoWords = "banana" : "cantaloupe" : []

-- mystery1 = "pear" : empty
-- mystery2 = "peach" : oneWord
-- mystery3 = "pineapple" : mystery3
-- mystery4 = 42 : "apple" : []

-- dropOne :: [a] -> [a]
-- dropOne (first:rest) = rest
-- dropOne [] = []

-- justOne :: [a] -> [a]
-- justOne (a:_) = a:[]
-- justOne [] = []

-- data [] a = [] | a : [a] -- this is in the standard library
-- infixr 5 :

-- empty = []
-- oneWord = ["apple"]                 -- syntatic sugar
-- twoWords = ["banana", "cantaloupe"] -- two teaspoons full

-- mystery1 = "pear" : empty
-- mystery2 = "peach" : oneWord
-- mystery3 = "pineapple" : mystery3
-- mystery4 = [42, "apple"] -- sweet, but still won't compile

-- dropOne :: [a] -> [a]
-- dropOne (first:rest) = rest
-- dropOne [] = []

-- justOne :: [a] -> [a] -- don't confuse these "[a]"s
-- justOne (a:_) = [a]   -- with this "[a]"
-- justOne [] = []

-- How a string is rep in haskell
type String = [Char]
-- The idea behind maybe, either there is a value in which case it's 'Just a'
    -- Or there's nothing in which case it's 'Nothing'
data Maybe a = Nothing | Just a

-- Pattern match on the val of Maybe and exec approp fnx
pickMessage :: Maybe Int -> String
pickMessage (Just n) = "Pick a number, like " ++ show n ++ "."
pickMessage Nothing = "Pick any number you like."

-- This is meh
    -- idea is to return just first elem of a list as a new list
    -- or an empty list if the list passed in is empty
justOne :: [a] -> [a]
justOne (a:_) = [a]
justOne [] = []

-- THIS IS BAD B/C  REASONS
    -- Idea of fnx is to return the first elem in a list
    -- Returning error if a list is empty shouldn't happen
firstOne :: [a] -> a
firstOne (a:_) = a
firstOne [] = error "O Noes!"

-- Returns Just the first elem in a list if the list isn't empty
    -- Otherwise, returns nothing
firstOne' :: [a] -> Maybe a
firstOne' (a:_) = Just a
firstOne' [] = Nothing


-- Recursively finds the first char after a *
    -- A String is [char] so can access and sep first elems w/ : op
        -- where r is the rest of the rest
findAfterStar :: String -> Maybe Char
findAfterStar (c:d:r) =
  if c == '*' then Just d
              else findAfterStar (d:r)
findAfterStar _ = Nothing

-- Recursively finds the first char afer some other char
    -- Similar to findAfterStar but now we pass in a char m
findAfterChar :: Char -> String -> Maybe Char
findAfterChar m (c:d:r) =
  if c == m then Just d
            else findAfterChar m (d:r)
findAfterChar _ _ = Nothing


-- Finds the first thing after a match
    -- Similar to findAfterElem
        -- Key diff is finding any elem that conforms to Eq
        -- Here char and the list are of same type of Any (a)
findAfterElem :: Eq a => a -> [a] -> Maybe a
findAfterElem m (c:d:r) =
  if c == m then Just d
            else findAfterElem m (d:r)
findAfterElem _ _ = Nothing


-- Injects the value of a previous fnx, short circuiting if Nothing is found
getHeader "Date" message >>= parseDate >>= mailboxForDate

getHeader :: String -> MimeMessage -> Maybe String

parseDate :: String -> Maybe Date

mailboxForDate :: Date -> Maybe Mailbox
