From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/66] libperf: Add perf_mmap struct
Date: Wed, 25 Sep 2019 21:32:01 -0300
Message-ID: <20190926003244.13962-24-acme@kernel.org>
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

Add the perf_mmap struct to libperf.

The definition is added into:

  include/internal/mmap.h

which is not to be included by users, but shared within perf and
libperf.

Committer notes:

Remove unnecessary includes from tools/perf/lib/include/internal/mmap.h,
those will be readded as they become necessary, later in the series.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-11-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c |  2 +-
 tools/perf/arch/x86/util/intel-bts.c         |  2 +-
 tools/perf/arch/x86/util/intel-pt.c          |  2 +-
 tools/perf/builtin-record.c                  | 14 ++++++-------
 tools/perf/lib/include/internal/mmap.h       | 14 +++++++++++++
 tools/perf/util/mmap.c                       | 22 ++++++++++----------
 tools/perf/util/mmap.h                       |  7 ++++---
 7 files changed, 39 insertions(+), 24 deletions(-)
 create mode 100644 tools/perf/lib/include/internal/mmap.h

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index e1dd5f8894ba..bd404db94b3a 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -93,7 +93,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 
 	CHECK__(evlist__mmap(evlist, UINT_MAX));
 
-	pc = evlist->mmap[0].base;
+	pc = evlist->mmap[0].core.base;
 	ret = perf_read_tsc_conversion(pc, &tc);
 	if (ret) {
 		if (ret == -EOPNOTSUPP) {
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 64b409dad6e2..130925141369 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -78,7 +78,7 @@ static int intel_bts_info_fill(struct auxtrace_record *itr,
 	if (!session->evlist->nr_mmaps)
 		return -EINVAL;
 
-	pc = session->evlist->mmap[0].base;
+	pc = session->evlist->mmap[0].core.base;
 	if (pc) {
 		err = perf_read_tsc_conversion(pc, &tc);
 		if (err) {
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 6c139611d231..34d7118bf390 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -355,7 +355,7 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
 	if (!session->evlist->nr_mmaps)
 		return -EINVAL;
 
-	pc = session->evlist->mmap[0].base;
+	pc = session->evlist->mmap[0].core.base;
 	if (pc) {
 		err = perf_read_tsc_conversion(pc, &tc);
 		if (err) {
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 1bb3d91c6599..2520c0212275 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -261,7 +261,7 @@ static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size
 	struct record_aio *aio = to;
 
 	/*
-	 * map->base data pointed by buf is copied into free map->aio.data[] buffer
+	 * map->core.base data pointed by buf is copied into free map->aio.data[] buffer
 	 * to release space in the kernel buffer as fast as possible, calling
 	 * perf_mmap__consume() from perf_mmap__push() function.
 	 *
@@ -360,7 +360,7 @@ static void record__aio_mmap_read_sync(struct record *rec)
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		struct mmap *map = &maps[i];
 
-		if (map->base)
+		if (map->core.base)
 			record__aio_sync(map, true);
 	}
 }
@@ -970,7 +970,7 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
 		u64 flush = 0;
 		struct mmap *map = &maps[i];
 
-		if (map->base) {
+		if (map->core.base) {
 			record__adjust_affinity(rec, map);
 			if (synch) {
 				flush = map->flush;
@@ -1198,10 +1198,10 @@ static const struct perf_event_mmap_page *
 perf_evlist__pick_pc(struct evlist *evlist)
 {
 	if (evlist) {
-		if (evlist->mmap && evlist->mmap[0].base)
-			return evlist->mmap[0].base;
-		if (evlist->overwrite_mmap && evlist->overwrite_mmap[0].base)
-			return evlist->overwrite_mmap[0].base;
+		if (evlist->mmap && evlist->mmap[0].core.base)
+			return evlist->mmap[0].core.base;
+		if (evlist->overwrite_mmap && evlist->overwrite_mmap[0].core.base)
+			return evlist->overwrite_mmap[0].core.base;
 	}
 	return NULL;
 }
diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
new file mode 100644
index 000000000000..2ef051901f48
--- /dev/null
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_MMAP_H
+#define __LIBPERF_INTERNAL_MMAP_H
+
+/**
+ * struct perf_mmap - perf's ring buffer mmap details
+ *
+ * @refcnt - e.g. code using PERF_EVENT_IOC_SET_OUTPUT to share this
+ */
+struct perf_mmap {
+	void		*base;
+};
+
+#endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index f3b7c8b0fa90..76190b2edd78 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -31,7 +31,7 @@ size_t perf_mmap__mmap_len(struct mmap *map)
 static union perf_event *perf_mmap__read(struct mmap *map,
 					 u64 *startp, u64 end)
 {
-	unsigned char *data = map->base + page_size;
+	unsigned char *data = map->core.base + page_size;
 	union perf_event *event = NULL;
 	int diff = end - *startp;
 
@@ -116,7 +116,7 @@ void perf_mmap__get(struct mmap *map)
 
 void perf_mmap__put(struct mmap *map)
 {
-	BUG_ON(map->base && refcount_read(&map->refcnt) == 0);
+	BUG_ON(map->core.base && refcount_read(&map->refcnt) == 0);
 
 	if (refcount_dec_and_test(&map->refcnt))
 		perf_mmap__munmap(map);
@@ -317,9 +317,9 @@ void perf_mmap__munmap(struct mmap *map)
 		munmap(map->data, perf_mmap__mmap_len(map));
 		map->data = NULL;
 	}
-	if (map->base != NULL) {
-		munmap(map->base, perf_mmap__mmap_len(map));
-		map->base = NULL;
+	if (map->core.base != NULL) {
+		munmap(map->core.base, perf_mmap__mmap_len(map));
+		map->core.base = NULL;
 		map->fd = -1;
 		refcount_set(&map->refcnt, 0);
 	}
@@ -370,12 +370,12 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 	refcount_set(&map->refcnt, 2);
 	map->prev = 0;
 	map->mask = mp->mask;
-	map->base = mmap(NULL, perf_mmap__mmap_len(map), mp->prot,
+	map->core.base = mmap(NULL, perf_mmap__mmap_len(map), mp->prot,
 			 MAP_SHARED, fd, 0);
-	if (map->base == MAP_FAILED) {
+	if (map->core.base == MAP_FAILED) {
 		pr_debug2("failed to mmap perf event ring buffer, error %d\n",
 			  errno);
-		map->base = NULL;
+		map->core.base = NULL;
 		return -1;
 	}
 	map->fd = fd;
@@ -399,7 +399,7 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 	}
 
 	if (auxtrace_mmap__mmap(&map->auxtrace_mmap,
-				&mp->auxtrace_mp, map->base, fd))
+				&mp->auxtrace_mp, map->core.base, fd))
 		return -1;
 
 	return perf_mmap__aio_mmap(map, mp);
@@ -444,7 +444,7 @@ static int __perf_mmap__read_init(struct mmap *md)
 {
 	u64 head = perf_mmap__read_head(md);
 	u64 old = md->prev;
-	unsigned char *data = md->base + page_size;
+	unsigned char *data = md->core.base + page_size;
 	unsigned long size;
 
 	md->start = md->overwrite ? head : old;
@@ -489,7 +489,7 @@ int perf_mmap__push(struct mmap *md, void *to,
 		    int push(struct mmap *map, void *to, void *buf, size_t size))
 {
 	u64 head = perf_mmap__read_head(md);
-	unsigned char *data = md->base + page_size;
+	unsigned char *data = md->core.base + page_size;
 	unsigned long size;
 	void *buf;
 	int rc = 0;
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index ab086ede044a..d2f0ce581e2c 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -1,6 +1,7 @@
 #ifndef __PERF_MMAP_H
 #define __PERF_MMAP_H 1
 
+#include <internal/mmap.h>
 #include <linux/compiler.h>
 #include <linux/refcount.h>
 #include <linux/types.h>
@@ -20,7 +21,7 @@ struct aiocb;
  * @refcnt - e.g. code using PERF_EVENT_IOC_SET_OUTPUT to share this
  */
 struct mmap {
-	void		 *base;
+	struct perf_mmap	core;
 	int		 mask;
 	int		 fd;
 	int		 cpu;
@@ -60,12 +61,12 @@ void perf_mmap__consume(struct mmap *map);
 
 static inline u64 perf_mmap__read_head(struct mmap *mm)
 {
-	return ring_buffer_read_head(mm->base);
+	return ring_buffer_read_head(mm->core.base);
 }
 
 static inline void perf_mmap__write_tail(struct mmap *md, u64 tail)
 {
-	ring_buffer_write_tail(md->base, tail);
+	ring_buffer_write_tail(md->core.base, tail);
 }
 
 union perf_event *perf_mmap__read_forward(struct mmap *map);
-- 
2.21.0
