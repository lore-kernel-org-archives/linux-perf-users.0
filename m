Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F48DC4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 04:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E15236101D
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 04:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhHIEdd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 00:33:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60806 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhHIEdd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 00:33:33 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8E6071FD82;
        Mon,  9 Aug 2021 04:33:12 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BB4013398;
        Mon,  9 Aug 2021 04:33:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IIVwEgawEGEfDQAAMHmgww
        (envelope-from <dave@stgolabs.net>); Mon, 09 Aug 2021 04:33:10 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     acme@kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/7] perf/bench-futex: Group test parameters cleanup
Date:   Sun,  8 Aug 2021 21:32:55 -0700
Message-Id: <20210809043301.66002-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210809043301.66002-1-dave@stgolabs.net>
References: <20210809043301.66002-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Do this across all futex-bench tests such that all program parameters
neatly share a common structure, which is nicer than how we have them
now. No changes in program behavior are expected.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 tools/perf/bench/futex-hash.c          | 55 +++++++++++-----------
 tools/perf/bench/futex-lock-pi.c       | 53 ++++++++++-----------
 tools/perf/bench/futex-requeue.c       | 65 ++++++++++++++------------
 tools/perf/bench/futex-wake-parallel.c | 58 ++++++++++++-----------
 tools/perf/bench/futex-wake.c          | 57 +++++++++++-----------
 tools/perf/bench/futex.h               | 11 +++++
 6 files changed, 162 insertions(+), 137 deletions(-)

diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index b65373ce5c4f..ddca7558e559 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -29,11 +29,7 @@
 
 #include <err.h>
 
-static unsigned int nthreads = 0;
-static unsigned int nsecs    = 10;
-/* amount of futexes per thread */
-static unsigned int nfutexes = 1024;
-static bool fshared = false, done = false, silent = false;
+static bool done = false;
 static int futex_flag = 0;
 
 struct timeval bench__start, bench__end, bench__runtime;
@@ -49,12 +45,17 @@ struct worker {
 	unsigned long ops;
 };
 
+static struct bench_futex_parameters params = {
+	.nfutexes = 1024,
+	.runtime  = 10,
+};
+
 static const struct option options[] = {
-	OPT_UINTEGER('t', "threads", &nthreads, "Specify amount of threads"),
-	OPT_UINTEGER('r', "runtime", &nsecs,    "Specify runtime (in seconds)"),
-	OPT_UINTEGER('f', "futexes", &nfutexes, "Specify amount of futexes per threads"),
-	OPT_BOOLEAN( 's', "silent",  &silent,   "Silent mode: do not display data/details"),
-	OPT_BOOLEAN( 'S', "shared",  &fshared,  "Use shared futexes instead of private ones"),
+	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads"),
+	OPT_UINTEGER('r', "runtime", &params.runtime, "Specify runtime (in seconds)"),
+	OPT_UINTEGER('f', "futexes", &params.nfutexes, "Specify amount of futexes per threads"),
+	OPT_BOOLEAN( 's', "silent",  &params.silent, "Silent mode: do not display data/details"),
+	OPT_BOOLEAN( 'S', "shared",  &params.fshared, "Use shared futexes instead of private ones"),
 	OPT_END()
 };
 
