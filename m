Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D102644C4F2;
	Mon,  5 Oct 2026 23:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791244470; cv=none; b=RL+wK7xsiZYVB94uG1o3I1fBMmhje3/S1fiIXtOIRRgHl0pw1OZYVuI4fLHZY1V5lvQqC4AnNhb6R2b1fseqBLoxSbuTeo5Rnjb8fuyQ3KhJGGwp7TgkoqAZ86J5O6GPFjQWQ+t8Dl1Iu3AQ+7p+KDv3b9NR12VNJUPVeS2qMjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791244470; c=relaxed/simple;
	bh=f/dq71Y/L23/CH2gbK8KVx8NpMdLrGrkQHdmMQ5s3lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnwymTst+xrXMZgIjQ4ZE8SY5VeAvNfIAjk8Eh9ogd7fbGlvFxk/naoc2Wlyrim9Ct7Wh26nbxG63CFmgRwWDjgMvisxhWIb+u1I5bAzYdZk6+9Swj0ow8HDFt7OP5OlqfeY7Yi1gc3pvea6haw8P05c8vz8ZPMPA8UDZdCZ1LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQ5mrR8I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQ5mrR8I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB831F000FF;
	Mon,  5 Oct 2026 23:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791244468;
	bh=w2A1rXj+KtmqQHJwpAwHuS88Ibvi+PbU84wmLWTUskA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UQ5mrR8IL1+VKZg2zWYCZRy4XCAAwri2Ff33acFXiFJxPtV2jBtf5KfAJJcMaXrHp
	 JLWvQchEunIeuA6ltH5bQGYuMbXu6io4y7gwXuJ1hjq1OICAOaGkGXaR0//Q9SXMVA
	 FaD95XAmKH+QvgRjIKiDXnNtYuQlic+1iZXMrzSz79R4NL5aZsFPqag8TibbO/y+Ra
	 am/MLUiMdl0QjupXJHRAN02V8/mCm09qTKUjKcxh44SWXY3B0vZR++o0rRg502sSB7
	 I+HZs/irWFWQV94+nepwnt56wW7h2f2DFLWeweSSA4fHPGYcGr17oc773ikj4me6Oc
	 SNN7y32elUQFA==
Date: Mon, 5 Oct 2026 16:54:26 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Michal Pluta <michalpl2003@gmail.com>
Cc: acme@kernel.org, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/8] perf bench futex: Use the whole timeval for elapsed
 times
Message-ID: <asQ4sju-WXehW8oP@google.com>
References: <20260926190407.1106421-1-michalpl2003@gmail.com>
 <20260926190407.1106421-4-michalpl2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260926190407.1106421-4-michalpl2003@gmail.com>

On Sat, Sep 26, 2026 at 08:04:02PM +0100, Michal Pluta wrote:
> Several futex benchmarks read only one field of the struct timeval that
> timersub() produces, so part of the elapsed time is lost.
> 
> 'futex wake', 'futex wake-parallel' and 'futex requeue' print tv_usec,
> so a run that takes 1.5 s is shown as 500 ms. 'futex hash' and 'futex
> lock-pi' divide their operation count by tv_sec, which overstates the
> throughput when a run is stopped early, and gives 0 if that happens
> within the first second. Their "total secs" is truncated in the same
> way.
> 
> Use the whole timeval and print "total secs" with two decimals. With
> --runtime=0 the rate is now computed over the time that actually
> elapsed, instead of showing 0.

Can you please add an example output of one of the benchmarks in the
commit message?

Thanks,
Namhyung

