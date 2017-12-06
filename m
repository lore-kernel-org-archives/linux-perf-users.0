From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/36] perf bench futex: Use cpumaps
Date: Wed,  6 Dec 2017 11:40:49 -0300
Message-ID: <20171206144115.15097-11-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Kim Phillips <kim.phillips@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

It was reported that the whole futex bench breaks when dealing with
non-contiguously numbered cpus.

$ echo 0 | sudo tee /sys/devices/system/cpu/cpu3/online
$ ./perf bench futex all
 perf: pthread_create: Operation not permitted
 Run summary [PID 14934]: 7 threads, each ....

James had implemented an approach with cpumaps that use an in house
flavor. Instead of re-inventing the wheel, I've redone the patch such
that we use the perf's util/cpumap.c interface instead.

Applies to all futex benchmarks.

Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Originally-from: James Yang <james.yang@arm.com>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Kim Phillips <kim.phillips@arm.com>
Link: http://lkml.kernel.org/r/20171127042101.3659-2-dave@stgolabs.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/futex-hash.c          | 19 ++++++++++++-------
 tools/perf/bench/futex-lock-pi.c       | 23 ++++++++++++++---------
 tools/perf/bench/futex-requeue.c       | 22 +++++++++++++---------
 tools/perf/bench/futex-wake-parallel.c | 24 +++++++++++++++---------
 tools/perf/bench/futex-wake.c          | 18 +++++++++++-------
 5 files changed, 65 insertions(+), 41 deletions(-)

diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index 58ae6ed8f38b..2defb6df7fd0 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -24,6 +24,7 @@
 #include <subcmd/parse-options.h>
 #include "bench.h"
 #include "futex.h"
+#include "cpumap.h"
 
 #include <err.h>
 #include <sys/time.h>
@@ -118,11 +119,12 @@ static void print_summary(void)
 int bench_futex_hash(int argc, const char **argv)
 {
 	int ret = 0;
-	cpu_set_t cpu;
+	cpu_set_t cpuset;
 	struct sigaction act;
-	unsigned int i, ncpus;
+	unsigned int i;
 	pthread_attr_t thread_attr;
 	struct worker *worker = NULL;
+	struct cpu_map *cpu;
 
 	argc = parse_options(argc, argv, options, bench_futex_hash_usage, 0);
 	if (argc) {
@@ -130,14 +132,16 @@ int bench_futex_hash(int argc, const char **argv)
 		exit(EXIT_FAILURE);
 	}
 
-	ncpus = sysconf(_SC_NPROCESSORS_ONLN);
+	cpu = cpu_map__new(NULL);
+	if (!cpu)
+		goto errmem;
 
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
 
 	if (!nthreads) /* default to the number of CPUs */
-		nthreads = ncpus;
+		nthreads = cpu->nr;
 
 	worker = calloc(nthreads, sizeof(*worker));
 	if (!worker)
@@ -163,10 +167,10 @@ int bench_futex_hash(int argc, const char **argv)
 		if (!worker[i].futex)
 			goto errmem;
 
-		CPU_ZERO(&cpu);
-		CPU_SET(i % ncpus, &cpu);
+		CPU_ZERO(&cpuset);
+		CPU_SET(cpu->map[i % cpu->nr], &cpuset);
 
-		ret = pthread_attr_setaffinity_np(&thread_attr, sizeof(cpu_set_t), &cpu);
+		ret = pthread_attr_setaffinity_np(&thread_attr, sizeof(cpu_set_t), &cpuset);
 		if (ret)
 			err(EXIT_FAILURE, "pthread_attr_setaffinity_np");
 
@@ -217,6 +221,7 @@ int bench_futex_hash(int argc, const char **argv)
 	print_summary();
 
 	free(worker);
+	free(cpu);
 	return ret;
 errmem:
 	err(EXIT_FAILURE, "calloc");
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index 08653ae8a8c4..8e9c4753e304 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -15,6 +15,7 @@
 #include <errno.h>
 #include "bench.h"
 #include "futex.h"
+#include "cpumap.h"
 
 #include <err.h>
 #include <stdlib.h>
@@ -32,7 +33,7 @@ static struct worker *worker;
 static unsigned int nsecs = 10;
 static bool silent = false, multi = false;
 static bool done = false, fshared = false;
-static unsigned int ncpus, nthreads = 0;
+static unsigned int nthreads = 0;
 static int futex_flag = 0;
 struct timeval start, end, runtime;
 static pthread_mutex_t thread_lock;
@@ -113,9 +114,10 @@ static void *workerfn(void *arg)
 	return NULL;
 }
 
-static void create_threads(struct worker *w, pthread_attr_t thread_attr)
+static void create_threads(struct worker *w, pthread_attr_t thread_attr,
+			   struct cpu_map *cpu)
 {
-	cpu_set_t cpu;
+	cpu_set_t cpuset;
 	unsigned int i;
 
 	threads_starting = nthreads;
@@ -130,10 +132,10 @@ static void create_threads(struct worker *w, pthread_attr_t thread_attr)
 		} else
 			worker[i].futex = &global_futex;
 
