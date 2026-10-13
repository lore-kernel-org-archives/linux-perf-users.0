Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A13E331200
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 07:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877697; cv=none; b=S7A3bOLt+2cVwXNX+ksFDpdYLD1JuMHde62RB6226l20Xe7cSc8OS00tUacClsl1smNlgox9KZLZhtuMhC6ixh1Fpk9CAnojhuvrGJF6P8Gm2JvRMpoEllH+S88psUcHJohrT4G7pV8zHCjkrbD1kFoZa2Ij94Kk/V03qKrRwOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877697; c=relaxed/simple;
	bh=cbpQdvGiUqMd8HcptNM5COQdlc9nStPPkS8U/Q0w5F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ef89/pzqMkyqMFKTnh4RDHtCINEMeKgyRakaQv/ZtMVrpXkGJEPH/XeSBROr2COYmwRSmDTi0s6bnRi4wBNqNITATjI/X46XaLpOR0MRn1zUuucuT+gwyFf4QIgJwqLTaKrSc22LtWktXaPdTpwFwFnoaSCBcSrfwIyz1TsvSaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxD6Kb06; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxD6Kb06"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e81738d24eso22660145ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 00:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791877695; x=1792482495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y4VSleMJVOdQag/GU8tRioqf/at46h1dLRpWKJjbZAQ=;
        b=cxD6Kb062vq13Bta24Cd+sNe9SS7Xcpl5cOsfMDW68PnzyvFKzlhDCJrLA583OHvnd
         BTZLzHD/FREbmWnFYXO+THkJsJ6rySdE5yiyDMOequiP5kk417rZavyvNZ1kh2Fo31en
         b+71vTatiqhclJcC+LTqJKAcMH6auj9XB0J7tDRX8TVpA4EGae70upbOTKPknkFP44dO
         H/XHrTYuxE1T8nkZn+zqcfOWuAUhODILUjCngGVieebmOUBh74n7DbMe23zOLQa2Xkw+
         WIhrEQ/O3GkgbJcqmB0AhNtsGKpJh8HSoOhsNoH2MYhAnuftN9QrE2zY7z7JDBclArz4
         dDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791877695; x=1792482495;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y4VSleMJVOdQag/GU8tRioqf/at46h1dLRpWKJjbZAQ=;
        b=b5nvMla6pcAdomZdW2M/UtdjQuRw2wZuQF6QuhTyvXPy5iYoP21TdB+dxi6R+cTNQ0
         85C9DTFefwGRQyZeUj986RsB/oSluJ7vnU9ue4esSEMoNspbUiUrLbNzF/OZvlw7HLTq
         S9w54Q119mY/l1ONJbLG2iAIM9IFW8LwEsev8gJZKmhcrxBXJZxJLsowFiIShsF0dHQ4
         uOgezX+qaoTWvMl4LwAVbRSZEBjjOgLe7bxq53WIPuN4+qCwymprqnegU8rUu0QZBq63
         +Y08QSSuuyBEagb6/lRrwDf3mK2yw4CpqIHXTUvr/3LtoOYNPH9vcY2BdDgqIaxUAr8L
         9hMg==
X-Forwarded-Encrypted: i=1; AKwUvBzMAuFmCVVxXXqYRS3eNQ264KncSPtKUQO6bRtN3g3svcoUpOjx08KQ20Cd+yLFuEcDnfd8WtQITmexTvr04pfw@vger.kernel.org
X-Gm-Message-State: AFq9FYKui+vvyfDZLdIFdNkD66wgrJAM+zaWD9cj0P7ZZXc3THexqGpy
	j7sKDvNUzPdNAw2BkWglum9/kgqeoUm/LYyz7CiXwUm5IjjWCoVcqMwx