@@ -78,7 +79,7 @@ static void *workerfn(void *arg)
 	pthread_mutex_unlock(&thread_lock);
 
 	do {
-		for (i = 0; i < nfutexes; i++, ops++) {
+		for (i = 0; i < params.nfutexes; i++, ops++) {
 			/*
 			 * We want the futex calls to fail in order to stress
 			 * the hashing of uaddr and not measure other steps,
@@ -86,7 +87,7 @@ static void *workerfn(void *arg)
 			 * the critical region protected by hb->lock.
 			 */
 			ret = futex_wait(&w->futex[i], 1234, NULL, futex_flag);
-			if (!silent &&
+			if (!params.silent &&
 			    (!ret || errno != EAGAIN || errno != EWOULDBLOCK))
 				warn("Non-expected futex return call");
 		}
@@ -112,7 +113,7 @@ static void print_summary(void)
 	double stddev = stddev_stats(&throughput_stats);
 
 	printf("%sAveraged %ld operations/sec (+- %.2f%%), total secs = %d\n",
-	       !silent ? "\n" : "", avg, rel_stddev_stats(stddev, avg),
+	       !params.silent ? "\n" : "", avg, rel_stddev_stats(stddev, avg),
 	       (int)bench__runtime.tv_sec);
 }
 
@@ -141,30 +142,30 @@ int bench_futex_hash(int argc, const char **argv)
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
 
-	if (!nthreads) /* default to the number of CPUs */
-		nthreads = cpu->nr;
+	if (!params.nthreads) /* default to the number of CPUs */
+		params.nthreads = cpu->nr;
 
-	worker = calloc(nthreads, sizeof(*worker));
+	worker = calloc(params.nthreads, sizeof(*worker));
 	if (!worker)
 		goto errmem;
 
-	if (!fshared)
+	if (!params.fshared)
 		futex_flag = FUTEX_PRIVATE_FLAG;
 
 	printf("Run summary [PID %d]: %d threads, each operating on %d [%s] futexes for %d secs.\n\n",
-	       getpid(), nthreads, nfutexes, fshared ? "shared":"private", nsecs);
+	       getpid(), params.nthreads, params.nfutexes, params.fshared ? "shared":"private", params.runtime);
 
 	init_stats(&throughput_stats);
 	pthread_mutex_init(&thread_lock, NULL);
 	pthread_cond_init(&thread_parent, NULL);
 	pthread_cond_init(&thread_worker, NULL);
 
-	threads_starting = nthreads;
+	threads_starting = params.nthreads;
 	pthread_attr_init(&thread_attr);
 	gettimeofday(&bench__start, NULL);
-	for (i = 0; i < nthreads; i++) {
+	for (i = 0; i < params.nthreads; i++) {
 		worker[i].tid = i;
-		worker[i].futex = calloc(nfutexes, sizeof(*worker[i].futex));
+		worker[i].futex = calloc(params.nfutexes, sizeof(*worker[i].futex));
 		if (!worker[i].futex)
 			goto errmem;
 
@@ -189,10 +190,10 @@ int bench_futex_hash(int argc, const char **argv)
 	pthread_cond_broadcast(&thread_worker);
 	pthread_mutex_unlock(&thread_lock);
 
-	sleep(nsecs);
+	sleep(params.runtime);
 	toggle_done(0, NULL, NULL);
 
-	for (i = 0; i < nthreads; i++) {
+	for (i = 0; i < params.nthreads; i++) {
 		ret = pthread_join(worker[i].thread, NULL);
 		if (ret)
 			err(EXIT_FAILURE, "pthread_join");
@@ -203,18 +204,18 @@ int bench_futex_hash(int argc, const char **argv)
 	pthread_cond_destroy(&thread_worker);
 	pthread_mutex_destroy(&thread_lock);
 
-	for (i = 0; i < nthreads; i++) {
+	for (i = 0; i < params.nthreads; i++) {
 		unsigned long t = bench__runtime.tv_sec > 0 ?
 			worker[i].ops / bench__runtime.tv_sec : 0;
 		update_stats(&throughput_stats, t);
-		if (!silent) {
-			if (nfutexes == 1)
+		if (!params.silent) {
+			if (params.nfutexes == 1)
 				printf("[thread %2d] futex: %p [ %ld ops/sec ]\n",
 				       worker[i].tid, &worker[i].futex[0], t);
 			else
 				printf("[thread %2d] futexes: %p ... %p [ %ld ops/sec ]\n",
 				       worker[i].tid, &worker[i].futex[0],
-				       &worker[i].futex[nfutexes-1], t);
+				       &worker[i].futex[params.nfutexes-1], t);
 		}
 
 		zfree(&worker[i].futex);
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index 89c6d160379c..ce980df23bb0 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -31,22 +31,23 @@ struct worker {
 
 static u_int32_t global_futex = 0;
 static struct worker *worker;
-static unsigned int nsecs = 10;
-static bool silent = false, multi = false;
-static bool done = false, fshared = false;
-static unsigned int nthreads = 0;
+static bool done = false;
 static int futex_flag = 0;
 static pthread_mutex_t thread_lock;
 static unsigned int threads_starting;
 static struct stats throughput_stats;
 static pthread_cond_t thread_parent, thread_worker;
 
+static struct bench_futex_parameters params = {
+	.runtime  = 10,
+};
+
 static const struct option options[] = {
-	OPT_UINTEGER('t', "threads",  &nthreads, "Specify amount of threads"),
-	OPT_UINTEGER('r', "runtime", &nsecs,     "Specify runtime (in seconds)"),
-	OPT_BOOLEAN( 'M', "multi",   &multi,     "Use multiple futexes"),
-	OPT_BOOLEAN( 's', "silent",  &silent,    "Silent mode: do not display data/details"),
-	OPT_BOOLEAN( 'S', "shared",  &fshared,   "Use shared futexes instead of private ones"),
+	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads"),
+	OPT_UINTEGER('r', "runtime", &params.runtime, "Specify runtime (in seconds)"),
+	OPT_BOOLEAN( 'M', "multi",   &params.multi, "Use multiple futexes"),
+	OPT_BOOLEAN( 's', "silent",  &params.silent, "Silent mode: do not display data/details"),
+	OPT_BOOLEAN( 'S', "shared",  &params.fshared, "Use shared futexes instead of private ones"),
 	OPT_END()
 };
 
@@ -61,7 +62,7 @@ static void print_summary(void)
 	double stddev = stddev_stats(&throughput_stats);
 
 	printf("%sAveraged %ld operations/sec (+- %.2f%%), total secs = %d\n",
-	       !silent ? "\n" : "", avg, rel_stddev_stats(stddev, avg),
+	       !params.silent ? "\n" : "", avg, rel_stddev_stats(stddev, avg),
 	       (int)bench__runtime.tv_sec);
 }
 
@@ -93,7 +94,7 @@ static void *workerfn(void *arg)
 		ret = futex_lock_pi(w->futex, NULL, futex_flag);
 
 		if (ret) { /* handle lock acquisition */
-			if (!silent)
+			if (!params.silent)
 				warn("thread %d: Could not lock pi-lock for %p (%d)",
 				     w->tid, w->futex, ret);
 			if (done)
@@ -104,7 +105,7 @@ static void *workerfn(void *arg)
 
 		usleep(1);
 		ret = futex_unlock_pi(w->futex, futex_flag);
-		if (ret && !silent)
+		if (ret && !params.silent)
 			warn("thread %d: Could not unlock pi-lock for %p (%d)",
 			     w->tid, w->futex, ret);
 		ops++; /* account for thread's share of work */
@@ -120,12 +121,12 @@ static void create_threads(struct worker *w, pthread_attr_t thread_attr,
 	cpu_set_t cpuset;
 	unsigned int i;
 
-	threads_starting = nthreads;
+	threads_starting = params.nthreads;
 
-	for (i = 0; i < nthreads; i++) {
+	for (i = 0; i < params.nthreads; i++) {
 		worker[i].tid = i;
 
-		if (multi) {
+		if (params.multi) {
 			worker[i].futex = calloc(1, sizeof(u_int32_t));
 			if (!worker[i].futex)
 				err(EXIT_FAILURE, "calloc");
@@ -164,25 +165,25 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
 
-	if (!nthreads)
-		nthreads = cpu->nr;
+	if (!params.nthreads)
+		params.nthreads = cpu->nr;
 
-	worker = calloc(nthreads, sizeof(*worker));
+	worker = calloc(params.nthreads, sizeof(*worker));
 	if (!worker)
 		err(EXIT_FAILURE, "calloc");
 
-	if (!fshared)
+	if (!params.fshared)
 		futex_flag = FUTEX_PRIVATE_FLAG;
 
 	printf("Run summary [PID %d]: %d threads doing pi lock/unlock pairing for %d secs.\n\n",
-	       getpid(), nthreads, nsecs);
+	       getpid(), params.nthreads, params.runtime);
 
 	init_stats(&throughput_stats);
 	pthread_mutex_init(&thread_lock, NULL);
 	pthread_cond_init(&thread_parent, NULL);
 	pthread_cond_init(&thread_worker, NULL);
 
-	threads_starting = nthreads;
+	threads_starting = params.nthreads;
 	pthread_attr_init(&thread_attr);
 	gettimeofday(&bench__start, NULL);
 
@@ -195,10 +196,10 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	pthread_cond_broadcast(&thread_worker);
 	pthread_mutex_unlock(&thread_lock);
 
-	sleep(nsecs);
+	sleep(params.runtime);
 	toggle_done(0, NULL, NULL);
 
-	for (i = 0; i < nthreads; i++) {
+	for (i = 0; i < params.nthreads; i++) {
 		ret = pthread_join(worker[i].thread, NULL);
 		if (ret)
 			err(EXIT_FAILURE, "pthread_join");
@@ -209,16 +210,16 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	pthread_cond_destroy(&thread_worker);
 	pthread_mutex_destroy(&thread_lock);
 
-	for (i = 0; i < nthreads; i++) {
+	for (i = 0; i < params.nthreads; i++) {
 		unsigned long t = bench__runtime.tv_sec > 0 ?
 			worker[i].ops / bench__runtime.tv_sec : 0;
 
 		update_stats(&throughput_stats, t);
-		if (!silent)
+		if (!params.silent)
 			printf("[thread %3d] futex: %p [ %ld ops/sec ]\n",
 			       worker[i].tid, worker[i].futex, t);
 
-		if (multi)
+		if (params.multi)
 			zfree(&worker[i].futex);
 	}
 
diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index 5fa23295ee5f..66747bfe22cf 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -30,25 +30,27 @@
 
 static u_int32_t futex1 = 0, futex2 = 0;
 
-/*
- * How many tasks to requeue at a time.
- * Default to 1 in order to make the kernel work more.
- */
-static unsigned int nrequeue = 1;
-
 static pthread_t *worker;
-static bool done = false, silent = false, fshared = false;
+static bool done = false;
 static pthread_mutex_t thread_lock;
 static pthread_cond_t thread_parent, thread_worker;
 static struct stats requeuetime_stats, requeued_stats;
-static unsigned int threads_starting, nthreads = 0;
+static unsigned int threads_starting;
 static int futex_flag = 0;
 
+static struct bench_futex_parameters params = {
+	/*
+	 * How many tasks to requeue at a time.
+	 * Default to 1 in order to make the kernel work more.
+	 */
+	.nrequeue = 1,
+};
+
 static const struct option options[] = {
-	OPT_UINTEGER('t', "threads",  &nthreads, "Specify amount of threads"),
-	OPT_UINTEGER('q', "nrequeue", &nrequeue, "Specify amount of threads to requeue at once"),
-	OPT_BOOLEAN( 's', "silent",   &silent,   "Silent mode: do not display data/details"),
-	OPT_BOOLEAN( 'S', "shared",   &fshared,  "Use shared futexes instead of private ones"),
+	OPT_UINTEGER('t', "threads",  &params.nthreads, "Specify amount of threads"),
+	OPT_UINTEGER('q', "nrequeue", &params.nrequeue, "Specify amount of threads to requeue at once"),
+	OPT_BOOLEAN( 's', "silent",   &params.silent, "Silent mode: do not display data/details"),
+	OPT_BOOLEAN( 'S', "shared",   &params.fshared, "Use shared futexes instead of private ones"),
 	OPT_END()
 };
 
@@ -65,7 +67,7 @@ static void print_summary(void)
 
 	printf("Requeued %d of %d threads in %.4f ms (+-%.2f%%)\n",
 	       requeued_avg,
-	       nthreads,
+	       params.nthreads,
 	       requeuetime_avg / USEC_PER_MSEC,
 	       rel_stddev_stats(requeuetime_stddev, requeuetime_avg));
 }
@@ -89,10 +91,10 @@ static void block_threads(pthread_t *w,
 	cpu_set_t cpuset;
 	unsigned int i;
 
-	threads_starting = nthreads;
+	threads_starting = params.nthreads;
 
 	/* create and block all threads */
-	for (i = 0; i < nthreads; i++) {
+	for (i = 0; i < params.nthreads; i++) {
 		CPU_ZERO(&cpuset);
 		CPU_SET(cpu->map[i % cpu->nr], &cpuset);
 
@@ -132,22 +134,22 @@ int bench_futex_requeue(int argc, const char **argv)
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
 
-	if (!nthreads)
-		nthreads = cpu->nr;
+	if (!params.nthreads)
+		params.nthreads = cpu->nr;
 
-	worker = calloc(nthreads, sizeof(*worker));
+	worker = calloc(params.nthreads, sizeof(*worker));
 	if (!worker)
 		err(EXIT_FAILURE, "calloc");
 
-	if (!fshared)
+	if (!params.fshared)
 		futex_flag = FUTEX_PRIVATE_FLAG;
 
-	if (nrequeue > nthreads)
-		nrequeue = nthreads;
+	if (params.nrequeue > params.nthreads)
+		params.nrequeue = params.nthreads;
 
 	printf("Run summary [PID %d]: Requeuing %d threads (from [%s] %p to %p), "
-	       "%d at a time.\n\n",  getpid(), nthreads,
-	       fshared ? "shared":"private", &futex1, &futex2, nrequeue);
+	       "%d at a time.\n\n",  getpid(), params.nthreads,
+	       params.fshared ? "shared":"private", &futex1, &futex2, params.nrequeue);
 
 	init_stats(&requeued_stats);
 	init_stats(&requeuetime_stats);
@@ -174,13 +176,14 @@ int bench_futex_requeue(int argc, const char **argv)
 
 		/* Ok, all threads are patiently blocked, start requeueing */
 		gettimeofday(&start, NULL);
-		while (nrequeued < nthreads) {
+		while (nrequeued < params.nthreads) {
 			/*
 			 * Do not wakeup any tasks blocked on futex1, allowing
 			 * us to really measure futex_wait functionality.
 			 */
 			nrequeued += futex_cmp_requeue(&futex1, 0, &futex2, 0,
-						       nrequeue, futex_flag);
+						       params.nrequeue,
+						       futex_flag);
 		}
 
 		gettimeofday(&end, NULL);
@@ -189,17 +192,19 @@ int bench_futex_requeue(int argc, const char **argv)
 		update_stats(&requeued_stats, nrequeued);
 		update_stats(&requeuetime_stats, runtime.tv_usec);
 
-		if (!silent) {
+		if (!params.silent) {
 			printf("[Run %d]: Requeued %d of %d threads in %.4f ms\n",
-			       j + 1, nrequeued, nthreads, runtime.tv_usec / (double)USEC_PER_MSEC);
+			       j + 1, nrequeued, params.nthreads,
+			       runtime.tv_usec / (double)USEC_PER_MSEC);
 		}
 
 		/* everybody should be blocked on futex2, wake'em up */
 		nrequeued = futex_wake(&futex2, nrequeued, futex_flag);
-		if (nthreads != nrequeued)
-			warnx("couldn't wakeup all tasks (%d/%d)", nrequeued, nthreads);
+		if (params.nthreads != nrequeued)
+			warnx("couldn't wakeup all tasks (%d/%d)",
+			      nrequeued, params.nthreads);
 
-		for (i = 0; i < nthreads; i++) {
+		for (i = 0; i < params.nthreads; i++) {
 			ret = pthread_join(worker[i], NULL);
 			if (ret)
 				err(EXIT_FAILURE, "pthread_join");
diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
index 6e6f5247e1fe..958372ad159c 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -47,8 +47,7 @@ static unsigned int nwakes = 1;
 static u_int32_t futex = 0;
 
 static pthread_t *blocked_worker;
-static bool done = false, silent = false, fshared = false;
-static unsigned int nblocked_threads = 0, nwaking_threads = 0;
+static bool done = false;
 static pthread_mutex_t thread_lock;
 static pthread_cond_t thread_parent, thread_worker;
 static pthread_barrier_t barrier;
@@ -56,11 +55,13 @@ static struct stats waketime_stats, wakeup_stats;
 static unsigned int threads_starting;
 static int futex_flag = 0;
 
+static struct bench_futex_parameters params;
+
 static const struct option options[] = {
-	OPT_UINTEGER('t', "threads", &nblocked_threads, "Specify amount of threads"),
-	OPT_UINTEGER('w', "nwakers", &nwaking_threads, "Specify amount of waking threads"),
-	OPT_BOOLEAN( 's', "silent",  &silent,   "Silent mode: do not display data/details"),
-	OPT_BOOLEAN( 'S', "shared",  &fshared,  "Use shared futexes instead of private ones"),
+	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads"),
+	OPT_UINTEGER('w', "nwakers", &params.nwakes, "Specify amount of waking threads"),
+	OPT_BOOLEAN( 's', "silent",  &params.silent, "Silent mode: do not display data/details"),
+	OPT_BOOLEAN( 'S', "shared",  &params.fshared, "Use shared futexes instead of private ones"),
 	OPT_END()
 };
 
@@ -96,10 +97,10 @@ static void wakeup_threads(struct thread_data *td, pthread_attr_t thread_attr)
 
 	pthread_attr_setdetachstate(&thread_attr, PTHREAD_CREATE_JOINABLE);
 
-	pthread_barrier_init(&barrier, NULL, nwaking_threads + 1);
+	pthread_barrier_init(&barrier, NULL, params.nwakes + 1);
 
 	/* create and block all threads */
-	for (i = 0; i < nwaking_threads; i++) {
+	for (i = 0; i < params.nwakes; i++) {
 		/*
 		 * Thread creation order will impact per-thread latency
 		 * as it will affect the order to acquire the hb spinlock.
@@ -112,7 +113,7 @@ static void wakeup_threads(struct thread_data *td, pthread_attr_t thread_attr)
 
 	pthread_barrier_wait(&barrier);
 
-	for (i = 0; i < nwaking_threads; i++)
+	for (i = 0; i < params.nwakes; i++)
 		if (pthread_join(td[i].worker, NULL))
 			err(EXIT_FAILURE, "pthread_join");
 
@@ -143,10 +144,10 @@ static void block_threads(pthread_t *w, pthread_attr_t thread_attr,
 	cpu_set_t cpuset;
 	unsigned int i;
 
-	threads_starting = nblocked_threads;
+	threads_starting = params.nthreads;
 
 	/* create and block all threads */
-	for (i = 0; i < nblocked_threads; i++) {
+	for (i = 0; i < params.nthreads; i++) {
 		CPU_ZERO(&cpuset);
 		CPU_SET(cpu->map[i % cpu->nr], &cpuset);
 
@@ -167,7 +168,7 @@ static void print_run(struct thread_data *waking_worker, unsigned int run_num)
 	init_stats(&__wakeup_stats);
 	init_stats(&__waketime_stats);
 
-	for (i = 0; i < nwaking_threads; i++) {
+	for (i = 0; i < params.nwakes; i++) {
 		update_stats(&__waketime_stats, waking_worker[i].runtime.tv_usec);
 		update_stats(&__wakeup_stats, waking_worker[i].nwoken);
 	}
@@ -178,7 +179,7 @@ static void print_run(struct thread_data *waking_worker, unsigned int run_num)
 
 	printf("[Run %d]: Avg per-thread latency (waking %d/%d threads) "
 	       "in %.4f ms (+-%.2f%%)\n", run_num + 1, wakeup_avg,
-	       nblocked_threads, waketime_avg / USEC_PER_MSEC,
+	       params.nthreads, waketime_avg / USEC_PER_MSEC,
 	       rel_stddev_stats(waketime_stddev, waketime_avg));
 }
 
@@ -193,7 +194,7 @@ static void print_summary(void)
 
 	printf("Avg per-thread latency (waking %d/%d threads) in %.4f ms (+-%.2f%%)\n",
 	       wakeup_avg,
-	       nblocked_threads,
+	       params.nthreads,
 	       waketime_avg / USEC_PER_MSEC,
 	       rel_stddev_stats(waketime_stddev, waketime_avg));
 }
@@ -203,7 +204,7 @@ static void do_run_stats(struct thread_data *waking_worker)
 {
 	unsigned int i;
 
-	for (i = 0; i < nwaking_threads; i++) {
+	for (i = 0; i < params.nwakes; i++) {
 		update_stats(&waketime_stats, waking_worker[i].runtime.tv_usec);
 		update_stats(&wakeup_stats, waking_worker[i].nwoken);
 	}
@@ -242,32 +243,33 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 	if (!cpu)
 		err(EXIT_FAILURE, "calloc");
 
-	if (!nblocked_threads)
-		nblocked_threads = cpu->nr;
+	if (!params.nthreads)
+		params.nthreads = cpu->nr;
 
 	/* some sanity checks */
-	if (nwaking_threads > nblocked_threads || !nwaking_threads)
-		nwaking_threads = nblocked_threads;
+	if (params.nwakes > params.nthreads ||
+	    !params.nwakes)
+		params.nwakes = params.nthreads;
 
-	if (nblocked_threads % nwaking_threads)
+	if (params.nthreads % params.nwakes)
 		errx(EXIT_FAILURE, "Must be perfectly divisible");
 	/*
 	 * Each thread will wakeup nwakes tasks in
 	 * a single futex_wait call.
 	 */
-	nwakes = nblocked_threads/nwaking_threads;
+	nwakes = params.nthreads/params.nwakes;
 
-	blocked_worker = calloc(nblocked_threads, sizeof(*blocked_worker));
+	blocked_worker = calloc(params.nthreads, sizeof(*blocked_worker));
 	if (!blocked_worker)
 		err(EXIT_FAILURE, "calloc");
 
-	if (!fshared)
+	if (!params.fshared)
 		futex_flag = FUTEX_PRIVATE_FLAG;
 
 	printf("Run summary [PID %d]: blocking on %d threads (at [%s] "
 	       "futex %p), %d threads waking up %d at a time.\n\n",
-	       getpid(), nblocked_threads, fshared ? "shared":"private",
-	       &futex, nwaking_threads, nwakes);
+	       getpid(), params.nthreads, params.fshared ? "shared":"private",
+	       &futex, params.nwakes, nwakes);
 
 	init_stats(&wakeup_stats);
 	init_stats(&waketime_stats);
@@ -278,7 +280,7 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 	pthread_cond_init(&thread_worker, NULL);
 
 	for (j = 0; j < bench_repeat && !done; j++) {
-		waking_worker = calloc(nwaking_threads, sizeof(*waking_worker));
+		waking_worker = calloc(params.nwakes, sizeof(*waking_worker));
 		if (!waking_worker)
 			err(EXIT_FAILURE, "calloc");
 
@@ -297,14 +299,14 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 		/* Ok, all threads are patiently blocked, start waking folks up */
 		wakeup_threads(waking_worker, thread_attr);
 
-		for (i = 0; i < nblocked_threads; i++) {
+		for (i = 0; i < params.nthreads; i++) {
 			ret = pthread_join(blocked_worker[i], NULL);
 			if (ret)
 				err(EXIT_FAILURE, "pthread_join");
 		}
 
 		do_run_stats(waking_worker);
-		if (!silent)
+		if (!params.silent)
 			print_run(waking_worker, j);
 
 		free(waking_worker);
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index 6d217868f53c..9ed4d65416f3 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -31,25 +31,27 @@
 /* all threads will block on the same futex */
 static u_int32_t futex1 = 0;
 
-/*
- * How many wakeups to do at a time.
- * Default to 1 in order to make the kernel work more.
- */
-static unsigned int nwakes = 1;
-
-pthread_t *worker;
-static bool done = false, silent = false, fshared = false;
+static pthread_t *worker;
+static bool done = false;
 static pthread_mutex_t thread_lock;
 static pthread_cond_t thread_parent, thread_worker;
 static struct stats waketime_stats, wakeup_stats;
-static unsigned int threads_starting, nthreads = 0;
+static unsigned int threads_starting;
 static int futex_flag = 0;
 
+static struct bench_futex_parameters params = {
+	/*
+	 * How many wakeups to do at a time.
+	 * Default to 1 in order to make the kernel work more.
+	 */
+	.nwakes  = 1,
+};
+
 static const struct option options[] = {
-	OPT_UINTEGER('t', "threads", &nthreads, "Specify amount of threads"),
-	OPT_UINTEGER('w', "nwakes",  &nwakes,   "Specify amount of threads to wake at once"),
-	OPT_BOOLEAN( 's', "silent",  &silent,   "Silent mode: do not display data/details"),
-	OPT_BOOLEAN( 'S', "shared",  &fshared,  "Use shared futexes instead of private ones"),
+	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads"),
+	OPT_UINTEGER('w', "nwakes",  &params.nwakes, "Specify amount of threads to wake at once"),
+	OPT_BOOLEAN( 's', "silent",  &params.silent, "Silent mode: do not display data/details"),
+	OPT_BOOLEAN( 'S', "shared",  &params.fshared, "Use shared futexes instead of private ones"),
 	OPT_END()
 };
 
@@ -84,7 +86,7 @@ static void print_summary(void)
 
 	printf("Wokeup %d of %d threads in %.4f ms (+-%.2f%%)\n",
 	       wakeup_avg,
-	       nthreads,
+	       params.nthreads,
 	       waketime_avg / USEC_PER_MSEC,
 	       rel_stddev_stats(waketime_stddev, waketime_avg));
 }
@@ -95,10 +97,10 @@ static void block_threads(pthread_t *w,
 	cpu_set_t cpuset;
 	unsigned int i;
 
-	threads_starting = nthreads;
+	threads_starting = params.nthreads;
 
 	/* create and block all threads */
-	for (i = 0; i < nthreads; i++) {
+	for (i = 0; i < params.nthreads; i++) {
 		CPU_ZERO(&cpuset);
 		CPU_SET(cpu->map[i % cpu->nr], &cpuset);
 
@@ -140,19 +142,20 @@ int bench_futex_wake(int argc, const char **argv)
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
 
-	if (!nthreads)
-		nthreads = cpu->nr;
+	if (!params.nthreads)
+		params.nthreads = cpu->nr;
 
-	worker = calloc(nthreads, sizeof(*worker));
+	worker = calloc(params.nthreads, sizeof(*worker));
 	if (!worker)
 		err(EXIT_FAILURE, "calloc");
 
-	if (!fshared)
+	if (!params.fshared)
 		futex_flag = FUTEX_PRIVATE_FLAG;
 
 	printf("Run summary [PID %d]: blocking on %d threads (at [%s] futex %p), "
 	       "waking up %d at a time.\n\n",
-	       getpid(), nthreads, fshared ? "shared":"private",  &futex1, nwakes);
+	       getpid(), params.nthreads, params.fshared ? "shared":"private",
+	       &futex1, params.nwakes);
 
 	init_stats(&wakeup_stats);
 	init_stats(&waketime_stats);
@@ -179,20 +182,22 @@ int bench_futex_wake(int argc, const char **argv)
 
 		/* Ok, all threads are patiently blocked, start waking folks up */
 		gettimeofday(&start, NULL);
-		while (nwoken != nthreads)
-			nwoken += futex_wake(&futex1, nwakes, futex_flag);
+		while (nwoken != params.nthreads)
+			nwoken += futex_wake(&futex1,
+					     params.nwakes, futex_flag);
 		gettimeofday(&end, NULL);
 		timersub(&end, &start, &runtime);
 
 		update_stats(&wakeup_stats, nwoken);
 		update_stats(&waketime_stats, runtime.tv_usec);
 
-		if (!silent) {
+		if (!params.silent) {
 			printf("[Run %d]: Wokeup %d of %d threads in %.4f ms\n",
-			       j + 1, nwoken, nthreads, runtime.tv_usec / (double)USEC_PER_MSEC);
+			       j + 1, nwoken, params.nthreads,
+			       runtime.tv_usec / (double)USEC_PER_MSEC);
 		}
 
-		for (i = 0; i < nthreads; i++) {
+		for (i = 0; i < params.nthreads; i++) {
 			ret = pthread_join(worker[i], NULL);
 			if (ret)
 				err(EXIT_FAILURE, "pthread_join");
diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index 31b53cc7d5bc..5f98653e6bb3 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -13,6 +13,17 @@
 #include <sys/types.h>
 #include <linux/futex.h>
 
+struct bench_futex_parameters {
+	bool silent;
+	bool fshared;
+	bool multi; /* lock-pi */
+	unsigned int runtime; /* seconds*/
+	unsigned int nthreads;
+	unsigned int nfutexes;
+	unsigned int nwakes;
+	unsigned int nrequeue;
+};
+
 /**
  * futex() - SYS_futex syscall wrapper
  * @uaddr:	address of first futex
-- 
2.26.2