> 
> Fixes: 27db78307481 ("perf bench: Add futex-wake microbenchmark")
> Fixes: 0fb298cf95c0 ("perf bench: Add futex-requeue microbenchmark")
> Fixes: a043971141f1 ("perf bench: Add futex-hash microbenchmark")
> Fixes: d2f3f5d2e9ca ("perf bench futex: Add lock_pi stresser")
> Fixes: d65817b4e707 ("perf bench futex: Support parallel waker threads")
> Assisted-by: LLM
> Signed-off-by: Michal Pluta <michalpl2003@gmail.com>
> ---
>  tools/perf/bench/futex-hash.c          | 12 ++++++++----
>  tools/perf/bench/futex-lock-pi.c       | 12 ++++++++----
>  tools/perf/bench/futex-requeue.c       |  8 +++++---
>  tools/perf/bench/futex-wake-parallel.c |  8 ++++++--
>  tools/perf/bench/futex-wake.c          |  6 ++++--
>  5 files changed, 31 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
> index 7e29f04da744..32b88df8ee6d 100644
> --- a/tools/perf/bench/futex-hash.c
> +++ b/tools/perf/bench/futex-hash.c
> @@ -18,6 +18,7 @@
>  #include <stdlib.h>
>  #include <linux/compiler.h>
>  #include <linux/kernel.h>
> +#include <linux/time64.h>
>  #include <linux/zalloc.h>
>  #include <sys/time.h>
>  #include <sys/mman.h>
> @@ -118,18 +119,19 @@ static void print_summary(void)
>  	unsigned long avg = avg_stats(&throughput_stats);
>  	double stddev = stddev_stats(&throughput_stats);
>  
> -	printf("%sAveraged %ld operations/sec (+- %.2f%%), total secs = %d\n",
> +	printf("%sAveraged %ld operations/sec (+- %.2f%%), total secs = %.2f\n",
>  	       !params.silent ? "\n" : "", avg, rel_stddev_stats(stddev, avg),
> -	       (int)bench__runtime.tv_sec);
> +	       bench__runtime.tv_sec + bench__runtime.tv_usec / (double)USEC_PER_SEC);
>  	futex_print_nbuckets(&params);
>  }
>  
>  int bench_futex_hash(int argc, const char **argv)
>  {
>  	int ret = 0;
>  	cpu_set_t *cpuset;
>  	struct sigaction act;
>  	unsigned int i;
> +	u64 runtime_us;
>  	pthread_attr_t thread_attr;
>  	struct worker *worker = NULL;
>  	struct perf_cpu_map *cpu;
> @@ -229,9 +231,11 @@ int bench_futex_hash(int argc, const char **argv)
>  	cond_destroy(&thread_worker);
>  	mutex_destroy(&thread_lock);
>  
> +	runtime_us = (u64)bench__runtime.tv_sec * USEC_PER_SEC + bench__runtime.tv_usec;
> +
>  	for (i = 0; i < params.nthreads; i++) {
> -		unsigned long t = bench__runtime.tv_sec > 0 ?
> -			worker[i].ops / bench__runtime.tv_sec : 0;
> +		unsigned long t = runtime_us ?
> +			(u64)worker[i].ops * USEC_PER_SEC / runtime_us : 0;
>  		update_stats(&throughput_stats, t);
>  		if (!params.silent) {
>  			if (params.nfutexes == 1)
> diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
> index 40640b674427..7190f5102e09 100644
> --- a/tools/perf/bench/futex-lock-pi.c
> +++ b/tools/perf/bench/futex-lock-pi.c
> @@ -13,6 +13,7 @@
>  #include <subcmd/parse-options.h>
>  #include <linux/compiler.h>
>  #include <linux/kernel.h>
> +#include <linux/time64.h>
>  #include <linux/zalloc.h>
>  #include <errno.h>
>  #include <perf/cpumap.h>
> @@ -66,9 +67,9 @@ static void print_summary(void)
>  	unsigned long avg = avg_stats(&throughput_stats);
>  	double stddev = stddev_stats(&throughput_stats);
>  
> -	printf("%sAveraged %ld operations/sec (+- %.2f%%), total secs = %d\n",
> +	printf("%sAveraged %ld operations/sec (+- %.2f%%), total secs = %.2f\n",
>  	       !params.silent ? "\n" : "", avg, rel_stddev_stats(stddev, avg),
> -	       (int)bench__runtime.tv_sec);
> +	       bench__runtime.tv_sec + bench__runtime.tv_usec / (double)USEC_PER_SEC);
>  	futex_print_nbuckets(&params);
>  }
>  
> @@ -168,6 +169,7 @@ int bench_futex_lock_pi(int argc, const char **argv)
>  {
>  	int ret = 0;
>  	unsigned int i;
> +	u64 runtime_us;
>  	struct sigaction act;
>  	struct perf_cpu_map *cpu;
>  
> @@ -233,9 +235,11 @@ int bench_futex_lock_pi(int argc, const char **argv)
>  	cond_destroy(&thread_worker);
>  	mutex_destroy(&thread_lock);
>  
> +	runtime_us = (u64)bench__runtime.tv_sec * USEC_PER_SEC + bench__runtime.tv_usec;
> +
>  	for (i = 0; i < params.nthreads; i++) {
> -		unsigned long t = bench__runtime.tv_sec > 0 ?
> -			worker[i].ops / bench__runtime.tv_sec : 0;
> +		unsigned long t = runtime_us ?
> +			(u64)worker[i].ops * USEC_PER_SEC / runtime_us : 0;
>  
>  		update_stats(&throughput_stats, t);
>  		if (!params.silent)
> diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
> index 0748b0fd689e..5d4708f40c60 100644
> --- a/tools/perf/bench/futex-requeue.c
> +++ b/tools/perf/bench/futex-requeue.c
> @@ -223,6 +223,7 @@ int bench_futex_requeue(int argc, const char **argv)
>  	for (j = 0; j < bench_repeat && !done; j++) {
>  		unsigned int nrequeued = 0, wakeups = 0;
>  		struct timeval start, end, runtime;
> +		u64 runtime_us;
>  
>  		/* create, launch & block all threads */
>  		block_threads(worker, cpu);
> @@ -267,23 +268,24 @@ int bench_futex_requeue(int argc, const char **argv)
>  
>  		gettimeofday(&end, NULL);
>  		timersub(&end, &start, &runtime);
> +		runtime_us = (u64)runtime.tv_sec * USEC_PER_SEC + runtime.tv_usec;
>  
>  		update_stats(&requeued_stats, nrequeued);
> -		update_stats(&requeuetime_stats, runtime.tv_usec);
> +		update_stats(&requeuetime_stats, runtime_us);
>  
>  		if (!params.silent) {
>  			if (!params.pi)
>  				printf("[Run %d]: Requeued %d of %d threads in "
>  				       "%.4f ms\n", j + 1, nrequeued,
>  				       params.nthreads,
> -				       runtime.tv_usec / (double)USEC_PER_MSEC);
> +				       runtime_us / (double)USEC_PER_MSEC);
>  			else {
>  				nrequeued -= wakeups;
>  				printf("[Run %d]: Awoke and Requeued (%d+%d) of "
>  				       "%d threads in %.4f ms\n",
>  				       j + 1, wakeups, nrequeued,
>  				       params.nthreads,
> -				       runtime.tv_usec / (double)USEC_PER_MSEC);
> +				       runtime_us / (double)USEC_PER_MSEC);
>  			}
>  
>  		}
> diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
> index a089d8ee4b02..fa70b7d4b473 100644
> --- a/tools/perf/bench/futex-wake-parallel.c
> +++ b/tools/perf/bench/futex-wake-parallel.c
> @@ -192,7 +192,9 @@ static void print_run(struct thread_data *waking_worker, unsigned int run_num)
>  	init_stats(&__waketime_stats);
>  
>  	for (i = 0; i < params.nwakes; i++) {
> -		update_stats(&__waketime_stats, waking_worker[i].runtime.tv_usec);
> +		update_stats(&__waketime_stats,
> +			     (u64)waking_worker[i].runtime.tv_sec * USEC_PER_SEC +
> +			     waking_worker[i].runtime.tv_usec);
>  		update_stats(&__wakeup_stats, waking_worker[i].nwoken);
>  	}
>  
> @@ -229,7 +231,9 @@ static void do_run_stats(struct thread_data *waking_worker)
>  	unsigned int i;
>  
>  	for (i = 0; i < params.nwakes; i++) {
> -		update_stats(&waketime_stats, waking_worker[i].runtime.tv_usec);
> +		update_stats(&waketime_stats,
> +			     (u64)waking_worker[i].runtime.tv_sec * USEC_PER_SEC +
> +			     waking_worker[i].runtime.tv_usec);
>  		update_stats(&wakeup_stats, waking_worker[i].nwoken);
>  	}
>  
> diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
> index 58427bb55c03..12a75be077a0 100644
> --- a/tools/perf/bench/futex-wake.c
> +++ b/tools/perf/bench/futex-wake.c
> @@ -191,6 +191,7 @@ int bench_futex_wake(int argc, const char **argv)
>  	for (j = 0; j < bench_repeat && !done; j++) {
>  		unsigned int nwoken = 0;
>  		struct timeval start, end, runtime;
> +		u64 runtime_us;
>  
>  		/* create, launch & block all threads */
>  		block_threads(worker, cpu);
> @@ -211,14 +212,15 @@ int bench_futex_wake(int argc, const char **argv)
>  					     params.nwakes, futex_flag);
>  		gettimeofday(&end, NULL);
>  		timersub(&end, &start, &runtime);
> +		runtime_us = (u64)runtime.tv_sec * USEC_PER_SEC + runtime.tv_usec;
>  
>  		update_stats(&wakeup_stats, nwoken);
> -		update_stats(&waketime_stats, runtime.tv_usec);
> +		update_stats(&waketime_stats, runtime_us);
>  
>  		if (!params.silent) {
>  			printf("[Run %d]: Wokeup %d of %d threads in %.4f ms\n",
>  			       j + 1, nwoken, params.nthreads,
> -			       runtime.tv_usec / (double)USEC_PER_MSEC);
> +			       runtime_us / (double)USEC_PER_MSEC);
>  		}
>  
>  		for (i = 0; i < params.nthreads; i++) {
> -- 
> 2.43.0
> 
