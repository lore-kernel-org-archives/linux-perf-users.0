From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 65/69] libperf: Introduce perf_evlist__exit()
Date: Fri, 11 Oct 2019 17:05:55 -0300
Message-ID: <20191011200559.7156-66-acme@kernel.org>
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

Add the perf_evlist__exit() function, so far it's not exported and added
only for internal use for perf and libperf.

USe it to release cpus/threads and pollfd array.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-25-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c                  | 12 +++++++++++-
 tools/perf/lib/include/internal/evlist.h |  2 ++
 tools/perf/util/evlist.c                 |  6 +-----
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 5ae1da97d2e6..7ba98f0e6365 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -109,13 +109,23 @@ perf_evlist__next(struct perf_evlist *evlist, struct perf_evsel *prev)
 	return next;
 }
 
+void perf_evlist__exit(struct perf_evlist *evlist)
+{
+	perf_cpu_map__put(evlist->cpus);
+	perf_thread_map__put(evlist->threads);
+	evlist->cpus = NULL;
+	evlist->threads = NULL;
+	fdarray__exit(&evlist->pollfd);
+}
+
 void perf_evlist__delete(struct perf_evlist *evlist)
 {
 	if (evlist == NULL)
 		return;
 
 	perf_evlist__munmap(evlist);
-	fdarray__exit(&evlist->pollfd);
+	perf_evlist__close(evlist);
+	perf_evlist__exit(evlist);
 	free(evlist);
 }
 
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index b2019700cdc0..0721512ffb19 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -48,6 +48,8 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 			  struct perf_evlist_mmap_ops *ops,
 			  struct perf_mmap_param *mp);
 
+void perf_evlist__exit(struct perf_evlist *evlist);
+
 /**
  * __perf_evlist__for_each_entry - iterate thru all the evsels
  * @list: list_head instance to iterate
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 5192c6583c96..031ace3696a2 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -138,7 +138,7 @@ void evlist__exit(struct evlist *evlist)
 {
 	zfree(&evlist->mmap);
 	zfree(&evlist->overwrite_mmap);
-	fdarray__exit(&evlist->core.pollfd);
+	perf_evlist__exit(&evlist->core);
 }
 
 void evlist__delete(struct evlist *evlist)
@@ -148,10 +148,6 @@ void evlist__delete(struct evlist *evlist)
 
 	evlist__munmap(evlist);
 	evlist__close(evlist);
-	perf_cpu_map__put(evlist->core.cpus);
-	perf_thread_map__put(evlist->core.threads);
-	evlist->core.cpus = NULL;
-	evlist->core.threads = NULL;
 	evlist__purge(evlist);
 	evlist__exit(evlist);
 	free(evlist);
-- 
2.21.0
