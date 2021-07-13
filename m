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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89898C07E95
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 12:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74DCC61249
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 12:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbhGMMOf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 08:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236172AbhGMMOd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 08:14:33 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EC8C0613EF;
        Tue, 13 Jul 2021 05:11:42 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l7so29263017wrv.7;
        Tue, 13 Jul 2021 05:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6WNHzJ7TZJXM3U37FlFXdskl78ntwTEiBDlOoJjZQ24=;
        b=LTSRY90x7Y7DimNCF6RUhDJbyVReFviK/HDP4qepG7UHo0saNt3Neo6gmWuoflS8gW
         clL15AvJb36PQxkydvOBbthju+yLjTqzZbzWIJ4WZUs2rBVcRY3XjX7IFM9oOXqVqbOz
         GP9SRyrLRf9u8TSTmWWCmn3iQatZPID/1ayg+8uUn9Pi6yI+p6MmZ4F/NB9r31QCAsGi
         iGC2FRV6RXNPJZfviYnrevdLRkYKXYmUQix/wD8ESgVyJl4ZghEDUQhFoKVdXdcKwaIq
         bcrdzpv7iBn7/j1yelMqIlbgchwiNPytfBE1cykcdPOc/EuE4mK20oiZbY6QZdy2zEve
         eugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6WNHzJ7TZJXM3U37FlFXdskl78ntwTEiBDlOoJjZQ24=;
        b=pO6MBV/e0uQNNIL/Jw7Hf1I0c8Yb1lBGJeLsXSdPIqiSYGaiPp4mXQBI32LFgyF6qx
         ebF8pSEQaYYkt6TJuDakmTzyR5C8J8Ebn7mNWOJ9RlkuEeSJHPZR0j9SE4Rtsty2Fax5
         5eB5oIEY/5gr4dS4Uitsc3BtGgHk1cLruEX1R2+rm3yWmws+Vye1ElniT4ab1BCc/+6X
         uD0Cs3sxXQzRbMJgYhVlVLQ/bE7ZbLOoq1BEJPJt+QVr43yUsBjrPe7pmt0rDotYs5sY
         NsNab/05S6q22JgBHs/xRRkPvX92qrBOmlCzPDplurbJ8e7m/pnvrd32kmWXm21tikba
         9kGQ==
X-Gm-Message-State: AOAM531KV9xRjQ2MmIKVGbTSHh7csqPqLlh3NjaHvIqvIxRCpuFOdFbe
        1I78MAlUBhV/ZoNpIwAP2ak=
X-Google-Smtp-Source: ABdhPJzKUtfswrK+N087tU7Je+1UDSJUnz0e0h7Vb88mX6gkah3HK5+zOnKgr1iYjUGOzRnGSNIoeA==
X-Received: by 2002:adf:a350:: with SMTP id d16mr5348380wrb.207.1626178301238;
        Tue, 13 Jul 2021 05:11:41 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id o3sm17551425wrw.56.2021.07.13.05.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 05:11:40 -0700 (PDT)
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
Subject: [RFC PATCH 10/10] perf synthetic-events: use workqueue parallel_for
Date:   Tue, 13 Jul 2021 14:11:21 +0200
Message-Id: <b430c981f027cb03c1c20f6f7ee4800aded7a810.1626177381.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626177381.git.rickyman7@gmail.com>
References: <cover.1626177381.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

To generate synthetic events, perf has the option to use multiple
threads. These threads are created manually using pthread_created.

This patch replaces the manual pthread_create with a workqueue,
using the parallel_for utility.

Experimental results show that workqueue has a higher overhead, but
this is repayed by the improved work balancing among threads.

Results of perf bench before and after are reported below:
Command: sudo ./perf bench internals synthesize -t
Average synthesis time in usec is reported.

Laptop (dual core i7 w/ hyperthreading), avg num events ~14200:
 N    pthread (before)        workqueue (after)
 1  70714.400 +-  908.789   73306.000 +- 1597.868
 2  77426.700 +- 2986.579   46782.300 +-  326.221
 3  53176.300 +- 3405.635   41614.100 +-  239.827
 4  50760.900 +-  702.623   41071.300 +-  230.200

