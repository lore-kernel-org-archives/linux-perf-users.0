Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654E82B9B9;
	Fri, 15 Nov 2024 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659930; cv=none; b=mGPFa6NbK70UOgVOBME7sOeaizm4i71r3WIlxqC97ymwbsCCmbaqbtkft+52haOoz7UIarLSpr3nD6klpmueveWbFD1/PXB0QVfUopKe3tBETZ9KAowcWO41MNktkQF2c3FMKvnUazkH7frHbazRIlhAHYpey4dljPe6wpYf3vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659930; c=relaxed/simple;
	bh=Tn9VJuRMe2xlv96wKod4QuzhvPY8JAA97LpI/hU7H1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WG1M3M+p1LDYuSo0EU3FNIR0FVahgYGzXthFnAODonMs5tB/4VmFskPqwEhw95dapQZI7+MhKfAnDQZlZDdm8kntb0H9zJ4fIwpryKB37LGyesI6Jy13VnQ7vzLixIUvHSirhcKFpVrlnNMJ4fFvM5fxCHCFvMZLHIGKgmqEYys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IrfZjzEl; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IrfZjzEl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731659928; x=1763195928;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Tn9VJuRMe2xlv96wKod4QuzhvPY8JAA97LpI/hU7H1U=;
  b=IrfZjzElpPPSLKkl+2k1ZHU1A6utFDcAjIpze+PlTteQ/EbFT+5ZQltn
   WKiFE/cZbMn5n+xxZj7jzTdBa7wtERBjDNinypWTi/Hm2XZTV8T1Bn4aa
   342O8bMo5NlTOTyf5zHlkm5KTAnEDpjz3m7G2PvWAk90GJjwq5oruZXqC
   1/B9S2YzQeWblvgVqJdGted2SQHyAf+8k+H3/4BEftWQEceOo0em7EKOT
   WxozFzPSMVymvmetMFGXBGdiboUwAjUBtpZ6eeemYXRzp/HsL1J4qKLfk
   TWUtiAp3WXR99+W9Zp+EkOB+W8t1e8/6cdI5H7YPrsDLKt8T3WqQLT0KK
   Q==;
X-CSE-ConnectionGUID: I3ztPHXfQXWiLDKBiCviLA==
X-CSE-MsgGUID: aHiDu4CLT8aneG2Ts7mcDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="19268729"
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="19268729"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 00:38:24 -0800
X-CSE-ConnectionGUID: k40xVWqFTwyCyYHhCW1H+A==
X-CSE-MsgGUID: JDixOTL5QsuiG6FuyZ+j0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="119428133"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 00:38:15 -0800
Message-ID: <d133fc97-e4d7-4970-933f-2762c25ae50e@intel.com>
Date: Fri, 15 Nov 2024 10:38:10 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] libperf cpumap: Refactor perf_cpu_map__merge()
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, "Liang, Kan" <kan.liang@linux.intel.com>,
 James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241107125308.41226-1-leo.yan@arm.com>
 <20241107125308.41226-2-leo.yan@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241107125308.41226-2-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/24 14:53, Leo Yan wrote:
