Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2508A212D94;
	Tue, 14 Jan 2025 21:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736889780; cv=none; b=MfLsT1gB2COIF5aF0GZeQs6g6Jt9CHQBx4RLLxFYVYnQryTwO4rRuXIJkR66w2FycdAfRfkoSS0g+nEiRkqGEkQZKJvVYgnoIWoRcFT1PAUF55yKMExDLfOh8fpT9vT+7YmFNhYk3HxQ0MSqxKCiJuTIRGv7r6eezjTX1aAnUeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736889780; c=relaxed/simple;
	bh=RfBaj4PbSnE3Ns3yNkpZJWdF4poiD2WjKo9y2CbPgkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7bqKgi9ea2nkgOBSnSLwGwvY80zuqt/SymU0uy5+dmorxZB/X6u1yZeGn3DD4TB3nmZD5b7Hz8mRV5OCh9z2WSHMUb4NJz/oHP0jtTZ5yuJLocZ+FH4RHVXmiTewaPC9sk7yQgfbVeItD4QcTV3Uvda6MXFeL8gCAL1pCm4bVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeUhnXaZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeUhnXaZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43DDC4CEE4;
	Tue, 14 Jan 2025 21:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736889780;
	bh=RfBaj4PbSnE3Ns3yNkpZJWdF4poiD2WjKo9y2CbPgkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aeUhnXaZYdONGwyBxrEeWyiQsH3+NVf7W/kfnsCLRl6GZFosGvkcVA1FxfJHpOz0r
	 sLp8uxRBVAKe4S9V4fABAoGS2oPZIOBBULO+V0Q7OAWtROBGAtIakf9oaTwXuNl9Q2
	 f1v/ZQeK3lVUkk2OFgH+WkjWITzpR6rtJ8UJaJEwlHz3iXfE2cHVQJF2ls9g9jhJMm
	 5nC4xdWvtn5VPk3Gc4GBcXEUptfW9Nx5Y/t2O71+ISemIBvFUoQL9YqABgGJS4KLvN
	 ipVOOEN7R02lDsINJ55/7dJ43VUsQTQS+RIbSK/aBYexCf4UMG53lL8WEfRHda9cjl
	 uyA1wLlbbfRqQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH 4/4] perf trace: Add --system-summary option
Date: Tue, 14 Jan 2025 13:22:56 -0800
Message-ID: <20250114212256.160730-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
In-Reply-To: <20250114212256.160730-1-namhyung@kernel.org>
References: <20250114212256.160730-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  $ sudo ./perf trace -as --system-summary sleep 1

   Summary of events:

   total, 21580 events

     syscall            calls  errors  total       min       avg       max       stddev
                                       (msec)    (msec)    (msec)    (msec)        (%)
     --------------- --------  ------ -------- --------- --------- ---------     ------
     epoll_wait          1305      0 14716.712     0.000    11.277   551.529      8.87%
     futex               1256     89 13331.197     0.000    10.614   733.722     15.49%
     poll                 669      0  6806.618     0.000    10.174   459.316     11.77%
     ppoll                220      0  3968.797     0.000    18.040   516.775     25.35%
     clock_nanosleep        1      0  1000.027  1000.027  1000.027  1000.027      0.00%
     epoll_pwait           21      0   592.783     0.000    28.228   522.293     88.29%
     nanosleep             16      0    60.515     0.000     3.782    10.123     33.33%
     ioctl                510      0     4.284     0.001     0.008     0.182      8.84%
     recvmsg             1434    775     3.497     0.001     0.002     0.174      6.37%
     write               1393      0     2.854     0.001     0.002     0.017      1.79%
     read                1063    100     2.236     0.000     0.002     0.083      5.11%
     ...

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-trace.txt |   3 +
 tools/perf/builtin-trace.c              | 100 +++++++++++++++++++-----
 2 files changed, 85 insertions(+), 18 deletions(-)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index 2620c4f4601c8701..72f29f82649e320a 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -150,6 +150,9 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 	To be used with -s or -S, to show stats for the errnos experienced by
 	syscalls, using only this option will trigger --summary.
 
+--system-summary::
+	To be used with -s or -S, to show system-wide summary instead of per-thread.
+
 --tool_stats::
 	Show tool stats such as number of times fd->pathname was discovered thru
 	hooking the open syscall return + vfs_getname or via reading /proc/pid/fd, etc.
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ad7f7fcd0d80b9df..00a20052f676847c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -177,8 +177,10 @@ struct trace {
 		pid_t		*entries;
 		struct bpf_map  *map;
 	}			filter_pids;
+	struct hashmap		*syscall_stats;
 	double			duration_filter;
 	double			runtime_ms;