-		CPU_ZERO(&cpu);
-		CPU_SET(i % ncpus, &cpu);
+		CPU_ZERO(&cpuset);
+		CPU_SET(cpu->map[i % cpu->nr], &cpuset);
 
-		if (pthread_attr_setaffinity_np(&thread_attr, sizeof(cpu_set_t), &cpu))
+		if (pthread_attr_setaffinity_np(&thread_attr, sizeof(cpu_set_t), &cpuset))
 			err(EXIT_FAILURE, "pthread_attr_setaffinity_np");
 
 		if (pthread_create(&w[i].thread, &thread_attr, workerfn, &worker[i]))
@@ -147,19 +149,22 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	unsigned int i;
 	struct sigaction act;
 	pthread_attr_t thread_attr;
+	struct cpu_map *cpu;
 
 	argc = parse_options(argc, argv, options, bench_futex_lock_pi_usage, 0);
 	if (argc)
 		goto err;
 
-	ncpus = sysconf(_SC_NPROCESSORS_ONLN);
+	cpu = cpu_map__new(NULL);
+	if (!cpu)
+		err(EXIT_FAILURE, "calloc");
 
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
 
 	if (!nthreads)
-		nthreads = ncpus;
+		nthreads = cpu->nr;
 
 	worker = calloc(nthreads, sizeof(*worker));
 	if (!worker)
@@ -180,7 +185,7 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	pthread_attr_init(&thread_attr);
 	gettimeofday(&start, NULL);
 
-	create_threads(worker, thread_attr);
+	create_threads(worker, thread_attr, cpu);
 	pthread_attr_destroy(&thread_attr);
 
 	pthread_mutex_lock(&thread_lock);
diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index 1058c194608a..fc692efa0c05 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -22,6 +22,7 @@
 #include <errno.h>
 #include "bench.h"
 #include "futex.h"
+#include "cpumap.h"
 
 #include <err.h>
 #include <stdlib.h>
@@ -40,7 +41,7 @@ static bool done = false, silent = false, fshared = false;
 static pthread_mutex_t thread_lock;
 static pthread_cond_t thread_parent, thread_worker;
 static struct stats requeuetime_stats, requeued_stats;