VM (16 vCPUs over 16 core Intel Xeon E5-2630L v3), avg num events ~2760:
 N    pthread (before)        workqueue (after)
 1  30309.500 +-  578.283   34252.000 +-  839.474
 2  23815.200 +- 1339.102   28487.200 +- 1423.481
 3  20644.300 +-  311.573   19220.200 +- 1436.024
 4  19091.500 +-  446.109   15048.600 +-  319.138
 5  17574.000 +-  988.612   14938.500 +-  411.078
 6  18908.900 +-  520.676   13997.600 +-  358.668
 7  19275.700 +-  631.989   11371.400 +-  365.038
 8  15671.200 +-  306.727   11964.800 +-  338.021
 9  14660.900 +-  333.218   11762.800 +-  652.763
10  12490.200 +-  579.211   11832.300 +-  200.601
11  18052.900 +-  941.578   13166.900 +-  704.318
12  14253.600 +-  354.332   12012.000 +-  309.724
13  12219.000 +-  516.438   12023.800 +-  273.626
14  15896.600 +-  442.419   11764.600 +-  353.961
15  15087.200 +-  337.612   11942.600 +-  304.102
16  15368.700 +-  336.785   13625.200 +-  715.125

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/synthetic-events.c | 131 ++++++++++++-----------------
 1 file changed, 56 insertions(+), 75 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 35aa0c0f7cd955b2..a55c7fa41b4f86d3 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -41,6 +41,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <unistd.h>
+#include "util/workqueue/workqueue.h"
 
 #define DEFAULT_PROC_MAP_PARSE_TIMEOUT 500
 
