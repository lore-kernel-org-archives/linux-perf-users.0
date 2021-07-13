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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527C1C07E96
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 12:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 398886120A
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 12:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbhGMMO2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 08:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236134AbhGMMO2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 08:14:28 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CC8C0613DD;
        Tue, 13 Jul 2021 05:11:36 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d2so30225059wrn.0;
        Tue, 13 Jul 2021 05:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u+oRVIcH2dwwU63fH8m2eByL7WZNB6ou/3CewRjtJjw=;
        b=JpaICWY4XpomJHTJKFMbNZpJcxYTcUOUnPb41yijePE/Clso7Pe+MKmbRjWixA2fbB
         h9nPV1VwsHmcBOB32K7iQOLUDAFTsmvQ7Q/oSiRblO2qPGMYGxhg180t3Jx4R5+OAX2y
         uOAa5cRPdthina4ey7r7cMSql0BUHmAoKSaLhncbeDlBeu29qdULblJGyspc+JrShsgD
         yWz2qQQDsksCXaVjcufrHQisb7JSuQqIJ1wEOC8AEurF/qdq/KpLHswoPQNXTfckg34y
         RteqXlXFIDZ0pJN74Ob15w8Rhw7FJvIVPLhP8uyd1SrQq1qc/nAF9umegWZy6pES0i3V
         4x4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u+oRVIcH2dwwU63fH8m2eByL7WZNB6ou/3CewRjtJjw=;
        b=ejEVgnYeA57nCKod2PtcHyLdY29ZhwYnMpFBtLdluKRzW4WTZP/02zy4vPCeu5sYjz
         okHXpk/1pDnojnGbLjDLRISsorqmvTW9MFzR13cN417QKZbyMW0bNiExi2SSo+1jRxzb
         iw8act4XvV99pc75IlXdikNUWY/DLSCItTCAZ2oEFc+Cs/BzrMrieIs/5sKIptwilW4j
         HjNjrRXOo5qr5Txluo3b3vj3JvR9nv6hIYOZaLMuUt6YrXbHRti+YUduxWDIywXAKm8t
         jL4uRj1Fot/rgoktTfMEPdoWz9XPfb6Ri7sfkqJ15l+fbZaI8Ik893LJvRunlKm/ndVv
         c4Hw==
X-Gm-Message-State: AOAM532omUoKhBuvs6MFyQTDaa3nKAsWEyWF5q3DQ5Ffag11kXwmEFeK
        7n0N23UG32V+WfLcNF+n1Wc=
X-Google-Smtp-Source: ABdhPJzvVclWdRT5SopOOAMAsmtV/acCDyuTAbOHndnsZMRmZ22kYqZMNxOLih1NdinK3qRvzt/TDw==
X-Received: by 2002:adf:ba07:: with SMTP id o7mr5213276wrg.160.1626178295173;
        Tue, 13 Jul 2021 05:11:35 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id o3sm17551425wrw.56.2021.07.13.05.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 05:11:34 -0700 (PDT)
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
Subject: [RFC PATCH 04/10] perf workqueue: add threadpool execute and wait functions
Date:   Tue, 13 Jul 2021 14:11:15 +0200
Message-Id: <a5fee5068f9630f14f1f5c259434badf43d451c4.1626177381.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626177381.git.rickyman7@gmail.com>
References: <cover.1626177381.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds:
 - execute_in_threadpool: assigns a task to the threads to execute
   asynchronously.
 - wait_threadpool: waits for the task to complete on all threads.
Furthermore, testing for these new functions is added.

This patch completes the threadpool.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/tests/workqueue.c           |  86 ++++++++++++++++++++-
 tools/perf/util/workqueue/threadpool.c | 103 +++++++++++++++++++++++++
 tools/perf/util/workqueue/threadpool.h |   5 ++
 3 files changed, 193 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/workqueue.c b/tools/perf/tests/workqueue.c
