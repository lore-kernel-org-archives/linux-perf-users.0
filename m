Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31284199FC9;
	Tue,  7 Jan 2025 22:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736289834; cv=none; b=emUBJHaJl3jENNJjnc/bB/fnAgnqCh4INdHWdRCxZF/H9zx81xQ3S35VdNYTsAugOraab6PgcIOgJ7BQYFbScy8wpuOiuJctsA9Dok+c9irD9t6W/nWLrG0+sD5XFwUMohONvZZ59TnqVIVOYuvBGYKSzxoPBE1iIPgJA/yFMVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736289834; c=relaxed/simple;
	bh=FKU3Rzm1uF7rYj3GGVd8x6vCqs+S1l1Z9Ic3PgrImqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eZhIUrwvKFwDqK/lMsPjDaPUrw48cZ/r6DSMmNF5jYq714B/akqMsjUl8tDiKFPgMbrSnuwss5ACWZ0F4r28+eN7UvcDsvWcHaKFqBcmnpKd9m8BIvDvbO5d7mXrAX+czR4mX9sWBgtIGG1PkReM+OgN+ZzKExeMaf3ioVNC2PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hft0cpaT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hft0cpaT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613D6C4CED6;
	Tue,  7 Jan 2025 22:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736289833;
	bh=FKU3Rzm1uF7rYj3GGVd8x6vCqs+S1l1Z9Ic3PgrImqY=;
	h=From:To:Cc:Subject:Date:From;
	b=hft0cpaT27SB8s1kTnhEpu/MWYi/8L6z8C0EKIjkijwdd2tVZOfL1LQupFZnukdna
	 Uro826yOLWKyDnqtQL0UYEwp5ekutN0yuXh08jNmDNDSRvypgrUOw1VdLmOvgNEy7j
	 RNorYw7qpp1ONMOof+9R8HD+n3bH2UvH9dxsBXnd+N7cKFatXH2DRUsbsoukq3oRU+
	 Q9bbZflgT69amqkyPAkjwO2WwVmc+czXdAu/LUqn7qOug9+gGvQj2Nvr7IcGZhmLQA
	 TPSk9HSanm/w3PIfL0sMbr9shm0DDhQQhJd6RktzqWXm64hh1sbMY0FNr8js823rYo
	 ZhNtIfkUglAzQ==
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
	James Clark <james.clark@linaro.org>
Subject: [PATCH v2 1/3] perf ftrace: Display latency statistics at the end
Date: Tue,  7 Jan 2025 14:43:50 -0800
Message-ID: <20250107224352.1128669-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes users also want to see average latency as well as histogram.
Display latency statistics like avg, max, min at the end.

  $ sudo ./perf ftrace latency -ab -T synchronize_rcu -- ...
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

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-ftrace.c                 | 14 +++++++++++++-
 tools/perf/util/bpf_ftrace.c                | 12 +++++++++++-
 tools/perf/util/bpf_skel/func_latency.bpf.c | 19 +++++++++++++++++++
 tools/perf/util/ftrace.h                    |  6 ++++--
 4 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 834074162a63bf2b..2a786047ba32bcb7 100644
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
@@ -798,8 +800,10 @@ static void make_histogram(struct perf_ftrace *ftrace, int buckets[],
 		if (i >= NUM_BUCKET || num >= max_latency - min_latency)
 			i = NUM_BUCKET - 1;
 
+		num += min_latency;
 do_inc:
 		buckets[i]++;
+		update_stats(&latency_stats, num);
 
 next:
 		/* empty the line buffer for the next output  */
@@ -894,6 +898,12 @@ static void display_histogram(struct perf_ftrace *ftrace, int buckets[])
 	printf(" | %10d | %.*s%*s |\n", buckets[NUM_BUCKET - 1],
 	       bar_len, bar, bar_total - bar_len, "");
 
+	printf("\n# statistics  (in %s)\n", ftrace->use_nsec ? "nsec" : "usec");
+	printf("  total time: %20.0f\n", latency_stats.mean * latency_stats.n);
+	printf("    avg time: %20.0f\n", latency_stats.mean);
+	printf("    max time: %20"PRIu64"\n", latency_stats.max);
+	printf("    min time: %20"PRIu64"\n", latency_stats.min);
+	printf("       count: %20.0f\n", latency_stats.n);
 }
 
 static int prepare_func_latency(struct perf_ftrace *ftrace)