> The perf_cpu_map__merge() function has two arguments, 'orig' and
> 'other'.  The function definition might cause confusion as it could give
> the impression that the CPU maps in the two arguments are copied into a
> new allocated structure, which is then returned as the result.
> 
> The purpose of the function is to merge the CPU map 'other' into the CPU
> map 'orig'.  This commit changes the 'orig' argument to a pointer to
> pointer, so the new result will be updated into 'orig'.
> 
> The return value is changed to an int type, as an error number or 0 for
> success.
> 
> Update callers and tests for the new function definition.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/lib/perf/cpumap.c              | 49 +++++++++++++++-------------
>  tools/lib/perf/evlist.c              |  2 +-
>  tools/lib/perf/include/perf/cpumap.h |  4 +--
>  tools/perf/tests/cpumap.c            | 13 ++++----
>  tools/perf/util/mem-events.c         |  5 ++-
>  5 files changed, 40 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> index cae799ad44e1..a36e90d38142 100644
> --- a/tools/lib/perf/cpumap.c
> +++ b/tools/lib/perf/cpumap.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> +#include <errno.h>
>  #include <perf/cpumap.h>
>  #include <stdlib.h>
>  #include <linux/refcount.h>
> @@ -436,46 +437,49 @@ bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu
>  }
>  
>  /*
> - * Merge two cpumaps
> + * Merge two cpumaps.
>   *
> - * orig either gets freed and replaced with a new map, or reused
> - * with no reference count change (similar to "realloc")
> - * other has its reference count increased.
> + * If 'other' is subset of '*orig', '*orig' keeps itself with no reference count
> + * change (similar to "realloc").
> + *
> + * If '*orig' is subset of 'other', '*orig' reuses 'other' with its reference
> + * count increased.
> + *
> + * Otherwise, '*orig' gets freed and replaced with a new map.
>   */
> -
> -struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
> -					 struct perf_cpu_map *other)
> +int perf_cpu_map__merge(struct perf_cpu_map **orig, struct perf_cpu_map *other)
>  {
>  	struct perf_cpu *tmp_cpus;
>  	int tmp_len;
>  	int i, j, k;
>  	struct perf_cpu_map *merged;
>  
> -	if (perf_cpu_map__is_subset(orig, other))
> -		return orig;
> -	if (perf_cpu_map__is_subset(other, orig)) {
> -		perf_cpu_map__put(orig);
> -		return perf_cpu_map__get(other);
> +	if (perf_cpu_map__is_subset(*orig, other))
> +		return 0;
> +	if (perf_cpu_map__is_subset(other, *orig)) {
> +		perf_cpu_map__put(*orig);
> +		*orig = perf_cpu_map__get(other);
> +		return 0;
>  	}
>  
> -	tmp_len = __perf_cpu_map__nr(orig) + __perf_cpu_map__nr(other);
> +	tmp_len = __perf_cpu_map__nr(*orig) + __perf_cpu_map__nr(other);
>  	tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
>  	if (!tmp_cpus)
> -		return NULL;
> +		return -ENOMEM;
>  
>  	/* Standard merge algorithm from wikipedia */
>  	i = j = k = 0;
> -	while (i < __perf_cpu_map__nr(orig) && j < __perf_cpu_map__nr(other)) {
> -		if (__perf_cpu_map__cpu(orig, i).cpu <= __perf_cpu_map__cpu(other, j).cpu) {
> -			if (__perf_cpu_map__cpu(orig, i).cpu == __perf_cpu_map__cpu(other, j).cpu)
> +	while (i < __perf_cpu_map__nr(*orig) && j < __perf_cpu_map__nr(other)) {
> +		if (__perf_cpu_map__cpu(*orig, i).cpu <= __perf_cpu_map__cpu(other, j).cpu) {
> +			if (__perf_cpu_map__cpu(*orig, i).cpu == __perf_cpu_map__cpu(other, j).cpu)
>  				j++;
> -			tmp_cpus[k++] = __perf_cpu_map__cpu(orig, i++);
> +			tmp_cpus[k++] = __perf_cpu_map__cpu(*orig, i++);
>  		} else
>  			tmp_cpus[k++] = __perf_cpu_map__cpu(other, j++);
>  	}
>  
> -	while (i < __perf_cpu_map__nr(orig))
> -		tmp_cpus[k++] = __perf_cpu_map__cpu(orig, i++);
> +	while (i < __perf_cpu_map__nr(*orig))
> +		tmp_cpus[k++] = __perf_cpu_map__cpu(*orig, i++);
>  
>  	while (j < __perf_cpu_map__nr(other))
>  		tmp_cpus[k++] = __perf_cpu_map__cpu(other, j++);
> @@ -483,8 +487,9 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
>  
>  	merged = cpu_map__trim_new(k, tmp_cpus);
>  	free(tmp_cpus);
> -	perf_cpu_map__put(orig);
> -	return merged;
> +	perf_cpu_map__put(*orig);
> +	*orig = merged;
> +	return 0;
>  }
>  
>  struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *orig,
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index c6d67fc9e57e..94b7369f3efe 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -75,7 +75,7 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>  		evsel->threads = perf_thread_map__get(evlist->threads);
>  	}
>  
> -	evlist->all_cpus = perf_cpu_map__merge(evlist->all_cpus, evsel->cpus);
> +	perf_cpu_map__merge(&evlist->all_cpus, evsel->cpus);
>  }
>  
>  static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
> diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
> index 90457d17fb2f..c83bfb2c36ff 100644
> --- a/tools/lib/perf/include/perf/cpumap.h
> +++ b/tools/lib/perf/include/perf/cpumap.h
> @@ -39,8 +39,8 @@ LIBPERF_API struct perf_cpu_map *perf_cpu_map__new_online_cpus(void);
>  LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
>  LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
>  LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
> -LIBPERF_API struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
> -						     struct perf_cpu_map *other);
> +LIBPERF_API int perf_cpu_map__merge(struct perf_cpu_map **orig,
> +				    struct perf_cpu_map *other);
>  LIBPERF_API struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *orig,
>  							 struct perf_cpu_map *other);
>  LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
> diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
> index 2f0168b2a5a9..7f189d57232f 100644
> --- a/tools/perf/tests/cpumap.c
> +++ b/tools/perf/tests/cpumap.c
> @@ -160,14 +160,14 @@ static int test__cpu_map_merge(struct test_suite *test __maybe_unused, int subte
>  {
>  	struct perf_cpu_map *a = perf_cpu_map__new("4,2,1");
>  	struct perf_cpu_map *b = perf_cpu_map__new("4,5,7");
> -	struct perf_cpu_map *c = perf_cpu_map__merge(a, b);
>  	char buf[100];
>  
> -	TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(c) == 5);
> -	cpu_map__snprint(c, buf, sizeof(buf));
> +	perf_cpu_map__merge(&a, b);
> +	TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(a) == 5);
> +	cpu_map__snprint(a, buf, sizeof(buf));
>  	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "1-2,4-5,7"));
>  	perf_cpu_map__put(b);
> -	perf_cpu_map__put(c);
> +	perf_cpu_map__put(a);
>  	return 0;
>  }
>  
> @@ -233,9 +233,8 @@ static int test__cpu_map_equal(struct test_suite *test __maybe_unused, int subte
>  	}
>  
>  	/* Maps equal made maps. */
> -	tmp = perf_cpu_map__merge(perf_cpu_map__get(one), two);
> -	TEST_ASSERT_VAL("pair", perf_cpu_map__equal(pair, tmp));
> -	perf_cpu_map__put(tmp);
> +	perf_cpu_map__merge(&two, one);
> +	TEST_ASSERT_VAL("pair", perf_cpu_map__equal(pair, two));
>  
>  	tmp = perf_cpu_map__intersect(pair, one);
>  	TEST_ASSERT_VAL("one", perf_cpu_map__equal(one, tmp));
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index bf5090f5220b..3692e988c86e 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -258,6 +258,7 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr)
>  	const char *s;
>  	char *copy;
>  	struct perf_cpu_map *cpu_map = NULL;
> +	int ret;
>  
>  	while ((pmu = perf_pmus__scan_mem(pmu)) != NULL) {
>  		for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> @@ -283,7 +284,9 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr)
>  			rec_argv[i++] = "-e";
>  			rec_argv[i++] = copy;
>  
> -			cpu_map = perf_cpu_map__merge(cpu_map, pmu->cpus);
> +			ret = perf_cpu_map__merge(&cpu_map, pmu->cpus);
> +			if (ret < 0)
> +				return ret;
>  		}
>  	}
>  

