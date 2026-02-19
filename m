Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5603221F15;
	Thu, 19 Feb 2026 00:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771461859; cv=none; b=PjLD3Hzk/7xrnYPGLMK0qBB55Fp6Opm9/dIQNCloQQzSWQdFSW7FMGWeHX0uBxAeAoVyTcam0boh8rOOVe1GhBfrPF6Wx8OXChtuWQbuG1F8nTBjqg29//1HBFZRKPHSYM7BOAVgFp/e20D7LDhqdmanVIXfd0rKWUWZhVwFq1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771461859; c=relaxed/simple;
	bh=moDKKo0ingnmWzxs5/JO6iF8OHKF0zphtYKC17MYtX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YoxFEBWbe/+acl6+MYkflnWl85yj6v4Dm9EMALNkPbUSp5fo0/rhzuZO5PzpDMHV+dWYBVi6Va48WlKjWbg0y/g5fS2bb5lRUYU452FUGAKUywyRx6ak8rBZHd7iwpG8p49mJ5GmaEG5InJPTKJkafIPJboMfU7uvRkN6A9kTMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsvCnuhw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsvCnuhw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2217EC19422;
	Thu, 19 Feb 2026 00:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771461859;
	bh=moDKKo0ingnmWzxs5/JO6iF8OHKF0zphtYKC17MYtX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TsvCnuhwnxdjEG8j6rGnxf+7wLrPFkpG5Cz/x3o8T7cAW4+0y+TBRUN8gM2tUFK8j
	 2LQBuohH71S6DrjfIWM6qqprLIDUbWFlhfB3A6k7+VKz7pqReROpmhC3oyIi2OI06r
	 emViVpsMZEl/52WIzGPHjY9KAQN+o9gyL9dbTNED+NOE11sZJHHO5EoNHuAurSMysW
	 ufOTXVV2bNLOgOPMWoShmMhMSXg11XYFjQY00qZAFtsJH6iUBvkcneEYgqULUWHUoD
	 nCiX/FSexMtrcBdnb4g8eSZ/hETGG0+VllMlSEA7Jmznqz2WOsRcWBnyZ4U1eDwi+A
	 Ev6FSqa9yPgJA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v2 2/2] perf bench: Add -t/--threads option to perf bench mem mmap
Date: Wed, 18 Feb 2026 16:44:17 -0800
Message-ID: <20260219004417.188434-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0.335.g19a08e0c02-goog
In-Reply-To: <20260219004417.188434-1-namhyung@kernel.org>
References: <20260219004417.188434-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So that it can measure overhead of mmap_lock and/or per-VMA lock
contention.

  $ perf bench mem mmap -f demand -l 1000 -t 1
  # Running 'mem/mmap' benchmark:
  # function 'demand' (Demand loaded mmap())
  # Copying 1MB bytes ...

         2.786858 GB/sec

  $ perf bench mem mmap -f demand -l 1000 -t 2
  # Running 'mem/mmap' benchmark:
  # function 'demand' (Demand loaded mmap())
  # Copying 1MB bytes ...

         1.624468 GB/sec/thread   ( +-   0.30% )

  $ perf bench mem mmap -f demand -l 1000 -t 3
  # Running 'mem/mmap' benchmark:
  # function 'demand' (Demand loaded mmap())
  # Copying 1MB bytes ...

         1.493068 GB/sec/thread   ( +-   0.15% )

  $ perf bench mem mmap -f demand -l 1000 -t 4
  # Running 'mem/mmap' benchmark:
  # function 'demand' (Demand loaded mmap())
  # Copying 1MB bytes ...

         1.006087 GB/sec/thread   ( +-   0.41% )

Cc: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2)
 * correct timeval2double calculation
 * add "/thread" notation when -t > 1  (James)
 * add stddev when -t > 1  (Ankur)

 tools/perf/Documentation/perf-bench.txt |   4 +
 tools/perf/bench/mem-functions.c        | 109 +++++++++++++++++++-----
 2 files changed, 92 insertions(+), 21 deletions(-)

diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
index 1160224cb718392d..c5913cf59c988421 100644
--- a/tools/perf/Documentation/perf-bench.txt
+++ b/tools/perf/Documentation/perf-bench.txt
@@ -274,6 +274,10 @@ Repeat mmap() invocation this number of times.
 --cycles::
 Use perf's cpu-cycles event instead of gettimeofday syscall.
 
+-t::
+--threads=<NUM>::
+Create multiple threads to call mmap/munmap concurrently.
+
 SUITES FOR 'numa'
 ~~~~~~~~~~~~~~~~~
 *mem*::
diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
index 676c8d18f4c2e259..8e04ae69f8a85c5e 100644
--- a/tools/perf/bench/mem-functions.c
+++ b/tools/perf/bench/mem-functions.c
@@ -7,13 +7,14 @@
  * Written by Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
  */
 
-#include "debug.h"
+#include "bench.h"
 #include "../perf-sys.h"
 #include <subcmd/parse-options.h>
-#include "../util/header.h"
-#include "../util/cloexec.h"
-#include "../util/string2.h"
-#include "bench.h"
+#include "util/cloexec.h"
+#include "util/debug.h"
+#include "util/header.h"
+#include "util/stat.h"
+#include "util/string2.h"
 #include "mem-memcpy-arch.h"
 #include "mem-memset-arch.h"
 
@@ -26,6 +27,7 @@
 #include <errno.h>
 #include <linux/time64.h>
 #include <linux/log2.h>
+#include <pthread.h>
 
 #define K 1024
 
@@ -41,6 +43,7 @@ static unsigned int	nr_loops	= 1;
 static bool		use_cycles;
 static int		cycles_fd;
 static unsigned int	seed;
