From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 095/107] libperf: Adopt simplified perf_evlist__open()/close() functions from tools/perf
Date: Mon, 29 Jul 2019 23:55:58 -0300
Message-ID: <20190730025610.22603-96-acme@kernel.org>
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

Add the following functions:

  perf_evlist__open()
  perf_evlist__close()

It's a simplified version of perf's evlist__open() without the sampling
id index calculations. We can try to merge it in the future when we need
it in some new libperf user.

Also adopt some helper evlist traversing macros. In the future we can
remove them from util/evlist.h, but that requires also some other
changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-69-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c                  | 27 +++++++++++++++++++
 tools/perf/lib/include/internal/evlist.h | 34 ++++++++++++++++++++++++
 tools/perf/lib/include/perf/evlist.h     |  2 ++
 tools/perf/lib/libperf.map               |  2 ++
 4 files changed, 65 insertions(+)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 6a2308ef9868..5dda96b1d4da 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <perf/evlist.h>
+#include <perf/evsel.h>
 #include <linux/list.h>
 #include <internal/evlist.h>
 #include <internal/evsel.h>
@@ -114,3 +115,29 @@ void perf_evlist__set_maps(struct perf_evlist *evlist,
 
 	perf_evlist__propagate_maps(evlist);
 }
+
+int perf_evlist__open(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel;
+	int err;
+
+	perf_evlist__for_each_entry(evlist, evsel) {
+		err = perf_evsel__open(evsel, evsel->cpus, evsel->threads);
+		if (err < 0)
+			goto out_err;
+	}
+
+	return 0;
+
+out_err:
+	perf_evlist__close(evlist);
+	return err;
+}
+
+void perf_evlist__close(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel;
+
+	perf_evlist__for_each_entry_reverse(evlist, evsel)
+		perf_evsel__close(evsel);
+}
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index b7b43dbc9b82..448891f06e3e 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -2,6 +2,8 @@
 #ifndef __LIBPERF_INTERNAL_EVLIST_H
 #define __LIBPERF_INTERNAL_EVLIST_H
 
+#include <linux/list.h>
+
 struct perf_cpu_map;
 struct perf_thread_map;
 
@@ -13,4 +15,36 @@ struct perf_evlist {
 	struct perf_thread_map	*threads;
 };
 
+/**
+ * __perf_evlist__for_each_entry - iterate thru all the evsels
+ * @list: list_head instance to iterate
+ * @evsel: struct perf_evsel iterator
+ */
+#define __perf_evlist__for_each_entry(list, evsel) \
+	list_for_each_entry(evsel, list, node)
+
+/**
+ * evlist__for_each_entry - iterate thru all the evsels
+ * @evlist: perf_evlist instance to iterate
+ * @evsel: struct perf_evsel iterator
+ */
+#define perf_evlist__for_each_entry(evlist, evsel) \
+	__perf_evlist__for_each_entry(&(evlist)->entries, evsel)
+
+/**
+ * __perf_evlist__for_each_entry_reverse - iterate thru all the evsels in reverse order
+ * @list: list_head instance to iterate
+ * @evsel: struct evsel iterator
+ */
+#define __perf_evlist__for_each_entry_reverse(list, evsel) \
+	list_for_each_entry_reverse(evsel, list, node)
+
+/**
+ * perf_evlist__for_each_entry_reverse - iterate thru all the evsels in reverse order
+ * @evlist: evlist instance to iterate
+ * @evsel: struct evsel iterator
+ */
+#define perf_evlist__for_each_entry_reverse(evlist, evsel) \
+	__perf_evlist__for_each_entry_reverse(&(evlist)->entries, evsel)
+
 #endif /* __LIBPERF_INTERNAL_EVLIST_H */
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index b1d8dee018d6..6d3dda743541 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -18,6 +18,8 @@ LIBPERF_API struct perf_evlist *perf_evlist__new(void);
 LIBPERF_API void perf_evlist__delete(struct perf_evlist *evlist);
 LIBPERF_API struct perf_evsel* perf_evlist__next(struct perf_evlist *evlist,
 						 struct perf_evsel *evsel);
+LIBPERF_API int perf_evlist__open(struct perf_evlist *evlist);
+LIBPERF_API void perf_evlist__close(struct perf_evlist *evlist);
 
 #define perf_evlist__for_each_evsel(evlist, pos)	\
 	for ((pos) = perf_evlist__next((evlist), NULL);	\
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 9f43b5cda031..4f966ddd5e53 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -25,6 +25,8 @@ LIBPERF_0.0.1 {
 		perf_evsel__threads;
 		perf_evlist__new;
 		perf_evlist__delete;
+		perf_evlist__open;
+		perf_evlist__close;
 		perf_evlist__init;
 		perf_evlist__add;
 		perf_evlist__remove;
-- 
2.21.0
