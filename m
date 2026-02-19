Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084103093A8
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Feb 2026 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771497792; cv=none; b=J/r/lbPWMuxAO9dYYchwY2dmc/l+cecNeg9LDe1cS0yH8mywjeNKr3Qeblc5TGOBB3SpATr8CiKSXAqw0JYD/EfCDr8kZp12pVZlEKeYeg+tQu+ezGCXQRerSDg6Eabv15wZ1fM8DmFxVJ7y17Wg99E5WFC32LQkMOTOYXH7X2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771497792; c=relaxed/simple;
	bh=jIDl2aUFSTNM4e0HIAkwwoqLD+t+1ahm4trFh/HXOzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Em4GAcQFHf+t/soyIMXOELZkxwQM4WbnCUDJBsZoViNXOmM0n+ytyjda1h1c8+ndqoZ75THcad4TBkvChgklA1f8s33U3fEN+JBNUxOrbWq42YNK/I6MM/ZFKDnQlQskBeXElRfwt61uXO1rIBA2MMuUZzc7TVFBuioUqdJe3eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zL3JSWjR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zL3JSWjR"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48372efa020so6079835e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Feb 2026 02:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771497789; x=1772102589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FaFPVUJQnAWvUj3Wv50cn/Nz/uP6wEpNDusbLeuclUY=;
        b=zL3JSWjRNRZ8IH8FVM4sxdPQi88QdaYziqU/qqwGWy/kcW8Bp1haq/MxuZ8LC3uPbd
         BtvSE0+m0MqAotRaEy92XOPwJUS+3FzFS3ayxZ4WhQNKlsxzozTyRfpc5h3SPuQYdC3x
         kM65pXFMs1pOCasJp1BRSys/AMSDplDfZ4UlL8WiDrHhIwgeVIiqTZSZ6701/lf+2+6W
         BD4z74Nt+TNsvz1SnaZzdwLAGpEGFc+Qq6Mtrcz4NI4X3TJFKDy7IUic6YvPFH5jYwkA
         NiLqWAuabTUWluKBVUP7NZbUHXwB9IjytIzdds2bjx4m6sDiJLigb4ayk5+/BnhJX4SZ
         G8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771497789; x=1772102589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FaFPVUJQnAWvUj3Wv50cn/Nz/uP6wEpNDusbLeuclUY=;
        b=THRqksh9yFtYgRzochbvrkWczYzDWuIJGuHV5j8vM9uH/iDs8W7Yi9Z+acc+0bVAGM
         M5aHhs6RrRX+ejFgYVKZOHrjdmekO8KQ9odPjl6amcO6IRFNdi4QqOtOvewFW7aHE76S
         ObZbS++c07N+TVxVjONpEBn7v9P1YWAPGxleU1UBLPf0G9Zf5j/tskphQYGxfDrLiryo
         OPgAGJghNXDNp2xCvtspiff7njvJyfYcEmAQT73vo+YbhZ3bFscDJoQDHp8vfPL5KVzf
         vZad0H2nn4k++cDF0tVwnzgLducTZk6VWsrgKxeumyjQ5UMH9lAzyRQ620gSxreEecJe
         r9GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNYw54Xw3tqGfiG2GHuUhpZK4tU7rP5i1Pa0sKFy3c9MDY7xJ/rQTiZFHPj9egnfnTRdDD5gmX00fsk1gpR8KC@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9prGMcfPuFdi7zargY2JhT7I16wZe80Zz+kQWQh1DVQ9wNgnc
	+BT2SV25jokFWMNapmB1WqQiWXMEASxL1GL6NOvXXNM4t2S3XB2FFjh91UHgJzOOLmc=
X-Gm-Gg: AZuq6aL7F+dXpdmmHJnnNAzLx5nF+I7LnrQa7z9cVuyuwjPB0MnETr6Z71j5XHrSIz1
	IaWzt8gYdK4Sfvmb2J68Yz4MjeSsFt99cpTSDzRhBVPZI3zoo9g96gWJYnVoYShRw/9zXlikyMM
	ulsQkqSIFax9VKEqgWXF1H4KlSf5F1ygpo0FSlvY3Fl7wVYK3rSAehaCRT1PyGgbGCsbAOtklDU
	FEA7Ff8pd3ksjMLTrSZYttCJQbCV+SkNVkAOiHlr3lcyC05+h7pFa5mO3+WaWAX/mAEnycR4Qw4
	NBzEhARtgWDKUFH+I4bcK00v7uuRCDbmD158fDKMjZDu7GrzVR40jSC+HN7UIO3kmHqz9L80EuN
	G1LX4OTvnDpM27zebUjZDj2HYUAxyhZv6AhcwAo+J1IU7OZQM2c1Lxjd9rTL9cVTu99OjXoDNqP
	heQajlAe2MhwtW6+bMAOjZ3q6T8v16
