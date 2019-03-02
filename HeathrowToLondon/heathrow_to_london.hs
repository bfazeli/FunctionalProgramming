import Debug.Trace

-- while loop
while:: ([Int], [QuadPaths]) -> (([Int], [QuadPaths]) -> Bool) -> (([Int], [QuadPaths]) -> ([Int], [QuadPaths])) -> (([Int], [QuadPaths]) -> result) -> result
while state shouldContinue action finalAction =
    if shouldContinue state then 
        -- trace("The value of state is: " ++ show state) 
        while (action state) shouldContinue action finalAction
    else 
        trace("The final state is: " ++ show state)
        finalAction state

-- A roadsystem consists of N amount of sections, where each section consists of K amount of steps
data Section = Section { getA :: Int, getB :: Int, getC:: Int } deriving (Show)
type RoadSystem = [Section]

-- label fields for step names, where a and b are horizontal steps and c is the cross step
data Label = A | B | C deriving (Show)
newtype Distance = Distance Int deriving (Show, Ord, Eq)
newtype Path = Path (ShortestStep, Distance, PotentialSteps)
newtype ShortestStep = ShortestStep (Label, Label)
newtype Step = Step (Label, Distance)

newtype PotentialSteps = PotentialSteps [Step] deriving (Show)
newtype QuadPaths = QuadPaths [Path] deriving (Show)


-- instance Show PotentialSteps where
--     show (PotentialSteps steps) = showList steps

-- Handling display of custom types
instance Show Path where
    show (Path (shortestSteps, distance, possibleSteps)) = "\n" ++ show shortestSteps ++ "." ++ show distance ++ "." ++ show possibleSteps
instance Show ShortestStep where
    show (ShortestStep (a, b)) = show a ++ "->" ++ show b
instance Show Step where
    show (Step (label, distance)) = show label ++ "/" ++ show distance

-- Handle addition of custom types if needed
instance Num Distance where
    Distance a + Distance b = Distance(a + b)
    -- p@(Path steps)

-- optimalPaths:: Int -> Int -> Distance
-- optimalPaths input =
--     let result = optimalPaths' $ trace("\noptimalPaths (input):\n" ++ show input) input
--     in trace ("\noptimalPaths (output): " ++ show result ++ "\n") result

-- optimalPaths' input = sort . (\(QuadPaths paths) -> paths) . combinePaths . qpList

-- combinePaths :: [QuadPaths] -> QuadPaths
-- combinePaths (qp : qps) = foldl join qp qps

-- qpList will return an array of QuadPaths
qpList :: [Int] -> [QuadPaths]
qpList input =
    -- | length input - 2 `mod` 3 /= 0 =
    --     [QuadPaths]
    -- | otherwise = 
        while 
            (input, [])
            (\(input, output) -> (not (null input)))
            (\(input, output) -> (drop 3 input, createQuad (take 3 input) : output))
            (reverse . snd)

-- TODO: Implement createQuad
createQuad :: [Int] -> QuadPaths
createQuad input
    | length input >= 3 = 
        QuadPaths [
            Path (ShortestStep(A, A), Distance(head input), 
                PotentialSteps [Step(A, Distance(head input))]
            ),
            Path (ShortestStep(A, B), Distance (head input + head (tail (tail input))), 
                PotentialSteps [Step(A, Distance(head input)), Step(B, Distance(head (tail (tail input))))]
            ),
            Path (ShortestStep(B, A), Distance(head (tail input) + head (tail (tail input))), 
                PotentialSteps [Step(B, Distance(head (tail input))), Step(C, Distance(head (tail (tail input))))]
            ),
            Path (ShortestStep(B, B), Distance(head (tail input)), 
                PotentialSteps [Step(B, Distance(head (tail input)))]
            )
        ]
    | otherwise = 
        QuadPaths [
            Path (ShortestStep(A, A), Distance(head input), 
                PotentialSteps [Step(A, Distance(head input))]
            ),
            Path (ShortestStep(A, B), Distance(head input), 
                PotentialSteps [Step(A, Distance(head input)), Step(C, Distance 0)]
            ),
            Path (ShortestStep(B, A), Distance(head (tail input)), 
                PotentialSteps [Step(B, Distance(head (tail input))), Step(C, Distance 0)]
            ),
            Path (ShortestStep(B, B), Distance(head (tail input)), 
                PotentialSteps [Step(B, Distance(head (tail input)))]
            )
        ]

-- main execution of program
main :: IO()
main = 
    -- print("Calling fibTopDownRec: " ++ show (optimalPaths [50, 10, 30, 5, 90, 20, 40, 2, 25, 10, 8]))
    print("Calling qpList [1, 2, 3]: \n" ++ show (qpList [50, 10, 30, 5, 90, 20, 40, 2, 25, 10, 8]))