X-Gm-Gg: AYBFou2Bt1E3/wYHPbAFv3B3xGAkqh7zT0IGm7UkXzIvVLXloS/M551G+ZUBXrJh2Bn
	Wv1KmgHv7HCefYPNPdl+Bubg2Z5FX8qN/+7TFjG8ZjTCGXrVSuZSDMwQ28DOi5PhWwPI05N2iT6
	IR33udU7XCEi5vuNVK3dCfP+Esb38VEUgwNHH8GCYopa6Cjee1v65sMOXowkMkKBylEd31EjIkf
	H/ddjLKjfT7PuYu3+FkuM6MccIdic1ngnGlbZ6ErGJ7bl4+Bi4s+7SeIGP5pma/4KnlSA0H+4Un
	x9Gdw44i6NdOtKVLihHlQm9A94nku7pgEz2m9eGMgeK86nXmUkZn6IOzPvW3707GVSMFm8qfA7Q
	inCIiJW6u0rwu048nFYN0v11T/9Yo9a/Npd5CMd3FpXWb3qUBc0vIDGRAVD9VcN+t7QAi6+VV+x
	20CJd3XpoPfTxBLWura6dNUq3klUfi2zGwsQK8KJRkkQPA2xOEbVyOh/ssWKO8pmNAK0scL4MPc
	9g=
X-Received: by 2002:a17:903:286:b0:2e2:da4f:b2bf with SMTP id d9443c01a7336-2e842f11b8cmr129759495ad.44.1791877695136;
        Tue, 13 Oct 2026 00:48:15 -0700 (PDT)
