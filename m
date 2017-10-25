From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/15] perf util: Enable handling of inlined frames by default
Date: Wed, 25 Oct 2017 13:00:13 -0300
Message-ID: <20171025160013.11136-16-acme@kernel.org>
References: <20171025160013.11136-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171025160013.11136-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Milian Wolff <milian.wolff@kdab.com>

Now that we have caches in place to speed up the process of finding
inlined frames and srcline information repeatedly, we can enable this
useful option by default.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171019113836.5548-6-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt | 3 ++-
 tools/perf/Documentation/perf-script.txt | 3 ++-
 tools/perf/util/symbol.c                 | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 383a98d992ed..ddde2b54af57 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -434,7 +434,8 @@ include::itrace.txt[]
 
 --inline::
 	If a callgraph address belongs to an inlined function, the inline stack
-	will be printed. Each entry is function name or file/line.
+	will be printed. Each entry is function name or file/line. Enabled by
+	default, disable with --no-inline.
 
 include::callchain-overhead-calculation.txt[]
 
diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index bcc1ba35a2d8..25e677344728 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -327,7 +327,8 @@ include::itrace.txt[]
 
 --inline::
 	If a callgraph address belongs to an inlined function, the inline stack
-	will be printed. Each entry has function name and file/line.
+	will be printed. Each entry has function name and file/line. Enabled by
+	default, disable with --no-inline.
 
 SEE ALSO
 --------
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 066e38aa4063..ce6993bebf8c 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -45,6 +45,7 @@ struct symbol_conf symbol_conf = {
 	.show_hist_headers	= true,
 	.symfs			= "",
 	.event_group		= true,
+	.inline_name		= true,
 };
 
 static enum dso_binary_type binary_type_symtab[] = {
-- 
2.13.6
