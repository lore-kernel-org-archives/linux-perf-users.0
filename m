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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1C9C4320A
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 332DE61156
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhHUJUl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbhHUJUg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:20:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A690CC06175F;
        Sat, 21 Aug 2021 02:19:56 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s25so4932712edw.0;
        Sat, 21 Aug 2021 02:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UPweOBnT2woI7Uc+uUSBbPPvUccUzrnaZjXAycOrk2c=;
        b=c5h/KerRO8qgqBGB1q6+xGs+jr1EsKylgxTYMDYY0tQU46xKJ4A1Wdr+ryZk4khWBW
         T/QiqhIU4JBfxa0wIXK+hTSubr4tJjAGxxMNm064v9tfOqU3Ezgye7M0V3vcSEBR9K4i
         Rnz/7kvxev+MF7Xd85rOQC59mtOIKs21+Kl3BCKbCMZX15zg2LWmm3sqwjbyle9SBTxu
         iSnmgyWJa0ATuCAmJxgI2fME6RshD2jUh3VtNECWFax0Ki60RoFI3mbc4koWSJ7CWhhm
         v2W8X0dzn1Li0pCZmp8KYtoNNkieC/JJaaw1brbEgO2WzH05s99iLLEob6xCOMkaOeeU
         Q/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UPweOBnT2woI7Uc+uUSBbPPvUccUzrnaZjXAycOrk2c=;
        b=G6VQf60Xe4wbbT08p3JtkeeFrq7rCDk+PKxsHt6iuoM5ueX0kRiZZ1zyNmZXDinq2P
         dMSuW9LH+tWoGA1qJPFC/gYw3AoJZ//4mzsHHkkr/W5f6M0a8/E/O981ZhhaO21GQ9oO
         nvXCWBxH2O+g3EUfaH3dXD/r5ygrknY7nhIvNBghzRQAW4xNOoRPhzDDABfMwFd85ZLF
         c3tdxdgBAvIFcqYXY8e2vcH50GJihkPVDskcE2h923Qk6KYyUeujOYNFf7d+XsdMmfBx
         qt3Uf05TNguAJTeUr+MI0x4bBNQhBJuSY6TDle/PWXDoIwF+Qe3KgBlCuD9Rl2f0SggC
         h71A==
X-Gm-Message-State: AOAM532oFnn0DV9QAOtfNMclZ5jJFDliTHGxa+RXm4zHXF1etId5Nylo
        THPWhXyJdzJkkgz9nQZeqZ4=
X-Google-Smtp-Source: ABdhPJzbq3JVrJCSs4Or1NUPXCNyQpTloBLqI53+S+iY5qYs58EXSrhZssmRgw4Fal/BvTmXIRvSgg==
X-Received: by 2002:a05:6402:1011:: with SMTP id c17mr26253123edu.144.1629537595194;
        Sat, 21 Aug 2021 02:19:55 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:19:54 -0700 (PDT)
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
Subject: [RFC PATCH v1 06/37] perf workqueue: add affinities to threadpool
Date:   Sat, 21 Aug 2021 11:19:12 +0200
Message-Id: <f2994f2e63e9b825a8fc483d7795bbdea02eef15.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds the possibility to set affinities to the threads in the
threadpool.
An usage of the new functions is added to the workqueue test.

This patch concludes the patches regarding the threadpool.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/tests/workqueue.c           | 87 +++++++++++++++++++++++---
 tools/perf/util/workqueue/threadpool.c | 70 +++++++++++++++++++++
 tools/perf/util/workqueue/threadpool.h |  7 +++
 3 files changed, 157 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/workqueue.c b/tools/perf/tests/workqueue.c
index 4eb14a75b6c0a3aa..738b56ec3004f742 100644
--- a/tools/perf/tests/workqueue.c
+++ b/tools/perf/tests/workqueue.c
@@ -4,6 +4,8 @@
 #include <linux/kernel.h>
 #include <linux/err.h>
 #include <linux/zalloc.h>
+#include <linux/bitmap.h>
+#include <perf/cpumap.h>
 #include "tests.h"
 #include "util/debug.h"
 #include "util/workqueue/threadpool.h"
