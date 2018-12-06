From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/75] perf mmap: Map data buffer for preserving collected data
Date: Thu,  6 Dec 2018 18:25:05 -0300
Message-ID: <20181206212602.20474-19-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexey Budankov <alexey.budankov@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

The map->data buffer is used to preserve map->base profiling data for
writing to disk. AIO map->cblock is used to queue corresponding
map->data buffer for asynchronous writing.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/5fcda10c-6c63-68df-383a-c6d9e5d1f918@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c |  2 +-
 tools/perf/util/mmap.c   | 49 +++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/mmap.h   | 11 ++++++++-
 3 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 36526d229315..6f010b9f0a81 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1028,7 +1028,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	 * Its value is decided by evsel's write_backward.
 	 * So &mp should not be passed through const pointer.
 	 */
-	struct mmap_params mp;
+	struct mmap_params mp = { .nr_cblocks = 0 };
 
 	if (!evlist->mmap)
 		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index cdb95b3a1213..47cdc3ad6546 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -153,8 +153,55 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
 {
 }
 
+#ifdef HAVE_AIO_SUPPORT
+static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
+{
+	int delta_max;
+
+	if (mp->nr_cblocks) {
+		map->aio.data = malloc(perf_mmap__mmap_len(map));
+		if (!map->aio.data) {
+			pr_debug2("failed to allocate data buffer, error %m\n");
+			return -1;
+		}
+		/*
+		 * Use cblock.aio_fildes value different from -1
+		 * to denote started aio write operation on the
+		 * cblock so it requires explicit record__aio_sync()
+		 * call prior the cblock may be reused again.
+		 */
+		map->aio.cblock.aio_fildes = -1;
+		/*
+		 * Allocate cblock with max priority delta to
+		 * have faster aio write system calls.
+		 */
+		delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
+		map->aio.cblock.aio_reqprio = delta_max;
+	}
+
+	return 0;
+}
+
+static void perf_mmap__aio_munmap(struct perf_mmap *map)
+{
+	if (map->aio.data)
+		zfree(&map->aio.data);
+}
+#else
+static int perf_mmap__aio_mmap(struct perf_mmap *map __maybe_unused,
+			       struct mmap_params *mp __maybe_unused)
+{
+	return 0;
+}
+
+static void perf_mmap__aio_munmap(struct perf_mmap *map __maybe_unused)
+{
+}
+#endif
+
 void perf_mmap__munmap(struct perf_mmap *map)
 {
+	perf_mmap__aio_munmap(map);
 	if (map->base != NULL) {
 		munmap(map->base, perf_mmap__mmap_len(map));
 		map->base = NULL;
@@ -197,7 +244,7 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int c
 				&mp->auxtrace_mp, map->base, fd))
 		return -1;
 
-	return 0;
+	return perf_mmap__aio_mmap(map, mp);
 }
 
 static int overwrite_rb_find_range(void *buf, int mask, u64 *start, u64 *end)
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index cc5e2d6d17a9..3f10ad030c5e 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -6,6 +6,9 @@
 #include <linux/types.h>
 #include <linux/ring_buffer.h>
 #include <stdbool.h>
+#ifdef HAVE_AIO_SUPPORT
+#include <aio.h>
+#endif
 #include "auxtrace.h"
 #include "event.h"
 
@@ -26,6 +29,12 @@ struct perf_mmap {
 	bool		 overwrite;
 	struct auxtrace_mmap auxtrace_mmap;
 	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
+#ifdef HAVE_AIO_SUPPORT
+	struct {
+		void 		 *data;
+		struct aiocb	 cblock;
+	} aio;
+#endif
 };
 
 /*
@@ -57,7 +66,7 @@ enum bkw_mmap_state {
 };
 
 struct mmap_params {
-	int			    prot, mask;
+	int			    prot, mask, nr_cblocks;
 	struct auxtrace_mmap_params auxtrace_mp;
 };
 
-- 
2.19.2
