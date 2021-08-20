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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E93C432BE
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADBCE60C3E
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbhHTKzu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbhHTKza (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Aug 2021 06:55:30 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B6FC0613A3;
        Fri, 20 Aug 2021 03:54:38 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id bo19so13359647edb.9;
        Fri, 20 Aug 2021 03:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=exxZgwSNBK3fYlIbeOPOzlef2BAUXtuXAblIC9zjF1s=;
        b=Meyg+sKI3rJLjPDvkwkrDAKa4m96A12UgNsilBdsguWSAbwDVjCiUccvvYHNKr1qzA
         P5qnqaLQwUq4E0TGB+//5IsT/RUaLTOe9jix3ghCvAWkOgcQNGZC5/y2yd4yaseLsicI
         mhuh7KqxlMZEXUtGMFwdAGKkwn9ZiPVRuY3HGe/w2r4xHXJWYua+KZZA+TiyImoDAGn7
         10MIPgOph8K1BYuatlJJDF6rTj0Hpnhe/lUJeB1+2BktVbsMpPhXvQWpXC+3xRweXIIU
         z18AVOjto4dADohjYRAewRNMhJgwjtmaGNhs5Ga8S5R9btIUU1G5cZI4QiBgDmgaR6Oj
         6sXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=exxZgwSNBK3fYlIbeOPOzlef2BAUXtuXAblIC9zjF1s=;
        b=gmn440TZLeUOI+ydewsw0VfNru+skCWGiWNe48F+CjfbKUcH9joAq8dY7T4q40pOyf
         E2gn039WM8E3NoT46pqolbJuAP4UknSp5D+SFeuGYyO5M43gbRV2MTtIJQ2iXvr7CO4E
         /tYU8of2Afnn9aIbTDZKtiRLG+4a3OIayMhPzP5y12BLzBX+khtrqEXiwdNlDWSMMLOO
         CHHIpQy57KfcN4L1myeo4QOjl5zE53HEsvAp4HfsfbWabaIGmGtGe7VI4d7HNjru5vRZ
         XE9NEsKoDxemKQPYhcUmVnDRgiFTzxTQB5So/yX2/U8cH2PlCkzIQC18v0BWQpBCtkpz
         u3Zw==
X-Gm-Message-State: AOAM5335uFgX/5RVcdYoa26OQ93IwESIqNg9SXEHiimOPlOM73BR1ge/
        SkiEJ1tf/4SJ4mmp73fifRkhQui1lA1nexrDVgY=
X-Google-Smtp-Source: ABdhPJzZx97cDB1Afg1E+bkpky7YdS/IMkJDYYZqVHR5w9kaz363HVoYkVJITzZ9xdXljaAfEnJsLQ==
X-Received: by 2002:a05:6402:5249:: with SMTP id t9mr21165427edd.260.1629456876675;
        Fri, 20 Aug 2021 03:54:36 -0700 (PDT)
Received: from honeypot.epfl.ch (mob-176-243-199-7.net.vodafone.it. [176.243.199.7])
        by smtp.googlemail.com with ESMTPSA id g29sm3451459edf.31.2021.08.20.03.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 03:54:35 -0700 (PDT)
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
Subject: [RFC PATCH v3 15/15] perf synthetic-events: use workqueue parallel_for
Date:   Fri, 20 Aug 2021 12:54:01 +0200
Message-Id: <d7b1771ad9bdc23507f8abd2cb46c19849126cce.1629454773.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629454773.git.rickyman7@gmail.com>
References: <cover.1629454773.git.rickyman7@gmail.com>
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
 tools/perf/bench/synthesize.c         |  12 +--
 tools/perf/builtin-kvm.c              |   2 +-
 tools/perf/builtin-record.c           |   3 +-
 tools/perf/builtin-top.c              |   3 +-
 tools/perf/builtin-trace.c            |   3 +-
 tools/perf/tests/mmap-thread-lookup.c |   2 +-
 tools/perf/util/synthetic-events.c    | 135 +++++++++-----------------
 tools/perf/util/synthetic-events.h    |   8 +-
 8 files changed, 56 insertions(+), 112 deletions(-)

diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
index 738821113a005a6c..f1880116f4375c46 100644
--- a/tools/perf/bench/synthesize.c
+++ b/tools/perf/bench/synthesize.c
@@ -63,7 +63,6 @@ static int do_run_single_threaded(struct perf_session *session,
 				struct perf_thread_map *threads,
 				struct target *target, bool data_mmap)
 {
-	const unsigned int nr_threads_synthesize = 1;
 	struct timeval start, end, diff;
 	u64 runtime_us;
 	unsigned int i;
@@ -81,8 +80,7 @@ static int do_run_single_threaded(struct perf_session *session,
 						NULL,
 						target, threads,
 						process_synthesized_event,
-						data_mmap,
-						nr_threads_synthesize);
+						data_mmap);
 		if (err)
 			return err;
 
@@ -148,8 +146,7 @@ static int run_single_threaded(void)
 	return err;
 }
 