X-Received: by 2002:a05:600c:8b84:b0:483:4bbc:89ea with SMTP id 5b1f17b1804b1-48379c42db1mr290735695e9.37.1771497789133;
        Thu, 19 Feb 2026 02:43:09 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4839f986118sm16023575e9.21.2026.02.19.02.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 02:43:08 -0800 (PST)
Message-ID: <d50a0446-7029-4234-8399-b8f643d44c62@linaro.org>
Date: Thu, 19 Feb 2026 10:43:07 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] perf bench: Add -t/--threads option to perf bench
 mem mmap
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Ankur Arora <ankur.a.arora@oracle.com>
References: <20260219004417.188434-1-namhyung@kernel.org>
 <20260219004417.188434-2-namhyung@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260219004417.188434-2-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/02/2026 12:44 am, Namhyung Kim wrote:
> So that it can measure overhead of mmap_lock and/or per-VMA lock
> contention.
> 
>    $ perf bench mem mmap -f demand -l 1000 -t 1
>    # Running 'mem/mmap' benchmark:
>    # function 'demand' (Demand loaded mmap())
>    # Copying 1MB bytes ...
> 
>           2.786858 GB/sec
> 
>    $ perf bench mem mmap -f demand -l 1000 -t 2
>    # Running 'mem/mmap' benchmark:
>    # function 'demand' (Demand loaded mmap())
>    # Copying 1MB bytes ...
> 
>           1.624468 GB/sec/thread   ( +-   0.30% )
> 
>    $ perf bench mem mmap -f demand -l 1000 -t 3
>    # Running 'mem/mmap' benchmark:
>    # function 'demand' (Demand loaded mmap())
>    # Copying 1MB bytes ...
> 
>           1.493068 GB/sec/thread   ( +-   0.15% )
> 
>    $ perf bench mem mmap -f demand -l 1000 -t 4
>    # Running 'mem/mmap' benchmark:
>    # function 'demand' (Demand loaded mmap())
>    # Copying 1MB bytes ...
> 
>           1.006087 GB/sec/thread   ( +-   0.41% )
> 
> Cc: Ankur Arora <ankur.a.arora@oracle.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> v2)
>   * correct timeval2double calculation
>   * add "/thread" notation when -t > 1  (James)
>   * add stddev when -t > 1  (Ankur)
> 
>   tools/perf/Documentation/perf-bench.txt |   4 +
>   tools/perf/bench/mem-functions.c        | 109 +++++++++++++++++++-----
>   2 files changed, 92 insertions(+), 21 deletions(-)
> 

