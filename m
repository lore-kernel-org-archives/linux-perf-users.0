From: Ian Rogers <irogers@google.com>
Subject: [RFC PATCH 10/12] perf topdown-parser: Add json metric code generation.
Date: Tue, 10 Nov 2020 02:03:44 -0800
Message-ID: <20201110100346.2527031-11-irogers@google.com>
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

Code generation from read in TMA_Metrics.csv to json metric encoding.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Sandeep Dasgupta <sdasgup@google.com>
---
 .../code_gen_target_perf_json.cpp             | 546 ++++++++++++++++++
 .../code_gen_target_perf_json.h               |  25 +
 2 files changed, 571 insertions(+)
 create mode 100644 tools/perf/pmu-events/topdown-parser/code_gen_target_perf_json.cpp
 create mode 100644 tools/perf/pmu-events/topdown-parser/code_gen_target_perf_json.h

diff --git a/tools/perf/pmu-events/topdown-parser/code_gen_target_perf_json.cpp b/tools/perf/pmu-events/topdown-parser/code_gen_target_perf_json.cpp
new file mode 100644
index 000000000000..70bb45de6675
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/code_gen_target_perf_json.cpp
@@ -0,0 +1,546 @@
+/*
+ * Copyright 2020 Google LLC.
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include "code_gen_target_perf_json.h"
+
+#include <cassert>
+#include <fstream>
+#include <regex>
+
+#include "configuration.h"
+#include "dependence_dag_utils.h"
+#include "event_info.h"
+#include "expr_parser-bison.hpp"
+#include "general_utils.h"
+#include "logging.h"
+
+namespace topdown_parser
+{
+namespace
+{
+/**
+ * The input csv file does not define the formula for some metrics which
+ * are meant to be defined by the host machine. For example, the
+ * expression entry for Boolean metric `SMT_on` is empty in the input
+ * csv file.  Perf tool evaluating the formula must extract information
+ * about the availability of hyper-threading from the host machine. We
+ * refer such metrics as external parameters.  While generating the
+ * metric json files (encoding the expression of each metric), we want
+ * to replace the expression for such metrics either with their
+ * definition or a symbol recognized by the perf tool so that it can
+ * parse the json file correctly.  For example,
+ * `#SMT_on` is the symbol used by perf tool identify the csv Boolean
+ * metric `SMT_on`
+ *
+ * 'CheckExternalParameter' checks if a name matches an external
+ * parameter name. If found, then `external_param_info` is used to
+ * return meta-information about the external parameter. The information
+ * includes: (1) The data-type of the metric, (2) The definition or
+ * the symbol used to replace the metric expression of the external
+ * parameter.
+ */
+bool CheckExternalParameter(
+	const std::string &sym_name,
+	std::pair<std::string, std::pair<std::string, std::string> >
+		*external_param_info)
+{
+	using ParamInfo = std::pair<std::string, std::string>;
+	using ExternalParamNameToParamInfo = std::map<std::string, ParamInfo>;
+
+	/**
+	 * g_ExternalParameters stores the external parameters in the
+	 * following format:
+	 * Parameter name --> {Parameter Data Type, Definition or
+	 *                   symbol to be used instead of the parameter}
+	 */
+	static ExternalParamNameToParamInfo g_ExternalParameters = {
+		// SMT_on: Hyper-threading is ON on host machine.
+		{ "SMT_on",
+		  std::pair<std::string, std::string>("bool", "#SMT_on") },
+		// EBS_Mode: Event Sampling Based Mode
+		{ "EBS_Mode",
+		  std::pair<std::string, std::string>("bool", "0") },
+	};
+
+	for (auto &exp : g_ExternalParameters) {
+		const std::string &exp_name = exp.first;
+		if (sym_name.find(exp_name) != std::string::npos) {
+			*external_param_info =
+				std::pair<std::string,
+					  std::pair<std::string, std::string> >(
+					exp_name, exp.second);
+			return true;
+		}
+	}
+	external_param_info = nullptr;
+	return false;
+}
+
+/**
+ * Create the event string for event 'event_str'.
+ *
+ * For example:
+ *  For the event "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD:c4",
+ *  Return:
+ *  "cpu@OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD\\,cmask\\=4@"
+ */
+std::string GetEventString(const std::string &event_str, const std::string &cpu)
+{
+	std::string retval("");
+	const EventInfo *event_data;
+	std::vector<std::string> tokens;
+
+	GetEventInfo(event_str, cpu, &event_data, &tokens);
+
+	const std::string &event_name = event_data->eventname_;
+	const std::string msrvalue = Trim(event_data->msrvalue_);
+	std::string cmask = event_data->countermask_;
+
+	std::string edge = "";
+	if (event_data->edgedetect_ != "0") {
+		edge = "edge";
+	}
+
+	const std::string any = (event_data->anythread_ != "0") ? "any" : "";
+
+	std::string invert = "";
+	if (event_data->invert_ != "0") {
+		invert = "inv";
+	}
+
+	if (tokens.size() > 1) {
+		for (size_t i = 1; i < tokens.size(); ++i) {
+			std::smatch sm;
+			// Cmask
+			if (regex_match(tokens[i], sm,
+					std::regex("c([0-9]+)"))) {
+				cmask = sm[1].str();
+				continue;
+			}
+
+			// Edge
+			if (regex_match(tokens[i], std::regex("e1"))) {
+				edge = "edge";
+				continue;
+			}
+
+			// invert_
+			if (regex_match(tokens[i], std::regex("i1"))) {
+				invert = "inv";
+				continue;
+			}
+
+			ERROR("Unhandled token: " << tokens[i]
+						  << " for Event: " << event_str
+						  << " for CPU:" << cpu);
+		}
+	}
+
+	retval += "";
+	retval += "cpu@" + event_name;
+	// Cmask
+	if (!cmask.empty() && cmask != "0") {
+		retval += "\\\\,cmask\\\\=";
+		retval += cmask;
+	}
+
+	// Edge
+	if (!edge.empty()) {
+		retval += "\\\\,edge";
+	}
+
+	// Any
+	if (!any.empty()) {
+		retval += "\\\\,any";
+	}
+
+	// Invert
+	if (!invert.empty()) {
+		retval += "\\\\,inv";
+	}
+	retval += "@";
+
+	return retval;
+}
+
+/**
+ * Formatting the formula.
+ */
+std::string FormatFormula(const std::string &str)
+{
+	std::regex r_comma("(\\,)"); // For every occurrence of
+		// character ','
+	std::string repl_comma = "$1 "; // Replace with ", "
+
+	std::string retval = regex_replace(str, r_comma, repl_comma);
+
+	std::regex r_op("(\\<|\\>|\\+|\\-|\\*|\\/|\\%" // Every occurrence of
+			"|if|else)");
+	std::string repl_op = " $1 "; // operator '+',
+	retval = regex_replace(retval, r_op,
+			       repl_op); // replace with ' + '
+
+	// The above formatting will make the event encoding
+	//  cpu@OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD\\,cmask\\=4@
+	// look
+	//  cpu@OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD\\, cmask\\=4@
+	// which is not acceptable.
+	// For the event attributes like cmask, invert, edge and any, we
+	// prevent such transformation.
+	retval = regex_replace(retval, std::regex("(\\s*)cmask"), "cmask");
+	retval = regex_replace(retval, std::regex("(\\s*)inv"), "inv");
+	retval = regex_replace(retval, std::regex("(\\s*)edge"), "edge");
+	retval = regex_replace(retval, std::regex("(\\s*)any"), "any");
+
+	return retval;
+}
+/**
+ * Preprocess cell contents.
+ */
+std::vector<std::string> NormalizeFormula(const std::string &str,
+					  const std::string &header_name)
+{
+	std::vector<std::string> body_tokens;
+
+	if (!str.length()) {
+		return body_tokens;
+	}
+
+	// Make the cell content amenable to split based on whitespace.
+	std::string cell_content;
+	size_t cursor = 0;
+	yy::parser parser(str, &cursor, false /* do not convert if stmt */,
+			  false /* Remove false branch */,
+			  false /* do not wrap div operator in a function */,
+			  &cell_content);
+	if (parser.parse())
+		FATAL("Parsing error");
+
+	// Split the cell content based on whitespace.
+	body_tokens = WhitespaceSplit(cell_content);
+
+	// Handle 'if #Model in ['KBLR' 'CFL']'
+	if (regex_search(cell_content, std::regex("Model"))) {
+		body_tokens = NormalizeModel(body_tokens, header_name);
+	}
+
+	return body_tokens;
+}
+
+// Forward declaration
+std::string
+GetMetricExpr(const std::string &key,
+	      const std::unordered_map<std::string, MappedData> &dependence_dag,
+	      std::unordered_map<std::string, std::string> *formula_cache);
+
+std::string ComputeBodyFormula(
+	const MappedData &data,
+	const std::unordered_map<std::string, MappedData> &dependence_dag,
+	std::unordered_map<std::string, std::string> *formula_cache)
+{
+	// For the cells containing Uncore event, generate an assertion
+	// error and bail off.
+	std::regex blacklisted_formulas("UNC_|_PS");
+
+	if (data.cell_content_.find("UNC_") != std::string::npos) {
+		FATAL("Found an uncore event in expr: " << data.cell_content_);
+	}
+
+	std::string retval("");
+	std::vector<std::string> retval_tokens;
+	const std::string &header_name = data.header_name_;
+	std::vector<std::string> body_tokens =
+		NormalizeFormula(data.cell_content_, header_name);
+
+	for (auto &body_token : body_tokens) {
+		std::string search_key = body_token + "_" + header_name;
+
+		// Check if the token corresponds to an existing cell.
+		if (dependence_dag.count(search_key) != 0) {
+			// If any of the cell token corresponds to an
+			// 'Info.Systems' cell, then generate an
+			// assertion error and bail off.
+			if (dependence_dag.at(search_key).prefix_ ==
+			    "Info.System") {
+				FATAL("Formula refer to Info.System: "
+				      << data.cell_content_);
+			}
+
+			retval_tokens.push_back(GetMetricExpr(
+				search_key, dependence_dag, formula_cache));
+			continue;
+		}
+
+		// Check if the token is an operator.
+		if (IsOperator(body_token) || IsConstant(body_token)) {
+			retval_tokens.push_back(body_token);
+			continue;
+		}
+
+		// Check if the token is "NA"
+		if (body_token == "#NA" || body_token == "NA" ||
+		    body_token == "N/A") {
+			retval_tokens.push_back("NOT_APPLICABLE");
+			continue;
+		}
+
+		// Check if the token is an event.
+		const EventInfo *event_data;
+		std::vector<std::string> tokens;
+		if (GetEventInfo(body_token, header_name, &event_data,
+				 &tokens)) {
+			retval_tokens.push_back(
+				GetEventString(body_token, header_name));
+			continue;
+		}
+
+		// Unknown token: Error Out We want to emit all the
+		// missing definition errors before we assert false.
+		ERROR("Missing definition of "
+		      << body_token << " in the formula: " << data.cell_content_
+		      << " for CPU: " << header_name);
+		retval_tokens.push_back(body_token);
+	}
+
+	for (auto &retval_token : retval_tokens) {
+		retval += retval_token;
+	}
+
+	return (retval);
+}
+
+std::string
+GetMetricExpr(const std::string &key,
+	      const std::unordered_map<std::string, MappedData> &dependence_dag,
+	      std::unordered_map<std::string, std::string> *formula_cache)
+{
+	std::string retval("0.0");
+	const MappedData &cell_data = dependence_dag.at(key);
+
+	// Check if the function name corresponds to an external
+	// parameter
+	std::pair<std::string, std::pair<std::string, std::string> >
+		external_param_info;
+	bool isExtParam = CheckExternalParameter(key, &external_param_info);
+
+	// Skip generating the function definitions
+	// for certain conditions.
+	if ((!isExtParam && cell_data.cell_content_.empty()) ||
+	    cell_data.cell_content_ == "#NA" ||
+	    cell_data.cell_content_ == "N/A" ||
+	    cell_data.cell_content_ == "NA" || cell_data.cell_content_ == "-" ||
+	    cell_data.prefix_ == "Info.System") {
+		return "NOT_APPLICABLE";
+	}
+
+	if (0 != formula_cache->count(key)) {
+		return (*formula_cache)[key];
+	}
+
+	if (isExtParam) {
+		retval = external_param_info.second.second;
+	} else {
+		retval = "(" +
+			 ComputeBodyFormula(cell_data, dependence_dag,
+					    formula_cache) +
+			 ")";
+	}
+
+	(*formula_cache)[key] = retval;
+	return retval;
+}
+
+/**
+ * For the metric group of form mg1:mg2, the function ProcessMetricGroup
+ * return <prefix>_mg1; <prefix>_mg2
+ */
+std::string ProcessMetricGroup(const std::string &metric_group,
+			       const std::string &prefix)
+{
+	std::string retval("");
+	std::vector<std::string> metric_group_tokens = Split(metric_group, ';');
+
+	for (size_t i = 0; i < metric_group_tokens.size(); ++i) {
+		if (i == 0) {
+			retval += prefix + metric_group_tokens[i];
+			continue;
+		}
+		retval += ";" + prefix + metric_group_tokens[i];
+	}
+	return retval;
+}
+
+/**
+ * Generate topdown json records. Each records contains
+ * 1. A BriefDescription of the metric.
+ * 2. A Metric Group as specified in the input csv file.
+ * 3. Name of the metric
+ * 4. The metric expression: For example, say the expression for metrics
+ *    M1 and M2 are (e1 op1 e2) and (e3 op2 e4) respectively, where ei
+ *    is an event and opi is some operator. For a metric M with
+ *    expession as (e5 op3 M1 op4 M2). The flattened expression for M is
+ *    e5 op3 (e1 op1 e2) op4 (e3 op2 e4)
+ */
+void GenTopdownRecords(
+	std::ofstream &ofile_json, const std::string &metric,
+	const std::string &child_metric,
+	const std::unordered_map<std::string, MappedData> &dependence_dag,
+	const std::string &cpu)
+{
+	std::string key = child_metric + "_" + cpu;
+
+	if (dependence_dag.count(key) == 0) {
+		FATAL("Topdown key: " << key << " not found for  metric: "
+				      << metric << ", CPU: " << cpu);
+	}
+
+	const MappedData &cell_data = dependence_dag.at(key);
+
+	// Get "BriefDescription" json key
+	std::string brief_description = cell_data.description_;
+
+	// Get flattened "MetricExpr" json key.
+	std::unordered_map<std::string, std::string> formula_cache;
+	std::string metric_expr =
+		GetMetricExpr(key, dependence_dag, &formula_cache);
+
+	// Format the expression
+	metric_expr = FormatFormula(metric_expr);
+
+	// Remove false branch.
+	std::string metric_expr_false_branch_removed;
+	size_t cursor = 0;
+	yy::parser parser(metric_expr, &cursor, false /* convert if stmt */,
+			  true /* Remove false branch */,
+			  false /* wrap div operator in a function */,
+			  &metric_expr_false_branch_removed);
+	if (parser.parse())
+		FATAL("Parsing error");
+
+	// Check if the flattened expression has a "NOT_APPLICABLE"
+	// string. It yes, it means that metric expression is not valid
+	// for `cpu` and we can ignore the metric `child_metric`.
+	//
+	// Note: This check needs to be done after "Removing false
+	// branches". This is because: We might have a flattened
+	// expression like (e1 op "NOT_APPLICABLE" if 0 else  e2). Even
+	// though the expression contain  "NOT_APPLICABLE", but we
+	// should not ignore the metric as the "NOT_APPLICABLE" appears
+	// in the false branch.
+	if (std::string::npos !=
+	    metric_expr_false_branch_removed.find("NOT_APPLICABLE")) {
+		return;
+	}
+
+	// Get "MetricGroup" json key
+	std::string metric_group = cell_data.metric_group_;
+
+	// Get "MetricName" json key
+	std::string metric_name = cell_data.metric_name_;
+
+	ofile_json << "    {\n";
+	ofile_json << "\t\t\"BriefDescription\": \"" << brief_description
+		   << "\",\n";
+	ofile_json << "\t\t\"MetricExpr\": \""
+		   << metric_expr_false_branch_removed << "\",\n";
+	ofile_json << "\t\t\"MetricGroup\": \""
+		   << ProcessMetricGroup(metric_group, "Topdown_Group_")
+		   << "\",\n";
+	ofile_json << "\t\t\"MetricName\": \""
+		   << "Topdown_Metric_" + metric_name << "\"\n";
+	ofile_json << "    },\n";
+}
+
+/**
+ * CodeGen generates metric json files (e.g. skx-topdown-metric.json)
+ */
+void CodeGenPerfJson(
+	const std::unordered_map<std::string, MappedData> &dependence_dag)
+{
+	const std::set<std::string> compact_cpus_to_handle(
+		g_RelevantCpus->begin(), g_RelevantCpus->end());
+
+	for (const std::string &cpu : compact_cpus_to_handle) {
+		// For the CPUs JKT and SNB-EP, generate output only for
+		// JKT.
+		// This is because:
+		// 1. All the members in a group share the same formula
+		// (as specified in the input csv file as JKT/SNB-EP)
+		// and same event encoding json files.
+		// 2. pmu-events/arch/x86 hosts directory only for
+		// jaketown
+		if ((cpu == "SNB-EP" &&
+		     compact_cpus_to_handle.count("JKT") != 0)) {
+			continue;
+		}
+
+		std::string outfile = kConfigParams->output_path_ + "/";
+
+		// If (per CPU output directory is not specified or
+		//       It is specified but does not exists)
+		//    dump the JSon file in kConfigParams->output_path_
+		// Else
+		//    Else dump the JSon file in
+		//    kConfigParams->output_path_/<per cpu dir>
+		if (kConfigParams->output_directory_per_cpu_.count(cpu) == 0 ||
+		    !CheckDirPathExists(
+			    outfile +
+			    kConfigParams->output_directory_per_cpu_.at(cpu))) {
+			INFO("No CPU specific directory found under"
+			     << " Path " << outfile << " for CPU " << cpu);
+			INFO("Either directory "
+			     << outfile
+			     << "<per cpu directory> does not exists."
+				"Or there is no CPU specific "
+				"output directory "
+				"mentioned under JSon key"
+				"\"output_directory_per_cpu\" for "
+			     << cpu);
+			outfile += ToLower(cpu) + "-topdown-metric.json";
+		} else {
+			outfile += kConfigParams->output_directory_per_cpu_.at(
+					   cpu) +
+				   "/" + ToLower(cpu) + "-topdown-metric.json";
+		}
+
+		std::ofstream ofile_json(outfile);
+
+		if (false == ofile_json.is_open()) {
+			FATAL("Cannot open metric json file: " << outfile);
+		}
+		INFO("Generating metric json file: " << outfile << "\n");
+
+		ofile_json << "[\n";
+
+		for (auto &p : *g_TopdownHierarchy) {
+			const std::string &parent_metric = p.first;
+			std::vector<std::string> &child_metrics =
+				p.second.child_metrics;
+
+			for (size_t i = 0; i < child_metrics.size(); ++i) {
+				GenTopdownRecords(ofile_json, parent_metric,
+						  child_metrics[i],
+						  dependence_dag, cpu);
+			}
+		}
+
+		ofile_json << "\n]";
+		ofile_json.close();
+	}
+}
+
+} // namespace
+
+TargetInfo kTargetPerfJson = {
+	.name = "perf_json",
+	.description = "The generated code includes:\n"
+		       "<cpu>-topdown-metric.json:"
+		       "Per cpu json file encoding the topdown "
+		       "metric formulas\n",
+	.codegen_entry_point = &CodeGenPerfJson,
+	.codegen_test_harness_entry_point = nullptr,
+};
+
+} // namespace topdown_parser
diff --git a/tools/perf/pmu-events/topdown-parser/code_gen_target_perf_json.h b/tools/perf/pmu-events/topdown-parser/code_gen_target_perf_json.h
new file mode 100644
index 000000000000..bb4fe7776f2b
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/code_gen_target_perf_json.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+// --------------------------------------------------------------
+// File: code_gen_target_perf_json.h
+// -------------------------------------------------------------
+//
+// The header file provides the interface to generate JSon files encoding
+// topdown formulas to be used by upstream perf.
+
+#ifndef TOPDOWN_PARSER_CODE_GEN_TARGET_PERF_JSON_H_
+#define TOPDOWN_PARSER_CODE_GEN_TARGET_PERF_JSON_H_
+
+#include "code_gen_target.h"
+
+namespace topdown_parser
+{
+/**
+ * Target information for generating JSon code for json perf encoding the
+ * topdown metric expressions.
+ */
+extern TargetInfo kTargetPerfJson;
+
+} // namespace topdown_parser
+
+#endif // TOPDOWN_PARSER_CODE_GEN_TARGET_PERF_JSON_H_
-- 
2.29.2.222.g5d2a92d10f8-goog
