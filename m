Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE18F23E25B;
	Thu, 31 Jul 2025 05:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753939496; cv=none; b=G8E4ePxYT7HuLVHYQjQ0emI9+6/SAILPMb5RknYfLTj0JihXhgjnFs/lPwxsGXoUvmda81YYOK/cU6vJRe/QvhGCYhlfbTz9mrG9MahiBwhAxmrDrYpQy430Fq6vEZB8Oq5Whj3Qfn2Kays5naLvnjl8jD4Suhg0VhP/jfHYt4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753939496; c=relaxed/simple;
	bh=24xQHVXxaEOP8OPxbxy+S6R7yjfRe6FGh+DmKLcXi20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMmO6WOB54i04RGDGESiB4w+WIw5HRC9X10lISmqUKref8WIECFaANudmUO5qNhbVB8UQrEA1FWyKc6PhnE5jV6KJ2TPKqTiRPKNfIukxSmAxbt1lpOkLHNdNfga33VJqJnpCx1yud6gqKOj4MHhQgiPADRZoJ19FLZTt4YXVOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OR8+3iTR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OR8+3iTR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC96C4CEEF;
	Thu, 31 Jul 2025 05:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753939495;
	bh=24xQHVXxaEOP8OPxbxy+S6R7yjfRe6FGh+DmKLcXi20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OR8+3iTRv7197eVy8kUgC3HDWgvyWMKkEgpCmNmUGLWPWUySJqgxgcGXPggxXEqav
	 FRm9M04ku6kE1FTE1+N4RdVQk40NW8UqIIhcvzSXHo0izD3VCAyC7mD2RZtOuIWGus
	 ud8J6AIIsk7u4KiCjU5uT1TqtkjqrZnpOnby7g5soyF4tyYnbpXibLVXA/tBO9MWdx
	 I1imLzyl35nPzXBQtBIHO2KU02jgLE0M0VIcnWr6VVokaacnW80BNyloqS01YeI1c4
	 vpea1Fj2g61ZsW7ZRXI4QFyeBYY8y4JIQXMUkV6oG7eJgDKO42hkFvx+XGRE2uhNd8
	 Y/EtbncYC/mtA==
Date: Wed, 30 Jul 2025 22:24:53 -0700
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
Subject: Re: [PATCH v1 7/7] perf bench sync: Add latency histogram
 functionality
Message-ID: <aIr-JTyuJBKPJN8c@google.com>
References: <20250729022640.3134066-1-yuzhuo@google.com>
 <20250729022640.3134066-8-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250729022640.3134066-8-yuzhuo@google.com>

