import Debug.Trace
-- import Data.Map
import Data.List

-- -- while loop
-- while:: state -> (state -> Bool) -> (state -> state) -> (state -> result) -> result
-- while state shouldContinue action finalAction =
--     if shouldContinue state then 
--         -- trace("The value of state is: " ++ show state) 
--         while (action state) shouldContinue action finalAction
--     else 
--         trace("The final state is: " ++ show state)
--         finalAction state

-- -- A roadsystem consists of N amount of sections, where each section consists of K amount of steps
-- data Section = Section { getA :: Int, getB :: Int, getC:: Int } deriving (Show)
-- type RoadSystem = [Section]

-- -- label fields for step names, where a and b are horizontal steps and c is the cross step
-- data Label = A | B | C deriving (Show, Eq)
-- newtype Distance = Distance Int deriving (Show, Ord, Eq)
-- newtype Path = Path (ShortestStep, Distance, PotentialSteps)
-- newtype ShortestStep = ShortestStep (Label, Label)
-- newtype Step = Step (Label, Distance) deriving (Ord, Eq)

-- newtype PotentialSteps = PotentialSteps [Step] deriving (Show)
-- newtype QuadPaths = QuadPaths [Path] deriving (Show)

-- fromStepToTuple (Step lbl val) = (lbl, val)
-- -- instance Show PotentialSteps where
-- --     show (PotentialSteps steps) = showList steps

-- -- Handling display of custom types
-- instance Show Path where
--     show (Path (shortestSteps, distance, possibleSteps)) = "\n" ++ show shortestSteps ++ "." ++ show distance ++ "." ++ show possibleSteps
-- instance Show ShortestStep where
--     show (ShortestStep (a, b)) = show a ++ "->" ++ show b
-- instance Show Step where
--     show (Step (label, distance)) = show label ++ "/" ++ show distance

-- -- Handle addition of custom types if needed
-- instance Num Distance where
--     Distance a + Distance b = Distance(a + b)
--     -- p@(Path steps)

-- optimalPaths:: Int -> Int -> Distance
-- optimalPaths input =
--     let result = optimalPaths' $ trace("\noptimalPaths (input):\n" ++ show input) input
--     in trace ("\noptimalPaths (output): " ++ show result ++ "\n") result

-- optimalPaths' input = sort . (\(QuadPaths paths) -> paths) . combinePaths . qpList

-- combinePaths :: [QuadPaths] -> QuadPaths
-- combinePaths (qp : qps) = foldl join qp qps

-- join :: QuadPaths -> QuadPaths -> QuadPaths
-- join qp1 qp2 =
--     let 
--         mapQp1 = fromList[(A, Step(A, Distance 0)), (B, Step(B, Distance 0)), (C, Step(C, Distance 0))]
--         mapQp2 = fromList[(A, Step(A, Distance 0)), (B, Step(B, Distance 0)), (C, Step(C, Distance 0))]
--     in 
--     -- -- The tuple (0, 0, 0) is (A, B, C) 
--     buildPaths . buildMap (qp1, qp2, (0, 0, 0), lastCross qp1)
    

-- -- 


-- -- Come back to this
-- -- Takes the second qp2 and gets the unique elements
-- uniqueElements input =
--     while
--         (input, [])
--         (\(input, _) -> not . null . qp2)
--         (\(input, accum) -> (tail input, head (reverse (head qp2) ++ qp2)))
--         nub . snd

        
        

-- -- processPath :: state -> state
-- -- processPath state = 
-- --     while 
-- --         (qp1, qp2, mapQp1, mapQp2, [])
-- --         (\(input, _) -> (not (null input)))
-- --         buildNewPath . processPath
-- --         (\(input, output) -> (drop 3 input, createQuad (take 3 input) : output))
-- --         (reverse . snd)

-- -- -- (qp1, qp2, mapQp1, mapQ2, lastCross)

-- -- mapPath state
-- --     | \(_, _, _, _, lastCross) -> lastCross > -1 =
-- --         \(qp1, qp2, mapQp1, mapQp2, lastCross) -> (qp1, qp2, _, updateMap qp2 mapQ2, M.loopkup C mapQp1)

