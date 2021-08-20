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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74180C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EDC560FE7
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239322AbhHTKzH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239259AbhHTKyx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Aug 2021 06:54:53 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF68C06175F;
        Fri, 20 Aug 2021 03:54:15 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id q3so13406757edt.5;
        Fri, 20 Aug 2021 03:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SwbzEInT0NYckj1933prTLPUBDs9JwAKeIScX+4Vk78=;
        b=BE1UyTza6RzTgpID4q8IInHFH6zDVr4+f8RT2NNabS7jLlDKP+f+GojhNwsZxO9tOw
         +1ihx5+xAParwwraCKHPruGcPNFHx7QH/j71caRbK/Qzzwd4ffgn1dB8nV/pJ4IE4aan
         BcFRd2lC8tyMwTtm6YjAqE07ucGqKmbjnEcCjFIduv7PyAPZQh33JlgfEZgG9xYEti1F
         oJyVMM4FQXUMJS2jHH9x3rmJMmMMGNf33pK7IblFpUEQumMgYXWU3XHPjb5U/zlf5WdZ
         h+R9lTb62ia+4YdyLYL4Q+/bCCz7f1zgaAz7DclNXpxMWti33TcmKQLAcERH7mI0tQiC
         kLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SwbzEInT0NYckj1933prTLPUBDs9JwAKeIScX+4Vk78=;
        b=lyRTijYFJsYUgDqdbt9gNA6L+YJ5IGplcUyLPhiudt81W4sGDbYfGT2J1G1ZIlC63v
         66dTIS+GwnwxNtWVoy6AXh2/gfFdDT+J48/YNQ8gQ09uTpLv8dWQhc/n9jn4YvWvKyEb
         7UettRBrEC9Nm+3g1DlICCS7YfCnYe05pkpGizrs8dBfExbD9s2Y4Eg1TTdrzrvthsF7
         Kq7DaK1lEX8FanPFwsx0NC1kTY+gwtsfUIYhZaWXKUBcJUhYAIDQUtUMm+j3ANPCzBD8
         OwJK+C6X00kAaPwKnx6EB9j2Sf4ehJO1Xo5r/SuZD+ZgHbqxUw+jXS/f+GAuEZeBb0oZ
         Yiyw==
X-Gm-Message-State: AOAM530cNcvbHzPyek9dap5kXr56z0yK7H2KfO9wHxkE8OA+OoNjXJR6
        qJgotCcCyfeheMVickuGLa0=
X-Google-Smtp-Source: ABdhPJx7xDYO7tmZc41mHIA3K0X9D+6GT8sopnrq6Av8nYzDUPVBrWSz9V0stQ7VTkRQ6yeTrcOktg==
X-Received: by 2002:a50:d795:: with SMTP id w21mr21909418edi.112.1629456854447;
        Fri, 20 Aug 2021 03:54:14 -0700 (PDT)
Received: from honeypot.epfl.ch (mob-176-243-199-7.net.vodafone.it. [176.243.199.7])
        by smtp.googlemail.com with ESMTPSA id g29sm3451459edf.31.2021.08.20.03.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 03:54:13 -0700 (PDT)
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
Subject: [RFC PATCH v3 04/15] perf workqueue: add threadpool execute and wait functions
Date:   Fri, 20 Aug 2021 12:53:50 +0200
Message-Id: <bb5784f3d0015208552cb27e90ca4859848a49c6.1629454773.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629454773.git.rickyman7@gmail.com>
References: <cover.1629454773.git.rickyman7@gmail.com>
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

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/tests/workqueue.c           | 86 ++++++++++++++++++++++-
 tools/perf/util/workqueue/threadpool.c | 94 ++++++++++++++++++++++++++
 tools/perf/util/workqueue/threadpool.h |  4 ++
 3 files changed, 183 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/workqueue.c b/tools/perf/tests/workqueue.c
