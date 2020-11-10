From: Ian Rogers <irogers@google.com>
Subject: [RFC PATCH 11/12] perf topdown-parser: Main driver.
Date: Tue, 10 Nov 2020 02:03:45 -0800
Message-ID: <20201110100346.2527031-12-irogers@google.com>
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

Invoke the necessary configuration reading and parsing, then code
generation. Handles command line arguments.
Add a minor README.

Co-authored-by: Stephane Eranian <eranian@google.com>
Co-authored-by: Ian Rogers <irogers@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Sandeep Dasgupta <sdasgup@google.com>
---
 tools/perf/pmu-events/topdown-parser/README   |   5 +
 .../topdown-parser/topdown_parser_main.cpp    | 155 ++++++++++++++++++
 2 files changed, 160 insertions(+)
 create mode 100644 tools/perf/pmu-events/topdown-parser/README
 create mode 100644 tools/perf/pmu-events/topdown-parser/topdown_parser_main.cpp

diff --git a/tools/perf/pmu-events/topdown-parser/README b/tools/perf/pmu-events/topdown-parser/README
new file mode 100644
index 000000000000..7f100792b00c
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/README
@@ -0,0 +1,5 @@
+Topdown parser and code generator
+=================================
+
+The topdown parser processes a TMA_Metrics.csv file and generates
+Intel specific metrics from the data in the spreadsheet cells.
\ No newline at end of file
diff --git a/tools/perf/pmu-events/topdown-parser/topdown_parser_main.cpp b/tools/perf/pmu-events/topdown-parser/topdown_parser_main.cpp
new file mode 100644
index 000000000000..ba9acd32726e
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/topdown_parser_main.cpp
@@ -0,0 +1,155 @@
+/*
+ * Copyright 2020 Google LLC.
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <getopt.h>
+#include <stdlib.h>
+
+#include <iostream>
+#include <string>
+#include <unordered_map>
+#include <vector>
+
+#include "code_gen_target.h"
+#include "configuration.h"
+#include "csvreader.h"
+#include "dependence_dag_utils.h"
+#include "event_info.h"
+#include "logging.h"
+
+namespace topdown_parser
+{
+namespace
+{
+/**
+ * Printing usage model
+ */
+[[noreturn]] void ShowUsage()
+{
+	std::cout
+		<< "\n"
+		   " Usage: topdown_parser  --csv-file <csv input file>\n"
+		   "                         --events-data-dir <path of event "
+		   "encoding JSon files>\n"
+		   "                         --config-file <path to "
+		   "configuration.json>\n"
+		   "                         --output-path <path to "
+		   "output the topdown file(s)>\n"
+		   "                         [Options]\n"
+		   " Synopsis: Auto-generates topdown.c \n\n"
+		   " Options\n"
+		   "\t--dump-events :    Dump the unique events for each metric.\n"
+		   "generated topdown file. Used for testing.\n"
+		   "\t--help        :    Show help\n";
+	exit(0);
+}
+
+/**
+ * The input csv file name specifying formula encoding for topdown
+ * metric
+ */
+char *g_CsvFile = nullptr;
+
+/**
+ * ProcessArgs parses command-line arguments
+ */
+bool ProcessArgs(int argc, char **argv)
+{
+	// The following command-line arguments to the program
+	// todown_parser are required: --csv-file <file>,
+	// --events-data-dir <dir>, --config-file <file> --output-path
+	// <path>
+	if (argc < 9) {
+		ShowUsage();
+		return false;
+	}
+
+	const char *const short_opts = "f:a:z:hdt";
+	const option long_opts[] = {
+		{ "csv-file", required_argument, nullptr, 'f' },
+		{ "events-data-dir", required_argument, nullptr, 'a' },
+		{ "config-file", required_argument, nullptr, 'z' },
+		{ "output-path", required_argument, nullptr, 'o' },
+		{ "dump-events", no_argument, nullptr, 'd' },
+		{ "help", no_argument, nullptr, 'h' },
+		{ nullptr, no_argument, nullptr, 0 }
+	};
+
+	while (true) {
+		const auto opt =
+			getopt_long(argc, argv, short_opts, long_opts, nullptr);
+
+		if (opt == -1)
+			break;
+
+		switch (opt) {
+		case 'f':
+			g_CsvFile = optarg;
+			break;
+
+		case 'a':
+			kConfigParams->event_data_dir_ = optarg;
+			kConfigParams->event_data_dir_ += "/";
+			break;
+
+		case 'z':
+			kConfigParams->config_file_ = optarg;
+			break;
+
+		case 'o':
+			kConfigParams->output_path_ = optarg;
+			break;
+
+		case 'd':
+			g_DumpEvents = true;
+			break;
+
+		case 'h':
+		case '?':
+		default:
+			ShowUsage();
+			return false;
+		}
+	}
+
+	INFO("csv filename: |" << g_CsvFile << "|");
+	INFO("events data dir: |" << kConfigParams->event_data_dir_ << "|");
+	INFO("config file : |" << kConfigParams->config_file_ << "|");
+	return true;
+}
+
+} // namespace
+
+} // namespace topdown_parser
+
+/**
+ * Main driver function for generating topdown files.
+ */
+int main(int argc, char *argv[])
+{
+	bool process_arg_stat = topdown_parser::ProcessArgs(argc, argv);
+	if (!process_arg_stat) {
+		FATAL("Failed to process the command-line arguments");
+	}
+
+	// Read the configuration file "configuration.json"
+	int read_config_stat = topdown_parser::ReadConfig();
+	if (read_config_stat != 0) {
+		FATAL("Failed to read configuration file");
+	}
+
+	// Read the input csv file
+	topdown_parser::CsvReader reader(topdown_parser::g_CsvFile);
+	std::vector<std::vector<std::string> > records = reader.getData();
+	std::unordered_map<std::string, topdown_parser::MappedData>
+		dependence_dag = topdown_parser::ProcessRecords(&records);
+
+	// Read and process the json files specifying the event encodings
+	topdown_parser::ProcessEventEncodings();
+
+	// Generate topdown files for a specific target (or purpose)
+	topdown_parser::CodeGenTarget(dependence_dag);
+
+	return 0;
+}
-- 
2.29.2.222.g5d2a92d10f8-goog
