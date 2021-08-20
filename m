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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0994C4320A
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC3A560C3E
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbhHTKzO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239440AbhHTKzF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Aug 2021 06:55:05 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABA5C06179A;
        Fri, 20 Aug 2021 03:54:19 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id h9so19390696ejs.4;
        Fri, 20 Aug 2021 03:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AwgtUznNB+XoCffYaoWbFnFw2HkfYuAMamDUWIC8uSM=;
        b=TbG+SmEQgJ4076vSyRWs4hzZQDhVMDNI1X86RhVK4rTaDGLNVuAoZhchOSePCbcSaM
         61xdcCpCM9VOZXuA/vGunk6kKsLGvPTdzmHy7iz47+Yf2W8yGCOmdWh+qPXuf64g2rl/
         N6h8RgOqFS80TyFhDqTSpNkWn7+VnRfxgmJ3NDVzONoX06YKar91UNVt0lZtfP5KqrKC
         +7nhCa/T3gDcfyGq+CuWRZreiJdgg5a50GOtqY8pCxGoCnQT04npNQHg5Ktom2qLI9P9
         zdIplqiYVPyU/8Qm+tkJCliQpgJQwI6WtO7ZA2Y6LPbb3uNNVkLVVQLVMWZQcRXQUH5p
         uBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AwgtUznNB+XoCffYaoWbFnFw2HkfYuAMamDUWIC8uSM=;
        b=quxtJgYFahKcnqMt0f74CU5KrWSAydMnfJsnc6k0RVADf5q65sfHB0yLOhlDPmWQKb
         hhh5EuXjpJl9lQpvPxOJsddBLIJACxoMeJ+OZVrukWucWwugtfb5Kv3HVCiYcQXwL/Nv
         CCbdmC411PFoA+joBnkxbOTKpvqYmychwAqy7L2Cm6sMfyUYmiHPXrw2mkbY5Mg/wgrt
         htWtURsM1jPrtSUH6z2+xzntZhxJb/c+CEeRPpmdzuJcGkDRruEhGoe7w7AiP1Mxof2K
         nJQpltb35tl4JIqh/y3EyfO1zu3N+SobbliJXw5BtzwrpXZFTyDpYernHEKp6Yq2ehSP
         P7TQ==
X-Gm-Message-State: AOAM530aKffnm1J7IBhG1YojKd5JF4OTFe6Yj1BE/uYMkXCe+IYSbEc6
        InSh7EWe9kuPi6UAX77P7tY=
X-Google-Smtp-Source: ABdhPJy7d3etfxEVYHqxnDqFupMROOXihMNNYhSoBkQ/UEbBSYHirHqV5NFRlmvIsAVQXtT1rHo05w==
X-Received: by 2002:a17:907:35d0:: with SMTP id ap16mr20909966ejc.456.1629456858270;
        Fri, 20 Aug 2021 03:54:18 -0700 (PDT)
Received: from honeypot.epfl.ch (mob-176-243-199-7.net.vodafone.it. [176.243.199.7])
        by smtp.googlemail.com with ESMTPSA id g29sm3451459edf.31.2021.08.20.03.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 03:54:17 -0700 (PDT)
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
Subject: [RFC PATCH v3 06/15] perf workqueue: introduce workqueue struct
Date:   Fri, 20 Aug 2021 12:53:52 +0200
Message-Id: <9dee672538967a3cf7e82ef194ebccc709b1af41.1629454773.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629454773.git.rickyman7@gmail.com>
References: <cover.1629454773.git.rickyman7@gmail.com>
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
 tools/perf/tests/workqueue.c          |  81 +++++++++++
 tools/perf/util/workqueue/Build       |   1 +
 tools/perf/util/workqueue/workqueue.c | 196 ++++++++++++++++++++++++++
 tools/perf/util/workqueue/workqueue.h |  39 +++++
 4 files changed, 317 insertions(+)
 create mode 100644 tools/perf/util/workqueue/workqueue.c
 create mode 100644 tools/perf/util/workqueue/workqueue.h

diff --git a/tools/perf/tests/workqueue.c b/tools/perf/tests/workqueue.c
index b145a5155089497f..1aa6ee788b0b1c32 100644
--- a/tools/perf/tests/workqueue.c
+++ b/tools/perf/tests/workqueue.c
@@ -7,6 +7,7 @@
 #include "tests.h"
 #include "util/debug.h"
 #include "util/workqueue/threadpool.h"
+#include "util/workqueue/workqueue.h"
 
 #define DUMMY_FACTOR 100000
 #define N_DUMMY_WORK_SIZES 7
@@ -15,6 +16,11 @@ struct threadpool_test_args_t {
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
@@ -141,6 +147,43 @@ static int __test__threadpool(void *_args)
 	return ret;
 }
 
