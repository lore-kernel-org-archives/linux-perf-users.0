Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE023DD873
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 02:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792031919; cv=none; b=TwoYo4yZzrVs48lpnJEyeykTSf6UX6ETwK2318ySahLu90BZc5UNFFvTybfgPMnM/6Jmgfo02b9KpOngK+gM276VikGxFmLhCREVTuG5v6cY4oar0oPXMlUntZAHoZ+vVo9nop1V4g6IaVSCAsxZ1o918pScTZU5OatNyzhdinw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792031919; c=relaxed/simple;
	bh=pySb2jiABzgDr1vxTY8i/AMiAl0D3YFu788ZEmjnvpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+dmCrKnOi2fDDrcbMEVPHr1Co2KKNfbTY3k2yQGcDCPP1Jdo4PHjiW9YXf20iGm3wmAbforJBI/uJXMVcjx50+K7qZK76GkmPW8nY1lML2Ae7Hfuz5j5K8U/j9UOKUJ9o13Ra0uasmEu6aaBoWu+LDz1pOVllgmTlaMqmcp2Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TINHuo2C; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TINHuo2C"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8875d220446so2476569b3a.3
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 19:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792031909; x=1792636709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VjToYZTxn2Bougr/b4/7DSjFqkkGdfdtJzQcTgHaBLY=;
        b=TINHuo2CvJy29eD7UtG+JKQotr3eT4k04CqniCvJ+BPHRlOtGVNH+FhjPp7nuTZVXb
         9MrVgfesrbEXDhMrwC+ZyJfSdXynhb7PuLLALWV21QIvIV9zHRGIsdfvt5Yy7Add8GQw
         ZeEqaGbhK6kSSWIKkR+01UrDq3SudlmckIl+qRRKbcOXrbxjeDp4RV42k/4Jn8uQOXL/
         wEgDx5Mt+qjZ2GwiEvHuKuhZ3YXN0rRwn4zL+ykv+Xs6pwj05rTOA+6G3ekZXtNP+G9y
         5kzJAAF9LZ/c1u6AY1SPN3nllqFKWwMlRPjmL6dmHA25em+RDwwlJ5XDomAAXTrhqDuu
         6TZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792031909; x=1792636709;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VjToYZTxn2Bougr/b4/7DSjFqkkGdfdtJzQcTgHaBLY=;
        b=yFgPGtkd1Z9Q8VfVKH0YUVtoM43Eb6/v03tY+484ZYPhMusuqqMiTn8+567z8nfGZf
         I9LhC65dFU5Qna24ySP/oQ2Ev/qiXLoBPg0WbRaO9BgCI6bLbKco6Fx1z2rTgngKI2wp
         fUJl+yoEKMJJkoOrldOUCcDzKWMlmQ6XnyoIHETRyaMCML9a0rkUz5r57qcXJ72QjX9V
         +vAZ2Fkhf+jxKiV6t705lXFcy0Jn7+5esr9TWPLvT6XVwNKnw65/S9NS/qH1J0Vxv0Ul
         XrLj1Kat5BLy5SUhTbwm4wc/ZKejhS+hWNwHEAJTcQLmo4wLR07rMff3D1ItAhAMGEGw
         cThw==
X-Forwarded-Encrypted: i=1; AKwUvBy6UkJEhxtlt7010p8H19Wfdt2YkriD7jhHsJKxtKrxYYfqr3/W0m+rTIU3pQazjYChacmFhVSb+B8Am2C9DVMB@vger.kernel.org
X-Gm-Message-State: AFq9FYIyfGVJbHPQ6unMjia4uOLwpv0RXA4ASfAnNzhwye7NuWnqCb8A
	8VhPC/LHN40AfSfkqua6uUSQZloKNwSCBQeTBeNVlGMDxGw8KvO0fC69
X-Gm-Gg: AYBFou1XxoK7mW+Hj1iEeFNVcGmv5Dky6gYIUeMTYAastTGX9aegUn1CO1INqaBN6Hf
	E7kQNYrIGPpWz35LIQQ8EgIgLFKsCiB7sedjAkzSZhaX8DBHc9sEXtl31VexkKxZ/4Fbw5QjwfP
	sDKV/7W3cp1gCouAo1YqkN8s8gtexOF6srSj3yzYuMpAi8/X9q2NCbYIkDh3kftxO715R/F8Hk2
	p/CGx4n2QtSRrjB1g7e48pd25/nhDIC38dmfCttHQ8z9KH4LW/lMSYgoF2yF2stwTYciutj0dX4
	b9aCb5r0TDWDYXlHvLJBZGhrQlaN3OgUJLGLupm2PswPcxQC3QShP6wMb6XZ6rQwNdCdOksnwj8
	rVcS4RO+pXddeEm1VcEixvOBtfX8SQA5NLO5oJvRdXLV9WI1zOywfESGUBQs7ofi10H44u6HgQB
	fOzPPYEawto5A1qZ0gwVNqauwwjmSYm1R4YBIvdCWz+pKHYGiGPfKZ3QDWJ/jZ+p+YSqzWO/Mcu
	Q==
