From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH v2 14/14] perf util: enable handling of inlined frames by default
Date: Sun,  6 Aug 2017 23:24:46 +0200
Message-ID: <20170806212446.24925-15-milian.wolff@kdab.com>
References: <20170806212446.24925-1-milian.wolff@kdab.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170806212446.24925-1-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Now that we have caches in place to speed up the process of finding
inlined frames and srcline information repeatedly, we can enable
this useful option by default.

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Yao Jin <yao.jin@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/Documentation/perf-report.txt | 3 ++-
 tools/perf/Documentation/perf-script.txt | 3 ++-
 tools/perf/util/symbol.c                 | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 9fa84617181e..8d5834a837d8 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -433,7 +433,8 @@ include::itrace.txt[]
 
 --inline::
 	If a callgraph address belongs to an inlined function, the inline stack
-	will be printed. Each entry is function name or file/line.
+	will be printed. Each entry is function name or file/line. Enabled by
+	default, disable with --no-inline.
 
 include::callchain-overhead-calculation.txt[]
 
diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 5ee8796be96e..683242ad15a2 100644
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
index 971b990557b4..7b8d9981588e 100644
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
2.13.3
