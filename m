From: Ian Rogers <irogers@google.com>
Subject: [RFC PATCH 06/12] perf topdown-parser: Interface for TMA_Metrics.csv.
Date: Tue, 10 Nov 2020 02:03:40 -0800
Message-ID: <20201110100346.2527031-7-irogers@google.com>
References: <20201110100346.2527031-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
In-Reply-To: <20201110100346.2527031-1-irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, John Garry <john.garry@huawei.com>, Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>
Cc: Stephane Eranian <eranian@google.com>, Sandeep Dasgupta <sdasgup@google.com>, linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sandeep Dasgupta <sdasgup@google.com>

Reads the CSV file then creates an in memory model from the data.

Co-authored-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Sandeep Dasgupta <sdasgup@google.com>
---
 .../topdown-parser/dependence_dag_utils.cpp   | 984 ++++++++++++++++++
 .../topdown-parser/dependence_dag_utils.h     | 178 ++++
 2 files changed, 1162 insertions(+)
 create mode 100644 tools/perf/pmu-events/topdown-parser/dependence_dag_utils.cpp
 create mode 100644 tools/perf/pmu-events/topdown-parser/dependence_dag_utils.h

diff --git a/tools/perf/pmu-events/topdown-parser/dependence_dag_utils.cpp b/tools/perf/pmu-events/topdown-parser/dependence_dag_utils.cpp
new file mode 100644
index 000000000000..7c9eff06e2a9
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/dependence_dag_utils.cpp
@@ -0,0 +1,984 @@
+/*
+ * Copyright 2020 Google LLC.
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include "dependence_dag_utils.h"
+
+#include <cassert>
+#include <fstream>
+#include <regex>
+
+#include "configuration.h"
+#include "general_utils.h"
+#include "logging.h"
+
+namespace topdown_parser
+{
+char g_PerfmonVersion[VERSION_MAX_STRLEN];
+
+std::map<std::string, TopdownInfo> *g_TopdownHierarchy = nullptr;
+
+std::vector<std::string> *g_RelevantCpus = nullptr;
+
+std::vector<std::set<std::string> > *g_CpuAliasesForEventInfo = nullptr;
+
+namespace
+{
+/**
+ * Column number in the input csv file specifying 'Count Domain'
+ */
+size_t g_CountDomainColm = UINT_MAX;
+
+/**
+ * Column number in the input csv file specifying 'Metric Group'
+ */
+size_t g_MetricGroupColm = UINT_MAX;
+
+/**
+ * Column number in the input csv file specifying 'Description'
+ */
+size_t g_DescColm = UINT_MAX;
+
+/**
+ * header_rowKey is used to derive the row number of the header. The
+ * header of the input csv file specifies the information like level
+ * numbers, CPU product names, Metric Description etc.  A typical header
+ * row looks like: Key | Level1 | Level2 | SKX SKL | Count | Domain
+ * Metric Description |  ...
+ */
+const char *header_rowKey = "level[0-9]+";
+
+/**
+ * formula_start_colm_Key is used to derive the first column number
+ * specifying a formula.
+ */
+const char *formula_start_colm_Key = "level[0-9]+";
+
+/**
+ * formula_end_colm_Key is used to derive the last column number
+ * specifying a formula.
+ */
+const char *formula_end_colm_Key = "locate-with";
+
+/**
+ * g_CountDomainColmKey is used to derive column number in the input csv
+ * file specifying 'Count Domain'.
+ */
+const char *g_CountDomainColmKey = "count";
+
+/**
+ * g_DescColmKey is used to derive column number in the input csv file
+ * specifying 'Description'.
+ */
+const char *g_DescColmKey = "description";
+
+/**
+ * g_MetricGroupColmKey is used to derive column number in the input csv
+ * file specifying 'Metric Group'.
+ */
+const char *g_MetricGroupColmKey = "group";
+
+/**
+ * Last row number in the input csv file specifying topdown levels
+ */
+size_t g_LevelEndRow = UINT_MAX;
+
+/**
+ * g_LevelEndRowKey is used to derive the last row number in the input
+ * csv file specifying topdown levels.
+ */
+const char *g_LevelEndRowKey = "\\.";
+
+/**
+ * First and last column numbers in the input csv file specifying
+ * topdown levels.
+ */
+size_t g_LevelStartColm = UINT_MAX;
+size_t g_LevelEndColm = UINT_MAX;
+
+/**
+ * Initialize globals.
+ */
+void InitGlobals()
+{
+	if (g_TopdownHierarchy == nullptr) {
+		g_TopdownHierarchy = new std::map<std::string, TopdownInfo>;
+	}
+
+	if (g_RelevantCpus == nullptr) {
+		g_RelevantCpus = new std::vector<std::string>;
+	}
+
+	if (g_CpuAliasesForEventInfo == nullptr) {
+		g_CpuAliasesForEventInfo =
+			new std::vector<std::set<std::string> >;
+	}
+}
+
+/**
+ * Plot the topdown hierarchy in graphviz dot.
+ */
+void PlotTopdownHierarchy(
+	const std::map<std::string, TopdownInfo> &g_TopdownHierarchy)
+{
+	std::string topdown_hierarchy_dot =
+		kConfigParams->output_path_ + "topdown_hierarchy.dot";
+	std::ofstream ofile_dot(topdown_hierarchy_dot);
+	if (!ofile_dot.is_open()) {
+		ERROR("Error opening file: " << topdown_hierarchy_dot);
+		exit(1);
+	}
+
+	INFO("Generating topdown hierarchy file: " << topdown_hierarchy_dot);
+
+	ofile_dot << "digraph graphname {\n";
+	int toggle = 0;
+	std::string color = "[color=blue]";
+	for (auto &p : g_TopdownHierarchy) {
+		auto metric_name = std::string("\"") + p.first + "\"";
+
+		if (toggle == 0) {
+			color = "[color=blue]";
+		} else {
+			color = "[color=red]";
+		}
+
+		for (size_t i = 0; i < p.second.child_metrics.size() - 1; ++i) {
+			ofile_dot << metric_name << " -> "
+				  << "\"" << p.second.child_metrics[i] << "\" "
+				  << color << std::endl;
+		}
+		ofile_dot
+			<< metric_name << "->"
+			<< "\""
+			<< p.second.child_metrics[p.second.child_metrics.size() -
+						  1]
+			<< "\" " << color << std::endl;
+		toggle = toggle ^ 1;
+	}
+	ofile_dot << "}\n";
+
+	ofile_dot.close();
+}
+
+/**
+ * GetTopdownHierarchy derives the topdown hierarchy
+ * from the csv file.
+ * The hierarchy looks like
+ *
+ *            g_LevelStartColm     g_LevelEndColm
+ *                    |                 |
+ *                    V                 V
+ * header_row     | Level1 | Level2 | Level3 |
+ * header_row + 1 |   A    |        |        |
+ *                |        |  B     |        |
+ *                |        |        |   C    |
+ *                |        |  G     |        |
+ *                |        |  D     |        |
+ *                |        |        |   E    |
+ * g_LevelEndRow  |        |        |   F    |
+ *
+ * The function returns:
+ *   g_TopdownHierarchy["Topdown"] --> {"<perf-stat-switch-name>", {"A"}}
+ *   g_TopdownHierarchy["A"] -->    {"<perf-stat-switch-name>", {"B", "G", "D"}}
+ *   g_TopdownHierarchy["B"] -->       {"<perf-stat-switch-name>", {"C"}}
+ *   g_TopdownHierarchy["G"] -->       {"<perf-stat-switch-name>", {"E", "F"}}
+ *
+ * <perf-stat-switch-name> for a metric is the name of the switch which
+ * will be used invoke perf stat on that metric. These names are
+ * provided by a configuration parameters perf_stat_switch_names_ for
+ * each parent metric.
+ */
+void GetTopdownHierarchy(const std::vector<std::vector<std::string> > &records)
+{
+	assert((UINT_MAX != kConfigParams->header_row &&
+		UINT_MAX != g_LevelEndRow && UINT_MAX != g_LevelStartColm &&
+		UINT_MAX != g_LevelEndColm) &&
+	       "Cannot find topdown hierarchy");
+
+	std::string last_parent("");
+	for (size_t level = g_LevelStartColm; level <= g_LevelEndColm;
+	     level++) {
+		for (size_t i = kConfigParams->header_row + 1;
+		     i <= g_LevelEndRow; ++i) {
+			if (records[i][level].empty() &&
+			    records[i][level - 1].empty()) {
+				continue;
+			}
+
+			// All the metrics in the first level becomes
+			// the sub-metrics of "topdown" metric.
+			if (g_LevelStartColm == level) {
+				if (!records[i][level].empty()) {
+					(*g_TopdownHierarchy)[std::string(
+								      "topdown")]
+						.child_metrics.push_back(
+							records[i][level]);
+				}
+				continue;
+			}
+
+			// For the case
+			//  Level1 | Level2 | Level3 |
+			//    A    |        |        |
+			// We register the parent metric "A"
+			if (records[i][level].empty() &&
+			    !records[i][level - 1].empty()) {
+				last_parent = records[i][level - 1];
+				continue;
+			}
+
+			// For the case
+			//  Level1 | Level2 | Level3 |
+			//         |  B     |        |
+			// We make "B" the sub-metric of the registered
+			// parent metric "A".
+			if (!records[i][level].empty() &&
+			    records[i][level - 1].empty()) {
+				(*g_TopdownHierarchy)[last_parent]
+					.child_metrics.push_back(
+						records[i][level]);
+				continue;
+			}
+		}
+	}
+
+	// Assign a perf stat switch names to parent metrics. The perf
+	// stat switch names are provided by configuration parameter and
+	// used while invoking perf stat command.
+	for (auto &p : *g_TopdownHierarchy) {
+		if (kConfigParams->perf_stat_switch_names_.count(p.first) !=
+		    0) {
+			p.second.perf_stat_switch_name =
+				kConfigParams->perf_stat_switch_names_.at(
+					p.first);
+		}
+		// For some targets, like perf_public,
+		// perf_stat_switch_names_ will not be available.
+	}
+}
+
+/**
+ * GetPerfmonVersion extracts the version number from the
+ * input csv file. The number is extracted as follows:
+ * 1. Find the column in the first row of input csv file having a regex
+ *    match with keyword "version"
+ * 2. The version number is typically specified in the very next column
+ *    of the same row.
+ */
+void GetPerfmonVersion(const std::vector<std::vector<std::string> > &records)
+{
+	std::regex r("version", std::regex_constants::icase);
+	std::string retval;
+
+	for (size_t j = 0; j < records[0].size(); j++) {
+		if (regex_match(records[0][j], r)) {
+			retval = (j + 1 < records[0].size()) ?
+					       records[0][j + 1] :
+					       "";
+			strncpy(g_PerfmonVersion, retval.c_str(),
+				sizeof(g_PerfmonVersion));
+			return;
+		}
+	}
+
+	strncpy(g_PerfmonVersion, "", sizeof(g_PerfmonVersion));
+}
+
+/**
+ * Determine the level end row. Level end row is defined as the
+ * last row number in the input csv file specifying a topdown
+ * level. Typically it is marked in the csv file with a 'dot'.
+ */
+size_t GetLevelEndRow(const std::vector<std::vector<std::string> > &records)
+{
+	std::regex r(g_LevelEndRowKey, std::regex_constants::icase);
+	for (size_t i = kConfigParams->header_row + 1; i < records.size();
+	     ++i) {
+		if (regex_search(records[i][0], r)) {
+			return i - 1;
+		}
+	}
+
+	ERROR("Failed to derive the level end row using level end row"
+	      " key: "
+	      << g_LevelEndRowKey);
+	INFO("Level end row not found. update the 'g_LevelEndRowKey' in"
+	     " dependence_dag_utils.cc");
+	exit(1);
+
+	return UINT_MAX;
+}
+
+/**
+ * The function determines the row number of input csv file which
+ * specifies if a CPU product is a client or server. It is typically the
+ * row above the header row.
+ */
+size_t GetServerIdentifierRow()
+{
+	if (UINT_MAX != kConfigParams->server_identifier_row_) {
+		return kConfigParams->server_identifier_row_;
+	}
+
+	return kConfigParams->header_row - 1;
+}
+
+/**
+ * Determine the last column letter in the input csv file specifying
+ * topdown levels. It is derived as the column before the one which
+ * starts specifying formulas.
+ *
+ * A typical header row looks like:
+ * Key | Level1 | Level2 | Level3 | SKX | SKL | ...
+ * The function return the column number for Level3.
+ *
+ * In case the kConfigParams->first_last_ is provided, which specifies
+ * the last level number, then the function returns the column number
+ * corresponding to that level. For example, if
+ * kConfigParams->first_last_ == 2, then the function returns the column
+ * number for Level2.
+ */
+size_t GetLevelEndColm(const std::vector<std::vector<std::string> > &records)
+{
+	if (UINT_MAX != kConfigParams->first_last_) {
+		std::string search_string("level");
+		search_string += std::to_string(kConfigParams->first_last_);
+		std::regex r(search_string.c_str(),
+			     std::regex_constants::icase);
+
+		for (size_t j = 1; j <= g_LevelEndColm; j++) {
+			const std::string &cell_content =
+				records[kConfigParams->header_row][j];
+			if (regex_search(cell_content, r)) {
+				return j;
+			}
+		}
+		ERROR("Wrong specification of last level in "
+		      "configuration file. Current Value: "
+		      << kConfigParams->first_last_);
+		INFO("Assumption is levels are marked in the csv file "
+		     "as Level1, Level2, "
+		     "..., Leveln and the expected values of last level"
+		     " (to be "
+		     "provided in the configuration file) are [1 - n]");
+		exit(1);
+	}
+
+	if (kConfigParams->formula_start_colm_ == UINT_MAX) {
+		assert(0 && "kConfigParams->formula_start_colm_ not set");
+	}
+	return kConfigParams->formula_start_colm_ - 1;
+}
+
+/**
+ * Determine the first column letter in the input csv file specifying
+ * topdown levels. It is derived as the column, in the header row,
+ * having a regex match with formula_start_colm_Key.
+ *
+ * A typical header row looks like:
+ * Key | Level1 | Level2 | SKX | SKL | ...
+ * The function return the column number for Level1.
+ *
+ * In case the kConfigParams->first_level_ is provided, which specifies
+ * the level number to begin with, then the function returns the column
+ * number corresponding to that level.
+ * For example, if kConfigParams->first_level_ == 2, then the function
+ * returns the column number for Level2.
+ */
+size_t GetLevelStartColm(const std::vector<std::vector<std::string> > &records)
+{
+	if (UINT_MAX != kConfigParams->first_level_) {
+		std::string search_string("level");
+		search_string += std::to_string(kConfigParams->first_level_);
+		std::regex r(search_string.c_str(),
+			     std::regex_constants::icase);
+
+		for (size_t j = 1;
+		     j < records[kConfigParams->header_row].size(); j++) {
+			const std::string &cell_content =
+				records[kConfigParams->header_row][j];
+			if (regex_search(cell_content, r)) {
+				return j;
+			}
+		}
+
+		ERROR("Wrong specification of first level in "
+		      "onfiguration file. Current Value: "
+		      << kConfigParams->first_level_);
+		INFO("Assumption is levels are marked in the csv file "
+		     "as Level1, Level2, "
+		     "..., Leveln and the expected values of first "
+		     "level (to be "
+		     "provided in the configuration file) are [1 - n]");
+		exit(1);
+	}
+
+	if (std::strcmp(formula_start_colm_Key, "") == 0) {
+		FATAL("Set formula_start_colm_Key in "
+		      "dependence_dag_utils.cpp file");
+	}
+
+	std::regex r(formula_start_colm_Key, std::regex_constants::icase);
+	for (size_t j = 1; j < records[kConfigParams->header_row].size(); j++) {
+		if (regex_search(records[kConfigParams->header_row][j], r)) {
+			return j;
+		}
+	}
+
+	ERROR("Wrong specification of formula start column key "
+	      "Current Value: "
+	      << formula_start_colm_Key);
+	INFO("Assumption is 'g_LevelStartColm' is derived as the first"
+	     "column whose header matches the formula start column key."
+	     " Try updating the formula_start_colm_Key in "
+	     "dependence_dag_utils.cc.");
+	exit(1);
+}
+
+/**
+ * Derives the header row as the first row in csv file counting from
+ * topmost row, that has a substring match with header_rowKey on any of
+ * its cells.
+ */
+size_t GetHeaderRow(const std::vector<std::vector<std::string> > &records)
+{
+	if (UINT_MAX != kConfigParams->header_row) {
+		return kConfigParams->header_row;
+	}
+
+	std::regex r(header_rowKey, std::regex_constants::icase);
+	for (size_t i = 0; i < records.size(); ++i) {
+		for (size_t j = 0; j < records[i].size(); j++) {
+			if (regex_search(records[i][j], r)) {
+				return i;
+			}
+		}
+	}
+
+	ERROR("Header row not found.");
+	INFO("Update the header row keys in dependence_dag_utils.cpp");
+	exit(1);
+	return UINT_MAX;
+}
+
+/**
+ * Derives "the first column number specifying a formula" as the first
+ * column in csv file, counting from left in the header row, which does
+ * not match with formula_start_colm_Key. The counting of columns starts
+ * with 2nd from the left as the left most one has the item "Key" in its
+ * header column.
+ */
+size_t
+GetFormulaStartColm(const std::vector<std::vector<std::string> > &records)
+{
+	if (UINT_MAX != kConfigParams->formula_start_colm_) {
+		return kConfigParams->formula_start_colm_;
+	}
+
+	std::regex r(formula_start_colm_Key, std::regex_constants::icase);
+	for (size_t j = 1; j < records[kConfigParams->header_row].size(); j++) {
+		if (!regex_search(records[kConfigParams->header_row][j], r)) {
+			return j;
+		}
+	}
+	assert(0 && "formula start column not found. update the formula "
+		    "start column keys");
+	return UINT_MAX;
+}
+
+/**
+ * Derives "the last column number specifying a formula".
+ * For the purpose, we first find the first column from
+ * right in the header row which **do** match with formula_end_colm_Key.
+ * The desired column is the one to the left of above found column.
+ */
+size_t GetFormulaEndColm(const std::vector<std::vector<std::string> > &records)
+{
+	if (UINT_MAX != kConfigParams->formula_end_colm_) {
+		return kConfigParams->formula_end_colm_;
+	}
+
+	std::regex r(formula_end_colm_Key, std::regex_constants::icase);
+	for (size_t j = records[kConfigParams->header_row].size(); j-- > 0;) {
+		if (regex_search(records[kConfigParams->header_row][j], r)) {
+			return j - 1;
+		}
+	}
+	assert(0 && "formula end column not found. update the formula end "
+		    "column keys");
+	return UINT_MAX;
+}
+
+/**
+ * Derives "Column number in the input csv file specifying
+ * 'Count Domain'" as the column number, counting from leftmost, that
+ * has a substring match with g_CountDomainColmKey.
+ */
+size_t GetCountDomainColm(const std::vector<std::vector<std::string> > &records)
+{
+	std::regex r(g_CountDomainColmKey, std::regex_constants::icase);
+	for (size_t j = 1; j < records[kConfigParams->header_row].size(); j++) {
+		if (regex_search(records[kConfigParams->header_row][j], r)) {
+			return j;
+		}
+	}
+
+	ERROR("Count domain column not found.");
+	INFO("Update the formula 'g_CountDomainColmKey' in "
+	     "dependence_dag_utils.cpp");
+	exit(1);
+
+	return UINT_MAX;
+}
+
+/**
+ * Get the alias CPUs, marked in the csv file as CPUX/CPUY.
+ */
+void GetAliasCpus(const std::vector<std::vector<std::string> > &records)
+{
+	std::regex r("\\/");
+	for (size_t j = kConfigParams->formula_start_colm_;
+	     j <= kConfigParams->formula_end_colm_; j++) {
+		const std::string &cell_content =
+			records[kConfigParams->header_row][j];
+		if (regex_search(cell_content, r)) {
+			std::set<std::string> alias_set;
+			std::vector<std::string> split_values =
+				Split(cell_content, '/');
+
+			for (auto &item : split_values) {
+				if (kConfigParams->dont_care_cpus_.count(
+					    item) == 0) {
+					alias_set.insert(Trim(item));
+				}
+			}
+			if (alias_set.size() > 1) {
+				g_CpuAliasesForEventInfo->push_back(alias_set);
+			}
+		}
+	}
+}
+
+/**
+ * Determine the cpus relevant to generate topdown hierarchy.
+ * If kConfigParams->selected_cpus_ is present (which are the selected
+ * CPUs provided using configuration parameter selected_cpus), then the
+ * function return value == kConfigParams->selected_cpus_.
+ * If not, return value =
+ *   (cpu names derived from csv file) - kConfigParams->dont_care_cpus_
+ */
+std::vector<std::string>
+GetRelevantCpus(const std::vector<std::vector<std::string> > &records)
+{
+	if (!g_RelevantCpus->empty()) {
+		return *g_RelevantCpus;
+	}
+
+	if (!kConfigParams->selected_cpus_.empty()) {
+		return (kConfigParams->selected_cpus_);
+	}
+
+	std::vector<std::string> retval;
+
+	std::regex r("\\/");
+	for (size_t j = kConfigParams->formula_start_colm_;
+	     j <= kConfigParams->formula_end_colm_; j++) {
+		const std::string &cell_content =
+			records[kConfigParams->header_row][j];
+
+		// Check if the CPUs names are provided as CPUx/CPUy
+		if (regex_search(cell_content, r)) {
+			std::vector<std::string> split_values =
+				Split(cell_content, '/');
+
+			for (auto &item : split_values) {
+				if (kConfigParams->dont_care_cpus_.count(
+					    item) == 0) {
+					retval.push_back(Trim(item));
+				}
+			}
+		} else {
+			if (kConfigParams->dont_care_cpus_.count(
+				    cell_content) == 0) {
+				retval.push_back(Trim(cell_content));
+			}
+		}
+	}
+
+	return retval;
+}
+
+/**
+ * Determines the column number in the input csv file specifying
+ * 'Description'. It is derived as the column number, counting from
+ * leftmost, that has a substring match with g_DescColmKey.
+ */
+size_t GetDescColm(const std::vector<std::vector<std::string> > &records)
+{
+	std::regex r(g_DescColmKey, std::regex_constants::icase);
+	for (size_t j = 1; j < records[kConfigParams->header_row].size(); j++) {
+		if (regex_search(records[kConfigParams->header_row][j], r)) {
+			return j;
+		}
+	}
+
+	ERROR("Description column not found.");
+	INFO("Update the formula 'g_DescColmKey' in "
+	     "dependence_dag_utils.cpp");
+	exit(1);
+
+	return UINT_MAX;
+}
+
+/**
+ * Determines the column number in the input csv file specifying
+ * 'Metric Group'. It is derived as the column number, counting from
+ * leftmost, that has a substring match with g_MetricGroupColmKey.
+ */
+size_t GetMetricGroupColm(const std::vector<std::vector<std::string> > &records)
+{
+	std::regex r(g_MetricGroupColmKey, std::regex_constants::icase);
+	for (size_t j = 1; j < records[kConfigParams->header_row].size(); j++) {
+		if (regex_search(records[kConfigParams->header_row][j], r)) {
+			return j;
+		}
+	}
+
+	ERROR("Metric Group column not found.");
+	INFO("Update the formula 'g_MetricGroupColmKey' in "
+	     "dependence_dag_utils.cpp");
+	exit(1);
+
+	return UINT_MAX;
+}
+
+/**
+ * 'IsServer' determine if a product represented by a column number is a
+ * server or a client.
+ */
+bool IsServer(const std::vector<std::vector<std::string> > &records,
+	      const size_t product_column_number)
+{
+	std::regex r("server", std::regex_constants::icase);
+	if (regex_match(records[kConfigParams->server_identifier_row_]
+			       [product_column_number],
+			r)) {
+		return true;
+	}
+
+	return false;
+}
+
+/**
+ * The input csv file has intentionally omitted some formulas for many
+ * metrics.  The idea is that those missing formulas can be derived
+ * using an inheritance rule which says:
+ *
+ *  Client products (like SNB/IVB/HSW/BDW/SKL) inherits on their
+ *  predecessors.  E.g. BDW inherits HSW (which inherits IVB)
+ *
+ *  Servers products (like JKT/IVT/HSX/BDX) inherits a baseline core and
+ *  builds-on predecessors. E.g. HSX inherits HSW and builds-on IVT
+ *  (which inherits IVB)
+ *
+ * PopulateEmptyFormulas modifies the `records` (which is the in-memory
+ * representation of the input csv file), to fill in the cell with
+ * missing formulas based on above inheritance rule.
+ *
+ */
+void PopulateEmptyFormulas(std::vector<std::vector<std::string> > *records)
+{
+	bool server_bool = false;
+
+	for (size_t i = kConfigParams->header_row + 1; i < records->size();
+	     ++i) {
+		std::string last_client_data("");
+
+		for (size_t j = kConfigParams->formula_end_colm_;
+		     j >= kConfigParams->formula_start_colm_; j--) {
+			server_bool = IsServer(*records, j);
+
+			if (!server_bool) {
+				// Client will inherit missing data from
+				// its predecessors clients.
+				if (!(*records)[i][j].empty()) {
+					last_client_data = (*records)[i][j];
+				} else {
+					(*records)[i][j] = last_client_data;
+				}
+			} else {
+				// Servers will inherit missing data
+				// from its predecessors clients.
+				if ((*records)[i][j].empty()) {
+					(*records)[i][j] = last_client_data;
+				}
+			}
+		}
+	}
+}
+
+/**
+ * `records` is the in-memory representation of the input csv file.
+ * `ParseRecordToMappedData` parses each cell given by
+ * `records[row][column]` and extracts information as follows:
+ *
+ * For example: For the following csv entry
+ *  0    1          2            3               4              5
+ *       Level1 |  SKX     | Count Domain |  Description | Metric Group
+ *  P     M     | Formula  | Slots        |  description |     MG
+ *
+ *  For the cell specifying "Formula", the information collected are:
+ * (1) row and column number: 0,2
+ * (2) Textual content of the cell: "Formula"
+ * (3) Name of the header: "SKX"
+ * (4) The count domain: "Slots"
+ * (5) Descriptive text: "Some description"
+ * (6) Metric group: "MG"
+ * (7) Key: "M"
+ * (8) Prefix: "P"
+ * (9) Aux data: A collection of data like Count Domain, Description,
+ *              Metric Group etc.
+ */
+MappedData
+ParseRecordToMappedData(const std::vector<std::vector<std::string> > &records,
+			const size_t &row, const size_t &column)
+{
+	MappedData obj;
+	obj.row_ = row;
+	obj.column_ = column;
+	obj.cell_content_ = records[row][column];
+	obj.header_name_ = records[kConfigParams->header_row][column];
+	obj.count_domain_ = records[row][g_CountDomainColm];
+	obj.description_ = records[row][g_DescColm];
+	obj.metric_group_ = records[row][g_MetricGroupColm];
+
+	// Find metric name
+	// This is equal to the first non-empty string in `row` before
+	// the column starting formula/expression specification.
+	for (size_t j = kConfigParams->formula_start_colm_; j-- > 0;) {
+		if (!records[row][j].empty()) {
+			obj.metric_name_ = records[row][j];
+			break;
+		}
+	}
+
+	if (obj.metric_name_.empty()) {
+		std::cerr << "key missing for row: " << row
+			  << " column: " << column << "\n";
+		assert(0);
+	}
+
+	// Find the prefix string.
+	bool flag = true;
+	for (size_t j = kConfigParams->formula_start_colm_; j-- > 0;) {
+		if (!records[row][j].empty()) {
+			if (flag) {
+				flag = false;
+			} else {
+				obj.prefix_ = records[row][j] + obj.prefix_;
+			}
+		}
+	}
+
+	// Find the aux_data string.
+	for (size_t j = kConfigParams->formula_end_colm_ + 1;
+	     j < records[row].size(); j++) {
+		if (!records[row][j].empty()) {
+			obj.aux_data_ += "\t * " +
+					 records[kConfigParams->header_row][j] +
+					 ": " + records[row][j] + "\n";
+		}
+	}
+
+	return obj;
+}
+
+std::string GetKey(const MappedData &data)
+{
+	return data.metric_name_ + "_" + data.header_name_;
+}
+
+/**
+ * Create a dependence dag using the 'records' data-structure
+ * (which is the in-memory representation of the input csv file)
+ * "dependence dag" is implemented as a map as follows:
+ * A. Suppose we have rows
+ *            Level1  Level2  ||  SKL    BDW
+ *        K     L1            ||  P1*L2  P2*L2
+ *        K             L2    ||  P3*Q3  P4*Q4
+ *
+ *    The information we will be storing in the map are as follows:
+ *
+ *       Map Key ->  and object of `MappedData`
+ *       -----------------------------------------
+ *      <metric>_<CPU> ->   {<header>, <textual formula>, <prefix>, ...}
+ *      L1_SKL         ->   {SKL, P1*L2, "K", ...}
+ *      L1_BWD         ->   {BWD, P2*L2, "K", ...}
+ *      L2_SKL         ->   {SKL, P3*Q3, "K", ...}
+ *      L2_BWD         ->   {BWD, P4*Q4, "K", ...}
+ */
+std::unordered_map<std::string, MappedData>
+CreateDependenceDag(const std::vector<std::vector<std::string> > &records)
+{
+	std::unordered_map<std::string, MappedData> dependence_dag;
+
+	// Store the records in a dependence std::map
+	for (size_t i = kConfigParams->header_row + 1; i < records.size();
+	     ++i) {
+		for (size_t j = kConfigParams->formula_start_colm_;
+		     j <= kConfigParams->formula_end_colm_; j++) {
+			MappedData data =
+				ParseRecordToMappedData(records, i, j);
+
+			// Skip std::map population for irrelevant keys.
+			if (data.metric_name_.empty() ||
+			    data.metric_name_ == ".") {
+				continue;
+			}
+
+			std::string key = GetKey(data);
+
+			if (dependence_dag.count(key) > 0) {
+				std::cerr << "Duplicate key: " << key
+					  << " Row: " << i << " Colm: " << j
+					  << "\n";
+				assert(0 && "duplicate!!");
+			} else {
+				dependence_dag[key] = data;
+			}
+		}
+	}
+
+	assert(!dependence_dag.empty() && "empty dependence dag");
+
+	// Remove the entries with column header label as SKL/BDW and
+	// create separate entry for them.
+	std::regex r("\\/");
+	std::vector<std::string> keys_to_remove;
+	std::vector<std::pair<std::string, MappedData> > keys_to_insert;
+	for (auto &p : dependence_dag) {
+		const std::string &key = p.first;
+		MappedData &value = p.second;
+
+		if (regex_search(value.header_name_, r)) {
+			std::vector<std::string> split_values =
+				Split(value.header_name_, '/');
+
+			for (auto &item : split_values) {
+				MappedData new_value = value;
+				new_value.header_name_ = Trim(item);
+				std::string new_mapkey = GetKey(new_value);
+				if (dependence_dag.count(new_mapkey) > 0) {
+					std::cerr << "Duplicate key: "
+						  << new_mapkey << "\n";
+					assert(0 && "Duplicate 2");
+				}
+				keys_to_insert.push_back(
+					std::pair<std::string, MappedData>(
+						new_mapkey, new_value));
+			}
+			keys_to_remove.push_back(key);
+		}
+	}
+
+	for (auto &delkey : keys_to_remove) {
+		dependence_dag.erase(delkey);
+	}
+	for (auto &insertkey : keys_to_insert) {
+		dependence_dag.insert(insertkey);
+	}
+
+	// Adding description for dummy metric topdown.
+	for (auto &known_cpu : *g_RelevantCpus) {
+		MappedData &data =
+			dependence_dag[std::string("topdown") + "_" + known_cpu];
+		data.header_name_ = known_cpu;
+		data.metric_name_ = std::string("topdown") + "_" + known_cpu;
+		data.description_ = std::string(
+			"Intel Topdown analysis expressed in % of issue"
+			" slots");
+	}
+
+	return dependence_dag;
+}
+
+/**
+ * Print Diagnosis results.
+ */
+void PrintConfigVars()
+{
+	std::cout << std::endl;
+	INFO("Important csv artifacts");
+	INFO(std::string("Header row number = ") +
+	     std::to_string(kConfigParams->header_row + 1));
+	INFO(std::string("Server identifier row number = ") +
+	     std::to_string(kConfigParams->server_identifier_row_ + 1));
+	INFO(std::string("Formula start column = ") +
+	     std::string(1, static_cast<char>(
+				    'A' + kConfigParams->formula_start_colm_)));
+	INFO(std::string("Formula end column = ") +
+	     std::string(1, static_cast<char>(
+				    'A' + kConfigParams->formula_end_colm_)));
+	INFO(std::string("Level start column = ") +
+	     std::string(1, static_cast<char>('A' + g_LevelStartColm)));
+	INFO(std::string("Level end column = ") +
+	     std::string(1, static_cast<char>('A' + g_LevelEndColm)));
+	INFO(std::string("Level end row number = ") +
+	     std::to_string(g_LevelEndRow + 1));
+	INFO(std::string("Count Domain column = ") +
+	     std::string(1, static_cast<char>('A' + g_CountDomainColm)));
+	INFO(std::string("Description column = ") +
+	     std::string(1, static_cast<char>('A' + g_DescColm)));
+
+	std::cout << std::endl;
+	INFO("Relevant CPUs = " << *g_RelevantCpus);
+	INFO("Don't care CPUs = " << kConfigParams->dont_care_cpus_);
+	INFO("CPU alias sets for event encodings");
+	for (auto &alias_set : *g_CpuAliasesForEventInfo) {
+		INFO("\t{" << alias_set << "} ");
+	}
+}
+
+} // namespace
+
+std::unordered_map<std::string, MappedData>
+ProcessRecords(std::vector<std::vector<std::string> > *records)
+{
+	InitGlobals();
+
+	// Task 0
+	GetPerfmonVersion(*records);
+
+	// Task 1
+	kConfigParams->header_row = GetHeaderRow(*records);
+	kConfigParams->formula_start_colm_ = GetFormulaStartColm(*records);
+	kConfigParams->formula_end_colm_ = GetFormulaEndColm(*records);
+	g_CountDomainColm = GetCountDomainColm(*records);
+	g_DescColm = GetDescColm(*records);
+	g_MetricGroupColm = GetMetricGroupColm(*records);
+	g_LevelStartColm = GetLevelStartColm(*records);
+	g_LevelEndColm = GetLevelEndColm(*records);
+	g_LevelEndRow = GetLevelEndRow(*records);
+	(*g_RelevantCpus) = GetRelevantCpus(*records);
+	kConfigParams->server_identifier_row_ = GetServerIdentifierRow();
+
+	// Task 2
+	GetTopdownHierarchy(*records);
+	PlotTopdownHierarchy(*g_TopdownHierarchy);
+
+	// Task 3
+	GetAliasCpus(*records);
+
+	// Task 4
+	PopulateEmptyFormulas(records);
+
+	// Task 5
+	PrintConfigVars();
+
+	// Task 6
+	return CreateDependenceDag(*records);
+}
+
+} // namespace topdown_parser
diff --git a/tools/perf/pmu-events/topdown-parser/dependence_dag_utils.h b/tools/perf/pmu-events/topdown-parser/dependence_dag_utils.h
new file mode 100644
index 000000000000..e7f992f98e45
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/dependence_dag_utils.h
@@ -0,0 +1,178 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+// --------------------------------------------------------
+// File: dependence_dag_utils.h
+// --------------------------------------------------------
+//
+// The header provides the interface to read the input csv file, process it and
+// populate an in-memory model.
+//
+// The cells of the input csv file can be broadly divided into two types:
+// (1) Ones specifying the top down metric and (2) Ones specifying the
+// metric expression for a metric and CPU pair. (CPU is specified in the csv
+// file by the column and  metric by the row).
+//
+// A formula might involve the following:
+// (1) Raw PMU events
+// (2) Constants
+// (3) External parameters: The definition of such components are not defined in
+// the input csv file and must come from elsewhere. For example, a formula
+// component `SMT_on`, specifying if hyper-threading is enabled on CPU or not,
+// need to be extracted from host machine.
+//    Example, ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else CLKS
+// (4) Another (sub-)metric, as in
+//    1 - ( Frontend_Bound + Bad_Speculation + Retiring )
+//
+// We represent the formula as a dependence dag where the root of the dag
+// represents a topdown metric (hence a formula), the intermediate nodes
+// represent sub-formulas and the leaves represent the PMU events, constants or
+// external parameter. We implement this dependence dag using a map.
+
+#ifndef TOPDOWN_PARSER_DEPENDENCE_DAG_UTILS_H_
+#define TOPDOWN_PARSER_DEPENDENCE_DAG_UTILS_H_
+
+#include <map>
+#include <set>
+#include <string>
+#include <unordered_map>
+#include <vector>
+
+namespace topdown_parser
+{
+/**
+ * For each metric, the data-structure `TopdownInfo` stores the
+ * (1) the name of perf-metric switch name to be used for invoking perf stat.
+ * Note: This field is not required for all targets.
+ * (2) the names of all the sub-metrics.
+ */
+struct TopdownInfo {
+	std::string perf_stat_switch_name;
+	std::vector<std::string> child_metrics;
+};
+
+/**
+ * `g_TopdownHierarchy` stores the topdown hierarchy.
+ *
+ *  An example: The metric `topdown` has four sub-metrics and each of the
+ *  sub-metrics can be further broken down.
+ *      Topdown
+ *        Frontend_Bound
+ *          Frontend_Latency
+ *          Frontend_Bandwidth
+ *        Backend_Bound
+ *          ...
+ *        Bad_Speculation
+ *          ...
+ *        Retiring
+ *          ...
+ *
+ *  g_TopdownHierarchy is an map from the parent metric name to an object of
+ *  type TopdownInfo which contains
+ *    1. Name of perf stat switch: This is derived from the configuration
+ *       parameter `perf_stat_switch_names_`.
+ *    2. Names of all the child metrics
+ *
+ *  For example, in the context of running example,
+ *
+ *   g_TopdownHierarchy["Topdown"] --> {"topdown",
+ *                {"Frontend_Bound", Backend_Bound, Bad_Speculation, Retiring}}
+ *   g_TopdownHierarchy["Frontend_Bound"] --> {"topdown_fe",
+ *                {"Frontend_Latency", "Frontend_Bandwidth"}}
+ */
+extern std::map<std::string, TopdownInfo> *g_TopdownHierarchy;
+
+/**
+ * The version number of the input csv file.
+ */
+#define VERSION_MAX_STRLEN 100
+extern char g_PerfmonVersion[VERSION_MAX_STRLEN];
+
+/**
+ * The CPUs actually used for generating topdown files. This takes into account
+ * the CPUs derived from the input csv file and the ones included or excluded
+ * by configuration parameters `selected_cpus_` and `dont_care_cpus_`
+ */
+extern std::vector<std::string> *g_RelevantCpus;
+
+/**
+ * List of unique CPU names which are specified in the input csv file as
+ * CPUX/CPUY
+ */
+extern std::vector<std::set<std::string> > *g_CpuAliasesForEventInfo;
+
+/**
+ * Each textual entry of the input csv file is parsed to the following
+ * data-structure.
+ */
+struct MappedData {
+	// Row and column of the textual entry.
+	size_t row_, column_;
+	// The textual content.
+	std::string cell_content_;
+	// Prefix is used to make the
+	// function name more informative.
+	std::string prefix_;
+	// Auxiliary data about the entry.
+	std::string aux_data_;
+	// The header value for the entry, which equals the CPU model.
+	std::string header_name_;
+	// Metric name
+	std::string metric_name_;
+	// The value of count domain
+	// for the entry.
+	std::string count_domain_;
+	// The value of description
+	// for the entry.
+	std::string description_;
+	// The value of metric group
+	// for the entry.
+	std::string metric_group_;
+};
+
+std::ostream &operator<<(std::ostream &, const MappedData &);
+std::ostream &operator<<(std::ostream &,
+			 const std::unordered_map<std::string, MappedData> &);
+
+/**
+ * ProcessRecords parses and process the entries of the csv file and
+ * creates an in-memory model. It process the list of rows 'records' of the csv
+ * file in the following way.
+ * Task 0. Determine the version number of the input csv file.
+ *
+ * Task 1. Derive information from the input csv file.
+ *
+ * Task 2: Generate the topdown hierarchy
+ *
+ * Task 3. Determine the alias CPUs.
+ * If the csv file has column headers like "CPUX/CPUY", then we consider the
+ * CPUs as aliases for event encoding look-up purposes. That is, if the  event
+ * encoding JSon file for CPUX, is missing or an event is not found in the
+ * event encoding file for CPUX, then we will lookup in encoding file of CPUY.
+ *
+ * Task 4. Populate the missing cell values.
+ *
+ * Task 5. Print the information derived at Task 2.
+ *
+ * Task 6. Create a map storing the records. in the following fashion.
+ * Example
+ * A. Suppose we have rows
+ *            Level1  Level2  ||  SKL    BDW
+ *        K     L1            ||  P1*L2  P2*L2
+ *        K             L2    ||  P3*Q3  P4*Q4
+ *
+ *    The information we will be storing in the map are as follows:
+ *
+ *             Map Key ->  Some of the mapped values
+ *
+ *              <metric>_<CPU> ->   {<header>, <textual formula>, <prefix>, ...}
+ *              L1_SKL ->   {SKL, P1*L2, "K", ...}
+ *              L1_BWD ->   {BWD, P2*L2, "K", ...}
+ *              L2_SKL ->   {SKL, P3*Q3, "K", ...}
+ *              L2_BWD ->   {BWD, P4*Q4, "K", ...}
+ */
+std::unordered_map<std::string, MappedData>
+ProcessRecords(std::vector<std::vector<std::string> > *);
+
+} // namespace topdown_parser
+
+#endif // TOPDOWN_PARSER_DEPENDENCE_DAG_UTILS_H_
-- 
2.29.2.222.g5d2a92d10f8-goog