@@ -882,16 +883,13 @@ static int __perf_event__synthesize_threads(struct perf_tool *tool,
 					    perf_event__handler_t process,
 					    struct machine *machine,
 					    bool mmap_data,
-					    struct dirent **dirent,
-					    int start,
-					    int num)
+					    char *d_name)
 {
 	union perf_event *comm_event, *mmap_event, *fork_event;
 	union perf_event *namespaces_event;
 	int err = -1;
 	char *end;
 	pid_t pid;
-	int i;
 
 	comm_event = malloc(sizeof(comm_event->comm) + machine->id_hdr_size);
 	if (comm_event == NULL)
@@ -911,24 +909,22 @@ static int __perf_event__synthesize_threads(struct perf_tool *tool,
 	if (namespaces_event == NULL)
 		goto out_free_fork;
 
-	for (i = start; i < start + num; i++) {
-		if (!isdigit(dirent[i]->d_name[0]))
-			continue;
+	if (!isdigit(d_name[0]))
+		goto out_free_namespaces;
 
-		pid = (pid_t)strtol(dirent[i]->d_name, &end, 10);
-		/* only interested in proper numerical dirents */
-		if (*end)
-			continue;
-		/*
-		 * We may race with exiting thread, so don't stop just because
-		 * one thread couldn't be synthesized.
-		 */
-		__event__synthesize_thread(comm_event, mmap_event, fork_event,
-					   namespaces_event, pid, 1, process,
-					   tool, machine, mmap_data);
-	}
+	pid = (pid_t)strtol(d_name, &end, 10);
+	/* only interested in proper numerical dirents */
+	if (*end)
+		goto out_free_namespaces;
+	/*
+	 * We may race with exiting thread, so don't stop just because
+	 * one thread couldn't be synthesized.
+	 */
+	__event__synthesize_thread(comm_event, mmap_event, fork_event,
+					namespaces_event, pid, 1, process,
+					tool, machine, mmap_data);
 	err = 0;
-
+out_free_namespaces:
 	free(namespaces_event);
 out_free_fork:
 	free(fork_event);
@@ -946,19 +942,15 @@ struct synthesize_threads_arg {
 	struct machine *machine;
 	bool mmap_data;
 	struct dirent **dirent;
-	int num;
-	int start;
 };
 
-static void *synthesize_threads_worker(void *arg)
+static void synthesize_threads_worker(int i, void *arg)
 {
 	struct synthesize_threads_arg *args = arg;
 
 	__perf_event__synthesize_threads(args->tool, args->process,
 					 args->machine, args->mmap_data,
-					 args->dirent,
-					 args->start, args->num);
-	return NULL;
+					 args->dirent[i]->d_name);
 }
 
 int perf_event__synthesize_threads(struct perf_tool *tool,
@@ -967,15 +959,14 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
 				   bool mmap_data,
 				   unsigned int nr_threads_synthesize)
 {
-	struct synthesize_threads_arg *args = NULL;
-	pthread_t *synthesize_threads = NULL;
+	struct synthesize_threads_arg args;
 	char proc_path[PATH_MAX];
 	struct dirent **dirent;
-	int num_per_thread;
-	int m, n, i, j;
+	int n, i;
 	int thread_nr;
-	int base = 0;
-	int err = -1;
+	int err = -1, ret;
+	struct threadpool_struct *pool;
+	struct workqueue_struct *wq;
 
 
 	if (machine__is_default_guest(machine))
@@ -992,54 +983,44 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
 		thread_nr = nr_threads_synthesize;
 
 	if (thread_nr <= 1) {
-		err = __perf_event__synthesize_threads(tool, process,
-						       machine, mmap_data,
-						       dirent, base, n);
+		for (i = 0; i < n; i++)
+			err = __perf_event__synthesize_threads(tool, process,
+								machine, mmap_data,
+								dirent[i]->d_name);
 		goto free_dirent;
 	}
-	if (thread_nr > n)
-		thread_nr = n;
 
-	synthesize_threads = calloc(sizeof(pthread_t), thread_nr);
-	if (synthesize_threads == NULL)
+	pool = create_threadpool(thread_nr);
+	if (!pool)
 		goto free_dirent;
 
-	args = calloc(sizeof(*args), thread_nr);
-	if (args == NULL)
-		goto free_threads;
-
-	num_per_thread = n / thread_nr;
-	m = n % thread_nr;
-	for (i = 0; i < thread_nr; i++) {
-		args[i].tool = tool;
-		args[i].process = process;
-		args[i].machine = machine;
-		args[i].mmap_data = mmap_data;
-		args[i].dirent = dirent;
-	}
-	for (i = 0; i < m; i++) {
-		args[i].num = num_per_thread + 1;
-		args[i].start = i * args[i].num;
-	}
-	if (i != 0)
-		base = args[i-1].start + args[i-1].num;
-	for (j = i; j < thread_nr; j++) {
-		args[j].num = num_per_thread;
-		args[j].start = base + (j - i) * args[i].num;
-	}
-
-	for (i = 0; i < thread_nr; i++) {
-		if (pthread_create(&synthesize_threads[i], NULL,
-				   synthesize_threads_worker, &args[i]))
-			goto out_join;
-	}
-	err = 0;
-out_join:
-	for (i = 0; i < thread_nr; i++)
-		pthread_join(synthesize_threads[i], NULL);
-	free(args);
-free_threads:
-	free(synthesize_threads);
+	err = start_threadpool(pool);
+	if (err)
+		goto free_pool;
+
+	wq = create_workqueue(pool);
+	if (!wq)
+		goto stop_pool;
+
+	args.tool = tool;
+	args.process = process;
+	args.machine = machine;
+	args.mmap_data = mmap_data;
+	args.dirent = dirent;
+
+	ret = parallel_for(wq, 0, n, 1, synthesize_threads_worker, &args);
+	if (ret)
+		err = ret;
+
+	ret = destroy_workqueue(wq);
+	if (ret)
+		err = ret;
+stop_pool:
+	ret = stop_threadpool(pool);
+	if (ret)
+		err = ret;
+free_pool:
+	destroy_threadpool(pool);
 free_dirent:
 	for (i = 0; i < n; i++)
 		zfree(&dirent[i]);
-- 
2.31.1

