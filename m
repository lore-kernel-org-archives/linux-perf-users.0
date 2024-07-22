Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F57946C;
	Mon, 22 Jul 2024 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721644866; cv=none; b=QCWJyHC6Z7VoRpPYz5BpYVBU9kFq3o9sGt/LdgIZ2mLmVTuTv0y3gxhsxBVGwqr1n4HMFgp34X064IaXBG6m2mkNe5jxbU9aO25kIgNq9rI1RhK9M4MxWa/pI/un5F2fKU1WyxK4R+3Lzw3OIwHYBue4DaMYnA7611oEZdUor5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721644866; c=relaxed/simple;
	bh=EFV2wzzwODmtn/7Y0xB5l/izBemdfK2HYblHgY6ccaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S5GU1iXPoIA/p199vS7oMHpiD6V+ANzQ3lvCNa/UcQwAX3SQfxxfBeYRfLgYwB+X1TneQORXEE1ndxf9FS2eFI6Tkc925KLl5fDMyRGGbS+55q+RigwvDqmb4e+D4AEZv7QCL/7ZcpgD42cvH6vhtMW5N9LeBYgDswtl4AeIcpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kFgsP0Hg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kFgsP0Hg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721644865; x=1753180865;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=EFV2wzzwODmtn/7Y0xB5l/izBemdfK2HYblHgY6ccaE=;
  b=kFgsP0Hg7G/fpFJjIrz4mB0mroEypW5SwacdYJAsj1oWeUVIhVo/1IpJ
   hhzC6pZ3gtAFCVbtZ8jEajtiBxvoAg7WQdHKQzapvlf+EosZWtDfby1ni
   IKT+X3kBe1odOqFji9AkdBqst5O0Ieoyo+BYPO4CpRsemSxZhxb4xsd67
   NEy/wSVkUmLKvf7RUSj/PvXJcAm7KguxzZbiB6McRa6b0UKByh5Igixc3
   1TxRHguEP2zlpf26R/rMwFA1bG0ZPqXnPm1hCpwmPPq4ABmBZYKOonYJM
   W6oLNFfR3eIHZ4EdEqJA687Itu2aq+ZGDAbzfx0fbxKOsqqE12+DY4dZz
   Q==;
X-CSE-ConnectionGUID: yQmo61SwTc65OEjlgfLTww==
X-CSE-MsgGUID: P+7077VoQD63ejMdXXYE3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="19354517"
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="19354517"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 03:41:05 -0700
X-CSE-ConnectionGUID: 7BLo0Y8NTTuX5AE51ygT5g==
X-CSE-MsgGUID: c1KscY52SLGWR2kBiOV+OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="82857199"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.41.28])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 03:41:01 -0700
Message-ID: <3c25ed2b-9538-4d10-9152-ed1e6106b41a@intel.com>
Date: Mon, 22 Jul 2024 13:40:56 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] perf pmu: Directly use evsel's PMU pointer
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240721202113.380750-1-leo.yan@arm.com>
 <20240721202113.380750-2-leo.yan@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240721202113.380750-2-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/07/24 23:21, Leo Yan wrote:
> Rather than iterating the whole PMU list for finding the associated PMU
> device for an evsel, this commit optimizes to directly use evsel's 'pmu'
> pointer for accessing PMU device.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/util/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 986166bc7c78..798cd5a2ebc4 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1199,7 +1199,7 @@ void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
>  
>  bool evsel__is_aux_event(const struct evsel *evsel)
>  {
> -	struct perf_pmu *pmu = evsel__find_pmu(evsel);
> +	struct perf_pmu *pmu = evsel->pmu;

Assumes event parser has populated evsel->pmu for auxtrace events.
Could use a comment to that effect.

>  
>  	return pmu && pmu->auxtrace;
>  }

