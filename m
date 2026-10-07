Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602683DA5C5
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Oct 2026 05:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791351049; cv=none; b=ihZ9y9VKhRSJDumhDSj1oe4yAPfurZDWdHF5Uhig1b6XEBVyAK5TRP/xgHQS4fISNhIpGRApw20WkJTuXkFCgRdXtzLefUFW4Nm081/Xl4Qj2nne3iG9mEc5uZKJv1N2AbUXHvcP/96L7jorpkNuoobQ6QkxuuP7uN4g8A90atU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791351049; c=relaxed/simple;
	bh=OqaPyFPIAb5pA6XOr222+ri8L8KoNjni8K1hOHwKuts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=djxHXcK2Y5yFdfzrEgsMWPwzxSpYnJZWoAR8Cq4uqVCoBx5a/fW9/3U5BzjEZbPsTy2Evt7NIQHnd6khEjcRNmj9Xsf/nuxoGyUT7i4jK5OSzoPT2WIYJMTGZcaRCuFPw++sYz+t+HqyLruS/39Ij0kMI/UwI/hd7m98VcDn2G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oFDOBdKF; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFDOBdKF"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so2381425a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Oct 2026 22:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791351047; x=1791955847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PBI/4YvkSQ+VFrtN0cmN+OQwHA5A5JBzV1ymzQIcz6g=;
        b=oFDOBdKFOXfbySZcXjLP4gKF52STRAC+qSEzwqROvrAM6PgQuwlVhciQaKTTbL2K6W
         Ij9/47mngeutQvQ/0zu0Yg73hGILf4uyNkTkjKAkMTOrKwQk84tQp4iDov9kECutJQek
         cBVbRCcQSSe3o7OhdyXoxs1xGrevHOJuZNMRtIZ/iwdmkPEVehP5j4+rDuroTMVLrMWB
         qzI6EVUBJBWnTiqkbTRBg/80pWuvMC3i3uv9aH3SIMFkQQvLt//j5UvKUvRgO3eFjDoW
         ewsGZ1UP5A5o0wzzHYyJfLzvZH+eB7k1w3XaWP8inn44/lwLORmLaEogMXsGg7hlC8rV
         nhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791351047; x=1791955847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PBI/4YvkSQ+VFrtN0cmN+OQwHA5A5JBzV1ymzQIcz6g=;
        b=NEj1ZEYm7r3N8Fukzjtsu1iSLVT8vEgK5zXyiNrIvTyybt18j9fM7gqdoGJh3jBwVb
         tnwwQ5mSBlutvI6p7jzA0NJc+Zrg0aba9REdERX7cQHth1aEs1yMMGKPUIimAhJfwmXo
         dpcDQd34uWRQ/W8QBBW0AzBQft2HbZnOWjQ5p6u2u/10Pv832qU0dJobwydhYAp2SjBq
         UOZrqkxxu+jdnIVH15jpFrJOjNz5GPxZtm0dpSWU0k0Snm2VnFYhL74R9oXclb/Mkt9j
         E2JcFrXDHCysaLnnHFnwGppd1IV4s7C/eh4qRderIpblhww8Md+tcLHkD8jHbfMlNZA+
         mYVQ==
X-Forwarded-Encrypted: i=1; AKwUvByteUJ8L6m+j+qhThqZsh8kORIjJg6BPAPn08BIF6VW9XcJMQ2rRqmhutMwYDiiDBYXixehXx4sKVMjAN/ZtBJT@vger.kernel.org
X-Gm-Message-State: AFq9FYIM/FpsLqnZIgCdiGHdxNsLLwNz12ZVRWMFfZl9Ltaa9h8B0S1G
	sWrEVUPPeT+oQJSZKQzcTG2y6wBs2QnkuUDdt7yJCz8A3+9reiITxHcB
X-Gm-Gg: AYBFou1+WrWyB4pZOxj1CFrBWLgHREe8C5VMu5k06GOezXdwKi8LA6mpYeWSlM5QGbs
	OE+CqOko/sJs9ugBsTfWcxacADmDuNy8qpevfCo6BgzPa7clpFjxsl9i6NNMI8mxkDWRB/r8luk
	wKsdCTxqaYr3xx+CisaI6in5+/NzRW3uzx0r6gHdZ3DE4r51NoGk3AUlfML+DBhDxQ/R2uvL+mG
	gFcv0RZ1msJcCl6GmegXpD5Wj3ro/yGtQW4UYnPjpMMUHdQrDlzWb8p4sCsvqXQM72LFCnG7tdG
	8i+jKa6MiAhW3onyf8m2Fcr66+GbrL2aeSGENIBKkv6DmD5Lp0c/q1wpVvuRR+KVfnikkCoM1fN
	TUWYiZRcU0OkAong/SyF0vkQnSsMG+cnqDY6FuicZQDYKuUEsZCeze3Udk0+TxCSTHbDXasm2pt
	m862waDEMO4FKthHmX0cor+T8wfXPiBDO/JoFr3IzYyPk5rgkE2SK+ZHuGXqzefPbk2A==
