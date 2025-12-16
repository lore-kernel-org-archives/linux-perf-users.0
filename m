Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532F7315D3B;
	Tue, 16 Dec 2025 06:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765866189; cv=none; b=deAW07IkYg1gZvLvtB+mGMxRShcyj7Sp4JPsKAkQMf48h5aPGBNLWvxpkVBOT9S9U3E8uDQ8ISU8wTEPak3Yj0P0a+jt2ieTnIXltHU5BcEYENkZ0bGEp2mrcYoYxeAd/d4IPOFpYutukZP8n77G+HhUeXFWwuawIxD70gEP+cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765866189; c=relaxed/simple;
	bh=oJsHdVX4lcJ9KkJcLtmQuVzpM76327rCz7UiRhPoHT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzvkQGqAW7kOmIpEq1kEjMoidboYfCY65RZ3B5vGZcoYjvZiRLU9KhVNUjcYO/GwCxUHeGMIXVFajIszPZvPDw48JncZk64AqfFTOCg4tY9eYDykt9pD0nfNtRj3HBGMXX7mB5RQAZOohqVO6z+GbAavNLh/eKl5Nf3/zvuz1Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3AcD0WX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3AcD0WX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A7BC4CEF1;
	Tue, 16 Dec 2025 06:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765866186;
	bh=oJsHdVX4lcJ9KkJcLtmQuVzpM76327rCz7UiRhPoHT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c3AcD0WXV6h6kAYL3/PC9/RLKJBla4qwgnADEgXFmwWdFf7Kn1vb5ajYfP22Up1wk
	 24tICJT/JUZwDVGPOHaJgJOKpT6+a0VYhCpFiMiRaHSSsew72MD0VK6LgDGvkhTKbO
	 f/elEboLobvK99kRGtoGplWwzh6EK86rojeDYp1M6I+1+Q5Msq6Q5GRp+mmVOmv0v1
	 lwPvZ8nMovEp0M0o88GaH8nNpIHVDkItGVrUurn+E136aBy3s8fsyAkpByXsTYBUr5
	 J3K4CAsINhLdtdOdYRfowvC5sNmL8TThuDYK/4+3DkDqaGr8avLFnYv16twJodYUOs
	 chYBrXTpx9D9Q==
Date: Mon, 15 Dec 2025 22:23:04 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ankur Arora <ankur.a.arora@oracle.com>
Subject: Re: [PATCH] perf bench: Add -t/--threads option to perf bench mem
 mmap
Message-ID: <aUD6yGZ2bSHsCb2e@google.com>
References: <20251207085741.1388141-1-namhyung@kernel.org>
 <3c27128a-5cca-4c2f-a3f8-47b9a375bc7a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c27128a-5cca-4c2f-a3f8-47b9a375bc7a@linaro.org>

Hi James,

On Tue, Dec 09, 2025 at 01:01:25PM +0000, James Clark wrote:
> 
> 
> On 07/12/2025 8:57 am, Namhyung Kim wrote:
> > So that it can measure overhead of mmap_lock and/or per-VMA lock
> > contention.
> > 
> >    $ perf bench mem mmap -f demand -l 1000 -t 1
> >    # Running 'mem/mmap' benchmark:
> >    # function 'demand' (Demand loaded mmap())
> >    # Copying 1MB bytes ...
> > 
> >           2.914503 GB/sec
> > 
> >    $ perf bench mem mmap -f demand -l 1000 -t 2
> >    # Running 'mem/mmap' benchmark:
> >    # function 'demand' (Demand loaded mmap())
> >    # Copying 1MB bytes ...
> > 
> >         888.769991 MB/sec
> > 
> >    $ perf bench mem mmap -f demand -l 1000 -t 3
> >    # Running 'mem/mmap' benchmark:
> >    # function 'demand' (Demand loaded mmap())
> >    # Copying 1MB bytes ...
> > 
> >         757.658220 MB/sec
> > 
> >    $ perf bench mem mmap -f demand -l 1000 -t 4
> >    # Running 'mem/mmap' benchmark:
> >    # function 'demand' (Demand loaded mmap())
> >    # Copying 1MB bytes ...
> > 
> >         316.410713 MB/sec
> 
> Should this now say "MB/sec per thread" for nr_threads > 1? I think it could
> be interpreted either way without a label, but I see you divided by
> nr_threads in timeval2double().

Right, thanks for the review.  I think we can add it unconditionally.

Thanks,
Namhyung

