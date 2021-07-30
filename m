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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472F0C19F38
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 15:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 326DD60F5E
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 15:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbhG3PiM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jul 2021 11:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbhG3PfB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jul 2021 11:35:01 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422A3C0617A0;
        Fri, 30 Jul 2021 08:34:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id u15so6250725wmj.1;
        Fri, 30 Jul 2021 08:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PpBWqH+iA/teZIqktGYl/6obuerMLuNNDB13LV2Dyuk=;
        b=O7zp0Tgbtp9AkfWfdI35DD11T5ObwrVAbuU1s/H2ZwweHPVjWAvsg11L4cznB4x1iR
         d7KyJAlLJutdQ5efq2Y9HPW0Ik2ED/k0naLoDcYDL6ZOeL2XkoF+soeRyCMpalixES6S
         d7B0NrAJ7WffDPIUvIH1Ka2aiH3kgGIgCvoxTwYv8ZRtlkaTUpE8YcbhYy6y8vlgWSI2
         duFAGF8P5U/jNxMnB7waJIYJIhFJRxUveITAbrf39I89utOyHTBw8B4B0Hs2MSZZrlkK
         my1xDAHtEVD9AOmQx9S7srlID2DoujO2ja/+FmmZ+W4/f8ny/ESymctGa7DNOIMY1YOG
         1kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PpBWqH+iA/teZIqktGYl/6obuerMLuNNDB13LV2Dyuk=;
        b=RvFTh83xqYKXsezrnURpy2GnSi+IyA3sN68dtSCAkLDfzBfjm5Vcu47Pi+5HZxtiEl
         icFMGmt0eaUHcFRRILfqxBkdFYWDX+fNwCw3EFpvN3+j9oRt6EN+oY51Qn+o6bdhJtg2
         We4BWRO+4pLEy65x+eEd3H7ni+0IEZHqSZboe7tBlZb4ucIG0S4Wnj6aTFqXB+MCdVT4
         Mm97qVQXr5VqVlgfpNHa71m6gqAvmEktUrj6OpRFJ2iqiQsuRvB9oA5U/rotUokXgzt6
         m+tfhRfkAj3/Ak/NtZp/2kZU9DW5P921RRJLj3Nu8aaJvW1DuB3UbbhFYodNciMTlzb9
         32sg==
X-Gm-Message-State: AOAM532BoBAy/ZPmuOIf6hHmaELHNRrVXmPCH37HAskrGnuBqtwIouOi
        wJXDLz/UuQx5N8x7uEBfVVM=
X-Google-Smtp-Source: ABdhPJzyO1aYR8qIe+X9GU3Gjcdm/LrqGXTYq2y/SuKR+ErO/BVumQNmKW0WO3LoytpGCC9HgUqhmw==
X-Received: by 2002:a1c:9851:: with SMTP id a78mr3700523wme.123.1627659268748;
        Fri, 30 Jul 2021 08:34:28 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id v15sm2354727wmj.39.2021.07.30.08.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 08:34:28 -0700 (PDT)
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
Subject: [RFC PATCH v2 07/10] perf workqueue: implement worker thread and management
Date:   Fri, 30 Jul 2021 17:34:14 +0200
Message-Id: <c693ab79b15914ce2da05d223dd37943a16a1e70.1627657061.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627657061.git.rickyman7@gmail.com>
References: <cover.1627657061.git.rickyman7@gmail.com>
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
 tools/perf/util/workqueue/workqueue.c | 243 +++++++++++++++++++++++++-
 1 file changed, 242 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/workqueue/workqueue.c b/tools/perf/util/workqueue/workqueue.c
