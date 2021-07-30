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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8965CC43216
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 15:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D8E860F4A
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 15:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239606AbhG3PhB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jul 2021 11:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbhG3Pet (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jul 2021 11:34:49 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ADEC06179B;
        Fri, 30 Jul 2021 08:34:27 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c16so11786039wrp.13;
        Fri, 30 Jul 2021 08:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=et2Vmn/m/kig5JVT51IzZ+wV7f8kKEkQi2Z+9+BNt/M=;
        b=lWQFYKxDTNaslQDyWGhmk59zq+qfr9jhoqxYXLJKj1mzCRWoGiz8so8yW5d6Al+vC5
         aK5RoVTxOMypbcn6rx4qeQIWCeDnn2Xu5NoWDOYA7kMFBwN/xMgvnIaJfkt24yV3IcG1
         1AbKLBHo6wGJ4UjWKKdxNzYtyPSRftcEaqyKHXhIqV/7+g8rWsyRgoGPMg612IRzfI5z
         VFy6YGjGztVhNoxGLVjwCjqQD567KUBnPYrhj9YAWEWNA3RuD8izC04CIYGLBQEE9CGA
         BIADFMhL1lqxnksawQNVMCyERhf0010d1kSkX4qiwz5DdJRgy+G8ZJBh+aFAYj+Xzra7
         g+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=et2Vmn/m/kig5JVT51IzZ+wV7f8kKEkQi2Z+9+BNt/M=;
        b=PnfBBKDxtCqlM0mCxBkbcsuVlS9h9a5lPUQpfvXvYpnyFStAOPjf70Z41dkItTrndR
         Ay79XUTstV5h1BoihGn+yEmsTfJ9k3xjKztv6Y7U17UHlxVo2PGYuABUX80/bYw5DyJo
         Fqx2dvFNPrMxMxMQs+1nc7IZOGtJTo+T1nXKyJhpq/A0FBhfx5mwN2hcxDcqbX0tu+S1
         dtpDss//d4WW5iRCj4J533kJJc3doTaEPYNSMnyLgIBncg2XDczPGOEIynlHQPAcqEI/
         afP8F72fc/YbhNzsTBFdbULnAa/rMTT+OMm+WvcIBEx/E/tiSYDzQpIGBUyJ3q5qOPUH
         ILfg==
X-Gm-Message-State: AOAM533svDNZ6fJgU1TZenb+g9nFtfubzRRc725GQYmwOcTHWXE3Zw0N
        blpPc0uZaukybGBKPWTX3yE=
X-Google-Smtp-Source: ABdhPJyex6WTAeXV051kVf80qrz59SrZYYDS9OjM/uX/MhohzDKOJv4wwO3GS9l1cbhKVebwEnBYrQ==
X-Received: by 2002:a5d:6905:: with SMTP id t5mr3595615wru.78.1627659266032;
        Fri, 30 Jul 2021 08:34:26 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id v15sm2354727wmj.39.2021.07.30.08.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 08:34:25 -0700 (PDT)
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
Subject: [RFC PATCH v2 04/10] perf workqueue: add threadpool execute and wait functions
Date:   Fri, 30 Jul 2021 17:34:11 +0200
Message-Id: <2b55c73f1c1738361d80349f1c67e5fe9cce7174.1627657061.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627657061.git.rickyman7@gmail.com>
References: <cover.1627657061.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds:
 - threadpool__execute: assigns a task to the threads to execute
   asynchronously.
 - threadpool__wait: waits for the task to complete on all threads.
Furthermore, testing for these new functions is added.

This patch completes the threadpool.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/tests/workqueue.c           |  85 +++++++++++++-
 tools/perf/util/workqueue/threadpool.c | 146 ++++++++++++++++++++++++-
 tools/perf/util/workqueue/threadpool.h |   1 +
 3 files changed, 230 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/workqueue.c b/tools/perf/tests/workqueue.c
index 767e4fb60be4b190..87bf8fc71c346653 100644
--- a/tools/perf/tests/workqueue.c
+++ b/tools/perf/tests/workqueue.c
@@ -1,14 +1,60 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stdlib.h>
 #include <linux/kernel.h>
 #include <linux/err.h>
+#include <linux/zalloc.h>
 #include "tests.h"
 #include "util/debug.h"
 #include "util/workqueue/threadpool.h"
 
+#define DUMMY_FACTOR 100000
+#define N_DUMMY_WORK_SIZES 7
+
 struct threadpool_test_args_t {
 	int pool_size;
 };
 
+struct test_task {
+	struct task_struct task;
+	int n_threads;
+	int *array;
+};
+
+/**
+ * dummy_work - calculates DUMMY_FACTOR * (idx % N_DUMMY_WORK_SIZES) inefficiently
+ *
+ * This function uses modulus to create work items of different sizes.
+ */
+static void dummy_work(int idx)
+{
+	volatile int prod = 0;	/* prevent possible compiler optimizations */
+	int k = idx % N_DUMMY_WORK_SIZES;
+	int i, j;
+
+	for (i = 0; i < DUMMY_FACTOR; i++)
+		for (j = 0; j < k; j++)
+			prod++;
+
+	pr_debug3("dummy: %d * %d = %d\n", DUMMY_FACTOR, k, prod);
+}
+
+static void test_task_fn1(int tidx, struct task_struct *task)
+{
+	struct test_task *mtask = container_of(task, struct test_task, task);
+
+	dummy_work(tidx);
+	mtask->array[tidx] = tidx+1;
+}
+
+static void test_task_fn2(int tidx, struct task_struct *task)
+{
+	struct test_task *mtask = container_of(task, struct test_task, task);
+
+	dummy_work(tidx);
+	mtask->array[tidx] = tidx*2;
+}
+
+
 static int __threadpool__prepare(struct threadpool **pool, int pool_size)
 {
 	int ret;
@@ -39,22 +85,59 @@ static int __threadpool__teardown(struct threadpool *pool)
 	return TEST_OK;
 }
 
+static int __threadpool__exec_wait(struct threadpool *pool,
+				struct task_struct *task)
+{
+	int ret = threadpool__execute(pool, task);
+
+	TEST_ASSERT_VAL("threadpool execute failure", ret == 0);
+	TEST_ASSERT_VAL("threadpool is not executing", threadpool__is_busy(pool));
+
+	ret = threadpool__wait(pool);
+	TEST_ASSERT_VAL("threadpool wait failure", ret == 0);
+	TEST_ASSERT_VAL("waited threadpool is not ready", threadpool__is_ready(pool));
+
+	return TEST_OK;
+}
 
 static int __test__threadpool(void *_args)
 {
 	struct threadpool_test_args_t *args = _args;
 	struct threadpool *pool;
-	int ret;
+	int ret, i;
+	struct test_task task;
+
+	task.task.fn = test_task_fn1;
+	task.n_threads = args->pool_size;
+	task.array = calloc(args->pool_size, sizeof(*task.array));
+	TEST_ASSERT_VAL("calloc failure", task.array);
 
 	ret = __threadpool__prepare(&pool, args->pool_size);
 	if (ret)
 		goto out;
 
+	ret = __threadpool__exec_wait(pool, &task.task);
+	if (ret)
+		goto out;
+
+	for (i = 0; i < args->pool_size; i++)
+		TEST_ASSERT_VAL("failed array check (1)", task.array[i] == i+1);
+
+	task.task.fn = test_task_fn2;
+
+	ret = __threadpool__exec_wait(pool, &task.task);
+	if (ret)
+		goto out;
+
+	for (i = 0; i < args->pool_size; i++)
+		TEST_ASSERT_VAL("failed array check (2)", task.array[i] == 2*i);
+
 	ret = __threadpool__teardown(pool);
 	if (ret)
 		goto out;
 
 out:
+	free(task.array);
 	return ret;
 }
 
diff --git a/tools/perf/util/workqueue/threadpool.c b/tools/perf/util/workqueue/threadpool.c
index 850ef7e110566536..33320dd0fb44fe38 100644
--- a/tools/perf/util/workqueue/threadpool.c
+++ b/tools/perf/util/workqueue/threadpool.c
@@ -26,6 +26,7 @@ static inline pid_t gettid(void)
 enum threadpool_status {
 	THREADPOOL_STATUS__STOPPED,		/* no threads */
 	THREADPOOL_STATUS__READY,		/* threads are ready but idle */
+	THREADPOOL_STATUS__BUSY,		/* threads are busy */
 	THREADPOOL_STATUS__ERROR,		/* errors */
 	THREADPOOL_STATUS__MAX
 };
@@ -33,6 +34,7 @@ enum threadpool_status {
 static const char * const threadpool_status_tags[] = {
 	"stopped",
 	"ready",
+	"busy",
 	"error"
 };
 
@@ -181,6 +183,28 @@ static int threadpool__terminate_thread(struct threadpool_entry *thread)
 	return threadpool__wait_thread(thread);
 }
 
+/**
+ * threadpool__wake_thread - send wake msg to @thread
+ *
+ * This function does not wait for the thread to actually wake
+ * NB: call only from main thread!
+ */
+static int threadpool__wake_thread(struct threadpool_entry *thread)
+{
+	int res;
+	enum threadpool_msg msg = THREADPOOL_MSG__WAKE;
+
+	res = writen(thread->pipes.cmd[1], &msg, sizeof(msg));
+	if (res < 0) {
+		pr_debug2("threadpool: error sending wake msg: %s\n", strerror(errno));
+		return -THREADPOOL_ERROR__WRITEPIPE;
+	}
+
+	pr_debug2("threadpool: sent wake msg %s to tid=%d\n",
+		threadpool_msg_tags[msg], thread->tid);
+	return 0;
+}
+
 /**
  * threadpool_entry__function - send ack to main thread
  */
@@ -249,6 +273,15 @@ static void *threadpool_entry__function(void *args)
 
 		if (cmd == THREADPOOL_MSG__STOP)
 			break;
+
+		if (!thread->pool->current_task) {
+			pr_debug("threadpool[%d]: received wake without task\n",
+				thread->tid);
+			break;
+		}
+
+		pr_debug("threadpool[%d]: executing task\n", thread->tid);
+		thread->pool->current_task->fn(thread->idx, thread->pool->current_task);
 	}
 
 	pr_debug2("threadpool[%d]: exit\n", thread->tid);
