From: Ian Rogers <irogers@google.com>
Subject: [RFC PATCH 03/12] perf topdown-paser: Add a CSV file reader.
Date: Tue, 10 Nov 2020 02:03:37 -0800
Message-ID: <20201110100346.2527031-4-irogers@google.com>
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

Read a CSV file info a two dimensional vector of vectors. Open
parentheses are counted so that expressions like "min(a,b)" aren't
split. Escape characters and quotations aren't handled.

Co-authored-by: Ian Rogers <irogers@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Sandeep Dasgupta <sdasgup@google.com>
---
 .../pmu-events/topdown-parser/csvreader.cpp   | 49 ++++++++++++++++++
 .../pmu-events/topdown-parser/csvreader.h     | 51 +++++++++++++++++++
 2 files changed, 100 insertions(+)
 create mode 100644 tools/perf/pmu-events/topdown-parser/csvreader.cpp
 create mode 100644 tools/perf/pmu-events/topdown-parser/csvreader.h

diff --git a/tools/perf/pmu-events/topdown-parser/csvreader.cpp b/tools/perf/pmu-events/topdown-parser/csvreader.cpp
new file mode 100644
index 000000000000..142e0e7e5ce7
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/csvreader.cpp
@@ -0,0 +1,49 @@
+/*
+ * Copyright 2020 Google LLC.
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include "csvreader.h"
+
+#include <cassert>
+#include <algorithm>
+#include <fstream>
+
+#include "general_utils.h"
+#include "logging.h"
+
+namespace topdown_parser
+{
+std::vector<std::vector<std::string> > CsvReader::getData() const
+{
+	std::vector<std::vector<std::string> > dataList;
+	std::ifstream file(file_name_);
+	std::string line = "";
+	assert(file.is_open() && "unable to open csv file");
+
+	while (getline(file, line)) {
+		std::vector<std::string> tokens;
+		int opens = 0;
+		int closes = 0;
+		for (const std::string &str : Split(line, delimeter_)) {
+			std::string stripped_str = Strip(str, '"');
+			if (opens > closes) {
+				tokens.back() += ", " + stripped_str;
+			} else {
+				tokens.push_back(stripped_str);
+			}
+			opens += std::count(str.begin(), str.end(), '(');
+			closes += std::count(str.begin(), str.end(), ')');
+		}
+
+		dataList.push_back(tokens);
+	}
+
+	if (dataList.empty()) {
+		FATAL("Empty csv file" << file_name_);
+	}
+
+	return dataList;
+}
+
+} // namespace topdown_parser
diff --git a/tools/perf/pmu-events/topdown-parser/csvreader.h b/tools/perf/pmu-events/topdown-parser/csvreader.h
new file mode 100644
index 000000000000..a82470041145
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/csvreader.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+// ---------------------------------------------
+// File: csvheader.h
+// ---------------------------------------------
+//
+// The header file provides the interface for parsing csv file using
+// CsvReader::delimeter_ as the delimiter for parsing each line.
+//
+// The library provides the following utilities:
+//  `getData`: Reads the input csv file `file_name_` and parses its
+//             contents, based on the delimeter `delimeter_`, as strings.
+//             The parsed data is returned as a 2D vector, V, of strings such
+//             that V[r][c] is same as the value of the input csv file at row r
+//             and column c.
+//
+//             For example, with the following content of a csv file,
+//             a,b,c,
+//             1,2,3
+//             and delimiter as ',', the return value is
+//
+//             {
+//               {"a", "b", "c"},
+//               {"1", "2", "3"}
+//             }
+
+#ifndef TOPDOWN_PARSER_CSV_READER_H_
+#define TOPDOWN_PARSER_CSV_READER_H_
+
+#include <string>
+#include <vector>
+
+namespace topdown_parser
+{
+class CsvReader {
+    public:
+	explicit CsvReader(std::string fname, char delm = ',')
+		: file_name_(fname), delimeter_(delm)
+	{
+	}
+
+	std::vector<std::vector<std::string> > getData() const;
+
+    private:
+	const std::string file_name_;
+	const char delimeter_;
+};
+
+} // namespace topdown_parser
+
+#endif // TOPDOWN_PARSER_CSV_READER_H_
-- 
2.29.2.222.g5d2a92d10f8-goog
