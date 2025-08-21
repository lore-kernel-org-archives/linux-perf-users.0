Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A14A33F6;
	Thu, 21 Aug 2025 00:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755736342; cv=none; b=INwI1XivsHFJuEpuOk4nVevPNn2PAlJB8pR96OkMhn4CVQtWfd8g78z9qJE+XiF4n80kDWfYeP3X7YuSR/5HTzuKFEGj9AbujAQywhQThu0GsvX2tW0fwRZQwQAB6uZ4nUdPDmNFLKmETBeD8h+qYK2hBzwd28L7HJeoXXbRB74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755736342; c=relaxed/simple;
	bh=JgTpt/cFm1bqz6ke7U4Y1VgLyhPqy2YNQ7zgU69JqVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SU92RIFjglUFHHa6U3pb+1Ealyxdnr+AoQPR6N48wZSsy5+ePTnLtPkSNit4nbuN6qI5FL4HFJvyCABLzTHEqLCg4kySNOavP5CeUnI/v8JL2VaaPc2sAMc5i3YpDr5J1IIbbPoMRPqanVk4z8nEe8fMX2YECd8KhztK/kOI1Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyOUMYEG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyOUMYEG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15672C4CEE7;
	Thu, 21 Aug 2025 00:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755736341;
	bh=JgTpt/cFm1bqz6ke7U4Y1VgLyhPqy2YNQ7zgU69JqVY=;
	h=From:To:Cc:Subject:Date:From;
	b=MyOUMYEGYFln061eXscNjucv6KGxLswL3guHFRIDVORnCBHz0mlpLuvscdx9mz7fN
	 WwP8bGyOJZILP5Pog2iF5CYJXcDfpHmhxx2zzhXjLVoTXjUhcAVYTaQoTfawHYSFsL
	 /r2olhiwm7qpj0JsHtV9LJAM6glfwk496WWH0OoLIhQakPQ91o62GowkxPecICxg8q
	 rLgzfpw/gzbAI2gD/SHksjSQ43BeAX50SzqTh7m0u2n3nEImHaIk5IwPN/Op5gI0Q0
	 JP5OD+Xb1qKAQ62lgEiUA3lpgC6/LnBKzuhbTeo05byqnUVFj7euUmJm1jq0yv63g0
	 pnLGsDAvBBxbQ==
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
Subject: [PATCH] perf trace: Add --max-summary option
Date: Wed, 20 Aug 2025 17:32:20 -0700
Message-ID: <20250821003220.1051711-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --max-summary option is to limit the number of output lines for
syscall summary stats.  The max applies to each entries like thread and
cgroups.  For total summary, it will just print up to the given number.

For example,

  $ sudo perf trace -as --max-summary 3 sleep 0.1

   ThreadPoolServi (1011651), 114 events, 14.8%

     syscall            calls  errors  total       min       avg       max       stddev
                                       (msec)    (msec)    (msec)    (msec)        (%)
     --------------- --------  ------ -------- --------- --------- ---------     ------
     epoll_wait            38      0    95.589     0.000     2.515    11.153     28.98%
     futex                  9      0     0.040     0.002     0.004     0.014     28.63%
     read                  10      0     0.037     0.003     0.004     0.005      4.67%

   sleep (1050529), 250 events, 32.4%

     syscall            calls  errors  total       min       avg       max       stddev
                                       (msec)    (msec)    (msec)    (msec)        (%)
     --------------- --------  ------ -------- --------- --------- ---------     ------
     clock_nanosleep        1      0   100.156   100.156   100.156   100.156      0.00%
     execve                 4      3     1.020     0.005     0.255     0.989     95.93%
     openat                36     17     0.416     0.003     0.012     0.029     10.58%

   ...

And this is for per-cgroup summary using BPF.

  $ sudo perf trace -as --max-summary 3 --summary-mode=cgroup --bpf-summary sleep 0.1

   cgroup /user.slice/user-657345.slice/user@657345.service/session.slice/org.gnome.Shell@x11.service, 12 events

     syscall            calls  errors  total       min       avg       max       stddev
                                       (msec)    (msec)    (msec)    (msec)        (%)
     --------------- --------  ------ -------- --------- --------- ---------     ------
     recvmsg                8      7     0.016     0.001     0.002     0.006     39.73%
     ppoll                  1      0     0.014     0.014     0.014     0.014      0.00%
     write                  2      0     0.010     0.002     0.005     0.008     61.02%

   cgroup /user.slice/user-657345.slice/session-4.scope, 73 events

     syscall            calls  errors  total       min       avg       max       stddev
                                       (msec)    (msec)    (msec)    (msec)        (%)
     --------------- --------  ------ -------- --------- --------- ---------     ------
     epoll_wait             8      0    13.461     0.010     1.683    12.235     89.66%
     ioctl                 20      0     0.204     0.001     0.010     0.113     54.01%
     writev                11      0     0.164     0.004     0.015     0.042     20.34%

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-trace.txt |  4 +++
 tools/perf/builtin-trace.c              | 10 ++++++-
 tools/perf/util/bpf-trace-summary.c     | 40 ++++++++++++++-----------
 tools/perf/util/trace.h                 |  4 +--
 4 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index 973fede403a05d2e..892c82a9bf402db2 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -249,6 +249,10 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 	works well with -s/--summary option where no argument information is
 	required.
 