@@ -932,6 +942,8 @@ static int prepare_func_latency(struct perf_ftrace *ftrace)
 	if (fd < 0)
 		pr_err("failed to open trace_pipe\n");
 
+	init_stats(&latency_stats);
+
 	put_tracing_file(trace_file);
 	return fd;
 }
@@ -961,7 +973,7 @@ static int stop_func_latency(struct perf_ftrace *ftrace)
 static int read_func_latency(struct perf_ftrace *ftrace, int buckets[])
 {
 	if (ftrace->target.use_bpf)
-		return perf_ftrace__latency_read_bpf(ftrace, buckets);
+		return perf_ftrace__latency_read_bpf(ftrace, buckets, &latency_stats);
 
 	return 0;
 }
diff --git a/tools/perf/util/bpf_ftrace.c b/tools/perf/util/bpf_ftrace.c
index bc484e65fb8f69ca..25fc280e414ac5fe 100644
--- a/tools/perf/util/bpf_ftrace.c
+++ b/tools/perf/util/bpf_ftrace.c
@@ -11,6 +11,7 @@
 #include "util/debug.h"
 #include "util/evlist.h"
 #include "util/bpf_counter.h"
+#include "util/stat.h"
 
 #include "util/bpf_skel/func_latency.skel.h"
 
@@ -86,6 +87,8 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
 		}
 	}
 
+	skel->bss->min = INT64_MAX;
+
 	skel->links.func_begin = bpf_program__attach_kprobe(skel->progs.func_begin,
 							    false, func->name);
 	if (IS_ERR(skel->links.func_begin)) {
@@ -122,7 +125,7 @@ int perf_ftrace__latency_stop_bpf(struct perf_ftrace *ftrace __maybe_unused)
 }
 
 int perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace __maybe_unused,
-				  int buckets[])
+				  int buckets[], struct stats *stats)
 {
 	int i, fd, err;
 	u32 idx;
@@ -146,6 +149,13 @@ int perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace __maybe_unused,
 			buckets[idx] += hist[i];
 	}
 
+	if (skel->bss->count) {
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
index 4df54e1b1411b10a..fb144811b34fc72a 100644
--- a/tools/perf/util/bpf_skel/func_latency.bpf.c
+++ b/tools/perf/util/bpf_skel/func_latency.bpf.c
@@ -38,6 +38,12 @@ struct {
 
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
@@ -122,6 +128,8 @@ int BPF_PROG(func_end)
 					delta >= max_latency - min_latency)
 					key = NUM_BUCKET - 1;
 			}
+
+			delta += min_latency;
 			goto do_lookup;
 		}
 		// calculate index using delta
@@ -136,6 +144,17 @@ int BPF_PROG(func_end)
 			return 0;
 
 		*hist += 1;
+
+		if (bucket_range == 0)
+			delta /= cmp_base;
+
+		__sync_fetch_and_add(&total, delta);
+		__sync_fetch_and_add(&count, 1);
+
+		if (delta > max)
+			max = delta;
+		if (delta < min)
+			min = delta;
 	}
 
 	return 0;
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index f218703063f74786..5dee2caba0fe403f 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -7,6 +7,7 @@
 
 struct evlist;
 struct hashamp;
+struct stats;
 
 struct perf_ftrace {
 	struct evlist		*evlist;
@@ -46,7 +47,7 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace);
 int perf_ftrace__latency_start_bpf(struct perf_ftrace *ftrace);
 int perf_ftrace__latency_stop_bpf(struct perf_ftrace *ftrace);
 int perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace,
-				  int buckets[]);
+				  int buckets[], struct stats *stats);
 int perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace);
 
 #else  /* !HAVE_BPF_SKEL */
@@ -71,7 +72,8 @@ perf_ftrace__latency_stop_bpf(struct perf_ftrace *ftrace __maybe_unused)
 
 static inline int
 perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace __maybe_unused,
-			      int buckets[] __maybe_unused)
+			      int buckets[] __maybe_unused,
+			      struct stats *stats __maybe_unused)
 {
 	return -1;
 }
-- 
2.47.1.613.gc27f4b7a9f-goog

