import Debug.Trace

-- while loop
while:: state -> (state -> Bool) -> (state -> state) -> (state -> result) -> result
while state shouldContinue action finalAction =
    if shouldContinue state then while (action state) shouldContinue action finalAction
    else finalAction state

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
    show (Path (shortestSteps, distance, possibleSteps)) = show shortestSteps ++ "." ++ "Dist: " ++ show distance ++ "." ++ show possibleSteps
instance Show ShortestStep where
    show (ShortestStep (a, b)) = show a ++ "->" ++ show b
instance Show Step where
    show (Step (label, distance)) = show label ++ "/" ++ show distance

-- Handle addition of custom types if needed
instance Num Distance where
    Distance a + Distance b = Distance(a + b)
    -- p@(Path steps)

optimalPaths:: Int -> Int -> Distance
optimalPaths input =
    let result = optimalPaths' $ trace("\noptimalPaths (input):\n" ++ show input) input
    in trace ("\noptimalPaths (output): " ++ show result ++ "\n") result

optimalPaths' input = sort . (\(QuadPaths paths) -> paths) . combinePaths . qpList

combinePaths :: [QuadPaths] -> QuadPaths
combinePaths (qp : qps) = foldl join qp qps

-- qpList will return an array of QuadPaths
qpList :: [Int] -> [QuadPaths]
qpList input = 
    while 
        (input, [])
        (not . null (tail(tail . fst)))
        (\(input, output) -> (drop 3 input, output + createQuad (take 3 input)))
        (\(input, output) -> (output + createQuad (take 2 input)))

-- TODO: Implement createQuad

-- main execution of program
main :: IO()
main = 
    print("Calling fibTopDownRec: " ++ show (optimalPaths [50, 10, 30, 5, 90, 20, 40, 2, 25, 10, 8]))