Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B53CB667;
	Thu, 31 Jul 2025 05:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753938985; cv=none; b=tzdzN23/FHLvA3kbpTJoW48JU0gG4fp5pSryuk84wxWsKlWTCoWtFsToHm4p+XxLnTJStX15HwI12WhUmO1OWQfhldNWbw2WmCizujLJVh0f89sf0Xhh/0++7ALcRhMqOm+pn7vGyB50NAzHacNiFl0TGVgK92FLwuykUyA/DP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753938985; c=relaxed/simple;
	bh=UE8m/BZ9p5kdt+ZwHKwPViXm5Y2PUpr2qnlJ5eGoQa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxpPh6X+ALamO2i5HxPuJ4IHM37JnT247ckhEdZNuROlDpCeViBzWKX7bmO6LIzbUggj0npV+wJrAx+wuNnLYMQGdisnF9tbWLilzMEmVveMAP98aZ5rM36LwYI90TwCDgqg360rJGEqCAcaz6vMcJtns+uxtIvp+celMhb9lkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRfqX7Uj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRfqX7Uj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A5DC4CEEF;
	Thu, 31 Jul 2025 05:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753938985;
	bh=UE8m/BZ9p5kdt+ZwHKwPViXm5Y2PUpr2qnlJ5eGoQa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PRfqX7UjcaY9XmqAqfGrRJlMX5AzVDYLqsY4ZXi+pECO6R2QiDcpWZiGkiqm5/+QO
	 wmt8wfGSBw0AT5U7XwgGwIfGaiFBMJva7DmJptjahLaDbvAsM5DU9bvWsdGDowjVYE
	 GdWobqs4O5dB2kWY5oSO/R9+nZAJacGnvr7vy+t/ogS3gfgcKec6XGyPrZ7NplVKml
	 plxe/9OFqDLkejWfP68dc4n39pwoprfT4VTwqLjIfkOwjMCP9U290CdMluwaKy6a3z
	 eNXktYL9np+NZCI9f7RJVY1AOZjzDWEhEY1BG1AGkGBxz+LgMLivkD+IYqjbzrMAok
	 HzF90BPRgdvwQ==
Date: Wed, 30 Jul 2025 22:16:22 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Yuzhuo Jing <yuzhuo@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>, Yuzhuo Jing <yzj@umich.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 6/7] perf bench: Add 'bench sync qspinlock' subcommand
Message-ID: <aIr8JuprT1JPNJsq@google.com>
References: <20250729022640.3134066-1-yuzhuo@google.com>
 <20250729022640.3134066-7-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250729022640.3134066-7-yuzhuo@google.com>

On Mon, Jul 28, 2025 at 07:26:39PM -0700, Yuzhuo Jing wrote:
> Benchmark kernel queued spinlock implementation in user space.  Support
> settings of the number of threads and the number of acquire/releases.

My general advice is that you'd better add an example command line and
output in the commit message if you add any user-visible changes.  Also
please update the Documentation/perf-bench.txt.

Thanks,
Namhyung

