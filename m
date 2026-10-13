Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF9A33F59C
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 08:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881826; cv=none; b=HR6Ajr5n1+xx7GJ/341E9xiWohP2Se1sIPZ3GmmPd9gwGxDb0TTZZy59QUbceNRWgK//K6cxAKOutxTvdAst4cUVitm+pniI4zkCqKwaeVSV9kw7dBKSRTgoShA2g8Rgpyz7JQQjWd+RV6WlswVArbhI4gBvFzTCRHtgInAQoyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881826; c=relaxed/simple;
	bh=nQ0+lZw5xI710/4/kQVjKZn+swcHEkEnvGr7V+P8RNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DgoOM4kXtkAoX8sg5g2IYQZejQZs/xBPvboTpHJGFIg359zmjvr+zASaRb1VW5OqOajZqik06woEiYpvKdviKFXHMDk6m2ynp9CEMMdoURCfTG8kBN2ME9+FHw/ss3GoN/94JhxZKRIIjmkp3Mi2Bzg3lxXmK56cv0sxH5hBZQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y31FqQjo; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y31FqQjo"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so2191638a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 01:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791881823; x=1792486623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CSw+uT5Ak8bmclq5en3KdAD6uust7n7UC2AY2cCXQCg=;
        b=Y31FqQjok7mthXBahFYCtE5KR24wcJOZ4Ni/MfybTll21xBZhG2lUkaX5y5xvzj8Du
         6MNgSokuTJHsjSOvPbVJVxDSQRfcKvt3uuFmw8TncgK2mS19erWpWWNd55avRfegM5c5
         j/ptWjY1PsV4/0f/qkwiMCxo7778J8vdS1wRB2yy8sM3qQn9GVRAsnNzvCfVAa19q9TE
         ebvMYXGGM2fsi3rxtG4Bl9PKdaarYckRvPsR03D/kxJ0MNLXf4e2CJjeyKTMHfiDrl8x
         9RgIyx3QlW8utOWJf0s7/8dQSFJf+TeqDQm40z5+oHs2viquZg+JbXrNhLpw8zDAhTlK
         IAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791881823; x=1792486623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CSw+uT5Ak8bmclq5en3KdAD6uust7n7UC2AY2cCXQCg=;
        b=RG69QqgUuyKbgwWoqOEV05Q6FdzvYF4j4P6Fpb+xzvBQk2X9bO5yL688vopCcWzHpj
         M5RR/fgssp53ZVikrKLhEZRLdRbaHOshVkV3qM2P2HPJKp0GQWYhK1OKYaR6a/1Tq5Bu
         AW2sqAwzl/2EfRWBJZVeuxxgKpahiB/rStVvy74k2y7ft09IhJmLJ7hBH9/P3rV+gq9p
         5BNFs/tGF5dRQdlDg734STCuKqABbP+1ljXu9J0KrHCx6jyhxwLZmHlpeORXdY5/wrOa
         HAATHfoZZUt49rT/YB+jtgxzufls4xsY4BqjP5w7pBZ+wfmGXO3E3I6usGycGAO029F+
         QbWw==
X-Forwarded-Encrypted: i=1; AKwUvBy4w2Tze/be7P33Di3c0OQbx1hBcMPRzkrsSbXYLuS8c3+6om/uXKM+mB5B3uKxMKqCkDlOgAOtv7Axhn0zw+qe@vger.kernel.org
X-Gm-Message-State: AFq9FYKSio9/TcGmPd0tT2BX+dni4RfR/x9k7N7HmiwfYqqsVIEUwlvJ
	a/TTMirAERMv4AiVmVF/sZUNIW++j/i48eljAV2buzjz26lIaKY2R4ko
X-Gm-Gg: AYBFou1foofRPe6/i8SoAfDm0Ch9At0puRrH+fi9C6uoCmivUqLeF5gTGLPw6k/UiKR
	ImbZgLoOBFDbjwRJ7Pe/qCmY7hxjyaWU+ulgl5/SqPW8i8F3WRrMtz/JZfZ96krMAthPsmHn4WO
	gqvY4pNwumhDhoxAAAPznbIKFFkCssr7CSG1VrQXDYFw1G0CY52MZuLNbYWygLeeUcgKK9zmBhZ
	OzWD9XV833MTpVgRQmeJdAS+eiM6hMiGqlRtP+/ND8AMHqMMfnCwzf5JXPcSsQo8tqQo1KpFcjc
	CQo5ZNTRqVx2l0V3C6VomxXrdMhuNs1lq6STlpBGT9hhMLecqpID7RlDJ8lrtzXml+m2pk9x2xD
	UB19SAugHrG/CyjhSwlHIvUTFuRgKdXzT7z4I9LvwB6dc0JKFw19UMI+2cowSxX3dUoeDDR29mB
	uM37fmzBsMbT0DBT2apzXL9E5H783zcF0P2QFpFm0/GKYpNHzrTMPxiAQdYOiAQ1Kd
