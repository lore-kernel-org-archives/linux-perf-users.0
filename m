Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E675C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5843260FDA
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239646AbhHTKzR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239479AbhHTKzG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Aug 2021 06:55:06 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59F6C0612E7;
        Fri, 20 Aug 2021 03:54:23 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id q3so13407243edt.5;
        Fri, 20 Aug 2021 03:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SUXeqCV+Zu6HYvK9lSq8KFT8ZqIRZTCMmeyZKMorHsg=;
        b=lnlmg92Hsz+1gXF1pammlwPUvndHY7Z5wmUaZEWLOcsmDs4Zk+xW2Hh3wInrhoddQy
         d4iTw2E8mcOUH3T1Xnz5JMc/9yr/3TxmGzXQIZR/s7QbPaKgcOFOAzbZksAtZIujfrDv
         JILIUGLj2P9ZqTarUkr1zcyg6fMqR5TFUMDyvndHNwbs4qWn4RebBPtvPS1hFeRcvuUZ
         sx8HRu7kgn0VknTvACnBcXayv0/urOduD+3DBMlI7a8xmuQoenMEFXc1r2sFNO1I3Wer
         Le40yLx1WgOh57scDSxCYnHpoMtgakSnOFIRjlabpd8GVHNpMvtk01Ay061+xG9nQiIm
         55yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SUXeqCV+Zu6HYvK9lSq8KFT8ZqIRZTCMmeyZKMorHsg=;
        b=WPTIx7kGY+JUiHrnzP9X3w+psdvQ10u458edEkALZxEILaD421IaaL3jodbtvVhPET
         U6QEhoJuFCUnu15GRuZMA6/Dt8wec2+CxgrYy3sTZSyMMFzss+YTZhL3I7IoNTwVFol5
         O9p5ojOhhZFJr/z1JLK4WgHdxKA83RQ5G1KEwlrLz1E5GHZO5wunQWZG0p+We9hSoc7L
         SCThprPxHJnjmqVD0V5F+MQd7bKU5b4pnLQ0rqkazV34bsMMEt8hbblpErxhXAudmH1k
         4TNV4zQPfIu8g0CY0okwtSy0TDAy+0t9kmtq2BxLcs7otC0FZSZKkJ+8aCRg2zb508ib
         Aotg==
X-Gm-Message-State: AOAM531BfMyT419P88ssBoodFRaDfh12GeYVzwfDcyBvSokPWXbE4e0G
        UoCu9S/BLgmc2GKWg55jRa4=
X-Google-Smtp-Source: ABdhPJyULc9QSu4vZdhcdIcXO7EAfcD51CgsJTWBQADd2soOZr1NmcyKy8my/T08OUXWSEqwanERqQ==
X-Received: by 2002:a50:9f25:: with SMTP id b34mr480868edf.323.1629456862244;
        Fri, 20 Aug 2021 03:54:22 -0700 (PDT)
Received: from honeypot.epfl.ch (mob-176-243-199-7.net.vodafone.it. [176.243.199.7])
        by smtp.googlemail.com with ESMTPSA id g29sm3451459edf.31.2021.08.20.03.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 03:54:21 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [RFC PATCH v3 08/15] perf workqueue: add queue_work and flush_workqueue functions
Date:   Fri, 20 Aug 2021 12:53:54 +0200
Message-Id: <f9100c6e428eafe1b9761f947550e45ccc9e8849.1629454773.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629454773.git.rickyman7@gmail.com>
References: <cover.1629454773.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds functions to queue and wait work_structs, and
related tests.

When a new work item is added, the workqueue first checks if there
are threads to wake up. If so, it wakes it up with the given work item,
otherwise it will pick the next round-robin thread and queue the work
item to its queue. A thread which completes its queue will go to sleep.

The round-robin mechanism is implemented through the next_worker
attibute which will point to the next worker to be chosen for queueing.
When work is assigned to that worker or when the worker goes to sleep,
the pointer is moved to the next worker in the busy_list, if any.
When a worker is woken up, it is added in the busy list just before the
next_worker, so that it will be chosen as last (it's just been assigned
a work item).

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/tests/workqueue.c          |  71 ++++++++++-
 tools/perf/util/workqueue/workqueue.c | 176 +++++++++++++++++++++++++-
 tools/perf/util/workqueue/workqueue.h |   9 ++
 3 files changed, 254 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/workqueue.c b/tools/perf/tests/workqueue.c
