Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33EC479884
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759792; cv=none; b=sFdBBaat97NDs2NGode1c2iVe6Na8YI3BsUEw7qJyDxp49rmdJZUhoYJG5fSYZJXRC2eaaKyynMqf3BIcFx01/XBi5a5dj9hQ6qm46HGllRK6/Hnb8noGPOJqLf8QXqzM8JNiQrwmO16rbHqYV+KNqwx2a6iTeIi93WeouKwqlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759792; c=relaxed/simple;
	bh=g4Y5Ioh1PNKD1m8pIgh2Ofp5Df1IWYwPbOTKbtrXEy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hFtstQ4qlHdwHREsn6LYdnci4TgYpVIrBIV5KWUzPwsEa/NJxoSwNVhVYMTJcn5aY/Lz026ABLO95xLrw5zXTY3il/lEd0Xg/sAyY1EWjWf+0EUFd624QZdggOHhaFwVhyBDCTNfOBh6qjGkt5VrNjL7+uKR8lBZFhlI2Nn7m+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=syTZTJyz; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syTZTJyz"
Received: by mail-pz2-f37.google.com with SMTP id 41be03b00d2f7-cc7c4c92477so1070242a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 02:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790759790; x=1791364590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WYucAYlC1aLIWcQy1lYFzdZNT5TnSScFxgAFNJOXc7Y=;
        b=syTZTJyzR3VQNuu8rTfCd/UFGciECHndY9/LrYc290c4MgbVStmoWoZkD0MvkztGXc
         dZmo1QBwfxKD3O47l4AJZMn2vxmLJDYiBBhyh5AUyCf+S8+0+RpNcz/WmPlYUgH8A7dt
         4VEG7TjCuqJ+tP1XdngbwH99RLfWHQIE+q3IIwpTsOgv1WlIap5Bx0DJM4s9iRI+4gKI
         0wM+cYpMdHAoqdlwpge4B4d6VGFPWFftloEpmFxyF/7xeeKfHQ6NE40T6CaDJmTPqwbY
         9rYyExoftWqxsxB279NXpDkwTm7acmuT3cht9nDu9F9i1yVVPXFk4y+HWCd1l2KYzird
         IrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790759790; x=1791364590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WYucAYlC1aLIWcQy1lYFzdZNT5TnSScFxgAFNJOXc7Y=;
        b=VO7XmqnUimGYpvcxfdaQYeiQZ22f80bBGfG4lOv7ZP0MJl2CvdEpcKM5vV8GaMrEgq
         oLDpF9N5wuwbEgctY4GmzFEzT9X3q63ZHcyUjdvR/yhSbYc0SzoKNSE/RvS0BQqV2Hkn
         VOsdQmgHHqEEduMgf2GGte+LDv31y5Sr6IcLuAjZvtAqRoM6pJb5vNSl3yKag+7iMzeJ
         Q0arGOZP/DVpWQ3QBjsWk2C09HPYRlnbsFCFa34pbvWe376QTAg1iZo3y38jXMrnypEh
         0D9C841B3V5Rl0iDmpCSLtpelvxfGeQ/UvLrBwk5LTxkEAv8H9WeQ7+0HLmZMGgGLNXA
         +TgQ==
X-Forwarded-Encrypted: i=1; AKwUvBy1iIxfWdjcGTwf3JbWCepzuEG3amUV8oZDzwDhf6m7XIjCwG+P4w/McUVFq8upyEL359akRH4+mzY09Iq6GvMY@vger.kernel.org
X-Gm-Message-State: AFq9FYLyvRw2ZElIk6isxAC9enzYkwc+Jt0osuPQVm0R5tfm7tZputjR
	68n9f3i+XWDEpLKoi6/Hl/zrOl/i59+52k1lkkEvT6PO0QCVgdKAAT5PW7i6cOwa
