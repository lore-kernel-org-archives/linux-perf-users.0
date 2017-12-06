From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/36] perf mmap: Remove overwrite and check_messup from mmap read
Date: Wed,  6 Dec 2017 11:41:08 -0300
Message-ID: <20171206144115.15097-30-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Wang Nan <wangnan0@huawei.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Wang Nan <wangnan0@huawei.com>

All perf_mmap__read_forward() read from read-write ring buffer, so no
need check_messup. Reading from backward ring buffer doesn't require
check_messup because it never mess up. Cleanup arguments lists.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@intel.com>
Link: http://lkml.kernel.org/r/20171203020044.81680-6-wangnan0@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c |  2 +-
 tools/perf/util/mmap.c   | 28 ++++------------------------
 tools/perf/util/mmap.h   |  2 +-
 3 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index a59134fb141f..68c1f9546650 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -711,7 +711,7 @@ union perf_event *perf_evlist__mmap_read_forward(struct perf_evlist *evlist, int
 	 * No need for read-write ring buffer: kernel stop outputting when
 	 * it hit md->prev (perf_mmap__consume()).
 	 */
-	return perf_mmap__read_forward(md, false);
+	return perf_mmap__read_forward(md);
 }
 
 union perf_event *perf_evlist__mmap_read_backward(struct perf_evlist *evlist, int idx)
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 703ed41a9269..3f262e707a41 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -21,33 +21,13 @@ size_t perf_mmap__mmap_len(struct perf_mmap *map)
 }
 
 /* When check_messup is true, 'end' must points to a good entry */
-static union perf_event *perf_mmap__read(struct perf_mmap *map, bool check_messup,
+static union perf_event *perf_mmap__read(struct perf_mmap *map,
 					 u64 start, u64 end, u64 *prev)
 {
 	unsigned char *data = map->base + page_size;
 	union perf_event *event = NULL;
 	int diff = end - start;
 
-	if (check_messup) {
-		/*
-		 * If we're further behind than half the buffer, there's a chance
-		 * the writer will bite our tail and mess up the samples under us.
-		 *
-		 * If we somehow ended up ahead of the 'end', we got messed up.
-		 *
-		 * In either case, truncate and restart at 'end'.
-		 */
-		if (diff > map->mask / 2 || diff < 0) {
-			fprintf(stderr, "WARNING: failed to keep up with mmap data.\n");
-
-			/*
-			 * 'end' points to a known good entry, start there.
-			 */
-			start = end;
-			diff = 0;
-		}
-	}
-
 	if (diff >= (int)sizeof(event->header)) {
 		size_t size;
 
@@ -89,7 +69,7 @@ static union perf_event *perf_mmap__read(struct perf_mmap *map, bool check_messu
 	return event;
 }
 
-union perf_event *perf_mmap__read_forward(struct perf_mmap *map, bool check_messup)
+union perf_event *perf_mmap__read_forward(struct perf_mmap *map)
 {
 	u64 head;
 	u64 old = map->prev;
@@ -102,7 +82,7 @@ union perf_event *perf_mmap__read_forward(struct perf_mmap *map, bool check_mess
 
 	head = perf_mmap__read_head(map);
 
-	return perf_mmap__read(map, check_messup, old, head, &map->prev);
+	return perf_mmap__read(map, old, head, &map->prev);
 }
 
 union perf_event *perf_mmap__read_backward(struct perf_mmap *map)
@@ -138,7 +118,7 @@ union perf_event *perf_mmap__read_backward(struct perf_mmap *map)
 	else
 		end = head + map->mask + 1;
 
-	return perf_mmap__read(map, false, start, end, &map->prev);
+	return perf_mmap__read(map, start, end, &map->prev);
 }
 
 void perf_mmap__read_catchup(struct perf_mmap *map)
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 2c3d291785de..d640273b7762 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -86,7 +86,7 @@ static inline void perf_mmap__write_tail(struct perf_mmap *md, u64 tail)
 	pc->data_tail = tail;
 }
 
-union perf_event *perf_mmap__read_forward(struct perf_mmap *map, bool check_messup);
+union perf_event *perf_mmap__read_forward(struct perf_mmap *map);
 union perf_event *perf_mmap__read_backward(struct perf_mmap *map);
 
 int perf_mmap__push(struct perf_mmap *md, bool backward,
-- 
2.13.6
