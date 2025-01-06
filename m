Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921771514F6
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jan 2025 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736183675; cv=none; b=pWlI3dxD0UtblkCtDSyh8ghcjOdXli1lG8kPvAGjXr03Dy7w+bSePtwfmFkHICZGV0Rk4k8FvmZ27ks/yKpEW5I4BlRy1EafuuZ8tgk9Lpt0v1qzEc3vU9KkaDFG9/9lpMUUULya21g4kPsmXrZua+vkyNVec1cHT1GEq6NJS4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736183675; c=relaxed/simple;
	bh=gYPX7ak35yKqpjfcfidNp35ku7greqbhh704o4wb97Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uz6S137L/7rdyCPviElsiXFhbFz6NM1fHycyFdzjD4NbY7S00gDIHdQff80mNoesSAi9tBVtEqt6Gv2I194+NbzYXT3LkxYlwylx4PT1sgq3pafMYc7SL+K2epXTG8zHu45+7EidzgSJEEMnICmPUxPYdYZO4bVGmbz6pk5zZuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G3Sd5VWg; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G3Sd5VWg"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so8046432f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Jan 2025 09:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736183671; x=1736788471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=By5FO0EVLUXQEFNClCmXQLNWlbEh6v8HuXoE6KBTHJw=;
        b=G3Sd5VWgKirfSA5fFCtqQbeDBIcuNvv8hrBvrANKhPjQgZ9NyLyMiliuts3X2/7TnC
         lUrzmAxZN4STQT1mHUovCBBHaH/i9jvR6kM35RnCMMykBUzHLNedVaw3HZS+iW12P7kE
         YtWgNbNh1xqVE6OJT6L52dMzXcrscg8lcsejSKcT09+KVgImZTDWNzqK/XbCmPVdwOOk
         LyfIFycSbilMfft53L5/C70nvR4lZcRyDC3pzN2tkUtyweHCbAuEOuy10hBPth9BGtvt
         dOhMcrUtfv68kdKDb/oBQQCLzXFmu5a5maKQ80SaNrE2auUW7/CFYlkDCTMZy8lBXbc/
         M5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736183671; x=1736788471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=By5FO0EVLUXQEFNClCmXQLNWlbEh6v8HuXoE6KBTHJw=;
        b=QJq7iViLLru14eZk9CGize057W8YE7EdnTjwGfAMuxJrVZYonQA8L/ziDtRcI5suJH
         Ep+QJEK+HRCkzWc5UdU4r3W0fNQkhQrRNwFGXgeWlgUdgdiMYPrOk+dZiYrd7knPhLjp
         qBfmDQ9uItxBG3VtwSeW/ZeAxs3zzhEzhR+QnUMTw26fjGBHNoel5oDfYyhkt5CgUFzC
         He4ROzAF5UuzgdN8TeevpzBi9WPGp2EebiLTZATC8rAagvs5aRQV4EVhcLCzc+zuJvTS
         LxaPNx660vVydtsRQQNZPEU/IyIiPstOP1x/pHlx7KQUY7lmOb07z6edfjW3lGYZrYiS
         grtw==
X-Forwarded-Encrypted: i=1; AJvYcCXTo877cLcV/PCv2OsJmCLGGvPgoqBK5A62ipwf1L+DwmfEyflV4PBgLFTkbunhPfUemK1EHtrb4U9DBV9sU2/L@vger.kernel.org
X-Gm-Message-State: AOJu0YwW5o8Mx+WTxv80m1b1nyuAZQnDVaXGDBe0jTdQIV8eXSmAbgd/
	naycEVb08thlav80fkIGL9F+sKsE56G1uFaUpB4tFNXRS4rjUgbmBpVpuSd5A897yqPxeMXtN9H
	R
