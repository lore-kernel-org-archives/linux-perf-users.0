Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C2C429037;
	Mon,  5 Oct 2026 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791239452; cv=none; b=dkQhMAZxbysSxbwWT1rjqcBPXVXLhRwHzwyQy7ImzVpdxxIjf+Lvy5FHBb4vYOcW/qfFfuXlxCplo8rM2jmVRScReB0/XKIJipilIrVnSeLFLmohy0hgFpooYurZR4yIbqxmA0BwlJF5ZGWKyLmqcCu/09CtWBedDSpAIpjk+LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791239452; c=relaxed/simple;
	bh=D6uIN5Q41ysaWMqar1gfkdMLo/eboazs9HTMSBoD9ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bspWbRnxgSEvo0c0Z5q9zCnFg8YnfVGGandWrs5GSxNmNB5bVyBL47grgOxd7+m68n3pp8j3B6E3gBJPEGeD3468CctFnZzO1C6IOYnMKn0Mum566ulML0xvz2rnWvt3fn/9dSE8xwA9DG1e5fyJ/y+OAuFUkOpZjJX2CVfqZUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjZNsnBL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjZNsnBL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14E61F000FF;
	Mon,  5 Oct 2026 22:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791239448;
	bh=xMIOo5mQuv9W6ZcW2O3hzJcBNuUV59eBFMWg5Op2jTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VjZNsnBLzEJgbbIwixml95EzEnq92qykpf+Em3lzh5gAaA2oxZ8F2qhOKUY4+ZuTp
	 Z3TjNYN4tMpFa6MV50HmBn0oNdQ5CAJB3CeybwHENUzgBEirdjGcD4GLLzo33Z7g3C
	 dZIp9EdfolxykWYkYE61/+9QTN4r6ys8yDXFq0TIGgOudN3Y3fnTy8xbRGxHSadOxg
	 hHQkV1dAg1UvsQ8lBZD+aKYs1+5h5D+aHVmuhBVzg4XawsQPUXZ8S2Zt5gNP6Iv4DD
	 D+agAWDgYVljqn6UIcvVKiWHc9HPujp6jxPJX2SyzAnb/O5TlAf49/ykfeDcVCrcXy
	 qWS+LsOfJ3w4g==
Date: Mon, 5 Oct 2026 15:30:46 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Changbin Du <changbin.du@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf bench: Add atomic CAS benchmark
Message-ID: <asQlFvclL-vj5xlh@google.com>
References: <20260930091617.4189736-1-changbin.du@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260930091617.4189736-1-changbin.du@gmail.com>

Hello,

On Wed, Sep 30, 2026 at 05:16:17PM +0800, Changbin Du wrote:
> Add a new 'atomic' collection to perf bench for benchmarking
> compare-and-swap (CAS) atomic operations with multi-threaded
> contention testing.
> 
> The benchmark tests __atomic_compare_exchange_n operations
> with configurable thread count and iteration count to measure
> atomic contention effects.
> 
> Why this benchmark is needed:
> - CAS operations are fundamental to lock-free algorithms and data
>   structures. Understanding their performance characteristics under
>   contention is critical for designing high-performance concurrent
>   applications.
> - The benchmark helps identify atomic operation latency and
>   scalability issues across different thread counts, revealing
>   contention patterns that are not visible in single-threaded tests.
> - Useful for evaluating atomic implementation quality on different
>   architectures and for regression testing after changes to atomic
>   primitives or memory ordering.
> 
> Measurement methodology:
> - Each thread starts a private timer (clock_gettime CLOCK_MONOTONIC)
>   after synchronizing on a pthread_barrier, ensuring all threads
>   begin simultaneously.
> - Each thread performs a hot loop of atomic compare-and-swap on a
>   shared u64 counter, incrementing from 0 to iterations.
> - The shared counter is cache-line aligned (64 bytes) to isolate
>   contention to the target cache line and avoid false sharing.
> - The wall-clock time is measured as the max of all per-thread
>   runtimes (the time for the slowest thread to finish).
> - The first repeat is excluded from statistics as a warmup phase
>   to avoid cache-cold effects.
> Example usage:
>   $ perf bench atomic cas --threads 2
>   # Running 'atomic/cas' benchmark:
> 
>     Threads: 2, iterations/thread: 100000000, repeats: 10 (warmup: 1)
>     Avg wall-clock time: 7365.480 msec  (stddev 66.014 msec)
>     Total ops: 200,000,000
>     Throughput total: 27,153,697 ops/sec
>     Per-thread times and throughput (last repeat):
>       fastest:  7510.031 msec  (13315525 ops/sec)
>       slowest:  7581.678 msec  (13189692 ops/sec)
>       avg:      7545.854 msec  (13252310 ops/sec)
> 
> Output fields explained:
> - Threads: number of contending threads
> - iterations/thread: CAS operations each thread performs
> - repeats: number of test runs (first is warmup)
> - Avg wall-clock time: mean time for all threads to complete
> - stddev: standard deviation across repeats
> - Total ops: threads x iterations/thread
> - Throughput total: aggregate ops/sec across all threads
> - Per-thread times: fastest/slowest/avg thread completion time
> - Per-thread throughput: per-thread ops/sec (shows scheduling imbalance)

