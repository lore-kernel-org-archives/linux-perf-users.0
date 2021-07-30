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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D066C3F6A3
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 15:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7970E60F4B
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 15:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239652AbhG3PhE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jul 2021 11:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbhG3PfL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jul 2021 11:35:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327BCC0617B1;
        Fri, 30 Jul 2021 08:34:33 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d8so11812438wrm.4;
        Fri, 30 Jul 2021 08:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BmIa+7125YO4azJQTlS/YBJsGTKcXkfMo9fHDkWwO/k=;
        b=R7rxSqv6GRdwz8GJppAljgaRYrsCTOHyNJOhiRWw/2vPba43nsuuzvXMVTPOEN6FmL
         9bhgCr9POsoSz9I/1MEGeHTIGFnDdINCcXVer33mquceT7H7lLQcoQo+bJyEaFBL7Gsy
         mIsw6y0WimMqIXzt5fCgzHtlKJmAjEMoAgeLucFUscOzCmDQtTw1zIqcmvIpsH7rJdym
         VtR8lrcD98nvpXVv8EtEoJ1EYExOGRYg15tWiLRY1CyO6zzxNkwRiJfeCctpYk92K8gw
         NhV93SJcxQQGwO9VWcHzSx8fHfjoLEC0sOEYueZxGRw3aV938sRxjZUACrvaqC2f6LcA
         F8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BmIa+7125YO4azJQTlS/YBJsGTKcXkfMo9fHDkWwO/k=;
        b=AeUu0H6U7Qm0nROZB8c+16U4gF8SwlkrIz1hDOPoc+U8GnRnccdq4maPKA5vTg8n+X
         boCci2W5JnBSqfX903EkOlcEtwPO7VJqf/m/hRBIs+f8nhVfif51SQgREiafT22BJrK+
         nCqJuu9mOR09P6yeyemj7T5qbyH6f3VyEZ9CWSPIJKj8r4oF365thGClI13d8+LiGPbM
         89eDK5+uE9hVNvOEn0vOsYY7VFCokXhly7xTyVZS+TgOzMSoQ53z+9rCB6rfFYX+VC1c
         4RlPHXDw2mM+xSmMZpruMqLkOQuS6nPckVtQ3enB0V89s+14/WUE7LYIgrM4B1oUEJ5u
         KRFg==
X-Gm-Message-State: AOAM532kwb6RwWknAspjcoER6FlOZWsn8UekheOp+Ax6jYadhcI6bRpu
        M96nUgzI0tBB7uXSRY6I6SU=
X-Google-Smtp-Source: ABdhPJyWKJ0zKKtFNKpfpxZoL+RKVc0yl7Txcr++bvfAiiuEP/KgrurVLYxn5JMLH3ojLacZt2delw==
X-Received: by 2002:adf:e107:: with SMTP id t7mr3675997wrz.165.1627659271649;
        Fri, 30 Jul 2021 08:34:31 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id v15sm2354727wmj.39.2021.07.30.08.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 08:34:31 -0700 (PDT)
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
Subject: [RFC PATCH v2 10/10] perf synthetic-events: use workqueue parallel_for
Date:   Fri, 30 Jul 2021 17:34:17 +0200
Message-Id: <0e9bdbcb903b24b95841e09bbae180841b6311ca.1627657061.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627657061.git.rickyman7@gmail.com>
References: <cover.1627657061.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

To generate synthetic events, perf has the option to use multiple
threads. These threads are created manually using pthread_created.

This patch replaces the manual pthread_create with a workqueue,
using the parallel_for utility.

Experimental results show that workqueue has a slightly higher overhead,
but this is repayed by the improved work balancing among threads.

Results of perf bench before and after are reported below:
Command: sudo ./perf bench internals synthesize -t
Average synthesis time in usec is reported.

Laptop (2 cores 4 threads i7), avg num events ~21500:
 N    pthread (before)        workqueue (after)
 1  121475.200 +- 2227.757  118882.900 +- 1389.398
 2   72834.100 +- 1860.677   67668.600 +- 2847.693
 3   70650.200 +-  540.096   55694.200 +-  496.155
 4   55554.300 +-  259.968   50901.400 +-  434.327