@@ -502,10 +535,14 @@ static int __threadpool__stop(struct threadpool *pool)
  * threadpool__stop - stop all threads in the pool.
  *
  * This function blocks waiting for ack from all threads.
+ * If the pool was busy, it will first wait for the task to finish.
  */
 int threadpool__stop(struct threadpool *pool)
 {
-	int ret;
+	int ret = threadpool__wait(pool);
+
+	if (ret)
+		return ret;
 
 	if (pool->status != THREADPOOL_STATUS__READY) {
 		pr_debug2("threadpool: stopping not ready pool\n");
@@ -528,3 +565,110 @@ bool threadpool__is_ready(struct threadpool *pool)
 {
 	return pool->status == THREADPOOL_STATUS__READY;
 }
+
+/**
+ * __threadpool__execute - execute @task on all threads of the @pool
+ *
+ * NB: use threadpool__execute. This function does not change @pool->status.
+ */
+static int __threadpool__execute(struct threadpool *pool, struct task_struct *task)
+{
+	int t, ret;
+
+	pool->current_task = task;
+
+	for (t = 0; t < pool->nr_threads; t++) {
+		ret = threadpool__wake_thread(&pool->threads[t]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * threadpool__execute - execute @task on all threads of the @pool
+ *
+ * The task will run asynchronously wrt the main thread.
+ * The task can be waited with threadpool__wait.
+ *
+ * NB: make sure the pool is ready before calling this, since no queueing is
+ *     performed. If you need queueing, have a look at the workqueue.
+ */
+int threadpool__execute(struct threadpool *pool, struct task_struct *task)
+{
+	int ret;
+
+	if (pool->status != THREADPOOL_STATUS__READY) {
+		pr_debug2("threadpool: executing on not ready pool\n");
+		return -THREADPOOL_ERROR__NOTALLOWED;
+	}
+
+	ret = __threadpool__execute(pool, task);
+	if (ret) {
+		pool->status = THREADPOOL_STATUS__ERROR;
+		return ret;
+	}
+	pool->status = THREADPOOL_STATUS__BUSY;
+	return 0;
+}
+
+/**
+ * __threadpool__wait - wait until all threads in @pool are done
+ *
+ * NB: use threadpool__wait. This function does not change @pool->status.
+ */
+static int __threadpool__wait(struct threadpool *pool)
+{
+	int t, err = 0, ret;
+
+	for (t = 0; t < pool->nr_threads; t++) {
+		ret = threadpool__wait_thread(&pool->threads[t]);
+		if (ret)
+			err = ret;
+	}
+
+	pool->current_task = NULL;
+	return err;
+}
+
+/**
+ * threadpool__wait - wait until all threads in @pool are done
+ *
+ * This function will wait for all threads to finish execution and send their
+ * ack message.
+ *
+ * NB: call only from main thread!
+ */
+int threadpool__wait(struct threadpool *pool)
+{
+	int ret;
+
+	switch (pool->status) {
+	case THREADPOOL_STATUS__BUSY:
+		break;
+	case THREADPOOL_STATUS__READY:
+		return 0;
+	default:
+	case THREADPOOL_STATUS__STOPPED:
+	case THREADPOOL_STATUS__ERROR:
+	case THREADPOOL_STATUS__MAX:
+		return -THREADPOOL_ERROR__NOTALLOWED;
+	}
+
+	ret = __threadpool__wait(pool);
+	if (ret) {
+		pool->status = THREADPOOL_STATUS__ERROR;
+		return ret;
+	}
+	pool->status = THREADPOOL_STATUS__READY;
+	return 0;
+}
+
+/**
+ * threadpool__is_busy - check if the pool is busy
+ */
+int threadpool__is_busy(struct threadpool *pool)
+{
+	return pool->status == THREADPOOL_STATUS__BUSY;
+}
diff --git a/tools/perf/util/workqueue/threadpool.h b/tools/perf/util/workqueue/threadpool.h
index 7d56e5450fac605b..f28b3856d30e91e5 100644
--- a/tools/perf/util/workqueue/threadpool.h
+++ b/tools/perf/util/workqueue/threadpool.h
@@ -22,6 +22,7 @@ extern int threadpool__wait(struct threadpool *pool);
 
 extern int threadpool__size(struct threadpool *pool);
 extern bool threadpool__is_ready(struct threadpool *pool);
+extern int threadpool__is_busy(struct threadpool *pool);
 
 /* Error management */
 #define THREADPOOL_STRERR_BUFSIZE (128+STRERR_BUFSIZE)
-- 
2.31.1