X-Gm-Gg: AYBFou04gnEYUOKsk1h/PmPd32OM2MCoZwhJhBzoXXhIxqTdOzq4QzC7Q1uwm/kt3J+
	DLj6SWu6XvDVtysjq5oTicev/xGR6u2D4+M4Cf1WhdKeYxTYRLjGcohTsEtQoDiOy23x4Xxb67L
	z8vd5TtrkB5uPXUv/s0JDTQjBv4U3ljLH/aaJaH1noMaD15LREbR4cnk+gcY/Mi8tJjR2fRc+iS
	6M9hAP4sQaZ0OzHxfNJhhjPA/OHavALayIw04c/K51zcG9Ukr2YJ2ziJ5lHMK2idTw8M4Dp+7gN
	3zADqKqkhYMaZ5mh/iXP7ilzTCwQst/vedPpeYQz82daCjrkYUDPvWQf9cYqiXkR0ltRCWD4BPA
	O82NqmJflzd8uDHcbFlvYdCZbsPd+uApb613u9E1MDxHfXdzYZ7E1NffCw8GNOru+QAI2XFOIKs
	N0tSpGqPCx7l+ucrFt8v/9p565smZSI/e83ALujV7ZT2dVwvZHatIqgKofLQQAaQlCzw==
X-Received: by 2002:a17:90b:538f:b0:39e:6c68:c77b with SMTP id 98e67ed59e1d1-3a4d18d5da0mr736762a91.49.1790759789619;
        Wed, 30 Sep 2026 02:16:29 -0700 (PDT)