X-Gm-Gg: ASbGncvS8hADDvr6oKfIcyRwoC+Cy2yF5G7SLkSC2G7i0vfP1/egjTWl5hFwLVzFPkg
	k1PtrLCK6LW4oYnKU0nmgwCTTvBpoWSetZYejfGAVduRnZP8dYT/mqcIbSq8a9qaeuVklrbikBq
	0mR8R9gCDwW+blQdvSPreL6KjkwkWIskakLasnY+U5VAzTVehnZKmnjGCEjYn8VFSzlFfBsuenw
	C+WmRIjHCeb8bCPChfJ5PKDfGRMpFUi7/+rCFCKNA3D4vyQors/VvS0Jkzqm1RRnaY=
X-Google-Smtp-Source: AGHT+IG2kv6l6sn/Vui5wWFhKF7l6rM48110BNmcxfXFFXzAX67245U6lWTyxNGe2Tb58ldO2zIIiw==
X-Received: by 2002:adf:a342:0:b0:38a:624b:e37b with SMTP id ffacd0b85a97d-38a624be4e4mr14170002f8f.53.1736183670763;
        Mon, 06 Jan 2025 09:14:30 -0800 (PST)
Received: from [192.168.68.163] ([145.224.66.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611ea3e0sm580183545e9.7.2025.01.06.09.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 09:14:30 -0800 (PST)
Message-ID: <f587fc70-deca-4db5-a3c5-c8ace9e83493@linaro.org>
Date: Mon, 6 Jan 2025 17:14:15 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] perf ftrace: Add --stats option to latency subcommand
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Kan Liang <kan.liang@linux.intel.com>
References: <20250103231630.928815-1-namhyung@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250103231630.928815-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/01/2025 11:16 pm, Namhyung Kim wrote:
> Sometimes users also want to see average latency as well as histogram.
> The --stats option is to display latency statistics at the end.
> 
>    $ sudo ./perf ftrace latency -ab --stats -T synchronize_rcu -- ...
>    #   DURATION     |      COUNT | GRAPH                                          |
>         0 - 1    us |          0 |                                                |
>         1 - 2    us |          0 |                                                |
>         2 - 4    us |          0 |                                                |
>         4 - 8    us |          0 |                                                |
>         8 - 16   us |          0 |                                                |
>        16 - 32   us |          0 |                                                |
>        32 - 64   us |          0 |                                                |
>        64 - 128  us |          0 |                                                |
>       128 - 256  us |          0 |                                                |
>       256 - 512  us |          0 |                                                |
>       512 - 1024 us |          0 |                                                |
>         1 - 2    ms |          0 |                                                |
>         2 - 4    ms |          0 |                                                |
>         4 - 8    ms |          0 |                                                |
>         8 - 16   ms |          1 | #####                                          |
>        16 - 32   ms |          7 | ########################################       |
>        32 - 64   ms |          0 |                                                |
>        64 - 128  ms |          0 |                                                |
>       128 - 256  ms |          0 |                                                |
>       256 - 512  ms |          0 |                                                |
>       512 - 1024 ms |          0 |                                                |
>         1 - ...   s |          0 |                                                |
> 
>    # statistics  (in usec)
>      total time:               171832
>        avg time:                21479
>        max time:                30906
>        min time:                15869
>           count:                    8
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>   tools/perf/Documentation/perf-ftrace.txt    |  4 ++++
>   tools/perf/builtin-ftrace.c                 | 24 ++++++++++++++++++++-
>   tools/perf/util/bpf_ftrace.c                | 16 ++++++++++++--
>   tools/perf/util/bpf_skel/func_latency.bpf.c | 19 ++++++++++++++++
>   tools/perf/util/ftrace.h                    |  4 +++-
>   5 files changed, 63 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> index eccc0483f7faecad..16b067eb5d84746d 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -160,6 +160,10 @@ OPTIONS for 'perf ftrace latency'
>   	-n/--use-nsec). The setting is ignored if the value results in more than
>   	22 buckets.
>   
> +--stats::
> +	Display latency statistics at the end.
> +
> +
>   OPTIONS for 'perf ftrace profile'
>   ---------------------------------
>   
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 834074162a63bf2b..0ac2b20b272bd790 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -43,6 +43,8 @@
>   static volatile sig_atomic_t workload_exec_errno;
>   static volatile sig_atomic_t done;
>   
> +static struct stats latency_stats;  /* for tracepoints */
> +
>   static void sig_handler(int sig __maybe_unused)
>   {
>   	done = true;
> @@ -801,6 +803,13 @@ static void make_histogram(struct perf_ftrace *ftrace, int buckets[],
>   do_inc:
>   		buckets[i]++;
>   
> +		if (ftrace->stats) {
> +			if (num >= min_latency)
> +				num += min_latency;
> +
> +			update_stats(&latency_stats, num);
> +		}
> +
>   next:
>   		/* empty the line buffer for the next output  */
>   		linebuf[0] = '\0';
> @@ -894,6 +903,14 @@ static void display_histogram(struct perf_ftrace *ftrace, int buckets[])
>   	printf(" | %10d | %.*s%*s |\n", buckets[NUM_BUCKET - 1],
>   	       bar_len, bar, bar_total - bar_len, "");
>   
> +	if (ftrace->stats) {
> +		printf("\n# statistics  (in %s)\n", ftrace->use_nsec ? "nsec" : "usec");
> +		printf("  total time: %20.0f\n", latency_stats.mean * latency_stats.n);
> +		printf("    avg time: %20.0f\n", latency_stats.mean);
> +		printf("    max time: %20"PRIu64"\n", latency_stats.max);
> +		printf("    min time: %20"PRIu64"\n", latency_stats.min);
> +		printf("       count: %20.0f\n", latency_stats.n);
> +	}
>   }
>   
>   static int prepare_func_latency(struct perf_ftrace *ftrace)
> @@ -932,6 +949,9 @@ static int prepare_func_latency(struct perf_ftrace *ftrace)
>   	if (fd < 0)
>   		pr_err("failed to open trace_pipe\n");
>   
> +	if (ftrace->stats)
> +		init_stats(&latency_stats);
> +
>   	put_tracing_file(trace_file);
>   	return fd;
>   }
> @@ -961,7 +981,7 @@ static int stop_func_latency(struct perf_ftrace *ftrace)
>   static int read_func_latency(struct perf_ftrace *ftrace, int buckets[])
>   {
>   	if (ftrace->target.use_bpf)
> -		return perf_ftrace__latency_read_bpf(ftrace, buckets);
> +		return perf_ftrace__latency_read_bpf(ftrace, buckets, &latency_stats);
>   
>   	return 0;
>   }
> @@ -1620,6 +1640,8 @@ int cmd_ftrace(int argc, const char **argv)
>   		    "Minimum latency (1st bucket). Works only with --bucket-range."),
>   	OPT_UINTEGER(0, "max-latency", &ftrace.max_latency,
>   		    "Maximum latency (last bucket). Works only with --bucket-range and total buckets less than 22."),
> +	OPT_BOOLEAN(0, "stats", &ftrace.stats,
> +		    "Collect function latency stats too"),
>   	OPT_PARENT(common_options),
>   	};
>   	const struct option profile_options[] = {
> diff --git a/tools/perf/util/bpf_ftrace.c b/tools/perf/util/bpf_ftrace.c
> index bc484e65fb8f69ca..ecd5e16df9730e0d 100644
> --- a/tools/perf/util/bpf_ftrace.c
> +++ b/tools/perf/util/bpf_ftrace.c
> @@ -11,6 +11,7 @@
>   #include "util/debug.h"
>   #include "util/evlist.h"
>   #include "util/bpf_counter.h"
> +#include "util/stat.h"
>   
>   #include "util/bpf_skel/func_latency.skel.h"
>   
> @@ -53,6 +54,7 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
>   	}
>   
>   	skel->rodata->use_nsec = ftrace->use_nsec;
> +	skel->rodata->stats = ftrace->stats;
>   
>   	set_max_rlimit();
>   
> @@ -86,6 +88,9 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
>   		}
>   	}
>   
> +	if (ftrace->stats)
> +		skel->bss->min = INT64_MAX;
> +
>   	skel->links.func_begin = bpf_program__attach_kprobe(skel->progs.func_begin,
>   							    false, func->name);
>   	if (IS_ERR(skel->links.func_begin)) {
> @@ -121,8 +126,8 @@ int perf_ftrace__latency_stop_bpf(struct perf_ftrace *ftrace __maybe_unused)
>   	return 0;
>   }
>   
> -int perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace __maybe_unused,
> -				  int buckets[])
> +int perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace,
> +				  int buckets[], struct stats *stats)
>   {
>   	int i, fd, err;
>   	u32 idx;
> @@ -146,6 +151,13 @@ int perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace __maybe_unused,
>   			buckets[idx] += hist[i];
>   	}
>   
> +	if (ftrace->stats && skel->bss->count) {
> +		stats->mean = skel->bss->total / skel->bss->count;
> +		stats->n = skel->bss->count;
> +		stats->max = skel->bss->max;
> +		stats->min = skel->bss->min;
> +	}
> +
>   	free(hist);
>   	return 0;
>   }
> diff --git a/tools/perf/util/bpf_skel/func_latency.bpf.c b/tools/perf/util/bpf_skel/func_latency.bpf.c
> index 4df54e1b1411b10a..9b68eea8fd444699 100644
> --- a/tools/perf/util/bpf_skel/func_latency.bpf.c
> +++ b/tools/perf/util/bpf_skel/func_latency.bpf.c
> @@ -38,12 +38,19 @@ struct {
>   
>   int enabled = 0;
>   
> +// stats
> +__s64 total;
> +__s64 count;
> +__s64 max;
> +__s64 min;
> +
>   const volatile int has_cpu = 0;
>   const volatile int has_task = 0;
>   const volatile int use_nsec = 0;
>   const volatile unsigned int bucket_range;
>   const volatile unsigned int min_latency;
>   const volatile unsigned int max_latency;
> +const volatile int stats = 0;
>   
>   SEC("kprobe/func")
>   int BPF_PROG(func_begin)
> @@ -136,6 +143,18 @@ int BPF_PROG(func_end)
>   			return 0;
>   
>   		*hist += 1;
> +
> +		if (stats) {
> +			delta /= cmp_base;
> +
> +			__sync_fetch_and_add(&total, delta);
> +			__sync_fetch_and_add(&count, 1);
> +
> +			if (delta > max)
> +				max = delta;
> +			if (delta < min)
> +				min = delta;
> +		}
>   	}
>   
>   	return 0;
> diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
> index f218703063f74786..76038ed712085fbc 100644
> --- a/tools/perf/util/ftrace.h
> +++ b/tools/perf/util/ftrace.h
> @@ -7,6 +7,7 @@
>   
>   struct evlist;
>   struct hashamp;
> +struct stats;
>   
>   struct perf_ftrace {
>   	struct evlist		*evlist;
> @@ -23,6 +24,7 @@ struct perf_ftrace {
>   	unsigned int		bucket_range;
>   	unsigned int		min_latency;
>   	unsigned int		max_latency;
> +	bool			stats;
>   	int			graph_depth;
>   	int			func_stack_trace;
>   	int			func_irq_info;
> @@ -46,7 +48,7 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace);
>   int perf_ftrace__latency_start_bpf(struct perf_ftrace *ftrace);
>   int perf_ftrace__latency_stop_bpf(struct perf_ftrace *ftrace);
>   int perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace,
> -				  int buckets[]);
> +				  int buckets[], struct stats *stats);

Hi Namhyung,

There's a stub below for !HAVE_BPF_SKEL that needs updating too.

Also a minor point, but it seems quite low impact so it could be always 
on and then get rid of the --stats option.

Other than that:

Reviewed-by: James Clark <james.clark@linaro.org>

>   int perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace);
>   
>   #else  /* !HAVE_BPF_SKEL */