X-Received: by 2002:a17:90b:4d86:b0:3a8:6571:b43f with SMTP id 98e67ed59e1d1-3ab3a9f7f28mr9910406a91.29.1791881822438;
        Tue, 13 Oct 2026 01:57:02 -0700 (PDT)
Received: from morefine ([5.34.221.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3da03f449sm5230806a12.28.2026.10.13.01.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:57:01 -0700 (PDT)
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
	David Laight <david.laight.linux@gmail.com>,
	Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4] perf bench: Add atomic operations benchmark
Date: Tue, 13 Oct 2026 16:56:48 +0800
Message-ID: <20261013085648.976819-1-changbin.du@gmail.com>
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

Both support a configurable thread count and runtime to measure
atomic contention effects.

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
- By default two threads contend for the counter, enough to expose
  the contention effect; use -t to scale the count.
- Each thread starts a private timer (clock_gettime CLOCK_MONOTONIC)
  after synchronizing on a pthread_barrier, ensuring all threads
  begin simultaneously.
- Each thread performs a hot loop of the selected atomic operation
  (compare-and-swap or fetch-add) on a shared unsigned long counter
  for a fixed runtime. It counts its own completed operations in a
  local variable, and the loop runs in batches so the termination
  flag is only polled between batches.
- The main thread sleeps for the runtime and then sets the flag; the
  throughput of a repeat is the total operation count divided by the
  measured wall time (the max per-thread runtime).
- The shared counter is cache-line aligned (64 bytes) to isolate
  contention to the target cache line and avoid false sharing.
- The per-thread operation counts of the last repeat show whether
  any thread failed to make progress under contention.
- The first repeat is excluded from statistics as a warmup phase
  to avoid cache-cold effects.

Example usage:
  $ perf bench atomic all
  # Running atomic/cas benchmark...
    Threads: 2, runtime: 2 sec, repeats: 10 (warmup: 1)
    Avg throughput: 68,599,954 ops/sec (+- 0.13%)
    Per-thread ops (last repeat):
      fastest:  74,842,112 ops
      slowest:  63,176,704 ops
      avg:      69,009,408 ops

  # Running atomic/inc benchmark...
    Threads: 2, runtime: 2 sec, repeats: 10 (warmup: 1)
    Avg throughput: 128,428,772 ops/sec (+- 0.54%)
    Per-thread ops (last repeat):
      fastest:  146,230,272 ops
      slowest:  112,825,344 ops
      avg:      129,527,808 ops

Output fields explained:
- Threads: number of contending threads
- runtime: seconds each thread runs per repeat
- repeats: number of test runs (first is warmup)
- Avg throughput: mean aggregate ops/sec across repeats
- +- %: relative standard error of the mean throughput across repeats
- Per-thread ops: fastest/slowest/avg operations per thread in the
  last repeat (shows scheduling imbalance and lack of progress)

Assisted-by: opencode:DeepSeek-V4-Pro
Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
Changes in v4:
- Default to 2 threads (1 on a single-CPU machine).
- Replace the iteration count with a fixed runtime per repeat.
- Report per-thread operation counts to show lack of progress.

Changes in v3:
- Use native word size (unsigned long) for the shared counter instead
  of u64 to avoid libatomic on 32-bit targets.
- Include <stdint.h> explicitly for UINT64_MAX.

Changes in v2:
- Add an 'atomic inc' subcommand for contended __atomic_fetch_add.
- Hoist the load out of the CAS retry loop; the failed
  __atomic_compare_exchange_n already returns the current value.
- Cast the seconds delta to u64 before multiplying by NSEC_PER_SEC to
  avoid 32-bit overflow.
---
 tools/perf/Documentation/perf-bench.txt |  38 +++
 tools/perf/bench/Build                  |   1 +
 tools/perf/bench/atomic.c               | 295 ++++++++++++++++++++++++
 tools/perf/bench/bench.h                |   2 +
 tools/perf/builtin-bench.c              |   9 +
 5 files changed, 345 insertions(+)
 create mode 100644 tools/perf/bench/atomic.c

diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
index c5913cf59c98..2a1206fea0c9 100644
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
 
@@ -283,6 +286,41 @@ SUITES FOR 'numa'
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
+Number of threads contending for the shared counter (default: 2, or
+1 on a single-CPU machine).
+
+-r::
+--runtime=::
+Runtime of each repeat in seconds (default: 2).
+
+The per-thread fastest/slowest/avg ops summary is only printed when
+running with more than one thread.
+
+The average throughput is annotated with its relative deviation
+("+- x%"), i.e. the standard error of the mean over the measured
+repeats. A small value means the average is reproducible; it does not
+reflect per-thread fairness, which the per-thread ops summary shows.
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
index 000000000000..2da74bf078bc
--- /dev/null
+++ b/tools/perf/bench/atomic.c
@@ -0,0 +1,295 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Changbin Du <changbin.du@gmail.com>
+ *
+ * Benchmarks for atomic read-modify-write operations.
+ *
+ * Measures throughput (ops/sec) of contended atomic operations on a
+ * single shared counter across multiple threads. Each thread performs
+ * a hot loop of the selected operation -- compare-and-swap (cas) or
+ * fetch-add (inc) -- competing with all other threads for the same
+ * cache line. Threads run for a fixed runtime, so a system that
+ * cannot make progress under heavy contention reports a low (or
+ * zero) throughput instead of hanging.
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
+#include <stdint.h>
+#include <unistd.h>
+#include <pthread.h>
+#include <time.h>
+#include <inttypes.h>
+#include <err.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/time64.h>
+#include <perf/cpumap.h>
+#include <subcmd/parse-options.h>
+#include "../util/stat.h"
+
+static unsigned int threads;		/* 0: default to min(2, online CPUs) */
+static unsigned int runtime	= 2;	/* seconds per repeat */
+
+static const struct option options[] = {
+	OPT_UINTEGER('t', "threads", &threads,
+		     "Number of contending threads (default: 2, or 1 on single CPU)"),
+	OPT_UINTEGER('r', "runtime", &runtime,
+		     "Runtime of each repeat in seconds (default: 2)"),
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
+/*
+ * The termination flag is polled between batches only, so that the
+ * check does not perturb the measured loop.
+ */
+#define BATCH_OPS	1024
+
+static unsigned long shared_counter __aligned(64);
+static pthread_barrier_t start_barrier __aligned(64);
+static bool done;
+
+struct worker_stats {
+	u64	runtime_ns;
+	u64	ops;
+};
+
+static void cas_batch(void)
+{
+	unsigned long i;
+
+	for (i = 0; i < BATCH_OPS; i++) {
+		unsigned long old_val, new_val;
+
+		old_val = __atomic_load_n(&shared_counter, __ATOMIC_RELAXED);
+		do {
+			new_val = old_val + 1;
+		} while (!__atomic_compare_exchange_n(&shared_counter, &old_val,
+						      new_val, false,
+						      __ATOMIC_RELAXED,
+						      __ATOMIC_RELAXED));
+	}
+}
+
+static void inc_batch(void)
+{
+	unsigned long i;
+
+	for (i = 0; i < BATCH_OPS; i++)
+		__atomic_fetch_add(&shared_counter, 1, __ATOMIC_RELAXED);
+}
+
+static void *worker(void *arg)
+{
+	struct worker_stats *ws = (struct worker_stats *)arg;
+	struct timespec tstart, tend;
+	u64 ops = 0;
+
+	pthread_barrier_wait(&start_barrier);
+
+	clock_gettime(CLOCK_MONOTONIC, &tstart);
+	while (!__atomic_load_n(&done, __ATOMIC_RELAXED)) {
+		switch (bench_op) {
+		case OP_CAS:
+			cas_batch();
+			break;
+		case OP_INC:
+			inc_batch();
+			break;
+		default:
+			BUG_ON(1);
+			break;
+		}
+		ops += BATCH_OPS;
+	}
+	clock_gettime(CLOCK_MONOTONIC, &tend);
+
+	ws->runtime_ns	= (u64)(tend.tv_sec - tstart.tv_sec) * NSEC_PER_SEC +
+			  (tend.tv_nsec - tstart.tv_nsec);
+	ws->ops		= ops;
+
+	return NULL;
+}
+
+static void print_default_format(struct worker_stats *wstats,
+				 struct stats *throughput_stats)
+{
+	double thru_avg, thru_stddev;
+
+	printf("  Threads: %u, runtime: %u sec, repeats: %u (warmup: 1)\n",
+	       threads, runtime, bench_repeat);
+
+	thru_avg    = avg_stats(throughput_stats);
+	thru_stddev = stddev_stats(throughput_stats);
+
+	printf("  Avg throughput: %'.0f ops/sec (+- %.2f%%)\n",
+	       thru_avg, rel_stddev_stats(thru_stddev, thru_avg));
+
+	/*
+	 * Per-thread operation counts from the last measured repeat show
+	 * whether any thread failed to make progress under contention.
+	 */
+	if (threads > 1) {
+		u64 min_ops = UINT64_MAX, max_ops = 0, total_ops = 0;
+
+		for (unsigned int t = 0; t < threads; t++) {
+			if (wstats[t].ops < min_ops)
+				min_ops = wstats[t].ops;
+			if (wstats[t].ops > max_ops)
+				max_ops = wstats[t].ops;
+			total_ops += wstats[t].ops;
+		}
+
+		printf("  Per-thread ops (last repeat):\n");
+		printf("    fastest:  %'" PRIu64 " ops\n", max_ops);
+		printf("    slowest:  %'" PRIu64 " ops\n", min_ops);
+		printf("    avg:      %'" PRIu64 " ops\n", total_ops / threads);
+	}
+}
+
+static int run_benchmark(void)
+{
+	pthread_t *thread_ids;
+	struct worker_stats *wstats;
+	struct stats throughput_stats;
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
+	init_stats(&throughput_stats);
+
+	for (r = 0; r < bench_repeat + 1; r++) {
+		u64 max_runtime_ns = 0, total_ops = 0;
+		double throughput;
+
+		shared_counter = 0;
+		__atomic_store_n(&done, false, __ATOMIC_RELAXED);
+		pthread_barrier_init(&start_barrier, NULL, threads);
+
+		for (t = 0; t < threads; t++) {
+			if (pthread_create(&thread_ids[t], NULL,
+					   worker, &wstats[t]))
+				err(EXIT_FAILURE, "pthread_create");
+		}
+
+		sleep(runtime);
+		__atomic_store_n(&done, true, __ATOMIC_RELAXED);
+
+		for (t = 0; t < threads; t++)
+			pthread_join(thread_ids[t], NULL);
+
+		pthread_barrier_destroy(&start_barrier);
+
+		for (t = 0; t < threads; t++) {
+			total_ops += wstats[t].ops;
+			if (wstats[t].runtime_ns > max_runtime_ns)
+				max_runtime_ns = wstats[t].runtime_ns;
+		}
+
+		/*
+		 * Exclude the first repeat (warmup) from statistics so
+		 * that cache-cold and lazy-init effects are not counted.
+		 */
+		if (r > 0 && max_runtime_ns) {
+			throughput = (double)total_ops /
+				     ((double)max_runtime_ns / NSEC_PER_SEC);
+			update_stats(&throughput_stats, (u64)throughput);
+		}
+	}
+
+	switch (bench_format) {
+	case BENCH_FORMAT_DEFAULT:
+		print_default_format(wstats, &throughput_stats);
+		break;
+
+	case BENCH_FORMAT_SIMPLE:
+		printf("%.0f\n", avg_stats(&throughput_stats));
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
+	struct perf_cpu_map *cpu;
+
+	if (parse_options(argc, argv, options, usage, 0)) {
+		usage_with_options(usage, options);
+		exit(EXIT_FAILURE);
+	}
+
+	if (!threads) {	/* default to 2 threads (1 on a single-CPU machine) */
+		cpu = perf_cpu_map__new_online_cpus();
+		threads = (cpu && perf_cpu_map__nr(cpu) > 1) ? 2 : 1;
+		perf_cpu_map__put(cpu);
+	}
+
+	if (runtime < 1) {
+		fprintf(stderr, "Invalid runtime: %u\n", runtime);
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

