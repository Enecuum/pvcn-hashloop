
import Data.Maybe
import Data.Either
import Data.List
import Debug.Trace

main = do
  a <- getContents
  let b = lines a
  let f = process []
  let c = head $ dropWhileDiff $ iterate f b
  putStr $ unlines c

dropWhileDiff o@(a:b:c) = if a /= b then dropWhileDiff (b:c) else o

{-
trc a = trace ("TRACE: " ++ a) a
trc4 o@(Left x:xs) = trace ("TRACE4: " ++ show (take 3 (filter isRight o), length o)) o
trc4 o@(Right x:xs) = trace ("TRACE4: " ++ show (take 3 (filter isRight o), length o)) o
trc4 a = trace ("TRACE4: " ++ (show a)) a
trc3 a = trace ("TRACE3: " ++ (show a)) a
-}

trc2 a = trace ("TRACE2: " ++ a) a
trc5 a = trace ("TRACE2: " ++ show a) a
trc = id
-- trc2 = id
trc4 = id
trc3 = id

correctIndent n m a | len > n = drop (len-n) b ++ c
                    | otherwise = replicate (n-len) ' ' ++ b ++ c
 where
  (b,c) = span (==' ') a
  len = m

getMinIndent x = foldr1 min $ map indent x
 where
  indent x = let (b,c) = span (==' ') x in length b

process :: [Either (String,[String]) (String,[String])] -> [String] -> [String]
process _ [] = []
process state (x:xs) | not $ null a = x : process (addRec ( Left (b,[]) : state )) xs
                     | not $ null c = x : process (addRec ( Right foundA : deletedA )) xs
                     | not $ null d =  []
                                       ++ [replicate indent ' ' ++ "// INSERT REGION " ++ regName]
                                       ++ tail ( reverse (map (correctIndent indent (getMinIndent foundB)) foundB))
                                       ++ [replicate indent ' ' ++ "// REGION " ++ regName ++ " INSERTED"]
                                       ++ process (addRec state) xs
                     | otherwise = x : process (addRec state) xs
                     -- | otherwise = x : process (trc4 (map (\(a,b) -> Left (a,x:b)) lefts ++ map Right rights)) xs
 where
  addRec state = (map (\(a,b) -> Left (a,x:b)) lefts ++ map Right rights)
    where
      lefts = map fromLeft $ filter isLeft state
      rights = map fromRight $ filter isRight state
  foundA :: (String,[String])
  foundA = (snd $ head c, fromJust1 $ lookup (snd $ head c) lefts)
  foundB = fromJust $ lookup (snd $ head d) (rights)
  regName = snd $ head d
  indent = fst $ fst $ head d
  deletedA :: [Either (String,[String]) (String,[String])]
  deletedA = delete (Left foundA) state
  lefts = map fromLeft $ filter isLeft state
  rights = map fromRight $ filter isRight state
  filt = filter $ \((n,a),b) -> (not $ null a) && (not $ null b)
  ((n,a),b) = let (a,b) = splitString 0 "// MACRO REGION " x in (a,tail b)
  c = filt $ splitString 0 $ "// MACRO REMEMBER REGION " ++ getRegions x
  d = filt $ splitString 0 $ "// MACRO INSERT REGION "   ++ getRegionsB x
  getRegions = map fst lefts
  getRegionsB = map fst rights

fromJust1 (Just a) = a

splitString :: Int -> String -> String -> ((Int,String),String)
splitString _ _ [] = ((0,[]),[])
splitString n pat o@(x:xs) | a == pat = trc5 ((n,pat),drop (len-1) o)
                           | otherwise = splitString (n+1) pat xs
 where
  a = subString o pat
  b = a == pat
  len = length pat

subString [] _ = []
subString _ [] = []
subString (x:xs) (y:ys) = if (x == y) then x : subString xs ys else []

fromLeft (Left a) = a
fromRight (Right a) = a