> 
> Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
> ---
>  tools/perf/bench/Build     |   2 +
>  tools/perf/bench/bench.h   |   1 +
>  tools/perf/bench/sync.c    | 234 +++++++++++++++++++++++++++++++++++++
>  tools/perf/builtin-bench.c |   7 ++
>  4 files changed, 244 insertions(+)
>  create mode 100644 tools/perf/bench/sync.c
> 
> diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
> index b558ab98719f..13558279fa0e 100644
> --- a/tools/perf/bench/Build
> +++ b/tools/perf/bench/Build
> @@ -19,6 +19,8 @@ perf-bench-y += evlist-open-close.o
>  perf-bench-y += breakpoint.o
>  perf-bench-y += pmu-scan.o
>  perf-bench-y += uprobe.o
> +perf-bench-y += sync.o
> +perf-bench-y += qspinlock.o
>  
>  perf-bench-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
>  perf-bench-$(CONFIG_X86_64) += mem-memset-x86-64-asm.o
> diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
> index 9f736423af53..dd6c8b6126d3 100644
> --- a/tools/perf/bench/bench.h
> +++ b/tools/perf/bench/bench.h
> @@ -22,6 +22,7 @@ int bench_numa(int argc, const char **argv);
>  int bench_sched_messaging(int argc, const char **argv);
>  int bench_sched_pipe(int argc, const char **argv);
>  int bench_sched_seccomp_notify(int argc, const char **argv);
> +int bench_sync_qspinlock(int argc, const char **argv);
>  int bench_syscall_basic(int argc, const char **argv);
>  int bench_syscall_getpgid(int argc, const char **argv);
>  int bench_syscall_fork(int argc, const char **argv);
> diff --git a/tools/perf/bench/sync.c b/tools/perf/bench/sync.c
> new file mode 100644
> index 000000000000..2685cb66584c
> --- /dev/null
> +++ b/tools/perf/bench/sync.c
> @@ -0,0 +1,234 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Synchronization benchmark.
> + *
> + * 2025  Yuzhuo Jing <yuzhuo@google.com>
> + */
> +#include <bits/time.h>
> +#include <err.h>
> +#include <inttypes.h>
> +#include <perf/cpumap.h>
> +#include <pthread.h>
> +#include <stdbool.h>
> +#include <string.h>
> +#include <subcmd/parse-options.h>
> +#include <sys/cdefs.h>
> +
> +#include "bench.h"
> +
> +#include "include/qspinlock.h"
> +
> +#define NS 1000000000ull
> +#define CACHELINE_SIZE 64
> +
> +static unsigned int nthreads;
> +static unsigned long nspins = 10000ul;
> +
> +struct barrier_t;
> +
> +typedef void(*lock_fn)(void *);
> +
> +/*
> + * Lock operation definition to support multiple implmentations of locks.
> + *
> + * The lock and unlock functions only take one variable, the data pointer.
> + */
> +struct lock_ops {
> +	lock_fn lock;
> +	lock_fn unlock;
> +	void *data;
> +};
> +
> +struct worker {
> +	pthread_t thd;
> +	unsigned int tid;
> +	struct lock_ops *ops;
> +	struct barrier_t *barrier;
> +	u64 runtime;		// in nanoseconds
> +};
> +
> +static const struct option options[] = {
> +	OPT_UINTEGER('t',	"threads",	&nthreads,
> +		"Specify number of threads (default: number of CPUs)."),
> +	OPT_ULONG('n',		"spins",	&nspins,
> +		"Number of lock acquire operations per thread (default: 10,000 times)."),
> +	OPT_END()
> +};
> +
> +static const char *const bench_sync_usage[] = {
> +	"perf bench sync qspinlock <options>",
> +	NULL
> +};
> +
> +/*
> + * A atomic-based barrier.  Expect to have lower latency than pthread barrier
> + * that sleeps the thread.
> + */
> +struct barrier_t {
> +	unsigned int count __aligned(CACHELINE_SIZE);
> +};
> +
> +/*
> + * A atomic-based barrier.  Expect to have lower latency than pthread barrier
> + * that sleeps the thread.
> + */
> +__always_inline void wait_barrier(struct barrier_t *b)
> +{
> +	if (__atomic_sub_fetch(&b->count, 1, __ATOMIC_RELAXED) == 0)
> +		return;
> +	while (__atomic_load_n(&b->count, __ATOMIC_RELAXED))
> +		;
> +}
> +
> +static int bench_sync_lock_generic(struct lock_ops *ops, int argc, const char **argv);
> +
> +/*
> + * Benchmark of linux kernel queued spinlock in user land.
> + */
> +int bench_sync_qspinlock(int argc, const char **argv)
> +{
> +	struct qspinlock lock = __ARCH_SPIN_LOCK_UNLOCKED;
> +	struct lock_ops ops = {
> +		.lock = (lock_fn)queued_spin_lock,
> +		.unlock = (lock_fn)queued_spin_unlock,
> +		.data = &lock,
> +	};
> +	return bench_sync_lock_generic(&ops, argc, argv);
> +}
> +
> +/*
> + * A busy loop to acquire and release the given lock N times.
> + */
> +static void lock_loop(const struct lock_ops *ops, unsigned long n)
> +{
> +	unsigned long i;
> +
> +	for (i = 0; i < n; ++i) {
> +		ops->lock(ops->data);
> +		ops->unlock(ops->data);
> +	}
> +}
> +
> +/*
> + * Thread worker function.  Runs lock loop for N/5 times before and after
> + * the main timed loop.
> + */
> +static void *sync_workerfn(void *args)
> +{
> +	struct worker *worker = (struct worker *)args;
> +	struct timespec starttime, endtime;
> +
> +	set_this_cpu_id(worker->tid);
> +
> +	/* Barrier to let all threads start together */
> +	wait_barrier(worker->barrier);
> +
> +	/* Warmup loop (not counted) to keep the below loop contended. */
> +	lock_loop(worker->ops, nspins / 5);
> +
> +	clock_gettime(CLOCK_THREAD_CPUTIME_ID, &starttime);
> +	lock_loop(worker->ops, nspins);
> +	clock_gettime(CLOCK_THREAD_CPUTIME_ID, &endtime);
> +
> +	/* Tail loop (not counted) to keep the above loop contended. */
> +	lock_loop(worker->ops, nspins / 5);
> +
> +	worker->runtime = (endtime.tv_sec - starttime.tv_sec) * NS
> +		+ endtime.tv_nsec - starttime.tv_nsec;
> +
> +	return NULL;
> +}
> +
> +/*
> + * Generic lock synchronization benchmark function.  Sets up threads and
> + * thread affinities.
> + */
> +static int bench_sync_lock_generic(struct lock_ops *ops, int argc, const char **argv)
> +{
> +	struct perf_cpu_map *online_cpus;
> +	unsigned int online_cpus_nr;
> +	struct worker *workers;
> +	u64 totaltime = 0, total_spins, avg_ns, avg_ns_dot;
> +	struct barrier_t barrier;
> +	cpu_set_t *cpuset;
> +	size_t cpuset_size;
> +
> +	argc = parse_options(argc, argv, options, bench_sync_usage, 0);
> +	if (argc) {
> +		usage_with_options(bench_sync_usage, options);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	/* CPU count setup. */
> +	online_cpus = perf_cpu_map__new_online_cpus();
> +	if (!online_cpus)
> +		err(EXIT_FAILURE, "No online CPUs available");
> +	online_cpus_nr = perf_cpu_map__nr(online_cpus);
> +
> +	if (!nthreads) /* default to the number of CPUs */
> +		nthreads = online_cpus_nr;
> +
> +	workers = calloc(nthreads, sizeof(*workers));
> +	if (!workers)
> +		err(EXIT_FAILURE, "calloc");
> +
> +	barrier.count = nthreads;
> +
> +	printf("Running with %u threads.\n", nthreads);
> +
> +	cpuset = CPU_ALLOC(online_cpus_nr);
> +	if (!cpuset)
> +		err(EXIT_FAILURE, "Cannot allocate cpuset.");
> +	cpuset_size = CPU_ALLOC_SIZE(online_cpus_nr);
> +
> +	/* Create worker data structures, set CPU affinity, and create   */
> +	for (unsigned int i = 0; i < nthreads; ++i) {
> +		pthread_attr_t thread_attr;
> +		int ret;
> +
> +		/* Basic worker thread information */
> +		workers[i].tid = i;
> +		workers[i].barrier = &barrier;
> +		workers[i].ops = ops;
> +
> +		/* Set CPU affinity */
> +		pthread_attr_init(&thread_attr);
> +		CPU_ZERO_S(cpuset_size, cpuset);
> +		CPU_SET_S(perf_cpu_map__cpu(online_cpus, i % online_cpus_nr).cpu,
> +			cpuset_size, cpuset);
> +
> +		if (pthread_attr_setaffinity_np(&thread_attr, cpuset_size, cpuset))
> +			err(EXIT_FAILURE, "Pthread set affinity failed");
> +
> +		/* Create and block thread */
> +		ret = pthread_create(&workers[i].thd, &thread_attr, sync_workerfn, &workers[i]);
> +		if (ret != 0)
> +			err(EXIT_FAILURE, "Error creating thread: %s", strerror(ret));
> +
> +		pthread_attr_destroy(&thread_attr);
> +	}
> +
> +	CPU_FREE(cpuset);
> +
> +	for (unsigned int i = 0; i < nthreads; ++i) {
> +		int ret = pthread_join(workers[i].thd, NULL);
> +
> +		if (ret)
> +			err(EXIT_FAILURE, "pthread_join");
> +	}
> +
> +	/* Calculate overall average latency. */
> +	for (unsigned int i = 0; i < nthreads; ++i)
> +		totaltime += workers[i].runtime;
> +
> +	total_spins = (u64)nthreads * nspins;
> +	avg_ns = totaltime / total_spins;
> +	avg_ns_dot = (totaltime % total_spins) * 10000 / total_spins;
> +
> +	printf("Lock-unlock latency of %u threads: %"PRIu64".%"PRIu64" ns.\n",
> +			nthreads, avg_ns, avg_ns_dot);
> +
> +	free(workers);
> +
> +	return 0;
> +}
> diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
> index 2c1a9f3d847a..cfe6f6dc6ed4 100644
> --- a/tools/perf/builtin-bench.c
> +++ b/tools/perf/builtin-bench.c
> @@ -52,6 +52,12 @@ static struct bench sched_benchmarks[] = {
>  	{ NULL,		NULL,						NULL			}
>  };
>  
> +static struct bench sync_benchmarks[] = {
> +	{ "qspinlock",	"Benchmark for queued spinlock",		bench_sync_qspinlock	},
> +	{ "all",	"Run all synchronization benchmarks",		NULL			},
> +	{ NULL,		NULL,						NULL			}
> +};
> +
>  static struct bench syscall_benchmarks[] = {
>  	{ "basic",	"Benchmark for basic getppid(2) calls",		bench_syscall_basic	},
>  	{ "getpgid",	"Benchmark for getpgid(2) calls",		bench_syscall_getpgid	},
> @@ -122,6 +128,7 @@ struct collection {
>  
>  static struct collection collections[] = {
>  	{ "sched",	"Scheduler and IPC benchmarks",			sched_benchmarks	},
> +	{ "sync",	"Synchronization benchmarks",			sync_benchmarks		},
>  	{ "syscall",	"System call benchmarks",			syscall_benchmarks	},
>  	{ "mem",	"Memory access benchmarks",			mem_benchmarks		},
>  #ifdef HAVE_LIBNUMA_SUPPORT
> -- 
> 2.50.1.487.gc89ff58d15-goog
> 
