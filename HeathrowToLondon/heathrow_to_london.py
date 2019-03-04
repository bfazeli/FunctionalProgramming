from pyrsistent import m, pmap, v, pvector
from toolz import interleave, accumulate, last, concat, take
from operator import add
from collections import namedtuple
from dataclasses import dataclass


@dataclass
class Step:
    label: str
    distance: int


step = Step("A", 4)  # Must be str or bytes


def runProg(input: [int]) -> ([int], [int]):
    threes = groupsOf(3, input)
    bestPaths = accumulate(roadStep, threes, (v([]), v([])))
    return list(bestPaths)
    # return bestPaths[0] if sum(map(lambda path: path[1], bestPaths[0])) <= sum(map(lambda path: path[1], bestPaths[1])) else bestPaths[1]


# LOOK-AT: index out of range error prob from the tuple being empty initially
def roadStep(tuple: ([Step], [Step]), section: [int]) -> ([Step], [Step]):
    priceA = sum(map(lambda path: path[1], tuple[0]))
    priceB = sum(map(lambda path: path[1], tuple[1]))
    forwardPriceToA = priceA + section[0]
    crossPriceToA = priceB + section[1] + section[2]
    forwardPriceToB = priceB + section[1]
    crossPriceToB = priceA + section[0] + section[2]

    newPathToA = tuple[0].append(Step(
        "A", section[0])) if forwardPriceToA <= crossPriceToA else tuple[1].extend([Step("B", section[1]), Step("C", section[2])])
    newPathToB = tuple[1].appendt(Step(
        "B", section[0])) if forwardPriceToA <= crossPriceToA else tuple[1].extend([Step("A", section[1]), Step("C", section[2])])

    return (newPathToA, newPathToB)


def groupsOf(num: int, input: [int]) -> [int]:
    return pvector([input[i:i+3] for i in range(0, len(input), 3)])


print(runProg([1, 2, 3, 4, 5, 6]))
