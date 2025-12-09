Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D85330B02
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Dec 2025 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765285290; cv=none; b=BS5bAFulJR3czLdhtHjPDDq9RxLxsuRS+MVGo1vS4/VS/AIr4Czt8+7BifqISrd8OAA2ngd1nu5/5Lg8dEBBeFnXlBSALviINgtUDjnTO8NdGb1sKWiqEOBbM50Ob4bnjj1oVXwQMjKt3JCBgqn8h8/HWysS/bnjYrPjrrjcAIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765285290; c=relaxed/simple;
	bh=wqVgsncxvpMLGl7mWRxwt420jJBUq4mUp9pBmEvDgnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbDoDH7hPjl2RASGMMIc0z3gBYUnuYYY/1mdytGj0z/IplHAkIRmtowfxJXfpV2mMcpBlqubNDBmp0E6tAcOA/SMuoYNW9eWOAktSlxv4IRrF4MY9LI+wClk+lEvuOFy/2xo519m7xufTPxlac7RwT+adsnchaVXesFbuk2xYQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ij/4npfF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ij/4npfF"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477b1cc8fb4so39444875e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Dec 2025 05:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765285287; x=1765890087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EloXbUlyU+hIjFo3T7Nctx7EsOFehJ2QD88cldp/Pqc=;
        b=Ij/4npfFmvo4HVadd+JbVDhnxgeBeDLWLgj49f3KHN+Cwzex3U8xPeeiSRXLB66Dro
         qh3wEMkIz17RewpuIREUtrLU8gL1dA9uEjQOfCjWNk01sfco3VAGjza32jUjJQN+/Go/
         VFykYF1sl3XFq6PuFp0tLpC2oHHujqwjQ5btNEwiBSWDplOCIjGVp1Ty3Jtiz+oYV1O1
         axjznvXmhzrvc5jKfLES00YAgsUdt7ZNa713uLVhRNOYgZsdvis955KD7zhkYZtx2o7q
         zWFxDViJGI0HOVgLbDsxgyqDzvIQAiqD4Ux3cY8bwypWG9gvEM2gu087MLusNwauEx8W
         H/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765285287; x=1765890087;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EloXbUlyU+hIjFo3T7Nctx7EsOFehJ2QD88cldp/Pqc=;
        b=GF75YPfA237vtrfkoWUtOCiSaZEdFarGZnP2kk9AluRvWbDL78j5+awEfgbq1H/VOM
         m7MjEHUyLNqZDcv9uN0GlNGJPV4xVbJ2U5lzxSe7M0t5Sf8wYpcTbfzlSeGKSuHP6Qz8
         Bjd+0pTT8AWXZYCoMMzNQYAqg2YRCbyWARSK9ItttCrf9aJmNiZ6xYtWVZ8N8D/OksZ0
         /XRmSGcmJMHtsUs4jVl6bDkmE4AcELQ2IPubHs9f+nB/3kMMmbyVhtQojx1PdMTG+Gwr
         3bjpWkdVa15uLYdRWgU3g3U7RNN7IgjuY3b8PDrFJJR52/O5yjJeyp6l3tioWI50NR0A
         yfIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZuq/WEPvi3BnzyyO2z4xZKhdubbAX2mSAKYPC2+Pr8Mu0VuFhFLWp+r2utCOXcMDZnySQZ0LkPKFucEKA/pGQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzjjXdAUDr81ICfwqbRTrpbHTQ4P6yJV5jaShFWxtitlo+GXDPc
	5Vd4dKV2rRDkUUjXgH5ZLLrFv+xePraeGkeeMy8ZuVJHgvq8cwAMgx992dQRPGPNNx4=
X-Gm-Gg: ASbGncs3lJuZ1Ds3ef86rSJWstYBCmUgS4h3ml6LAIgU00N6JFZHjn5YuP/wFmvVGu8
	6Yr68IVK4nLb9HqRChj0mbBLwgisTInFXVEkCMQjXT6UWloL0SjL7vBRkuA1akfJeuaBNl8zMHM
	UYPQNRgvpTrw/KzMDLyyJ7wied5XwJtIMn9w+FMm00/fjtzlWGXE9LfIgsU8TaHLtEJHiyut9x6
	UvR7tXkE5OZtFNLefo3sK6U1aZv/Dfj9KqVYGtOedlJswMZ2GLIZfqo6qqXWpXY4wwhwHZPn7qr
	odoV1Vv/dOZjprTmuYPBiAYBpVPaLBD2GSalRHIr/9dvtEDKO2UbEk+5Yz5dCmadXuYhHyBPYDj
	q3X5Z0AFrVztCsAZPFfvpWmPZtDVdoxZER+VnrCbbzVM4oAvCDwl/VyqEE1g1v8lCOZAcWTB5G/
	UoMr/n5pBGDTleq4+3
