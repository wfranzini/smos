{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}

module Main where

import Criterion.Main as Criterion
import Data.GenValidity.Containers ()
import Data.GenValidity.Criterion
import Data.Map (Map)
import Data.Set (Set)
import Smos.Data
import Smos.Data.Gen ()

main :: IO ()
main =
  Criterion.defaultMain
    [ genValidBench @Header,
      genValidBench @Contents,
      genValidBench @PropertyName,
      genValidBench @PropertyValue,
      genValidBench @TimestampName,
      genValidBench @Timestamp,
      genValidBench @TodoState,
      genValidBench @StateHistoryEntry,
      genValidBench @StateHistory,
      genValidBench @LogbookEntry,
      genValidBench @Logbook,
      genValidBench @Tag,
      genValidBench @(Set Tag),
      genValidBench @(Map TimestampName Timestamp),
      genValidBench @(Map PropertyName PropertyValue),
      genValidBench @Entry,
      genValidBench @(Tree Entry),
      genValidBench @(Forest Entry),
      genValidBench @SmosFile
    ]