Received: from morefine ([5.34.221.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4ce419342sm2291724a91.16.2026.09.30.02.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 02:16:29 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] perf bench: Add atomic CAS benchmark
Date: Wed, 30 Sep 2026 17:16:17 +0800
Message-ID: <20260930091617.4189736-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new 'atomic' collection to perf bench for benchmarking
compare-and-swap (CAS) atomic operations with multi-threaded
contention testing.

The benchmark tests __atomic_compare_exchange_n operations
with configurable thread count and iteration count to measure
atomic contention effects.

Why this benchmark is needed:
- CAS operations are fundamental to lock-free algorithms and data
  structures. Understanding their performance characteristics under
  contention is critical for designing high-performance concurrent
  applications.
- The benchmark helps identify atomic operation latency and
  scalability issues across different thread counts, revealing
  contention patterns that are not visible in single-threaded tests.
- Useful for evaluating atomic implementation quality on different
  architectures and for regression testing after changes to atomic
  primitives or memory ordering.

Measurement methodology:
- Each thread starts a private timer (clock_gettime CLOCK_MONOTONIC)
  after synchronizing on a pthread_barrier, ensuring all threads
  begin simultaneously.
- Each thread performs a hot loop of atomic compare-and-swap on a
  shared u64 counter, incrementing from 0 to iterations.
- The shared counter is cache-line aligned (64 bytes) to isolate
  contention to the target cache line and avoid false sharing.
- The wall-clock time is measured as the max of all per-thread
  runtimes (the time for the slowest thread to finish).
- The first repeat is excluded from statistics as a warmup phase
  to avoid cache-cold effects.
Example usage:
  $ perf bench atomic cas --threads 2
  # Running 'atomic/cas' benchmark:

    Threads: 2, iterations/thread: 100000000, repeats: 10 (warmup: 1)
    Avg wall-clock time: 7365.480 msec  (stddev 66.014 msec)
    Total ops: 200,000,000
    Throughput total: 27,153,697 ops/sec
    Per-thread times and throughput (last repeat):
      fastest:  7510.031 msec  (13315525 ops/sec)
      slowest:  7581.678 msec  (13189692 ops/sec)
      avg:      7545.854 msec  (13252310 ops/sec)

Output fields explained:
- Threads: number of contending threads
- iterations/thread: CAS operations each thread performs
- repeats: number of test runs (first is warmup)
- Avg wall-clock time: mean time for all threads to complete
- stddev: standard deviation across repeats
- Total ops: threads x iterations/thread
- Throughput total: aggregate ops/sec across all threads
- Per-thread times: fastest/slowest/avg thread completion time
- Per-thread throughput: per-thread ops/sec (shows scheduling imbalance)

Assisted-by: opencode:DeepSeek-V4-Pro
Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/Documentation/perf-bench.txt |  22 +++
 tools/perf/bench/Build                  |   1 +
 tools/perf/bench/atomic.c               | 229 ++++++++++++++++++++++++
 tools/perf/bench/bench.h                |   1 +
 tools/perf/builtin-bench.c              |   8 +
 5 files changed, 261 insertions(+)
 create mode 100644 tools/perf/bench/atomic.c

diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
index c5913cf59c98..9cdc19f02bcf 100644
--- a/tools/perf/Documentation/perf-bench.txt
+++ b/tools/perf/Documentation/perf-bench.txt
@@ -58,6 +58,9 @@ SUBSYSTEM
 'numa'::
 	NUMA scheduling and MM benchmarks.
 
+'atomic'::
+	Atomic operation benchmarks.
+
 'futex'::
 	Futex stressing benchmarks.
 
@@ -283,6 +286,25 @@ SUITES FOR 'numa'
 *mem*::
 Suite for evaluating NUMA workloads.
 
+SUITES FOR 'atomic'
+~~~~~~~~~~~~~~~~~~~
+*cas*::
+Suite for evaluating compare-and-swap (CAS) atomic operations under
+multi-threaded contention.
+
+Options of *cas*
+^^^^^^^^^^^^^^^^
+-t::
+--threads=::
+Number of threads contending for the shared counter (default: 2).
+
+-i::
+--iterations=::
+Number of iterations per thread (default: 100000000).
+
+The per-thread fastest/slowest/avg summary is only printed when
+running with more than one thread.
+
 SUITES FOR 'futex'
 ~~~~~~~~~~~~~~~~~~
 *hash*::
diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
index 67b76fe20ba6..c64c52468d3d 100644
--- a/tools/perf/bench/Build
+++ b/tools/perf/bench/Build
@@ -3,6 +3,7 @@ perf-bench-y += sched-pipe.o
 perf-bench-y += sched-seccomp-notify.o
 perf-bench-y += syscall.o
 perf-bench-y += mem-functions.o
+perf-bench-y += atomic.o
 perf-bench-y += futex.o
 perf-bench-y += futex-hash.o
 perf-bench-y += futex-wake.o
diff --git a/tools/perf/bench/atomic.c b/tools/perf/bench/atomic.c
new file mode 100644
index 000000000000..ce97025018ab
--- /dev/null
+++ b/tools/perf/bench/atomic.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Changbin Du
+ *
+ * Benchmark for atomic compare-and-swap (CAS) operations.
+ *
+ * Measures throughput (ops/sec) of contended CAS on a single shared
+ * counter across multiple threads. Each thread performs a hot loop
+ * of compare-and-swap, competing with all other threads for the
+ * same cache line.
+ */
+#include "bench.h"
+#include <linux/compiler.h>
+#include "../util/debug.h"
+
+#ifndef HAVE_PTHREAD_BARRIER
+int bench_atomic(int argc __maybe_unused, const char **argv __maybe_unused)
+{
+	pr_err("%s: pthread_barrier_t unavailable, disabling this test...\n", __func__);
+	return 0;
+}
+#else /* HAVE_PTHREAD_BARRIER */
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <pthread.h>
+#include <time.h>
+#include <inttypes.h>
+#include <err.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/time64.h>
+#include <subcmd/parse-options.h>
+#include "../util/stat.h"
+
+static unsigned int threads	= 2;
+static unsigned int iterations	= 100000000;
+
+static const struct option options[] = {
+	OPT_UINTEGER('t', "threads", &threads,
+		     "Number of threads contending for the counter"),
+	OPT_UINTEGER('i', "iterations", &iterations,
+		     "Number of iterations per thread"),
+	OPT_END()
+};
+
+static const char * const bench_usage[] = {
+	"perf bench atomic cas <options>",
+	NULL
+};
+
+static u64 shared_counter __aligned(64);
+static pthread_barrier_t start_barrier __aligned(64);
+
+struct worker_stats {
+	u64	runtime_ns;
+};
+
+static void *worker(void *arg)
+{
+	struct worker_stats *ws = (struct worker_stats *)arg;
+	struct timespec tstart, tend;
+	u64 i;
+
+	pthread_barrier_wait(&start_barrier);
+
+	clock_gettime(CLOCK_MONOTONIC, &tstart);
+	for (i = 0; i < iterations; i++) {
+		u64 old_val, new_val;
+
+		do {
+			old_val = __atomic_load_n(&shared_counter,
+						  __ATOMIC_RELAXED);
+			new_val = old_val + 1;
+		} while (!__atomic_compare_exchange_n(&shared_counter,
+						      &old_val, new_val,
+						      false,
+						      __ATOMIC_RELAXED,
+						      __ATOMIC_RELAXED));
+	}
+	clock_gettime(CLOCK_MONOTONIC, &tend);
+
+	ws->runtime_ns	= (tend.tv_sec - tstart.tv_sec) * NSEC_PER_SEC +
+			  (tend.tv_nsec - tstart.tv_nsec);
+
+	return NULL;
+}
+
+static void print_default_format(struct worker_stats *wstats,
+				 struct stats *time_stats)
+{
+	double time_avg, time_stddev;
+
+	printf("  Threads: %u, iterations/thread: %u, repeats: %u (warmup: 1)\n",
+	       threads, iterations, bench_repeat);
+
+	time_avg    = avg_stats(time_stats);
+	time_stddev = stddev_stats(time_stats);
+
+	printf("  Avg wall-clock time: %.3f msec  (stddev %.3f msec)\n",
+	       time_avg / (double)NSEC_PER_MSEC,
+	       time_stddev / (double)NSEC_PER_MSEC);
+	printf("  Total ops: %'" PRIu64 "\n",
+	       iterations * (u64)threads);
+	printf("  Throughput total: %'.0f ops/sec\n",
+	       (double)(iterations * (u64)threads) /
+	       (time_avg / (double)NSEC_PER_SEC));
+
+	/*
+	 * Per-thread statistics from the last measured repeat show
+	 * fairness / imbalance in CPU scheduling.
+	 */
+	if (threads > 1) {
+		u64 min_ns = UINT64_MAX, max_ns = 0, total_ns = 0;
+		double min_thru, max_thru, avg_thru;
+
+		for (unsigned int t = 0; t < threads; t++) {
+			if (wstats[t].runtime_ns < min_ns)
+				min_ns = wstats[t].runtime_ns;
+			if (wstats[t].runtime_ns > max_ns)
+				max_ns = wstats[t].runtime_ns;
+			total_ns += wstats[t].runtime_ns;
+		}
+
+		min_thru = (double)iterations * NSEC_PER_SEC / min_ns;
+		max_thru = (double)iterations * NSEC_PER_SEC / max_ns;
+		avg_thru = (double)threads * iterations * NSEC_PER_SEC / total_ns;
+
+		printf("  Per-thread times and throughput (last repeat):\n");
+		printf("    fastest:  %.3f msec  (%.0f ops/sec)\n",
+		       min_ns / (double)NSEC_PER_MSEC, min_thru);
+		printf("    slowest:  %.3f msec  (%.0f ops/sec)\n",
+		       max_ns / (double)NSEC_PER_MSEC, max_thru);
+		printf("    avg:      %.3f msec  (%.0f ops/sec)\n",
+		       (total_ns / threads) / (double)NSEC_PER_MSEC, avg_thru);
+	}
+}
+
+static int run_cas_benchmark(void)
+{
+	pthread_t *thread_ids;
+	struct worker_stats *wstats;
+	struct stats time_stats;
+	unsigned int r, t;
+
+	thread_ids = calloc(threads, sizeof(pthread_t));
+	if (!thread_ids)
+		return -1;
+
+	wstats = calloc(threads, sizeof(struct worker_stats));
+	if (!wstats) {
+		free(thread_ids);
+		return -1;
+	}
+
+	init_stats(&time_stats);
+
+	for (r = 0; r < bench_repeat + 1; r++) {
+		u64 max_runtime_ns = 0;
+
+		shared_counter = 0;
+		pthread_barrier_init(&start_barrier, NULL, threads);
+
+		for (t = 0; t < threads; t++) {
+			if (pthread_create(&thread_ids[t], NULL,
+					   worker, &wstats[t]))
+				err(EXIT_FAILURE, "pthread_create");
+		}
+
+		for (t = 0; t < threads; t++)
+			pthread_join(thread_ids[t], NULL);
+
+		pthread_barrier_destroy(&start_barrier);
+
+		for (t = 0; t < threads; t++) {
+			if (wstats[t].runtime_ns > max_runtime_ns)
+				max_runtime_ns = wstats[t].runtime_ns;
+		}
+
+		/*
+		 * Exclude the first repeat (warmup) from statistics so
+		 * that cache-cold and lazy-init effects are not counted.
+		 */
+		if (r > 0)
+			update_stats(&time_stats, max_runtime_ns);
+	}
+
+	switch (bench_format) {
+	case BENCH_FORMAT_DEFAULT:
+		print_default_format(wstats, &time_stats);
+		break;
+
+	case BENCH_FORMAT_SIMPLE:
+		printf("%.0f\n",
+		       (double)(iterations * (u64)threads) /
+		       (avg_stats(&time_stats) / (double)NSEC_PER_SEC));
+		break;
+
+	default:
+		fprintf(stderr, "Unknown format: %d\n", bench_format);
+		exit(EXIT_FAILURE);
+	}
+
+	free(thread_ids);
+	free(wstats);
+
+	return 0;
+}
+
+int bench_atomic(int argc, const char **argv)
+{
+	if (parse_options(argc, argv, options, bench_usage, 0)) {
+		usage_with_options(bench_usage, options);
+		exit(EXIT_FAILURE);
+	}
+
+	if (threads < 1) {
+		fprintf(stderr, "Invalid thread count: %u\n", threads);
+		return 1;
+	}
+
+	if (iterations < 1) {
+		fprintf(stderr, "Invalid iteration count: %u\n", iterations);
+		return 1;
+	}
+
+	return run_cas_benchmark();
+}
+#endif /* HAVE_PTHREAD_BARRIER */
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index 8519eb5a42fa..01eb6ceffb8d 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -30,6 +30,7 @@ int bench_mem_memcpy(int argc, const char **argv);
 int bench_mem_memset(int argc, const char **argv);
 int bench_mem_mmap(int argc, const char **argv);
 int bench_mem_find_bit(int argc, const char **argv);
+int bench_atomic(int argc, const char **argv);
 int bench_futex_hash(int argc, const char **argv);
 int bench_futex_wake(int argc, const char **argv);
 int bench_futex_wake_parallel(int argc, const char **argv);
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 02d47913cc6a..aeffa0826aea 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -14,6 +14,7 @@
  *  syscall ... System call performance
  *  mem   ... memory access performance
  *  numa  ... NUMA scheduling and MM performance
+ *  atomic ... Atomic operation performance
  *  futex ... Futex performance
  *  epoll ... Event poll performance
  */
@@ -115,6 +116,12 @@ static const struct bench uprobe_benchmarks[] = {
 	{ NULL,	NULL, NULL },
 };
 
+static const struct bench atomic_benchmarks[] = {
+	{ "cas",	"Benchmark CAS (compare-and-swap) operations",	bench_atomic		},
+	{ "all",	"Run all atomic benchmarks",			NULL			},
+	{ NULL,		NULL,						NULL			}
+};
+
 struct collection {
 	const char		*name;
 	const char		*summary;
@@ -128,6 +135,7 @@ static const struct collection collections[] = {
 #ifdef HAVE_LIBNUMA_SUPPORT
 	{ "numa",	"NUMA scheduling and MM benchmarks",		numa_benchmarks		},
 #endif
+	{ "atomic",	"Atomic operation benchmarks",			atomic_benchmarks	},
 	{"futex",       "Futex stressing benchmarks",                   futex_benchmarks        },
 #ifdef HAVE_EVENTFD_SUPPORT
 	{"epoll",       "Epoll stressing benchmarks",                   epoll_benchmarks        },
-- 
2.53.0