X-Google-Smtp-Source: AGHT+IFDlGRr/YlbcCjqm4e6AKZfDMyX5+qQMOLamcP7s3WAWrfh7lAxE2Xtj6o6T4iNnHR0Lcka4A==
X-Received: by 2002:a05:600c:4ecb:b0:45d:e28c:875a with SMTP id 5b1f17b1804b1-47939e4ee88mr121622935e9.31.1765285286961;
        Tue, 09 Dec 2025 05:01:26 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d99dabesm17221325e9.5.2025.12.09.05.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 05:01:26 -0800 (PST)
Message-ID: <3c27128a-5cca-4c2f-a3f8-47b9a375bc7a@linaro.org>
Date: Tue, 9 Dec 2025 13:01:25 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf bench: Add -t/--threads option to perf bench mem
 mmap
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Ankur Arora <ankur.a.arora@oracle.com>
References: <20251207085741.1388141-1-namhyung@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251207085741.1388141-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/12/2025 8:57 am, Namhyung Kim wrote:
> So that it can measure overhead of mmap_lock and/or per-VMA lock
> contention.
> 
>    $ perf bench mem mmap -f demand -l 1000 -t 1
>    # Running 'mem/mmap' benchmark:
>    # function 'demand' (Demand loaded mmap())
>    # Copying 1MB bytes ...
> 
>           2.914503 GB/sec
> 
>    $ perf bench mem mmap -f demand -l 1000 -t 2
>    # Running 'mem/mmap' benchmark:
>    # function 'demand' (Demand loaded mmap())
>    # Copying 1MB bytes ...
> 
>         888.769991 MB/sec
> 
>    $ perf bench mem mmap -f demand -l 1000 -t 3
>    # Running 'mem/mmap' benchmark:
>    # function 'demand' (Demand loaded mmap())
>    # Copying 1MB bytes ...
> 
>         757.658220 MB/sec
> 
>    $ perf bench mem mmap -f demand -l 1000 -t 4
>    # Running 'mem/mmap' benchmark:
>    # function 'demand' (Demand loaded mmap())
>    # Copying 1MB bytes ...
> 
>         316.410713 MB/sec

Should this now say "MB/sec per thread" for nr_threads > 1? I think it 
could be interpreted either way without a label, but I see you divided 
by nr_threads in timeval2double().

