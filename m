Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59EAC19F31
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 15:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B90961102
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 15:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhG3PhH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jul 2021 11:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbhG3PfB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jul 2021 11:35:01 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D71AC06179F;
        Fri, 30 Jul 2021 08:34:29 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f14-20020a05600c154eb02902519e4abe10so9433790wmg.4;
        Fri, 30 Jul 2021 08:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N4+eNHRqB7ir2o3uFz4Wrxn1pmXgTsAdKgvyvw3c0jk=;
        b=ZHDfxT35/HCfOfyWymR63jwJ0f2Z3Dgy5rH1sIgN1VoszPpj1Bm1z2ZcVx5NCLZh47
         QN66QmrXzGo81n84BlWKKEshkrDfH5PRuZgQU8FDw/Gsyed+hNItPKpYxDe3e8NyTmiK
         c0GnA+tcTtj1hSc1g1rfwi+8vzW0BfNbWIoJ8hxvUcAnLViykf+3bUuhsgRM0xgSYJjA
         ajbjQlBZWSLWnDvO3hEiQMyK6K3VWO16G8MDj/E//y5tlA5bVayjYb7yKz4hdpCrQJMo
         oh3/H+xgtB4+UXUYE6l3Ov52EhzSTpsYde5iqbAkfo6ABqJ3XsVve26uPPUtsKbWEV2O
         2DPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4+eNHRqB7ir2o3uFz4Wrxn1pmXgTsAdKgvyvw3c0jk=;
        b=azyhDYFq0Tukuupxc249G8mCns6dhoHvfDffUvAnLNeIRyF+wn6ehxCvAPuOnK3k1N
         8wp/D2NLZ9NZlI3tzKNgV2f7RAVR+vK+7Talw29vynyeoS0ocMJMzndOBwWTM+Cqf530
         dvCNigBREovk9Xc4XpXz6WUYAkPXaBX45YRUG3TyVnPKvQaKd8PgGowl3KCHoDj3fsjv
         TqIV60vpmH9s+14q9OcHrpR5x4FlRHoJU8tLX3jXwv28AJ7sxRxeW6E2Fx5aIhB4fw2H
         tBZZiVgPGZuL/4oiT/whH/ZJWKdeq7ScvZKhng0TEYPK10suuYWV/KHQhCPslqeFtSxc
         Ld4g==
X-Gm-Message-State: AOAM530UrITUWPEWd+Z8NKocd69IYTxe3Idj03uoEDreXedjbJrlOZ3E
        pj0AkS7itz3kGF3lNxOdR3Q=
X-Google-Smtp-Source: ABdhPJyOKBdCCuHD7RXdi+g7n9k5bLHNYgl4SpikaPbgR+zuGMeEMHebYz2T3Lu2DeFahVIHYPF6PA==
X-Received: by 2002:a1c:ed13:: with SMTP id l19mr3746606wmh.48.1627659267923;
        Fri, 30 Jul 2021 08:34:27 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id v15sm2354727wmj.39.2021.07.30.08.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 08:34:27 -0700 (PDT)
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
Subject: [RFC PATCH v2 06/10] perf workqueue: introduce workqueue struct
Date:   Fri, 30 Jul 2021 17:34:13 +0200
Message-Id: <c946622ece7d1d1b99912563f6a7c56402955156.1627657061.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627657061.git.rickyman7@gmail.com>
References: <cover.1627657061.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds the workqueue definition, along with simple creation and
destruction functions.
Furthermore, a simple subtest is added.

A workqueue is attached to a pool, on which it executes its workers.
Next patches will introduce workers.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/tests/workqueue.c          |  86 +++++++++
 tools/perf/util/workqueue/Build       |   1 +
 tools/perf/util/workqueue/workqueue.c | 268 ++++++++++++++++++++++++++
 tools/perf/util/workqueue/workqueue.h |  38 ++++
 4 files changed, 393 insertions(+)
 create mode 100644 tools/perf/util/workqueue/workqueue.c
 create mode 100644 tools/perf/util/workqueue/workqueue.h

