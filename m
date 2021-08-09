Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E562C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 04:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 158FA60041
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 04:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhHIEdr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 00:33:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59030 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbhHIEdr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 00:33:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4AC2B21F04;
        Mon,  9 Aug 2021 04:33:26 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38EC013398;
        Mon,  9 Aug 2021 04:33:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oOtqBBSwEGEfDQAAMHmgww
        (envelope-from <dave@stgolabs.net>); Mon, 09 Aug 2021 04:33:24 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     acme@kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 7/7] perf/bench-futex, requeue: Add --pi parameter
Date:   Sun,  8 Aug 2021 21:33:01 -0700
Message-Id: <20210809043301.66002-8-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210809043301.66002-1-dave@stgolabs.net>
References: <20210809043301.66002-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This extends the program to measure WAIT_REQUEUE_PI+CMP_REQUEUE_PI
pairs, which are the underlying machinery behind priority-inheritance
aware condition variables. The defaults are the same as with the regular
non-pi version, requeueing one task at a time, with the exception that
PI will always wakeup the first waiter.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 tools/perf/bench/futex-requeue.c | 100 +++++++++++++++++++++++--------
 tools/perf/bench/futex.h         |  37 +++++++++++-
 2 files changed, 111 insertions(+), 26 deletions(-)

diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index e4892ba6864f..03a05814d45e 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -6,7 +6,8 @@
  *                on futex2, N at a time.
  *
  * This program is particularly useful to measure the latency of nthread
- * requeues without waking up any tasks -- thus mimicking a regular futex_wait.
+ * requeues without waking up any tasks (in the non-pi case) -- thus
+ * mimicking a regular futex_wait.
  */
 
 /* For the CLR_() macros */
@@ -53,6 +54,8 @@ static const struct option options[] = {
 	OPT_BOOLEAN( 'S', "shared",   &params.fshared, "Use shared futexes instead of private ones"),
 	OPT_BOOLEAN( 'm', "mlockall", &params.mlockall, "Lock all current and future memory"),
 	OPT_BOOLEAN( 'B', "broadcast", &params.broadcast, "Requeue all threads at once"),
+	OPT_BOOLEAN( 'p', "pi", &params.pi, "Use PI-aware variants of FUTEX_CMP_REQUEUE"),
+
 	OPT_END()
 };
 