index 1aa6ee788b0b1c32..194bab2f3f668ce9 100644
--- a/tools/perf/tests/workqueue.c
+++ b/tools/perf/tests/workqueue.c
@@ -147,6 +147,28 @@ static int __test__threadpool(void *_args)
 	return ret;
 }
 
+struct test_work {
+	struct work_struct work;
+	int i;
+	int *array;
+};
+
+static void test_work_fn1(struct work_struct *work)
+{
+	struct test_work *mwork = container_of(work, struct test_work, work);
+
+	dummy_work(mwork->i);
+	mwork->array[mwork->i] = mwork->i+1;
+}
+
+static void test_work_fn2(struct work_struct *work)
+{
+	struct test_work *mwork = container_of(work, struct test_work, work);
+
+	dummy_work(mwork->i);
+	mwork->array[mwork->i] = mwork->i*2;
+}
+
 static int __workqueue__prepare(struct workqueue_struct **wq,
 				int pool_size)
 {
@@ -166,21 +188,68 @@ static int __workqueue__teardown(struct workqueue_struct *wq)
 	return 0;
 }
 
+static int __workqueue__exec_wait(struct workqueue_struct *wq,
+				int *array, struct test_work *works,
+				work_func_t func, int n_work_items)
+{
+	int ret, i;
+
+	for (i = 0; i < n_work_items; i++) {
+		works[i].array = array;
+		works[i].i = i;
+
+		init_work(&works[i].work);
+		works[i].work.func = func;
+		queue_work(wq, &works[i].work);
+	}
+
+	ret = flush_workqueue(wq);
+	TEST_ASSERT_VAL("workqueue flush failure", ret == 0);
+
+	return TEST_OK;
+}
+
+
 static int __test__workqueue(void *_args)
 {
 	struct workqueue_test_args_t *args = _args;
 	struct workqueue_struct *wq;
+	struct test_work *works;
+	int *array;
 	int pool_size = args->pool_size ?: sysconf(_SC_NPROCESSORS_ONLN);
-	int ret = __workqueue__prepare(&wq, pool_size);
+	int i, ret = __workqueue__prepare(&wq, pool_size);
 
+	if (ret)
+		return ret;
+
+	array = calloc(args->n_work_items, sizeof(*array));
+	TEST_ASSERT_VAL("failed array calloc", array);
+	works = calloc(args->n_work_items, sizeof(*works));
+	TEST_ASSERT_VAL("failed works calloc", works);
+
+	ret = __workqueue__exec_wait(wq, array, works, test_work_fn1,
+					args->n_work_items);
 	if (ret)
 		goto out;
 
+	for (i = 0; i < args->n_work_items; i++)
+		TEST_ASSERT_VAL("failed array check (1)", array[i] == i+1);
+
+	ret = __workqueue__exec_wait(wq, array, works, test_work_fn2,
+					args->n_work_items);
+	if (ret)
+		goto out;
+
+	for (i = 0; i < args->n_work_items; i++)
+		TEST_ASSERT_VAL("failed array check (2)", array[i] == 2*i);
+
 	ret = __workqueue__teardown(wq);
 	if (ret)
 		goto out;
 
 out:
+	free(array);
+	free(works);
 	return ret;
 }
 