+--max-summary=N::
+	Maximum number of lines in the summary mode.  Note that this applies to
+	each entry (thread or cgroup).
+
 
 PAGEFAULTS
 ----------
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a7a49d8997d55594..2e205c661fc360a1 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -197,6 +197,7 @@ struct trace {
 	unsigned int		max_stack;
 	unsigned int		min_stack;
 	enum trace_summary_mode	summary_mode;
+	int			max_summary;
 	int			raw_augmented_syscalls_args_size;
 	bool			raw_augmented_syscalls;
 	bool			fd_path_disabled;
@@ -4625,7 +4626,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	if (!err) {
 		if (trace->summary) {
 			if (trace->summary_bpf)
-				trace_print_bpf_summary(trace->output);
+				trace_print_bpf_summary(trace->output, trace->max_summary);
 			else if (trace->summary_mode == SUMMARY__BY_TOTAL)
 				trace__fprintf_total_summary(trace, trace->output);
 			else
@@ -4848,6 +4849,7 @@ static size_t syscall__dump_stats(struct trace *trace, int e_machine, FILE *fp,
 				  struct hashmap *syscall_stats)
 {
 	size_t printed = 0;
+	int lines = 0;
 	struct syscall *sc;
 	struct syscall_entry *entries;
 
@@ -4892,7 +4894,11 @@ static size_t syscall__dump_stats(struct trace *trace, int e_machine, FILE *fp,
 						fprintf(fp, "\t\t\t\t%s: %d\n", perf_env__arch_strerrno(trace->host->env, e + 1), stats->errnos[e]);
 				}
 			}
+			lines++;
 		}
+
+		if (trace->max_summary && trace->max_summary <= lines)
+			break;
 	}
 
 	free(entries);
@@ -5469,6 +5475,8 @@ int cmd_trace(int argc, const char **argv)
 	OPT_BOOLEAN(0, "force-btf", &trace.force_btf, "Prefer btf_dump general pretty printer"
 		       "to customized ones"),
 	OPT_BOOLEAN(0, "bpf-summary", &trace.summary_bpf, "Summary syscall stats in BPF"),
+	OPT_INTEGER(0, "max-summary", &trace.max_summary,
+		     "Max number of entries in the summary."),
 	OPTS_EVSWITCH(&trace.evswitch),
 	OPT_END()
 	};
diff --git a/tools/perf/util/bpf-trace-summary.c b/tools/perf/util/bpf-trace-summary.c
index 69fb165da206b01f..8dfe7e678941d0d8 100644
--- a/tools/perf/util/bpf-trace-summary.c
+++ b/tools/perf/util/bpf-trace-summary.c
@@ -138,11 +138,14 @@ static bool sc_node_equal(long key1, long key2, void *ctx __maybe_unused)
 	return key1 == key2;
 }
 