+static int __workqueue__prepare(struct workqueue_struct **wq,
+				int pool_size)
+{
+	*wq = create_workqueue(pool_size);
+	TEST_ASSERT_VAL("workqueue creation failure", !IS_ERR(*wq));
+	TEST_ASSERT_VAL("workqueue wrong size", workqueue_nr_threads(*wq) == pool_size);
+
+	return TEST_OK;
+}
+
+static int __workqueue__teardown(struct workqueue_struct *wq)
+{
+	int ret = destroy_workqueue(wq);
+
+	TEST_ASSERT_VAL("workqueue detruction failure", ret == 0);
+
+	return 0;
+}
+
+static int __test__workqueue(void *_args)
+{
+	struct workqueue_test_args_t *args = _args;
+	struct workqueue_struct *wq;
+	int pool_size = args->pool_size ?: sysconf(_SC_NPROCESSORS_ONLN);
+	int ret = __workqueue__prepare(&wq, pool_size);
+
+	if (ret)
+		goto out;
+
+	ret = __workqueue__teardown(wq);
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
@@ -162,6 +205,37 @@ static const struct threadpool_test_args_t threadpool_test_args[] = {
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
+	},
+	{
+		.pool_size = 0,	// sysconf(_SC_NPROCESSORS_ONLN)
+		.n_work_items = 8191
+	}
+};
+
 struct test_case {
 	const char *desc;
 	int (*func)(void *args);
@@ -177,6 +251,13 @@ static struct test_case workqueue_testcase_table[] = {
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
index 0000000000000000..053aac43e038f0b7
--- /dev/null
+++ b/tools/perf/util/workqueue/workqueue.c
@@ -0,0 +1,196 @@
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
+#include <linux/zalloc.h>
+#include "debug.h"
+#include <internal/lib.h>
+#include "workqueue.h"
+
+struct workqueue_struct {
+	pthread_mutex_t		lock;		/* locking of the workqueue */
+	pthread_cond_t		idle_cond;	/* all workers are idle cond */
+	struct threadpool	*pool;		/* underlying pool */
+	int			pool_errno;	/* latest pool error */
+	struct task_struct	task;		/* threadpool task */
+	struct list_head	busy_list;	/* busy workers */
+	struct list_head	idle_list;	/* idle workers */
+	int			msg_pipe[2];	/* main thread comm pipes */
+};
+
+static const char * const workqueue_errno_str[] = {
+	"Error creating threadpool",
+	"Error executing function in threadpool",
+	"Error stopping the threadpool",
+	"Error starting thread in the threadpool",
+	"Error sending message to worker",
+	"Error receiving message from worker",
+	"Received unexpected message from worker",
+};
+
+/**
+ * create_workqueue - create a workqueue associated to @pool
+ *
+ * The workqueue will create a threadpool on which to execute.
+ */
+struct workqueue_struct *create_workqueue(int nr_threads)
+{
+	int ret, err = 0;
+	struct workqueue_struct *wq = zalloc(sizeof(struct workqueue_struct));
+
+	if (!wq) {
+		err = -ENOMEM;
+		goto out_return;
+	}
+
+	wq->pool = threadpool__new(nr_threads);
+	if (IS_ERR(wq->pool)) {
+		err = -WORKQUEUE_ERROR__POOLNEW;
+		wq->pool_errno = PTR_ERR(wq->pool);
+		goto out_free_wq;
+	}
+
+	ret = pthread_mutex_init(&wq->lock, NULL);
+	if (ret) {
+		err = -ret;
+		goto out_delete_pool;
+	}
+
+	ret = pthread_cond_init(&wq->idle_cond, NULL);
+	if (ret) {
+		err = -ret;
+		goto out_destroy_mutex;
+	}
+
+	INIT_LIST_HEAD(&wq->busy_list);
+	INIT_LIST_HEAD(&wq->idle_list);
+
+	ret = pipe(wq->msg_pipe);
+	if (ret) {
+		err = -ENOMEM;
+		goto out_destroy_cond;
+	}
+
+	return wq;
+
+out_destroy_cond:
+	pthread_cond_destroy(&wq->idle_cond);
+out_destroy_mutex:
+	pthread_mutex_destroy(&wq->lock);
+out_delete_pool:
+	threadpool__delete(wq->pool);
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
+	char sbuf[STRERR_BUFSIZE];
+
+	if (IS_ERR_OR_NULL(wq))
+		return 0;
+
+	threadpool__delete(wq->pool);
+	wq->pool = NULL;
+
+	ret = pthread_mutex_destroy(&wq->lock);
+	if (ret) {
+		err = -ret;
+		pr_debug2("workqueue: error pthread_mutex_destroy: %s\n",
+			str_error_r(ret, sbuf, sizeof(sbuf)));
+	}
+
+	ret = pthread_cond_destroy(&wq->idle_cond);
+	if (ret) {
+		err = -ret;
+		pr_debug2("workqueue: error pthread_cond_destroy: %s\n",
+			str_error_r(ret, sbuf, sizeof(sbuf)));
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
+	const char *errno_str;
+
+	errno_str = workqueue_errno_str[-err-WORKQUEUE_ERROR__OFFSET];
+
+	switch (err) {
+	case -WORKQUEUE_ERROR__POOLNEW:
+	case -WORKQUEUE_ERROR__POOLEXE:
+	case -WORKQUEUE_ERROR__POOLSTOP:
+	case -WORKQUEUE_ERROR__POOLSTARTTHREAD:
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
index 0000000000000000..100841cc035fde1d
--- /dev/null
+++ b/tools/perf/util/workqueue/workqueue.h
@@ -0,0 +1,39 @@
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
+extern struct workqueue_struct *create_workqueue(int nr_threads);
+extern int destroy_workqueue(struct workqueue_struct *wq);
+
+extern int workqueue_nr_threads(struct workqueue_struct *wq);
+
+#define WORKQUEUE_STRERR_BUFSIZE (128+THREADPOOL_STRERR_BUFSIZE)
+#define WORKQUEUE_ERROR__OFFSET 512
+enum {
+	WORKQUEUE_ERROR__POOLNEW = WORKQUEUE_ERROR__OFFSET,
+	WORKQUEUE_ERROR__POOLEXE,
+	WORKQUEUE_ERROR__POOLSTOP,
+	WORKQUEUE_ERROR__POOLSTARTTHREAD,
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

