From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 63/69] libperf: Centralize map refcnt setting
Date: Fri, 11 Oct 2019 17:05:53 -0300
Message-ID: <20191011200559.7156-64-acme@kernel.org>
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

Currently when a new map is mmapped we set its refcnt to 2 in the
perf_evlist_mmap_ops::mmap callback.

Every mmap gets its refcnt set to 2 when it's first mmaped:

  - 1 for the current user, which will be taken out by a call to
    perf_evlist__munmap_filtered(), where we find out there's
    no more data comming from kernel to this mmap.

  - 1 for the drain code where in perf_mmap__consume() the mmap
    is released if it is empty.

Move this common setup into libperf's generic code before the mmap
callback is called.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-23-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c | 30 +++++++++++++++---------------
 tools/perf/util/mmap.c  | 15 ---------------
 2 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index b69722627779..f9a802d2ceb5 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -362,21 +362,6 @@ static int
 perf_evlist__mmap_cb_mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
 			  int output, int cpu)
 {
-	/*
-	 * The last one will be done at perf_mmap__consume(), so that we
-	 * make sure we don't prevent tools from consuming every last event in
-	 * the ring buffer.
-	 *
-	 * I.e. we can get the POLLHUP meaning that the fd doesn't exist
-	 * anymore, but the last events for it are still in the ring buffer,
-	 * waiting to be consumed.
-	 *
-	 * Tools can chose to ignore this at their own discretion, but the
-	 * evlist layer can't just drop it when filtering events in
-	 * perf_evlist__filter_pollfd().
-	 */
-	refcount_set(&map->refcnt, 2);
-
 	return perf_mmap__mmap(map, mp, output, cpu);
 }
 
@@ -418,6 +403,21 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 		if (*output == -1) {
 			*output = fd;
 
+			/*
+			 * The last one will be done at perf_mmap__consume(), so that we
+			 * make sure we don't prevent tools from consuming every last event in
+			 * the ring buffer.
+			 *
+			 * I.e. we can get the POLLHUP meaning that the fd doesn't exist
+			 * anymore, but the last events for it are still in the ring buffer,
+			 * waiting to be consumed.
+			 *
+			 * Tools can chose to ignore this at their own discretion, but the
+			 * evlist layer can't just drop it when filtering events in
+			 * perf_evlist__filter_pollfd().
+			 */
+			refcount_set(&map->refcnt, 2);
+
 			if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
 				return -1;
 		} else {
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 2a8bf0ab861c..063d1b93c53d 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -243,21 +243,6 @@ static void perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params
 
 int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 {
-	/*
-	 * The last one will be done at perf_mmap__consume(), so that we
-	 * make sure we don't prevent tools from consuming every last event in
-	 * the ring buffer.
-	 *
-	 * I.e. we can get the POLLHUP meaning that the fd doesn't exist
-	 * anymore, but the last events for it are still in the ring buffer,
-	 * waiting to be consumed.
-	 *
-	 * Tools can chose to ignore this at their own discretion, but the
-	 * evlist layer can't just drop it when filtering events in
-	 * perf_evlist__filter_pollfd().
-	 */
-	refcount_set(&map->core.refcnt, 2);
-
 	if (perf_mmap__mmap(&map->core, &mp->core, fd, cpu)) {
 		pr_debug2("failed to mmap perf event ring buffer, error %d\n",
 			  errno);
-- 
2.21.0
