Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE03174EE4;
	Fri, 15 Nov 2024 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731660551; cv=none; b=Iwl5r3sk4KMQlN18KfjyuJe1G3nQlEywmlQMUYjqMmtwsHsACy+xxHl62XbQIRFnD6mWxb6qj7Ljew2cftIlsqxNldnB/pJWrANTUjdyyNlCtCg6JzgHaZv7qHzlaxKNnsJraBcaq4uh4MFcNHBXZkkTg7b/hl9wDdcQ8qvik9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731660551; c=relaxed/simple;
	bh=Bn9p2f4x838RbxuIp6/3keJ5yvXCNdZc7B0nzOHhsvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fm89Ci8fYjEG6Ibo+xOEui4W1fpDHTVulcrvVFR0d6Avld+eTFyJJmnlEO0TEkBmVKNZuq2clmfms1ZOag0ehDrjrJmjDmfna+CP9gfDd/x6mvf/c7UWI+T3bUtWZ5ywCileF1SFQCXvyxVvoamBnax3gQqLrLP5EtW5RN6QWBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GmXhVevz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GmXhVevz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731660550; x=1763196550;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Bn9p2f4x838RbxuIp6/3keJ5yvXCNdZc7B0nzOHhsvE=;
  b=GmXhVevzw4s3Ujv2NfzDVykR0CHL0d3GRPOrhMigrKJsjZzvdnlNBAd9
   j2iox4fDYtWuoo512HzQUxyjYg5IVgOHtsWdJ0aHUsfyM7ExAwu6knm4P
   127NAFvAk+HuTFI1mEoqVlbWG5yGmeNPeXb0Y8226A7zJuSi+OjVhXio+
   9lw2aLpcHpG90zBXO3q6N5TjgLifouqU8l7rXoI9vY6tpo+qK0b75c5Rq
   8hixQEDYBLVphznTwDPU26UhA7K6DjrI1BHzMfkh6bUznGRcNLLn4rIJQ
   ZczZwc64ZnsHUhMfxU4BgW0UuTaKGUnFwduC6n9D3otZVLdQXIfvkuFom
   Q==;
X-CSE-ConnectionGUID: +MiBm0cUSQidLsMGYkTbaw==
X-CSE-MsgGUID: MIgLJTtcTlSA+sSVsYCprw==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="43062589"
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="43062589"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 00:49:09 -0800
X-CSE-ConnectionGUID: rgeU7d7bQ5ywd08aH7h1Bw==
X-CSE-MsgGUID: F/vZsQPdRIyY8RJLtKG1dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="88491133"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 00:49:05 -0800
Message-ID: <a584b2da-7463-41c4-885c-1ff13e69b08a@intel.com>
Date: Fri, 15 Nov 2024 10:49:01 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] perf cpumap: Add checking for reference counter
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, "Liang, Kan" <kan.liang@linux.intel.com>,
 James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241107125308.41226-1-leo.yan@arm.com>
 <20241107125308.41226-4-leo.yan@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241107125308.41226-4-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/24 14:53, Leo Yan wrote:
> For the CPU map merging test, add an extra check for the reference
> counter before releasing the last CPU map.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/tests/cpumap.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
> index f8187a801b8e..5ed7ff072ea3 100644
> --- a/tools/perf/tests/cpumap.c
> +++ b/tools/perf/tests/cpumap.c
> @@ -167,6 +167,15 @@ static int __test__cpu_map_merge(const char *lhs, const char *rhs, int nr, const
>  	cpu_map__snprint(a, buf, sizeof(buf));
>  	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, expected));
>  	perf_cpu_map__put(b);
> +
> +	/*
> +	 * If 'b' is a superset of 'a', 'a' points to the same map with the
> +	 * map 'b'. In this case, the owner 'b' has released the resource above
> +	 * but 'a' still keeps the ownership, the reference counter should be 1.
> +	 */
> +	TEST_ASSERT_VAL("unexpected refcnt: bad result",
> +			refcount_read(perf_cpu_map__refcnt(a)) == 1);
> +
>  	perf_cpu_map__put(a);
>  	return 0;
>  }