index be377e9897bab4e9..3c64db8203556847 100644
--- a/tools/perf/tests/workqueue.c
+++ b/tools/perf/tests/workqueue.c
@@ -1,13 +1,59 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stdlib.h>
 #include <linux/kernel.h>
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
+	int prod = 0;
+	int k = idx % N_DUMMY_WORK_SIZES;
+	int i, j;
+
+	for (i = 0; i < DUMMY_FACTOR; i++)
+		for (j = 0; j < k; j++)
+			prod ++;
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
 static int __threadpool__prepare(struct threadpool_struct **pool, int pool_size)
 {
 	int ret;
@@ -38,21 +84,59 @@ static int __threadpool__teardown(struct threadpool_struct *pool)
 	return 0;
 }
 
+static int __threadpool__exec_wait(struct threadpool_struct *pool,
+				struct task_struct *task)
+{
+	int ret;
+
+	ret = execute_in_threadpool(pool, task);
+	TEST_ASSERT_VAL("threadpool execute failure", ret == 0);
+	TEST_ASSERT_VAL("threadpool is not executing", threadpool_is_busy(pool));
+
+	ret = wait_threadpool(pool);
+	TEST_ASSERT_VAL("threadpool wait failure", ret == 0);
+	TEST_ASSERT_VAL("waited threadpool is not ready", threadpool_is_ready(pool));
+
+	return 0;
+}
 
 static int __test__threadpool(void *_args)
 {
 	struct threadpool_test_args_t *args = _args;
 	struct threadpool_struct *pool;
-	int ret;
+	int ret, i;
+	struct test_task task;
+
+	task.task.fn = test_task_fn1;
+	task.n_threads = args->pool_size;
+	task.array = calloc(args->pool_size, sizeof(*task.array));
 
 	ret = __threadpool__prepare(&pool, args->pool_size);
 	if (ret)
 		return ret;
 
+	ret = __threadpool__exec_wait(pool, &task.task);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < args->pool_size; i++)
+		TEST_ASSERT_VAL("failed array check (1)", task.array[i] == i+1);
+
+	task.task.fn = test_task_fn2;
+
+	ret = __threadpool__exec_wait(pool, &task.task);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < args->pool_size; i++)
+		TEST_ASSERT_VAL("failed array check (2)", task.array[i] == 2*i);
+
 	ret = __threadpool__teardown(pool);
 	if (ret)
 		return ret;
 
+	free(task.array);
+
 	return 0;
 }
 
diff --git a/tools/perf/util/workqueue/threadpool.c b/tools/perf/util/workqueue/threadpool.c
index f4635ff782b9388e..720c7b2a562d6816 100644
--- a/tools/perf/util/workqueue/threadpool.c
+++ b/tools/perf/util/workqueue/threadpool.c
@@ -21,6 +21,7 @@ static inline pid_t gettid(void)
 enum threadpool_status {
 	THREADPOOL_STATUS__STOPPED,		/* no threads */
 	THREADPOOL_STATUS__READY,		/* threads are ready but idle */
+	THREADPOOL_STATUS__BUSY,		/* threads are busy */
 	THREADPOOL_STATUS__ERROR,		/* errors */
 	THREADPOOL_STATUS__MAX
 };
@@ -164,6 +165,28 @@ static int terminate_thread(struct thread_struct *thread)
 	return res;
 }
 