@@ -31,6 +33,7 @@ struct test_task {
 	struct task_struct task;
 	int n_threads;
 	int *array;
+	struct mmap_cpu_mask *affinity_masks;
 };
 
 /**
@@ -54,9 +57,36 @@ static void dummy_work(int idx)
 static void test_task_fn1(int tidx, struct task_struct *task)
 {
 	struct test_task *mtask = container_of(task, struct test_task, task);
+	struct mmap_cpu_mask real_affinity_mask, *set_affinity_mask;
+	int ret;
+
+	set_affinity_mask = &mtask->affinity_masks[tidx];
+	real_affinity_mask.nbits = set_affinity_mask->nbits;
+	real_affinity_mask.bits = bitmap_alloc(real_affinity_mask.nbits);
+	if (!real_affinity_mask.bits) {
+		pr_err("ENOMEM in malloc real_affinity_mask.bits\n");
+		goto out;
+	}
+
+	ret = pthread_getaffinity_np(pthread_self(), real_affinity_mask.nbits,
+				(cpu_set_t *)real_affinity_mask.bits);
+	if (ret) {
+		pr_err("Error in pthread_getaffinity_np: %s\n", strerror(ret));
+		goto out;
+	}
+
+	if (!bitmap_equal(real_affinity_mask.bits, set_affinity_mask->bits,
+			real_affinity_mask.nbits)) {
+		pr_err("affinity mismatch!\n");
+		mmap_cpu_mask__scnprintf(set_affinity_mask, "set affinity");
+		mmap_cpu_mask__scnprintf(&real_affinity_mask, "real affinity");
+		goto out;
+	}
 
 	dummy_work(tidx);
 	mtask->array[tidx] = tidx+1;
+out:
+	bitmap_free(real_affinity_mask.bits);
 }
 
 static void test_task_fn2(int tidx, struct task_struct *task)
@@ -116,21 +146,58 @@ static int __test__threadpool(void *_args)
 {
 	struct threadpool_test_args_t *args = _args;
 	struct threadpool *pool;
+	int ret, i, nr_cpus, nr_bits, cpu;
 	struct test_task task;
 	int pool_size = args->pool_size ?: sysconf(_SC_NPROCESSORS_ONLN);
-	int i, ret = __threadpool__prepare(&pool, pool_size);
+	struct perf_cpu_map *cpumap = perf_cpu_map__new(NULL);
+	struct mmap_cpu_mask *affinity_masks;
 
-	if (ret)
-		goto out;
+	if (!cpumap) {
+		pr_err("ENOMEM in perf_cpu_map__new\n");
+		return TEST_FAIL;
+	}
+
+	nr_cpus = perf_cpu_map__nr(cpumap);
+	nr_bits = BITS_TO_LONGS(nr_cpus) * sizeof(unsigned long);
+
+	affinity_masks = calloc(pool_size, sizeof(*affinity_masks));
+	if (!affinity_masks) {
+		pr_err("ENOMEM in calloc affinity_masks\n");
+		ret = TEST_FAIL;
+		goto out_put_cpumap;
+	}
+
+	for (i = 0; i < pool_size; i++) {
+		affinity_masks[i].nbits = nr_bits;
+		affinity_masks[i].bits = bitmap_alloc(nr_cpus);
+		if (!affinity_masks[i].bits) {
+			ret = TEST_FAIL;
+			goto out_free_affinity_masks;
+		}
+		bitmap_zero(affinity_masks[i].bits, affinity_masks[i].nbits);
+		cpu = perf_cpu_map__cpu(cpumap, i % nr_cpus);
+		test_and_set_bit(cpu, affinity_masks[i].bits);
+	}
 
 	task.task.fn = test_task_fn1;
 	task.n_threads = pool_size;
+	task.affinity_masks = affinity_masks;
 	task.array = calloc(pool_size, sizeof(*task.array));
 	TEST_ASSERT_VAL("calloc failure", task.array);
 
+	ret = __threadpool__prepare(&pool, pool_size);
+	if (ret)
+		goto out_free_tasks;
+
+	ret = threadpool__set_affinities(pool, task.affinity_masks);
+	if (ret) {
+		ret = TEST_FAIL;
+		goto out_free_tasks;
+	}
+
 	ret = __threadpool__exec_wait(pool, &task.task);
 	if (ret)
-		goto out;
+		goto out_free_tasks;
 
 	for (i = 0; i < pool_size; i++)
 		TEST_ASSERT_VAL("failed array check (1)", task.array[i] == i+1);
@@ -139,17 +206,23 @@ static int __test__threadpool(void *_args)
 
 	ret = __threadpool__exec_wait(pool, &task.task);
 	if (ret)
-		goto out;
+		goto out_free_tasks;
 
 	for (i = 0; i < pool_size; i++)
 		TEST_ASSERT_VAL("failed array check (2)", task.array[i] == 2*i);
 
 	ret = __threadpool__teardown(pool);
 	if (ret)
-		goto out;
+		goto out_free_tasks;
 
-out:
+out_free_tasks:
 	free(task.array);
+out_free_affinity_masks:
+	for (i = 0; i < pool_size; i++)
+		bitmap_free(affinity_masks[i].bits);
+	free(affinity_masks);
+out_put_cpumap:
+	perf_cpu_map__put(cpumap);
 	return ret;
 }
 
diff --git a/tools/perf/util/workqueue/threadpool.c b/tools/perf/util/workqueue/threadpool.c
index 44bcbe4fa3d2d026..bf4ebc394b9bc705 100644
--- a/tools/perf/util/workqueue/threadpool.c
+++ b/tools/perf/util/workqueue/threadpool.c
@@ -13,7 +13,9 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <pthread.h>
+#include <linux/bitmap.h>
 #include <internal/lib.h>
+#include "util/mmap.h"
 #include "threadpool.h"
 
 #ifndef HAVE_GETTID
@@ -39,6 +41,7 @@ struct threadpool_entry {
 		int cmd[2];			/* messages to thread (commands) */
 	} pipes;
 	bool				running; /* has this thread been started? */