On Mon, Jul 28, 2025 at 07:26:40PM -0700, Yuzhuo Jing wrote:
> Add an option to print the histogram of lock acquire latencies (unit in
> TSCs).
> 
> Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
> ---
>  tools/perf/bench/sync.c | 97 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 96 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/bench/sync.c b/tools/perf/bench/sync.c
> index 2685cb66584c..c85e9853c72a 100644
> --- a/tools/perf/bench/sync.c
> +++ b/tools/perf/bench/sync.c
> @@ -15,14 +15,19 @@
>  #include <sys/cdefs.h>
>  
>  #include "bench.h"
> +#include "../util/tsc.h"
>  
>  #include "include/qspinlock.h"
>  
>  #define NS 1000000000ull
>  #define CACHELINE_SIZE 64
>  
> +#define DEFAULT_HIST_INTERVAL 1000
> +
>  static unsigned int nthreads;
>  static unsigned long nspins = 10000ul;
> +static bool do_hist;
> +static u64 hist_interval = DEFAULT_HIST_INTERVAL;
>  
>  struct barrier_t;
>  
> @@ -45,6 +50,7 @@ struct worker {
>  	struct lock_ops *ops;
>  	struct barrier_t *barrier;
>  	u64 runtime;		// in nanoseconds
> +	u64 *lock_latency;	// in TSCs

Why TSC?  Is it for x86 only?

Thanks,
Namhyung

>  };
>  
>  static const struct option options[] = {
> @@ -52,6 +58,10 @@ static const struct option options[] = {
>  		"Specify number of threads (default: number of CPUs)."),
>  	OPT_ULONG('n',		"spins",	&nspins,
>  		"Number of lock acquire operations per thread (default: 10,000 times)."),
> +	OPT_BOOLEAN(0,		"hist",		&do_hist,
> +		"Print a histogram of lock acquire TSCs."),
> +	OPT_U64(0,	"hist-interval",	&hist_interval,
> +		"Histogram bucket size (default 1,000 TSCs)."),
>  	OPT_END()
>  };
>  
> @@ -109,6 +119,25 @@ static void lock_loop(const struct lock_ops *ops, unsigned long n)
>  	}
>  }
>  
> +/*
> + * A busy loop to acquire and release the given lock N times, and also collect
> + * all acquire latencies, for histogram use.  Note that the TSC operations
> + * latency itself is also included.
> + */
> +static void lock_loop_timing(const struct lock_ops *ops, unsigned long n, u64 *sample_buffer)
> +{
> +	unsigned long i;
> +	u64 t1, t2;
> +
> +	for (i = 0; i < n; ++i) {
> +		t1 = rdtsc();
> +		ops->lock(ops->data);
> +		t2 = rdtsc();
> +		ops->unlock(ops->data);
> +		sample_buffer[i] = t2 - t1;
> +	}
> +}
> +
>  /*
>   * Thread worker function.  Runs lock loop for N/5 times before and after
>   * the main timed loop.
> @@ -127,7 +156,10 @@ static void *sync_workerfn(void *args)
>  	lock_loop(worker->ops, nspins / 5);
>  
>  	clock_gettime(CLOCK_THREAD_CPUTIME_ID, &starttime);
> -	lock_loop(worker->ops, nspins);
> +	if (worker->lock_latency)
> +		lock_loop_timing(worker->ops, nspins, worker->lock_latency);
> +	else
> +		lock_loop(worker->ops, nspins);
>  	clock_gettime(CLOCK_THREAD_CPUTIME_ID, &endtime);
>  
>  	/* Tail loop (not counted) to keep the above loop contended. */
> @@ -139,6 +171,57 @@ static void *sync_workerfn(void *args)
>  	return NULL;
>  }
>  
> +/*
> + * Calculate and print a histogram.
> + */
> +static void print_histogram(struct worker *workers)
> +{
> +	u64 tsc_max = 0;
> +	u64 *buckets;
> +	unsigned long nbuckets;
> +
> +	if (hist_interval == 0)
> +		hist_interval = DEFAULT_HIST_INTERVAL;
> +
> +	printf("Lock acquire histogram:\n");
> +
> +	/* Calculate the max TSC value to get the number of buckets needed. */
> +	for (unsigned int i = 0; i < nthreads; ++i) {
> +		struct worker *w = workers + i;
> +
> +		for (unsigned long j = 0; j < nspins; ++j)
> +			tsc_max = max(w->lock_latency[j], tsc_max);
> +	}
> +	nbuckets = (tsc_max + hist_interval - 1) / hist_interval;
> +
> +	/* Allocate the actual bucket.  The bucket definition may be optimized
> +	 * if it is sparse.
> +	 */
> +	buckets = calloc(nbuckets, sizeof(*buckets));
> +	if (!buckets)
> +		err(EXIT_FAILURE, "calloc");
> +
> +	/* Iterate through all latencies again to fill the buckets. */
> +	for (unsigned int i = 0; i < nthreads; ++i) {
> +		struct worker *w = workers + i;
> +
> +		for (unsigned long j = 0; j < nspins; ++j) {
> +			u64 latency = w->lock_latency[j];
> +			++buckets[latency / hist_interval];
> +		}
> +	}
> +
> +	/* Print the histogram as a table. */
> +	printf("Bucket, Count\n");
> +	for (unsigned long i = 0; i < nbuckets; ++i) {
> +		if (buckets[i] == 0)
> +			continue;
> +		printf("%"PRIu64", %"PRIu64"\n", hist_interval * (i + 1), buckets[i]);
> +	}
> +
> +	free(buckets);
> +}
> +
>  /*
>   * Generic lock synchronization benchmark function.  Sets up threads and
>   * thread affinities.
> @@ -191,6 +274,12 @@ static int bench_sync_lock_generic(struct lock_ops *ops, int argc, const char **
>  		workers[i].barrier = &barrier;
>  		workers[i].ops = ops;
>  
> +		if (do_hist) {
> +			workers[i].lock_latency = calloc(nspins, sizeof(*workers[i].lock_latency));
> +			if (!workers[i].lock_latency)
> +				err(EXIT_FAILURE, "calloc");
> +		}
> +
>  		/* Set CPU affinity */
>  		pthread_attr_init(&thread_attr);
>  		CPU_ZERO_S(cpuset_size, cpuset);
> @@ -228,6 +317,12 @@ static int bench_sync_lock_generic(struct lock_ops *ops, int argc, const char **
>  	printf("Lock-unlock latency of %u threads: %"PRIu64".%"PRIu64" ns.\n",
>  			nthreads, avg_ns, avg_ns_dot);
>  
> +	/* Print histogram if requested. */
> +	if (do_hist)
> +		print_histogram(workers);
> +
> +	for (unsigned int i = 0; i < nthreads; ++i)
> +		free(workers[i].lock_latency);
>  	free(workers);
>  
>  	return 0;
> -- 
> 2.50.1.487.gc89ff58d15-goog
> 