index d3c6d4c4e75944a5..16a55de25cf247d8 100644
--- a/tools/perf/util/workqueue/workqueue.c
+++ b/tools/perf/util/workqueue/workqueue.c
@@ -12,6 +12,15 @@
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
 enum workqueue_status {
 	WORKQUEUE_STATUS__READY,	/* wq is ready to receive work */
 	WORKQUEUE_STATUS__ERROR,
@@ -46,13 +55,216 @@ static const char * const workqueue_errno_str[] = {
 	"Received unexpected message from worker",
 };
 
+struct worker {
+	int				tidx;		/* idx of thread in pool */
+	struct list_head		entry;		/* in idle or busy list */
+	struct work_struct		*current_work;	/* work being processed */
+	int				msg_pipe[2];	/* main thread comm pipes*/
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
+	ret = writen(w->msg_pipe[1], &msg, sizeof(msg));
+	if (ret < 0) {
+		pr_debug2("workqueue: error sending stop msg: %s\n",
+			strerror(errno));
+		return -WORKQUEUE_ERROR__WRITEPIPE;
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
+		pr_debug2("worker[%d]: error opening pipe: %s\n", tidx, strerror(errno));
+		return -ENOMEM;
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
+	struct workqueue_struct *wq = container_of(task, struct workqueue_struct, task);
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
+			tidx, strerror(errno));
+
+		if (init_err)
+			return;
+		goto out;
+	}
 
-	pr_info("Hi from worker %d, executing task %p\n", tidx, task);
+	// stop if there have been errors in init
+	if (init_err)
+		return;
+
+	for (;;) {
+		msg = WORKER_MSG__UNDEFINED;
+		ret = readn(this_worker.msg_pipe[0], &msg, sizeof(msg));
+		if (ret < 0 || (msg != WORKER_MSG__WAKE && msg != WORKER_MSG__STOP)) {
+			pr_debug("worker[%d]: error receiving msg: %s\n",
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
+				pr_debug2("worker[%d]: dequeued work\n",
+					tidx);
+			} else {
+				this_worker.current_work = NULL;
+				sleep_worker(wq, &this_worker);
+				pr_debug2("worker[%d]: going to sleep\n",
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
@@ -61,6 +273,9 @@ static void worker_thread(int tidx, struct task_struct *task)
 static int attach_threadpool_to_workqueue(struct workqueue_struct *wq,
 					struct threadpool *pool)
 {
+	int ret, t;
+	enum worker_msg msg;
+
 	if (!threadpool__is_ready(pool)) {
 		pr_debug2("workqueue: cannot attach to pool: pool is not ready\n");
 		return -WORKQUEUE_ERROR__NOTALLOWED;
@@ -72,6 +287,22 @@ static int attach_threadpool_to_workqueue(struct workqueue_struct *wq,
 	if (wq->pool_errno)
 		return -WORKQUEUE_ERROR__POOLEXE;
 
+
+	// wait ack from all threads
+	for (t = 0; t < threadpool__size(pool); t++) {
+		msg = WORKER_MSG__UNDEFINED;
+		ret = readn(wq->msg_pipe[0], &msg, sizeof(msg));
+		if (ret < 0) {
+			pr_debug("workqueue: error receiving ack: %s\n",
+				strerror(errno));
+			return -WORKQUEUE_ERROR__READPIPE;
+		}
+		if (msg != WORKER_MSG__READY) {
+			pr_debug2("workqueue: received error\n");
+			return -WORKQUEUE_ERROR__INVALIDMSG;
+		}
+	}
+
 	return 0;
 }
 
@@ -81,12 +312,22 @@ static int attach_threadpool_to_workqueue(struct workqueue_struct *wq,
 static int detach_threadpool_from_workqueue(struct workqueue_struct *wq)
 {
 	int ret, err = 0;
+	struct worker *w;
 
 	if (wq->status != WORKQUEUE_STATUS__READY) {
 		pr_debug2("workqueue: cannot attach to pool: wq is not ready\n");
 		return -WORKQUEUE_ERROR__NOTALLOWED;
 	}
 
+	lock_workqueue(wq);
+	for_each_idle_worker(wq, w) {
+		ret = stop_worker(w);
+		if (ret)
+			err = ret;
+	}
+	unlock_workqueue(wq);
+
+
 	ret = threadpool__wait(wq->pool);
 	if (ret) {
 		pr_debug2("workqueue: error waiting threadpool\n");
-- 
2.31.1

