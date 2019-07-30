From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 071/107] libperf: Move zalloc.o into libperf
Date: Mon, 29 Jul 2019 23:55:34 -0300
Message-ID: <20190730025610.22603-72-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We need it in both perf and libperf, thus moving it to libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-45-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Build               | 5 +++++
 tools/perf/util/Build              | 5 -----
 tools/perf/util/python-ext-sources | 1 -
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/lib/Build b/tools/perf/lib/Build
index b27c1543b046..faf64db13e37 100644
--- a/tools/perf/lib/Build
+++ b/tools/perf/lib/Build
@@ -3,3 +3,8 @@ libperf-y += cpumap.o
 libperf-y += threadmap.o
 libperf-y += evsel.o
 libperf-y += evlist.o
+libperf-y += zalloc.o
+
+$(OUTPUT)zalloc.o: ../../lib/zalloc.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 14f812bb07a7..08f670d21615 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -26,7 +26,6 @@ perf-y += rbtree.o
 perf-y += libstring.o
 perf-y += bitmap.o
 perf-y += hweight.o
-perf-y += zalloc.o
 perf-y += smt.o
 perf-y += strbuf.o
 perf-y += string.o
@@ -243,7 +242,3 @@ $(OUTPUT)util/hweight.o: ../lib/hweight.c FORCE
 $(OUTPUT)util/vsprintf.o: ../lib/vsprintf.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
-
-$(OUTPUT)util/zalloc.o: ../lib/zalloc.c FORCE
-	$(call rule_mkdir)
-	$(call if_changed_dep,cc_o_c)
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index ceb8afdf9a89..2237bac9fadb 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -18,7 +18,6 @@ util/namespaces.c
 ../lib/hweight.c
 ../lib/string.c
 ../lib/vsprintf.c
-../lib/zalloc.c
 util/thread_map.c
 util/util.c
 util/xyarray.c
-- 
2.21.0