> 
> > 
> > Cc: Ankur Arora <ankur.a.arora@oracle.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >   tools/perf/Documentation/perf-bench.txt |  4 ++
> >   tools/perf/bench/mem-functions.c        | 74 +++++++++++++++++++++----
> >   2 files changed, 67 insertions(+), 11 deletions(-)
> > 
> > diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
> > index 1160224cb718392d..c5913cf59c988421 100644
> > --- a/tools/perf/Documentation/perf-bench.txt
> > +++ b/tools/perf/Documentation/perf-bench.txt
> > @@ -274,6 +274,10 @@ Repeat mmap() invocation this number of times.
> >   --cycles::
> >   Use perf's cpu-cycles event instead of gettimeofday syscall.
> > +-t::
> > +--threads=<NUM>::
> > +Create multiple threads to call mmap/munmap concurrently.
> > +
> >   SUITES FOR 'numa'
> >   ~~~~~~~~~~~~~~~~~
> >   *mem*::
> > diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
> > index 2908a3a796c932d0..e7e7d0b41fc7720f 100644
> > --- a/tools/perf/bench/mem-functions.c
> > +++ b/tools/perf/bench/mem-functions.c
> > @@ -26,6 +26,7 @@
> >   #include <errno.h>
> >   #include <linux/time64.h>
> >   #include <linux/log2.h>
> > +#include <pthread.h>
> >   #define K 1024
> > @@ -41,6 +42,7 @@ static unsigned int	nr_loops	= 1;
> >   static bool		use_cycles;
> >   static int		cycles_fd;
> >   static unsigned int	seed;
> > +static unsigned int	nr_threads	= 1;
> >   static const struct option bench_common_options[] = {
> >   	OPT_STRING('s', "size", &size_str, "1MB",
> > @@ -174,7 +176,7 @@ static void clock_accum(union bench_clock *a, union bench_clock *b)
> >   static double timeval2double(struct timeval *ts)
> >   {
> > -	return (double)ts->tv_sec + (double)ts->tv_usec / (double)USEC_PER_SEC;
> > +	return (double)ts->tv_sec + (double)ts->tv_usec / (double)USEC_PER_SEC / nr_threads;
> >   }
> >   #define print_bps(x) do {						\
> > @@ -494,16 +496,27 @@ static void mmap_page_touch(void *dst, size_t size, unsigned int page_shift, boo
> >   	}
> >   }
> > -static int do_mmap(const struct function *r, struct bench_params *p,
> > -		  void *src __maybe_unused, void *dst __maybe_unused,
> > -		  union bench_clock *accum)
> > +struct mmap_data {
> > +	pthread_t id;
> > +	const struct function *func;
> > +	struct bench_params *params;
> > +	union bench_clock result;
> > +	unsigned int seed;
> > +	int error;
> > +};
> > +
> > +static void *do_mmap_thread(void *arg)
> >   {
> > +	struct mmap_data *data = arg;
> > +	const struct function *r = data->func;
> > +	struct bench_params *p = data->params;
> >   	union bench_clock start, end, diff;
> >   	mmap_op_t fn = r->fn.mmap_op;
> >   	bool populate = strcmp(r->name, "populate") == 0;
> > +	void *dst;
> > -	if (p->seed)
> > -		srand(p->seed);
> > +	if (data->seed)
> > +		srand(data->seed);
> >   	for (unsigned int i = 0; i < p->nr_loops; i++) {
> >   		clock_get(&start);
> > @@ -514,16 +527,53 @@ static int do_mmap(const struct function *r, struct bench_params *p,
> >   		fn(dst, p->size, p->page_shift, p->seed);
> >   		clock_get(&end);
> >   		diff = clock_diff(&start, &end);
> > -		clock_accum(accum, &diff);
> > +		clock_accum(&data->result, &diff);
> >   		bench_munmap(dst, p->size);
> >   	}
> > -	return 0;
> > +	return data;
> >   out:
> > -	printf("# Memory allocation failed - maybe size (%s) %s?\n", size_str,
> > -			p->page_shift != PAGE_SHIFT_4KB ? "has insufficient hugepages" : "is too large");
> > -	return -1;
> > +	data->error = -ENOMEM;
> > +	return NULL;
> > +}
> > +
> > +static int do_mmap(const struct function *r, struct bench_params *p,
> > +		  void *src __maybe_unused, void *dst __maybe_unused,
> > +		  union bench_clock *accum)
> > +{
> > +	struct mmap_data *data;
> > +	int error = 0;
> > +
> > +	data = calloc(nr_threads, sizeof(*data));
> > +	if (!data) {
> > +		printf("# Failed to allocate thread resources\n");
> > +		return -1;
> > +	}
> > +
> > +	for (unsigned int i = 0; i < nr_threads; i++) {
> > +		data[i].func = r;
> > +		data[i].params = p;
> > +		if (p->seed)
> > +			data[i].seed = p->seed + i;
> > +
> > +		if (pthread_create(&data[i].id, NULL, do_mmap_thread, &data[i]) < 0)
> > +			data[i].error = -errno;
> > +	}
> > +
> > +	for (unsigned int i = 0; i < nr_threads; i++) {
> > +		pthread_join(data[i].id, NULL);
> > +
> > +		clock_accum(accum, &data[i].result);
> > +		error |= data[i].error;
> > +	}
> > +	free(data);
> > +
> > +	if (error) {
> > +		printf("# Memory allocation failed - maybe size (%s) %s?\n", size_str,
> > +		       p->page_shift != PAGE_SHIFT_4KB ? "has insufficient hugepages" : "is too large");
> > +	}
> > +	return error ? -1 : 0;
> >   }
> >   static const char * const bench_mem_mmap_usage[] = {
> > @@ -548,6 +598,8 @@ int bench_mem_mmap(int argc, const char **argv)
> >   	static const struct option bench_mmap_options[] = {
> >   		OPT_UINTEGER('r', "randomize", &seed,
> >   			    "Seed to randomize page access offset."),
> > +		OPT_UINTEGER('t', "threads", &nr_threads,
> > +			    "Number of threads to run concurrently (default: 1)."),
> >   		OPT_PARENT(bench_common_options),
> >   		OPT_END()
> >   	};
> 
