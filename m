Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237AF244691;
	Tue, 28 Oct 2025 19:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761678813; cv=none; b=gYBfHa6NQZtktQxdUhNU2k8jT4PHMpw0Nx7/NRd8JH05IU0LZx+Jc628ZgYsNsJo/Vxf8+DekdAUgoqEKUNuubQtmSB4YM/MCHfuMxpsMliAK7N8jyB0DLVUvsI+XkKxEX0EBHCL94JCkvNtEl7RL2/GZw/vS1QedTeMgb//m+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761678813; c=relaxed/simple;
	bh=sZIrF5BC7ksSsWzA+ZVd/ZRBeM5EUfucbSmCQoGjJpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/OvFuggHrWl2dGVrz+lDr6enR96g39K+Gx0q513fgZUKd3/suGPYUKd15v/ppiEWCjphy9bC8woKMqJ6cX0WktI3uIpQFsBAPAkctaKLV85+alBuBGhgiHtrU2NLTUK3/8svwgHwKw6A7+i+wA0zYkmiIa+iQZ7YszXRIro1lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMknY+ux; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMknY+ux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAF7C4CEE7;
	Tue, 28 Oct 2025 19:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761678812;
	bh=sZIrF5BC7ksSsWzA+ZVd/ZRBeM5EUfucbSmCQoGjJpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SMknY+uxdXCS6M7DgL/O8lllk3C/4IEmUM8+wtrkh8yDZRnvBgA5+lEPjJoa+desw
	 wrFvea+RngTjoT6geDFzTy0NU4pY+71t8BbdVJtYhSxobiRrvOq3hkLl05w6Otv0sc
	 BrsnPlnPl2EleChu+WQgWMsxdUMtQtApCnS57Om0n63jE9/3CBeVku37dZTpN4+HO1
	 LVco4JKMqGTqI40P8ADCW9Be3jHI62aD8nU6mgLmw8XHB7Cu90HtA6Y7ndt4FkapK8
	 V6ek33aUqOrAeYqSMXkkJ7FYUq+4hWc/NXEATIFBq9eI5ZyN8J8GAR5UVrVQqfqPZ3
	 N/JOk4DgiESZQ==
Date: Tue, 28 Oct 2025 16:13:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf test workload: Add thread count argument to
 thloop
Message-ID: <aQEV2ABm7JaGH3UO@x1>
References: <20251028153821.4003666-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028153821.4003666-1-irogers@google.com>

On Tue, Oct 28, 2025 at 08:38:20AM -0700, Ian Rogers wrote:
> Allow the number of threads for the thloop workload to be increased
> beyond the normal 2. Add error checking to the parsed time and thread
> count values.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v2: Perform the pthread_join unconditionally and ensure started
>     threads terminate.
> ---
>  tools/perf/tests/workloads/thloop.c | 45 ++++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/workloads/thloop.c
> index 457b29f91c3e..bd8168f883fb 100644
> --- a/tools/perf/tests/workloads/thloop.c
> +++ b/tools/perf/tests/workloads/thloop.c
> @@ -31,21 +31,52 @@ static void *thfunc(void *arg)
>  
>  static int thloop(int argc, const char **argv)
>  {
> -	int sec = 1;
> -	pthread_t th;
> +	int nt = 2, sec = 1, err = 1;
> +	pthread_t *thread_list = NULL;
>  
>  	if (argc > 0)
>  		sec = atoi(argv[0]);
>  
> +	if (sec <= 0) {
> +		fprintf(stderr, "Error: seconds (%d) must be >= 1\n", sec);
> +		return 1;
> +	}
> +
> +	if (argc > 1)
> +		nt = atoi(argv[1]);
> +
> +	if (nt <= 0) {
> +		fprintf(stderr, "Error: thread count (%d) must be >= 1\n", nt);
> +		return 1;
> +	}
> +
>  	signal(SIGINT, sighandler);
>  	signal(SIGALRM, sighandler);
> -	alarm(sec);
>  
> -	pthread_create(&th, NULL, thfunc, test_loop);
> -	test_loop();
> -	pthread_join(th, NULL);
> +	thread_list = calloc(nt, sizeof(pthread_t));
> +	if (thread_list == NULL) {
> +		fprintf(stderr, "Error: malloc failed for %d threads\n", nt);
> +		goto out;
> +	}
> +	for (int i = 1; i < nt; i++) {

Why do you start at 1? What goes in thread[0]? calloc() leaves it at
NULL, then if you have two threads you'll allocate thread[1], i gets
incremented, 2 < 2 fails, you get just one thread created, when two were
asked?

Oh, I see, you use the main thread to run, that test_loop() just before
the err = 0, its just that you allocate thread[0] for nothing, that
confused me.

- Arnaldo

> +		int ret = pthread_create(&thread_list[i], NULL, thfunc, test_loop);
>  
> -	return 0;
> +		if (ret) {
> +			fprintf(stderr, "Error: failed to create thread %d\n", i);
> +			done = 1; // Ensure started threads terminate.
> +			goto out;
> +		}
> +	}
> +	alarm(sec);
> +	test_loop();
> +	err = 0;
> +out:
> +	for (int i = 1; i < nt; i++) {
> +		if (thread_list && thread_list[i])
> +			pthread_join(thread_list[i], /*retval=*/NULL);
> +	}
> +	free(thread_list);
> +	return err;
>  }
>  
>  DEFINE_WORKLOAD(thloop);
> -- 
> 2.51.1.851.g4ebd6896fd-goog
