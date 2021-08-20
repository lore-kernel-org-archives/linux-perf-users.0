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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA277C432BE
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93EEC60FDA
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239932AbhHTKzb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238990AbhHTKzN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Aug 2021 06:55:13 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56035C061760;
        Fri, 20 Aug 2021 03:54:30 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v2so13364491edq.10;
        Fri, 20 Aug 2021 03:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iokw2ce7L4IVlWZyPnyKWhzFSLlCvIOWDAz9armKv8Q=;
        b=jdlx7dj4hsHljPpipZkgxfQROtrDXf2pW8/kdOzU2zjCGpONjCkzgdrS0ybOk5QOhT
         SYyBzvuplNvGWqRVqSWZs15WA8PAIQp6XtMacMF8JmBOXrK0jLK2vE0UZc88ThLQx0nU
         b3ksZ724coqrJs4zwg/xx96heHqrUfFS4mIf1fCt7cIlhTyDJvxecVfHGWWJ3ElNjAIt
         MXv+TEAQh23z1VuCoh/KYzmIEqrLoLU1lvZzCOQmUr2YLihXXTBtYLK2WuVkQdyIUZnO
         1+i5/MFrkITqF0fZG3PDEvOgJ+YkhPjj8WqMUVdhGeBAOSqWnHs+yCKEXZcOJrqoKHbK
         LCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iokw2ce7L4IVlWZyPnyKWhzFSLlCvIOWDAz9armKv8Q=;
        b=YjkCE7U3BUrTiEvGXFsz0mJWBTckV07gPv0q+1R5kAIS6qDMCe5KROPjzv2HOLH+Rf
         /ncx8eUwhksyeqtVh3PnGk1M8HFRVGUhyyX/4CgVA9Zp9W7RQHMKGUX7u5dyOEkJ+L1G
         MrD+PfFbPeWY5kcu0Pfg33N3AZytSx4SP3htZnBGDMpjCDvaCROJ5vhO9RtcvWBWe23g
         gcuoL85S8JRJ+90MqD/Hgpj6aYt9Aq+6imaJOuhVq9aWlktwd+sHWcKkAmpoN+bqhwAX
         QKq4JKHZTszZQKNLx6W1khunU/pf86y64aVcycS2FoiM98/xtGPC+lY+l6dzFW4hwIyZ
         4RCQ==
X-Gm-Message-State: AOAM531t4bTMo0bF1rjKDYCk5FLim7DFICL/XyXQpyezvJbjvKtiogxP
        VKjwQjLHyuS+D1Ws/iwNWeo=
X-Google-Smtp-Source: ABdhPJx0HWeoImjOZfsf5fku5obTVfPVW923O+OX4FnWsyyloeFoqlmXgUiX1M/4YcnbR3++NVWmDg==
X-Received: by 2002:a05:6402:52:: with SMTP id f18mr21400109edu.338.1629456868712;
        Fri, 20 Aug 2021 03:54:28 -0700 (PDT)
Received: from honeypot.epfl.ch (mob-176-243-199-7.net.vodafone.it. [176.243.199.7])
        by smtp.googlemail.com with ESMTPSA id g29sm3451459edf.31.2021.08.20.03.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 03:54:28 -0700 (PDT)
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
Subject: [RFC PATCH v3 11/15] perf workqueue: add utility to execute a for loop in parallel
Date:   Fri, 20 Aug 2021 12:53:57 +0200
Message-Id: <93671f25b9b65d6dd6f3760fa5ef91e391fac69b.1629454773.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629454773.git.rickyman7@gmail.com>
References: <cover.1629454773.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds the parallel_for which executes a given function inside
the workqueue, taking care of managing the work items.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/tests/workqueue.c          |  89 +++++++++++++++++
 tools/perf/util/workqueue/workqueue.c | 135 ++++++++++++++++++++++++++
 tools/perf/util/workqueue/workqueue.h |   7 ++
 3 files changed, 231 insertions(+)

diff --git a/tools/perf/tests/workqueue.c b/tools/perf/tests/workqueue.c
index 194bab2f3f668ce9..4eb14a75b6c0a3aa 100644
--- a/tools/perf/tests/workqueue.c
+++ b/tools/perf/tests/workqueue.c
@@ -21,6 +21,12 @@ struct workqueue_test_args_t {
 	int n_work_items;
 };
 
