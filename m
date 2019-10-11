From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 66/69] libperf: Introduce perf_evlist__purge()
Date: Fri, 11 Oct 2019 17:05:56 -0300
Message-ID: <20191011200559.7156-67-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add a static perf_evlist__purge() function to purge evsels from a evlist.

Add also perf_evlist__for_each_entry_safe() which is used by
perf_evlist__purge().

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-26-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c                  | 13 +++++++++++++
 tools/perf/lib/include/internal/evlist.h | 18 ++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 7ba98f0e6365..9534ad9a572f 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -109,6 +109,18 @@ perf_evlist__next(struct perf_evlist *evlist, struct perf_evsel *prev)
 	return next;
 }
 
+static void perf_evlist__purge(struct perf_evlist *evlist)
+{
+	struct perf_evsel *pos, *n;
+
+	perf_evlist__for_each_entry_safe(evlist, n, pos) {
+		list_del_init(&pos->node);
+		perf_evsel__delete(pos);
+	}
+
+	evlist->nr_entries = 0;
+}
+
 void perf_evlist__exit(struct perf_evlist *evlist)
 {
 	perf_cpu_map__put(evlist->cpus);
@@ -125,6 +137,7 @@ void perf_evlist__delete(struct perf_evlist *evlist)
 
 	perf_evlist__munmap(evlist);
 	perf_evlist__close(evlist);
+	perf_evlist__purge(evlist);
 	perf_evlist__exit(evlist);
 	free(evlist);
 }
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 0721512ffb19..be0b25a70730 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -82,6 +82,24 @@ void perf_evlist__exit(struct perf_evlist *evlist);
 #define perf_evlist__for_each_entry_reverse(evlist, evsel) \
 	__perf_evlist__for_each_entry_reverse(&(evlist)->entries, evsel)
 
+/**
+ * __perf_evlist__for_each_entry_safe - safely iterate thru all the evsels
+ * @list: list_head instance to iterate
+ * @tmp: struct evsel temp iterator
+ * @evsel: struct evsel iterator
+ */
+#define __perf_evlist__for_each_entry_safe(list, tmp, evsel) \
+	list_for_each_entry_safe(evsel, tmp, list, node)
+
+/**
+ * perf_evlist__for_each_entry_safe - safely iterate thru all the evsels
+ * @evlist: evlist instance to iterate
+ * @evsel: struct evsel iterator
+ * @tmp: struct evsel temp iterator
+ */
+#define perf_evlist__for_each_entry_safe(evlist, tmp, evsel) \
+	__perf_evlist__for_each_entry_safe(&(evlist)->entries, tmp, evsel)
+
 static inline struct perf_evsel *perf_evlist__first(struct perf_evlist *evlist)
 {
 	return list_entry(evlist->entries.next, struct perf_evsel, node);
-- 
2.21.0
