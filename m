From: Ian Rogers <irogers@google.com>
Subject: [RFC PATCH 01/12] perf topdown-parser: Add a simple logging API.
Date: Tue, 10 Nov 2020 02:03:35 -0800
Message-ID: <20201110100346.2527031-2-irogers@google.com>
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

A logging API that is simpler but inspired by that in abseil.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Sandeep Dasgupta <sdasgup@google.com>
---
 .../perf/pmu-events/topdown-parser/logging.h  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 tools/perf/pmu-events/topdown-parser/logging.h

diff --git a/tools/perf/pmu-events/topdown-parser/logging.h b/tools/perf/pmu-events/topdown-parser/logging.h
new file mode 100644
index 000000000000..9942018c4c75
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/logging.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+// -------------------------------------
+// File: logging.h
+// -------------------------------------
+//
+// The header provides the macro defintion for logging errors/warnings
+
+#ifndef TOPDOWN_PARSER_LOGGING_H_
+#define TOPDOWN_PARSER_LOGGING_H_
+
+#include <iostream>
+
+#define INFO(msg) std::cout << "\033[1;35mInfo: " << msg << "\033[0m\n"
+#define ERROR(msg)                                                             \
+	std::cout << __FILE__ << ":" << __LINE__                               \
+		  << " \033[1;31mError: " << msg << "\033[0m\n"
+#define FATAL(msg)                                                             \
+	do {                                                                   \
+		std::cout << __FILE__ << ":" << __LINE__                       \
+			  << " \033[1;31mFatal: " << msg << "\033[0m\n";       \
+		exit(1);                                                       \
+	} while (false)
+
+#endif // TOPDOWN_PARSER_LOGGING_H_
-- 
2.29.2.222.g5d2a92d10f8-goog