X-Received: by 2002:a05:6a00:2986:b0:88d:3f61:20f3 with SMTP id d2e1a72fcca58-897c77da353mr14168411b3a.54.1792031908992;
        Wed, 14 Oct 2026 19:38:28 -0700 (PDT)
Received: from mail.google.com ([5.34.221.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d803d6410sm1724095b3a.33.2026.10.14.19.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 19:38:28 -0700 (PDT)
Date: Thu, 15 Oct 2026 10:38:17 +0800
From: Changbin Du <changbin.du@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Changbin Du <changbin.du@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH v4] perf bench: Add atomic operations benchmark
Message-ID: <atA7Mgrupnil4Jcv@mail.google.com>
References: <20261013085648.976819-1-changbin.du@gmail.com>
 <as_z4g6CZTObWm2H@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as_z4g6CZTObWm2H@google.com>

On Wed, Oct 14, 2026 at 02:28:02PM -0700, Namhyung Kim wrote:
> On Tue, Oct 13, 2026 at 04:56:48PM +0800, Changbin Du wrote:
[..]
> > +
> > +static const struct option options[] = {
> > +	OPT_UINTEGER('t', "threads", &threads,
> > +		     "Number of contending threads (default: 2, or 1 on single CPU)"),
> > +	OPT_UINTEGER('r', "runtime", &runtime,
> 
> Can you please pick a different short option than 'r'?  perf bench
> itself has -r/--repeat option so it would be confusing.  It doesn't
> clash for now, but I think it's better to use perf bench options from
> 'perf bench atomic ...' later.
> 

Agreed -- I'll drop the short options; --threads and --runtime
stay long-only so no bench option (e.g. -r/--repeat) is shadowed
at perf bench atomic .... Will send an updated patch.

> Otherwise, looks good to me.
> 
> Thanks,
> Namhyung
> 
> 
> > +		     "Runtime of each repeat in seconds (default: 2)"),
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
> > +/*
> > + * The termination flag is polled between batches only, so that the
> > + * check does not perturb the measured loop.
> > + */
> > +#define BATCH_OPS	1024
> > +
> > +static unsigned long shared_counter __aligned(64);
> > +static pthread_barrier_t start_barrier __aligned(64);
> > +static bool done;
> > +
> > +struct worker_stats {
> > +	u64	runtime_ns;
> > +	u64	ops;
> > +};
> > +
> > +static void cas_batch(void)
> > +{
> > +	unsigned long i;
> > +
> > +	for (i = 0; i < BATCH_OPS; i++) {
> > +		unsigned long old_val, new_val;
> > +
> > +		old_val = __atomic_load_n(&shared_counter, __ATOMIC_RELAXED);
> > +		do {
> > +			new_val = old_val + 1;
> > +		} while (!__atomic_compare_exchange_n(&shared_counter, &old_val,
> > +						      new_val, false,
> > +						      __ATOMIC_RELAXED,
> > +						      __ATOMIC_RELAXED));
> > +	}
> > +}
> > +
> > +static void inc_batch(void)
> > +{
> > +	unsigned long i;
> > +
> > +	for (i = 0; i < BATCH_OPS; i++)
> > +		__atomic_fetch_add(&shared_counter, 1, __ATOMIC_RELAXED);
> > +}
> > +
> > +static void *worker(void *arg)
> > +{
> > +	struct worker_stats *ws = (struct worker_stats *)arg;
> > +	struct timespec tstart, tend;
> > +	u64 ops = 0;
> > +
> > +	pthread_barrier_wait(&start_barrier);
> > +
> > +	clock_gettime(CLOCK_MONOTONIC, &tstart);
> > +	while (!__atomic_load_n(&done, __ATOMIC_RELAXED)) {
> > +		switch (bench_op) {
> > +		case OP_CAS:
> > +			cas_batch();
> > +			break;
> > +		case OP_INC:
> > +			inc_batch();
> > +			break;
> > +		default:
> > +			BUG_ON(1);
> > +			break;
> > +		}
> > +		ops += BATCH_OPS;
> > +	}
> > +	clock_gettime(CLOCK_MONOTONIC, &tend);
> > +
> > +	ws->runtime_ns	= (u64)(tend.tv_sec - tstart.tv_sec) * NSEC_PER_SEC +
> > +			  (tend.tv_nsec - tstart.tv_nsec);
> > +	ws->ops		= ops;
> > +
> > +	return NULL;
> > +}
> > +
> > +static void print_default_format(struct worker_stats *wstats,
> > +				 struct stats *throughput_stats)
> > +{
> > +	double thru_avg, thru_stddev;
> > +
> > +	printf("  Threads: %u, runtime: %u sec, repeats: %u (warmup: 1)\n",
> > +	       threads, runtime, bench_repeat);
> > +
> > +	thru_avg    = avg_stats(throughput_stats);
> > +	thru_stddev = stddev_stats(throughput_stats);
> > +
> > +	printf("  Avg throughput: %'.0f ops/sec (+- %.2f%%)\n",
> > +	       thru_avg, rel_stddev_stats(thru_stddev, thru_avg));
> > +
> > +	/*
> > +	 * Per-thread operation counts from the last measured repeat show
> > +	 * whether any thread failed to make progress under contention.
> > +	 */
> > +	if (threads > 1) {
> > +		u64 min_ops = UINT64_MAX, max_ops = 0, total_ops = 0;
> > +
> > +		for (unsigned int t = 0; t < threads; t++) {
> > +			if (wstats[t].ops < min_ops)
> > +				min_ops = wstats[t].ops;
> > +			if (wstats[t].ops > max_ops)
> > +				max_ops = wstats[t].ops;
> > +			total_ops += wstats[t].ops;
> > +		}
> > +
> > +		printf("  Per-thread ops (last repeat):\n");
> > +		printf("    fastest:  %'" PRIu64 " ops\n", max_ops);
> > +		printf("    slowest:  %'" PRIu64 " ops\n", min_ops);
> > +		printf("    avg:      %'" PRIu64 " ops\n", total_ops / threads);
> > +	}
> > +}
> > +
> > +static int run_benchmark(void)
> > +{
> > +	pthread_t *thread_ids;
> > +	struct worker_stats *wstats;
> > +	struct stats throughput_stats;
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
> > +	init_stats(&throughput_stats);
> > +
> > +	for (r = 0; r < bench_repeat + 1; r++) {
> > +		u64 max_runtime_ns = 0, total_ops = 0;
> > +		double throughput;
> > +
> > +		shared_counter = 0;
> > +		__atomic_store_n(&done, false, __ATOMIC_RELAXED);
> > +		pthread_barrier_init(&start_barrier, NULL, threads);
> > +
> > +		for (t = 0; t < threads; t++) {
> > +			if (pthread_create(&thread_ids[t], NULL,
> > +					   worker, &wstats[t]))
> > +				err(EXIT_FAILURE, "pthread_create");
> > +		}
> > +
> > +		sleep(runtime);
> > +		__atomic_store_n(&done, true, __ATOMIC_RELAXED);
> > +
> > +		for (t = 0; t < threads; t++)
> > +			pthread_join(thread_ids[t], NULL);
> > +
> > +		pthread_barrier_destroy(&start_barrier);
> > +
> > +		for (t = 0; t < threads; t++) {
> > +			total_ops += wstats[t].ops;
> > +			if (wstats[t].runtime_ns > max_runtime_ns)
> > +				max_runtime_ns = wstats[t].runtime_ns;
> > +		}
> > +
> > +		/*
> > +		 * Exclude the first repeat (warmup) from statistics so
> > +		 * that cache-cold and lazy-init effects are not counted.
> > +		 */
> > +		if (r > 0 && max_runtime_ns) {
> > +			throughput = (double)total_ops /
> > +				     ((double)max_runtime_ns / NSEC_PER_SEC);
> > +			update_stats(&throughput_stats, (u64)throughput);
> > +		}
> > +	}
> > +
> > +	switch (bench_format) {
> > +	case BENCH_FORMAT_DEFAULT:
> > +		print_default_format(wstats, &throughput_stats);
> > +		break;
> > +
> > +	case BENCH_FORMAT_SIMPLE:
> > +		printf("%.0f\n", avg_stats(&throughput_stats));
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
> > +	struct perf_cpu_map *cpu;
> > +
> > +	if (parse_options(argc, argv, options, usage, 0)) {
> > +		usage_with_options(usage, options);
> > +		exit(EXIT_FAILURE);
> > +	}
> > +
> > +	if (!threads) {	/* default to 2 threads (1 on a single-CPU machine) */
> > +		cpu = perf_cpu_map__new_online_cpus();
> > +		threads = (cpu && perf_cpu_map__nr(cpu) > 1) ? 2 : 1;
> > +		perf_cpu_map__put(cpu);
> > +	}
> > +
> > +	if (runtime < 1) {
> > +		fprintf(stderr, "Invalid runtime: %u\n", runtime);
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
