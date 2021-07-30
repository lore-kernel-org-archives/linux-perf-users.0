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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2D6C00143
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 15:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85B3C610A7
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 15:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239656AbhG3PhF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jul 2021 11:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbhG3PfK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jul 2021 11:35:10 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EA0C0617A5;
        Fri, 30 Jul 2021 08:34:32 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m19so6264655wms.0;
        Fri, 30 Jul 2021 08:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DiU4yRcNOdWDq4BWk98gOqWXUckfx2ed1HrWex0FO38=;
        b=Nk0buua+26yIS0TH3Vg6HyAsV1z/GXO/QG0TQJJNvMHFyRragVzdqD3mu/Yvh0OKvY
         YcPjVx40JptaPT/cUGQWaNtnxYROBZo7IsIcqfDZfLlOmMOmlVXoPcjMcP86iPjct/6T
         HPLGcOUpXI+tozI3AjjbaWP4goNxctrqsOMNxMKh7dKIP5BeY/bGoOzDDA+6erLWHzi5
         ytUYIV7dkQWxWhzDLWUx8L5WdYwJtv0sU+odJ11Q8obTkGsnriOg7px6viLofiDS6VwD
         mXi9eBED03FoJr+85vp9aVSgZYV80Gi+yuKKX2rOPz224LLgt9MUpzAsBFRK7+r1GEzt
         KEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DiU4yRcNOdWDq4BWk98gOqWXUckfx2ed1HrWex0FO38=;
        b=Hs7CUnOFcyzOL63XcezkQGBnoOhRWk1M2eutumnp1eph1+X5oVkTXSxtdNHZg0dluS
         yXkstha0HZxVO7Rc/zJwB/JDR1tsXwEmYYHmjQzMM/57LUYne3fvABp4Xqs+8Y2AJK4H
         RphyNYzCcquJhqK76bhxGgufAUttUwYapftnupt2GbNbvHDvZ3pwOU0yEVhLMzaHG8IN
         jKMZ7nRVSWH6YPurmnTokg6HS43z5OYCEqc1twG4B0pPnEhNf5tbxyYQbQPdrdl6okJC
         NVmwi8VyiyApviLc6WzeAaUz46nfXDZOd9jZecv+NfbRlLyNMm5ZHnTfthsP84mkHoWv
         FwIA==
X-Gm-Message-State: AOAM533ZpzC2f2WlxgiUfB3yddEdllZbZLxe2gPlyoP+Www+fOWhQ29K
        8xsiookX6rdGCncwesKCCio=
X-Google-Smtp-Source: ABdhPJzyHT6O7b1Gk3h84CVc/HbXU7CAh6uiTZJyPYLMD3J7zrUfay5lGWjOBYXWe7WWn21rNb2TpQ==
X-Received: by 2002:a1c:730d:: with SMTP id d13mr3769100wmb.129.1627659270795;
        Fri, 30 Jul 2021 08:34:30 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id v15sm2354727wmj.39.2021.07.30.08.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 08:34:30 -0700 (PDT)
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
Subject: [RFC PATCH v2 09/10] perf workqueue: add utility to execute a for loop in parallel
Date:   Fri, 30 Jul 2021 17:34:16 +0200
Message-Id: <2f6460a1be78c01b6c983314416f5bcc7ef602c6.1627657061.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627657061.git.rickyman7@gmail.com>
References: <cover.1627657061.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds the parallel_for which executes a given function inside
the workqueue, taking care of managing the work items.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/tests/workqueue.c          |  85 ++++++++++++++++
 tools/perf/util/workqueue/workqueue.c | 135 ++++++++++++++++++++++++++
 tools/perf/util/workqueue/workqueue.h |   7 ++
 3 files changed, 227 insertions(+)

diff --git a/tools/perf/tests/workqueue.c b/tools/perf/tests/workqueue.c
index 2488ee971877b1f0..258fc0196a55c407 100644
--- a/tools/perf/tests/workqueue.c
+++ b/tools/perf/tests/workqueue.c
@@ -20,6 +20,12 @@ struct workqueue_test_args_t {
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
@@ -261,6 +267,45 @@ static int __test__workqueue(void *_args)
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
+	struct threadpool *pool;
+	struct workqueue_struct *wq;
+	int ret, i;
+	int *array = calloc(args->n_work_items, sizeof(*array));
+
+	TEST_ASSERT_VAL("calloc array failure", array);
+
+	ret = __workqueue__prepare(&pool, &wq, args->pool_size);
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
+	ret = __workqueue__teardown(pool, wq);
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
@@ -306,6 +351,39 @@ static const struct workqueue_test_args_t workqueue_test_args[] = {
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
+	}
+};
+
 struct test_case {
 	const char *desc;
 	int (*func)(void *args);
@@ -328,6 +406,13 @@ static struct test_case workqueue_testcase_table[] = {
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
index a32d62dac1ec04a6..7f45b1e264ed6145 100644
--- a/tools/perf/util/workqueue/workqueue.c
+++ b/tools/perf/util/workqueue/workqueue.c
@@ -8,6 +8,7 @@
 #include <linux/list.h>
 #include <linux/err.h>
 #include <linux/string.h>
+#include <linux/kernel.h>
 #include "debug.h"
 #include <internal/lib.h>
 #include "workqueue.h"
@@ -613,3 +614,137 @@ void init_work(struct work_struct *work)
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
index ec998291b6a0623d..6185f4ca0f662dcb 100644
--- a/tools/perf/util/workqueue/workqueue.h
+++ b/tools/perf/util/workqueue/workqueue.h
@@ -28,6 +28,13 @@ extern int flush_workqueue(struct workqueue_struct *wq);
 
 extern void init_work(struct work_struct *work);
 
+/* parallel_for utility */
+
+typedef void (*parallel_for_func_t)(int i, void *args);
+
+extern int parallel_for(struct workqueue_struct *wq, int from, int to, int work_size,
+			parallel_for_func_t func, void *args);
+
 #define WORKQUEUE_STRERR_BUFSIZE (128+THREADPOOL_STRERR_BUFSIZE)
 #define WORKQUEUE_ERROR__OFFSET 512
 enum {
-- 
2.31.1

