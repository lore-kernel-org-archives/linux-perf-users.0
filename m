From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 44/57] libperf: Move mmap allocation to perf_evlist__mmap_ops::get
Date: Mon, 21 Oct 2019 10:38:21 -0300
Message-ID: <20191021133834.25998-45-acme@kernel.org>
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

Move allocation of the mmap array into perf_evlist__mmap_ops::get, to
centralize the mmap allocation.

Also move nr_mmap setup to perf_evlist__mmap_ops so it's centralized and
shared by both perf and libperf mmap code.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20191017105918.20873-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c  | 42 ++++++++++++++++++++++++----------------
 tools/perf/util/evlist.c | 24 +++++++++--------------
 2 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 854efff1519d..73aac6bb2ac5 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -338,10 +338,6 @@ static struct perf_mmap* perf_evlist__alloc_mmap(struct perf_evlist *evlist, boo
 	int i;
 	struct perf_mmap *map;
 
-	evlist->nr_mmaps = perf_cpu_map__nr(evlist->cpus);
-	if (perf_cpu_map__empty(evlist->cpus))
-		evlist->nr_mmaps = perf_thread_map__nr(evlist->threads);
-
 	map = zalloc(evlist->nr_mmaps * sizeof(struct perf_mmap));
 	if (!map)
 		return NULL;
@@ -384,18 +380,22 @@ static void perf_evlist__set_sid_idx(struct perf_evlist *evlist,
 static struct perf_mmap*
 perf_evlist__mmap_cb_get(struct perf_evlist *evlist, bool overwrite, int idx)
 {
-	struct perf_mmap *map = &evlist->mmap[idx];
+	struct perf_mmap *maps;
 
-	if (overwrite) {
-		if (!evlist->mmap_ovw) {
-			evlist->mmap_ovw = perf_evlist__alloc_mmap(evlist, true);
-			if (!evlist->mmap_ovw)
-				return NULL;
-		}
-		map = &evlist->mmap_ovw[idx];
+	maps = overwrite ? evlist->mmap_ovw : evlist->mmap;
+
+	if (!maps) {
+		maps = perf_evlist__alloc_mmap(evlist, overwrite);
+		if (!maps)
+			return NULL;
+
+		if (overwrite)
+			evlist->mmap_ovw = maps;
+		else
+			evlist->mmap = maps;
 	}
 
-	return map;
+	return &maps[idx];
 }
 
 #define FD(e, x, y) (*(int *) xyarray__entry(e->fd, x, y))
@@ -556,6 +556,17 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 	return -1;
 }
 
+static int perf_evlist__nr_mmaps(struct perf_evlist *evlist)
+{
+	int nr_mmaps;
+
+	nr_mmaps = perf_cpu_map__nr(evlist->cpus);
+	if (perf_cpu_map__empty(evlist->cpus))
+		nr_mmaps = perf_thread_map__nr(evlist->threads);
+
+	return nr_mmaps;
+}
+
 int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 			  struct perf_evlist_mmap_ops *ops,
 			  struct perf_mmap_param *mp)
@@ -567,10 +578,7 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 	if (!ops || !ops->get || !ops->mmap)
 		return -EINVAL;
 
-	if (!evlist->mmap)
-		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
-	if (!evlist->mmap)
-		return -ENOMEM;
+	evlist->nr_mmaps = perf_evlist__nr_mmaps(evlist);
 
 	perf_evlist__for_each_entry(evlist, evsel) {
 		if ((evsel->attr.read_format & PERF_FORMAT_ID) &&
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 6cda5a311ba5..5cded4ec5806 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -599,9 +599,6 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 	int i;
 	struct mmap *map;
 
-	evlist->core.nr_mmaps = perf_cpu_map__nr(evlist->core.cpus);
-	if (perf_cpu_map__empty(evlist->core.cpus))
-		evlist->core.nr_mmaps = perf_thread_map__nr(evlist->core.threads);
 	map = zalloc(evlist->core.nr_mmaps * sizeof(struct mmap));
 	if (!map)
 		return NULL;
@@ -639,19 +636,21 @@ static struct perf_mmap*
 perf_evlist__mmap_cb_get(struct perf_evlist *_evlist, bool overwrite, int idx)
 {
 	struct evlist *evlist = container_of(_evlist, struct evlist, core);
-	struct mmap *maps = evlist->mmap;
+	struct mmap *maps;
 
-	if (overwrite) {
-		maps = evlist->overwrite_mmap;
+	maps = overwrite ? evlist->overwrite_mmap : evlist->mmap;
 
-		if (!maps) {
-			maps = evlist__alloc_mmap(evlist, true);
-			if (!maps)
-				return NULL;
+	if (!maps) {
+		maps = evlist__alloc_mmap(evlist, overwrite);
+		if (!maps)
+			return NULL;
 
+		if (overwrite) {
 			evlist->overwrite_mmap = maps;
 			if (evlist->bkw_mmap_state == BKW_MMAP_NOTREADY)
 				perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_RUNNING);
+		} else {
+			evlist->mmap = maps;
 		}
 	}
 
@@ -812,11 +811,6 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 		.mmap = perf_evlist__mmap_cb_mmap,
 	};
 
-	if (!evlist->mmap)
-		evlist->mmap = evlist__alloc_mmap(evlist, false);
-	if (!evlist->mmap)
-		return -ENOMEM;
-
 	evlist->core.mmap_len = evlist__mmap_size(pages);
 	pr_debug("mmap size %zuB\n", evlist->core.mmap_len);
 	mp.core.mask = evlist->core.mmap_len - page_size - 1;
-- 
2.21.0
