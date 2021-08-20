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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A19C432BE
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25A4C60FDA
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbhHTKzP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239463AbhHTKzG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Aug 2021 06:55:06 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E40C0617AF;
        Fri, 20 Aug 2021 03:54:21 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id i6so13427598edu.1;
        Fri, 20 Aug 2021 03:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q55uo43bY1SXvA3GYrgM6zZrZfx+fjnW8CY5H1JInLE=;
        b=UHP3gDcBRnjk2ej1kI131dy09iFi6R0dwLtdWWB9V+z+lnq6zGbzyBoek8yafaPJO1
         dHHY/nNyFjXf0LTAG5k+zj7HOKWJZslw4DMbrQtEySs1v6Yo/6xUVjXuu2Scfa6s7XFM
         DW6znoQwLJVlbIqTJ+fDAqF8RQpTA+rD5UXiRZC2iFqNqEpBVXdfCs4BtArWG4UMbjdm
         9Un/WWiCjgX6rhIFq/PeVjn3JC5kS9feVE+Ri1f50LCy9Ejd+yTc8Z/a167skdo0q4Lq
         +UWHz8BxQN5lrjhaPOoVYISEaDctbchIdeVJcxONLv/HGuUKeU4+aUQ72b9fg17x41u9
         c0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q55uo43bY1SXvA3GYrgM6zZrZfx+fjnW8CY5H1JInLE=;
        b=UmxxAFQhLPoI3hHo4sJlWHhQmD0g/TIHWkiu/RVmSCSQKHH4trVM4MsI3qgh1HMf+c
         z2sJr+JvLC9bg1lYt6qXX4QnU87DBxYmlj/jYN+kRGjVv37JIx4tzJPIHx9gm5KNxp4z
         AKEj+qzVvcS6n2i0oiismYJGjXsNNR8XFiR0wf62KDzRab9K1fKeiXIAYytC6J71a4N8
         ofdF/UTfGnUCAuF0yj72U/imbrPY43E5Mjcq8UPXhC9YjBqf0+pwQKuSG4g9+WUcIRSA
         y6JqUuVA3viawqZi3WiJGxKcNVHgFJojiXnRVSUjdWiWaXio0znB59H3nKMEhnY4yKQD
         d1Wg==
X-Gm-Message-State: AOAM531LrFYiyKpqd7fDDcA7RInc0LcxgGnu0o+7psHY71hpAdCNK0QO
        SYRDDIqOTSsd3o6b0Wrtxto=
X-Google-Smtp-Source: ABdhPJzg3pMRmhlNLTffHuEjLklk61jP1PHpiTtWUeXtTKcPPC6dg+eLTOKbOZaMLrTydXKb9o9wQw==
X-Received: by 2002:a05:6402:2049:: with SMTP id bc9mr21450396edb.130.1629456860387;
        Fri, 20 Aug 2021 03:54:20 -0700 (PDT)
Received: from honeypot.epfl.ch (mob-176-243-199-7.net.vodafone.it. [176.243.199.7])
        by smtp.googlemail.com with ESMTPSA id g29sm3451459edf.31.2021.08.20.03.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 03:54:19 -0700 (PDT)
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
Subject: [RFC PATCH v3 07/15] perf workqueue: implement worker thread and management
Date:   Fri, 20 Aug 2021 12:53:53 +0200
Message-Id: <e88e4e61309845043d1f0939b5c33cd60e9d3ed5.1629454773.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629454773.git.rickyman7@gmail.com>
References: <cover.1629454773.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds the implementation of the worker thread that is executed
in the threadpool, and all management-related functions.

At startup, a worker registers itself with the workqueue by adding itself
to the idle_list, then it sends an ack back to the main thread. When
creating wotkers, the main thread will wait for the related acks.
Once there is work to do, threads are woken up to perform the work.
Threads will try to dequeue a new pending work before going to sleep.

This registering mechanism has been implemented to enable for lazy spin
up of worker threads in following patches

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/workqueue/workqueue.c | 376 +++++++++++++++++++++++++-
 1 file changed, 374 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/workqueue/workqueue.c b/tools/perf/util/workqueue/workqueue.c
index 053aac43e038f0b7..a2747fcc004ab0d1 100644
--- a/tools/perf/util/workqueue/workqueue.c
+++ b/tools/perf/util/workqueue/workqueue.c
@@ -13,6 +13,21 @@
 #include <internal/lib.h>
 #include "workqueue.h"
 