index 01f05b066d9fbc70..b145a5155089497f 100644
--- a/tools/perf/tests/workqueue.c
+++ b/tools/perf/tests/workqueue.c
@@ -1,15 +1,61 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <unistd.h>
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
@@ -39,21 +85,59 @@ static int __threadpool__teardown(struct threadpool *pool)
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
+	TEST_ASSERT_VAL("waited threadpool is not running", threadpool__is_running(pool));
+
+	return TEST_OK;
+}
+
 static int __test__threadpool(void *_args)
 {
 	struct threadpool_test_args_t *args = _args;
 	struct threadpool *pool;
+	struct test_task task;
 	int pool_size = args->pool_size ?: sysconf(_SC_NPROCESSORS_ONLN);
-	int ret = __threadpool__prepare(&pool, pool_size);
+	int i, ret = __threadpool__prepare(&pool, pool_size);
 
 	if (ret)
 		goto out;
 
+	task.task.fn = test_task_fn1;
+	task.n_threads = pool_size;
+	task.array = calloc(pool_size, sizeof(*task.array));
+	TEST_ASSERT_VAL("calloc failure", task.array);
+
+	ret = __threadpool__exec_wait(pool, &task.task);
+	if (ret)
+		goto out;
+
+	for (i = 0; i < pool_size; i++)
+		TEST_ASSERT_VAL("failed array check (1)", task.array[i] == i+1);
+
+	task.task.fn = test_task_fn2;
+
+	ret = __threadpool__exec_wait(pool, &task.task);
+	if (ret)
+		goto out;
+
+	for (i = 0; i < pool_size; i++)
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
index 861a20231558e618..44bcbe4fa3d2d026 100644
--- a/tools/perf/util/workqueue/threadpool.c
+++ b/tools/perf/util/workqueue/threadpool.c
@@ -200,6 +200,17 @@ static int threadpool__terminate_thread(struct threadpool *pool, int tidx)
 	goto out;
 }
 
+/**
+ * threadpool__wake_thread - send wake msg to @thread
+ *
+ * This function does not wait for the thread to actually wake
+ * NB: call only from main thread!
+ */
+static int threadpool__wake_thread(struct threadpool *pool, int tidx)
+{
+	return threadpool__send_cmd(pool, tidx, THREADPOOL_MSG__WAKE);
+}
+
 /**
  * threadpool_entry__send_ack - send ack to main thread
  */
@@ -270,6 +281,15 @@ static void *threadpool_entry__function(void *args)
 
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
@@ -448,6 +468,12 @@ int threadpool__start_thread(struct threadpool *pool, int tidx)
 
 	thread->running = true;
 
+	if (pool->current_task) {
+		err = threadpool__wake_thread(pool, tidx);
+		if (err)
+			goto out_cancel;
+	}
+
 out:
 	pthread_attr_destroy(&attrs);
 
@@ -498,6 +524,10 @@ int threadpool__stop(struct threadpool *pool)
 {
 	int t, ret, err = 0;
 
+	err = threadpool__wait(pool);
+	if (err)
+		return err;
+
 	for (t = 0; t < pool->nr_threads; t++) {
 		/**
 		 * Even if a termination fails, we should continue to terminate
@@ -523,3 +553,67 @@ bool threadpool__is_running(struct threadpool *pool)
 			return true;
 	return false;
 }
+
+/**
+ * threadpool__execute - set threadpool @task
+ *
+ * The task will be immediately executed on all started threads. If a thread
+ * is not running, it will start executing this task once started.
+ * The task will run asynchronously wrt the main thread.
+ * The task can be waited with threadpool__wait. Since no queueing is performed,
+ * you need to wait the pool before submitting a new task.
+ */
+int threadpool__execute(struct threadpool *pool, struct task_struct *task)
+{
+	int t, ret;
+
+	if (pool->current_task)
+		return -EBUSY;
+
+	pool->current_task = task;
+
+	for (t = 0; t < pool->nr_threads; t++) {
+		if (!pool->threads[t].running)
+			continue;
+		ret = threadpool__wake_thread(pool, t);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
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
+	int t, err = 0, ret;
+
+	if (!pool->current_task)
+		return 0;
+
+	for (t = 0; t < pool->nr_threads; t++) {
+		if (!pool->threads[t].running)
+			continue;
+		ret = threadpool__wait_thread(pool, t);
+		if (ret)
+			err = ret;
+	}
+
+	pool->current_task = NULL;
+	return err;
+}
+
+/**
+ * threadpool__is_busy - check if the pool has work to do
+ */
+bool threadpool__is_busy(struct threadpool *pool)
+{
+	return pool->current_task;
+}
diff --git a/tools/perf/util/workqueue/threadpool.h b/tools/perf/util/workqueue/threadpool.h
index 0e03fdd377627e79..9a6081cef8af95e0 100644
--- a/tools/perf/util/workqueue/threadpool.h
+++ b/tools/perf/util/workqueue/threadpool.h
@@ -18,8 +18,12 @@ extern int threadpool__start_thread(struct threadpool *pool, int tidx);
 extern int threadpool__start(struct threadpool *pool);
 extern int threadpool__stop(struct threadpool *pool);
 
+extern int threadpool__wait(struct threadpool *pool);
+extern int threadpool__execute(struct threadpool *pool, struct task_struct *task);
+
 extern int threadpool__size(struct threadpool *pool);
 extern bool threadpool__is_running(struct threadpool *pool);
+extern bool threadpool__is_busy(struct threadpool *pool);
 
 /* Error management */
 #define THREADPOOL_STRERR_BUFSIZE (128+STRERR_BUFSIZE)
-- 
2.31.1