diff --git a/tools/perf/util/workqueue/workqueue.c b/tools/perf/util/workqueue/workqueue.c
index a2747fcc004ab0d1..1092ece9ad39d6d2 100644
--- a/tools/perf/util/workqueue/workqueue.c
+++ b/tools/perf/util/workqueue/workqueue.c
@@ -38,6 +38,7 @@ struct workqueue_struct {
 	struct list_head	idle_list;	/* idle workers */
 	int			msg_pipe[2];	/* main thread comm pipes */
 	struct worker		**workers;	/* array of all workers */
+	struct worker		*next_worker;	/* next worker to choose (round robin) */
 };
 
 static const char * const workqueue_errno_str[] = {
@@ -48,6 +49,8 @@ static const char * const workqueue_errno_str[] = {
 	"Error sending message to worker",
 	"Error receiving message from worker",
 	"Received unexpected message from worker",
+	"Worker is not ready",
+	"Worker is in an unrecognized status",
 };
 
 struct worker {
@@ -94,6 +97,15 @@ __releases(&worker->lock)
 	return pthread_mutex_unlock(&worker->lock);
 }
 
+static void advance_next_worker(struct workqueue_struct *wq)
+__must_hold(&wq->lock)
+{
+	if (list_is_last(&wq->next_worker->entry, &wq->busy_list))
+		wq->next_worker = list_first_entry(&wq->busy_list, struct worker, entry);
+	else
+		wq->next_worker = list_next_entry(wq->next_worker, entry);
+}
+
 /**
  * available_work - check if worker @worker has work to do
  */
@@ -159,9 +171,13 @@ static void sleep_worker(struct workqueue_struct *wq, struct worker *worker)
 __must_hold(&wq->lock)
 {
 	worker->status = WORKER_STATUS__IDLE;
+	if (wq->next_worker == worker)
+		advance_next_worker(wq);
 	list_move(&worker->entry, &wq->idle_list);
-	if (list_empty(&wq->busy_list))
+	if (list_empty(&wq->busy_list)) {
+		wq->next_worker = NULL;
 		pthread_cond_signal(&wq->idle_cond);
+	}
 }
 
 /**
@@ -196,6 +212,52 @@ __must_hold(&worker->lock)
 	}
 }
 
+/**
+ * wake_worker - prepare for waking worker @worker of workqueue @wq assigning @work to do
+ *
+ * Called from main thread.
+ * Moves worker from idle to busy list and assigns @work to it.
+ * Must call wake_worker outside critical section afterwards.
+ */
+static int prepare_wake_worker(struct workqueue_struct *wq, struct worker *worker,
+			struct work_struct *work)
+__must_hold(&wq->lock)
+__must_hold(&worker->lock)
+{
+	if (wq->next_worker)
+		list_move_tail(&worker->entry, &wq->next_worker->entry);
+	else
+		list_move(&worker->entry, &wq->busy_list);
+	wq->next_worker = worker;
+
+	list_add_tail(&work->entry, &worker->queue);
+	worker->status = WORKER_STATUS__BUSY;
+
+	return 0;
+}
+
+/**
+ * wake_worker - send wake message to worker @worker of workqueue @wq
+ *
+ * Called from main thread.
+ * Must be called after prepare_wake_worker and outside critical section to
+ * reduce time spent inside it
+ */
+static int wake_worker(struct worker *worker)
+{
+	enum worker_msg msg = WORKER_MSG__WAKE;
+	int ret;
+	char sbuf[STRERR_BUFSIZE];
+
+	ret = writen(worker->msg_pipe[1], &msg, sizeof(msg));
+	if (ret < 0) {
+		pr_debug2("wake worker %d: error seding msg: %s\n",
+			worker->tidx, str_error_r(errno, sbuf, sizeof(sbuf)));
+		return -WORKQUEUE_ERROR__WRITEPIPE;
+	}
+
+	return 0;
+}
 
 /**
  * stop_worker - stop worker @worker
@@ -418,6 +480,8 @@ struct workqueue_struct *create_workqueue(int nr_threads)
 			goto out_stop_pool;
 	}
 
+	wq->next_worker = NULL;
+
 	return wq;
 
 out_stop_pool:
@@ -532,6 +596,8 @@ int workqueue_strerror(struct workqueue_struct *wq, int err, char *buf, size_t s
 		emsg = str_error_r(errno, sbuf, sizeof(sbuf));
 		return scnprintf(buf, size, "%s: %s.\n", errno_str, emsg);
 	case -WORKQUEUE_ERROR__INVALIDMSG:
+	case -WORKQUEUE_ERROR__INVALIDWORKERSTATUS:
+	case -WORKQUEUE_ERROR__NOTREADY:
 		return scnprintf(buf, size, "%s.\n", errno_str);
 	default:
 		emsg = str_error_r(err, sbuf, sizeof(sbuf));
@@ -566,3 +632,111 @@ int workqueue_nr_threads(struct workqueue_struct *wq)
 {
 	return threadpool__size(wq->pool);
 }
+
+/**
+ * __queue_work_on_worker - add @work to the internal queue of worker @worker
+ *
+ * NB: this function releases the locks to be able to send notification to
+ * thread outside the critical section.
+ */
+static int __queue_work_on_worker(struct workqueue_struct *wq __maybe_unused,
+				struct worker *worker, struct work_struct *work)
+__must_hold(&wq->lock)
+__must_hold(&worker->lock)
+__releases(&wq->lock)
+__releases(&worker->lock)
+{
+	int ret;
+
+	switch (worker->status) {
+	case WORKER_STATUS__BUSY:
+		list_add_tail(&work->entry, &worker->queue);
+
+		unlock_worker(worker);
+		unlock_workqueue(wq);
+		pr_debug("workqueue: queued new work item\n");
+		return 0;
+	case WORKER_STATUS__IDLE:
+		ret = prepare_wake_worker(wq, worker, work);
+		unlock_worker(worker);
+		unlock_workqueue(wq);
+		if (ret)
+			return ret;
+		ret = wake_worker(worker);
+		if (!ret)
+		pr_debug("workqueue: woke worker %d\n", worker->tidx);
+		return ret;
+	default:
+	case WORKER_STATUS__MAX:
+		unlock_worker(worker);
+		unlock_workqueue(wq);
+		pr_debug2("workqueue: worker is in unrecognized status %d\n",
+			worker->status);
+		return -WORKQUEUE_ERROR__INVALIDWORKERSTATUS;
+	}
+
+	return 0;
+}
+
+/**
+ * queue_work - add @work to @wq internal queue
+ *
+ * If there are idle threads, one of these will be woken up.
+ * Otherwise, the work is added to the pending list.
+ */
+int queue_work(struct workqueue_struct *wq, struct work_struct *work)
+{
+	struct worker *worker;
+
+	lock_workqueue(wq);
+	if (list_empty(&wq->idle_list)) {
+		worker = wq->next_worker;
+		advance_next_worker(wq);
+	} else {
+		worker = list_first_entry(&wq->idle_list, struct worker, entry);
+	}
+	lock_worker(worker);
+
+	return __queue_work_on_worker(wq, worker, work);
+}
+
+/**
+ * queue_work_on_worker - add @work to worker @tidx internal queue
+ */
+int queue_work_on_worker(int tidx, struct workqueue_struct *wq, struct work_struct *work)
+{
+	lock_workqueue(wq);
+	lock_worker(wq->workers[tidx]);
+	return __queue_work_on_worker(wq, wq->workers[tidx], work);
+}
+
+/**
+ * flush_workqueue - wait for all currently executed and pending work to finish
+ *
+ * This function blocks until all threads become idle.
+ */
+int flush_workqueue(struct workqueue_struct *wq)
+{
+	int err = 0, ret;
+
+	lock_workqueue(wq);
+	while (!list_empty(&wq->busy_list)) {
+		ret = pthread_cond_wait(&wq->idle_cond, &wq->lock);
+		if (ret) {
+			pr_debug2("%s: error in pthread_cond_wait\n", __func__);
+			err = -ret;
+			break;
+		}
+	}
+	unlock_workqueue(wq);
+
+	return err;
+}
+
+/**
+ * init_work - initialize the @work struct
+ */
+void init_work(struct work_struct *work)
+{
+	INIT_LIST_HEAD(&work->entry);
+}
diff --git a/tools/perf/util/workqueue/workqueue.h b/tools/perf/util/workqueue/workqueue.h
index 100841cc035fde1d..37ef84fc9c6ed4b6 100644
--- a/tools/perf/util/workqueue/workqueue.h
+++ b/tools/perf/util/workqueue/workqueue.h
@@ -22,6 +22,13 @@ extern int destroy_workqueue(struct workqueue_struct *wq);
 
 extern int workqueue_nr_threads(struct workqueue_struct *wq);
 
+extern int queue_work(struct workqueue_struct *wq, struct work_struct *work);
+extern int queue_work_on_worker(int tidx, struct workqueue_struct *wq, struct work_struct *work);
+
+extern int flush_workqueue(struct workqueue_struct *wq);
+
+extern void init_work(struct work_struct *work);
+
 #define WORKQUEUE_STRERR_BUFSIZE (128+THREADPOOL_STRERR_BUFSIZE)
 #define WORKQUEUE_ERROR__OFFSET 512
 enum {
@@ -32,6 +39,8 @@ enum {
 	WORKQUEUE_ERROR__WRITEPIPE,
 	WORKQUEUE_ERROR__READPIPE,
 	WORKQUEUE_ERROR__INVALIDMSG,
+	WORKQUEUE_ERROR__NOTREADY,
+	WORKQUEUE_ERROR__INVALIDWORKERSTATUS,
 };
 extern int workqueue_strerror(struct workqueue_struct *wq, int err, char *buf, size_t size);
 extern int create_workqueue_strerror(struct workqueue_struct *err_ptr, char *buf, size_t size);
-- 
2.31.1