+enum worker_msg {
+	WORKER_MSG__UNDEFINED,
+	WORKER_MSG__READY,                          /* from worker: ack */
+	WORKER_MSG__WAKE,                           /* to worker: wake up */
+	WORKER_MSG__STOP,                           /* to worker: exit */
+	WORKER_MSG__ERROR,
+	WORKER_MSG__MAX
+};
+
+enum worker_status {
+	WORKER_STATUS__IDLE,		/* worker is sleeping, waiting for signal */
+	WORKER_STATUS__BUSY,		/* worker is executing */
+	WORKER_STATUS__MAX
+};
+
 struct workqueue_struct {
 	pthread_mutex_t		lock;		/* locking of the workqueue */
 	pthread_cond_t		idle_cond;	/* all workers are idle cond */
@@ -22,6 +37,7 @@ struct workqueue_struct {
 	struct list_head	busy_list;	/* busy workers */
 	struct list_head	idle_list;	/* idle workers */
 	int			msg_pipe[2];	/* main thread comm pipes */
+	struct worker		**workers;	/* array of all workers */
 };
 
 static const char * const workqueue_errno_str[] = {
@@ -34,6 +50,310 @@ static const char * const workqueue_errno_str[] = {
 	"Received unexpected message from worker",
 };
 
+struct worker {
+	pthread_mutex_t			lock;		/* locking of the thread_pool */
+	int				tidx;		/* idx of thread in pool */
+	struct list_head		entry;		/* in idle or busy list */
+	struct work_struct		*current_work;	/* work being processed */
+	int				msg_pipe[2];	/* main thread comm pipes*/
+	struct list_head		queue;		/* pending work items */
+	enum worker_status		status;		/* worker status */
+};
+
+#define for_each_busy_worker(wq, m_worker) \
+	list_for_each_entry(m_worker, &wq->busy_list, entry)
+
+#define for_each_idle_worker(wq, m_worker) \
+	list_for_each_entry(m_worker, &wq->idle_list, entry)
+
+static inline int lock_workqueue(struct workqueue_struct *wq)
+__acquires(&wq->lock)
+{
+	__acquire(&wq->lock);
+	return pthread_mutex_lock(&wq->lock);
+}
+
+static inline int unlock_workqueue(struct workqueue_struct *wq)
+__releases(&wq->lock)
+{
+	__release(&wq->lock);
+	return pthread_mutex_unlock(&wq->lock);
+}
+
+static inline int lock_worker(struct worker *worker)
+__acquires(&worker->lock)
+{
+	__acquire(&worker->lock);
+	return pthread_mutex_lock(&worker->lock);
+}
+
+static inline int unlock_worker(struct worker *worker)
+__releases(&worker->lock)
+{
+	__release(&worker->lock);
+	return pthread_mutex_unlock(&worker->lock);
+}
+
+/**
+ * available_work - check if worker @worker has work to do
+ */
+static int available_work(struct worker *worker)
+__must_hold(&worker->lock)
+{
+	return !list_empty(&worker->queue);
+}
+
+/**
+ * dequeue_work - retrieve the next work in worker @worker's queue
+ *
+ * Called inside worker.
+ */
+static struct work_struct *dequeue_work(struct worker *worker)
+__must_hold(&worker->lock)
+{
+	struct work_struct *work = list_first_entry(&worker->queue, struct work_struct, entry);
+
+	list_del_init(&work->entry);
+	return work;
+}
+
+/**
+ * spinup_worker - start worker underlying thread and wait for it
+ *
+ * This function MUST NOT hold any lock and can be called only from main thread.
+ */
+static int spinup_worker(struct workqueue_struct *wq, int tidx)
+{
+	int ret;
+	enum worker_msg msg = WORKER_MSG__UNDEFINED;
+	char sbuf[STRERR_BUFSIZE];
+
+	wq->pool_errno = threadpool__start_thread(wq->pool, tidx);
+	if (wq->pool_errno)
+		return -WORKQUEUE_ERROR__POOLSTARTTHREAD;
+
+	ret = readn(wq->msg_pipe[0], &msg, sizeof(msg));
+	if (ret < 0) {
+		pr_debug("workqueue: error receiving ack: %s\n",
+			str_error_r(errno, sbuf, sizeof(sbuf)));
+		return -WORKQUEUE_ERROR__READPIPE;
+	}
+	if (msg != WORKER_MSG__READY) {
+		pr_debug2("workqueue: received error\n");
+		return -WORKQUEUE_ERROR__INVALIDMSG;
+	}
+
+	pr_debug("workqueue: spinup worker %d\n", tidx);
+
+	return 0;
+}
+
+/**
+ * sleep_worker - worker @worker of workqueue @wq goes to sleep
+ *
+ * Called inside worker.
+ * If this was the last idle thread, signal it to the main thread, in case it
+ * was flushing the workqueue.
+ */
+static void sleep_worker(struct workqueue_struct *wq, struct worker *worker)
+__must_hold(&wq->lock)
+{
+	worker->status = WORKER_STATUS__IDLE;
+	list_move(&worker->entry, &wq->idle_list);
+	if (list_empty(&wq->busy_list))
+		pthread_cond_signal(&wq->idle_cond);
+}
+
+/**
+ * dequeue_or_sleep - check if work is available and dequeue or go to sleep
+ *
+ * Called inside worker.
+ */
+static void dequeue_or_sleep(struct worker *worker, struct workqueue_struct *wq)
+__must_hold(&worker->lock)
+{
+	if (available_work(worker)) {
+		worker->current_work = dequeue_work(worker);
+		pr_debug2("worker[%d]: dequeued work\n", worker->tidx);
+	} else {
+		unlock_worker(worker);
+
+		lock_workqueue(wq);
+		lock_worker(worker);
+
+		// Check if I've been assigned new work in the
+		// meantime
+		if (available_work(worker)) {
+			// yep, no need to sleep
+			worker->current_work = dequeue_work(worker);
+		} else {
+			// nope, I gotta sleep
+			worker->current_work = NULL;
+			sleep_worker(wq, worker);
+			pr_debug2("worker[%d]: going to sleep\n", worker->tidx);
+		}
+		unlock_workqueue(wq);
+	}
+}
+
+
+/**
+ * stop_worker - stop worker @worker
+ *
+ * Called from main thread.
+ * Send stop message to worker @worker.
+ */
+static int stop_worker(struct worker *worker)
+{
+	int ret;
+	enum worker_msg msg;
+	char sbuf[STRERR_BUFSIZE];
+
+	msg = WORKER_MSG__STOP;
+	ret = writen(worker->msg_pipe[1], &msg, sizeof(msg));
+	if (ret < 0) {
+		pr_debug2("workqueue: error sending stop msg: %s\n",
+			str_error_r(errno, sbuf, sizeof(sbuf)));
+		return -WORKQUEUE_ERROR__WRITEPIPE;
+	}
+
+	return 0;
+}
+
+/**
+ * init_worker - init @worker struct
+ * @worker: the struct to init
+ * @tidx: index of the executing thread inside the threadpool
+ */
+static int init_worker(struct worker *worker, int tidx)
+{
+	int ret;
+	char sbuf[STRERR_BUFSIZE];
+
+	if (pipe(worker->msg_pipe)) {
+		pr_debug2("worker[%d]: error opening pipe: %s\n",
+			tidx, str_error_r(errno, sbuf, sizeof(sbuf)));
+		return -ENOMEM;
+	}
+
+	worker->tidx = tidx;
+	worker->current_work = NULL;
+	worker->status = WORKER_STATUS__IDLE;
+	INIT_LIST_HEAD(&worker->entry);
+	INIT_LIST_HEAD(&worker->queue);
+
+	ret = pthread_mutex_init(&worker->lock, NULL);
+	if (ret)
+		return -ret;
+
+	return 0;
+}
+
+/**
+ * fini_worker - deallocate resources used by @worker struct
+ */
+static void fini_worker(struct worker *worker)
+{
+	close(worker->msg_pipe[0]);
+	worker->msg_pipe[0] = -1;
+	close(worker->msg_pipe[1]);
+	worker->msg_pipe[1] = -1;
+	pthread_mutex_destroy(&worker->lock);
+}
+
+/**
+ * register_worker - add worker to @wq->idle_list
+ */
+static void register_worker(struct workqueue_struct *wq, struct worker *worker)
+__must_hold(&wq->lock)
+{
+	list_move(&worker->entry, &wq->idle_list);
+	wq->workers[worker->tidx] = worker;
+}
+
+/**
+ * unregister_worker - remove worker from @wq->idle_list
+ */
+static void unregister_worker(struct workqueue_struct *wq __maybe_unused,
+			struct worker *worker)
+__must_hold(&wq->lock)
+{
+	list_del_init(&worker->entry);
+	wq->workers[worker->tidx] = NULL;
+}
+
+/**
+ * worker_thread - worker function executed on threadpool
+ */
+static void worker_thread(int tidx, struct task_struct *task)
+{
+	struct workqueue_struct *wq = container_of(task, struct workqueue_struct, task);
+	char sbuf[STRERR_BUFSIZE];
+	struct worker this_worker;
+	enum worker_msg msg;
+	int ret, init_err = init_worker(&this_worker, tidx);
+
+	if (init_err) {
+		// send error message to main thread
+		msg = WORKER_MSG__ERROR;
+	} else {
+		lock_workqueue(wq);
+		register_worker(wq, &this_worker);
+		unlock_workqueue(wq);
+
+		// ack worker creation
+		msg = WORKER_MSG__READY;
+	}
+
+	ret = writen(wq->msg_pipe[1], &msg, sizeof(msg));
+	if (ret < 0) {
+		pr_debug("worker[%d]: error sending msg: %s\n",
+			tidx, str_error_r(errno, sbuf, sizeof(sbuf)));
+
+		if (init_err)
+			return;
+		goto out;
+	}
+
+	// stop if there have been errors in init
+	if (init_err)
+		return;
+
+	for (;;) {
+		msg = WORKER_MSG__UNDEFINED;
+		ret = readn(this_worker.msg_pipe[0], &msg, sizeof(msg));
+		if (ret < 0 || (msg != WORKER_MSG__WAKE && msg != WORKER_MSG__STOP)) {
+			pr_debug("worker[%d]: error receiving msg: %s\n",
+				tidx, str_error_r(errno, sbuf, sizeof(sbuf)));
+			break;
+		}
+
+		if (msg == WORKER_MSG__STOP)
+			break;
+
+		// main thread takes care of moving to busy list and appending
+		// work to list
+
+		for (;;) {
+			lock_worker(&this_worker);
+			dequeue_or_sleep(&this_worker, wq);
+			unlock_worker(&this_worker);
+
+			if (!this_worker.current_work)
+				break;
+
+			this_worker.current_work->func(this_worker.current_work);
+		};
+	}
+
+out:
+	lock_workqueue(wq);
+	unregister_worker(wq, &this_worker);
+	unlock_workqueue(wq);
+
+	fini_worker(&this_worker);
+}
+
 /**
  * create_workqueue - create a workqueue associated to @pool
  *
@@ -41,7 +361,8 @@ static const char * const workqueue_errno_str[] = {
  */
 struct workqueue_struct *create_workqueue(int nr_threads)
 {
-	int ret, err = 0;
+	int ret, err = 0, t;
+	struct worker *worker;
 	struct workqueue_struct *wq = zalloc(sizeof(struct workqueue_struct));
 
 	if (!wq) {
@@ -56,10 +377,16 @@ struct workqueue_struct *create_workqueue(int nr_threads)
 		goto out_free_wq;
 	}
 
+	wq->workers = calloc(nr_threads, sizeof(*wq->workers));
+	if (!wq->workers) {
+		err = -ENOMEM;
+		goto out_delete_pool;
+	}
+
 	ret = pthread_mutex_init(&wq->lock, NULL);
 	if (ret) {
 		err = -ret;
-		goto out_delete_pool;
+		goto out_free_workers;
 	}
 
 	ret = pthread_cond_init(&wq->idle_cond, NULL);
@@ -77,12 +404,41 @@ struct workqueue_struct *create_workqueue(int nr_threads)
 		goto out_destroy_cond;
 	}
 
+	wq->task.fn = worker_thread;
+
+	wq->pool_errno = threadpool__execute(wq->pool, &wq->task);
+	if (wq->pool_errno) {
+		err = -WORKQUEUE_ERROR__POOLEXE;
+		goto out_close_pipe;
+	}
+
+	for (t = 0; t < nr_threads; t++) {
+		err = spinup_worker(wq, t);
+		if (err)
+			goto out_stop_pool;
+	}
+
 	return wq;
 
+out_stop_pool:
+	lock_workqueue(wq);
+	for_each_idle_worker(wq, worker) {
+		ret = stop_worker(worker);
+		if (ret)
+			err = ret;
+	}
+	unlock_workqueue(wq);
+out_close_pipe:
+	close(wq->msg_pipe[0]);
+	wq->msg_pipe[0] = -1;
+	close(wq->msg_pipe[1]);
+	wq->msg_pipe[1] = -1;
 out_destroy_cond:
 	pthread_cond_destroy(&wq->idle_cond);
 out_destroy_mutex:
 	pthread_mutex_destroy(&wq->lock);
+out_free_workers:
+	free(wq->workers);
 out_delete_pool:
 	threadpool__delete(wq->pool);
 out_free_wq:
@@ -96,12 +452,27 @@ struct workqueue_struct *create_workqueue(int nr_threads)
  */
 int destroy_workqueue(struct workqueue_struct *wq)
 {
+	struct worker *worker;
 	int err = 0, ret;
 	char sbuf[STRERR_BUFSIZE];
 
 	if (IS_ERR_OR_NULL(wq))
 		return 0;
 
+	lock_workqueue(wq);
+	for_each_idle_worker(wq, worker) {
+		ret = stop_worker(worker);
+		if (ret)
+			err = ret;
+	}
+	unlock_workqueue(wq);
+
+	wq->pool_errno = threadpool__stop(wq->pool);
+	if (wq->pool_errno) {
+		pr_debug2("workqueue: error stopping threadpool\n");
+		err = -WORKQUEUE_ERROR__POOLSTOP;
+	}
+
 	threadpool__delete(wq->pool);
 	wq->pool = NULL;
 
@@ -125,6 +496,7 @@ int destroy_workqueue(struct workqueue_struct *wq)
 	close(wq->msg_pipe[1]);
 	wq->msg_pipe[1] = -1;
 
+	zfree(&wq->workers);
 	free(wq);
 	return err;
 }
-- 
2.31.1