VM (16 vCPU over 16 cores 32 threads Xeon), avg num events ~2920:
 N    pthread (before)        workqueue (after)
 1  35182.400 +- 3561.189   37528.300 +- 2972.887
 2  29188.400 +- 2191.767   28250.300 +- 1694.575
 3  22172.200 +-  788.659   19062.400 +-  611.201
 4  21600.700 +-  728.941   16812.900 +- 1085.359
 5  19395.800 +- 1070.617   14764.600 +- 1339.113
 6  18553.000 +- 1272.486   12814.200 +-  408.462
 7  14691.400 +-  485.105   12382.200 +-  464.964
 8  16036.400 +-  842.728   15015.000 +- 1648.844
 9  15606.800 +-  470.100   13230.800 +- 1288.246
10  15527.000 +-  822.317   12661.800 +-  873.199
11  13097.400 +-  513.870   13082.700 +-  974.378
12  14053.700 +-  592.427   13123.400 +- 1054.939
13  15446.400 +-  765.850   12837.200 +-  770.646
14  14979.400 +- 1056.955   13695.400 +- 1066.302
15  12578.000 +-  846.142   15053.600 +-  992.118
16  12394.800 +-  602.295   13683.700 +-  911.517

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/synthetic-events.c | 155 +++++++++++++++--------------
 1 file changed, 81 insertions(+), 74 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 35aa0c0f7cd955b2..3fcda677e100b3ae 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -22,6 +22,7 @@
 #include <linux/string.h>
 #include <linux/zalloc.h>
 #include <linux/perf_event.h>
+#include <linux/err.h>
 #include <asm/bug.h>
 #include <perf/evsel.h>
 #include <perf/cpumap.h>
@@ -41,6 +42,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <unistd.h>
+#include "util/workqueue/workqueue.h"
 
 #define DEFAULT_PROC_MAP_PARSE_TIMEOUT 500
 
@@ -882,16 +884,13 @@ static int __perf_event__synthesize_threads(struct perf_tool *tool,
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
@@ -911,24 +910,22 @@ static int __perf_event__synthesize_threads(struct perf_tool *tool,
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
@@ -946,19 +943,15 @@ struct synthesize_threads_arg {
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
@@ -967,15 +960,15 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
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
+	struct threadpool *pool;
+	struct workqueue_struct *wq;
+	char err_buf[WORKQUEUE_STRERR_BUFSIZE];
 
 
 	if (machine__is_default_guest(machine))
@@ -992,54 +985,68 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
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
+	pool = threadpool__new(thread_nr);
+	if (IS_ERR(pool)) {
+		ret = threadpool__new_strerror(pool, err_buf, sizeof(err_buf));
+		pr_err("threadpool__new: %s\n",
+			ret ? "Error generating error msg" : err_buf);
 		goto free_dirent;
-
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
 	}
 
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
+	err = threadpool__start(pool);
+	if (err) {
+		ret = threadpool__strerror(pool, err, err_buf, sizeof(err_buf));
+		pr_err("threadpool__start: %s\n",
+			ret ? "Error generating error msg" : err_buf);
+		goto free_pool;
+	}
+
+	wq = create_workqueue(pool);
+	if (IS_ERR(wq)) {
+		ret = create_workqueue_strerror(wq, err_buf, sizeof(err_buf));
+		pr_err("create_workqueue: %s\n",
+			ret ? "Error generating error msg" : err_buf);
+		goto stop_pool;
+	}
+
+	args.tool = tool;
+	args.process = process;
+	args.machine = machine;
+	args.mmap_data = mmap_data;
+	args.dirent = dirent;
+
+	ret = parallel_for(wq, 0, n, 1, synthesize_threads_worker, &args);
+	if (ret) {
+		ret = workqueue_strerror(wq, ret, err_buf, sizeof(err_buf));
+		pr_err("parallel_for: %s\n",
+			ret ? "Error generating error msg" : err_buf);
+		err = ret;
+	}
+
+	ret = destroy_workqueue(wq);
+	if (ret) {
+		ret = destroy_workqueue_strerror(ret, err_buf, sizeof(err_buf));
+		pr_err("destroy_workqueue: %s\n",
+			ret ? "Error generating error msg" : err_buf);
+		err = ret;
+	}
+stop_pool:
+	ret = threadpool__stop(pool);
+	if (ret) {
+		ret = threadpool__strerror(pool, ret, err_buf, sizeof(err_buf));
+		pr_err("threadpool__stop: %s\n",
+			ret ? "Error generating error msg" : err_buf);
+		err = ret;
+	}
+free_pool:
+	threadpool__delete(pool);
 free_dirent:
 	for (i = 0; i < n; i++)
 		zfree(&dirent[i]);
-- 
2.31.1

