From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 074/107] libperf: Add perf_evlist__for_each_evsel() iterator
Date: Mon, 29 Jul 2019 23:55:37 -0300
Message-ID: <20190730025610.22603-75-acme@kernel.org>
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

Add a perf_evlist__for_each_evsel() macro to iterate perf_evsel objects
in evlist.

Introduce the perf_evlist__next() function to do that without exposing
'struct perf_evlist' internals.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-48-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c              | 20 ++++++++++++++++++++
 tools/perf/lib/include/perf/evlist.h |  7 +++++++
 tools/perf/lib/libperf.map           |  1 +
 3 files changed, 28 insertions(+)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 0517deb4cb1c..979ee423490f 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -34,3 +34,23 @@ struct perf_evlist *perf_evlist__new(void)
 
 	return evlist;
 }
+
+struct perf_evsel *
+perf_evlist__next(struct perf_evlist *evlist, struct perf_evsel *prev)
+{
+	struct perf_evsel *next;
+
+	if (!prev) {
+		next = list_first_entry(&evlist->entries,
+					struct perf_evsel,
+					node);
+	} else {
+		next = list_next_entry(prev, node);
+	}
+
+	/* Empty list is noticed here so don't need checking on entry. */
+	if (&next->node == &evlist->entries)
+		return NULL;
+
+	return next;
+}
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index 7255a60869a1..5092b622935b 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -13,5 +13,12 @@ LIBPERF_API void perf_evlist__add(struct perf_evlist *evlist,
 LIBPERF_API void perf_evlist__remove(struct perf_evlist *evlist,
 				     struct perf_evsel *evsel);
 LIBPERF_API struct perf_evlist *perf_evlist__new(void);
+LIBPERF_API struct perf_evsel* perf_evlist__next(struct perf_evlist *evlist,
+						 struct perf_evsel *evsel);
+
+#define perf_evlist__for_each_evsel(evlist, pos)	\
+	for ((pos) = perf_evlist__next((evlist), NULL);	\
+	     (pos) != NULL;				\
+	     (pos) = perf_evlist__next((evlist), (pos)))
 
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index e3eac9b60726..c0968226f7b6 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -17,6 +17,7 @@ LIBPERF_0.0.1 {
 		perf_evlist__init;
 		perf_evlist__add;
 		perf_evlist__remove;
+		perf_evlist__next;
 	local:
 		*;
 };
-- 
2.21.0
