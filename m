From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 072/107] libperf: Add perf_evlist__new() function
Date: Mon, 29 Jul 2019 23:55:35 -0300
Message-ID: <20190730025610.22603-73-acme@kernel.org>
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

Add perf_evlist__new() function to create and init a perf_evlist struct
dynamicaly.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-46-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c              | 11 +++++++++++
 tools/perf/lib/include/perf/evlist.h |  1 +
 tools/perf/lib/libperf.map           |  1 +
 3 files changed, 13 insertions(+)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 1b27fd2de9b9..0517deb4cb1c 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -3,6 +3,7 @@
 #include <linux/list.h>
 #include <internal/evlist.h>
 #include <internal/evsel.h>
+#include <linux/zalloc.h>
 
 void perf_evlist__init(struct perf_evlist *evlist)
 {
@@ -23,3 +24,13 @@ void perf_evlist__remove(struct perf_evlist *evlist,
 	list_del_init(&evsel->node);
 	evlist->nr_entries -= 1;
 }
+
+struct perf_evlist *perf_evlist__new(void)
+{
+	struct perf_evlist *evlist = zalloc(sizeof(*evlist));
+
+	if (evlist != NULL)
+		perf_evlist__init(evlist);
+
+	return evlist;
+}
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index e0c87995c6ff..7255a60869a1 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -12,5 +12,6 @@ LIBPERF_API void perf_evlist__add(struct perf_evlist *evlist,
 				  struct perf_evsel *evsel);
 LIBPERF_API void perf_evlist__remove(struct perf_evlist *evlist,
 				     struct perf_evsel *evsel);
+LIBPERF_API struct perf_evlist *perf_evlist__new(void);
 
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index e38473a8f32f..5e685d6c7a95 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -12,6 +12,7 @@ LIBPERF_0.0.1 {
 		perf_thread_map__get;
 		perf_thread_map__put;
 		perf_evsel__init;
+		perf_evlist__new;
 		perf_evlist__init;
 		perf_evlist__add;
 		perf_evlist__remove;
-- 
2.21.0
