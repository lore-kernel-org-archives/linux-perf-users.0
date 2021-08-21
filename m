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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA88AC432BE
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A0B61156
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbhHUJUw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbhHUJUk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:20:40 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C786C0617AE;
        Sat, 21 Aug 2021 02:19:59 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id bo19so17594840edb.9;
        Sat, 21 Aug 2021 02:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cjZ7uJNpZLE3J25Q91QvoDOYEkRc1avEONuCIWmN21s=;
        b=k7f6w18PjhT3tPUNqSh13BKbvmzhsemBAn2Yv31MYOaF1P09K+9A5g9grlZJ3GgeXm
         FOvin/FqkPFeWlWH6FbtwbaX3FDcLvIkGOlkCgldeyhiMMZ/lQremK/bjpN8vUepBLcq
         W0ejf7EGc5goNcUqLa20UrLSG90CKQeAVhzehICzFuRcMFbZUbgPGU+K5SsDt9EQAcOM
         9P/nIkDQpl5YAUSBYyoyFNO3mZIB3P+lLVnzdsywopM/mki2jUDyRWg/cX/V++ZEcVP4
         z5gJLP4nMCe01meDXDdQ8zDaH/P/9QRSeiiokPCjCIyXGoKeBMWK1JhYyf5yzMioDVze
         n1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cjZ7uJNpZLE3J25Q91QvoDOYEkRc1avEONuCIWmN21s=;
        b=XzxQtyDI6nsdA8d3d+pKfM4ip3HN/Gr5fhNuum31XmGA/4OWZWe2i6GOEk1Di7rb13
         a+5kaU32SNRmsNqUfKsgsKZwO7eMh8+hrKlW1Kg24DJO4dEUUfRozQRp125d2qPG3P9x
         Cqn9z6+QQFyD4HxX32kTqeg+RGcdgT1PMHy1gbtczde/5jOWHTZ8Par6upxXW4JbeUDq
         qORf3vPjbvCavmuvt3CL0lIszbVfPqTe3TL93T14BaIFnm0QsMdDiw48O8/nHM+tbNQ9
         CWbYAAxNqbmMqp51aT0ZiqlMpZ62eHvLYPOal2hyCd1sYobC2ksg4QRHqSiZLzs/1DVE
         dVHg==
X-Gm-Message-State: AOAM5308mSU3U+DxSlFN+B3pb2z6W41UN1JHARhhFWCqOKM+GBGkmWxP
        1RZnjHg4hMOdK5EXDXFpQLE=
X-Google-Smtp-Source: ABdhPJwk6TExhFuuAKA+/Mj774+d3h051lTRiB9fbjHzh6HqntG9xKsFHTnbK0v17l/ePBCXcsYayw==
X-Received: by 2002:a05:6402:52:: with SMTP id f18mr26541861edu.338.1629537597915;
        Sat, 21 Aug 2021 02:19:57 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:19:57 -0700 (PDT)
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
Subject: [RFC PATCH v1 08/37] perf workqueue: add method to execute work on specific CPU
Date:   Sat, 21 Aug 2021 11:19:14 +0200
Message-Id: <fc51bfc206cd5976eec14541fc5ee50ce6788818.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds the possibility to schedule a work item on a specific
CPU.
There are 2 possibilities:
 - threads are pinned to a CPU using the new functions
   workqueue_set_affinity_cpu and workqueue_set_affinities_cpu
 - no thread is pinned to the requested cpu. In this case, affinity will
   be set before (and cleared after) executing the work.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/workqueue/workqueue.c | 133 +++++++++++++++++++++++++-
 tools/perf/util/workqueue/workqueue.h |  12 +++
 2 files changed, 144 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/workqueue/workqueue.c b/tools/perf/util/workqueue/workqueue.c
index 61f1b6c41deba031..650170a6a11f56bd 100644
--- a/tools/perf/util/workqueue/workqueue.c
+++ b/tools/perf/util/workqueue/workqueue.c
@@ -10,9 +10,12 @@
 #include <linux/string.h>
 #include <linux/zalloc.h>
 #include <linux/kernel.h>
+#include <linux/bitmap.h>
 #include "debug.h"
 #include <internal/lib.h>
 #include "workqueue.h"
