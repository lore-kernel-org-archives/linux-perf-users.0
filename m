Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84F9804;
	Fri, 11 Oct 2024 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728639990; cv=none; b=eYxASpXidssFcEsFSfeKpA4/IEOezY2AUJAgwvMXNFHuHC+QcWMdR85RuigTuDYswGX4iQT8j2QTF9zLdt9eeKXK7EaZwSjvvdx4vQPIbw9hf8w5xbzhr2MXaIySRkHKDfaMRdX/e9Xqtx7QomCphadTZjb6Gm7J8gc15VF0qxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728639990; c=relaxed/simple;
	bh=v+M+sEXI7BqLnPbmrmv04sDNbRIPP7hiTbtDIYhJfWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KE0dPDhy7PFQeq/VgE3F9iG/XTV5OQY3unuBFlagChjIZugUFEImOo9otsT9AJ3OLctn6J8gJU5tonXql63/W5Mjs3mgibJ/e1ehR/+QIdfjNj56uMb2aQnY0r6cQhg7x5Xghr1VX7bRG7kPdSx+ZTWLqXSttU4YeY4qmLgM2hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VRiijfzo; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VRiijfzo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728639989; x=1760175989;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=v+M+sEXI7BqLnPbmrmv04sDNbRIPP7hiTbtDIYhJfWo=;
  b=VRiijfzoCKuJSN6Ahr00heN0TVX4+CWQKOq0zc+eMYEYSCjt2d0VJyF3
   hW9wLc1BvZ8dOzPauH8wGFeCElFtc85K16H02ZHJiGd0i9RRsp+0V8s8Q
   5KYeEazQ9aHcV6WJelkHRsGwP+lZ/gx72A4tt+XeM/72sQbLU5PLFYllh
   0ihDuXGJAZQ5omkBgzOr+GKGkPfJ+itPSYsOjJCN/u8DHPRqKxwicg50X
   uo9f3OqsYiRMtSelXiWB5qcudiI6vPKNR54sbZrfJ6NQgo0pQLiVhRSJP
   3fdFyVESm3p4ednc56NSZNpH2wJ33EYXN1TFKekwGdeqwBd9VYGh+fHkp
   w==;
X-CSE-ConnectionGUID: S7V7FchsTw6LgQI/pTRuPw==
X-CSE-MsgGUID: S+xHBBjfQfqzgZUMZxIC5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="31829654"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="31829654"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 02:46:28 -0700
X-CSE-ConnectionGUID: tPuq55InTMi8UmaXwPg0yg==
X-CSE-MsgGUID: 5qSlIkiCSiSUtCzmHSfedQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="81651958"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 02:46:23 -0700
Message-ID: <d5864414-86ec-43d5-b38d-6c01a47e5b60@intel.com>
Date: Fri, 11 Oct 2024 12:46:18 +0300
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
 <c30c5139-6f77-4a30-bba8-b9372949aec7@intel.com>
 <91690d5c-7f46-4f6d-8140-c6013d84a0f1@arm.com>
 <dd674533-4d9c-4298-b6c3-9196b270f68b@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <dd674533-4d9c-4298-b6c3-9196b270f68b@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/10/24 12:40, Leo Yan wrote:
> 
> 
> On 10/11/24 10:34, Leo Yan wrote:
> 
>>> The 2 non-test uses of perf_cpu_map__merge both do:
>>>
>>>          a = perf_cpu_map__merge(a, b);
>>>
>>> so another way to make the API less misleading would be
>>> to introduce:
>>>
>>>          err = perf_cpu_map__merge_in(&a, b);
>>>
>>> where:
>>>
>>> int perf_cpu_map__merge_in(struct perf_cpu_map **orig, struct perf_cpu_map *other)
>>> {
>>>          struct perf_cpu_map *result = perf_cpu_map__merge(*orig, other);
>>>
>>>          if (!result)
>>>                  return -ENOMEM;
>>>
>>>          *orig = result;
>>>          return 0;
>>> }
>>>
>>> without any changes to perf_cpu_map__merge().
>>
>> Just wandering why we cannot do the same thing for the perf_cpu_map__merge()
>> function?
>>
>>    int perf_cpu_map__merge_in(struct perf_cpu_map **orig,
>>                               struct perf_cpu_map *other)
> 
> Sorry for typo and spamming. The above suggested definition is for perf_cpu_map__merge().

Yes - there is not much reason to have perf_cpu_map__merge()
and perf_cpu_map__merge_in().

> 
> 
>> This can allow us to avoid any confusion in the first place. And we don't need
>> to maintain two functions for the same thing.
>>
>> Thanks,
>> Leo
>>
>>