Thanks for the contribution!  I think it's very useful.
Just a few suggestions.

1. it'd be nice to add simple atomic_inc benchmark too.
2. it'd be nice to have an option to try other ordering requirements
   than "relaxed".

Thanks,
Namhyung

> 
> Assisted-by: opencode:DeepSeek-V4-Pro
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/Documentation/perf-bench.txt |  22 +++
>  tools/perf/bench/Build                  |   1 +
>  tools/perf/bench/atomic.c               | 229 ++++++++++++++++++++++++
>  tools/perf/bench/bench.h                |   1 +
>  tools/perf/builtin-bench.c              |   8 +
>  5 files changed, 261 insertions(+)
>  create mode 100644 tools/perf/bench/atomic.c
> 
> diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
> index c5913cf59c98..9cdc19f02bcf 100644
> --- a/tools/perf/Documentation/perf-bench.txt
> +++ b/tools/perf/Documentation/perf-bench.txt
> @@ -58,6 +58,9 @@ SUBSYSTEM
>  'numa'::
>  	NUMA scheduling and MM benchmarks.
>  
> +'atomic'::
> +	Atomic operation benchmarks.
> +
>  'futex'::
>  	Futex stressing benchmarks.
>  
> @@ -283,6 +286,25 @@ SUITES FOR 'numa'
>  *mem*::
>  Suite for evaluating NUMA workloads.
>  
> +SUITES FOR 'atomic'
> +~~~~~~~~~~~~~~~~~~~
> +*cas*::
> +Suite for evaluating compare-and-swap (CAS) atomic operations under
> +multi-threaded contention.
> +
> +Options of *cas*
> +^^^^^^^^^^^^^^^^
> +-t::
> +--threads=::
> +Number of threads contending for the shared counter (default: 2).
> +
> +-i::
> +--iterations=::
> +Number of iterations per thread (default: 100000000).
> +
> +The per-thread fastest/slowest/avg summary is only printed when
> +running with more than one thread.
> +
>  SUITES FOR 'futex'
>  ~~~~~~~~~~~~~~~~~~
>  *hash*::
> diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
> index 67b76fe20ba6..c64c52468d3d 100644
> --- a/tools/perf/bench/Build
> +++ b/tools/perf/bench/Build
> @@ -3,6 +3,7 @@ perf-bench-y += sched-pipe.o
>  perf-bench-y += sched-seccomp-notify.o
>  perf-bench-y += syscall.o
>  perf-bench-y += mem-functions.o
> +perf-bench-y += atomic.o
>  perf-bench-y += futex.o
>  perf-bench-y += futex-hash.o
>  perf-bench-y += futex-wake.o
> diff --git a/tools/perf/bench/atomic.c b/tools/perf/bench/atomic.c
> new file mode 100644
> index 000000000000..ce97025018ab
> --- /dev/null
> +++ b/tools/perf/bench/atomic.c
> @@ -0,0 +1,229 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Changbin Du
> + *
> + * Benchmark for atomic compare-and-swap (CAS) operations.
> + *
> + * Measures throughput (ops/sec) of contended CAS on a single shared
> + * counter across multiple threads. Each thread performs a hot loop
> + * of compare-and-swap, competing with all other threads for the
> + * same cache line.
> + */
> +#include "bench.h"
> +#include <linux/compiler.h>
> +#include "../util/debug.h"
> +
> +#ifndef HAVE_PTHREAD_BARRIER
> +int bench_atomic(int argc __maybe_unused, const char **argv __maybe_unused)
> +{
> +	pr_err("%s: pthread_barrier_t unavailable, disabling this test...\n", __func__);
> +	return 0;
> +}
> +#else /* HAVE_PTHREAD_BARRIER */
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <pthread.h>
> +#include <time.h>
> +#include <inttypes.h>
> +#include <err.h>
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/time64.h>
> +#include <subcmd/parse-options.h>
> +#include "../util/stat.h"
> +
> +static unsigned int threads	= 2;
> +static unsigned int iterations	= 100000000;
> +
> +static const struct option options[] = {
> +	OPT_UINTEGER('t', "threads", &threads,
> +		     "Number of threads contending for the counter"),
> +	OPT_UINTEGER('i', "iterations", &iterations,
> +		     "Number of iterations per thread"),
> +	OPT_END()
> +};
> +
> +static const char * const bench_usage[] = {
> +	"perf bench atomic cas <options>",
> +	NULL
> +};
> +
> +static u64 shared_counter __aligned(64);
> +static pthread_barrier_t start_barrier __aligned(64);
> +
> +struct worker_stats {
> +	u64	runtime_ns;
> +};
> +
> +static void *worker(void *arg)
> +{
> +	struct worker_stats *ws = (struct worker_stats *)arg;
> +	struct timespec tstart, tend;
> +	u64 i;
> +
> +	pthread_barrier_wait(&start_barrier);
> +
> +	clock_gettime(CLOCK_MONOTONIC, &tstart);
> +	for (i = 0; i < iterations; i++) {
> +		u64 old_val, new_val;
> +
> +		do {
> +			old_val = __atomic_load_n(&shared_counter,
> +						  __ATOMIC_RELAXED);
> +			new_val = old_val + 1;
> +		} while (!__atomic_compare_exchange_n(&shared_counter,
> +						      &old_val, new_val,
> +						      false,
> +						      __ATOMIC_RELAXED,
> +						      __ATOMIC_RELAXED));
> +	}
> +	clock_gettime(CLOCK_MONOTONIC, &tend);
> +
> +	ws->runtime_ns	= (tend.tv_sec - tstart.tv_sec) * NSEC_PER_SEC +
> +			  (tend.tv_nsec - tstart.tv_nsec);
> +
> +	return NULL;
> +}
> +
> +static void print_default_format(struct worker_stats *wstats,
> +				 struct stats *time_stats)
> +{
> +	double time_avg, time_stddev;
> +
> +	printf("  Threads: %u, iterations/thread: %u, repeats: %u (warmup: 1)\n",
> +	       threads, iterations, bench_repeat);
> +
> +	time_avg    = avg_stats(time_stats);
> +	time_stddev = stddev_stats(time_stats);
> +
> +	printf("  Avg wall-clock time: %.3f msec  (stddev %.3f msec)\n",
> +	       time_avg / (double)NSEC_PER_MSEC,
> +	       time_stddev / (double)NSEC_PER_MSEC);
> +	printf("  Total ops: %'" PRIu64 "\n",
> +	       iterations * (u64)threads);
> +	printf("  Throughput total: %'.0f ops/sec\n",
> +	       (double)(iterations * (u64)threads) /
> +	       (time_avg / (double)NSEC_PER_SEC));
> +
> +	/*
> +	 * Per-thread statistics from the last measured repeat show
> +	 * fairness / imbalance in CPU scheduling.
> +	 */
> +	if (threads > 1) {
> +		u64 min_ns = UINT64_MAX, max_ns = 0, total_ns = 0;
> +		double min_thru, max_thru, avg_thru;
> +
> +		for (unsigned int t = 0; t < threads; t++) {
> +			if (wstats[t].runtime_ns < min_ns)
> +				min_ns = wstats[t].runtime_ns;
> +			if (wstats[t].runtime_ns > max_ns)
> +				max_ns = wstats[t].runtime_ns;
> +			total_ns += wstats[t].runtime_ns;
> +		}
> +
> +		min_thru = (double)iterations * NSEC_PER_SEC / min_ns;
> +		max_thru = (double)iterations * NSEC_PER_SEC / max_ns;
> +		avg_thru = (double)threads * iterations * NSEC_PER_SEC / total_ns;
> +
> +		printf("  Per-thread times and throughput (last repeat):\n");
> +		printf("    fastest:  %.3f msec  (%.0f ops/sec)\n",
> +		       min_ns / (double)NSEC_PER_MSEC, min_thru);
> +		printf("    slowest:  %.3f msec  (%.0f ops/sec)\n",
> +		       max_ns / (double)NSEC_PER_MSEC, max_thru);
> +		printf("    avg:      %.3f msec  (%.0f ops/sec)\n",
> +		       (total_ns / threads) / (double)NSEC_PER_MSEC, avg_thru);
> +	}
> +}
> +
> +static int run_cas_benchmark(void)
> +{
> +	pthread_t *thread_ids;
> +	struct worker_stats *wstats;
> +	struct stats time_stats;
> +	unsigned int r, t;
> +
> +	thread_ids = calloc(threads, sizeof(pthread_t));
> +	if (!thread_ids)
> +		return -1;
> +
> +	wstats = calloc(threads, sizeof(struct worker_stats));
> +	if (!wstats) {
> +		free(thread_ids);
> +		return -1;
> +	}
> +
> +	init_stats(&time_stats);
> +
> +	for (r = 0; r < bench_repeat + 1; r++) {
> +		u64 max_runtime_ns = 0;
> +
> +		shared_counter = 0;
> +		pthread_barrier_init(&start_barrier, NULL, threads);
> +
> +		for (t = 0; t < threads; t++) {
> +			if (pthread_create(&thread_ids[t], NULL,
> +					   worker, &wstats[t]))
> +				err(EXIT_FAILURE, "pthread_create");
> +		}
> +
> +		for (t = 0; t < threads; t++)
> +			pthread_join(thread_ids[t], NULL);
> +
> +		pthread_barrier_destroy(&start_barrier);
> +
> +		for (t = 0; t < threads; t++) {
> +			if (wstats[t].runtime_ns > max_runtime_ns)
> +				max_runtime_ns = wstats[t].runtime_ns;
> +		}
> +
> +		/*
> +		 * Exclude the first repeat (warmup) from statistics so
> +		 * that cache-cold and lazy-init effects are not counted.
> +		 */
> +		if (r > 0)
> +			update_stats(&time_stats, max_runtime_ns);
> +	}
> +
> +	switch (bench_format) {
> +	case BENCH_FORMAT_DEFAULT:
> +		print_default_format(wstats, &time_stats);
> +		break;
> +
> +	case BENCH_FORMAT_SIMPLE:
> +		printf("%.0f\n",
> +		       (double)(iterations * (u64)threads) /
> +		       (avg_stats(&time_stats) / (double)NSEC_PER_SEC));
> +		break;
> +
> +	default:
> +		fprintf(stderr, "Unknown format: %d\n", bench_format);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	free(thread_ids);
> +	free(wstats);
> +
> +	return 0;
> +}
> +
> +int bench_atomic(int argc, const char **argv)
> +{
> +	if (parse_options(argc, argv, options, bench_usage, 0)) {
> +		usage_with_options(bench_usage, options);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	if (threads < 1) {
> +		fprintf(stderr, "Invalid thread count: %u\n", threads);
> +		return 1;
> +	}
> +
> +	if (iterations < 1) {
> +		fprintf(stderr, "Invalid iteration count: %u\n", iterations);
> +		return 1;
> +	}
> +
> +	return run_cas_benchmark();
> +}
> +#endif /* HAVE_PTHREAD_BARRIER */
> diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
> index 8519eb5a42fa..01eb6ceffb8d 100644
> --- a/tools/perf/bench/bench.h
> +++ b/tools/perf/bench/bench.h
> @@ -30,6 +30,7 @@ int bench_mem_memcpy(int argc, const char **argv);
>  int bench_mem_memset(int argc, const char **argv);
>  int bench_mem_mmap(int argc, const char **argv);
>  int bench_mem_find_bit(int argc, const char **argv);
> +int bench_atomic(int argc, const char **argv);
>  int bench_futex_hash(int argc, const char **argv);
>  int bench_futex_wake(int argc, const char **argv);
>  int bench_futex_wake_parallel(int argc, const char **argv);
> diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
> index 02d47913cc6a..aeffa0826aea 100644
> --- a/tools/perf/builtin-bench.c
> +++ b/tools/perf/builtin-bench.c
> @@ -14,6 +14,7 @@
>   *  syscall ... System call performance
>   *  mem   ... memory access performance
>   *  numa  ... NUMA scheduling and MM performance
> + *  atomic ... Atomic operation performance
>   *  futex ... Futex performance
>   *  epoll ... Event poll performance
>   */
> @@ -115,6 +116,12 @@ static const struct bench uprobe_benchmarks[] = {
>  	{ NULL,	NULL, NULL },
>  };
>  
> +static const struct bench atomic_benchmarks[] = {
> +	{ "cas",	"Benchmark CAS (compare-and-swap) operations",	bench_atomic		},
> +	{ "all",	"Run all atomic benchmarks",			NULL			},
> +	{ NULL,		NULL,						NULL			}
> +};
> +
>  struct collection {
>  	const char		*name;
>  	const char		*summary;
> @@ -128,6 +135,7 @@ static const struct collection collections[] = {
>  #ifdef HAVE_LIBNUMA_SUPPORT
>  	{ "numa",	"NUMA scheduling and MM benchmarks",		numa_benchmarks		},
>  #endif
> +	{ "atomic",	"Atomic operation benchmarks",			atomic_benchmarks	},
>  	{"futex",       "Futex stressing benchmarks",                   futex_benchmarks        },
>  #ifdef HAVE_EVENTFD_SUPPORT
>  	{"epoll",       "Epoll stressing benchmarks",                   epoll_benchmarks        },
> -- 
> 2.53.0
> 
