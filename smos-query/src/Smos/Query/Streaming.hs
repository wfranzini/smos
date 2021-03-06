module Smos.Query.Streaming where

import Conduit

import Smos.Report.Path
import Smos.Report.Streaming

import Smos.Query.Config

streamSmosProjects :: ConduitT i RootedPath Q ()
streamSmosProjects = do
  src <- lift $ asks smosQueryConfigReportConfig
  streamSmosProjectsFiles src

streamSmosFiles :: HideArchive -> ConduitT i RootedPath Q ()
streamSmosFiles ha = do
  src <- lift $ asks smosQueryConfigReportConfig
  streamSmosFilesFromWorkflow ha src

streamAllSmosFiles :: ConduitT i RootedPath Q ()
streamAllSmosFiles = do
  src <- lift $ asks smosQueryConfigReportConfig
  streamSmosFilesFromWorkflow Don'tHideArchive src