-- -- buildMap input mapQ2 = 
-- --     while
-- --         (head (reverse (head qp2)), mapQ2)
-- --         (not . (null . fst))
-- --         (\(input, mapQ2) -> (tail input, mapQ2.insert C (head input))


-- -- qpList will return an array of QuadPaths
-- qpList :: [Int] -> [QuadPaths]
-- qpList input =
--     -- | length input - 2 `mod` 3 /= 0 =
--     --     [QuadPaths]
--     -- | otherwise = 
--         while 
--             (input, [])
--             (\(input, output) -> (not (null input)))
--             (\(input, output) -> (drop 3 input, createQuad (take 3 input) : output))
--             (reverse . snd)

-- -- TODO: Implement createQuad
-- createQuad :: [Int] -> QuadPaths
-- createQuad input
--     | length input >= 3 = 
--         QuadPaths [
--             Path (ShortestStep(A, A), Distance(head input), 
--                 PotentialSteps [Step(A, Distance(head input))]
--             ),
--             Path (ShortestStep(A, B), Distance (head input + head (tail (tail input))), 
--                 PotentialSteps [Step(A, Distance(head input)), Step(B, Distance(head (tail (tail input))))]
--             ),
--             Path (ShortestStep(B, A), Distance(head (tail input) + head (tail (tail input))), 
--                 PotentialSteps [Step(B, Distance(head (tail input))), Step(C, Distance(head (tail (tail input))))]
--             ),
--             Path (ShortestStep(B, B), Distance(head (tail input)), 
--                 PotentialSteps [Step(B, Distance(head (tail input)))]
--             )
--         ]
--     | otherwise = 
--         QuadPaths [
--             Path (ShortestStep(A, A), Distance(head input), 
--                 PotentialSteps [Step(A, Distance(head input))]
--             ),
--             Path (ShortestStep(A, B), Distance(head input), 
--                 PotentialSteps [Step(A, Distance(head input)), Step(C, Distance 0)]
--             ),
--             Path (ShortestStep(B, A), Distance(head (tail input)), 
--                 PotentialSteps [Step(B, Distance(head (tail input))), Step(C, Distance 0)]
--             ),
--             Path (ShortestStep(B, B), Distance(head (tail input)), 
--                 PotentialSteps [Step(B, Distance(head (tail input)))]
--             )
--         ]

-- -- main execution of program
-- main :: IO()
-- main = 
--     -- print("Calling fibTopDownRec: " ++ show (optimalPaths [50, 10, 30, 5, 90, 20, 40, 2, 25, 10, 8]))
--     print("Calling qpList [1, 2, 3]: \n" ++ show (qpList [50, 10, 30, 5, 90, 20, 40, 2, 25, 10, 8]))

data Section = Section { getA :: Int, getB :: Int, getC :: Int } deriving (Show)  
type RoadSystem = [Section]


data Label = A | B | C deriving (Show)  
type Path = [(Label, Int)]  

-- heathrowToLondon :: RoadSystem  
-- heathrowToLondon = [Section 50 10 30, Section 5 90 20, Section 40 2 25, Section 10 8 0]  

roadStep :: (Path, Path) -> Section -> (Path, Path)  
roadStep (pathA, pathB) (Section a b c) =   
    let priceA = sum $ map snd pathA  
        priceB = sum $ map snd pathB  
        forwardPriceToA = priceA + a  
        crossPriceToA = priceB + b + c  
        forwardPriceToB = priceB + b  
        crossPriceToB = priceA + a + c  
        newPathToA = if forwardPriceToA <= crossPriceToA  
                        then (A,a):pathA  
                        else (C,c):(B,b):pathB  
        newPathToB = if forwardPriceToB <= crossPriceToB  
                        then (B,b):pathB  
                        else (C,c):(A,a):pathA  
    in  (newPathToA, newPathToB)  


optimalPath :: RoadSystem -> Path  
optimalPath roadSystem = 
    let (bestAPath, bestBPath) = foldl roadStep ([],[]) roadSystem  
    in  if sum (map snd bestAPath) <= sum (map snd bestBPath)  
            then reverse bestAPath  
            else reverse bestBPath  

groupsOf :: Int -> [a] -> [[a]]  
groupsOf 0 _ = undefined  
groupsOf _ [] = []  
groupsOf n xs = take n xs : groupsOf n (drop n xs) 


runProg input =
    let 
        threes = groupsOf 3 input
        roadSystem = map (\[a,b,c] -> Section a b c) threes  
        path = optimalPath roadSystem  
        -- pathString = concatMap (show . fst) path  
        -- pathPrice = sum $ map snd path
    in 
        show (optimalPath roadSystem, sum $ map snd path)

-- main execution of program
main :: IO()
main =
    -- groupsOf(3 [50, 10, 30, 5, 90, 20, 40, 2, 25, 10, 8])
    print("Finding optimal path: " ++ runProg [50, 10, 30, 5, 90, 20, 40, 2, 25, 10, 8, 0])
    -- print("Calling qpList [1, 2, 3]: \n" ++ show (qpList [50, 10, 30, 5, 90, 20, 40, 2, 25, 10, 8]))g