+/**
+ * wake_thread - send wake msg to @thread
+ *
+ * This function does not wait for the thread to actually wake
+ * NB: call only from main thread!
+ */
+static int wake_thread(struct thread_struct *thread)
+{
+	int res;
+	enum thread_msg msg = THREAD_MSG__WAKE;
+
+	res = write(thread->pipes.to[1], &msg, sizeof(msg));
+	if (res < 0) {
+		pr_err("threadpool: error sending wake msg: %s\n", strerror(errno));
+		return -1;
+	}
+
+	pr_debug2("threadpool: sent wake msg %s to tid=%d\n",
+		thread_msg_tags[msg], thread->tid);
+	return 0;
+}
+
 /**
  * threadpool_thread - function running on thread
  *
@@ -207,6 +230,15 @@ static void *threadpool_thread(void *args)
 
 		if (msg == THREAD_MSG__STOP)
 			break;
+
+		if (!thread->pool->current_task) {
+			pr_err("threadpool[%d]: received wake without task\n",
+				thread->tid);
+			break;
+		}
+
+		pr_debug("threadpool[%d]: executing task\n", thread->tid);
+		thread->pool->current_task->fn(thread->idx, thread->pool->current_task);
 	}
 
 	pr_debug2("threadpool[%d]: exit\n", thread->tid);
@@ -383,11 +415,16 @@ int start_threadpool(struct threadpool_struct *pool)
  * stop_threadpool - stop all threads in the pool.
  *
  * This function blocks waiting for ack from all threads.
+ * If the pool was busy, it will first wait for the task to finish.
  */
 int stop_threadpool(struct threadpool_struct *pool)
 {
 	int t, ret, err = 0;
 
+	err = wait_threadpool(pool);
+	if (err)
+		return err;
+
 	if (pool->status != THREADPOOL_STATUS__READY) {
 		pr_err("threadpool: stopping not ready pool\n");
 		return -1;
@@ -411,3 +448,69 @@ bool threadpool_is_ready(struct threadpool_struct *pool)
 {
 	return pool->status == THREADPOOL_STATUS__READY;
 }
+
+/**
+ * execute_in_threadpool - execute @task on all threads of the @pool
+ *
+ * The task will run asynchronously wrt the main thread.
+ * The task can be waited with wait_threadpool.
+ *
+ * NB: make sure the pool is ready before calling this, since no queueing is
+ *     performed. If you need queueing, have a look at the workqueue.
+ */
+int execute_in_threadpool(struct threadpool_struct *pool, struct task_struct *task)
+{
+	int t, err;
+
+	WARN_ON(pool->status != THREADPOOL_STATUS__READY);
+
+	pool->current_task = task;
+
+	for (t = 0; t < pool->nr_threads; t++) {
+		err = wake_thread(&pool->threads[t]);
+
+		if (err) {
+			pool->status = THREADPOOL_STATUS__ERROR;
+			return err;
+		}
+	}
+
+	pool->status = THREADPOOL_STATUS__BUSY;
+	return 0;
+}
+
+/**
+ * wait_threadpool - wait until all threads in @pool are done
+ *
+ * This function will wait for all threads to finish execution and send their
+ * ack message.
+ *
+ * NB: call only from main thread!
+ */
+int wait_threadpool(struct threadpool_struct *pool)
+{
+	int t, err = 0, ret;
+
+	if (pool->status != THREADPOOL_STATUS__BUSY)
+		return 0;
+
+	for (t = 0; t < pool->nr_threads; t++) {
+		ret = wait_thread(&pool->threads[t]);
+		if (ret) {
+			pool->status = THREADPOOL_STATUS__ERROR;
+			err = -1;
+		}
+	}
+
+	pool->status = err ? THREADPOOL_STATUS__ERROR : THREADPOOL_STATUS__READY;
+	pool->current_task = NULL;
+	return err;
+}
+
+/**
+ * threadpool_is_busy - check if the pool is busy
+ */
+int threadpool_is_busy(struct threadpool_struct *pool)
+{
+	return pool->status == THREADPOOL_STATUS__BUSY;
+}
diff --git a/tools/perf/util/workqueue/threadpool.h b/tools/perf/util/workqueue/threadpool.h
index b62cad2b2c5dd331..dd9c2103ebe8d23b 100644
--- a/tools/perf/util/workqueue/threadpool.h
+++ b/tools/perf/util/workqueue/threadpool.h
@@ -17,8 +17,13 @@ extern void destroy_threadpool(struct threadpool_struct *pool);
 extern int start_threadpool(struct threadpool_struct *pool);
 extern int stop_threadpool(struct threadpool_struct *pool);
 
+extern int execute_in_threadpool(struct threadpool_struct *pool,
+				struct task_struct *task);
+extern int wait_threadpool(struct threadpool_struct *pool);
+
 extern int threadpool_size(struct threadpool_struct *pool);
 
 extern bool threadpool_is_ready(struct threadpool_struct *pool);
+extern int threadpool_is_busy(struct threadpool_struct *pool);
 
 #endif /* __WORKQUEUE_THREADPOOL_H */
-- 
2.31.1