+	unsigned long		pfmaj, pfmin;
 	struct {
 		u64		vfs_getname,
 				proc_getname;
@@ -198,6 +200,7 @@ struct trace {
 	bool			summary;
 	bool			summary_only;
 	bool			errno_summary;
+	bool			system_summary;
 	bool			failure_only;
 	bool			show_comm;
 	bool			print_sample;
@@ -2500,18 +2503,23 @@ struct syscall_stats {
 };
 
 static void thread__update_stats(struct thread *thread, struct thread_trace *ttrace,
-				 int id, struct perf_sample *sample, long err, bool errno_summary)
+				 int id, struct perf_sample *sample, long err,
+				 struct trace *trace)
 {
+	struct hashmap *syscall_stats = ttrace->syscall_stats;
 	struct syscall_stats *stats = NULL;
 	u64 duration = 0;
 
-	if (!hashmap__find(ttrace->syscall_stats, id, &stats)) {
+	if (trace->system_summary)
+		syscall_stats = trace->syscall_stats;
+
+	if (!hashmap__find(syscall_stats, id, &stats)) {
 		stats = zalloc(sizeof(*stats));
 		if (stats == NULL)
 			return;
 
 		init_stats(&stats->stats);
-		if (hashmap__add(ttrace->syscall_stats, id, stats) < 0) {
+		if (hashmap__add(syscall_stats, id, stats) < 0) {
 			free(stats);
 			return;
 		}
@@ -2525,7 +2533,7 @@ static void thread__update_stats(struct thread *thread, struct thread_trace *ttr
 	if (err < 0) {
 		++stats->nr_failures;
 
-		if (!errno_summary)
+		if (!trace->errno_summary)
 			return;
 
 		err = -err;
@@ -2817,7 +2825,7 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	ret = perf_evsel__sc_tp_uint(evsel, ret, sample);
 
 	if (trace->summary)
-		thread__update_stats(thread, ttrace, id, sample, ret, trace->errno_summary);
+		thread__update_stats(thread, ttrace, id, sample, ret, trace);
 
 	if (!trace->fd_path_disabled && sc->is_open && ret >= 0 && ttrace->filename.pending_open) {
 		trace__set_fd_pathname(thread, ret, ttrace->filename.name);
@@ -3255,10 +3263,13 @@ static int trace__pgfault(struct trace *trace,
 	if (ttrace == NULL)
 		goto out_put;
 
-	if (evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ)
+	if (evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ) {
 		ttrace->pfmaj++;
-	else
+		trace->pfmaj++;
+	} else {
 		ttrace->pfmin++;
+		trace->pfmin++;
+	}
 
 	if (trace->summary_only)
 		goto out;
@@ -3417,6 +3428,7 @@ static int trace__record(struct trace *trace, int argc, const char **argv)
 }
 
 static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *fp);
+static size_t trace__fprintf_system_summary(struct trace *trace, FILE *fp);
 
 static bool evlist__add_vfs_getname(struct evlist *evlist)
 {
@@ -4329,6 +4341,12 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		goto out_delete_evlist;
 	}
 
+	if (trace->system_summary) {
+		trace->syscall_stats = alloc_syscall_stats();
+		if (trace->syscall_stats == NULL)
+			goto out_delete_evlist;
+	}
+
 	evlist__config(evlist, &trace->opts, &callchain_param);
 
 	if (forks) {
@@ -4489,8 +4507,12 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		ordered_events__flush(&trace->oe.data, OE_FLUSH__FINAL);
 
 	if (!err) {
-		if (trace->summary)
-			trace__fprintf_thread_summary(trace, trace->output);
+		if (trace->summary) {
+			if (trace->system_summary)
+				trace__fprintf_system_summary(trace, trace->output);
+			else
+				trace__fprintf_thread_summary(trace, trace->output);
+		}
 
 		if (trace->show_tool_stats) {
 			fprintf(trace->output, "Stats:\n "
@@ -4502,6 +4524,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	}
 
 out_delete_evlist:
+	delete_syscall_stats(trace->syscall_stats);
 	trace__symbols__exit(trace);
 	evlist__free_syscall_tp_fields(evlist);
 	evlist__delete(evlist);
@@ -4629,6 +4652,12 @@ static int trace__replay(struct trace *trace)
 			evsel->handler = trace__pgfault;
 	}
 
+	if (trace->system_summary) {
+		trace->syscall_stats = alloc_syscall_stats();
+		if (trace->syscall_stats == NULL)
+			goto out;
+	}
+
 	setup_pager();
 
 	err = perf_session__process_events(session);
@@ -4639,12 +4668,13 @@ static int trace__replay(struct trace *trace)
 		trace__fprintf_thread_summary(trace, trace->output);
 
 out:
+	delete_syscall_stats(trace->syscall_stats);
 	perf_session__delete(session);
 
 	return err;
 }
 
-static size_t trace__fprintf_threads_header(FILE *fp)
+static size_t trace__fprintf_summary_header(FILE *fp)
 {
 	size_t printed;
 
@@ -4667,19 +4697,19 @@ static int entry_cmp(const void *e1, const void *e2)
 	return entry1->msecs > entry2->msecs ? -1 : 1;
 }
 
-static struct syscall_entry *thread__sort_stats(struct thread_trace *ttrace)
+static struct syscall_entry *syscall__sort_stats(struct hashmap *syscall_stats)
 {
 	struct syscall_entry *entry;
 	struct hashmap_entry *pos;
 	unsigned bkt, i, nr;
 
-	nr = ttrace->syscall_stats->sz;
+	nr = syscall_stats->sz;
 	entry = malloc(nr * sizeof(*entry));
 	if (entry == NULL)
 		return NULL;
 
 	i = 0;
-	hashmap__for_each_entry(ttrace->syscall_stats, pos, bkt) {
+	hashmap__for_each_entry(syscall_stats, pos, bkt) {
 		struct syscall_stats *ss = pos->pvalue;
 		struct stats *st = &ss->stats;
 
@@ -4694,14 +4724,14 @@ static struct syscall_entry *thread__sort_stats(struct thread_trace *ttrace)
 	return entry;
 }
 
-static size_t thread__dump_stats(struct thread_trace *ttrace,
-				 struct trace *trace, FILE *fp)
+static size_t syscall__dump_stats(struct trace *trace, FILE *fp,
+				  struct hashmap *syscall_stats)
 {
 	size_t printed = 0;
 	struct syscall *sc;
 	struct syscall_entry *entries;
 
-	entries = thread__sort_stats(ttrace);
+	entries = syscall__sort_stats(syscall_stats);
 	if (entries == NULL)
 		return 0;
 
@@ -4711,7 +4741,7 @@ static size_t thread__dump_stats(struct thread_trace *ttrace,
 	printed += fprintf(fp, "                                     (msec)    (msec)    (msec)    (msec)        (%%)\n");
 	printed += fprintf(fp, "   --------------- --------  ------ -------- --------- --------- ---------     ------\n");
 
-	for (size_t i = 0; i < ttrace->syscall_stats->sz; i++) {
+	for (size_t i = 0; i < syscall_stats->sz; i++) {
 		struct syscall_entry *entry = &entries[i];
 		struct syscall_stats *stats = entry->stats;
 		if (stats) {
@@ -4747,6 +4777,17 @@ static size_t thread__dump_stats(struct thread_trace *ttrace,
 	return printed;
 }
 
+static size_t thread__dump_stats(struct thread_trace *ttrace,
+				 struct trace *trace, FILE *fp)
+{
+	return syscall__dump_stats(trace, fp, ttrace->syscall_stats);
+}
+
+static size_t system__dump_stats(struct trace *trace, FILE *fp)
+{
+	return syscall__dump_stats(trace, fp, trace->syscall_stats);
+}
+
 static size_t trace__fprintf_thread(FILE *fp, struct thread *thread, struct trace *trace)
 {
 	size_t printed = 0;
@@ -4800,7 +4841,7 @@ static int trace_nr_events_cmp(void *priv __maybe_unused,
 
 static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *fp)
 {
-	size_t printed = trace__fprintf_threads_header(fp);
+	size_t printed = trace__fprintf_summary_header(fp);
 	LIST_HEAD(threads);
 
 	if (machine__thread_list(trace->host, &threads) == 0) {
@@ -4815,6 +4856,27 @@ static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *fp)
 	return printed;
 }
 
+static size_t trace__fprintf_system_summary(struct trace *trace, FILE *fp)
+{
+	size_t printed = trace__fprintf_summary_header(fp);
+
+	printed += fprintf(fp, " total, ");
+	printed += fprintf(fp, "%lu events", trace->nr_events);
+
+	if (trace->pfmaj)
+		printed += fprintf(fp, ", %lu majfaults", trace->pfmaj);
+	if (trace->pfmin)
+		printed += fprintf(fp, ", %lu minfaults", trace->pfmin);
+	if (trace->sched)
+		printed += fprintf(fp, ", %.3f msec\n", trace->runtime_ms);
+	else if (fputc('\n', fp) != EOF)
+		++printed;
+
+	printed += system__dump_stats(trace, fp);
+
+	return printed;
+}
+
 static int trace__set_duration(const struct option *opt, const char *str,
 			       int unset __maybe_unused)
 {
@@ -5233,6 +5295,8 @@ int cmd_trace(int argc, const char **argv)
 		    "Show all syscalls and summary with statistics"),
 	OPT_BOOLEAN(0, "errno-summary", &trace.errno_summary,
 		    "Show errno stats per syscall, use with -s or -S"),
+	OPT_BOOLEAN(0, "system-summary", &trace.system_summary,
+		    "Show system-wide summary instead of per-thread, use with -s or -S"),
 	OPT_CALLBACK_DEFAULT('F', "pf", &trace.trace_pgfaults, "all|maj|min",
 		     "Trace pagefaults", parse_pagefaults, "maj"),
 	OPT_BOOLEAN(0, "syscalls", &trace.trace_syscalls, "Trace syscalls"),
-- 
2.48.0.rc2.279.g1de40edade-goog

