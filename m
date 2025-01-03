Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6721B6CF5;
	Fri,  3 Jan 2025 23:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735946191; cv=none; b=Rfxsps8LwkxVmg30v0qAa7UY1S2pe8Mj7FuGBJuLfJ7wNxbGr5gmY5AyrzZqgBKath65zXqE6luc8ZAcH+4GOJbvY+d4dn5wqc8XcFz1GzyVGWkWwp8do3BcyZLD8RgOF8ZRm9/0aCFylJL7JJB/u9tmbZDvnsMQCw0MWTReVVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735946191; c=relaxed/simple;
	bh=/9MTfDPmHerPwOCgOWQhnhD0RTm98dIhO51bYaZeFYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sZC9rox4zLhbsY3FNlivoU8R1GLRJtFHJN5e1SXkbdWlLGeduAU1YGECLttKYBubwyYIL/pANH1GW5eycVBYFLrgWY3oWGV63mmY0jjVf+iKfQDLkqhRImXbxRVcDGnZyg5aF9aZ1caMEoCfMN/n6vckQWImSDvgcpLF0MoLxwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A54exbpy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A54exbpy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0F2C4CEDD;
	Fri,  3 Jan 2025 23:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735946191;
	bh=/9MTfDPmHerPwOCgOWQhnhD0RTm98dIhO51bYaZeFYA=;
	h=From:To:Cc:Subject:Date:From;
	b=A54exbpy1XOnTer0qnVkz0+wE2grrFkWkYRJy143YlNWH5Jf2oQND0RfIysk1wflh
	 O5aQjpSBM9zRRYZ4FPyzkH5iWw0o1EnuftQlHLYpXYNacDPtZUfAUvQ9PbvRdZmWa1
	 vsrLj1IRfK3zafLT/TbbX4XPNE+R5jHV3CIT+5ZLLWgApVV8RNmELLNA8F0FD+Yy8B
	 CX4GGxNF5TPkOaH4mwPIf7+ano1zmMPpNtsSubs+8SN/oVnqBjp6feH5CGKi3WekO/
	 gWS7FS1wO4KwauZWcg0BFAj1uEh53wq9kqVbwgXtTtf/v4klXoNXXrfK6sOzmjaJHe
	 3JX6DDli3Ox/g==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/3] perf ftrace: Add --stats option to latency subcommand
Date: Fri,  3 Jan 2025 15:16:28 -0800
Message-ID: <20250103231630.928815-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes users also want to see average latency as well as histogram.
The --stats option is to display latency statistics at the end.

  $ sudo ./perf ftrace latency -ab --stats -T synchronize_rcu -- ...
  #   DURATION     |      COUNT | GRAPH                                          |
       0 - 1    us |          0 |                                                |
       1 - 2    us |          0 |                                                |
       2 - 4    us |          0 |                                                |
       4 - 8    us |          0 |                                                |
       8 - 16   us |          0 |                                                |
      16 - 32   us |          0 |                                                |
      32 - 64   us |          0 |                                                |
      64 - 128  us |          0 |                                                |
     128 - 256  us |          0 |                                                |
     256 - 512  us |          0 |                                                |
     512 - 1024 us |          0 |                                                |
       1 - 2    ms |          0 |                                                |
       2 - 4    ms |          0 |                                                |
       4 - 8    ms |          0 |                                                |
       8 - 16   ms |          1 | #####                                          |
      16 - 32   ms |          7 | ########################################       |
      32 - 64   ms |          0 |                                                |
      64 - 128  ms |          0 |                                                |
     128 - 256  ms |          0 |                                                |
     256 - 512  ms |          0 |                                                |
     512 - 1024 ms |          0 |                                                |
       1 - ...   s |          0 |                                                |

  # statistics  (in usec)
    total time:               171832
      avg time:                21479
      max time:                30906
      min time:                15869
         count:                    8

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-ftrace.txt    |  4 ++++
 tools/perf/builtin-ftrace.c                 | 24 ++++++++++++++++++++-
 tools/perf/util/bpf_ftrace.c                | 16 ++++++++++++--
 tools/perf/util/bpf_skel/func_latency.bpf.c | 19 ++++++++++++++++
 tools/perf/util/ftrace.h                    |  4 +++-
 5 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index eccc0483f7faecad..16b067eb5d84746d 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -160,6 +160,10 @@ OPTIONS for 'perf ftrace latency'
 	-n/--use-nsec). The setting is ignored if the value results in more than
 	22 buckets.
 
