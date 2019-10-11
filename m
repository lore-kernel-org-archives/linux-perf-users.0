From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 57/69] libperf: Add perf_evlist_mmap_ops::get callback
Date: Fri, 11 Oct 2019 17:05:47 -0300
Message-ID: <20191011200559.7156-58-acme@kernel.org>
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

Add the perf_evlist_mmap_ops::get callback to be called in
mmap_per_evsel() to get/allocate the 'struct perf_mmap' object.

Add the libperf's perf_evlist__mmap_cb_get() function as libperf's get
callback.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-17-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c                  | 18 ++++++++++--------
 tools/perf/lib/include/internal/evlist.h |  3 +++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 3832d3e9a3b4..4f49de5e8f7c 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -340,7 +340,7 @@ static void perf_evlist__set_sid_idx(struct perf_evlist *evlist,
 }
 
 static struct perf_mmap*
-perf_evlist__map_get(struct perf_evlist *evlist, bool overwrite, int idx)
+perf_evlist__mmap_cb_get(struct perf_evlist *evlist, bool overwrite, int idx)
 {
 	struct perf_mmap *map = &evlist->mmap[idx];
 
@@ -359,8 +359,8 @@ perf_evlist__map_get(struct perf_evlist *evlist, bool overwrite, int idx)
 #define FD(e, x, y) (*(int *) xyarray__entry(e->fd, x, y))
 
 static int
-mmap_per_evsel(struct perf_evlist *evlist, int idx,
-	       struct perf_mmap_param *mp, int cpu_idx,
+mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
+	       int idx, struct perf_mmap_param *mp, int cpu_idx,
 	       int thread, int *_output, int *_output_overwrite)
 {
 	int evlist_cpu = perf_cpu_map__cpu(evlist->cpus, cpu_idx);
@@ -379,7 +379,7 @@ mmap_per_evsel(struct perf_evlist *evlist, int idx,
 		if (cpu == -1)
 			continue;
 
-		map = perf_evlist__map_get(evlist, overwrite, idx);
+		map = ops->get(evlist, overwrite, idx);
 		if (map == NULL)
 			return -ENOMEM;
 
@@ -439,7 +439,7 @@ mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 		if (ops->idx)
 			ops->idx(evlist, mp, thread, false);
 
-		if (mmap_per_evsel(evlist, thread, mp, 0, thread,
+		if (mmap_per_evsel(evlist, ops, thread, mp, 0, thread,
 				   &output, &output_overwrite))
 			goto out_unmap;
 	}
@@ -467,7 +467,7 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 			ops->idx(evlist, mp, cpu, true);
 
 		for (thread = 0; thread < nr_threads; thread++) {
-			if (mmap_per_evsel(evlist, cpu, mp, cpu,
+			if (mmap_per_evsel(evlist, ops, cpu, mp, cpu,
 					   thread, &output, &output_overwrite))
 				goto out_unmap;
 		}
@@ -488,7 +488,7 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 	const struct perf_cpu_map *cpus = evlist->cpus;
 	const struct perf_thread_map *threads = evlist->threads;
 
-	if (!ops)
+	if (!ops || !ops->get)
 		return -EINVAL;
 
 	if (!evlist->mmap)
@@ -512,7 +512,9 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
 {
 	struct perf_mmap_param mp;
-	struct perf_evlist_mmap_ops ops = { 0 };
+	struct perf_evlist_mmap_ops ops = {
+		.get = perf_evlist__mmap_cb_get,
+	};
 
 	evlist->mmap_len = (pages + 1) * page_size;
 	mp.mask = evlist->mmap_len - page_size - 1;
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 053f620696f3..9bc3a21643ea 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -29,9 +29,12 @@ struct perf_evlist {
 
 typedef void
 (*perf_evlist_mmap__cb_idx_t)(struct perf_evlist*, struct perf_mmap_param*, int, bool);
+typedef struct perf_mmap*
+(*perf_evlist_mmap__cb_get_t)(struct perf_evlist*, bool, int);
 
 struct perf_evlist_mmap_ops {
 	perf_evlist_mmap__cb_idx_t	idx;
+	perf_evlist_mmap__cb_get_t	get;
 };
 
 int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
-- 
2.21.0
