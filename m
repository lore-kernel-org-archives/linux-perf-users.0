Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A5F21E0B2
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Jul 2025 02:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756017; cv=none; b=RCIh6OeQRvYPwnnksl7Ppu3f4wYDonI2sVPAlc90OD5hbhAnWKWpUYlilTkdjNGkMn4eX62Rnpq/aGVnwH0Z99zqyfbMhS9eb66PeKDkj9mGExvKWy9mxqs3sB6q/pG/CjTqQaFyxgh0nQwmmSBPZ2WLeDc71iyqXGO0tnu2lhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756017; c=relaxed/simple;
	bh=SR0yGjMpjNaiXRA6AQUdbwzU/jeOGsnKSCSE5b9t9Xs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=WCyRtGrA65XFPUZy9HndXDoHLHmlcGsxowBXRO2KifGx1Ou9q3FqCqIY28xuP2vgh4fWgXO3414GCWGnxAENtoDD5HUVAgMMpj6h8kSv98d34YLTnmpFmDxgc4+/Ja6ZsXkkln35TkjW3bf+HQqsBsTA1wi3jSy88YkdfRgwQDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q50HViec; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q50HViec"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b321087b1cdso6556801a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Jul 2025 19:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753756015; x=1754360815; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0IpzWh1GSupEuJD1HvbYqpGAkZZZklj4Nj25KDP0OIM=;
        b=Q50HVieceozS3MZgef+Un34PxDeRPeZyBZF1xECtyPTTuoPt3fZWWs0OvySCTVhFR+
         E3ZMW10uyE//oXoWOR9GkQ3I3u98Fh4SXxaVaGvTKoC8t7pT0BRjMdQBxTMqSi+a7xo1
         kuaRjVPcOsxAXjoVfcGUbzj1Eh65l+k4EAE0Rb9dD+iEFodkQ2o9DS0fmcIx9pKCVAFx
         0oRhkSUU/IgrzCuPyG3COQt2KFxCBWbux5NBZ7HM/ACNgmrHsiNZmvN1k0ParqMeesB2
         4Ou1AYYpPCejuJSecmcgGWiBvxz7zD8/3hXiaMTwOt6b2ygIJULJcfS+7eKFs+THX+yA
         zbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756015; x=1754360815;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0IpzWh1GSupEuJD1HvbYqpGAkZZZklj4Nj25KDP0OIM=;
        b=onGKbfbq9Jrs1bhqDTUYYKN6tQ9H0GKvBGPMQhszUiu93xem0xWQhQ3mQYdz+EekPT
         GNwufuTyZiGrw/K02oQ4SyaCKUCwalgYH3gxe3vIDvMhSM5X+jLmnnn52xUOGcSCsNu9
         F0oXL/c4j7lDeb5r4AYi91oRsgt8IQFgblXJxRzmWhforxZfpXeNE/09Jdm827zBQKYl
         C9tjeiBKNKMCdSeRLh2OqdZK8sKAHvOjgNikk71QC4hMCcrZpAk5gzwm/KilgjTQlBom
         Q6TZ8ykAGxWG3I6bccv7njDb+poXHjnUKR7c8xxANJL80EmWFLbKZEiKlR114NSL5OgB
         2wAw==
X-Forwarded-Encrypted: i=1; AJvYcCXJlBqpblpTm/60MnhiPrORLt1Ya41cln7mbUcclCv1lvbspQdfR9naxxc+dmAZzuJY6DU2+WM9GTonbzSiWCfb@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo1FIeOWA9Rw+VX099DzssXXggX3PQ1TVFFKvBbbnP6/6t2nVy
	L71dN1GCHOrdwEibfbiuC3f9lLRu4lmPGiktn27uAOTF+GkNQCTHBhBxM7lEL3wiWZ8K7HBRCa7
	bIS9nIw==
