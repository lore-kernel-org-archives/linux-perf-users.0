Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86E9C432BE
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 01:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DE4761184
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 01:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243209AbhHFBd4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 5 Aug 2021 21:33:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50792 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243210AbhHFBdz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 Aug 2021 21:33:55 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9A8D3223C7;
        Fri,  6 Aug 2021 01:33:39 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BF4E13DD1;
        Fri,  6 Aug 2021 01:33:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OIMXBXKRDGFiBgAAMHmgww
        (envelope-from <dave@stgolabs.net>); Fri, 06 Aug 2021 01:33:38 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 3/3] perf/bench-futex, requeue: Add --pi parameter
Date:   Thu,  5 Aug 2021 18:33:29 -0700
Message-Id: <20210806013329.94627-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210806013329.94627-1-dave@stgolabs.net>
References: <20210806013329.94627-1-dave@stgolabs.net>
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
 tools/perf/bench/futex-requeue.c | 81 +++++++++++++++++++++++++-------
 tools/perf/bench/futex.h         | 40 ++++++++++++++--
 2 files changed, 100 insertions(+), 21 deletions(-)

diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index 51f2c0d5e6f8..fcbf04235d94 100644
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
@@ -41,7 +42,8 @@ static int futex_flag = 0;
 
 struct parameters {
 	unsigned int nthreads;
-        unsigned int nrequeue;
+	unsigned int nrequeue;
+	bool pi;
 	bool silent;
 	bool fshared;
 	bool mlockall;
@@ -60,6 +62,8 @@ static const struct option options[] = {
 		     "Specify amount of threads"),
 	OPT_UINTEGER('q', "nrequeue", &params.nrequeue,
 		     "Specify amount of threads to requeue at once"),
+	OPT_BOOLEAN( 'p', "pi", &params.pi,
+		     "Use PI-aware variants of FUTEX_CMP_REQUEUE"),
 	OPT_BOOLEAN( 's', "silent",   &params.silent,
 		     "Silent mode: do not display data/details"),
 	OPT_BOOLEAN( 'S', "shared",   &params.fshared,
@@ -96,7 +100,18 @@ static void *workerfn(void *arg __maybe_unused)
 	pthread_cond_wait(&thread_worker, &thread_lock);
 	pthread_mutex_unlock(&thread_lock);
 
-	futex_wait(&futex1, 0, NULL, futex_flag);
+	if (!params.pi)
+		futex_wait(&futex1, 0, NULL, futex_flag);
+	else {
+		int ret = futex_wait_requeue_pi(&futex1, 0, &futex2,
+						 NULL, futex_flag);
+		if (ret)
+			warnx("waiter was not requeued");
+		else
+			futex_unlock_pi(&futex2, futex_flag);
+	}
+
+
 	return NULL;
 }
 
@@ -167,9 +182,10 @@ int bench_futex_requeue(int argc, const char **argv)
 	if (params.nrequeue > params.nthreads)
 		params.nrequeue = params.nthreads;
 
-	printf("Run summary [PID %d]: Requeuing %d threads (from [%s] %p to %p), "
+	printf("Run summary [PID %d]: Requeuing %d threads (from [%s] %p to %s%p), "
 	       "%d at a time.\n\n",  getpid(), params.nthreads,
-	       params.fshared ? "shared":"private", &futex1, &futex2, params.nrequeue);
+	       params.fshared ? "shared":"private", &futex1,
+	       params.pi ? "PI ": "", &futex2, params.nrequeue);
 
 	init_stats(&requeued_stats);
 	init_stats(&requeuetime_stats);
@@ -179,7 +195,7 @@ int bench_futex_requeue(int argc, const char **argv)
 	pthread_cond_init(&thread_worker, NULL);
 
 	for (j = 0; j < bench_repeat && !done; j++) {
-		unsigned int nrequeued = 0;
+		unsigned int nrequeued = 0, wakeups = 0;
 		struct timeval start, end, runtime;
 
 		/* create, launch & block all threads */
@@ -197,13 +213,30 @@ int bench_futex_requeue(int argc, const char **argv)
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
@@ -213,16 +246,28 @@ int bench_futex_requeue(int argc, const char **argv)
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
 		}
 
 		/* everybody should be blocked on futex2, wake'em up */
-		nrequeued = futex_wake(&futex2, nrequeued, futex_flag);
-		if (params.nthreads != nrequeued)
-			warnx("couldn't wakeup all tasks (%d/%d)",
-			      nrequeued, params.nthreads);
+		if (!params.pi) {
+			nrequeued = futex_wake(&futex2, nrequeued, futex_flag);
+			if (params.nthreads != nrequeued)
+				err(EXIT_FAILURE, "couldn't wakeup all tasks (%d/%d)",
+				    nrequeued, params.nthreads);
+		}
 
 		for (i = 0; i < params.nthreads; i++) {
 			ret = pthread_join(worker[i], NULL);
diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index 31b53cc7d5bc..f64a3c231184 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -77,13 +77,47 @@ futex_unlock_pi(u_int32_t *uaddr, int opflags)
 /**
 * futex_cmp_requeue() - requeue tasks from uaddr to uaddr2
 * @nr_wake:        wake up to this many tasks
-* @nr_requeue:        requeue up to this many tasks
+* @nr_requeue:     requeue up to this many tasks
 */
 static inline int
-futex_cmp_requeue(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2, int nr_wake,
-		 int nr_requeue, int opflags)
+futex_cmp_requeue(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2,
+		  int nr_wake, int nr_requeue, int opflags)
 {
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

