From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 44/66] libperf: Add perf_evlist__id_add() function
Date: Wed, 25 Sep 2019 21:32:22 -0300
Message-ID: <20190926003244.13962-45-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add the perf_evlist__id_add() function to libperf as an internal
function.  We already have the 'heads' member in 'struct perf_evlist'.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-31-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c                  | 26 ++++++++++++++++++++++++
 tools/perf/lib/include/internal/evlist.h |  4 ++++
 tools/perf/tests/event_update.c          |  2 +-
 tools/perf/util/evlist.c                 | 22 +-------------------
 tools/perf/util/evlist.h                 |  2 --
 tools/perf/util/header.c                 |  4 ++--
 6 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index ae861bf38976..a29ee8a746d9 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -1,9 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <perf/evlist.h>
 #include <perf/evsel.h>
+#include <linux/bitops.h>
 #include <linux/list.h>
+#include <linux/hash.h>
 #include <internal/evlist.h>
 #include <internal/evsel.h>
+#include <internal/xyarray.h>
 #include <linux/zalloc.h>
 #include <stdlib.h>
 #include <perf/cpumap.h>
@@ -168,3 +171,26 @@ u64 perf_evlist__read_format(struct perf_evlist *evlist)
 
 	return first->attr.read_format;
 }
+
+#define SID(e, x, y) xyarray__entry(e->sample_id, x, y)
+
+static void perf_evlist__id_hash(struct perf_evlist *evlist,
+				 struct perf_evsel *evsel,
+				 int cpu, int thread, u64 id)
+{
+	int hash;
+	struct perf_sample_id *sid = SID(evsel, cpu, thread);
+
+	sid->id = id;
+	sid->evsel = evsel;
+	hash = hash_64(sid->id, PERF_EVLIST__HLIST_BITS);
+	hlist_add_head(&sid->node, &evlist->heads[hash]);
+}
+
+void perf_evlist__id_add(struct perf_evlist *evlist,
+			 struct perf_evsel *evsel,
+			 int cpu, int thread, u64 id)
+{
+	perf_evlist__id_hash(evlist, evsel, cpu, thread, id);
+	evsel->id[evsel->ids++] = id;
+}
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 63516fe14f4c..649406f717bc 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -68,4 +68,8 @@ static inline struct perf_evsel *perf_evlist__last(struct perf_evlist *evlist)
 
 u64 perf_evlist__read_format(struct perf_evlist *evlist);
 
+void perf_evlist__id_add(struct perf_evlist *evlist,
+			 struct perf_evsel *evsel,
+			 int cpu, int thread, u64 id);
+
 #endif /* __LIBPERF_INTERNAL_EVLIST_H */
diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index cd6cae8e5137..c727379cf20e 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -97,7 +97,7 @@ int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unu
 	TEST_ASSERT_VAL("failed to allocate ids",
 			!perf_evsel__alloc_id(&evsel->core, 1, 1));
 
-	perf_evlist__id_add(evlist, evsel, 0, 0, 123);
+	perf_evlist__id_add(&evlist->core, &evsel->core, 0, 0, 123);
 
 	evsel->unit = strdup("KRAVA");
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index bc788192493f..f2863b4c61d7 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -461,26 +461,6 @@ int perf_evlist__poll(struct evlist *evlist, int timeout)
 	return fdarray__poll(&evlist->core.pollfd, timeout);
 }
 
-static void perf_evlist__id_hash(struct evlist *evlist,
-				 struct evsel *evsel,
-				 int cpu, int thread, u64 id)
-{
-	int hash;
-	struct perf_sample_id *sid = SID(evsel, cpu, thread);
-
-	sid->id = id;
-	sid->evsel = &evsel->core;
-	hash = hash_64(sid->id, PERF_EVLIST__HLIST_BITS);
-	hlist_add_head(&sid->node, &evlist->core.heads[hash]);
-}
-
-void perf_evlist__id_add(struct evlist *evlist, struct evsel *evsel,
-			 int cpu, int thread, u64 id)
-{
-	perf_evlist__id_hash(evlist, evsel, cpu, thread, id);
-	evsel->core.id[evsel->core.ids++] = id;
-}
-
 int perf_evlist__id_add_fd(struct evlist *evlist,
 			   struct evsel *evsel,
 			   int cpu, int thread, int fd)
@@ -518,7 +498,7 @@ int perf_evlist__id_add_fd(struct evlist *evlist,
 	id = read_data[id_idx];
 
  add:
-	perf_evlist__id_add(evlist, evsel, cpu, thread, id);
+	perf_evlist__id_add(&evlist->core, &evsel->core, cpu, thread, id);
 	return 0;
 }
 
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 3f89d9913a30..eb35b4b1d86f 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -141,8 +141,6 @@ struct evsel *
 perf_evlist__find_tracepoint_by_name(struct evlist *evlist,
 				     const char *name);
 
-void perf_evlist__id_add(struct evlist *evlist, struct evsel *evsel,
-			 int cpu, int thread, u64 id);
 int perf_evlist__id_add_fd(struct evlist *evlist,
 			   struct evsel *evsel,
 			   int cpu, int thread, int fd);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index fc5eac41e102..02602bc8cabf 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3618,7 +3618,7 @@ int perf_session__read_header(struct perf_session *session)
 			if (perf_header__getbuffer64(header, fd, &f_id, sizeof(f_id)))
 				goto out_errno;
 
-			perf_evlist__id_add(session->evlist, evsel, 0, j, f_id);
+			perf_evlist__id_add(&session->evlist->core, &evsel->core, 0, j, f_id);
 		}
 
 		lseek(fd, tmp, SEEK_SET);
@@ -3754,7 +3754,7 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 		return -ENOMEM;
 
 	for (i = 0; i < n_ids; i++) {
-		perf_evlist__id_add(evlist, evsel, 0, i, event->attr.id[i]);
+		perf_evlist__id_add(&evlist->core, &evsel->core, 0, i, event->attr.id[i]);
 	}
 
 	return 0;
-- 
2.21.0