-static int print_common_stats(struct syscall_data *data, FILE *fp)
+static int print_common_stats(struct syscall_data *data, int max_summary, FILE *fp)
 {
 	int printed = 0;
 
-	for (int i = 0; i < data->nr_nodes; i++) {
+	if (max_summary == 0 || max_summary > data->nr_nodes)
+		max_summary = data->nr_nodes;
+
+	for (int i = 0; i < max_summary; i++) {
 		struct syscall_node *node = &data->nodes[i];
 		struct syscall_stats *stat = &node->stats;
 		double total = (double)(stat->total_time) / NSEC_PER_MSEC;
@@ -200,7 +203,7 @@ static int update_thread_stats(struct hashmap *hash, struct syscall_key *map_key
 	return 0;
 }
 
-static int print_thread_stat(struct syscall_data *data, FILE *fp)
+static int print_thread_stat(struct syscall_data *data, int max_summary, FILE *fp)
 {
 	int printed = 0;
 
@@ -213,18 +216,18 @@ static int print_thread_stat(struct syscall_data *data, FILE *fp)
 	printed += fprintf(fp, "                                     (msec)    (msec)    (msec)    (msec)        (%%)\n");
 	printed += fprintf(fp, "   --------------- --------  ------ -------- --------- --------- ---------     ------\n");
 
-	printed += print_common_stats(data, fp);
+	printed += print_common_stats(data, max_summary, fp);
 	printed += fprintf(fp, "\n\n");
 
 	return printed;
 }
 
-static int print_thread_stats(struct syscall_data **data, int nr_data, FILE *fp)
+static int print_thread_stats(struct syscall_data **data, int nr_data, int max_summary, FILE *fp)
 {
 	int printed = 0;
 
 	for (int i = 0; i < nr_data; i++)
-		printed += print_thread_stat(data[i], fp);
+		printed += print_thread_stat(data[i], max_summary, fp);
 
 	return printed;
 }
@@ -277,7 +280,7 @@ static int update_total_stats(struct hashmap *hash, struct syscall_key *map_key,
 	return 0;
 }
 
-static int print_total_stats(struct syscall_data **data, int nr_data, FILE *fp)
+static int print_total_stats(struct syscall_data **data, int nr_data, int max_summary, FILE *fp)
 {
 	int printed = 0;
 	int nr_events = 0;
@@ -291,8 +294,11 @@ static int print_total_stats(struct syscall_data **data, int nr_data, FILE *fp)
 	printed += fprintf(fp, "                                     (msec)    (msec)    (msec)    (msec)        (%%)\n");
 	printed += fprintf(fp, "   --------------- --------  ------ -------- --------- --------- ---------     ------\n");
 
-	for (int i = 0; i < nr_data; i++)
-		printed += print_common_stats(data[i], fp);
+	if (max_summary == 0 || max_summary > nr_data)
+		max_summary = nr_data;
+
+	for (int i = 0; i < max_summary; i++)
+		printed += print_common_stats(data[i], max_summary, fp);
 
 	printed += fprintf(fp, "\n\n");
 	return printed;
@@ -333,7 +339,7 @@ static int update_cgroup_stats(struct hashmap *hash, struct syscall_key *map_key
 	return 0;
 }
 
-static int print_cgroup_stat(struct syscall_data *data, FILE *fp)
+static int print_cgroup_stat(struct syscall_data *data, int max_summary, FILE *fp)
 {
 	int printed = 0;
 	struct cgroup *cgrp = __cgroup__find(&cgroups, data->key);
@@ -351,23 +357,23 @@ static int print_cgroup_stat(struct syscall_data *data, FILE *fp)
 	printed += fprintf(fp, "                                     (msec)    (msec)    (msec)    (msec)        (%%)\n");
 	printed += fprintf(fp, "   --------------- --------  ------ -------- --------- --------- ---------     ------\n");
 
-	printed += print_common_stats(data, fp);
+	printed += print_common_stats(data, max_summary, fp);
 	printed += fprintf(fp, "\n\n");
 
 	return printed;
 }
 
-static int print_cgroup_stats(struct syscall_data **data, int nr_data, FILE *fp)
+static int print_cgroup_stats(struct syscall_data **data, int nr_data, int max_summary, FILE *fp)
 {
 	int printed = 0;
 
 	for (int i = 0; i < nr_data; i++)
-		printed += print_cgroup_stat(data[i], fp);
+		printed += print_cgroup_stat(data[i], max_summary, fp);
 
 	return printed;
 }
 
-int trace_print_bpf_summary(FILE *fp)
+int trace_print_bpf_summary(FILE *fp, int max_summary)
 {
 	struct bpf_map *map = skel->maps.syscall_stats_map;
 	struct syscall_key *prev_key, key;
@@ -420,13 +426,13 @@ int trace_print_bpf_summary(FILE *fp)
 
 	switch (skel->rodata->aggr_mode) {
 	case SYSCALL_AGGR_THREAD:
-		printed += print_thread_stats(data, nr_data, fp);
+		printed += print_thread_stats(data, nr_data, max_summary, fp);
 		break;
 	case SYSCALL_AGGR_CPU:
-		printed += print_total_stats(data, nr_data, fp);
+		printed += print_total_stats(data, nr_data, max_summary, fp);
 		break;
 	case SYSCALL_AGGR_CGROUP:
-		printed += print_cgroup_stats(data, nr_data, fp);
+		printed += print_cgroup_stats(data, nr_data, max_summary, fp);
 		break;
 	default:
 		break;
diff --git a/tools/perf/util/trace.h b/tools/perf/util/trace.h
index fa8d480527a22cef..fbbcfe6f44fe05ca 100644
--- a/tools/perf/util/trace.h
+++ b/tools/perf/util/trace.h
@@ -16,7 +16,7 @@ enum trace_summary_mode {
 int trace_prepare_bpf_summary(enum trace_summary_mode mode);
 void trace_start_bpf_summary(void);
 void trace_end_bpf_summary(void);
-int trace_print_bpf_summary(FILE *fp);
+int trace_print_bpf_summary(FILE *fp, int max_summary);
 void trace_cleanup_bpf_summary(void);
 
 #else /* !HAVE_BPF_SKEL */
@@ -27,7 +27,7 @@ static inline int trace_prepare_bpf_summary(enum trace_summary_mode mode __maybe
 }
 static inline void trace_start_bpf_summary(void) {}
 static inline void trace_end_bpf_summary(void) {}
-static inline int trace_print_bpf_summary(FILE *fp __maybe_unused)
+static inline int trace_print_bpf_summary(FILE *fp __maybe_unused, int max_summary __maybe_unused)
 {
 	return 0;
 }
-- 
2.51.0.rc1.193.gad69d77794-goog

