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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221CAC07E96
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 12:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E8E561279
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 12:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbhGMMOe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 08:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbhGMMOb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 08:14:31 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A372DC061787;
        Tue, 13 Jul 2021 05:11:40 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id f8-20020a1c1f080000b029022d4c6cfc37so151767wmf.5;
        Tue, 13 Jul 2021 05:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8xHovbrSBCiF5NnM0vyd4R8dUYmzGTc20LQ13x2GBek=;
        b=Jrua1J6OHHDicLFzEplcW+pOvp8QPv7NAFkOsWajBLQakFr3mNNyYXBWy/sj7NuUYy
         +PY7lm25HqLX0tzSiP3QyBPmSKOndQux4H5nAgKsK8eIUhCbNMEDtj7NyWWLvWsoGFod
         Gzy2xNv6yP1/M+xERZH9c3SNaBy1eC8hTEBCzyTWToHR/3geb7JesGP07b798q9aogX3
         Aaf0XlobhQnyWMRp6XEydBjHKeCYy0l+u7LVAcZJyRpt6lryn5IEX/HdBLcs4AR1+vc0
         TX1TfAhLy9yKJO7YdgIwehHe7mPgIpF1FiUv/VHCKM1fldY8vgGLXxhGOJlSeJ6TvDv/
         QKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8xHovbrSBCiF5NnM0vyd4R8dUYmzGTc20LQ13x2GBek=;
        b=Mc5P1w02C0Dv5l1MH9eNDyW0NA0A5XqRLn2tA5R3XCEyP6oIyNBpxrsjuTOoQIk4ty
         37AXYJfjyDixu3QhZxJVA/UZiL/YoaJT9xoV763qSbx34nQ25sofmb/WAKMrxZl4PRP1
         /sGD56Rm/EDpqgvQz5e/jnMfIywNyvB+6XpSU5Q8O2UfbWcjuyGfUTs0OEAI5MJQSnbJ
         7blTfOl7g1e67BeWm4kA4OEN7GGTjUfeX6cJac2AKSSUyHNIqYtpnDOibZ1Hn8DaCT2r
         HDzovHdhJFrL2g35p0hXCsHgWYAwh8wOJ7JS52Bvi8Y4kw5m+km0nP4Y9jpH2/xs3U97
         sM9g==
X-Gm-Message-State: AOAM531b1EoEfBiyeqNADDj29XiQPyKI4L1G+OjFkN0qKhj2DhBdD1Vp
        WiJZNj7BFC4r3g1alDsCExY=
X-Google-Smtp-Source: ABdhPJwgrkdgA5p5XbE/66ZZ1GbT29yyps7H4v6N9q5HtVMWfCqHrCkhYeKtlxMjOXxQpK30s+Dc/Q==
X-Received: by 2002:a05:600c:4fc7:: with SMTP id o7mr4702072wmq.16.1626178299146;
        Tue, 13 Jul 2021 05:11:39 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id o3sm17551425wrw.56.2021.07.13.05.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 05:11:38 -0700 (PDT)
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
Subject: [RFC PATCH 08/10] perf workqueue: add queue_work and flush_workqueue functions
Date:   Tue, 13 Jul 2021 14:11:19 +0200
Message-Id: <996325f824d095d2429f7677a87da602939f389c.1626177381.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626177381.git.rickyman7@gmail.com>
References: <cover.1626177381.git.rickyman7@gmail.com>
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
 tools/perf/tests/workqueue.c          | 69 +++++++++++++++++++-
 tools/perf/util/workqueue/workqueue.c | 93 +++++++++++++++++++++++++++
 tools/perf/util/workqueue/workqueue.h |  7 ++
 3 files changed, 168 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/workqueue.c b/tools/perf/tests/workqueue.c
