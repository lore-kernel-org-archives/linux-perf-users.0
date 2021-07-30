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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FE6C41537
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 15:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56F01610A6
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 15:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239628AbhG3PhD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jul 2021 11:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbhG3PfL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jul 2021 11:35:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E67C0617A3;
        Fri, 30 Jul 2021 08:34:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n28-20020a05600c3b9cb02902552e60df56so6664289wms.0;
        Fri, 30 Jul 2021 08:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HR7XmzQssixZvIlMrrC3zL3vuGUtLnyM8+gDu6116Qw=;
        b=qjTNp6HFnlP0JDpRw3uCeCz3lFSLMM7zrEt9PZTsYEcP7TEw2/tiNWiUd8ygFRHeNi
         RbSIgFEYzE3EU6/uoPoPtr5omVp6NY6vqQQ7BprfBKstsZXv5fj374qfeP4crxb3lM62
         bJvPGVl2DRQdTcO5Ee5NguwziUb1rUJSOqB1QGaLZvmrT/LDcoSj78OZsJPeoY2EM1wR
         UeKpQAb72JlhX9BRAikBju/Rxd18hv02glvIVqEO4EAYkx371n49zwUM2qqUjYF99ugx
         YmNFmU8aaKrz0lECvXyqbmUZYwL/jrsz/nXZ8Ko3vd3bxiDMFu0bR0ihIiOSBSRUXWTp
         37DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HR7XmzQssixZvIlMrrC3zL3vuGUtLnyM8+gDu6116Qw=;
        b=fMBjy4XbEdtx3KyVKk77eH735N58vAP7iJDQKAHdORFFmwCxD9v5XWQP9fXiJx8HEE
         D2wU3y/tL6LFtkY8Io8KogB8FRA/kArC7ZaXJDTqAnQA4+Aka/7n84kXaeWVO/yyKqPn
         oEhX/+IB4v/vF39BHvac4RJVfVgGWGJ4qi5hi1rm/O877vyWOLYhZ/m4WjR3A6s0Gpty
         zQDT8psd+ptJQccekJEzPP6nDwbgruIRE7d1er235tBe599lmiyyltPsTR18JDZs4Ks8
         HE+1suGMG3zJqiUudcpMrUUtCKBqeYjEC9uBMdUY+W0eMiT8sgpS9J6mLtoO/Zg/+QcH
         j/nQ==
X-Gm-Message-State: AOAM531tPEq0eBXRlCgAXczxKjX6gqqmM6lzpHJO6BVBuObk1uLKQ7pG
        E0VKE3fSNzl5kUwiBuy38H4=
X-Google-Smtp-Source: ABdhPJxcwaQYUHLHWoneiufPplWbjmy18Be2lqddBq5J1qntvyKi+4JDDjfW6kZ1WGT/ubN8TrsHhw==
X-Received: by 2002:a05:600c:4401:: with SMTP id u1mr3815390wmn.49.1627659269694;
        Fri, 30 Jul 2021 08:34:29 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id v15sm2354727wmj.39.2021.07.30.08.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 08:34:29 -0700 (PDT)
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
Subject: [RFC PATCH v2 08/10] perf workqueue: add queue_work and flush_workqueue functions
Date:   Fri, 30 Jul 2021 17:34:15 +0200
Message-Id: <cf11e40889edfb10e296c5d6f575cd73cec99172.1627657061.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627657061.git.rickyman7@gmail.com>
References: <cover.1627657061.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds functions to queue and wait work_structs, and
related tests.

When a new work item is added, the workqueue first checks if there
are threads to wake up. If so, it wakes it up with the given work item,
otherwise it will just add it to the list pending work items. A thread
which completes a work item will check this list before going to sleep.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/tests/workqueue.c          |  70 ++++++++++++++++-
 tools/perf/util/workqueue/workqueue.c | 106 ++++++++++++++++++++++++++
 tools/perf/util/workqueue/workqueue.h |   6 ++
 3 files changed, 181 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/workqueue.c b/tools/perf/tests/workqueue.c
