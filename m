Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B7A17E44A;
	Fri, 15 Nov 2024 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731660273; cv=none; b=RL8o+WynDjzgiCIjJxkxlA3TmvnaiwHnr0VOtDMOr0r7Z6D4rZ6MCBzZVXgOlAdJBYHG4E+gtrMPWk7A+pI4gHT/aSS01GnpWBpmJx27G2pU8wjB5kKM9aWTZ91CpySn292TUxfvP/fFS/GLXe7nnvORAXDb/LPyJI0UVHNPLrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731660273; c=relaxed/simple;
	bh=BTmLMRruO58d0UaKkS+q/Ens+kOSVHgqbo1x+3kVrIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AEWFM7Wt9X/NwOiMLMl8d0fN8dXP8ewLTjL8YS0B9/2JXZr6uMt+O4HYGqiSUKXcu0cs8I2qM/nda5fp3APJRGdK2R2cQZwz125iiwchmmF+BLsua1Ljck/NfRm5C1E+6O01iwY7dtT4rqMk1gBmX3nOfPi8pIfspGy663mPvX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WDEcxOty; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WDEcxOty"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731660272; x=1763196272;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=BTmLMRruO58d0UaKkS+q/Ens+kOSVHgqbo1x+3kVrIw=;
  b=WDEcxOtyTwQyQjBg8KghRRWWjcQdczqrOlJ/KxGT7WnV8B5pPAKo1o0w
   FosC0ZGvch7tlk+2NnGRcsX3Xj3D4yFR9j/3xrJWL918QerBMQInwB/RR
   UPhgpdKTCPh6K6Ihc4AAhOOBF2XFUmvlMFTE/jmThyyXywGwKXCkA1Uu2
   /KwiMgXo1oWePU/HZcIvQ595Z2eD6kcBpPGjK3RfF8iy4Q6yU83RXuDNo
   96ThiowL2kCLLs2/gXhdHhLCwdvpDkRaBCTnjS/kMq/1WpnBVbvF9FzON
   21/ZfgfU8gVDNdOaC8EEI9+2OnqPoNZpVUn6pIGoym9aNtNlr2PqzKDEd
   w==;
X-CSE-ConnectionGUID: pFrH9JeISd2tB673tPLsag==
X-CSE-MsgGUID: VkLRl0MmQfqZrNPVO3wEYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="42739266"
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="42739266"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 00:44:32 -0800
X-CSE-ConnectionGUID: ZUeaOaHqRaeBHbP3J3M0NA==
X-CSE-MsgGUID: tbl8Z30ySPyhXJ/rrPxYXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="88903302"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 00:44:27 -0800
Message-ID: <7fa7942e-82a4-49f1-914b-ac8d76a0de2c@intel.com>
Date: Fri, 15 Nov 2024 10:44:22 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] perf cpumap: Add more tests for CPU map merging
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, "Liang, Kan" <kan.liang@linux.intel.com>,
 James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241107125308.41226-1-leo.yan@arm.com>
 <20241107125308.41226-3-leo.yan@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241107125308.41226-3-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/24 14:53, Leo Yan wrote:
> Add additional tests for CPU map merging to cover more cases.
> 
> These tests include different types of arguments, such as when one CPU
> map is a subset of another, as well as cases with or without overlap
> between the two maps.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/tests/cpumap.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
> index 7f189d57232f..f8187a801b8e 100644
> --- a/tools/perf/tests/cpumap.c
> +++ b/tools/perf/tests/cpumap.c
> @@ -156,21 +156,45 @@ static int test__cpu_map_print(struct test_suite *test __maybe_unused, int subte
>  	return 0;
>  }
>  
> -static int test__cpu_map_merge(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
> +static int __test__cpu_map_merge(const char *lhs, const char *rhs, int nr, const char *expected)
>  {
> -	struct perf_cpu_map *a = perf_cpu_map__new("4,2,1");
> -	struct perf_cpu_map *b = perf_cpu_map__new("4,5,7");
> +	struct perf_cpu_map *a = perf_cpu_map__new(lhs);
> +	struct perf_cpu_map *b = perf_cpu_map__new(rhs);
>  	char buf[100];
>  
>  	perf_cpu_map__merge(&a, b);
> -	TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(a) == 5);
> +	TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(a) == nr);
>  	cpu_map__snprint(a, buf, sizeof(buf));
> -	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "1-2,4-5,7"));
> +	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, expected));
>  	perf_cpu_map__put(b);
>  	perf_cpu_map__put(a);
>  	return 0;
>  }
>  
> +static int test__cpu_map_merge(struct test_suite *test __maybe_unused,
> +			       int subtest __maybe_unused)
> +{
> +	int ret;
> +
> +	ret = __test__cpu_map_merge("4,2,1", "4,5,7", 5, "1-2,4-5,7");
> +	if (ret)
> +		return ret;
> +	ret = __test__cpu_map_merge("1-8", "6-9", 9, "1-9");
> +	if (ret)
> +		return ret;
> +	ret = __test__cpu_map_merge("1-8,12-20", "6-9,15", 18, "1-9,12-20");
> +	if (ret)
> +		return ret;
> +	ret = __test__cpu_map_merge("4,2,1", "1", 3, "1-2,4");
> +	if (ret)
> +		return ret;
> +	ret = __test__cpu_map_merge("1", "4,2,1", 3, "1-2,4");
> +	if (ret)
> +		return ret;
> +	ret = __test__cpu_map_merge("1", "1", 1, "1");
> +	return ret;
> +}
> +
>  static int __test__cpu_map_intersect(const char *lhs, const char *rhs, int nr, const char *expected)
>  {
>  	struct perf_cpu_map *a = perf_cpu_map__new(lhs);

