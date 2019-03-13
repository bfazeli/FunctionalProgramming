from typing import TypeVar, operator, Optional
from dataclasses import dataclass
from functools import update_wrapper

# Structured data
Nil = None
first = TypeVar('first')
rest = TypeVar('rest')
MimeMessage = TypeVar('MimeMessage')
Mailbox = TypeVar('Mailbox')
Date = TypeVar('Date')


# This is a WAY to the WAY of building Links
def cons(x: first, xs=Nil) -> (first, rest):
    return (x, xs)


# Time to use the power of A WAY, build the links
oneWord = cons("apple", Nil)
twoWords = cons("banana", cons("cantaloupe", Nil))


# Pop Quiz
mystery1 = cons("pear", Nil)
mystery2 = cons("peach", oneWord)
# mystery3 = cons("pineapple", mystery3)    What's wrong with this in Python?
mystery4 = cons(42, cons("apple", Nil))

# Some functions on List
def dropOne(link: (first, rest)) -> rest:
    return link.rest
# Returns a new list with the first element 
def justOne(link: (first, rest)) -> (first, rest):
    return cons(link[0], Nil) if link[0] else (Nil, Nil)


# The POWER of Optionals!
def pickMessage(n: Optional[int]=None) -> Optional[str]:
    return "Pick a number, like " + str(n) + "." if n else "Pick any number you like." 


# This is BAD
def firstOne(link: (first, rest)) -> first:
    return link[0] if link[0] else "Oh Noes!"
# But, Maybe..., there's a better way
def firstOneP(link: (first, rest)) -> Optional[first]:      
    return link[0] if link[0] else None  # This is where Optional is acting like a maybe, either it has a value or it's None (Heterogenous types)


# Find the first character after a star
def findAfterStar(value: str) -> Optional[chr]:
    valAsList = list(value)
    return findAfterStarP(valAsList)
def findAfterStarP(value: [chr]) -> Optional[chr]:
    if not value:
        return None
    elif value[0] == '*':
        return value[1]
    else:
        return findAfterStarP(value[1:])


# Find the first character after some other character:
def findAfterChar(char: chr, value: str) -> Optional[chr]:
    valAsList = list(value)
    return findAfterCharP(char, valAsList)
def findAfterCharP(char: chr, value: [chr]) -> Optional[chr]:
    if not value:
        return None
    elif value[0] == char:
        return value[1]
    else:
        return findAfterCharP(char, value[1:])
# Find the first character after some other thing
def findAfterElem(elem: first, value: str) -> Optional[chr]:
    valAsList = list(value)
    return findAfterElemP(elem, valAsList)
def findAfterElemP(elem: first, value: [chr]) -> Optional[chr]:
    if not value:
        return None
    elif value[0] == elem:
        return value[1]
    else:
        return findAfterElemP(elem, value[1:])


def getHeader(date: str, message: MimeMessage) -> Optional[str]:
    return None
def parseDate(date: Optional[str]) -> Optional[Date]:
    return None
def mailboxForDate(date: Optional[Date]) -> Optional[Mailbox]:
    return None

# Equivalency of (getHeader "Date" message >>= parseDate >>= mailboxForDate)
def injector(date: str, message: MimeMessage) -> Optional[Mailbox]:
    header = getHeader(date, message)
    if header:
        parsed = parseDate(header)
        if parsed:
            mailbox = mailboxForDate(parsed)
            return mailbox if mailbox else None
        else:
            None
    else:
        None

print(justOne(mystery2))
print(pickMessage())
print(firstOneP(("fire", None)))
print(injector("yeah", "you"))