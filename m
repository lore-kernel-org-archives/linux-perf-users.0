Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD6D33769A;
	Tue, 28 Oct 2025 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664094; cv=none; b=PfRzhfbmw0bUhX7Y3gg8nKfF7ebweEYMBKUtz2y2j6cCvLhgIDM/y+sSJqa+WKaB51iFOlhuc074vIur0IJDLJFnNLrL52V2+rB0NKA6xsH0t6JmWHrZSp38EbdzzpedInsoSF2RPj/2nr+E+IoCry/jXR3UAO5VGwpiaEq+sv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664094; c=relaxed/simple;
	bh=KSeLWfOIJIJ6rjAdH73CFG870S9I/ysFcDzt7Qd2DxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3uf+kdTB7jYLfGqYtto/vXS0pFLSDUW62W2SN1s6U1C8NPsFSgtX/N8t90RfZWaxq6HND+zELCfCr6sRGZyCGIDi2KyvSDpi4S6FxwolYKhABC01izc5/cuR+H7d6R5jOmq3vQaKPOkH7cF0KpM0QD4skXILjpAs5eT2wbBUog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqLWwI2/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqLWwI2/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61581C4CEF7;
	Tue, 28 Oct 2025 15:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761664094;
	bh=KSeLWfOIJIJ6rjAdH73CFG870S9I/ysFcDzt7Qd2DxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XqLWwI2/h+Ljug5dZGeHNoWKdWTbeNHzWL5YYQ7LzO0HXm4R+UouDP/fUtz4o2RA2
	 oUaKkkvDNCEwNU3AIqPW8m3j/viG73HaLCMytWKUvvimwT5JGT3EPXulHkYKB01G8Y
	 T1Jqmm1XDqTTjkWssVHU7RiWyqJ8qSHI5tlyZEQJ9Qz+GicrbTYV0zb4DoV4dlJj0E
	 w0B7QFNGGxjUgDXF8907s8bqpxXk7SCt6tjRqvTgExCRESzZ7hU2IrND2S7UNkTXsL
	 dN6Vcq8pW2rBw4Jf83VxyIgm7n6zETA/G+xhHA7FfQJkP+DLP2oWs9nCuisT8vM+HI
	 aXaIWlp7GvO0g==
Date: Tue, 28 Oct 2025 12:08:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf test workload: Add thread count argument to
 thloop
Message-ID: <aQDcWtHI9LSBAWw9@x1>
References: <20251027201405.3715599-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027201405.3715599-1-irogers@google.com>

On Mon, Oct 27, 2025 at 01:14:05PM -0700, Ian Rogers wrote:
> Allow the number of threads for the thloop workload to be increased
> beyond the normal 2. Add error checking to the parsed time and thread
> count values.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/workloads/thloop.c | 41 ++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/workloads/thloop.c
> index 457b29f91c3e..dbb88bcf49e0 100644
> --- a/tools/perf/tests/workloads/thloop.c
> +++ b/tools/perf/tests/workloads/thloop.c
> @@ -31,21 +31,50 @@ static void *thfunc(void *arg)
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
> +	thread_list = calloc(nt, sizeof(pthread_t));
> +	if (thread_list == NULL) {
> +		fprintf(stderr, "Error: malloc failed for %d threads\n", nt);
> +		goto out;
> +	}
> +	for (int i = 1; i < nt; i++) {
> +		int ret = pthread_create(&thread_list[i], NULL, thfunc, test_loop);
> +
> +		if (ret) {
> +			fprintf(stderr, "Error: failed to create thread %d\n", i);

With nt=2 what happens if you manage to create the first thread but not
the second? The first would not have its pthread_join()?

> +			goto out;
> +		}
> +	}
> +	alarm(sec);
>  	test_loop();
> -	pthread_join(th, NULL);
> +	for (int i = 1; i < nt; i++)
> +		pthread_join(thread_list[i], /*retval=*/NULL);
>  
> -	return 0;
> +	err = 0;
> +out:
> +	free(thread_list);
> +	return err;
>  }
>  
>  DEFINE_WORKLOAD(thloop);
> -- 
> 2.51.1.851.g4ebd6896fd-goog