X-Received: by 2002:a17:90b:5887:b0:3a0:afc9:a51a with SMTP id 98e67ed59e1d1-3a8a196711amr901388a91.12.1791351046567;
        Tue, 06 Oct 2026 22:30:46 -0700 (PDT)
Received: from morefine ([5.34.221.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a89b17bc5esm2849790a91.7.2026.10.06.22.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 22:30:45 -0700 (PDT)
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
Subject: [PATCH v2] perf bench: Add atomic operations benchmark
Date: Wed,  7 Oct 2026 13:30:27 +0800
Message-ID: <20261007053027.1738402-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new 'atomic' collection to perf bench for benchmarking
atomic read-modify-write operations with multi-threaded
contention testing. It provides two subcommands:

  - atomic cas: contended compare-and-swap operations
    (__atomic_compare_exchange_n)
  - atomic inc: contended fetch-add operations (__atomic_fetch_add)

Both support configurable thread count and iteration count to
measure atomic contention effects.

Why this benchmark is needed:
- Atomic read-modify-write operations are fundamental to lock-free
  algorithms and data structures. Understanding their performance
  characteristics under contention is critical for designing
  high-performance concurrent applications.
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
- Each thread performs a hot loop of the selected atomic operation
  (compare-and-swap or fetch-add) on a shared u64 counter,
  incrementing it from 0 to iterations.
- The shared counter is cache-line aligned (64 bytes) to isolate
  contention to the target cache line and avoid false sharing.
- The wall-clock time is measured as the max of all per-thread
  runtimes (the time for the slowest thread to finish).
- The first repeat is excluded from statistics as a warmup phase
  to avoid cache-cold effects.

Example usage:
$ perf bench atomic all
# Running atomic/cas benchmark...
  Threads: 2, iterations/thread: 100000000, repeats: 10 (warmup: 1)
  Avg wall-clock time: 3286.297 msec  (stddev 6.820 msec)
  Total ops: 200,000,000
  Throughput total: 60,858,769 ops/sec
  Per-thread times and throughput (last repeat):
    fastest:  3304.312 msec  (30263489 ops/sec)
    slowest:  3325.518 msec  (30070504 ops/sec)
    avg:      3314.915 msec  (30166688 ops/sec)

# Running atomic/inc benchmark...
  Threads: 2, iterations/thread: 100000000, repeats: 10 (warmup: 1)
  Avg wall-clock time: 2170.716 msec  (stddev 7.306 msec)
  Total ops: 200,000,000
  Throughput total: 92,135,503 ops/sec
  Per-thread times and throughput (last repeat):
    fastest:  2196.458 msec  (45527849 ops/sec)
    slowest:  2208.764 msec  (45274198 ops/sec)
    avg:      2202.611 msec  (45400669 ops/sec)

Output fields explained:
- Threads: number of contending threads
- iterations/thread: atomic operations each thread performs
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
Changes since v1:
- Add an 'atomic inc' subcommand benchmarking contended fetch-add
  (__atomic_fetch_add), split the entry points into
  bench_atomic_cas() and bench_atomic_inc(), and document it.
- Hoist the plain load out of the compare-and-swap retry loop; the
  failed __atomic_compare_exchange_n already returns the current
  value via *expected, so the loop measures pure CAS throughput.
- Cast the seconds delta to u64 before multiplying by NSEC_PER_SEC
  to avoid 32-bit signed overflow in the runtime calculation.
---
 tools/perf/Documentation/perf-bench.txt |  32 +++
 tools/perf/bench/Build                  |   1 +
 tools/perf/bench/atomic.c               | 268 ++++++++++++++++++++++++
 tools/perf/bench/bench.h                |   2 +
 tools/perf/builtin-bench.c              |   9 +
 5 files changed, 312 insertions(+)
 create mode 100644 tools/perf/bench/atomic.c

diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
index c5913cf59c98..871c3aa5fc43 100644
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
 
@@ -283,6 +286,35 @@ SUITES FOR 'numa'
 *mem*::
 Suite for evaluating NUMA workloads.
 
+SUITES FOR 'atomic'
+~~~~~~~~~~~~~~~~~~~
+*cas*::
+Suite for evaluating compare-and-swap (CAS) atomic operations under
+multi-threaded contention.
+
+*inc*::
+Suite for evaluating atomic fetch-add (increment) operations under
+multi-threaded contention.
+
+Options of *cas* and *inc*
+^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+Note that the cas benchmark counts successful compare-and-swap
+operations only; retries and the loads between them are additional
+atomic instructions not included in the ops/sec count, so cas and
+inc throughputs are not directly comparable at the instruction
+level.
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
index 000000000000..08497910b563
--- /dev/null
+++ b/tools/perf/bench/atomic.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Changbin Du
+ *
+ * Benchmarks for atomic read-modify-write operations.
+ *
+ * Measures throughput (ops/sec) of contended atomic operations on a
+ * single shared counter across multiple threads. Each thread performs
+ * a hot loop of the selected operation -- compare-and-swap (cas) or
+ * fetch-add (inc) -- competing with all other threads for the same
+ * cache line.
+ */
+#include "bench.h"
+#include <linux/compiler.h>
+#include "../util/debug.h"
+
+#ifndef HAVE_PTHREAD_BARRIER
+int bench_atomic_cas(int argc __maybe_unused, const char **argv __maybe_unused)
+{
+	pr_err("%s: pthread_barrier_t unavailable, disabling this test...\n", __func__);
+	return 0;
+}
+
+int bench_atomic_inc(int argc __maybe_unused, const char **argv __maybe_unused)
+{
+	pr_err("%s: pthread_barrier_t unavailable, disabling this test...\n", __func__);
+	return 0;
+}
+#else /* HAVE_PTHREAD_BARRIER */
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <string.h>
+#include <pthread.h>
+#include <time.h>
+#include <inttypes.h>
+#include <err.h>
+#include <linux/types.h>
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
+static const char * const cas_usage[] = {
+	"perf bench atomic cas <options>",
+	NULL
+};
+
+static const char * const inc_usage[] = {
+	"perf bench atomic inc <options>",
+	NULL
+};
+
+enum atomic_op {
+	OP_CAS,
+	OP_INC,
+};
+
+static int bench_op = OP_CAS;
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
+	switch (bench_op) {
+	case OP_CAS:
+		for (i = 0; i < iterations; i++) {
+			u64 old_val, new_val;
+
+			old_val = __atomic_load_n(&shared_counter, __ATOMIC_RELAXED);
+			do {
+				new_val = old_val + 1;
+			} while (!__atomic_compare_exchange_n(&shared_counter,
+							      &old_val, new_val,
+							      false,
+							      __ATOMIC_RELAXED,
+							      __ATOMIC_RELAXED));
+		}
+		break;
+	case OP_INC:
+		for (i = 0; i < iterations; i++)
+			__atomic_fetch_add(&shared_counter, 1, __ATOMIC_RELAXED);
+		break;
+	default:
+		break;
+	}
+	clock_gettime(CLOCK_MONOTONIC, &tend);
+
+	ws->runtime_ns	= (u64)(tend.tv_sec - tstart.tv_sec) * NSEC_PER_SEC +
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
+static int run_benchmark(void)
+{
+	pthread_t *thread_ids;
+	struct worker_stats *wstats;
+	struct stats time_stats;
+	unsigned int r, t;
+
+	thread_ids = calloc(threads, sizeof(pthread_t));
+	if (!thread_ids)
+		err(EXIT_FAILURE, "calloc");
+
+	wstats = calloc(threads, sizeof(struct worker_stats));
+	if (!wstats)
+		err(EXIT_FAILURE, "calloc");
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
+static int run_atomic_bench(int argc, const char **argv,
+			    const char * const *usage)
+{
+	if (parse_options(argc, argv, options, usage, 0)) {
+		usage_with_options(usage, options);
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
+	return run_benchmark();
+}
+
+int bench_atomic_cas(int argc, const char **argv)
+{
+	bench_op = OP_CAS;
+	return run_atomic_bench(argc, argv, cas_usage);
+}
+
+int bench_atomic_inc(int argc, const char **argv)
+{
+	bench_op = OP_INC;
+	return run_atomic_bench(argc, argv, inc_usage);
+}
+#endif /* HAVE_PTHREAD_BARRIER */
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index 8519eb5a42fa..85e3ac471875 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -30,6 +30,8 @@ int bench_mem_memcpy(int argc, const char **argv);
 int bench_mem_memset(int argc, const char **argv);
 int bench_mem_mmap(int argc, const char **argv);
 int bench_mem_find_bit(int argc, const char **argv);
+int bench_atomic_cas(int argc, const char **argv);
+int bench_atomic_inc(int argc, const char **argv);
 int bench_futex_hash(int argc, const char **argv);
 int bench_futex_wake(int argc, const char **argv);
 int bench_futex_wake_parallel(int argc, const char **argv);
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 02d47913cc6a..62bebdedd3b8 100644
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
@@ -115,6 +116,13 @@ static const struct bench uprobe_benchmarks[] = {
 	{ NULL,	NULL, NULL },
 };
 
+static const struct bench atomic_benchmarks[] = {
+	{ "cas",	"Benchmark CAS (compare-and-swap) operations",	bench_atomic_cas	},
+	{ "inc",	"Benchmark atomic fetch-add operations",	bench_atomic_inc	},
+	{ "all",	"Run all atomic benchmarks",			NULL			},
+	{ NULL,		NULL,						NULL			}
+};
+
 struct collection {
 	const char		*name;
 	const char		*summary;
@@ -128,6 +136,7 @@ static const struct collection collections[] = {
 #ifdef HAVE_LIBNUMA_SUPPORT
 	{ "numa",	"NUMA scheduling and MM benchmarks",		numa_benchmarks		},
 #endif
+	{ "atomic",	"Atomic operation benchmarks",			atomic_benchmarks	},
 	{"futex",       "Futex stressing benchmarks",                   futex_benchmarks        },
 #ifdef HAVE_EVENTFD_SUPPORT
 	{"epoll",       "Epoll stressing benchmarks",                   epoll_benchmarks        },
-- 
2.53.0

