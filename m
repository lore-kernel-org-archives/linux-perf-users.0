From: Ian Rogers <irogers@google.com>
Subject: [RFC PATCH 08/12] perf topdown-parser: Add event interface.
Date: Tue, 10 Nov 2020 02:03:42 -0800
Message-ID: <20201110100346.2527031-9-irogers@google.com>
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

Add an ability to load then query events loaded from json files. Events
may be loaded from a single json file, such as on
download.01.org/perfmon, are from multiple json files within a
directory.

Co-authored-by: Ian Rogers <irogers@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Sandeep Dasgupta <sdasgup@google.com>
---
 .../pmu-events/topdown-parser/event_info.cpp  | 443 ++++++++++++++++++
 .../pmu-events/topdown-parser/event_info.h    | 114 +++++
 2 files changed, 557 insertions(+)
 create mode 100644 tools/perf/pmu-events/topdown-parser/event_info.cpp
 create mode 100644 tools/perf/pmu-events/topdown-parser/event_info.h

diff --git a/tools/perf/pmu-events/topdown-parser/event_info.cpp b/tools/perf/pmu-events/topdown-parser/event_info.cpp
new file mode 100644
index 000000000000..c5a6fa305fcb
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/event_info.cpp
@@ -0,0 +1,443 @@
+/*
+ * Copyright 2020 Google LLC.
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include "event_info.h"
+
+#include <dirent.h>
+
+#include <regex>
+
+#include "configuration.h"
+#include "dependence_dag_utils.h"
+#include "expr_parser-bison.hpp"
+#include "general_utils.h"
+#include "jsmn_extras.h"
+#include "logging.h"
+
+namespace topdown_parser
+{
+namespace
+{
+/**
+ * g_EventInfoMap stores, the event information `EventInfo`
+ * corresponsing to an event name and a cpu, using the following map
+ * structure.
+ *
+ *    CPU -> (Event Name -> "Meta Information of that event")
+ *
+ * The data-structure is useful for querying event name for a particular
+ * cpu.
+ */
+using EventNameToEventInfo = std::unordered_map<std::string, EventInfo>;
+using CPUToEventInfo = std::unordered_map<std::string, EventNameToEventInfo>;
+CPUToEventInfo *g_EventInfoMap = nullptr;
+
+/**
+ * Initialize globals.
+ */
+void InitGlobals()
+{
+	if (g_EventInfoMap == nullptr) {
+		g_EventInfoMap = new std::unordered_map<
+			std::string,
+			std::unordered_map<std::string, EventInfo> >;
+	}
+}
+
+/**
+ * SearchEvent implements the algorithm to search event E for CPU 'cpu'
+ */
+bool SearchEvent(const std::string &cpu, const std::string &event_token,
+		 const EventInfo **event_data)
+{
+	// If there is no event encoding map for 'cpu', return false;
+	if (g_EventInfoMap->count(cpu) == 0) {
+		return false;
+	}
+
+	// If there is event encoding map for 'cpu' and event is found
+	// in the map, return true;
+	if (g_EventInfoMap->at(cpu).count(event_token)) {
+		*event_data = &g_EventInfoMap->at(cpu).at(event_token);
+		return true;
+	}
+
+	// At this point, we have an event encoding map for 'cpu', but
+	// event is NOT found in the map. Check for the alias CPUs and
+	// search for the event in their encoding  maps.
+	for (auto &alias_set : *g_CpuAliasesForEventInfo) {
+		// Go over all the alias sets and find the one where
+		// `cpu` belongs.
+		if (alias_set.count(cpu) == 0) {
+			continue;
+		}
+
+		for (auto &alias : alias_set) {
+			if (alias == cpu) {
+				continue;
+			}
+			if (g_EventInfoMap->count(alias) &&
+			    g_EventInfoMap->at(alias).count(event_token)) {
+				*event_data = &g_EventInfoMap->at(alias).at(
+					event_token);
+				return true;
+			}
+		}
+	}
+
+	return false;
+}
+
+void PopulateEventInfoMap(const char *js, const jsmntok_t *t, int r,
+			  void *metainfo)
+{
+	std::unordered_map<std::string, EventInfo> *event_info =
+		(std::unordered_map<std::string, EventInfo> *)metainfo;
+
+	// Events are organized as an array of objects of key value pairs.
+	for (int i = 1; i < r;) {
+		if (t[i].type != JSMN_OBJECT) {
+			continue;
+		}
+		int size = t[i].size;
+		i++;
+		std::unordered_map<std::string, std::string> working_set;
+		for (int j = 0; j < size; j += 2) {
+			std::pair<std::string, std::string> key_val;
+			i = get_key_val(js, t, i, &key_val);
+			i++;
+			working_set[key_val.first] = key_val.second;
+		}
+		auto name = working_set.find("EventName");
+		if (name != working_set.end()) {
+			(*event_info)[name->second] = EventInfo(
+				name->second, working_set["EventCode"],
+				working_set["UMask"], working_set["MSRValue"],
+				working_set["CounterMask"],
+				working_set["Invert"], working_set["AnyThread"],
+				working_set["EdgeDetect"],
+				working_set["Errata"]);
+		}
+	}
+}
+
+/**
+ * Extract the event information `event_info` like EventName, EventCode.
+ * etc from the event encoding json file `json_fname`.
+ */
+int ReadEventInfoFromJson(const char *json_fname,
+			  std::unordered_map<std::string, EventInfo> *event_info)
+{
+	return ParseJson(json_fname, &PopulateEventInfoMap, event_info);
+}
+
+/**
+ * ProcessEventFiles does the following: 1. Read the version number of
+ * each Json file.  2. Print the candidate Json files for each CPU and
+ * mark the selected one with (*).  3. Read the event information from
+ * each Json file for a particular cpu and populate the`g_EventInfoMap`
+ */
+void ProcessEventFiles(
+	const std::unordered_map<std::string, std::vector<std::string> >
+		&cpu_to_json_filelist)
+{
+	for (const auto &entry : cpu_to_json_filelist) {
+		const std::string &cpu = entry.first;
+		const std::vector<std::string> &json_files = entry.second;
+		std::unordered_map<std::string, EventInfo> event_info;
+		for (const auto &jname : json_files) {
+			ReadEventInfoFromJson(jname.c_str(), &event_info);
+		}
+		g_EventInfoMap->insert(
+			std::pair<std::string,
+				  std::unordered_map<std::string, EventInfo> >(
+				cpu, event_info));
+	}
+}
+
+/**
+ * Check if every permissible CPU has a Json file hint associated with
+ * it.  If a particular CPU, CPUX does not have a Json hint, we check
+ * for alias CPUs, (like CPUX/CPUY as mentioned in the csv file), and
+ * assign the Json file hint of the alias, CPUY, to the CPU CPUX.
+ */
+void CheckJsonEventHints()
+{
+	// Check if the Json event file hints are provided for each
+	// CPUs.
+	for (auto &cpu : *g_RelevantCpus) {
+		if (kConfigParams->json_filename_hints_.count(cpu) == 0) {
+			// Check for any alias to cpu
+			bool json_filename_hint_found = false;
+			for (auto &alias_set : *g_CpuAliasesForEventInfo) {
+				if (alias_set.count(cpu) == 0) {
+					continue;
+				}
+
+				for (auto &alias : alias_set) {
+					if (alias == cpu) {
+						continue;
+					}
+					if (0 !=
+					    kConfigParams->json_filename_hints_
+						    .count(alias)) {
+						kConfigParams
+							->json_filename_hints_
+								[cpu] =
+							kConfigParams
+								->json_filename_hints_
+									[alias];
+						json_filename_hint_found = true;
+						INFO("Using the same "
+						     "Json file hint: \""
+						     << kConfigParams
+								->json_filename_hints_
+									[alias]
+						     << "\" for alias CPUs: "
+						     << alias << ", " << cpu);
+						break;
+					}
+				}
+			}
+
+			if (json_filename_hint_found) {
+				continue;
+			}
+
+			ERROR("Unspecified json filename hint for cpu: "
+			      << cpu);
+			INFO("Specify a substring of the json file name"
+			     "in 'kConfigParams->json_filename_hints_' "
+			     "data structure in configuration file."
+			     "Else put the cpu into "
+			     "'dont_care_cpus' in configuration file.");
+			exit(1);
+		}
+	}
+}
+
+/**
+ * Preprocess cell contents.
+ */
+std::vector<std::string> NormalizeFormula(const std::string &str)
+{
+	std::vector<std::string> body_tokens;
+
+	if (!str.length()) {
+		return body_tokens;
+	}
+
+	// Make the cell content amenable to split based on
+	// whitespace.
+	std::string cell_content;
+	size_t cursor = 0;
+	yy::parser parser(str, &cursor, false /* convert if stmt */,
+			  false /* Remove false branch */,
+			  false /* wrap div operator in a function */,
+			  &cell_content);
+	if (parser.parse())
+		FATAL("Parsing error");
+
+	// Split the cell content based on whitespace.
+	body_tokens = WhitespaceSplit(cell_content);
+
+	return body_tokens;
+}
+
+} // namespace
+
+bool GetEventInfo(const std::string &input_str, const std::string &cpu,
+		  const EventInfo **event_data,
+		  std::vector<std::string> *tokens)
+{
+	std::string str(input_str);
+
+	// Check if the token is of the form
+	//    OFFCORE_RESPONSE:request=A:response=B
+	// Replace it with OFFCORE_RESPONSE.A.B
+	if (regex_search(str, std::regex("OFFCORE_RESPONSE"))) {
+		str = regex_replace(str, std::regex(":request="), ".");
+		str = regex_replace(str, std::regex(":response="), ".");
+	}
+
+	// Handle PEBS event.
+	std::string event_token = regex_replace(str, std::regex("_PS$"), "");
+
+	// Check if the token is of form  'evt:c1:e1'; Extract the 'evt' part.
+	if (regex_search(str, std::regex("\\:"))) {
+		*tokens = Split(str, ':');
+		if (tokens->size() < 2) {
+			FATAL("Event Token: \"" << input_str
+						<< "\" is not well formed:");
+		}
+		event_token = (*tokens)[0];
+	}
+
+	// Search the event token among known events.
+	return SearchEvent(cpu, event_token, event_data);
+}
+
+void ProcessEventEncodings()
+{
+	InitGlobals();
+
+	// Check if all the permissible CPU has a Json file hint associated with
+	// it.
+	CheckJsonEventHints();
+
+	std::unordered_map<std::string, std::vector<std::string> >
+		cpu_to_json_filelist;
+	std::vector<std::string> event_data_dirs(
+		{ kConfigParams->event_data_dir_ });
+
+	while (!event_data_dirs.empty()) {
+		std::string dir_str = event_data_dirs.back();
+		event_data_dirs.pop_back();
+		std::unique_ptr<DIR, std::function<int(DIR *)> > dir(
+			opendir(dir_str.c_str()), closedir);
+		if (dir == nullptr) {
+			FATAL("Cannot open data directory: " << dir_str);
+		}
+		for (struct dirent *ent = readdir(dir.get()); ent != nullptr;
+		     ent = readdir(dir.get())) {
+			std::string fname = std::string(ent->d_name);
+			if (ent->d_type == DT_DIR) {
+				if (fname[0] != '.') {
+					event_data_dirs.push_back(dir_str +
+								  fname + "/");
+				}
+				continue;
+			}
+			if (fname.find("json") == std::string::npos) {
+				continue;
+			}
+			for (auto &cpu : *g_RelevantCpus) {
+				const std::string &json_hint =
+					kConfigParams->json_filename_hints_.at(
+						cpu);
+				if (dir_str.find(json_hint + "/") ==
+				    std::string::npos) {
+					continue;
+				}
+				cpu_to_json_filelist[cpu].push_back(dir_str +
+								    fname);
+			}
+		}
+	}
+
+	// Check if all the CPU got a event encoding Json file.
+	for (auto &cpu : *g_RelevantCpus) {
+		if (cpu_to_json_filelist.count(cpu) == 0) {
+			ERROR("Missing Json file for CPU: " << cpu);
+			INFO("In case no Json files are available for a CPU, "
+			     "put the CPU into "
+			     "'dont_care_cpus' in configuration file.");
+		}
+	}
+
+	ProcessEventFiles(cpu_to_json_filelist);
+}
+
+std::set<std::string>
+FindEvents(const std::string &token,
+	   const std::unordered_map<std::string, MappedData> &dependence_dag,
+	   const std::string &cpu)
+{
+	std::string search_key = token + "_" + cpu;
+	std::set<std::string> eventlist;
+
+	// Check if the 'token' corresponds to a metric.
+	if (dependence_dag.count(search_key) != 0) {
+		assert(dependence_dag.at(search_key).prefix_ != "Info.System" &&
+		       "A Topdown formula referring to \'Info.System\'");
+		std::vector<std::string> body_tokens = NormalizeFormula(
+			dependence_dag.at(search_key).cell_content_);
+		for (auto &body_token : body_tokens) {
+			std::set<std::string> evlist =
+				FindEvents(body_token, dependence_dag, cpu);
+			eventlist.insert(evlist.begin(), evlist.end());
+		}
+		return eventlist;
+	}
+
+	// Check if the token is an operator, constant, or "NA".
+	if (IsOperator(token) || IsConstant(token) || token == "#NA" ||
+	    token == "NA" || token == "N/A") {
+		return eventlist;
+	}
+
+	// At this point 'token' could be en event.
+	// Check if it is an event. If yes, then get the event information.
+	const EventInfo *event_data;
+	std::vector<std::string> tokens;
+	if (GetEventInfo(token, cpu, &event_data, &tokens)) {
+		eventlist.insert(token);
+	}
+
+	// At this point we might have token like
+	// 1. CPU names which arise out of parsing input csv entries like
+	// "#Model in ['SKL' 'KBL']" Such csv entries will be processed later
+	// using `NormalizeModel`
+	// 2. We would error out any expected tokens in `ComputeBodyFormula`
+	// where we will have more context around the error.
+	return eventlist;
+}
+
+std::set<std::string>
+FindErrata(const std::string &token,
+	   const std::unordered_map<std::string, MappedData> &dependence_dag,
+	   const std::string &cpu)
+{
+	std::string search_key = token + "_" + cpu;
+	std::set<std::string> erratalist;
+
+	// Check if the 'token' corresponds to a metric.
+	if (dependence_dag.count(search_key) > 0) {
+		assert(dependence_dag.at(search_key).prefix_ != "Info.System" &&
+		       "A Topdown formula referring to \'Info.System\'");
+		std::vector<std::string> body_tokens = NormalizeFormula(
+			dependence_dag.at(search_key).cell_content_);
+		for (auto &body_token : body_tokens) {
+			std::set<std::string> errlist =
+				FindErrata(body_token, dependence_dag, cpu);
+			erratalist.insert(errlist.begin(), errlist.end());
+		}
+		return erratalist;
+	}
+
+	// Check if the token is an operator, constant, or "NA".
+	if (IsOperator(token) || IsConstant(token) || token == "#NA" ||
+	    token == "NA" || token == "N/A") {
+		return erratalist;
+	}
+
+	// At this point 'token' could be en event.
+	// Check if it is an event.
+	const EventInfo *event_data;
+	std::vector<std::string> tokens;
+	if (GetEventInfo(token, cpu, &event_data, &tokens)) {
+		const std::string &errata = event_data->errata_;
+		if (errata != "0" && errata != "null" && errata != "nullptr") {
+			if (regex_search(errata, std::regex(","))) {
+				tokens = Split(errata, ',');
+				for (auto &token : tokens) {
+					erratalist.insert(token);
+				}
+			} else {
+				erratalist.insert(errata);
+			}
+		}
+	}
+
+	// At this point we might have token like
+	// 1. CPU names which arise out of parsing input csv entries like
+	// "#Model in ['SKL' 'KBL']" Such csv entries will be processed later
+	// using `NormalizeModel`
+	// 2. We would error out any expected tokens in `ComputeBodyFormula`
+	// where we will have more context around the error.
+	return erratalist;
+}
+
+} // namespace topdown_parser
diff --git a/tools/perf/pmu-events/topdown-parser/event_info.h b/tools/perf/pmu-events/topdown-parser/event_info.h
new file mode 100644
index 000000000000..b5b7d1521fe2
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/event_info.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+// ---------------------------------------------
+// File: event_info.h
+// ---------------------------------------------
+//
+// The header provides the interface to
+// (1) Read/process the events information from event encoding JSon files.
+// (2) Query events information using an event name.
+
+#ifndef TOPDOWN_PARSER_EVENT_INFO_H_
+#define TOPDOWN_PARSER_EVENT_INFO_H_
+
+#include <time.h>
+
+#include <map>
+#include <set>
+#include <string>
+#include <unordered_map>
+#include <vector>
+
+namespace topdown_parser
+{
+class MappedData;
+
+/**
+ * The following data-structure is used to store the various meta information
+ * of an event.
+ */
+class EventInfo {
+    public:
+	std::string eventname_;
+	std::string eventcode_;
+	std::string umask_;
+	std::string msrvalue_;
+	std::string countermask_;
+	std::string invert_;
+	std::string anythread_;
+	std::string edgedetect_;
+	std::string errata_;
+
+	bool operator==(const EventInfo &ei)
+	{
+		return eventname_ == ei.eventname_ &&
+		       eventcode_ == ei.eventcode_ && umask_ == ei.umask_ &&
+		       eventcode_ == ei.eventcode_ &&
+		       msrvalue_ == ei.msrvalue_ && invert_ == ei.invert_ &&
+		       anythread_ == ei.anythread_ &&
+		       edgedetect_ == ei.edgedetect_ && errata_ == ei.errata_;
+	}
+
+	bool operator!=(const EventInfo &ei)
+	{
+		return !(*this == ei);
+	}
+	EventInfo() = default;
+	EventInfo(const std::string &en, const std::string &ec,
+		  const std::string &um, const std::string &msrv,
+		  const std::string &cm, const std::string &i,
+		  const std::string &at, const std::string &ed,
+		  const std::string &er)
+		: eventname_(en), eventcode_(ec), umask_(um), msrvalue_(msrv),
+		  countermask_(cm), invert_(i), anythread_(at), edgedetect_(ed),
+		  errata_(er)
+	{
+	}
+};
+
+/**
+ * Query the information for a event `input_str` for a cpu `cpu`. The
+ * `EventInfo` information is stored in 'event_data'.
+ * If the token is of form  'evt:c1:e1', we tokenize it based on delimiter ':'
+ * and return the tokens. The tokens are used by some downstream functions, like
+ * GetEventString, to extract more information about the event.
+ */
+bool GetEventInfo(const std::string &input_str, const std::string &cpu,
+		  const EventInfo **event_data,
+		  std::vector<std::string> *tokens);
+
+/**
+ * Read and process the json files specifying the event encodings
+ */
+void ProcessEventEncodings();
+
+/**
+ * If `token` is the name of a metric, then 'FindEvents' returns a list of
+ * events used in the metric expression of that metric. If the metric expression
+ * contains sub-metrics, then 'FindEvents' recursive finds the events in those
+ * sub-metrics as well. An empty
+ * list is returned if `token` is not a metric name. The function uses
+ * `dependence_dag` (an in-memory model to store the input csv file
+ * information) and `cpu` to check if the `token` is a metric or not.
+ */
+std::set<std::string>
+FindEvents(const std::string &token,
+	   const std::unordered_map<std::string, MappedData> &dependence_dag,
+	   const std::string &cpu);
+
+/**
+ * If `token` is the name of a metric, then 'FindErrata' returns a list of
+ * errata corresponding to events used in the metric expression of that metric.
+ * If the metric expression contains sub-metrics, then 'FindEvents' recursive
+ * finds the errata for those sub-metrics as well. An empty list is returned if
+ * `token` is not a metric name. The function uses `dependence_dag` (an
+ * in-memory model to store the input csv file information) and `cpu` to check
+ * if the `token` is a metric or not.
+ */
+std::set<std::string>
+FindErrata(const std::string &token,
+	   const std::unordered_map<std::string, MappedData> &dependence_dag,
+	   const std::string &cpu);
+
+} // namespace topdown_parser
+#endif // TOPDOWN_PARSER_EVENT_INFO_H_
-- 
2.29.2.222.g5d2a92d10f8-goog