X-Google-Smtp-Source: AGHT+IHvM7XsglD+A2nSBVKJqo9GO6rSg0j3vR/q3GCnbggYdamThZ8mgI+B95CYlCTxKhmLXmIRcKjQl5Y=
X-Received: from pfbki17.prod.google.com ([2002:a05:6a00:9491:b0:746:2840:68a6])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4310:b0:23d:33ce:bc7a
 with SMTP id adf61e73a8af0-23d70171e0emr21607108637.23.1753756015101; Mon, 28
 Jul 2025 19:26:55 -0700 (PDT)
Date: Mon, 28 Jul 2025 19:26:39 -0700
In-Reply-To: <20250729022640.3134066-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729022640.3134066-1-yuzhuo@google.com>
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250729022640.3134066-7-yuzhuo@google.com>
Subject: [PATCH v1 6/7] perf bench: Add 'bench sync qspinlock' subcommand
From: Yuzhuo Jing <yuzhuo@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Yuzhuo Jing <yzj@umich.edu>, 
	Yuzhuo Jing <yuzhuo@google.com>, Andrea Parri <parri.andrea@gmail.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Barret Rhoden <brho@google.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Benchmark kernel queued spinlock implementation in user space.  Support
settings of the number of threads and the number of acquire/releases.

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
---
 tools/perf/bench/Build     |   2 +
 tools/perf/bench/bench.h   |   1 +
 tools/perf/bench/sync.c    | 234 +++++++++++++++++++++++++++++++++++++
 tools/perf/builtin-bench.c |   7 ++
 4 files changed, 244 insertions(+)
 create mode 100644 tools/perf/bench/sync.c

diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
index b558ab98719f..13558279fa0e 100644
--- a/tools/perf/bench/Build
+++ b/tools/perf/bench/Build
@@ -19,6 +19,8 @@ perf-bench-y += evlist-open-close.o
 perf-bench-y += breakpoint.o
 perf-bench-y += pmu-scan.o
 perf-bench-y += uprobe.o
+perf-bench-y += sync.o
+perf-bench-y += qspinlock.o
 
 perf-bench-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
 perf-bench-$(CONFIG_X86_64) += mem-memset-x86-64-asm.o
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index 9f736423af53..dd6c8b6126d3 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -22,6 +22,7 @@ int bench_numa(int argc, const char **argv);
 int bench_sched_messaging(int argc, const char **argv);
 int bench_sched_pipe(int argc, const char **argv);
 int bench_sched_seccomp_notify(int argc, const char **argv);
+int bench_sync_qspinlock(int argc, const char **argv);
 int bench_syscall_basic(int argc, const char **argv);
 int bench_syscall_getpgid(int argc, const char **argv);
 int bench_syscall_fork(int argc, const char **argv);