> 
> Cc: Ankur Arora <ankur.a.arora@oracle.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>   tools/perf/Documentation/perf-bench.txt |  4 ++
>   tools/perf/bench/mem-functions.c        | 74 +++++++++++++++++++++----
>   2 files changed, 67 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
> index 1160224cb718392d..c5913cf59c988421 100644
> --- a/tools/perf/Documentation/perf-bench.txt
> +++ b/tools/perf/Documentation/perf-bench.txt
> @@ -274,6 +274,10 @@ Repeat mmap() invocation this number of times.
>   --cycles::
>   Use perf's cpu-cycles event instead of gettimeofday syscall.
>   
> +-t::
> +--threads=<NUM>::
> +Create multiple threads to call mmap/munmap concurrently.
> +
>   SUITES FOR 'numa'
>   ~~~~~~~~~~~~~~~~~
>   *mem*::
> diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
> index 2908a3a796c932d0..e7e7d0b41fc7720f 100644
> --- a/tools/perf/bench/mem-functions.c
> +++ b/tools/perf/bench/mem-functions.c
> @@ -26,6 +26,7 @@
>   #include <errno.h>
>   #include <linux/time64.h>
>   #include <linux/log2.h>
> +#include <pthread.h>
>   
>   #define K 1024
>   
> @@ -41,6 +42,7 @@ static unsigned int	nr_loops	= 1;
>   static bool		use_cycles;
>   static int		cycles_fd;
>   static unsigned int	seed;
> +static unsigned int	nr_threads	= 1;
>   
>   static const struct option bench_common_options[] = {
>   	OPT_STRING('s', "size", &size_str, "1MB",
> @@ -174,7 +176,7 @@ static void clock_accum(union bench_clock *a, union bench_clock *b)
>   
>   static double timeval2double(struct timeval *ts)
>   {
> -	return (double)ts->tv_sec + (double)ts->tv_usec / (double)USEC_PER_SEC;
> +	return (double)ts->tv_sec + (double)ts->tv_usec / (double)USEC_PER_SEC / nr_threads;
>   }
>   
>   #define print_bps(x) do {						\
> @@ -494,16 +496,27 @@ static void mmap_page_touch(void *dst, size_t size, unsigned int page_shift, boo
>   	}
>   }
>   
> -static int do_mmap(const struct function *r, struct bench_params *p,
> -		  void *src __maybe_unused, void *dst __maybe_unused,
> -		  union bench_clock *accum)
> +struct mmap_data {
> +	pthread_t id;
> +	const struct function *func;
> +	struct bench_params *params;
> +	union bench_clock result;
> +	unsigned int seed;
> +	int error;
> +};
> +
> +static void *do_mmap_thread(void *arg)
>   {
> +	struct mmap_data *data = arg;
> +	const struct function *r = data->func;
> +	struct bench_params *p = data->params;
>   	union bench_clock start, end, diff;
>   	mmap_op_t fn = r->fn.mmap_op;
>   	bool populate = strcmp(r->name, "populate") == 0;
> +	void *dst;
>   
> -	if (p->seed)
> -		srand(p->seed);
> +	if (data->seed)
> +		srand(data->seed);
>   
>   	for (unsigned int i = 0; i < p->nr_loops; i++) {
>   		clock_get(&start);
> @@ -514,16 +527,53 @@ static int do_mmap(const struct function *r, struct bench_params *p,
>   		fn(dst, p->size, p->page_shift, p->seed);
>   		clock_get(&end);
>   		diff = clock_diff(&start, &end);
> -		clock_accum(accum, &diff);
> +		clock_accum(&data->result, &diff);
>   
>   		bench_munmap(dst, p->size);
>   	}
>   
> -	return 0;
> +	return data;
>   out:
> -	printf("# Memory allocation failed - maybe size (%s) %s?\n", size_str,
> -			p->page_shift != PAGE_SHIFT_4KB ? "has insufficient hugepages" : "is too large");
> -	return -1;
> +	data->error = -ENOMEM;
> +	return NULL;
> +}
> +
> +static int do_mmap(const struct function *r, struct bench_params *p,
> +		  void *src __maybe_unused, void *dst __maybe_unused,
> +		  union bench_clock *accum)
> +{
> +	struct mmap_data *data;
> +	int error = 0;
> +
> +	data = calloc(nr_threads, sizeof(*data));
> +	if (!data) {
> +		printf("# Failed to allocate thread resources\n");
> +		return -1;
> +	}
> +
> +	for (unsigned int i = 0; i < nr_threads; i++) {
> +		data[i].func = r;
> +		data[i].params = p;
> +		if (p->seed)
> +			data[i].seed = p->seed + i;
> +
> +		if (pthread_create(&data[i].id, NULL, do_mmap_thread, &data[i]) < 0)
> +			data[i].error = -errno;
> +	}
> +
> +	for (unsigned int i = 0; i < nr_threads; i++) {
> +		pthread_join(data[i].id, NULL);
> +
> +		clock_accum(accum, &data[i].result);
> +		error |= data[i].error;
> +	}
> +	free(data);
> +
> +	if (error) {
> +		printf("# Memory allocation failed - maybe size (%s) %s?\n", size_str,
> +		       p->page_shift != PAGE_SHIFT_4KB ? "has insufficient hugepages" : "is too large");
> +	}
> +	return error ? -1 : 0;
>   }
>   
>   static const char * const bench_mem_mmap_usage[] = {
> @@ -548,6 +598,8 @@ int bench_mem_mmap(int argc, const char **argv)
>   	static const struct option bench_mmap_options[] = {
>   		OPT_UINTEGER('r', "randomize", &seed,
>   			    "Seed to randomize page access offset."),
> +		OPT_UINTEGER('t', "threads", &nr_threads,
> +			    "Number of threads to run concurrently (default: 1)."),
>   		OPT_PARENT(bench_common_options),
>   		OPT_END()
>   	};

