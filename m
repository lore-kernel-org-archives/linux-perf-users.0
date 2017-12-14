From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/34] perf evsel: Fix swap for samples with raw data
Date: Thu, 14 Dec 2017 14:42:40 -0300
Message-ID: <20171214174247.16841-28-acme@kernel.org>
References: <20171214174247.16841-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171214174247.16841-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

When we detect a different endianity we swap event before processing.
It's tricky for samples because we have no idea what's inside. We treat
it as an array of u64s, swap them and later on we swap back parts which
are different.

We mangle this way also the tracepoint raw data, which ends up in report
showing wrong data:

  1.95%  comm=Q^B pid=29285 prio=16777216 target_cpu=000
  1.67%  comm=l^B pid=0 prio=16777216 target_cpu=000

Luckily the traceevent library handles the endianity by itself (thank
you Steven!), so we can pass the RAW data directly in the other
endianity.

  2.51%  comm=beah-rhts-task pid=1175 prio=120 target_cpu=002
  2.23%  comm=kworker/0:0 pid=11566 prio=120 target_cpu=000

The fix is basically to swap back the raw data if different endianity is
detected.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20171129184346.3656-1-jolsa@kernel.org
[ Add util/memswap.c to python-ext-sources to link missing mem_bswap_64() ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c            | 20 +++++++++++++++++---
 tools/perf/util/python-ext-sources |  1 +
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4718f0a460df..1cf044cbae36 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -36,6 +36,7 @@
 #include "debug.h"
 #include "trace-event.h"
 #include "stat.h"
+#include "memswap.h"
 #include "util/parse-branch-options.h"
 
 #include "sane_ctype.h"
@@ -2131,14 +2132,27 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 	if (type & PERF_SAMPLE_RAW) {
 		OVERFLOW_CHECK_u64(array);
 		u.val64 = *array;
-		if (WARN_ONCE(swapped,
-			      "Endianness of raw data not corrected!\n")) {
-			/* undo swap of u64, then swap on individual u32s */
+
+		/*
+		 * Undo swap of u64, then swap on individual u32s,
+		 * get the size of the raw area and undo all of the
+		 * swap. The pevent interface handles endianity by
+		 * itself.
+		 */
+		if (swapped) {
 			u.val64 = bswap_64(u.val64);
 			u.val32[0] = bswap_32(u.val32[0]);
 			u.val32[1] = bswap_32(u.val32[1]);
 		}
 		data->raw_size = u.val32[0];
+
+		/*
+		 * The raw data is aligned on 64bits including the
+		 * u32 size, so it's safe to use mem_bswap_64.
+		 */
+		if (swapped)
+			mem_bswap_64((void *) array, data->raw_size);
+
 		array = (void *)array + sizeof(u32);
 
 		OVERFLOW_CHECK(array, data->raw_size, max_size);
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index b4f2f06722a7..7aa0ea64544e 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -10,6 +10,7 @@ util/ctype.c
 util/evlist.c
 util/evsel.c
 util/cpumap.c
+util/memswap.c
 util/mmap.c
 util/namespaces.c
 ../lib/bitmap.c
-- 
2.13.6