+--stats::
+	Display latency statistics at the end.
+
+
 OPTIONS for 'perf ftrace profile'
 ---------------------------------
 
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 834074162a63bf2b..0ac2b20b272bd790 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -43,6 +43,8 @@
 static volatile sig_atomic_t workload_exec_errno;
 static volatile sig_atomic_t done;
 
+static struct stats latency_stats;  /* for tracepoints */
+
 static void sig_handler(int sig __maybe_unused)
 {
 	done = true;
@@ -801,6 +803,13 @@ static void make_histogram(struct perf_ftrace *ftrace, int buckets[],
 do_inc:
 		buckets[i]++;
 
+		if (ftrace->stats) {
+			if (num >= min_latency)
+				num += min_latency;
+
+			update_stats(&latency_stats, num);
+		}
+
 next:
 		/* empty the line buffer for the next output  */
 		linebuf[0] = '\0';
@@ -894,6 +903,14 @@ static void display_histogram(struct perf_ftrace *ftrace, int buckets[])
 	printf(" | %10d | %.*s%*s |\n", buckets[NUM_BUCKET - 1],
 	       bar_len, bar, bar_total - bar_len, "");
 
+	if (ftrace->stats) {
+		printf("\n# statistics  (in %s)\n", ftrace->use_nsec ? "nsec" : "usec");
+		printf("  total time: %20.0f\n", latency_stats.mean * latency_stats.n);
+		printf("    avg time: %20.0f\n", latency_stats.mean);
+		printf("    max time: %20"PRIu64"\n", latency_stats.max);
+		printf("    min time: %20"PRIu64"\n", latency_stats.min);
+		printf("       count: %20.0f\n", latency_stats.n);
+	}
 }
 
 static int prepare_func_latency(struct perf_ftrace *ftrace)
@@ -932,6 +949,9 @@ static int prepare_func_latency(struct perf_ftrace *ftrace)
 	if (fd < 0)
 		pr_err("failed to open trace_pipe\n");
 
+	if (ftrace->stats)
+		init_stats(&latency_stats);
+
 	put_tracing_file(trace_file);
 	return fd;
 }
@@ -961,7 +981,7 @@ static int stop_func_latency(struct perf_ftrace *ftrace)
 static int read_func_latency(struct perf_ftrace *ftrace, int buckets[])
 {
 	if (ftrace->target.use_bpf)
-		return perf_ftrace__latency_read_bpf(ftrace, buckets);
+		return perf_ftrace__latency_read_bpf(ftrace, buckets, &latency_stats);
 
 	return 0;
 }
@@ -1620,6 +1640,8 @@ int cmd_ftrace(int argc, const char **argv)
 		    "Minimum latency (1st bucket). Works only with --bucket-range."),
 	OPT_UINTEGER(0, "max-latency", &ftrace.max_latency,
 		    "Maximum latency (last bucket). Works only with --bucket-range and total buckets less than 22."),
+	OPT_BOOLEAN(0, "stats", &ftrace.stats,
+		    "Collect function latency stats too"),
 	OPT_PARENT(common_options),
 	};
 	const struct option profile_options[] = {
diff --git a/tools/perf/util/bpf_ftrace.c b/tools/perf/util/bpf_ftrace.c
index bc484e65fb8f69ca..ecd5e16df9730e0d 100644
--- a/tools/perf/util/bpf_ftrace.c
+++ b/tools/perf/util/bpf_ftrace.c
@@ -11,6 +11,7 @@
 #include "util/debug.h"
 #include "util/evlist.h"
 #include "util/bpf_counter.h"
+#include "util/stat.h"
 
 #include "util/bpf_skel/func_latency.skel.h"
 
@@ -53,6 +54,7 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
 	}
 
 	skel->rodata->use_nsec = ftrace->use_nsec;