Reviewed-by: James Clark <james.clark@linaro.org>

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
> index 676c8d18f4c2e259..8e04ae69f8a85c5e 100644
> --- a/tools/perf/bench/mem-functions.c
> +++ b/tools/perf/bench/mem-functions.c
> @@ -7,13 +7,14 @@
>    * Written by Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
>    */
>   
> -#include "debug.h"
> +#include "bench.h"
>   #include "../perf-sys.h"
>   #include <subcmd/parse-options.h>
> -#include "../util/header.h"
> -#include "../util/cloexec.h"
> -#include "../util/string2.h"
> -#include "bench.h"
> +#include "util/cloexec.h"
> +#include "util/debug.h"
> +#include "util/header.h"
> +#include "util/stat.h"
> +#include "util/string2.h"
>   #include "mem-memcpy-arch.h"
>   #include "mem-memset-arch.h"
>   
> @@ -26,6 +27,7 @@
>   #include <errno.h>
>   #include <linux/time64.h>
>   #include <linux/log2.h>
> +#include <pthread.h>
>   
>   #define K 1024
>   
> @@ -41,6 +43,7 @@ static unsigned int	nr_loops	= 1;
>   static bool		use_cycles;
>   static int		cycles_fd;
>   static unsigned int	seed;
> +static unsigned int	nr_threads	= 1;
>   
>   static const struct option bench_common_options[] = {
>   	OPT_STRING('s', "size", &size_str, "1MB",
> @@ -121,6 +124,8 @@ static struct perf_event_attr cycle_attr = {
>   	.config		= PERF_COUNT_HW_CPU_CYCLES
>   };
>   
> +static struct stats stats;
> +
>   static int init_cycles(void)
>   {
>   	cycles_fd = sys_perf_event_open(&cycle_attr, getpid(), -1, -1, perf_event_open_cloexec_flag());
> @@ -174,18 +179,18 @@ static void clock_accum(union bench_clock *a, union bench_clock *b)
>   
>   static double timeval2double(struct timeval *ts)
>   {
> -	return (double)ts->tv_sec + (double)ts->tv_usec / (double)USEC_PER_SEC;
> +	return ((double)ts->tv_sec + (double)ts->tv_usec / (double)USEC_PER_SEC) / nr_threads;
>   }
>   
>   #define print_bps(x) do {						\
>   		if (x < K)						\
> -			printf(" %14lf bytes/sec\n", x);		\
> +			printf(" %14lf bytes/sec", x);			\
>   		else if (x < K * K)					\
> -			printf(" %14lfd KB/sec\n", x / K);		\
> +			printf(" %14lfd KB/sec", x / K);		\
>   		else if (x < K * K * K)					\
> -			printf(" %14lf MB/sec\n", x / K / K);		\
> +			printf(" %14lf MB/sec", x / K / K);		\
>   		else							\
> -			printf(" %14lf GB/sec\n", x / K / K / K);	\
> +			printf(" %14lf GB/sec", x / K / K / K);	\
>   	} while (0)
>   
>   static void __bench_mem_function(struct bench_mem_info *info, struct bench_params *p,
> @@ -197,6 +202,7 @@ static void __bench_mem_function(struct bench_mem_info *info, struct bench_param
>   	void *src = NULL, *dst = NULL;
>   
>   	memset(&rt, 0, sizeof(rt));
> +	init_stats(&stats);
>   	printf("# function '%s' (%s)\n", r->name, r->desc);
>   
>   	if (r->fn.init && r->fn.init(info, p, &src, &dst))
> @@ -211,11 +217,16 @@ static void __bench_mem_function(struct bench_mem_info *info, struct bench_param
>   	switch (bench_format) {
>   	case BENCH_FORMAT_DEFAULT:
>   		if (use_cycles) {
> -			printf(" %14lf cycles/byte\n", (double)rt.cycles/(double)p->size_total);
> +			printf(" %14lf cycles/byte", (double)rt.cycles/(double)p->size_total);
>   		} else {
>   			result_bps = (double)p->size_total/timeval2double(&rt.tv);
>   			print_bps(result_bps);
>   		}
> +		if (nr_threads > 1) {
> +			printf("/thread\t( +- %6.2f%% )",
> +			       rel_stddev_stats(stddev_stats(&stats), avg_stats(&stats)));
> +		}
> +		printf("\n");
>   		break;
>   
>   	case BENCH_FORMAT_SIMPLE:
> @@ -495,16 +506,27 @@ static void mmap_page_touch(void *dst, size_t size, unsigned int page_shift, boo
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
> @@ -515,16 +537,59 @@ static int do_mmap(const struct function *r, struct bench_params *p,
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
> +		union bench_clock *t = &data[i].result;
> +
> +		pthread_join(data[i].id, NULL);
> +
> +		clock_accum(accum, t);
> +		if (use_cycles)
> +			update_stats(&stats, t->cycles);
> +		else
> +			update_stats(&stats, t->tv.tv_sec * 1e6 + t->tv.tv_usec);
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
> @@ -549,6 +614,8 @@ int bench_mem_mmap(int argc, const char **argv)
>   	static const struct option bench_mmap_options[] = {
>   		OPT_UINTEGER('r', "randomize", &seed,
>   			    "Seed to randomize page access offset."),
> +		OPT_UINTEGER('t', "threads", &nr_threads,
> +			    "Number of threads to run concurrently (default: 1)."),
>   		OPT_PARENT(bench_common_options),
>   		OPT_END()
>   	};

