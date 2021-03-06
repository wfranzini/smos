{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE MultiWayIf #-}
{-# LANGUAGE OverloadedStrings #-}

module Smos.Query.Commands.Projects
  ( smosQueryProjects
  ) where

import Data.Text (Text)

import Conduit
import Rainbow

import Smos.Data

import Smos.Report.Filter
import Smos.Report.Projects
import Smos.Report.Streaming

import Smos.Query.Config
import Smos.Query.Formatting
import Smos.Query.OptParse.Types
import Smos.Query.Streaming

smosQueryProjects :: ProjectsSettings -> Q ()
smosQueryProjects ProjectsSettings {..} = do
  projs <-
    sourceToList $
    streamSmosProjects .| parseSmosFiles .| printShouldPrint PrintWarning .|
    smosMFilter (FilterFst <$> projectsSetFilter)
  liftIO $ putTableLn $ renderProjectsReport $ makeProjectsReport projs

renderProjectsReport :: ProjectsReport -> Table
renderProjectsReport = formatAsTable . map renderProjectEntry . projectsReportEntries

renderProjectEntry :: ProjectEntry -> [Chunk Text]
renderProjectEntry ProjectEntry {..} =
  rootedPathChunk projectEntryFilePath :
  case projectEntryCurrentEntry of
    Nothing -> [chunk "No next action"]
    Just e@Entry {..} -> [mTodoStateChunk $ entryState e, headerChunk entryHeader]
