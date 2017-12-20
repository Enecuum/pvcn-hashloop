{-# LANGUAGE ForeignFunctionInterface #-}

import Data.Word
import Foreign.Marshal.Alloc
import Foreign.Marshal.Utils
import qualified Data.ByteString as B
import qualified Data.ByteString.Internal as B
import Foreign.Ptr
import Foreign.Storable
import Foreign.ForeignPtr
import Foreign.C.Types
import Foreign.C.String
import System.Environment


foreign import ccall "pvcn_hashloop_hw" c_pvcn_hashloop_hw :: Ptr CChar -> Int -> Int -> Int -> Ptr CChar -> Ptr CChar -> Ptr Int -> IO ()



main = do
  [arg] <- getArgs
  bs <- B.readFile arg
  let maxfrag = 256
  useAsCStringLen bs $ \(ptr, len) -> do
    frag <- malloc
    hash <- mallocBytes (32*maxfrag)
    c_pvcn_hashloop_hw ptr len maxfrag 0 nullPtr hash frag
    return ()




useAsCStringLen :: B.ByteString -> (CStringLen -> IO a) -> IO a
useAsCStringLen (B.PS fp o l) action =
  allocaBytesAligned (l+1) 128 $ \buf ->
    withForeignPtr fp $ \p -> do
      B.memcpy buf (p `plusPtr` o) (fromIntegral l)
      pokeByteOff buf l (0::Word8)
      action (castPtr buf, l)