+	skel->rodata->stats = ftrace->stats;
 
 	set_max_rlimit();
 
@@ -86,6 +88,9 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
 		}
 	}
 
+	if (ftrace->stats)
+		skel->bss->min = INT64_MAX;
+
 	skel->links.func_begin = bpf_program__attach_kprobe(skel->progs.func_begin,
 							    false, func->name);
 	if (IS_ERR(skel->links.func_begin)) {
@@ -121,8 +126,8 @@ int perf_ftrace__latency_stop_bpf(struct perf_ftrace *ftrace __maybe_unused)
 	return 0;
 }
 
-int perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace __maybe_unused,
-				  int buckets[])
+int perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace,
+				  int buckets[], struct stats *stats)
 {
 	int i, fd, err;
 	u32 idx;
@@ -146,6 +151,13 @@ int perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace __maybe_unused,
 			buckets[idx] += hist[i];
 	}
 
+	if (ftrace->stats && skel->bss->count) {
+		stats->mean = skel->bss->total / skel->bss->count;
+		stats->n = skel->bss->count;
+		stats->max = skel->bss->max;
+		stats->min = skel->bss->min;
+	}
+
 	free(hist);
 	return 0;
 }
diff --git a/tools/perf/util/bpf_skel/func_latency.bpf.c b/tools/perf/util/bpf_skel/func_latency.bpf.c
index 4df54e1b1411b10a..9b68eea8fd444699 100644
--- a/tools/perf/util/bpf_skel/func_latency.bpf.c
+++ b/tools/perf/util/bpf_skel/func_latency.bpf.c
@@ -38,12 +38,19 @@ struct {
 
 int enabled = 0;
 
+// stats
+__s64 total;
+__s64 count;
+__s64 max;
+__s64 min;
+
 const volatile int has_cpu = 0;
 const volatile int has_task = 0;
 const volatile int use_nsec = 0;
 const volatile unsigned int bucket_range;
 const volatile unsigned int min_latency;
 const volatile unsigned int max_latency;
+const volatile int stats = 0;
 
 SEC("kprobe/func")
 int BPF_PROG(func_begin)
@@ -136,6 +143,18 @@ int BPF_PROG(func_end)
 			return 0;
 
 		*hist += 1;
+
+		if (stats) {
+			delta /= cmp_base;
+
+			__sync_fetch_and_add(&total, delta);
+			__sync_fetch_and_add(&count, 1);
+
+			if (delta > max)
+				max = delta;
+			if (delta < min)
+				min = delta;
+		}
 	}
 
 	return 0;
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index f218703063f74786..76038ed712085fbc 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -7,6 +7,7 @@
 
 struct evlist;
 struct hashamp;
+struct stats;
 
 struct perf_ftrace {
 	struct evlist		*evlist;
@@ -23,6 +24,7 @@ struct perf_ftrace {
 	unsigned int		bucket_range;
 	unsigned int		min_latency;
 	unsigned int		max_latency;
+	bool			stats;
 	int			graph_depth;
 	int			func_stack_trace;
 	int			func_irq_info;
@@ -46,7 +48,7 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace);
 int perf_ftrace__latency_start_bpf(struct perf_ftrace *ftrace);
 int perf_ftrace__latency_stop_bpf(struct perf_ftrace *ftrace);
 int perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace,
-				  int buckets[]);
+				  int buckets[], struct stats *stats);
 int perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace);
 
 #else  /* !HAVE_BPF_SKEL */
-- 
2.47.1.613.gc27f4b7a9f-goog

