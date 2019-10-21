From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 43/57] libperf: Introduce perf_evlist__for_each_mmap()
Date: Mon, 21 Oct 2019 10:38:20 -0300
Message-ID: <20191021133834.25998-44-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add the perf_evlist__for_each_mmap() function and export it in the
perf/evlist.h header, so that the user can iterate through 'struct
perf_mmap' objects.

Add a internal perf_mmap__link() function to do the actual linking.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20191017105918.20873-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c                  | 26 +++++++++++++++++++++++-
 tools/perf/lib/include/internal/evlist.h |  2 ++
 tools/perf/lib/include/internal/mmap.h   |  5 +++--
 tools/perf/lib/include/perf/evlist.h     |  9 ++++++++
 tools/perf/lib/libperf.map               |  1 +
 tools/perf/lib/mmap.c                    |  6 ++++--
 tools/perf/util/evlist.c                 |  4 +++-
 7 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 65045614c938..854efff1519d 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -347,6 +347,8 @@ static struct perf_mmap* perf_evlist__alloc_mmap(struct perf_evlist *evlist, boo
 		return NULL;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
+		struct perf_mmap *prev = i ? &map[i - 1] : NULL;
+
 		/*
 		 * When the perf_mmap() call is made we grab one refcount, plus
 		 * one extra to let perf_mmap__consume() get the last
@@ -356,7 +358,7 @@ static struct perf_mmap* perf_evlist__alloc_mmap(struct perf_evlist *evlist, boo
 		 * Each PERF_EVENT_IOC_SET_OUTPUT points to this mmap and
 		 * thus does perf_mmap__get() on it.
 		 */
-		perf_mmap__init(&map[i], overwrite, NULL);
+		perf_mmap__init(&map[i], prev, overwrite, NULL);
 	}
 
 	return map;
@@ -405,6 +407,15 @@ perf_evlist__mmap_cb_mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
 	return perf_mmap__mmap(map, mp, output, cpu);
 }
 
+static void perf_evlist__set_mmap_first(struct perf_evlist *evlist, struct perf_mmap *map,
+					bool overwrite)
+{
+	if (overwrite)
+		evlist->mmap_ovw_first = map;
+	else
+		evlist->mmap_first = map;
+}
+
 static int
 mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 	       int idx, struct perf_mmap_param *mp, int cpu_idx,
@@ -460,6 +471,9 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 
 			if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
 				return -1;
+
+			if (!idx)
+				perf_evlist__set_mmap_first(evlist, map, overwrite);
 		} else {
 			if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
 				return -1;
@@ -605,3 +619,13 @@ void perf_evlist__munmap(struct perf_evlist *evlist)
 	zfree(&evlist->mmap);
 	zfree(&evlist->mmap_ovw);
 }
+
+struct perf_mmap*
+perf_evlist__next_mmap(struct perf_evlist *evlist, struct perf_mmap *map,
+		       bool overwrite)
+{
+	if (map)
+		return map->next;
+
+	return overwrite ? evlist->mmap_ovw_first : evlist->mmap_first;
+}
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index be0b25a70730..20d90e29fc0e 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -25,6 +25,8 @@ struct perf_evlist {
 	struct hlist_head	 heads[PERF_EVLIST__HLIST_SIZE];
 	struct perf_mmap	*mmap;
 	struct perf_mmap	*mmap_ovw;
+	struct perf_mmap	*mmap_first;
+	struct perf_mmap	*mmap_ovw_first;
 };
 
 typedef void
diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index ee536c4441bb..be7556e0a2b2 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -32,6 +32,7 @@ struct perf_mmap {
 	u64			 flush;
 	libperf_unmap_cb_t	 unmap_cb;
 	char			 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
+	struct perf_mmap	*next;
 };
 
 struct perf_mmap_param {
@@ -41,8 +42,8 @@ struct perf_mmap_param {
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map);
 
-void perf_mmap__init(struct perf_mmap *map, bool overwrite,
-		     libperf_unmap_cb_t unmap_cb);
+void perf_mmap__init(struct perf_mmap *map, struct perf_mmap *prev,
+		     bool overwrite, libperf_unmap_cb_t unmap_cb);
 int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
 		    int fd, int cpu);
 void perf_mmap__munmap(struct perf_mmap *map);
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index 16f526e74d13..8c4b3c28535e 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -3,6 +3,7 @@
 #define __LIBPERF_EVLIST_H
 
 #include <perf/core.h>
+#include <stdbool.h>
 
 struct perf_evlist;
 struct perf_evsel;
@@ -38,4 +39,12 @@ LIBPERF_API int perf_evlist__filter_pollfd(struct perf_evlist *evlist,
 LIBPERF_API int perf_evlist__mmap(struct perf_evlist *evlist, int pages);
 LIBPERF_API void perf_evlist__munmap(struct perf_evlist *evlist);
 
+LIBPERF_API struct perf_mmap *perf_evlist__next_mmap(struct perf_evlist *evlist,
+						     struct perf_mmap *map,
+						     bool overwrite);
+#define perf_evlist__for_each_mmap(evlist, pos, overwrite)		\
+	for ((pos) = perf_evlist__next_mmap((evlist), NULL, overwrite);	\
+	     (pos) != NULL;						\
+	     (pos) = perf_evlist__next_mmap((evlist), (pos), overwrite))
+
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 2184aba36c3f..8be02afc324b 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -43,6 +43,7 @@ LIBPERF_0.0.1 {
 		perf_evlist__mmap;
 		perf_evlist__munmap;
 		perf_evlist__filter_pollfd;
+		perf_evlist__next_mmap;
 		perf_mmap__consume;
 		perf_mmap__read_init;
 		perf_mmap__read_done;
diff --git a/tools/perf/lib/mmap.c b/tools/perf/lib/mmap.c
index 0752c193b0fb..79d5ed6c38cc 100644
--- a/tools/perf/lib/mmap.c
+++ b/tools/perf/lib/mmap.c
@@ -13,13 +13,15 @@
 #include <linux/kernel.h>
 #include "internal.h"
 
-void perf_mmap__init(struct perf_mmap *map, bool overwrite,
-		     libperf_unmap_cb_t unmap_cb)
+void perf_mmap__init(struct perf_mmap *map, struct perf_mmap *prev,
+		     bool overwrite, libperf_unmap_cb_t unmap_cb)
 {
 	map->fd = -1;
 	map->overwrite = overwrite;
 	map->unmap_cb  = unmap_cb;
 	refcount_set(&map->refcnt, 0);
+	if (prev)
+		prev->next = map;
 }
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map)
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 0f9cd703e725..6cda5a311ba5 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -607,6 +607,8 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 		return NULL;
 
 	for (i = 0; i < evlist->core.nr_mmaps; i++) {
+		struct perf_mmap *prev = i ? &map[i - 1].core : NULL;
+
 		/*
 		 * When the perf_mmap() call is made we grab one refcount, plus
 		 * one extra to let perf_mmap__consume() get the last
@@ -616,7 +618,7 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 		 * Each PERF_EVENT_IOC_SET_OUTPUT points to this mmap and
 		 * thus does perf_mmap__get() on it.
 		 */
-		perf_mmap__init(&map[i].core, overwrite, perf_mmap__unmap_cb);
+		perf_mmap__init(&map[i].core, prev, overwrite, perf_mmap__unmap_cb);
 	}
 
 	return map;
-- 
2.21.0