index 2165a563e47bd6a5..2488ee971877b1f0 100644
--- a/tools/perf/tests/workqueue.c
+++ b/tools/perf/tests/workqueue.c
@@ -147,6 +147,27 @@ static int __test__threadpool(void *_args)
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
 
 static int __workqueue__prepare(struct threadpool **pool,
 				struct workqueue_struct **wq,
@@ -175,21 +196,68 @@ static int __workqueue__teardown(struct threadpool *pool,
 	return __threadpool__teardown(pool);
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
 	struct threadpool *pool;
 	struct workqueue_struct *wq;
-	int ret = __workqueue__prepare(&pool, &wq, args->pool_size);
+	int *array;
+	struct test_work *works;
+	int i, ret = __workqueue__prepare(&pool, &wq, args->pool_size);
 
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
 	ret = __workqueue__teardown(pool, wq);
 	if (ret)
 		goto out;
 
 out:
+	free(array);
+	free(works);
 	return ret;
 }
 
diff --git a/tools/perf/util/workqueue/workqueue.c b/tools/perf/util/workqueue/workqueue.c
index 16a55de25cf247d8..a32d62dac1ec04a6 100644
--- a/tools/perf/util/workqueue/workqueue.c
+++ b/tools/perf/util/workqueue/workqueue.c
@@ -23,12 +23,14 @@ enum worker_msg {
 
 enum workqueue_status {
 	WORKQUEUE_STATUS__READY,	/* wq is ready to receive work */
+	WORKQUEUE_STATUS__STOPPING,	/* wq is being destructed */
 	WORKQUEUE_STATUS__ERROR,
 	WORKQUEUE_STATUS__MAX
 };
 
 static const char * const workqueue_status_tags[] = {
 	"ready",
+	"stopping",
 	"error"
 };
 
@@ -120,6 +122,39 @@ __must_hold(&wq->lock)
 		pthread_cond_signal(&wq->idle_cond);
 }
 
+/**
+ * wake_worker - wake worker @w of workqueue @wq assigning @work to do
+ *
+ * Called from main thread.
+ * Moves worker from idle to busy list, assigns @work to it and sends it a
+ * wake up message.
+ *
+ * NB: this function releases the lock to be able to send the notification
+ * outside the critical section.
+ */
+static int wake_worker(struct workqueue_struct *wq, struct worker *w,
+			struct work_struct *work)
+__must_hold(&wq->lock)
+__releases(&wq->lock)
+{
+	enum worker_msg msg = WORKER_MSG__WAKE;
+	int ret;
+
+	list_move(&w->entry, &wq->busy_list);
+	w->current_work = work;
+	unlock_workqueue(wq);
+
+	// send wake msg outside critical section to reduce time spent inside it
+	ret = writen(w->msg_pipe[1], &msg, sizeof(msg));
+	if (ret < 0) {
+		pr_debug2("wake_worker[%d]: error seding msg: %s\n",
+			w->tidx, strerror(errno));
+		return -WORKQUEUE_ERROR__WRITEPIPE;
+	}
+
+	return 0;
+}
+
 /**
  * stop_worker - stop worker @w
  *
@@ -319,6 +354,11 @@ static int detach_threadpool_from_workqueue(struct workqueue_struct *wq)
 		return -WORKQUEUE_ERROR__NOTALLOWED;
 	}
 
+	wq->status = WORKQUEUE_STATUS__STOPPING;
+	ret = flush_workqueue(wq);
+	if (ret)
+		return ret;
+
 	lock_workqueue(wq);
 	for_each_idle_worker(wq, w) {
 		ret = stop_worker(w);
@@ -507,3 +547,69 @@ int workqueue_nr_threads(struct workqueue_struct *wq)
 {
 	return threadpool__size(wq->pool);
 }
+
+/**
+ * queue_work - add @work to @wq internal queue
+ *
+ * If there are idle threads, one of these will be woken up.
+ * Otherwise, the work is added to the pending list.
+ */
+int queue_work(struct workqueue_struct *wq, struct work_struct *work)
+{
+	struct worker *chosen_worker;
+	int ret = 0;
+
+	// in particular, this can fail if workqueue is marked to be stopping
+	if (wq->status != WORKQUEUE_STATUS__READY) {
+		pr_debug2("workqueue: trying to queue but workqueue is not ready\n");
+		return -WORKQUEUE_ERROR__NOTALLOWED;
+	}
+
+	lock_workqueue(wq);
+	if (list_empty(&wq->idle_list)) {
+		list_add_tail(&work->entry, &wq->pending);
+		unlock_workqueue(wq);
+		pr_debug("workqueue: queued new work item\n");
+	} else {
+		chosen_worker = list_first_entry(&wq->idle_list, struct worker, entry);
+		ret = wake_worker(wq, chosen_worker, work);
+		pr_debug("workqueue: woke worker %d\n", chosen_worker->tidx);
+	}
+
+	if (ret) {
+		wq->status = WORKQUEUE_STATUS__ERROR;
+		return ret;
+	}
+	return 0;
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
index 456cd8b6cb2a26d8..ec998291b6a0623d 100644
--- a/tools/perf/util/workqueue/workqueue.h
+++ b/tools/perf/util/workqueue/workqueue.h
@@ -22,6 +22,12 @@ extern int destroy_workqueue(struct workqueue_struct *wq);
 
 extern int workqueue_nr_threads(struct workqueue_struct *wq);
 
+extern int queue_work(struct workqueue_struct *wq, struct work_struct *work);
+
+extern int flush_workqueue(struct workqueue_struct *wq);
+
+extern void init_work(struct work_struct *work);
+
 #define WORKQUEUE_STRERR_BUFSIZE (128+THREADPOOL_STRERR_BUFSIZE)
 #define WORKQUEUE_ERROR__OFFSET 512
 enum {
-- 
2.31.1

