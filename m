From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 066/107] libperf: Add perf_evlist__add() function
Date: Mon, 29 Jul 2019 23:55:29 -0300
Message-ID: <20190730025610.22603-67-acme@kernel.org>
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

Add the perf_evlist__add() function to add a perf_evsel in a perf_evlist
struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-40-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c              | 7 +++++++
 tools/perf/lib/include/perf/evlist.h | 3 +++
 tools/perf/lib/libperf.map           | 1 +
 tools/perf/util/evlist.c             | 2 +-
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index fdc8c1894b37..e5f187fa4e57 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -2,8 +2,15 @@
 #include <perf/evlist.h>
 #include <linux/list.h>
 #include <internal/evlist.h>
+#include <internal/evsel.h>
 
 void perf_evlist__init(struct perf_evlist *evlist)
 {
 	INIT_LIST_HEAD(&evlist->entries);
 }
+
+void perf_evlist__add(struct perf_evlist *evlist,
+		      struct perf_evsel *evsel)
+{
+	list_add_tail(&evsel->node, &evlist->entries);
+}
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index 1ddfcca0bd01..6992568b14a0 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -5,7 +5,10 @@
 #include <perf/core.h>
 
 struct perf_evlist;
+struct perf_evsel;
 
 LIBPERF_API void perf_evlist__init(struct perf_evlist *evlist);
+LIBPERF_API void perf_evlist__add(struct perf_evlist *evlist,
+				  struct perf_evsel *evsel);
 
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 5ca6ff6fcdfa..06ccf31eb24d 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -11,6 +11,7 @@ LIBPERF_0.0.1 {
 		perf_thread_map__put;
 		perf_evsel__init;
 		perf_evlist__init;
+		perf_evlist__add;
 	local:
 		*;
 };
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f4aa6cf80559..f2b86f49ab8d 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -180,8 +180,8 @@ static void perf_evlist__propagate_maps(struct evlist *evlist)
 
 void evlist__add(struct evlist *evlist, struct evsel *entry)
 {
+	perf_evlist__add(&evlist->core, &entry->core);
 	entry->evlist = evlist;
-	list_add_tail(&entry->core.node, &evlist->core.entries);
 	entry->idx = evlist->nr_entries;
 	entry->tracking = !entry->idx;
 
-- 
2.21.0
