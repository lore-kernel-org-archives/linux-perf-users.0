Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338756F31E;
	Thu, 10 Oct 2024 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582128; cv=none; b=PA5HwtmJ/nvddpLYs0Tr1g9itJ86C45clYeOLO8hww3FdzhKIvs9M7TYQjRUmTnOuMjLivlpYG7Ji8pKOQ81mJ0BtCDlYzcccrWWpCxpN9IDZdCTbVL0X1ig+tvvTzG7Ks0lgkJtYQqx8+oe2A6HE9NOAd2LSkEAcOgkHVx1sJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582128; c=relaxed/simple;
	bh=ye/gP1n8ztIFDCLZNjmaLjugOLDjluD09gxF3HmEwNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uirrR5MYoo0WNuS/6BUUbtr9oKQq5/Hw5ZPIhch/yjua62W2ccwQAeXaBUtCSmfs5GhQc1Dlt1bH2BaTPFU9sl/o/xuOyVQ48Q+WXYqCkc+0jzL3BLUJ4JjjcA31lMxE5Y+4GKFjW5Gl/y6hMvwJvbC8ymW43fxVrwksdWpU71o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UePnBmAV; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UePnBmAV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728582126; x=1760118126;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ye/gP1n8ztIFDCLZNjmaLjugOLDjluD09gxF3HmEwNs=;
  b=UePnBmAVj7UtPcoA4ZO5pFEb2zOM43UtFFPPw5A1UIcQk/SzM+a4nmKT
   qoQiOpDc3ILn1NDpghrd9TBMaGMmRRok3y3OG8VhawdIaot6v0QnNArOI
   j7pHrVVmoHjCl3MUeWKQMV8nxXw4nBJ8M8d036ojjWSxGvWzkccW2ggZ/
   t2mHL0PCRbo5vZ2dFvxM6/vH1CHAA43XJTYGLO9uvTZDDR1Ui5V0CrCB/
   F006M0o4s283uWEjZDwU1imSK2KarM90J/POYN5g1C8aLJ3v/LQUv9Ra+
   oVRJBPKxzWnlTMja79HVJK0ECLTOcQgaewz5+1MI47ktmA5g1vDKQdO7A
   Q==;
X-CSE-ConnectionGUID: itPDWUYaS5CPrVitKGKVZg==
X-CSE-MsgGUID: /OAJjNWlRsyKP+5TsGPPSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="28049339"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="28049339"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 10:42:06 -0700
X-CSE-ConnectionGUID: B7KXnM6zSQ25Uj2LLThcSw==
X-CSE-MsgGUID: iU+jRwPySHOUeSjf55/5Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="107524502"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 10:42:01 -0700
Message-ID: <c30c5139-6f77-4a30-bba8-b9372949aec7@intel.com>
Date: Thu, 10 Oct 2024 20:41:56 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] libperf cpumap: Correct reference count for
 perf_cpu_map__merge()
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240925195325.426533-1-leo.yan@arm.com>
 <20240925195325.426533-2-leo.yan@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240925195325.426533-2-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/09/24 22:53, Leo Yan wrote:
> The perf_cpu_map__merge() function has two arguments, 'orig' and 'other',
> and it returns results for three different cases:
> 
>   Case 1: 'other' is a subset of 'orig'.
>   Case 2: 'orig' is a subset of 'other'.
>   Case 3: 'orig' and 'other' are not subsets of each other.
> 
> The result combinations are:
> 
>   +--------+-------------+-----------+-----------+
>   | Cases  | Result      | orig      | other     |
>   +--------+-------------+-----------+-----------+
>   | Case1  | orig        | No change | No change |
>   +--------+-------------+-----------+-----------+
>   | Case2  | other       | No change | refcnt++  |
>   +--------+-------------+-----------+-----------+
>   | Case3  | New CPU map | refcnt--  | No change |
>   +--------+-------------+-----------+-----------+
> 
> Both Case 1 and Case 3 have a risk of releasing maps unexpectedly. This
> is because the reference counter operations are not consistent crossing
> different cases and leads to difficulty for callers handling them.
> 
> For Case 1, because 'other' is a subset of 'orig', 'orig' is returned as
> the merging result, but its refcnt is not incremented. This can lead to
> the map being released repeatedly:
> 
>   struct perf_cpu_map *a = perf_cpu_map__new("1,2");
>   struct perf_cpu_map *b = perf_cpu_map__new("2");
> 
>   /* 'm' and 'a' point to the same CPU map */
>   struct perf_cpu_map *m = perf_cpu_map__merge(a, b);
> 
>   ...
> 
>   perf_cpu_map__put(m); -> Release the map
>   perf_cpu_map__put(b);
>   perf_cpu_map__put(a); -> Release the same merged again
> 
> For Case 3, it is possible that the CPU map pointed to by 'orig' can be
> released twice: within the function and outside of it.
> 
>   struct perf_cpu_map *a = perf_cpu_map__new("1,2");
>   struct perf_cpu_map *b = perf_cpu_map__new("3");
> 
>   struct perf_cpu_map *m = perf_cpu_map__merge(a, b);
>                              `> 'm' is new allocated map. But 'a' has
> 			        been released in the function.
>   ...
> 
>   perf_cpu_map__put(m);
>   perf_cpu_map__put(b);
>   perf_cpu_map__put(a); -> Release the 'a' map again
> 
> This commit increases the reference counter if a passed map is returned.
> For the case of a newly allocated map, it does not change the reference
> counter for passed maps.

The 2 non-test uses of perf_cpu_map__merge both do:

	a = perf_cpu_map__merge(a, b);

so another way to make the API less misleading would be
to introduce:

	err = perf_cpu_map__merge_in(&a, b);

where:

int perf_cpu_map__merge_in(struct perf_cpu_map **orig, struct perf_cpu_map *other)
{
	struct perf_cpu_map *result = perf_cpu_map__merge(*orig, other);

	if (!result)
		return -ENOMEM;

	*orig = result;
	return 0;
}

without any changes to perf_cpu_map__merge().

> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/lib/perf/cpumap.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> index cae799ad44e1..3f80eade8b1c 100644
> --- a/tools/lib/perf/cpumap.c
> +++ b/tools/lib/perf/cpumap.c
> @@ -438,9 +438,7 @@ bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu
>  /*
>   * Merge two cpumaps
>   *
> - * orig either gets freed and replaced with a new map, or reused
> - * with no reference count change (similar to "realloc")
> - * other has its reference count increased.
> + * Return a new map, or reused with its reference count increased.
>   */
>  
>  struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
> @@ -452,11 +450,9 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
>  	struct perf_cpu_map *merged;
>  
>  	if (perf_cpu_map__is_subset(orig, other))
> -		return orig;
> -	if (perf_cpu_map__is_subset(other, orig)) {
> -		perf_cpu_map__put(orig);
> +		return perf_cpu_map__get(orig);
> +	if (perf_cpu_map__is_subset(other, orig))
>  		return perf_cpu_map__get(other);
> -	}
>  
>  	tmp_len = __perf_cpu_map__nr(orig) + __perf_cpu_map__nr(other);
>  	tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
> @@ -483,7 +479,6 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
>  
>  	merged = cpu_map__trim_new(k, tmp_cpus);
>  	free(tmp_cpus);
> -	perf_cpu_map__put(orig);
>  	return merged;
>  }
>  