index 423dc8a92ca2563c..f71a839d5752d224 100644
--- a/tools/perf/tests/workqueue.c
+++ b/tools/perf/tests/workqueue.c
@@ -146,6 +146,27 @@ static int __test__threadpool(void *_args)
 	return 0;
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
 
 static int __workqueue__prepare(struct threadpool_struct **pool,
 				struct workqueue_struct **wq,
@@ -180,21 +201,67 @@ static int __workqueue__teardown(struct threadpool_struct *pool,
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
+	return 0;
+}
+
+
 static int __test__workqueue(void *_args)
 {
 	struct workqueue_test_args_t *args = _args;
 	struct threadpool_struct *pool;
 	struct workqueue_struct *wq;
-	int ret;
+	int ret, i;
+	int *array;
+	struct test_work *works;
+
+	array = calloc(args->n_work_items, sizeof(*array));
+	works = calloc(args->n_work_items, sizeof(*works));
 
 	ret = __workqueue__prepare(&pool, &wq, args->pool_size);
 	if (ret)
 		return ret;
 
+	ret = __workqueue__exec_wait(wq, array, works, test_work_fn1,
+					args->n_work_items);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < args->n_work_items; i++)
+		TEST_ASSERT_VAL("failed array check (1)", array[i] == i+1);
+
+	ret = __workqueue__exec_wait(wq, array, works, test_work_fn2,
+					args->n_work_items);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < args->n_work_items; i++)
+		TEST_ASSERT_VAL("failed array check (2)", array[i] == 2*i);
+
 	ret = __workqueue__teardown(pool, wq);
 	if (ret)
 		return ret;
 
+	free(array);
+	free(works);
+
 	return 0;
 }
 
diff --git a/tools/perf/util/workqueue/workqueue.c b/tools/perf/util/workqueue/workqueue.c
index 5934b14b9ed3c0e1..20d196de9500d369 100644
--- a/tools/perf/util/workqueue/workqueue.c
+++ b/tools/perf/util/workqueue/workqueue.c
@@ -21,6 +21,7 @@ enum worker_msg {
 
 enum workqueue_status {
 	WORKQUEUE_STATUS__READY,	/* wq is ready to receive work */
+	WORKQUEUE_STATUS__STOPPING,	/* wq is being destructed */
 	WORKQUEUE_STATUS__ERROR,
 	WORKQUEUE_STATUS__MAX
 };
@@ -102,6 +103,39 @@ __must_hold(&wq->lock)
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
+	int err;
+
+	list_move(&w->entry, &wq->busy_list);
+	w->current_work = work;
+	unlock_workqueue(wq);
+
+	// send wake msg outside critical section to reduce time spent inside it
+	err = write(w->msg_pipe[1], &msg, sizeof(msg));
+	if (err < 0) {
+		pr_err("wake_worker[%d]: error seding msg: %s\n",
+			w->tidx, strerror(errno));
+		return -1;
+	}
+
+	return 0;
+}
+
 /**
  * stop_worker - stop worker @w
  *
@@ -302,6 +336,11 @@ static int detach_threadpool_from_workqueue(struct workqueue_struct *wq)
 		return -1;
 	}
 
+	wq->status = WORKQUEUE_STATUS__STOPPING;
+	ret = flush_workqueue(wq);
+	if (ret)
+		return -1;
+
 	lock_workqueue(wq);
 	for_each_idle_worker(wq, w) {
 		ret = stop_worker(w);
@@ -422,3 +461,57 @@ int workqueue_nr_threads(struct workqueue_struct *wq)
 {
 	return threadpool_size(wq->pool);
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
+	int ret = 0;
+	struct worker *chosen_worker;
+
+	// in particular, this can fail if workqueue is marked to be stopping
+	if (wq->status != WORKQUEUE_STATUS__READY) {
+		pr_err("workqueue: trying to queue but workqueue is not ready\n");
+		return -1;
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
+	return ret;
+}
+
+/**
+ * flush_workqueue - wait for all currently executed and pending work to finish
+ *
+ * This function blocks until all threads become idle.
+ */
+int flush_workqueue(struct workqueue_struct *wq)
+{
+	lock_workqueue(wq);
+	while (!list_empty(&wq->busy_list))
+		pthread_cond_wait(&wq->idle_cond, &wq->lock);
+	unlock_workqueue(wq);
+
+	return 0;
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
index 86ec1d69274f41db..719bd0e5fb0ce7b7 100644
--- a/tools/perf/util/workqueue/workqueue.h
+++ b/tools/perf/util/workqueue/workqueue.h
@@ -21,4 +21,11 @@ extern struct workqueue_struct *create_workqueue(struct threadpool_struct *pool)
 extern int destroy_workqueue(struct workqueue_struct *wq);
 
 extern int workqueue_nr_threads(struct workqueue_struct *wq);
+
+extern int queue_work(struct workqueue_struct *wq, struct work_struct *work);
+
+extern int flush_workqueue(struct workqueue_struct *wq);
+
+extern void init_work(struct work_struct *work);
+
 #endif /* __WORKQUEUE_WORKQUEUE_H */
-- 
2.31.1