diff --git a/tools/perf/bench/sync.c b/tools/perf/bench/sync.c
new file mode 100644
index 000000000000..2685cb66584c
--- /dev/null
+++ b/tools/perf/bench/sync.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Synchronization benchmark.
+ *
+ * 2025  Yuzhuo Jing <yuzhuo@google.com>
+ */
+#include <bits/time.h>
+#include <err.h>
+#include <inttypes.h>
+#include <perf/cpumap.h>
+#include <pthread.h>
+#include <stdbool.h>
+#include <string.h>
+#include <subcmd/parse-options.h>
+#include <sys/cdefs.h>
+
+#include "bench.h"
+
+#include "include/qspinlock.h"
+
+#define NS 1000000000ull
+#define CACHELINE_SIZE 64
+
+static unsigned int nthreads;
+static unsigned long nspins = 10000ul;
+
+struct barrier_t;
+
+typedef void(*lock_fn)(void *);
+
+/*
+ * Lock operation definition to support multiple implmentations of locks.
+ *
+ * The lock and unlock functions only take one variable, the data pointer.
+ */
+struct lock_ops {
+	lock_fn lock;
+	lock_fn unlock;
+	void *data;
+};
+
+struct worker {
+	pthread_t thd;
+	unsigned int tid;
+	struct lock_ops *ops;
+	struct barrier_t *barrier;
+	u64 runtime;		// in nanoseconds
+};
+
+static const struct option options[] = {
+	OPT_UINTEGER('t',	"threads",	&nthreads,
+		"Specify number of threads (default: number of CPUs)."),
+	OPT_ULONG('n',		"spins",	&nspins,
+		"Number of lock acquire operations per thread (default: 10,000 times)."),
+	OPT_END()
+};
+
+static const char *const bench_sync_usage[] = {
+	"perf bench sync qspinlock <options>",
+	NULL
+};
+
+/*
+ * A atomic-based barrier.  Expect to have lower latency than pthread barrier
+ * that sleeps the thread.
+ */
+struct barrier_t {
+	unsigned int count __aligned(CACHELINE_SIZE);
+};
+
+/*
+ * A atomic-based barrier.  Expect to have lower latency than pthread barrier
+ * that sleeps the thread.
+ */
+__always_inline void wait_barrier(struct barrier_t *b)
+{
+	if (__atomic_sub_fetch(&b->count, 1, __ATOMIC_RELAXED) == 0)
+		return;
+	while (__atomic_load_n(&b->count, __ATOMIC_RELAXED))
+		;
+}
+
+static int bench_sync_lock_generic(struct lock_ops *ops, int argc, const char **argv);
+
+/*
+ * Benchmark of linux kernel queued spinlock in user land.
+ */
+int bench_sync_qspinlock(int argc, const char **argv)
+{
+	struct qspinlock lock = __ARCH_SPIN_LOCK_UNLOCKED;
+	struct lock_ops ops = {
+		.lock = (lock_fn)queued_spin_lock,
+		.unlock = (lock_fn)queued_spin_unlock,
+		.data = &lock,
+	};
+	return bench_sync_lock_generic(&ops, argc, argv);
+}
+
+/*
+ * A busy loop to acquire and release the given lock N times.
+ */
+static void lock_loop(const struct lock_ops *ops, unsigned long n)
+{
+	unsigned long i;
+
+	for (i = 0; i < n; ++i) {
+		ops->lock(ops->data);
+		ops->unlock(ops->data);
+	}
+}
+
+/*
+ * Thread worker function.  Runs lock loop for N/5 times before and after
+ * the main timed loop.
+ */
+static void *sync_workerfn(void *args)
+{
+	struct worker *worker = (struct worker *)args;
+	struct timespec starttime, endtime;
+
+	set_this_cpu_id(worker->tid);
+
+	/* Barrier to let all threads start together */
+	wait_barrier(worker->barrier);
+
+	/* Warmup loop (not counted) to keep the below loop contended. */
+	lock_loop(worker->ops, nspins / 5);
+
+	clock_gettime(CLOCK_THREAD_CPUTIME_ID, &starttime);
+	lock_loop(worker->ops, nspins);
+	clock_gettime(CLOCK_THREAD_CPUTIME_ID, &endtime);
+
+	/* Tail loop (not counted) to keep the above loop contended. */
+	lock_loop(worker->ops, nspins / 5);
+
+	worker->runtime = (endtime.tv_sec - starttime.tv_sec) * NS
+		+ endtime.tv_nsec - starttime.tv_nsec;
+
+	return NULL;
+}
+
+/*
+ * Generic lock synchronization benchmark function.  Sets up threads and
+ * thread affinities.
+ */
+static int bench_sync_lock_generic(struct lock_ops *ops, int argc, const char **argv)
+{
+	struct perf_cpu_map *online_cpus;
+	unsigned int online_cpus_nr;
+	struct worker *workers;
+	u64 totaltime = 0, total_spins, avg_ns, avg_ns_dot;
+	struct barrier_t barrier;
+	cpu_set_t *cpuset;
+	size_t cpuset_size;
+
+	argc = parse_options(argc, argv, options, bench_sync_usage, 0);
+	if (argc) {
+		usage_with_options(bench_sync_usage, options);
+		exit(EXIT_FAILURE);
+	}
+
+	/* CPU count setup. */
+	online_cpus = perf_cpu_map__new_online_cpus();
+	if (!online_cpus)
+		err(EXIT_FAILURE, "No online CPUs available");
+	online_cpus_nr = perf_cpu_map__nr(online_cpus);
+
+	if (!nthreads) /* default to the number of CPUs */
+		nthreads = online_cpus_nr;
+
+	workers = calloc(nthreads, sizeof(*workers));
+	if (!workers)
+		err(EXIT_FAILURE, "calloc");
+
+	barrier.count = nthreads;
+
+	printf("Running with %u threads.\n", nthreads);
+
+	cpuset = CPU_ALLOC(online_cpus_nr);
+	if (!cpuset)
+		err(EXIT_FAILURE, "Cannot allocate cpuset.");
+	cpuset_size = CPU_ALLOC_SIZE(online_cpus_nr);
+
+	/* Create worker data structures, set CPU affinity, and create   */
+	for (unsigned int i = 0; i < nthreads; ++i) {
+		pthread_attr_t thread_attr;
+		int ret;
+
+		/* Basic worker thread information */
+		workers[i].tid = i;
+		workers[i].barrier = &barrier;
+		workers[i].ops = ops;
+
+		/* Set CPU affinity */
+		pthread_attr_init(&thread_attr);
+		CPU_ZERO_S(cpuset_size, cpuset);
+		CPU_SET_S(perf_cpu_map__cpu(online_cpus, i % online_cpus_nr).cpu,
+			cpuset_size, cpuset);
+
+		if (pthread_attr_setaffinity_np(&thread_attr, cpuset_size, cpuset))
+			err(EXIT_FAILURE, "Pthread set affinity failed");
+
+		/* Create and block thread */
+		ret = pthread_create(&workers[i].thd, &thread_attr, sync_workerfn, &workers[i]);
+		if (ret != 0)
+			err(EXIT_FAILURE, "Error creating thread: %s", strerror(ret));
+
+		pthread_attr_destroy(&thread_attr);
+	}
+
+	CPU_FREE(cpuset);
+
+	for (unsigned int i = 0; i < nthreads; ++i) {
+		int ret = pthread_join(workers[i].thd, NULL);
+
+		if (ret)
+			err(EXIT_FAILURE, "pthread_join");
+	}
+
+	/* Calculate overall average latency. */
+	for (unsigned int i = 0; i < nthreads; ++i)
+		totaltime += workers[i].runtime;
+
+	total_spins = (u64)nthreads * nspins;
+	avg_ns = totaltime / total_spins;
+	avg_ns_dot = (totaltime % total_spins) * 10000 / total_spins;
+
+	printf("Lock-unlock latency of %u threads: %"PRIu64".%"PRIu64" ns.\n",
+			nthreads, avg_ns, avg_ns_dot);
+
+	free(workers);
+
+	return 0;
+}
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 2c1a9f3d847a..cfe6f6dc6ed4 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -52,6 +52,12 @@ static struct bench sched_benchmarks[] = {
 	{ NULL,		NULL,						NULL			}
 };
 
+static struct bench sync_benchmarks[] = {
+	{ "qspinlock",	"Benchmark for queued spinlock",		bench_sync_qspinlock	},
+	{ "all",	"Run all synchronization benchmarks",		NULL			},
+	{ NULL,		NULL,						NULL			}
+};
+
 static struct bench syscall_benchmarks[] = {
 	{ "basic",	"Benchmark for basic getppid(2) calls",		bench_syscall_basic	},
 	{ "getpgid",	"Benchmark for getpgid(2) calls",		bench_syscall_getpgid	},
@@ -122,6 +128,7 @@ struct collection {
 
 static struct collection collections[] = {
 	{ "sched",	"Scheduler and IPC benchmarks",			sched_benchmarks	},
+	{ "sync",	"Synchronization benchmarks",			sync_benchmarks		},
 	{ "syscall",	"System call benchmarks",			syscall_benchmarks	},
 	{ "mem",	"Memory access benchmarks",			mem_benchmarks		},
 #ifdef HAVE_LIBNUMA_SUPPORT
-- 
2.50.1.487.gc89ff58d15-goog