diff --git a/tools/perf/tests/workqueue.c b/tools/perf/tests/workqueue.c
index 87bf8fc71c346653..2165a563e47bd6a5 100644
--- a/tools/perf/tests/workqueue.c
+++ b/tools/perf/tests/workqueue.c
@@ -6,6 +6,7 @@
 #include "tests.h"
 #include "util/debug.h"
 #include "util/workqueue/threadpool.h"
+#include "util/workqueue/workqueue.h"
 
 #define DUMMY_FACTOR 100000
 #define N_DUMMY_WORK_SIZES 7
@@ -14,6 +15,11 @@ struct threadpool_test_args_t {
 	int pool_size;
 };
 
+struct workqueue_test_args_t {
+	int pool_size;
+	int n_work_items;
+};
+
 struct test_task {
 	struct task_struct task;
 	int n_threads;
@@ -141,6 +147,52 @@ static int __test__threadpool(void *_args)
 	return ret;
 }
 
+
+static int __workqueue__prepare(struct threadpool **pool,
+				struct workqueue_struct **wq,
+				int pool_size)
+{
+	int ret = __threadpool__prepare(pool, pool_size);
+
+	if (ret)
+		return ret;
+
+	*wq = create_workqueue(*pool);
+	TEST_ASSERT_VAL("workqueue creation failure", !IS_ERR(*wq));
+	TEST_ASSERT_VAL("workqueue wrong size", workqueue_nr_threads(*wq) == pool_size);
+	TEST_ASSERT_VAL("threadpool is not executing", threadpool__is_busy(*pool));
+
+	return TEST_OK;
+}
+
+static int __workqueue__teardown(struct threadpool *pool,
+				struct workqueue_struct *wq)
+{
+	int ret = destroy_workqueue(wq);
+
+	TEST_ASSERT_VAL("workqueue detruction failure", ret == 0);
+
+	return __threadpool__teardown(pool);
+}
+
+static int __test__workqueue(void *_args)
+{
+	struct workqueue_test_args_t *args = _args;
+	struct threadpool *pool;
+	struct workqueue_struct *wq;
+	int ret = __workqueue__prepare(&pool, &wq, args->pool_size);
+
+	if (ret)
+		goto out;
+
+	ret = __workqueue__teardown(pool, wq);
+	if (ret)
+		goto out;
+
+out:
+	return ret;
+}
+
 static const struct threadpool_test_args_t threadpool_test_args[] = {
 	{
 		.pool_size = 1
@@ -159,6 +211,33 @@ static const struct threadpool_test_args_t threadpool_test_args[] = {
 	}
 };
 
+static const struct workqueue_test_args_t workqueue_test_args[] = {
+	{
+		.pool_size = 1,
+		.n_work_items = 1
+	},
+	{
+		.pool_size = 1,
+		.n_work_items = 10
+	},
+	{
+		.pool_size = 2,
+		.n_work_items = 1
+	},
+	{
+		.pool_size = 2,
+		.n_work_items = 100
+	},
+	{
+		.pool_size = 16,
+		.n_work_items = 7
+	},
+	{
+		.pool_size = 16,
+		.n_work_items = 2789
+	}
+};
+
 struct test_case {
 	const char *desc;
 	int (*func)(void *args);
@@ -174,6 +253,13 @@ static struct test_case workqueue_testcase_table[] = {
 		.args = (void *) threadpool_test_args,
 		.n_args = (int)ARRAY_SIZE(threadpool_test_args),
 		.arg_size = sizeof(struct threadpool_test_args_t)
+	},
+	{
+		.desc = "Workqueue",
+		.func = __test__workqueue,
+		.args = (void *) workqueue_test_args,
+		.n_args = (int)ARRAY_SIZE(workqueue_test_args),
+		.arg_size = sizeof(struct workqueue_test_args_t)
 	}
 };
 
diff --git a/tools/perf/util/workqueue/Build b/tools/perf/util/workqueue/Build
index 8b72a6cd4e2cba0d..4af721345c0a6bb7 100644
--- a/tools/perf/util/workqueue/Build
+++ b/tools/perf/util/workqueue/Build
@@ -1 +1,2 @@
 perf-y += threadpool.o
+perf-y += workqueue.o
diff --git a/tools/perf/util/workqueue/workqueue.c b/tools/perf/util/workqueue/workqueue.c
new file mode 100644
index 0000000000000000..d3c6d4c4e75944a5
--- /dev/null
+++ b/tools/perf/util/workqueue/workqueue.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
+#include <string.h>
+#include <pthread.h>
+#include <linux/list.h>
+#include <linux/err.h>
+#include <linux/string.h>
+#include "debug.h"
+#include <internal/lib.h>
+#include "workqueue.h"
+
+enum workqueue_status {
+	WORKQUEUE_STATUS__READY,	/* wq is ready to receive work */
+	WORKQUEUE_STATUS__ERROR,
+	WORKQUEUE_STATUS__MAX
+};
+
+static const char * const workqueue_status_tags[] = {
+	"ready",
+	"error"
+};
+
+struct workqueue_struct {
+	pthread_mutex_t		lock;		/* locking of the thread_pool */
+	pthread_cond_t		idle_cond;	/* all workers are idle cond */
+	struct threadpool	*pool;		/* underlying pool */
+	int			pool_errno;	/* latest pool error */
+	struct task_struct	task;		/* threadpool task */
+	struct list_head	busy_list;	/* busy workers */
+	struct list_head	idle_list;	/* idle workers */
+	struct list_head	pending;	/* pending work items */
+	int			msg_pipe[2];	/* main thread comm pipes */
+	enum workqueue_status	status;
+};
+
+static const char * const workqueue_errno_str[] = {
+	"",
+	"This operation is not allowed in this workqueue status",
+	"Error executing function in threadpool",
+	"Error waiting the threadpool",
+	"Error sending message to worker",
+	"Error receiving message from worker",
+	"Received unexpected message from worker",
+};
+
+/**
+ * worker_thread - worker function executed on threadpool
+ */
+static void worker_thread(int tidx, struct task_struct *task)
+{
+
+	pr_info("Hi from worker %d, executing task %p\n", tidx, task);
+}
+
+/**
+ * attach_threadpool_to_workqueue - start @wq workers on @pool
+ */
+static int attach_threadpool_to_workqueue(struct workqueue_struct *wq,
+					struct threadpool *pool)
+{
+	if (!threadpool__is_ready(pool)) {
+		pr_debug2("workqueue: cannot attach to pool: pool is not ready\n");
+		return -WORKQUEUE_ERROR__NOTALLOWED;
+	}
+
+	wq->pool = pool;
+
+	wq->pool_errno = threadpool__execute(pool, &wq->task);
+	if (wq->pool_errno)
+		return -WORKQUEUE_ERROR__POOLEXE;
+
+	return 0;
+}
+
+/**
+ * detach_threadpool_from_workqueue - stop @wq workers on @pool
+ */
+static int detach_threadpool_from_workqueue(struct workqueue_struct *wq)
+{
+	int ret, err = 0;
+
+	if (wq->status != WORKQUEUE_STATUS__READY) {
+		pr_debug2("workqueue: cannot attach to pool: wq is not ready\n");
+		return -WORKQUEUE_ERROR__NOTALLOWED;
+	}
+
+	ret = threadpool__wait(wq->pool);
+	if (ret) {
+		pr_debug2("workqueue: error waiting threadpool\n");
+		wq->pool_errno = ret;
+		err = -WORKQUEUE_ERROR__POOLWAIT;
+	}
+
+	wq->pool = NULL;
+	return err;
+}
+
+/**
+ * create_workqueue - create a workqueue associated to @pool
+ *
+ * Only one workqueue can execute on a pool at a time.
+ */
+struct workqueue_struct *create_workqueue(struct threadpool *pool)
+{
+	int ret, err = 0;
+	struct workqueue_struct *wq = malloc(sizeof(struct workqueue_struct));
+
+	if (!wq) {
+		err = -ENOMEM;
+		goto out_return;
+	}
+
+	ret = pthread_mutex_init(&wq->lock, NULL);
+	if (ret) {
+		err = -ret;
+		goto out_free_wq;
+	}
+
+	ret = pthread_cond_init(&wq->idle_cond, NULL);
+	if (ret) {
+		err = -ret;
+		goto out_destroy_mutex;
+	}
+
+	wq->pool = NULL;
+	INIT_LIST_HEAD(&wq->busy_list);
+	INIT_LIST_HEAD(&wq->idle_list);
+
+	INIT_LIST_HEAD(&wq->pending);
+
+	ret = pipe(wq->msg_pipe);
+	if (ret) {
+		err = -ENOMEM;
+		goto out_destroy_cond;
+	}
+
+	wq->task.fn = worker_thread;
+
+	ret = attach_threadpool_to_workqueue(wq, pool);
+	if (ret) {
+		err = ret;
+		goto out_destroy_cond;
+	}
+
+	wq->status = WORKQUEUE_STATUS__READY;
+
+	return wq;
+
+out_destroy_cond:
+	pthread_cond_destroy(&wq->idle_cond);
+out_destroy_mutex:
+	pthread_mutex_destroy(&wq->lock);
+out_free_wq:
+	free(wq);
+out_return:
+	return ERR_PTR(err);
+}
+
+/**
+ * destroy_workqueue - stop @wq workers and destroy @wq
+ */
+int destroy_workqueue(struct workqueue_struct *wq)
+{
+	int err = 0, ret;
+
+	if (IS_ERR_OR_NULL(wq))
+		return 0;
+
+	ret = detach_threadpool_from_workqueue(wq);
+	if (ret) {
+		pr_debug2("workqueue: error detaching from threadpool.\n");
+		err = ret;
+	}
+
+	ret = pthread_mutex_destroy(&wq->lock);
+	if (ret) {
+		err = -ret;
+		pr_debug2("workqueue: error pthread_mutex_destroy: %s\n",
+			strerror(errno));
+	}
+
+	ret = pthread_cond_destroy(&wq->idle_cond);
+	if (ret) {
+		err = -ret;
+		pr_debug2("workqueue: error pthread_cond_destroy: %s\n",
+			strerror(errno));
+	}
+
+	close(wq->msg_pipe[0]);
+	wq->msg_pipe[0] = -1;
+
+	close(wq->msg_pipe[1]);
+	wq->msg_pipe[1] = -1;
+
+	free(wq);
+	return err;
+}
+
+/**
+ * workqueue_strerror - print message regarding lastest error in @wq
+ *
+ * Buffer size should be at least WORKQUEUE_STRERR_BUFSIZE bytes.
+ */
+int workqueue_strerror(struct workqueue_struct *wq, int err, char *buf, size_t size)
+{
+	int ret;
+	char sbuf[THREADPOOL_STRERR_BUFSIZE], *emsg;
+	const char *status_str, *errno_str;
+
+	status_str = IS_ERR_OR_NULL(wq) ? "error" : workqueue_status_tags[wq->status];
+	errno_str = workqueue_errno_str[-err-WORKQUEUE_ERROR__OFFSET];
+
+	switch (err) {
+	case -WORKQUEUE_ERROR__NOTALLOWED:
+		return scnprintf(buf, size, "%s (%s).\n",
+			errno_str, status_str);
+	case -WORKQUEUE_ERROR__POOLEXE:
+	case -WORKQUEUE_ERROR__POOLWAIT:
+		if (IS_ERR_OR_NULL(wq))
+			return scnprintf(buf, size, "%s: unknown.\n",
+				errno_str);
+
+		ret = threadpool__strerror(wq->pool, wq->pool_errno, sbuf, sizeof(sbuf));
+		if (ret < 0)
+			return ret;
+		return scnprintf(buf, size, "%s: %s.\n", errno_str, sbuf);
+	case -WORKQUEUE_ERROR__WRITEPIPE:
+	case -WORKQUEUE_ERROR__READPIPE:
+		emsg = str_error_r(errno, sbuf, sizeof(sbuf));
+		return scnprintf(buf, size, "%s: %s.\n", errno_str, emsg);
+	case -WORKQUEUE_ERROR__INVALIDMSG:
+		return scnprintf(buf, size, "%s.\n", errno_str);
+	default:
+		emsg = str_error_r(err, sbuf, sizeof(sbuf));
+		return scnprintf(buf, size, "Error: %s", emsg);
+	}
+}
+
+/**
+ * create_workqueue_strerror - print message regarding @err_ptr
+ *
+ * Buffer size should be at least WORKQUEUE_STRERR_BUFSIZE bytes.
+ */
+int create_workqueue_strerror(struct workqueue_struct *err_ptr, char *buf, size_t size)
+{
+	return workqueue_strerror(err_ptr, PTR_ERR(err_ptr), buf, size);
+}
+
+/**
+ * destroy_workqueue_strerror - print message regarding @err
+ *
+ * Buffer size should be at least WORKQUEUE_STRERR_BUFSIZE bytes.
+ */
+int destroy_workqueue_strerror(int err, char *buf, size_t size)
+{
+	return workqueue_strerror(NULL, err, buf, size);
+}
+
+/**
+ * workqueue_nr_threads - get size of threadpool underlying @wq
+ */
+int workqueue_nr_threads(struct workqueue_struct *wq)
+{
+	return threadpool__size(wq->pool);
+}
diff --git a/tools/perf/util/workqueue/workqueue.h b/tools/perf/util/workqueue/workqueue.h
new file mode 100644
index 0000000000000000..456cd8b6cb2a26d8
--- /dev/null
+++ b/tools/perf/util/workqueue/workqueue.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __WORKQUEUE_WORKQUEUE_H
+#define __WORKQUEUE_WORKQUEUE_H
+
+#include <stdlib.h>
+#include <sys/types.h>
+#include <linux/list.h>
+#include "threadpool.h"
+
+struct work_struct;
+typedef void (*work_func_t)(struct work_struct *work);
+
+struct work_struct {
+	struct list_head entry;
+	work_func_t func;
+};
+
+struct workqueue_struct;
+
+extern struct workqueue_struct *create_workqueue(struct threadpool *pool);
+extern int destroy_workqueue(struct workqueue_struct *wq);
+
+extern int workqueue_nr_threads(struct workqueue_struct *wq);
+
+#define WORKQUEUE_STRERR_BUFSIZE (128+THREADPOOL_STRERR_BUFSIZE)
+#define WORKQUEUE_ERROR__OFFSET 512
+enum {
+	WORKQUEUE_ERROR__NOTALLOWED = WORKQUEUE_ERROR__OFFSET,
+	WORKQUEUE_ERROR__POOLEXE,
+	WORKQUEUE_ERROR__POOLWAIT,
+	WORKQUEUE_ERROR__WRITEPIPE,
+	WORKQUEUE_ERROR__READPIPE,
+	WORKQUEUE_ERROR__INVALIDMSG,
+};
+extern int workqueue_strerror(struct workqueue_struct *wq, int err, char *buf, size_t size);
+extern int create_workqueue_strerror(struct workqueue_struct *err_ptr, char *buf, size_t size);
+extern int destroy_workqueue_strerror(int err, char *buf, size_t size);
+#endif /* __WORKQUEUE_WORKQUEUE_H */
-- 
2.31.1