+#include <perf/cpumap.h>
+#include "util/affinity.h"
 
 struct workqueue_struct *global_wq;
 
@@ -43,6 +46,10 @@ struct workqueue_struct {
 	struct worker		**workers;	/* array of all workers */
 	struct worker		*next_worker;	/* next worker to choose (round robin) */
 	int			first_stopped_worker; /* next worker to start if needed */
+	struct {
+		int		*map;		/* maps cpu to thread idx */
+		int		size;		/* size of the map array */
+	} cpu_to_tidx_map;
 };
 
 static const char * const workqueue_errno_str[] = {
@@ -429,6 +436,7 @@ static void worker_thread(int tidx, struct task_struct *task)
 struct workqueue_struct *create_workqueue(int nr_threads)
 {
 	int ret, err = 0;
+	int nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 	struct workqueue_struct *wq = zalloc(sizeof(struct workqueue_struct));
 
 	if (!wq) {
@@ -449,10 +457,18 @@ struct workqueue_struct *create_workqueue(int nr_threads)
 		goto out_delete_pool;
 	}
 
+	wq->cpu_to_tidx_map.size = nr_cpus;
+	wq->cpu_to_tidx_map.map = calloc(nr_cpus, sizeof(*wq->cpu_to_tidx_map.map));
+	if (!wq->workers) {
+		err = -ENOMEM;
+		goto out_free_workers;
+	}
+	memset(wq->cpu_to_tidx_map.map, -1, nr_cpus * sizeof(*wq->cpu_to_tidx_map.map));
+
 	ret = pthread_mutex_init(&wq->lock, NULL);
 	if (ret) {
 		err = -ret;
-		goto out_free_workers;
+		goto out_free_cpu_to_idx_map;
 	}
 
 	ret = pthread_cond_init(&wq->idle_cond, NULL);
@@ -494,6 +510,8 @@ struct workqueue_struct *create_workqueue(int nr_threads)
 	pthread_mutex_destroy(&wq->lock);
 out_free_workers:
 	free(wq->workers);
+out_free_cpu_to_idx_map:
+	free(wq->cpu_to_tidx_map.map);
 out_delete_pool:
 	threadpool__delete(wq->pool);
 out_free_wq:
@@ -552,6 +570,7 @@ int destroy_workqueue(struct workqueue_struct *wq)
 	wq->msg_pipe[1] = -1;
 
 	zfree(&wq->workers);
+	zfree(&wq->cpu_to_tidx_map.map);
 	free(wq);
 	return err;
 }
@@ -779,6 +798,118 @@ int workqueue_set_affinity(struct workqueue_struct *wq, int tidx,
 	return wq->pool_errno ? -WORKQUEUE_ERROR__POOLAFFINITY : 0;
 }
 
+/**
+ * workqueue_set_affinity_cpu - set affinity to @cpu to thread @tidx in @wq->pool
+ *
+ * If cpu is -1, then affinity is set to all online processors.
+ */
+int workqueue_set_affinity_cpu(struct workqueue_struct *wq, int tidx, int cpu)
+{
+	struct mmap_cpu_mask affinity;
+	int i, err;
+
+	if (cpu >= 0)
+		affinity.nbits = cpu+1;
+	else
+		affinity.nbits = wq->cpu_to_tidx_map.size;
+
+	affinity.bits = bitmap_alloc(affinity.nbits);
+	if (!affinity.bits) {
+		pr_debug2("Failed allocation of bitmapset\n");
+		return -ENOMEM;
+	}
+
+	if (cpu >= 0)
+		test_and_set_bit(cpu, affinity.bits);
+	else
+		bitmap_fill(affinity.bits, affinity.nbits);
+
+	err = workqueue_set_affinity(wq, tidx, &affinity);
+	if (err)
+		goto out;
+
+	// find and unset this thread from the map
+	for (i = 0; i < wq->cpu_to_tidx_map.size; i++) {
+		if (wq->cpu_to_tidx_map.map[i] == tidx)
+			wq->cpu_to_tidx_map.map[i] = -1;
+	}
+
+	if (cpu >= 0)
+		wq->cpu_to_tidx_map.map[cpu] = tidx;
+
+out:
+	bitmap_free(affinity.bits);
+	return err;
+}
+
+/**
+ * workqueue_set_affinities_cpu - set single-cpu affinities to all threads in @wq->pool
+ */
+int workqueue_set_affinities_cpu(struct workqueue_struct *wq,
+				struct perf_cpu_map *cpus)
+{
+	int cpu, idx, err;
+
+	if (perf_cpu_map__nr(cpus) > threadpool__size(wq->pool))
+		return -EINVAL;
+
+
+	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
+		err = workqueue_set_affinity_cpu(wq, idx, cpu);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+struct cpu_bound_work {
+	struct work_struct work;
+	int cpu;
+	struct work_struct *original_work;
+};
+
+static void set_affinity_and_execute(struct work_struct *work)
+{
+	struct cpu_bound_work *cpu_bound_work = container_of(work, struct cpu_bound_work, work);
+	struct affinity affinity;
+
+	if (affinity__setup(&affinity) < 0)
+		goto out;
+
+	affinity__set(&affinity, cpu_bound_work->cpu);
+	cpu_bound_work->original_work->func(cpu_bound_work->original_work);
+	affinity__cleanup(&affinity);
+
+out:
+	free(cpu_bound_work);
+}
+
+/**
+ * queue_work_on - execute @work on @cpu
+ *
+ * The work is assigned to the worker pinned to @cpu, if any.
+ * Otherwise, affinity is set before running the work and unset after.
+ */
+int queue_work_on(int cpu, struct workqueue_struct *wq, struct work_struct *work)
+{
+	struct cpu_bound_work *cpu_bound_work;
+	int tidx = wq->cpu_to_tidx_map.map[cpu];
+
+	if (tidx >= 0)
+		return queue_work_on_worker(tidx, wq, work);
+
+	cpu_bound_work = malloc(sizeof(*cpu_bound_work));
+	if (!cpu_bound_work)
+		return -ENOMEM;
+
+	init_work(&cpu_bound_work->work);
+	cpu_bound_work->work.func = set_affinity_and_execute;
+	cpu_bound_work->cpu = cpu;
+	cpu_bound_work->original_work = work;
+	return queue_work(wq, &cpu_bound_work->work);
+}
+
 /**
  * init_work - initialize the @work struct
  */
diff --git a/tools/perf/util/workqueue/workqueue.h b/tools/perf/util/workqueue/workqueue.h
index dc6baee138b22ab2..a91a37e367b62d02 100644
--- a/tools/perf/util/workqueue/workqueue.h
+++ b/tools/perf/util/workqueue/workqueue.h
@@ -25,6 +25,7 @@ extern int workqueue_nr_threads(struct workqueue_struct *wq);
 
 extern int queue_work(struct workqueue_struct *wq, struct work_struct *work);
 extern int queue_work_on_worker(int tidx, struct workqueue_struct *wq, struct work_struct *work);
+extern int queue_work_on(int cpu, struct workqueue_struct *wq, struct work_struct *work);
 
 extern int flush_workqueue(struct workqueue_struct *wq);
 
@@ -32,6 +33,9 @@ extern int workqueue_set_affinities(struct workqueue_struct *wq,
 				struct mmap_cpu_mask *affinities);
 extern int workqueue_set_affinity(struct workqueue_struct *wq, int tidx,
 				struct mmap_cpu_mask *affinity);
+extern int workqueue_set_affinity_cpu(struct workqueue_struct *wq, int tidx, int cpu);
+extern int workqueue_set_affinities_cpu(struct workqueue_struct *wq,
+					struct perf_cpu_map *cpus);
 
 extern void init_work(struct work_struct *work);
 
@@ -82,6 +86,14 @@ static inline int schedule_work_on_worker(int tidx, struct work_struct *work)
 	return queue_work_on_worker(tidx, global_wq, work);
 }
 
+/**
+ * schedule_work_on - queue @work to be executed on @cpu by global_wq
+ */
+static inline int schedule_work_on(int cpu, struct work_struct *work)
+{
+	return queue_work_on(cpu, global_wq, work);
+}
+
 /**
  * flush_scheduled_work - ensure that any scheduled work in global_wq has run to completion
  */
-- 
2.31.1

