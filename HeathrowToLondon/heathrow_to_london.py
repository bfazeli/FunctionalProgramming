from pyrsistent import m, pmap, v, pvector
from toolz import interleave, accumulate, last, concat, take, drop
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
    bestPaths = last(optimalPath(threes))

    return bestPaths[0] if sum(map(lambda step: step.distance, bestPaths[0])) <= sum(map(lambda step: step.distance, bestPaths[1])) else bestPaths[1]


def optimalPath(threes: [[int]]) -> ([Step], [Step]):
    forwardPriceToA = threes[0][0]
    crossPriceToA = threes[0][1] + threes[0][2]
    forwardPriceToB = threes[0][1]
    crossPriceToB = threes[0][0] + threes[0][2]

    newPathToA = [Step("A", forwardPriceToA)] if forwardPriceToA <= crossPriceToA else [
        Step("B", forwardPriceToB), Step("C", threes[0][2])]
    newPathToB = [Step("B", forwardPriceToB)] if forwardPriceToB <= crossPriceToB else [
        Step("A", forwardPriceToA), Step("C", threes[0][2])]
    accumulator = (pvector(newPathToA), pvector(newPathToB))

    newThrees = drop(1, threes)
    return accumulate(roadStep, newThrees, accumulator)


def getDistance(step: Step) -> int:
    return step.distance


def roadStep(tuple: ([Step], [Step]), section: [int]) -> ([Step], [Step]):

    priceA = sum(map(lambda step: step.distance, tuple[0]))
    priceB = sum(map(lambda step: step.distance, tuple[1]))

    forwardPriceToA = priceA + section[0]
    crossPriceToA = priceB + section[1] + section[2]
    forwardPriceToB = priceB + section[1]
    crossPriceToB = priceA + section[0] + section[2]

    newPathToA = tuple[0].append(Step(
        "A", section[0])) if forwardPriceToA <= crossPriceToA else tuple[1].extend([Step("B", section[1]), Step("C", section[2])])
    newPathToB = tuple[1].append(Step(
        "B", section[1])) if forwardPriceToB <= crossPriceToB else tuple[0].extend([Step("A", section[0]), Step("C", section[2])])

    return (newPathToA, newPathToB)


def groupsOf(num: int, input: [int]) -> [int]:
    return pvector([input[i:i+3] for i in range(0, len(input), 3)])


print(runProg([50, 10, 30, 5, 90, 20, 40, 2, 25, 10, 8, 0]))
