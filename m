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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98531C11F66
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 12:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81CE761249
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 12:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbhGMMOf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 08:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbhGMMOb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 08:14:31 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E75C0613EE;
        Tue, 13 Jul 2021 05:11:41 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso2176205wmj.4;
        Tue, 13 Jul 2021 05:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wrfAS+mMRUT8LDRtdpJEqZr/ZEkXHQf7XdSey0KQIRo=;
        b=F7imLOfGlCdtb+j2z+c+J1wsEKV7Ru8sdxwG9HsbE0j2riS1z/tn7KsqwvpZD+vObH
         tpY5yHqiV0eNybuZ+hASu8y4LB/vB1qyDsOupmx9qaPaZvNl2nCNRnRlst3SzR87dnFA
         pyETt7jD8C6o55qvM/GE67hV4rsLrwOgzFq0rEBZJskWtknWR4PoS7bP53WDnUhISe5k
         uB9n+4cSuhbZIBAYfZIAg3TQhnevCO3mbmC93OlVmajj6VUw8eUbwnIM8n+2qjxB3Q2y
         awksjjLDVsdvJ+rT5UhMb5NBNsDEyCyqpPiHkSpfSoeDHigkV6ZV5emMwLbpSBGseXb6
         OkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wrfAS+mMRUT8LDRtdpJEqZr/ZEkXHQf7XdSey0KQIRo=;
        b=lAkO9yG7rJKnoJ67waakm3jC5f1s49E6KMTByrCN+6MTuHUZFnn7Rgz2XQWisL9Fkn
         /WG0M6msLBaSXXlHhxR3epxCKfBpdMx5TrjZCXpjM/XAz6uKc+JHPxo0KhtG9s2r4QP6
         tbdzEab+UFOJLcnPqwQMFumBQN5OCxVjGFIdFdxOtn93eJW1jZS6lxbU5emXj5Ngt1zF
         OYVnQquqaz9Pzx7em1XwCeXXVXDKCzIROjjL2J1G3BWw0KsOduUU4qsUtE8AEqz8un2k
         m6rd80yAJwTxben5uXclAUJ7Bw1ZxgT3Bu21m2Mbr5OsSpfLDYbZWRW6S6PbrxkpCb99
         dhJA==
X-Gm-Message-State: AOAM531DALqNhqrOO4yQMLJcTGbGvjFIcD4t0DyLRNP/0w2LsaHQm+N6
        tIOpiby+/3EuMZ84oRATGBg=
X-Google-Smtp-Source: ABdhPJy047TsRJBGd/1GkKHej2jtsTHzHQg5LPraCNUi8uN4tPNTjgjDX1HibgK7/fkX9i2UDQDqUQ==
X-Received: by 2002:a1c:a58b:: with SMTP id o133mr4740824wme.160.1626178299975;
        Tue, 13 Jul 2021 05:11:39 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id o3sm17551425wrw.56.2021.07.13.05.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 05:11:39 -0700 (PDT)
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
Subject: [RFC PATCH 09/10] perf workqueue: add utility to execute a for loop in parallel
Date:   Tue, 13 Jul 2021 14:11:20 +0200
Message-Id: <68bbee1a8235ce83e85605138b7dffebe6554331.1626177381.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626177381.git.rickyman7@gmail.com>
References: <cover.1626177381.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds the parallel_for which executes a given function inside
the workqueue, taking care of managing the work items.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/tests/workqueue.c          |  84 +++++++++++++++++
 tools/perf/util/workqueue/workqueue.c | 125 ++++++++++++++++++++++++++
 tools/perf/util/workqueue/workqueue.h |   7 ++
 3 files changed, 216 insertions(+)

diff --git a/tools/perf/tests/workqueue.c b/tools/perf/tests/workqueue.c
index f71a839d5752d224..462a17904f2858db 100644
--- a/tools/perf/tests/workqueue.c
+++ b/tools/perf/tests/workqueue.c
@@ -19,6 +19,12 @@ struct workqueue_test_args_t {
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
@@ -265,6 +271,44 @@ static int __test__workqueue(void *_args)
 	return 0;
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
+	struct threadpool_struct *pool;
+	struct workqueue_struct *wq;
+	int ret, i;
+	int *array;
+
+	array = calloc(args->n_work_items, sizeof(*array));
+
+	ret = __workqueue__prepare(&pool, &wq, args->pool_size);
+	if (ret)
+		return ret;
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
+		return ret;
+
+	free(array);
+
+	return 0;
+}
+
 static const struct threadpool_test_args_t threadpool_test_args[] = {
 	{
 		.pool_size = 1
@@ -310,6 +354,39 @@ static const struct workqueue_test_args_t workqueue_test_args[] = {
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
@@ -332,6 +409,13 @@ static struct test_case workqueue_testcase_table[] = {
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
index 20d196de9500d369..e69ed1568228a261 100644
--- a/tools/perf/util/workqueue/workqueue.c
+++ b/tools/perf/util/workqueue/workqueue.c
@@ -515,3 +515,128 @@ void init_work(struct work_struct *work)
 {
 	INIT_LIST_HEAD(&work->entry);
 }
+
+/* Parallel-for utility */
+
+#define ceil_div(a, b) (((a)+(b)-1)/(b))
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
+	int err = 0;
+
+	if (work_size <= 0) {
+		pr_err("workqueue parallel-for: work_size must be >0\n");
+		return -EINVAL;
+	}
+
+	if (to < from) {
+		pr_err("workqueue parallel-for: to must be >= from\n");
+		return -EINVAL;
+	} else if (to == from) {
+		pr_info("workqueue parallel-for: skip since from == to\n");
+		return 0;
+	}
+
+	n_work_items = ceil_div(n, work_size);
+	if (n_work_items < nr_threads)
+		n_work_items = min(n, nr_threads);
+
+	pfw_array = calloc(n_work_items, sizeof(*pfw_array));
+
+	num_per_item = n / n_work_items;
+	m = n % n_work_items;
+
+	for (i = 0; i < m; i++) {
+		num = num_per_item + 1;
+		start = i * num;
+		init_parallel_for_work(&pfw_array[i], func, args, start, num);
+		err = queue_work(wq, &pfw_array[i].work);
+		if (err)
+			goto out;
+	}
+	if (i != 0)
+		base = pfw_array[i-1].start + pfw_array[i-1].num;
+	else
+		base = 0;
+	for (j = i; j < n_work_items; j++) {
+		num = num_per_item;
+		start = base + (j - i) * num;
+		init_parallel_for_work(&pfw_array[j], func, args, start, num);
+		err = queue_work(wq, &pfw_array[j].work);
+		if (err)
+			goto out;
+	}
+
+out:
+	err = flush_workqueue(wq);
+
+	free(pfw_array);
+	return err;
+}
diff --git a/tools/perf/util/workqueue/workqueue.h b/tools/perf/util/workqueue/workqueue.h
index 719bd0e5fb0ce7b7..409acacbdba9e60d 100644
--- a/tools/perf/util/workqueue/workqueue.h
+++ b/tools/perf/util/workqueue/workqueue.h
@@ -28,4 +28,11 @@ extern int flush_workqueue(struct workqueue_struct *wq);
 
 extern void init_work(struct work_struct *work);
 
+/* parallel_for utility */
+
+typedef void (*parallel_for_func_t)(int i, void *args);
+
+extern int parallel_for(struct workqueue_struct *wq, int from, int to, int work_size,
+			parallel_for_func_t func, void *args);
+
 #endif /* __WORKQUEUE_WORKQUEUE_H */
-- 
2.31.1