+	struct mmap_cpu_mask		affinity_mask;
 };
 
 enum threadpool_msg {
@@ -255,6 +258,16 @@ static int threadpool_entry__recv_cmd(struct threadpool_entry *thread,
 	return 0;
 }
 
+/**
+ * threadpool_entry__apply_affinity - apply @thread->affinity
+ */
+static int threadpool_entry__apply_affinity(struct threadpool_entry *thread)
+{
+	return -pthread_setaffinity_np(thread->ptid,
+			MMAP_CPU_MASK_BYTES(&thread->affinity_mask),
+			(cpu_set_t *)(thread->affinity_mask.bits));
+}
+
 /**
  * threadpool_entry__function - function running on thread
  *
@@ -339,6 +352,7 @@ struct threadpool *threadpool__new(int n_threads)
 		pool->threads[t].ptid = 0;
 		pool->threads[t].pool = pool;
 		pool->threads[t].running = false;
+		// affinity is set to zero due to calloc
 		threadpool_entry__init_pipes(&pool->threads[t]);
 	}
 
@@ -414,6 +428,7 @@ void threadpool__delete(struct threadpool *pool)
 	for (t = 0; t < pool->nr_threads; t++) {
 		thread = &pool->threads[t];
 		threadpool_entry__close_pipes(thread);
+		bitmap_free(thread->affinity_mask.bits);
 	}
 
 	zfree(&pool->threads);
@@ -455,6 +470,16 @@ int threadpool__start_thread(struct threadpool *pool, int tidx)
 	pthread_attr_init(&attrs);
 	pthread_attr_setdetachstate(&attrs, PTHREAD_CREATE_DETACHED);
 
+	if (thread->affinity_mask.bits) {
+		ret = pthread_attr_setaffinity_np(&attrs,
+				MMAP_CPU_MASK_BYTES(&thread->affinity_mask),
+				(cpu_set_t *)(thread->affinity_mask.bits));
+		if (ret) {
+			err = -ret;
+			goto out;
+		}
+	}
+
 	ret = pthread_create(&thread->ptid, &attrs, threadpool_entry__function, thread);
 	if (ret) {
 		err = -ret;
@@ -617,3 +642,48 @@ bool threadpool__is_busy(struct threadpool *pool)
 {
 	return pool->current_task;
 }
+
+/**
+ * threadpool__set_affinity - set @affinity of the @tid thread in @pool
+ *
+ * If threadpool is not running affinity will be set on start.
+ * If threadpool is running, affinity is immediately set.
+ *
+ * This function can be called from any thread.
+ */
+int threadpool__set_affinity(struct threadpool *pool, int tid,
+				struct mmap_cpu_mask *affinity)
+{
+	struct threadpool_entry *thread = &pool->threads[tid];
+	int ret = mmap_cpu_mask__duplicate(affinity, &thread->affinity_mask);
+
+	if (ret)
+		return ret;
+
+	if (thread->running)
+		return threadpool_entry__apply_affinity(thread);
+	else
+		return 0;
+}
+
+/**
+ * threadpool__set_affinities - set @affinities of all threads in @pool
+ *
+ * If threadpool is not running, affinities will be set on start.
+ * If threadpool is running, affinities are immediately set.
+ *
+ * This function can be called from any thread.
+ */
+int threadpool__set_affinities(struct threadpool *pool,
+				struct mmap_cpu_mask *affinities)
+{
+	int i, ret;
+
+	for (i = 0; i < pool->nr_threads; i++) {
+		ret = threadpool__set_affinity(pool, i, &affinities[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/tools/perf/util/workqueue/threadpool.h b/tools/perf/util/workqueue/threadpool.h
index 9a6081cef8af95e0..21fbfb57b00e2906 100644
--- a/tools/perf/util/workqueue/threadpool.h
+++ b/tools/perf/util/workqueue/threadpool.h
@@ -2,6 +2,8 @@
 #ifndef __WORKQUEUE_THREADPOOL_H
 #define __WORKQUEUE_THREADPOOL_H
 
+#include "util/mmap.h"
+
 struct threadpool;
 struct task_struct;
 
@@ -25,6 +27,11 @@ extern int threadpool__size(struct threadpool *pool);
 extern bool threadpool__is_running(struct threadpool *pool);
 extern bool threadpool__is_busy(struct threadpool *pool);
 
+extern int threadpool__set_affinities(struct threadpool *pool,
+				struct mmap_cpu_mask *affinities);
+extern int threadpool__set_affinity(struct threadpool *pool, int tid,
+				struct mmap_cpu_mask *affinity);
+
 /* Error management */
 #define THREADPOOL_STRERR_BUFSIZE (128+STRERR_BUFSIZE)
 #define THREADPOOL_ERROR__OFFSET 512
-- 
2.31.1