+struct parallel_for_test_args_t {
+	int pool_size;
+	int n_work_items;
+	int work_size;
+};
+
 struct test_task {
 	struct task_struct task;
 	int n_threads;
@@ -253,6 +259,44 @@ static int __test__workqueue(void *_args)
 	return ret;
 }
 
+static void test_pfw_fn(int i, void *args)
+{
+	int *array = args;
+
+	dummy_work(i);
+	array[i] = i+1;
+}
+
+static int __test__parallel_for(void *_args)
+{
+	struct parallel_for_test_args_t *args = _args;
+	struct workqueue_struct *wq;
+	int ret, i, pool_size = args->pool_size ?: sysconf(_SC_NPROCESSORS_ONLN);
+	int *array = calloc(args->n_work_items, sizeof(*array));
+
+	TEST_ASSERT_VAL("calloc array failure", array);
+
+	ret = __workqueue__prepare(&wq, pool_size);
+	if (ret)
+		goto out;
+
+	ret = parallel_for(wq, 0, args->n_work_items, args->work_size,
+				test_pfw_fn, array);
+	TEST_ASSERT_VAL("parallel_for failure", ret == 0);
+
+	for (i = 0; i < args->n_work_items; i++)
+		TEST_ASSERT_VAL("failed array check", array[i] == i+1);
+
+	ret = __workqueue__teardown(wq);
+	if (ret)
+		goto out;
+
+out:
+	free(array);
+
+	return TEST_OK;
+}
+
 static const struct threadpool_test_args_t threadpool_test_args[] = {
 	{
 		.pool_size = 1
@@ -305,6 +349,44 @@ static const struct workqueue_test_args_t workqueue_test_args[] = {
 	}
 };
 
+static const struct parallel_for_test_args_t parallel_for_test_args[] = {
+	{
+		.pool_size = 1,
+		.n_work_items = 1,
+		.work_size = 1
+	},
+	{
+		.pool_size = 1,
+		.n_work_items = 10,
+		.work_size = 3
+	},
+	{
+		.pool_size = 2,
+		.n_work_items = 1,
+		.work_size = 1
+	},
+	{
+		.pool_size = 2,
+		.n_work_items = 100,
+		.work_size = 10
+	},
+	{
+		.pool_size = 16,
+		.n_work_items = 7,
+		.work_size = 2
+	},
+	{
+		.pool_size = 16,
+		.n_work_items = 2789,
+		.work_size = 16
+	},
+	{
+		.pool_size = 0,	// sysconf(_SC_NPROCESSORS_ONLN)
+		.n_work_items = 8191,
+		.work_size = 17
+	}
+};
+
 struct test_case {
 	const char *desc;
 	int (*func)(void *args);
@@ -327,6 +409,13 @@ static struct test_case workqueue_testcase_table[] = {
 		.args = (void *) workqueue_test_args,
 		.n_args = (int)ARRAY_SIZE(workqueue_test_args),
 		.arg_size = sizeof(struct workqueue_test_args_t)
+	},
+	{
+		.desc = "Workqueue parallel-for",
+		.func = __test__parallel_for,
+		.args = (void *) parallel_for_test_args,
+		.n_args = (int)ARRAY_SIZE(parallel_for_test_args),
+		.arg_size = sizeof(struct parallel_for_test_args_t)
 	}
 };
 
diff --git a/tools/perf/util/workqueue/workqueue.c b/tools/perf/util/workqueue/workqueue.c
index a89370e68bd720c8..7daac65abb5d57d1 100644
--- a/tools/perf/util/workqueue/workqueue.c
+++ b/tools/perf/util/workqueue/workqueue.c
@@ -9,6 +9,7 @@
 #include <linux/err.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
+#include <linux/kernel.h>
 #include "debug.h"
 #include <internal/lib.h>
 #include "workqueue.h"
@@ -764,3 +765,137 @@ void init_work(struct work_struct *work)
 {
 	INIT_LIST_HEAD(&work->entry);
 }
+
+/* Parallel-for utility */
+
+struct parallel_for_work {
+	struct work_struct work;	/* work item that is queued */
+	parallel_for_func_t func;	/* function to execute for each item */
+	void *args;			/* additional args to pass to func */
+	int start;			/* first item to execute */
+	int num;			/* number of items to execute */
+};
+
+/**
+ * parallel_for_work_fn - execute parallel_for_work.func in parallel
+ *
+ * This function will be executed by workqueue's workers.
+ */
+static void parallel_for_work_fn(struct work_struct *work)
+{
+	struct parallel_for_work *pfw = container_of(work, struct parallel_for_work, work);
+	int i;
+
+	for (i = 0; i < pfw->num; i++)
+		pfw->func(pfw->start+i, pfw->args);
+}
+
+static inline void init_parallel_for_work(struct parallel_for_work *pfw,
+					parallel_for_func_t func, void *args,
+					int start, int num)
+{
+	init_work(&pfw->work);
+	pfw->work.func = parallel_for_work_fn;
+	pfw->func = func;
+	pfw->args = args;
+	pfw->start = start;
+	pfw->num = num;
+
+	pr_debug2("pfw: start=%d, num=%d\n", start, num);
+}
+
+/**
+ * parallel_for - execute @func in parallel over indexes between @from and @to
+ * @wq: workqueue that will run @func in parallel
+ * @from: first index
+ * @to: last index (excluded)
+ * @work_size: number of indexes to handle on the same work item.
+ *             ceil((to-from)/work_size) work items will be added to @wq
+ *             NB: this is only a hint. The function will reduce the size of
+ *                 the work items to fill all workers.
+ * @func: function to execute in parallel
+ * @args: additional arguments to @func
+ *
+ * This function is equivalent to:
+ * for (i = from; i < to; i++) {
+ *     // parallel
+ *     func(i, args);
+ * }
+ * // sync
+ *
+ * This function takes care of:
+ *  - creating balanced work items to submit to workqueue
+ *  - submitting the work items to the workqueue
+ *  - waiting for completion of the work items
+ *  - cleanup of the work items
+ */
+int parallel_for(struct workqueue_struct *wq, int from, int to, int work_size,
+		parallel_for_func_t func, void *args)
+{
+	int n = to-from;
+	int n_work_items;
+	int nr_threads = workqueue_nr_threads(wq);
+	int i, j, start, num, m, base, num_per_item;
+	struct parallel_for_work *pfw_array;
+	int ret, err = 0;
+
+	if (work_size <= 0) {
+		pr_debug("workqueue parallel-for: work_size must be >0\n");
+		return -EINVAL;
+	}
+
+	if (to < from) {
+		pr_debug("workqueue parallel-for: to must be >= from\n");
+		return -EINVAL;
+	} else if (to == from) {
+		pr_debug2("workqueue parallel-for: skip since from == to\n");
+		return 0;
+	}
+
+	n_work_items = DIV_ROUND_UP(n, work_size);
+	if (n_work_items < nr_threads)
+		n_work_items = min(n, nr_threads);
+
+	pfw_array = calloc(n_work_items, sizeof(*pfw_array));
+
+	if (!pfw_array) {
+		pr_debug2("%s: error allocating pfw_array\n", __func__);
+		return -ENOMEM;
+	}
+
+	num_per_item = n / n_work_items;
+	m = n % n_work_items;
+
+	for (i = 0; i < m; i++) {
+		num = num_per_item + 1;
+		start = i * num;
+		init_parallel_for_work(&pfw_array[i], func, args, start, num);
+		ret = queue_work(wq, &pfw_array[i].work);
+		if (ret) {
+			err = ret;
+			goto out;
+		}
+	}
+	if (i != 0)
+		base = pfw_array[i-1].start + pfw_array[i-1].num;
+	else
+		base = 0;
+	for (j = i; j < n_work_items; j++) {
+		num = num_per_item;
+		start = base + (j - i) * num;
+		init_parallel_for_work(&pfw_array[j], func, args, start, num);
+		ret = queue_work(wq, &pfw_array[j].work);
+		if (ret) {
+			err = ret;
+			goto out;
+		}
+	}
+
+out:
+	ret = flush_workqueue(wq);
+	if (ret)
+		err = ret;
+
+	free(pfw_array);
+	return err;
+}
diff --git a/tools/perf/util/workqueue/workqueue.h b/tools/perf/util/workqueue/workqueue.h
index fc6166757f0e1d0d..7a0eda923df25d85 100644
--- a/tools/perf/util/workqueue/workqueue.h
+++ b/tools/perf/util/workqueue/workqueue.h
@@ -30,6 +30,13 @@ extern int flush_workqueue(struct workqueue_struct *wq);
 
 extern void init_work(struct work_struct *work);
 
+/* parallel_for utility */
+
+typedef void (*parallel_for_func_t)(int i, void *args);
+
+extern int parallel_for(struct workqueue_struct *wq, int from, int to, int work_size,
+			parallel_for_func_t func, void *args);
+
 /* Global workqueue */
 
 extern struct workqueue_struct *global_wq;
-- 
2.31.1

