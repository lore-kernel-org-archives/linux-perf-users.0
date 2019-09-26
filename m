From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/66] libperf: Add 'overwrite' to 'struct perf_mmap'
Date: Wed, 25 Sep 2019 21:32:07 -0300
Message-ID: <20190926003244.13962-30-acme@kernel.org>
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

Move 'overwrite' from tools/perf's mmap to libperf's perf_mmap struct.

Committer notes:

Add stdbool.h as we start using 'bool'.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-17-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/mmap.h |  2 ++
 tools/perf/util/evlist.c               |  2 +-
 tools/perf/util/mmap.c                 | 12 ++++++------
 tools/perf/util/mmap.h                 |  1 -
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index ebf5b93754fd..47c09f375fb6 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -4,6 +4,7 @@
 
 #include <linux/refcount.h>
 #include <linux/types.h>
+#include <stdbool.h>
 
 /**
  * struct perf_mmap - perf's ring buffer mmap details
@@ -19,6 +20,7 @@ struct perf_mmap {
 	u64		 prev;
 	u64		 start;
 	u64		 end;
+	bool		 overwrite;
 };
 
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index d987e0e5d62b..16d47a420bc2 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -709,7 +709,7 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		map[i].core.fd = -1;
-		map[i].overwrite = overwrite;
+		map[i].core.overwrite = overwrite;
 		/*
 		 * When the perf_mmap() call is made we grab one refcount, plus
 		 * one extra to let perf_mmap__consume() get the last
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 6ce70ff005cb..a8850ce2c2ff 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -93,12 +93,12 @@ union perf_event *perf_mmap__read_event(struct mmap *map)
 		return NULL;
 
 	/* non-overwirte doesn't pause the ringbuffer */
-	if (!map->overwrite)
+	if (!map->core.overwrite)
 		map->core.end = perf_mmap__read_head(map);
 
 	event = perf_mmap__read(map, &map->core.start, map->core.end);
 
-	if (!map->overwrite)
+	if (!map->core.overwrite)
 		map->core.prev = map->core.start;
 
 	return event;
@@ -124,7 +124,7 @@ void perf_mmap__put(struct mmap *map)
 
 void perf_mmap__consume(struct mmap *map)
 {
-	if (!map->overwrite) {
+	if (!map->core.overwrite) {
 		u64 old = map->core.prev;
 
 		perf_mmap__write_tail(map, old);
@@ -447,15 +447,15 @@ static int __perf_mmap__read_init(struct mmap *md)
 	unsigned char *data = md->core.base + page_size;
 	unsigned long size;
 
-	md->core.start = md->overwrite ? head : old;
-	md->core.end = md->overwrite ? old : head;
+	md->core.start = md->core.overwrite ? head : old;
+	md->core.end = md->core.overwrite ? old : head;
 
 	if ((md->core.end - md->core.start) < md->flush)
 		return -EAGAIN;
 
 	size = md->core.end - md->core.start;
 	if (size > (unsigned long)(md->core.mask) + 1) {
-		if (!md->overwrite) {
+		if (!md->core.overwrite) {
 			WARN_ONCE(1, "failed to keep up with mmap data. (warn only once)\n");
 
 			md->core.prev = head;
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index a3dd53f2bfb8..d3e74c8da51a 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -22,7 +22,6 @@ struct aiocb;
  */
 struct mmap {
 	struct perf_mmap	core;
-	bool		 overwrite;
 	struct auxtrace_mmap auxtrace_mmap;
 	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
 #ifdef HAVE_AIO_SUPPORT
-- 
2.21.0