-static unsigned int ncpus, threads_starting, nthreads = 0;
+static unsigned int threads_starting, nthreads = 0;
 static int futex_flag = 0;
 
 static const struct option options[] = {
@@ -83,19 +84,19 @@ static void *workerfn(void *arg __maybe_unused)
 }
 
 static void block_threads(pthread_t *w,
-			  pthread_attr_t thread_attr)
+			  pthread_attr_t thread_attr, struct cpu_map *cpu)
 {
-	cpu_set_t cpu;
+	cpu_set_t cpuset;
 	unsigned int i;
 
 	threads_starting = nthreads;
 
 	/* create and block all threads */
 	for (i = 0; i < nthreads; i++) {
-		CPU_ZERO(&cpu);
-		CPU_SET(i % ncpus, &cpu);
+		CPU_ZERO(&cpuset);
+		CPU_SET(cpu->map[i % cpu->nr], &cpuset);
 
-		if (pthread_attr_setaffinity_np(&thread_attr, sizeof(cpu_set_t), &cpu))
+		if (pthread_attr_setaffinity_np(&thread_attr, sizeof(cpu_set_t), &cpuset))
 			err(EXIT_FAILURE, "pthread_attr_setaffinity_np");
 
 		if (pthread_create(&w[i], &thread_attr, workerfn, NULL))
@@ -116,19 +117,22 @@ int bench_futex_requeue(int argc, const char **argv)
 	unsigned int i, j;
 	struct sigaction act;
 	pthread_attr_t thread_attr;
+	struct cpu_map *cpu;
 
 	argc = parse_options(argc, argv, options, bench_futex_requeue_usage, 0);
 	if (argc)
 		goto err;
 
-	ncpus = sysconf(_SC_NPROCESSORS_ONLN);
+	cpu = cpu_map__new(NULL);
+	if (!cpu)
+		err(EXIT_FAILURE, "cpu_map__new");
 
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
 
 	if (!nthreads)
-		nthreads = ncpus;
+		nthreads = cpu->nr;
 
 	worker = calloc(nthreads, sizeof(*worker));
 	if (!worker)
@@ -156,7 +160,7 @@ int bench_futex_requeue(int argc, const char **argv)
 		struct timeval start, end, runtime;
 
 		/* create, launch & block all threads */
-		block_threads(worker, thread_attr);
+		block_threads(worker, thread_attr, cpu);
 
 		/* make sure all threads are already blocked */
 		pthread_mutex_lock(&thread_lock);
diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
index b4732dad9f89..4488c27e8a43 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -21,6 +21,7 @@
 #include <errno.h>
 #include "bench.h"
 #include "futex.h"
+#include "cpumap.h"
 
 #include <err.h>
 #include <stdlib.h>
@@ -43,7 +44,7 @@ static unsigned int nblocked_threads = 0, nwaking_threads = 0;
 static pthread_mutex_t thread_lock;
 static pthread_cond_t thread_parent, thread_worker;
 static struct stats waketime_stats, wakeup_stats;
-static unsigned int ncpus, threads_starting;
+static unsigned int threads_starting;
 static int futex_flag = 0;
 
 static const struct option options[] = {
@@ -119,19 +120,20 @@ static void *blocked_workerfn(void *arg __maybe_unused)
 	return NULL;
 }
 
-static void block_threads(pthread_t *w, pthread_attr_t thread_attr)
+static void block_threads(pthread_t *w, pthread_attr_t thread_attr,
+			  struct cpu_map *cpu)
 {
-	cpu_set_t cpu;
+	cpu_set_t cpuset;
 	unsigned int i;
 
 	threads_starting = nblocked_threads;
 
 	/* create and block all threads */
 	for (i = 0; i < nblocked_threads; i++) {
-		CPU_ZERO(&cpu);
-		CPU_SET(i % ncpus, &cpu);
+		CPU_ZERO(&cpuset);
+		CPU_SET(cpu->map[i % cpu->nr], &cpuset);
 
-		if (pthread_attr_setaffinity_np(&thread_attr, sizeof(cpu_set_t), &cpu))
+		if (pthread_attr_setaffinity_np(&thread_attr, sizeof(cpu_set_t), &cpuset))
 			err(EXIT_FAILURE, "pthread_attr_setaffinity_np");
 
 		if (pthread_create(&w[i], &thread_attr, blocked_workerfn, NULL))
@@ -205,6 +207,7 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 	struct sigaction act;
 	pthread_attr_t thread_attr;
 	struct thread_data *waking_worker;
+	struct cpu_map *cpu;
 
 	argc = parse_options(argc, argv, options,
 			     bench_futex_wake_parallel_usage, 0);
@@ -217,9 +220,12 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
 
-	ncpus = sysconf(_SC_NPROCESSORS_ONLN);
+	cpu = cpu_map__new(NULL);
+	if (!cpu)
+		err(EXIT_FAILURE, "calloc");
+
 	if (!nblocked_threads)
-		nblocked_threads = ncpus;
+		nblocked_threads = cpu->nr;
 
 	/* some sanity checks */
 	if (nwaking_threads > nblocked_threads || !nwaking_threads)
@@ -259,7 +265,7 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 			err(EXIT_FAILURE, "calloc");
 
 		/* create, launch & block all threads */
-		block_threads(blocked_worker, thread_attr);
+		block_threads(blocked_worker, thread_attr, cpu);
 
 		/* make sure all threads are already blocked */
 		pthread_mutex_lock(&thread_lock);
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index 8c5c0b6b5c97..e8181ad7d088 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -22,6 +22,7 @@
 #include <errno.h>
 #include "bench.h"
 #include "futex.h"
+#include "cpumap.h"
 
 #include <err.h>
 #include <stdlib.h>
@@ -89,19 +90,19 @@ static void print_summary(void)
 }
 
 static void block_threads(pthread_t *w,
-			  pthread_attr_t thread_attr)
+			  pthread_attr_t thread_attr, struct cpu_map *cpu)
 {
-	cpu_set_t cpu;
+	cpu_set_t cpuset;
 	unsigned int i;
 
 	threads_starting = nthreads;
 
 	/* create and block all threads */
 	for (i = 0; i < nthreads; i++) {
-		CPU_ZERO(&cpu);
-		CPU_SET(i % ncpus, &cpu);
+		CPU_ZERO(&cpuset);
+		CPU_SET(cpu->map[i % cpu->nr], &cpuset);
 
-		if (pthread_attr_setaffinity_np(&thread_attr, sizeof(cpu_set_t), &cpu))
+		if (pthread_attr_setaffinity_np(&thread_attr, sizeof(cpu_set_t), &cpuset))
 			err(EXIT_FAILURE, "pthread_attr_setaffinity_np");
 
 		if (pthread_create(&w[i], &thread_attr, workerfn, NULL))
@@ -122,6 +123,7 @@ int bench_futex_wake(int argc, const char **argv)
 	unsigned int i, j;
 	struct sigaction act;
 	pthread_attr_t thread_attr;
+	struct cpu_map *cpu;
 
 	argc = parse_options(argc, argv, options, bench_futex_wake_usage, 0);
 	if (argc) {
@@ -129,7 +131,9 @@ int bench_futex_wake(int argc, const char **argv)
 		exit(EXIT_FAILURE);
 	}
 
-	ncpus = sysconf(_SC_NPROCESSORS_ONLN);
+	cpu = cpu_map__new(NULL);
+	if (!cpu)
+		err(EXIT_FAILURE, "calloc");
 
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
@@ -161,7 +165,7 @@ int bench_futex_wake(int argc, const char **argv)
 		struct timeval start, end, runtime;
 
 		/* create, launch & block all threads */
-		block_threads(worker, thread_attr);
+		block_threads(worker, thread_attr, cpu);
 
 		/* make sure all threads are already blocked */
 		pthread_mutex_lock(&thread_lock);
-- 
2.13.6
