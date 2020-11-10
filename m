From: Ian Rogers <irogers@google.com>
Subject: [RFC PATCH 09/12] perf topdown-paser: Add code generation API.
Date: Tue, 10 Nov 2020 02:03:43 -0800
Message-ID: <20201110100346.2527031-10-irogers@google.com>
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

Add API that is called to generate code using all registered targets.

Co-authored-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Sandeep Dasgupta <sdasgup@google.com>
---
 .../topdown-parser/code_gen_target.cpp        | 51 ++++++++++++
 .../topdown-parser/code_gen_target.h          | 77 +++++++++++++++++++
 2 files changed, 128 insertions(+)
 create mode 100644 tools/perf/pmu-events/topdown-parser/code_gen_target.cpp
 create mode 100644 tools/perf/pmu-events/topdown-parser/code_gen_target.h

diff --git a/tools/perf/pmu-events/topdown-parser/code_gen_target.cpp b/tools/perf/pmu-events/topdown-parser/code_gen_target.cpp
new file mode 100644
index 000000000000..c6d7ce8eb661
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/code_gen_target.cpp
@@ -0,0 +1,51 @@
+/*
+ * Copyright 2020 Google LLC.
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include "code_gen_target.h"
+
+#include "configuration.h"
+
+namespace topdown_parser
+{
+/**
+ * Dump event list. Used for testing of auto-generation.
+ */
+bool g_DumpEvents = false;
+
+namespace
+{
+/**
+ * `kRegisteredTargets` enumerates all the target supported by the
+ * topdown generator tool. Each target is responsible for generating a
+ * "code", which essentially encodes the topdown metric expressions, in
+ * a particular language or format support.
+ */
+TargetInfo *kRegisteredTargets[] = {
+	&kTargetPerfJson /* target to generate JSon code */,
+};
+
+} // namespace
+
+void CodeGenTarget(
+	const std::unordered_map<std::string, MappedData> &dependence_dag)
+{
+	for (size_t i = 0;
+	     i < sizeof(kRegisteredTargets) / sizeof(TargetInfo *); ++i) {
+		const std::string &target_name = kRegisteredTargets[i]->name;
+
+		if (target_name == kConfigParams->target_) {
+			kRegisteredTargets[i]->codegen_entry_point(
+				dependence_dag);
+			if (kRegisteredTargets[i]
+				    ->codegen_test_harness_entry_point) {
+				kRegisteredTargets[i]
+					->codegen_test_harness_entry_point();
+			}
+			break;
+		}
+	}
+}
+
+} // namespace topdown_parser
diff --git a/tools/perf/pmu-events/topdown-parser/code_gen_target.h b/tools/perf/pmu-events/topdown-parser/code_gen_target.h
new file mode 100644
index 000000000000..ab3e2b48bebc
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/code_gen_target.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+// --------------------------------------------------
+// File: code_gen_target.h
+// --------------------------------------------------
+//
+
+// The header provides the interface `CodeGenTarget` to generate code, encoding
+// the topdown metric expressions, using the data `dependence_dag` read from
+// the input csv file. The language or format of the generated code is the one
+// supported by a specific project (e.g. perf or projects using perf ) to encode
+// the topdown metric metric expressions. We define a `target` as a specific
+// project and use that to guide generation of topdown code in a language
+// supported by the project.
+
+#ifndef TOPDOWN_PARSER_CODE_GEN_TARGET_H_
+#define TOPDOWN_PARSER_CODE_GEN_TARGET_H_
+
+#include <string>
+#include <unordered_map>
+
+namespace topdown_parser
+{
+class MappedData;
+
+/**
+ * Dump event list. Used for testing of auto-generation.
+ */
+extern bool g_DumpEvents;
+
+/**
+ * The structure `TargetInfo` is used to specify a target.
+ */
+struct TargetInfo {
+	/**
+	 * Name of the target. This will be used to invoke code generation for a
+	 * particular target.
+	 */
+	std::string name;
+
+	/**
+	 * Descriptive information of the target (Optional).
+	 */
+	std::string description;
+
+	/**
+	 * The entry point function for generating code.
+	 */
+	void (*codegen_entry_point)(
+		const std::unordered_map<std::string, MappedData>
+			&dependence_dag);
+
+	/**
+	 * Function to generate golden reference for testing the auto-generated
+	 * code.
+	 * (Optional)
+	 */
+	void (*codegen_test_harness_entry_point)();
+};
+
+/**
+ * Target information for generating JSon code for perf encoding the topdown
+ * metric expressions.
+ */
+extern TargetInfo kTargetPerfJson;
+
+/**
+ * `CodeGenTarget` dispatches an appropriate callback, based on the
+ * configuration variable `kConfigParams->target_`, to generate  "code" for a
+ * particular target.
+ */
+void CodeGenTarget(
+	const std::unordered_map<std::string, MappedData> &dependence_dag);
+
+} // namespace topdown_parser
+
+#endif // TOPDOWN_PARSER_CODE_GEN_TARGET_H_
-- 
2.29.2.222.g5d2a92d10f8-goog