-static int do_run_multi_threaded(struct target *target,
-				unsigned int nr_threads_synthesize)
+static int do_run_multi_threaded(struct target *target)
 {
 	struct timeval start, end, diff;
 	u64 runtime_us;
@@ -172,8 +169,7 @@ static int do_run_multi_threaded(struct target *target,
 						NULL,
 						target, NULL,
 						process_synthesized_event,
-						false,
-						nr_threads_synthesize);
+						false);
 		if (err) {
 			perf_session__delete(session);
 			return err;
@@ -236,7 +232,7 @@ static int run_multi_threaded(void)
 		printf("  Number of synthesis threads: %u\n",
 			nr_threads_synthesize);
 
-		err = do_run_multi_threaded(&target, nr_threads_synthesize);
+		err = do_run_multi_threaded(&target);
 		if (err)
 			return err;
 
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index aa1b127ffb5be047..7afa1a41a627f353 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1456,7 +1456,7 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 	perf_session__set_id_hdr_size(kvm->session);
 	ordered_events__set_copy_on_queue(&kvm->session->ordered_events, true);
 	machine__synthesize_threads(&kvm->session->machines.host, &kvm->opts.target,
-				    kvm->evlist->core.threads, false, 1);
+				    kvm->evlist->core.threads, false);
 	err = kvm_live_open_events(kvm);
 	if (err)
 		goto out;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4d7b610b1d0bb9af..cccc2d0f9977d5b3 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1481,8 +1481,7 @@ static int record__synthesize(struct record *rec, bool tail)
 	}
 
 	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->core.threads,
-					    f, opts->sample_address,
-					    rec->opts.nr_threads_synthesize);
+					    f, opts->sample_address);
 
 	if (rec->opts.nr_threads_synthesize > 1)
 		perf_set_singlethreaded();
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 9b4f220920780a95..36cd1294d9b4ebd3 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1272,8 +1272,7 @@ static int __cmd_top(struct perf_top *top)
 		pr_debug("Couldn't synthesize cgroup events.\n");
 
 	machine__synthesize_threads(&top->session->machines.host, &opts->target,
-				    top->evlist->core.threads, false,
-				    top->nr_threads_synthesize);
+				    top->evlist->core.threads, false);
 
 	if (top->nr_threads_synthesize > 1)
 		perf_set_singlethreaded();
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2bf21194c7b3959e..e2b50ba55a5ea93d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1628,8 +1628,7 @@ static int trace__symbols_init(struct trace *trace, struct evlist *evlist)
 		goto out;
 
 	err = __machine__synthesize_threads(trace->host, &trace->tool, &trace->opts.target,
-					    evlist->core.threads, trace__tool_process, false,
-					    1);
+					    evlist->core.threads, trace__tool_process, false);
 out:
 	if (err)
 		symbol__exit();
diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index 8d9d4cbff76d17d5..809be9510e849d1b 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -135,7 +135,7 @@ static int synth_all(struct machine *machine)
 {
 	return perf_event__synthesize_threads(NULL,
 					      perf_event__process,
-					      machine, 0, 1);
+					      machine, 0);
 }
 
 static int synth_process(struct machine *machine)
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index a7e981b2d7decd3b..5f41e2f9579e3f77 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -23,6 +23,7 @@
 #include <linux/string.h>
 #include <linux/zalloc.h>
 #include <linux/perf_event.h>
+#include <linux/err.h>
 #include <asm/bug.h>
 #include <perf/evsel.h>
 #include <perf/cpumap.h>
@@ -42,6 +43,8 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <unistd.h>
+#include "util/workqueue/workqueue.h"
+#include "util/util.h"
 
 #define DEFAULT_PROC_MAP_PARSE_TIMEOUT 500
 
