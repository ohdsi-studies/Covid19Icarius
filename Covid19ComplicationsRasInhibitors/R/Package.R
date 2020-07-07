# @file Package.R
#
# Copyright 2019 Observational Health Data Sciences and Informatics
#
# This file is part of Covid19ComplicationsRasInhibitors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#' Covid19ComplicationsRasInhibitors
#' 
#' An OHDSI R package to compare the relative risk of COVID-19 outcomes for RAS inhibitor users
#'
#' @docType package
#' @name Covid19ComplicationsRasInhibitors
#' @importFrom stats aggregate density pnorm qnorm quantile
#' @importFrom utils read.csv write.csv install.packages menu setTxtProgressBar txtProgressBar write.table
#' @import DatabaseConnector
#' @importFrom dplyr pull collect bind_rows group_by summarise ungroup `%>%`
#' @importFrom rlang .data
#' 
NULL