+static unsigned int	nr_threads	= 1;
 
 static const struct option bench_common_options[] = {
 	OPT_STRING('s', "size", &size_str, "1MB",
@@ -121,6 +124,8 @@ static struct perf_event_attr cycle_attr = {
 	.config		= PERF_COUNT_HW_CPU_CYCLES
 };
 
+static struct stats stats;
+
 static int init_cycles(void)
 {
 	cycles_fd = sys_perf_event_open(&cycle_attr, getpid(), -1, -1, perf_event_open_cloexec_flag());
@@ -174,18 +179,18 @@ static void clock_accum(union bench_clock *a, union bench_clock *b)
 
 static double timeval2double(struct timeval *ts)
 {
-	return (double)ts->tv_sec + (double)ts->tv_usec / (double)USEC_PER_SEC;
+	return ((double)ts->tv_sec + (double)ts->tv_usec / (double)USEC_PER_SEC) / nr_threads;
 }
 
 #define print_bps(x) do {						\
 		if (x < K)						\
-			printf(" %14lf bytes/sec\n", x);		\
+			printf(" %14lf bytes/sec", x);			\
 		else if (x < K * K)					\
-			printf(" %14lfd KB/sec\n", x / K);		\
+			printf(" %14lfd KB/sec", x / K);		\
 		else if (x < K * K * K)					\
-			printf(" %14lf MB/sec\n", x / K / K);		\
+			printf(" %14lf MB/sec", x / K / K);		\
 		else							\
-			printf(" %14lf GB/sec\n", x / K / K / K);	\
+			printf(" %14lf GB/sec", x / K / K / K);	\
 	} while (0)
 
 static void __bench_mem_function(struct bench_mem_info *info, struct bench_params *p,
@@ -197,6 +202,7 @@ static void __bench_mem_function(struct bench_mem_info *info, struct bench_param
 	void *src = NULL, *dst = NULL;
 
 	memset(&rt, 0, sizeof(rt));
+	init_stats(&stats);
 	printf("# function '%s' (%s)\n", r->name, r->desc);
 
 	if (r->fn.init && r->fn.init(info, p, &src, &dst))
@@ -211,11 +217,16 @@ static void __bench_mem_function(struct bench_mem_info *info, struct bench_param
 	switch (bench_format) {
 	case BENCH_FORMAT_DEFAULT:
 		if (use_cycles) {
-			printf(" %14lf cycles/byte\n", (double)rt.cycles/(double)p->size_total);
+			printf(" %14lf cycles/byte", (double)rt.cycles/(double)p->size_total);
 		} else {
 			result_bps = (double)p->size_total/timeval2double(&rt.tv);
 			print_bps(result_bps);
 		}
+		if (nr_threads > 1) {
+			printf("/thread\t( +- %6.2f%% )",
+			       rel_stddev_stats(stddev_stats(&stats), avg_stats(&stats)));
+		}
+		printf("\n");
 		break;
 
 	case BENCH_FORMAT_SIMPLE:
@@ -495,16 +506,27 @@ static void mmap_page_touch(void *dst, size_t size, unsigned int page_shift, boo
 	}
 }
 
-static int do_mmap(const struct function *r, struct bench_params *p,
-		  void *src __maybe_unused, void *dst __maybe_unused,
-		  union bench_clock *accum)
+struct mmap_data {
+	pthread_t id;
+	const struct function *func;
+	struct bench_params *params;
+	union bench_clock result;
+	unsigned int seed;
+	int error;
+};
+
+static void *do_mmap_thread(void *arg)
 {
+	struct mmap_data *data = arg;
+	const struct function *r = data->func;
+	struct bench_params *p = data->params;
 	union bench_clock start, end, diff;
 	mmap_op_t fn = r->fn.mmap_op;
 	bool populate = strcmp(r->name, "populate") == 0;
+	void *dst;
 
-	if (p->seed)
-		srand(p->seed);
+	if (data->seed)
+		srand(data->seed);
 
 	for (unsigned int i = 0; i < p->nr_loops; i++) {
 		clock_get(&start);
@@ -515,16 +537,59 @@ static int do_mmap(const struct function *r, struct bench_params *p,
 		fn(dst, p->size, p->page_shift, p->seed);
 		clock_get(&end);
 		diff = clock_diff(&start, &end);
-		clock_accum(accum, &diff);
+		clock_accum(&data->result, &diff);
 
 		bench_munmap(dst, p->size);
 	}
 
-	return 0;
+	return data;
 out:
-	printf("# Memory allocation failed - maybe size (%s) %s?\n", size_str,
-			p->page_shift != PAGE_SHIFT_4KB ? "has insufficient hugepages" : "is too large");
-	return -1;
+	data->error = -ENOMEM;
+	return NULL;
+}
+
+static int do_mmap(const struct function *r, struct bench_params *p,
+		  void *src __maybe_unused, void *dst __maybe_unused,
+		  union bench_clock *accum)
+{
+	struct mmap_data *data;
+	int error = 0;
+
+	data = calloc(nr_threads, sizeof(*data));
+	if (!data) {
+		printf("# Failed to allocate thread resources\n");
+		return -1;
+	}
+
+	for (unsigned int i = 0; i < nr_threads; i++) {
+		data[i].func = r;
+		data[i].params = p;
+		if (p->seed)
+			data[i].seed = p->seed + i;
+
+		if (pthread_create(&data[i].id, NULL, do_mmap_thread, &data[i]) < 0)
+			data[i].error = -errno;
+	}
+
+	for (unsigned int i = 0; i < nr_threads; i++) {
+		union bench_clock *t = &data[i].result;
+
+		pthread_join(data[i].id, NULL);
+
+		clock_accum(accum, t);
+		if (use_cycles)
+			update_stats(&stats, t->cycles);
+		else
+			update_stats(&stats, t->tv.tv_sec * 1e6 + t->tv.tv_usec);
+		error |= data[i].error;
+	}
+	free(data);
+
+	if (error) {
+		printf("# Memory allocation failed - maybe size (%s) %s?\n", size_str,
+		       p->page_shift != PAGE_SHIFT_4KB ? "has insufficient hugepages" : "is too large");
+	}
+	return error ? -1 : 0;
 }
 
 static const char * const bench_mem_mmap_usage[] = {
@@ -549,6 +614,8 @@ int bench_mem_mmap(int argc, const char **argv)
 	static const struct option bench_mmap_options[] = {
 		OPT_UINTEGER('r', "randomize", &seed,
 			    "Seed to randomize page access offset."),
+		OPT_UINTEGER('t', "threads", &nr_threads,
+			    "Number of threads to run concurrently (default: 1)."),
 		OPT_PARENT(bench_common_options),
 		OPT_END()
 	};
-- 
2.53.0.335.g19a08e0c02-goog