@@ -883,16 +886,13 @@ static int __perf_event__synthesize_threads(struct perf_tool *tool,
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
@@ -912,24 +912,22 @@ static int __perf_event__synthesize_threads(struct perf_tool *tool,
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
@@ -947,36 +945,28 @@ struct synthesize_threads_arg {
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
 				   perf_event__handler_t process,
 				   struct machine *machine,
-				   bool mmap_data,
-				   unsigned int nr_threads_synthesize)
+				   bool mmap_data)
 {
-	struct synthesize_threads_arg *args = NULL;
-	pthread_t *synthesize_threads = NULL;
+	struct synthesize_threads_arg args;
 	char proc_path[PATH_MAX];
 	struct dirent **dirent;
-	int num_per_thread;
-	int m, n, i, j;
-	int thread_nr;
-	int base = 0;
-	int err = -1;
+	int n, i;
+	int err = -1, ret;
+	char err_buf[WORKQUEUE_STRERR_BUFSIZE];
 
 
 	if (machine__is_default_guest(machine))
@@ -987,60 +977,27 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
 	if (n < 0)
 		return err;
 
-	if (nr_threads_synthesize == UINT_MAX)
-		thread_nr = sysconf(_SC_NPROCESSORS_ONLN);
-	else
-		thread_nr = nr_threads_synthesize;
-
-	if (thread_nr <= 1) {
-		err = __perf_event__synthesize_threads(tool, process,
-						       machine, mmap_data,
-						       dirent, base, n);
+	if (perf_singlethreaded) {
+		for (i = 0; i < n; i++)
+			err = __perf_event__synthesize_threads(tool, process,
+								machine, mmap_data,
+								dirent[i]->d_name);
 		goto free_dirent;
 	}
-	if (thread_nr > n)
-		thread_nr = n;
-
-	synthesize_threads = calloc(sizeof(pthread_t), thread_nr);
-	if (synthesize_threads == NULL)
-		goto free_dirent;
 
-	args = calloc(sizeof(*args), thread_nr);
-	if (args == NULL)
-		goto free_threads;
+	args.tool = tool;
+	args.process = process;
+	args.machine = machine;
+	args.mmap_data = mmap_data;
+	args.dirent = dirent;
 
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
+	err = parallel_for(global_wq, 0, n, 1, synthesize_threads_worker, &args);
+	if (err) {
+		ret = workqueue_strerror(global_wq, err, err_buf, sizeof(err_buf));
+		pr_err("parallel_for: %s\n",
+			ret <= 0 ? "Error generating error msg" : err_buf);
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
 free_dirent:
 	for (i = 0; i < n; i++)
 		zfree(&dirent[i]);
@@ -1775,26 +1732,22 @@ int perf_event__synthesize_id_index(struct perf_tool *tool, perf_event__handler_
 
 int __machine__synthesize_threads(struct machine *machine, struct perf_tool *tool,
 				  struct target *target, struct perf_thread_map *threads,
-				  perf_event__handler_t process, bool data_mmap,
-				  unsigned int nr_threads_synthesize)
+				  perf_event__handler_t process, bool data_mmap)
 {
 	if (target__has_task(target))
 		return perf_event__synthesize_thread_map(tool, threads, process, machine, data_mmap);
 	else if (target__has_cpu(target))
 		return perf_event__synthesize_threads(tool, process,
-						      machine, data_mmap,
-						      nr_threads_synthesize);
+						      machine, data_mmap);
 	/* command specified */
 	return 0;
 }
 
 int machine__synthesize_threads(struct machine *machine, struct target *target,
-				struct perf_thread_map *threads, bool data_mmap,
-				unsigned int nr_threads_synthesize)
+				struct perf_thread_map *threads, bool data_mmap)
 {
 	return __machine__synthesize_threads(machine, NULL, target, threads,
-					     perf_event__process, data_mmap,
-					     nr_threads_synthesize);
+					     perf_event__process, data_mmap);
 }
 
 static struct perf_record_event_update *event_update_event__new(size_t size, u64 type, u64 id)
diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
index c845e2b9b444df57..cd3c43451a237563 100644
--- a/tools/perf/util/synthetic-events.h
+++ b/tools/perf/util/synthetic-events.h
@@ -54,7 +54,7 @@ int perf_event__synthesize_stat_round(struct perf_tool *tool, u64 time, u64 type
 int perf_event__synthesize_stat(struct perf_tool *tool, u32 cpu, u32 thread, u64 id, struct perf_counts_values *count, perf_event__handler_t process, struct machine *machine);
 int perf_event__synthesize_thread_map2(struct perf_tool *tool, struct perf_thread_map *threads, perf_event__handler_t process, struct machine *machine);
 int perf_event__synthesize_thread_map(struct perf_tool *tool, struct perf_thread_map *threads, perf_event__handler_t process, struct machine *machine, bool mmap_data);
-int perf_event__synthesize_threads(struct perf_tool *tool, perf_event__handler_t process, struct machine *machine, bool mmap_data, unsigned int nr_threads_synthesize);
+int perf_event__synthesize_threads(struct perf_tool *tool, perf_event__handler_t process, struct machine *machine, bool mmap_data);
 int perf_event__synthesize_tracing_data(struct perf_tool *tool, int fd, struct evlist *evlist, perf_event__handler_t process);
 int perf_event__synth_time_conv(const struct perf_event_mmap_page *pc, struct perf_tool *tool, perf_event__handler_t process, struct machine *machine);
 pid_t perf_event__synthesize_comm(struct perf_tool *tool, union perf_event *event, pid_t pid, perf_event__handler_t process, struct machine *machine);
@@ -65,11 +65,9 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 
 int __machine__synthesize_threads(struct machine *machine, struct perf_tool *tool,
 				  struct target *target, struct perf_thread_map *threads,
-				  perf_event__handler_t process, bool data_mmap,
-				  unsigned int nr_threads_synthesize);
+				  perf_event__handler_t process, bool data_mmap);
 int machine__synthesize_threads(struct machine *machine, struct target *target,
-				struct perf_thread_map *threads, bool data_mmap,
-				unsigned int nr_threads_synthesize);
+				struct perf_thread_map *threads, bool data_mmap);
 
 #ifdef HAVE_AUXTRACE_SUPPORT
 int perf_event__synthesize_auxtrace_info(struct auxtrace_record *itr, struct perf_tool *tool,
-- 
2.31.1

