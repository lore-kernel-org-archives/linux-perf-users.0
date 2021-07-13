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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5555DC11F66
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 12:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37F3761249
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 12:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbhGMMOc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 08:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbhGMMOa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 08:14:30 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CE3C0613E9;
        Tue, 13 Jul 2021 05:11:39 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d12so29542978wre.13;
        Tue, 13 Jul 2021 05:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FShKMfVxY1YHSTsnPA6zvZ0XO7LrxL/ui2UaXrGJeWY=;
        b=nvdtS5vzVKY5CUqwzHnUa2Ut4mG4ntOE2KmN3fN8bYemV4+vqansgk1f7Tl5O7wbHl
         ORbk6efHXN9/Nxd9+X65PLY8spvMN+ZXKZUFivTXQuxRpuxjvX092NRkCCAQ/siW+lCy
         Jwa5rmMazf+ifPYtwS2Zycug/h3QQHqWbgMyFkVv+Ba8iuV0xTAXSPZQ+ZSMm7+ADkIU
         eMAIxjFUJ/dlQOVl6iPiIq12UtpddEvFqXXxPqWglxCyYeVY3OJpTYyPMHMYuCCorMmI
         OxvyUnLa5iVffABuun6n0r+Qrn2XK4ipjapJkxeRCkEy+oslVd0jFbFmdQbCMazDJTMX
         AxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FShKMfVxY1YHSTsnPA6zvZ0XO7LrxL/ui2UaXrGJeWY=;
        b=l22sgrNVN7K0pmYeD3CYu9oMf62urodwqqDBeQr6CFKYm9LSXGvAFwnMqGZfn3EMdV
         Td11hGWAT9f27Ot/g99GKVRa0yAFIWwuKLpJHpocfG6kMMZby9Xxi76O41HmqhXCpIqW
         kse//tKdnXjMqgE91DfyxK1wQLnpuvyNCp/ziNMGyCxB9x4UhHnvIuAca8GOJFFCk59+
         uxmyiSXdIMvMfBJiNe9mixrgMbw2rV14LtY/+xxREzoEN39TrPiiyiTKsDYstYHPBlJm
         SyWRzgKDCPy8CCYLQsoVgZWbwENetJqXIZJI+FtbjnRrOzVdWWk8bQYSASeJJHiCLD5J
         qCLA==
X-Gm-Message-State: AOAM5335a6HcCHoszqWzo+SUVFkMGR5p8e6STr7C/eHIlcQqn6o2Dz24
        4F+3mtIuPGKC1XSpAqzRueA=
X-Google-Smtp-Source: ABdhPJxyhXEk3tnRrnneWdzDt3PtCvr1puPjQgyFvQWR8oXreFNw6VDeVzWhxcxLFHAxVWHimcArsg==
X-Received: by 2002:a5d:4d8c:: with SMTP id b12mr5356727wru.332.1626178298254;
        Tue, 13 Jul 2021 05:11:38 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id o3sm17551425wrw.56.2021.07.13.05.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 05:11:37 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [RFC PATCH 07/10] perf workqueue: implement worker thread and management
Date:   Tue, 13 Jul 2021 14:11:18 +0200
Message-Id: <20fe0b3320d8ea91b478a77a325a7e64d82daad7.1626177381.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626177381.git.rickyman7@gmail.com>
References: <cover.1626177381.git.rickyman7@gmail.com>
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

This registering mechanism has been implemented to enable for dynamic
growth of the workqueue in the future.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/workqueue/workqueue.c | 244 +++++++++++++++++++++++++-
 1 file changed, 242 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/workqueue/workqueue.c b/tools/perf/util/workqueue/workqueue.c
index 5099252a0662e788..5934b14b9ed3c0e1 100644
--- a/tools/perf/util/workqueue/workqueue.c
+++ b/tools/perf/util/workqueue/workqueue.c
@@ -7,8 +7,18 @@
 #include <pthread.h>
 #include <linux/list.h>
 #include "debug.h"
