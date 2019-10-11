From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 64/69] libperf: Move the pollfd allocation from tools/perf to libperf
Date: Fri, 11 Oct 2019 17:05:54 -0300
Message-ID: <20191011200559.7156-65-acme@kernel.org>
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

It's needed in libperf only, so move it to the perf_evlist__mmap_ops()
function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-24-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c  | 5 +++++
 tools/perf/util/evlist.c | 4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index f9a802d2ceb5..5ae1da97d2e6 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -34,6 +34,7 @@ void perf_evlist__init(struct perf_evlist *evlist)
 		INIT_HLIST_HEAD(&evlist->heads[i]);
 	INIT_LIST_HEAD(&evlist->entries);
 	evlist->nr_entries = 0;
+	fdarray__init(&evlist->pollfd, 64);
 }
 
 static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
@@ -114,6 +115,7 @@ void perf_evlist__delete(struct perf_evlist *evlist)
 		return;
 
 	perf_evlist__munmap(evlist);
+	fdarray__exit(&evlist->pollfd);
 	free(evlist);
 }
 
@@ -525,6 +527,9 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 			return -ENOMEM;
 	}
 
+	if (evlist->pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
+		return -ENOMEM;
+
 	if (perf_cpu_map__empty(cpus))
 		return mmap_per_thread(evlist, ops, mp);
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 3f4f11f27b94..5192c6583c96 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -58,7 +58,6 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 {
 	perf_evlist__init(&evlist->core);
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
-	fdarray__init(&evlist->core.pollfd, 64);
 	evlist->workload.pid = -1;
 	evlist->bkw_mmap_state = BKW_MMAP_NOTREADY;
 }
@@ -829,9 +828,6 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 	if (!evlist->mmap)
 		return -ENOMEM;
 
-	if (evlist->core.pollfd.entries == NULL && perf_evlist__alloc_pollfd(&evlist->core) < 0)
-		return -ENOMEM;
-
 	evlist->core.mmap_len = evlist__mmap_size(pages);
 	pr_debug("mmap size %zuB\n", evlist->core.mmap_len);
 	mp.core.mask = evlist->core.mmap_len - page_size - 1;
-- 
2.21.0