Received: from mail.google.com ([5.34.221.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8d9asm50770655ad.62.2026.10.13.00.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 00:48:14 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:48:04 +0800
From: Changbin Du <changbin.du@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Changbin Du <changbin.du@gmail.com>, 
	David Laight <david.laight.linux@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3] perf bench: Add atomic operations benchmark
Message-ID: <as3fw4jxf30lyjyp@mail.google.com>
References: <20261008041123.1970315-1-changbin.du@gmail.com>
 <as01ic9P29WcdJj_@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as01ic9P29WcdJj_@google.com>

On Mon, Oct 12, 2026 at 12:31:21PM -0700, Namhyung Kim wrote:
> On Thu, Oct 08, 2026 at 12:11:23PM +0800, Changbin Du wrote:
[...]
> > Assisted-by: opencode:DeepSeek-V4-Pro
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> 
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> 
> Thanks,
> Namhyung
> 

Thanks for the review. As David suggested, the fixed-time run will use
a runtime in seconds instead of iteration count. Threads sync on a 
pthread_barrier, spin on the atomic op while counting their own operations,
and stop when the main thread sets a shared done flag after the timer
expires. Workers poll it every 1024 ops to keep the hot loop unperturbed.
Throughput is total ops over wall time; per-thread counts verify no
thread stalled. Please see the V4 patch later for these changes.

> > ---
> > Changes in v3:
> > - Use native word size (unsigned long) for the shared counter instead
> >   of u64 to avoid libatomic on 32-bit targets.
> > - Include <stdint.h> explicitly for UINT64_MAX.
> > 
> > Changes in v2:
> > - Add an 'atomic inc' subcommand for contended __atomic_fetch_add.
> > - Hoist the load out of the CAS retry loop; the failed
> >   __atomic_compare_exchange_n already returns the current value.
> > - Cast the seconds delta to u64 before multiplying by NSEC_PER_SEC to
> >   avoid 32-bit overflow.
> > ---
> >  tools/perf/Documentation/perf-bench.txt |  32 +++
> >  tools/perf/bench/Build                  |   1 +
> >  tools/perf/bench/atomic.c               | 268 ++++++++++++++++++++++++
> >  tools/perf/bench/bench.h                |   2 +
> >  tools/perf/builtin-bench.c              |   9 +
> >  5 files changed, 312 insertions(+)
> >  create mode 100644 tools/perf/bench/atomic.c
> > 
> > diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
> > index c5913cf59c98..871c3aa5fc43 100644
> > --- a/tools/perf/Documentation/perf-bench.txt
> > +++ b/tools/perf/Documentation/perf-bench.txt
> > @@ -58,6 +58,9 @@ SUBSYSTEM
> >  'numa'::
> >  	NUMA scheduling and MM benchmarks.
> >  
> > +'atomic'::
> > +	Atomic operation benchmarks.
> > +
> >  'futex'::
> >  	Futex stressing benchmarks.
> >  
> > @@ -283,6 +286,35 @@ SUITES FOR 'numa'
> >  *mem*::
> >  Suite for evaluating NUMA workloads.
> >  
> > +SUITES FOR 'atomic'
> > +~~~~~~~~~~~~~~~~~~~
> > +*cas*::
> > +Suite for evaluating compare-and-swap (CAS) atomic operations under
> > +multi-threaded contention.
> > +
> > +*inc*::
> > +Suite for evaluating atomic fetch-add (increment) operations under
> > +multi-threaded contention.
> > +
> > +Options of *cas* and *inc*
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +-t::
> > +--threads=::
> > +Number of threads contending for the shared counter (default: 2).
> > +
> > +-i::
> > +--iterations=::
> > +Number of iterations per thread (default: 100000000).
> > +
> > +The per-thread fastest/slowest/avg summary is only printed when
> > +running with more than one thread.
> > +
> > +Note that the cas benchmark counts successful compare-and-swap
> > +operations only; retries and the loads between them are additional
> > +atomic instructions not included in the ops/sec count, so cas and
> > +inc throughputs are not directly comparable at the instruction
> > +level.
> > +
> >  SUITES FOR 'futex'
> >  ~~~~~~~~~~~~~~~~~~
> >  *hash*::
> > diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
> > index 67b76fe20ba6..c64c52468d3d 100644
> > --- a/tools/perf/bench/Build
> > +++ b/tools/perf/bench/Build
> > @@ -3,6 +3,7 @@ perf-bench-y += sched-pipe.o
> >  perf-bench-y += sched-seccomp-notify.o
> >  perf-bench-y += syscall.o
> >  perf-bench-y += mem-functions.o
> > +perf-bench-y += atomic.o
> >  perf-bench-y += futex.o
> >  perf-bench-y += futex-hash.o
> >  perf-bench-y += futex-wake.o
> > diff --git a/tools/perf/bench/atomic.c b/tools/perf/bench/atomic.c
> > new file mode 100644
> > index 000000000000..a7e906cf2ec1
> > --- /dev/null
> > +++ b/tools/perf/bench/atomic.c
> > @@ -0,0 +1,268 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2026 Changbin Du <changbin.du@gmail.com>
> > + *
> > + * Benchmarks for atomic read-modify-write operations.
> > + *
> > + * Measures throughput (ops/sec) of contended atomic operations on a
> > + * single shared counter across multiple threads. Each thread performs
> > + * a hot loop of the selected operation -- compare-and-swap (cas) or
> > + * fetch-add (inc) -- competing with all other threads for the same
> > + * cache line.
> > + */
> > +#include "bench.h"
> > +#include <linux/compiler.h>
> > +#include "../util/debug.h"
> > +
> > +#ifndef HAVE_PTHREAD_BARRIER
> > +int bench_atomic_cas(int argc __maybe_unused, const char **argv __maybe_unused)
> > +{
> > +	pr_err("%s: pthread_barrier_t unavailable, disabling this test...\n", __func__);
> > +	return 0;
> > +}
> > +
> > +int bench_atomic_inc(int argc __maybe_unused, const char **argv __maybe_unused)
> > +{
> > +	pr_err("%s: pthread_barrier_t unavailable, disabling this test...\n", __func__);
> > +	return 0;
> > +}
> > +#else /* HAVE_PTHREAD_BARRIER */
> > +#include <stdlib.h>
> > +#include <stdio.h>
> > +#include <stdbool.h>
> > +#include <stdint.h>
> > +#include <pthread.h>
> > +#include <time.h>
> > +#include <inttypes.h>
> > +#include <err.h>
> > +#include <linux/types.h>
> > +#include <linux/time64.h>
> > +#include <subcmd/parse-options.h>
> > +#include "../util/stat.h"
> > +
> > +static unsigned int threads	= 2;
> > +static unsigned int iterations	= 100000000;
> > +
> > +static const struct option options[] = {
> > +	OPT_UINTEGER('t', "threads", &threads,
> > +		     "Number of threads contending for the counter"),
> > +	OPT_UINTEGER('i', "iterations", &iterations,
> > +		     "Number of iterations per thread"),
> > +	OPT_END()
> > +};
> > +
> > +static const char * const cas_usage[] = {
> > +	"perf bench atomic cas <options>",
> > +	NULL
> > +};
> > +
> > +static const char * const inc_usage[] = {
> > +	"perf bench atomic inc <options>",
> > +	NULL
> > +};
> > +
> > +enum atomic_op {
> > +	OP_CAS,
> > +	OP_INC,
> > +};
> > +
> > +static int bench_op = OP_CAS;
> > +
> > +static unsigned long shared_counter __aligned(64);
> > +static pthread_barrier_t start_barrier __aligned(64);
> > +
> > +struct worker_stats {
> > +	u64	runtime_ns;
> > +};
> > +
> > +static void *worker(void *arg)
> > +{
> > +	struct worker_stats *ws = (struct worker_stats *)arg;
> > +	struct timespec tstart, tend;
> > +	u64 i;
> > +
> > +	pthread_barrier_wait(&start_barrier);
> > +
> > +	clock_gettime(CLOCK_MONOTONIC, &tstart);
> > +	switch (bench_op) {
> > +	case OP_CAS:
> > +		for (i = 0; i < iterations; i++) {
> > +			unsigned long old_val, new_val;
> > +
> > +			old_val = __atomic_load_n(&shared_counter, __ATOMIC_RELAXED);
> > +			do {
> > +				new_val = old_val + 1;
> > +			} while (!__atomic_compare_exchange_n(&shared_counter,
> > +							      &old_val, new_val,
> > +							      false,
> > +							      __ATOMIC_RELAXED,
> > +							      __ATOMIC_RELAXED));
> > +		}
> > +		break;
> > +	case OP_INC:
> > +		for (i = 0; i < iterations; i++)
> > +			__atomic_fetch_add(&shared_counter, 1, __ATOMIC_RELAXED);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +	clock_gettime(CLOCK_MONOTONIC, &tend);
> > +
> > +	ws->runtime_ns	= (u64)(tend.tv_sec - tstart.tv_sec) * NSEC_PER_SEC +
> > +			  (tend.tv_nsec - tstart.tv_nsec);
> > +
> > +	return NULL;
> > +}
> > +
> > +static void print_default_format(struct worker_stats *wstats,
> > +				 struct stats *time_stats)
> > +{
> > +	double time_avg, time_stddev;
> > +
> > +	printf("  Threads: %u, iterations/thread: %u, repeats: %u (warmup: 1)\n",
> > +	       threads, iterations, bench_repeat);
> > +
> > +	time_avg    = avg_stats(time_stats);
> > +	time_stddev = stddev_stats(time_stats);
> > +
> > +	printf("  Avg wall-clock time: %.3f msec  (stddev %.3f msec)\n",
> > +	       time_avg / (double)NSEC_PER_MSEC,
> > +	       time_stddev / (double)NSEC_PER_MSEC);
> > +	printf("  Total ops: %'" PRIu64 "\n",
> > +	       iterations * (u64)threads);
> > +	printf("  Throughput total: %'.0f ops/sec\n",
> > +	       (double)(iterations * (u64)threads) /
> > +	       (time_avg / (double)NSEC_PER_SEC));
> > +
> > +	/*
> > +	 * Per-thread statistics from the last measured repeat show
> > +	 * fairness / imbalance in CPU scheduling.
> > +	 */
> > +	if (threads > 1) {
> > +		u64 min_ns = UINT64_MAX, max_ns = 0, total_ns = 0;
> > +		double min_thru, max_thru, avg_thru;
> > +
> > +		for (unsigned int t = 0; t < threads; t++) {
> > +			if (wstats[t].runtime_ns < min_ns)
> > +				min_ns = wstats[t].runtime_ns;
> > +			if (wstats[t].runtime_ns > max_ns)
> > +				max_ns = wstats[t].runtime_ns;
> > +			total_ns += wstats[t].runtime_ns;
> > +		}
> > +
> > +		min_thru = (double)iterations * NSEC_PER_SEC / min_ns;
> > +		max_thru = (double)iterations * NSEC_PER_SEC / max_ns;
> > +		avg_thru = (double)threads * iterations * NSEC_PER_SEC / total_ns;
> > +
> > +		printf("  Per-thread times and throughput (last repeat):\n");
> > +		printf("    fastest:  %.3f msec  (%.0f ops/sec)\n",
> > +		       min_ns / (double)NSEC_PER_MSEC, min_thru);
> > +		printf("    slowest:  %.3f msec  (%.0f ops/sec)\n",
> > +		       max_ns / (double)NSEC_PER_MSEC, max_thru);
> > +		printf("    avg:      %.3f msec  (%.0f ops/sec)\n",
> > +		       (total_ns / threads) / (double)NSEC_PER_MSEC, avg_thru);
> > +	}
> > +}
> > +
> > +static int run_benchmark(void)
> > +{
> > +	pthread_t *thread_ids;
> > +	struct worker_stats *wstats;
> > +	struct stats time_stats;
> > +	unsigned int r, t;
> > +
> > +	thread_ids = calloc(threads, sizeof(pthread_t));
> > +	if (!thread_ids)
> > +		err(EXIT_FAILURE, "calloc");
> > +
> > +	wstats = calloc(threads, sizeof(struct worker_stats));
> > +	if (!wstats)
> > +		err(EXIT_FAILURE, "calloc");
> > +
> > +	init_stats(&time_stats);
> > +
> > +	for (r = 0; r < bench_repeat + 1; r++) {
> > +		u64 max_runtime_ns = 0;
> > +
> > +		shared_counter = 0;
> > +		pthread_barrier_init(&start_barrier, NULL, threads);
> > +
> > +		for (t = 0; t < threads; t++) {
> > +			if (pthread_create(&thread_ids[t], NULL,
> > +					   worker, &wstats[t]))
> > +				err(EXIT_FAILURE, "pthread_create");
> > +		}
> > +
> > +		for (t = 0; t < threads; t++)
> > +			pthread_join(thread_ids[t], NULL);
> > +
> > +		pthread_barrier_destroy(&start_barrier);
> > +
> > +		for (t = 0; t < threads; t++) {
> > +			if (wstats[t].runtime_ns > max_runtime_ns)
> > +				max_runtime_ns = wstats[t].runtime_ns;
> > +		}
> > +
> > +		/*
> > +		 * Exclude the first repeat (warmup) from statistics so
> > +		 * that cache-cold and lazy-init effects are not counted.
> > +		 */
> > +		if (r > 0)
> > +			update_stats(&time_stats, max_runtime_ns);
> > +	}
> > +
> > +	switch (bench_format) {
> > +	case BENCH_FORMAT_DEFAULT:
> > +		print_default_format(wstats, &time_stats);
> > +		break;
> > +
> > +	case BENCH_FORMAT_SIMPLE:
> > +		printf("%.0f\n",
> > +		       (double)(iterations * (u64)threads) /
> > +		       (avg_stats(&time_stats) / (double)NSEC_PER_SEC));
> > +		break;
> > +
> > +	default:
> > +		fprintf(stderr, "Unknown format: %d\n", bench_format);
> > +		exit(EXIT_FAILURE);
> > +	}
> > +
> > +	free(thread_ids);
> > +	free(wstats);
> > +
> > +	return 0;
> > +}
> > +
> > +static int run_atomic_bench(int argc, const char **argv,
> > +			    const char * const *usage)
> > +{
> > +	if (parse_options(argc, argv, options, usage, 0)) {
> > +		usage_with_options(usage, options);
> > +		exit(EXIT_FAILURE);
> > +	}
> > +
> > +	if (threads < 1) {
> > +		fprintf(stderr, "Invalid thread count: %u\n", threads);
> > +		return 1;
> > +	}
> > +
> > +	if (iterations < 1) {
> > +		fprintf(stderr, "Invalid iteration count: %u\n", iterations);
> > +		return 1;
> > +	}
> > +
> > +	return run_benchmark();
> > +}
> > +
> > +int bench_atomic_cas(int argc, const char **argv)
> > +{
> > +	bench_op = OP_CAS;
> > +	return run_atomic_bench(argc, argv, cas_usage);
> > +}
> > +
> > +int bench_atomic_inc(int argc, const char **argv)
> > +{
> > +	bench_op = OP_INC;
> > +	return run_atomic_bench(argc, argv, inc_usage);
> > +}
> > +#endif /* HAVE_PTHREAD_BARRIER */
> > diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
> > index 8519eb5a42fa..85e3ac471875 100644
> > --- a/tools/perf/bench/bench.h
> > +++ b/tools/perf/bench/bench.h
> > @@ -30,6 +30,8 @@ int bench_mem_memcpy(int argc, const char **argv);
> >  int bench_mem_memset(int argc, const char **argv);
> >  int bench_mem_mmap(int argc, const char **argv);
> >  int bench_mem_find_bit(int argc, const char **argv);
> > +int bench_atomic_cas(int argc, const char **argv);
> > +int bench_atomic_inc(int argc, const char **argv);
> >  int bench_futex_hash(int argc, const char **argv);
> >  int bench_futex_wake(int argc, const char **argv);
> >  int bench_futex_wake_parallel(int argc, const char **argv);
> > diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
> > index 02d47913cc6a..62bebdedd3b8 100644
> > --- a/tools/perf/builtin-bench.c
> > +++ b/tools/perf/builtin-bench.c
> > @@ -14,6 +14,7 @@
> >   *  syscall ... System call performance
> >   *  mem   ... memory access performance
> >   *  numa  ... NUMA scheduling and MM performance
> > + *  atomic ... Atomic operation performance
> >   *  futex ... Futex performance
> >   *  epoll ... Event poll performance
> >   */
> > @@ -115,6 +116,13 @@ static const struct bench uprobe_benchmarks[] = {
> >  	{ NULL,	NULL, NULL },
> >  };
> >  
> > +static const struct bench atomic_benchmarks[] = {
> > +	{ "cas",	"Benchmark CAS (compare-and-swap) operations",	bench_atomic_cas	},
> > +	{ "inc",	"Benchmark atomic fetch-add operations",	bench_atomic_inc	},
> > +	{ "all",	"Run all atomic benchmarks",			NULL			},
> > +	{ NULL,		NULL,						NULL			}
> > +};
> > +
> >  struct collection {
> >  	const char		*name;
> >  	const char		*summary;
> > @@ -128,6 +136,7 @@ static const struct collection collections[] = {
> >  #ifdef HAVE_LIBNUMA_SUPPORT
> >  	{ "numa",	"NUMA scheduling and MM benchmarks",		numa_benchmarks		},
> >  #endif
> > +	{ "atomic",	"Atomic operation benchmarks",			atomic_benchmarks	},
> >  	{"futex",       "Futex stressing benchmarks",                   futex_benchmarks        },
> >  #ifdef HAVE_EVENTFD_SUPPORT
> >  	{"epoll",       "Epoll stressing benchmarks",                   epoll_benchmarks        },
> > -- 
> > 2.53.0
> > 

-- 
Cheers,
Changbin Du