+#include "sparse.h"
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
 enum workqueue_status {
 	WORKQUEUE_STATUS__READY,	/* wq is ready to receive work */
 	WORKQUEUE_STATUS__ERROR,
@@ -27,14 +37,217 @@ struct workqueue_struct {
 	enum workqueue_status	status;
 };
 
+struct worker {
+	int                         tidx;           /* idx of thread in pool */
+	struct list_head	        entry;          /* in idle or busy list */
+	struct work_struct	        *current_work;	/* work being processed */
+	int                         msg_pipe[2];    /* main thread comm pipes*/
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
+/**
+ * available_work - check if @wq has work to do
+ */
+static int available_work(struct workqueue_struct *wq)
+__must_hold(&wq->lock)
+{
+	return !list_empty(&wq->pending);
+}
+
+/**
+ * dequeue_work - retrieve the next work in @wq to be executed by the worker
+ *
+ * Called inside worker.
+ */
+static struct work_struct *dequeue_work(struct workqueue_struct *wq)
+__must_hold(&wq->lock)
+{
+	struct work_struct *work = list_first_entry(&wq->pending, struct work_struct, entry);
+
+	list_del_init(&work->entry);
+	return work;
+}
+
+/**
+ * sleep_worker - worker @w of workqueue @wq goes to sleep
+ *
+ * Called inside worker.
+ * If this was the last idle thread, signal it to the main thread, in case it
+ * was flushing the workqueue.
+ */
+static void sleep_worker(struct workqueue_struct *wq, struct worker *w)
+__must_hold(&wq->lock)
+{
+	list_move(&w->entry, &wq->idle_list);
+	if (list_empty(&wq->busy_list))
+		pthread_cond_signal(&wq->idle_cond);
+}
+
+/**
+ * stop_worker - stop worker @w
+ *
+ * Called from main thread.
+ * Send stop message to worker @w.
+ */
+static int stop_worker(struct worker *w)
+{
+	int ret;
+	enum worker_msg msg;
+
+	msg = WORKER_MSG__STOP;
+	ret = write(w->msg_pipe[1], &msg, sizeof(msg));
+	if (ret < 0) {
+		pr_err("workqueue: error sending stop msg: %s\n",
+			strerror(errno));
+		return -1;
+	}
+
+	return 0;
+}
+
+/**
+ * init_worker - init @w struct
+ * @w: the struct to init
+ * @tidx: index of the executing thread inside the threadpool
+ */
+static int init_worker(struct worker *w, int tidx)
+{
+	if (pipe(w->msg_pipe)) {
+		pr_err("worker[%d]: error opening pipe: %s\n", tidx, strerror(errno));
+		return -1;
+	}
+
+	w->tidx = tidx;
+	w->current_work = NULL;
+	INIT_LIST_HEAD(&w->entry);
+
+	return 0;
+}
+
+/**
+ * fini_worker - deallocate resources used by @w struct
+ */
+static void fini_worker(struct worker *w)
+{
+	close(w->msg_pipe[0]);
+	w->msg_pipe[0] = -1;
+	close(w->msg_pipe[1]);
+	w->msg_pipe[1] = -1;
+}
+
+/**
+ * register_worker - add worker to @wq->idle_list
+ */
+static void register_worker(struct workqueue_struct *wq, struct worker *w)
+__must_hold(&wq->lock)
+{
+	list_move(&w->entry, &wq->idle_list);
+}
+
+/**
+ * unregister_worker - remove worker from @wq->idle_list
+ */
+static void unregister_worker(struct workqueue_struct *wq __maybe_unused,
+			struct worker *w)
+__must_hold(&wq->lock)
+{
+	list_del_init(&w->entry);
+}
+
 /**
  * worker_thread - worker function executed on threadpool
  */
 static void worker_thread(int tidx, struct task_struct *task)
 {
 	struct workqueue_struct *wq = container_of(task, struct workqueue_struct, task);
+	struct worker this_worker;
+	enum worker_msg msg;
+	int ret, init_err;
+
+	init_err = init_worker(&this_worker, tidx);
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
+	ret = write(wq->msg_pipe[1], &msg, sizeof(msg));
+	if (ret < 0) {
+		pr_err("worker[%d]: error sending msg: %s\n",
+			tidx, strerror(errno));
+
+		if (init_err)
+			return;
+		goto out;
+	}
 
-	pr_debug("hi from worker %d. Pool is in status %d\n", tidx, wq->status);
+	// stop if there have been errors in init
+	if (init_err)
+		return;
+
+	for (;;) {
+		msg = WORKER_MSG__UNDEFINED;
+		ret = read(this_worker.msg_pipe[0], &msg, sizeof(msg));
+		if (ret < 0 || (msg != WORKER_MSG__WAKE && msg != WORKER_MSG__STOP)) {
+			pr_err("worker[%d]: error receiving msg: %s\n",
+				tidx, strerror(errno));
+			break;
+		}
+
+		if (msg == WORKER_MSG__STOP)
+			break;
+
+		// main thread takes care of moving to busy list and assigning current_work
+
+		while (this_worker.current_work) {
+			this_worker.current_work->func(this_worker.current_work);
+
+			lock_workqueue(wq);
+			if (available_work(wq)) {
+				this_worker.current_work = dequeue_work(wq);
+				pr_debug("worker[%d]: dequeued work\n",
+					tidx);
+			} else {
+				this_worker.current_work = NULL;
+				sleep_worker(wq, &this_worker);
+				pr_debug("worker[%d]: going to sleep\n",
+					tidx);
+			}
+			unlock_workqueue(wq);
+		}
+	}
+
+out:
+	lock_workqueue(wq);
+	unregister_worker(wq, &this_worker);
+	unlock_workqueue(wq);
+
+	fini_worker(&this_worker);
 }
 
 /**
@@ -43,7 +256,8 @@ static void worker_thread(int tidx, struct task_struct *task)
 static int attach_threadpool_to_workqueue(struct workqueue_struct *wq,
 					struct threadpool_struct *pool)
 {
-	int err;
+	int err, ret, t;
+	enum worker_msg msg;
 
 	if (!threadpool_is_ready(pool)) {
 		pr_err("workqueue: cannot attach to pool: pool is not ready\n");
@@ -56,6 +270,22 @@ static int attach_threadpool_to_workqueue(struct workqueue_struct *wq,
 	if (err)
 		return -1;
 
+
+	// wait ack from all threads
+	for (t = 0; t < threadpool_size(pool); t++) {
+		msg = WORKER_MSG__UNDEFINED;
+		ret = read(wq->msg_pipe[0], &msg, sizeof(msg));
+		if (ret < 0) {
+			pr_err("workqueue: error receiving ack: %s\n",
+				strerror(errno));
+			return -1;
+		}
+		if (msg != WORKER_MSG__READY) {
+			pr_err("workqueue: received error\n");
+			return -1;
+		}
+	}
+
 	return 0;
 }
 
@@ -65,12 +295,22 @@ static int attach_threadpool_to_workqueue(struct workqueue_struct *wq,
 static int detach_threadpool_from_workqueue(struct workqueue_struct *wq)
 {
 	int ret, err = 0;
+	struct worker *w;
 
 	if (wq->status != WORKQUEUE_STATUS__READY) {
 		pr_err("workqueue: cannot attach to pool: wq is not ready\n");
 		return -1;
 	}
 
+	lock_workqueue(wq);
+	for_each_idle_worker(wq, w) {
+		ret = stop_worker(w);
+		if (ret)
+			err = -1;
+	}
+	unlock_workqueue(wq);
+
+
 	ret = wait_threadpool(wq->pool);
 	if (ret) {
 		pr_err("workqueue: error waiting threadpool\n");
-- 
2.31.1