@@ -86,14 +89,30 @@ static void *workerfn(void *arg __maybe_unused)
 	pthread_mutex_unlock(&thread_lock);
 
 	while (1) {
-		ret = futex_wait(&futex1, 0, NULL, futex_flag);
-		if (!ret)
-			break;
-
-		if (ret && errno != EAGAIN) {
-			if (!params.silent)
-				warn("futex_wait");
-			break;
+		if (!params.pi) {
+			ret = futex_wait(&futex1, 0, NULL, futex_flag);
+			if (!ret)
+				break;
+
+			if (ret && errno != EAGAIN) {
+				if (!params.silent)
+					warnx("futex_wait");
+				break;
+			}
+		} else {
+			ret = futex_wait_requeue_pi(&futex1, 0, &futex2,
+						    NULL, futex_flag);
+			if (!ret) {
+				/* got the lock at futex2 */
+				futex_unlock_pi(&futex2, futex_flag);
+				break;
+			}
+
+			if (ret && errno != EAGAIN) {
+				if (!params.silent)
+					warnx("futex_wait_requeue_pi");
+				break;
+			}
 		}
 	}
 
@@ -170,9 +189,10 @@ int bench_futex_requeue(int argc, const char **argv)
 	if (params.broadcast)
 		params.nrequeue = params.nthreads;
 
-	printf("Run summary [PID %d]: Requeuing %d threads (from [%s] %p to %p), "
+	printf("Run summary [PID %d]: Requeuing %d threads (from [%s] %p to %s%p), "
 	       "%d at a time.\n\n",  getpid(), params.nthreads,
-	       params.fshared ? "shared":"private", &futex1, &futex2, params.nrequeue);
+	       params.fshared ? "shared":"private", &futex1,
+	       params.pi ? "PI ": "", &futex2, params.nrequeue);
 
 	init_stats(&requeued_stats);
 	init_stats(&requeuetime_stats);
@@ -182,7 +202,7 @@ int bench_futex_requeue(int argc, const char **argv)
 	pthread_cond_init(&thread_worker, NULL);
 
 	for (j = 0; j < bench_repeat && !done; j++) {
-		unsigned int nrequeued = 0;
+		unsigned int nrequeued = 0, wakeups = 0;
 		struct timeval start, end, runtime;
 
 		/* create, launch & block all threads */
@@ -200,13 +220,30 @@ int bench_futex_requeue(int argc, const char **argv)
 		/* Ok, all threads are patiently blocked, start requeueing */
 		gettimeofday(&start, NULL);
 		while (nrequeued < params.nthreads) {
+			int r;
+
 			/*
-			 * Do not wakeup any tasks blocked on futex1, allowing
-			 * us to really measure futex_wait functionality.
+			 * For the regular non-pi case, do not wakeup any tasks
+			 * blocked on futex1, allowing us to really measure
+			 * futex_wait functionality. For the PI case the first
+			 * waiter is always awoken.
 			 */
-			nrequeued += futex_cmp_requeue(&futex1, 0, &futex2, 0,
-						       params.nrequeue,
-						       futex_flag);
+			if (!params.pi) {
+				r = futex_cmp_requeue(&futex1, 0, &futex2, 0,
+						      params.nrequeue,
+						      futex_flag);
+			} else {
+				r = futex_cmp_requeue_pi(&futex1, 0, &futex2,
+							 params.nrequeue,
+							 futex_flag);
+				wakeups++; /* assume no error */
+			}
+
+			if (r < 0)
+				err(EXIT_FAILURE, "couldn't requeue from %p to %p",
+				    &futex1, &futex2);
+
+			nrequeued += r;
 		}
 
 		gettimeofday(&end, NULL);
@@ -216,16 +253,29 @@ int bench_futex_requeue(int argc, const char **argv)
 		update_stats(&requeuetime_stats, runtime.tv_usec);
 
 		if (!params.silent) {
-			printf("[Run %d]: Requeued %d of %d threads in %.4f ms\n",
-			       j + 1, nrequeued, params.nthreads,
-			       runtime.tv_usec / (double)USEC_PER_MSEC);
+			if (!params.pi)
+				printf("[Run %d]: Requeued %d of %d threads in "
+				       "%.4f ms\n", j + 1, nrequeued,
+				       params.nthreads,
+				       runtime.tv_usec / (double)USEC_PER_MSEC);
+			else {
+				nrequeued -= wakeups;
+				printf("[Run %d]: Awoke and Requeued (%d+%d) of "
+				       "%d threads in %.4f ms\n",
+				       j + 1, wakeups, nrequeued,
+				       params.nthreads,
+				       runtime.tv_usec / (double)USEC_PER_MSEC);
+			}
+
 		}
 
-		/* everybody should be blocked on futex2, wake'em up */
-		nrequeued = futex_wake(&futex2, nrequeued, futex_flag);
-		if (params.nthreads != nrequeued)
-			warnx("couldn't wakeup all tasks (%d/%d)",
-			      nrequeued, params.nthreads);
+		if (!params.pi) {
+			/* everybody should be blocked on futex2, wake'em up */
+			nrequeued = futex_wake(&futex2, nrequeued, futex_flag);
+			if (params.nthreads != nrequeued)
+				warnx("couldn't wakeup all tasks (%d/%d)",
+				      nrequeued, params.nthreads);
+		}
 
 		for (i = 0; i < params.nthreads; i++) {
 			ret = pthread_join(worker[i], NULL);
diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index 36f158650edf..f0ad6d988349 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -21,6 +21,7 @@ struct bench_futex_parameters {
 	bool fshared;
 	bool mlockall;
 	bool multi; /* lock-pi */
+	bool pi; /* requeue-pi */
 	bool broadcast; /* requeue */
 	unsigned int runtime; /* seconds*/
 	unsigned int nthreads;
@@ -93,7 +94,7 @@ futex_unlock_pi(u_int32_t *uaddr, int opflags)
 /**
 * futex_cmp_requeue() - requeue tasks from uaddr to uaddr2
 * @nr_wake:        wake up to this many tasks
-* @nr_requeue:        requeue up to this many tasks
+* @nr_requeue:     requeue up to this many tasks
 */
 static inline int
 futex_cmp_requeue(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2, int nr_wake,
@@ -102,4 +103,38 @@ futex_cmp_requeue(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2, int nr_wak
 	return futex(uaddr, FUTEX_CMP_REQUEUE, nr_wake, nr_requeue, uaddr2,
 		 val, opflags);
 }
+
+/**
+ * futex_wait_requeue_pi() - block on uaddr and prepare to requeue to uaddr2
+ * @uaddr:	non-PI futex source
+ * @uaddr2:	PI futex target
+ *
+ * This is the first half of the requeue_pi mechanism. It shall always be
+ * paired with futex_cmp_requeue_pi().
+ */
+static inline int
+futex_wait_requeue_pi(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2,
+		      struct timespec *timeout, int opflags)
+{
+	return futex(uaddr, FUTEX_WAIT_REQUEUE_PI, val, timeout, uaddr2, 0,
+		     opflags);
+}
+
+/**
+ * futex_cmp_requeue_pi() - requeue tasks from uaddr to uaddr2
+ * @uaddr:	non-PI futex source
+ * @uaddr2:	PI futex target
+ * @nr_requeue:	requeue up to this many tasks
+ *
+ * This is the second half of the requeue_pi mechanism. It shall always be
+ * paired with futex_wait_requeue_pi(). The first waker is always awoken.
+ */
+static inline int
+futex_cmp_requeue_pi(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2,
+		     int nr_requeue, int opflags)
+{
+	return futex(uaddr, FUTEX_CMP_REQUEUE_PI, 1, nr_requeue, uaddr2,
+		     val, opflags);
+}
+
 #endif /* _FUTEX_H */
-- 
2.26.2

