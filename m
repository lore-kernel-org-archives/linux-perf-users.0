From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/36] perf bench futex: Sync waker threads
Date: Wed,  6 Dec 2017 11:40:51 -0300
Message-ID: <20171206144115.15097-13-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, James Yang <james.yang@arm.com>, Kim Phillips <kim.phillips@arm.com>, Davidlohr Bueso <dave@stgolabs.net>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: James Yang <james.yang@arm.com>

Waker threads in the futex wake-parallel benchmark are started by a loop
using pthread_create().  However, there is no synchronization for when
the waker threads wake the waiting threads.  Comparison of the waker
threads' measurement timestamps show they are not all running
concurrently because older waker threads finish their task before newer
waker threads even start.

This patch uses a barrier to better synchronize the waker threads.

Signed-off-by: James Yang <james.yang@arm.com
Cc: Kim Phillips <kim.phillips@arm.com>
Link: http://lkml.kernel.org/r/20171127042101.3659-4-dave@stgolabs.net
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
[ Disable the wake-parallel test for systems without pthread_barrier_t ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/futex-wake-parallel.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
index 4488c27e8a43..69d8fdc87315 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -7,7 +7,17 @@
  * for each individual thread to service its share of work. Ultimately
  * it can be used to measure futex_wake() changes.
  */
+#include "bench.h"
+#include <linux/compiler.h>
+#include "../util/debug.h"
 
+#ifndef HAVE_PTHREAD_BARRIER
+int bench_futex_wake_parallel(int argc __maybe_unused, const char **argv __maybe_unused)
+{
+	pr_err("%s: pthread_barrier_t unavailable, disabling this test...\n", __func__);
+	return 0;
+}
+#else /* HAVE_PTHREAD_BARRIER */
 /* For the CLR_() macros */
 #include <string.h>
 #include <pthread.h>
@@ -15,11 +25,9 @@
 #include <signal.h>
 #include "../util/stat.h"
 #include <subcmd/parse-options.h>
-#include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/time64.h>
 #include <errno.h>
-#include "bench.h"
 #include "futex.h"
 #include "cpumap.h"
 
@@ -43,6 +51,7 @@ static bool done = false, silent = false, fshared = false;
 static unsigned int nblocked_threads = 0, nwaking_threads = 0;
 static pthread_mutex_t thread_lock;
 static pthread_cond_t thread_parent, thread_worker;
+static pthread_barrier_t barrier;
 static struct stats waketime_stats, wakeup_stats;
 static unsigned int threads_starting;
 static int futex_flag = 0;
@@ -65,6 +74,8 @@ static void *waking_workerfn(void *arg)
 	struct thread_data *waker = (struct thread_data *) arg;
 	struct timeval start, end;
 
+	pthread_barrier_wait(&barrier);
+
 	gettimeofday(&start, NULL);
 
 	waker->nwoken = futex_wake(&futex, nwakes, futex_flag);
@@ -85,6 +96,8 @@ static void wakeup_threads(struct thread_data *td, pthread_attr_t thread_attr)
 
 	pthread_attr_setdetachstate(&thread_attr, PTHREAD_CREATE_JOINABLE);
 
+	pthread_barrier_init(&barrier, NULL, nwaking_threads + 1);
+
 	/* create and block all threads */
 	for (i = 0; i < nwaking_threads; i++) {
 		/*
@@ -97,9 +110,13 @@ static void wakeup_threads(struct thread_data *td, pthread_attr_t thread_attr)
 			err(EXIT_FAILURE, "pthread_create");
 	}
 
+	pthread_barrier_wait(&barrier);
+
 	for (i = 0; i < nwaking_threads; i++)
 		if (pthread_join(td[i].worker, NULL))
 			err(EXIT_FAILURE, "pthread_join");
+
+	pthread_barrier_destroy(&barrier);
 }
 
 static void *blocked_workerfn(void *arg __maybe_unused)
@@ -303,3 +320,4 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 	free(blocked_worker);
 	return ret;
 }
+#endif /* HAVE_PTHREAD_BARRIER */
-- 
2.13.6
