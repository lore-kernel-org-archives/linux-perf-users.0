Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70B8188A37;
	Thu,  5 Sep 2024 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725520395; cv=none; b=mTfEscYAul9DPhWeJBml0HdQ8bnNiz4qejB0lc3c/99ccuhMrlPM8Gs8yd6FmkBqTnX+bhYHM95S+WFbV3ah+FCdlv9taeZomkW+8e+4x5tcy5u0X7reHbMsXZ89yIgCEdCNgzNjCxC29z3o+fD1jdGT2uXxw0mmW0Lqwg0T0II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725520395; c=relaxed/simple;
	bh=7LNlhMFKGtFOttw11QtnX7UvMeTpjZskhNoGqPd2rs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eqr+tJvXNyXXVK9S8LQIxhPZMnik6zoDFm+HbYg6KqOt9HiPjECgSlWCVONXDNDnA2V/r+7cGKf1eZfcjqrs+ktE+g0lAcXdYfxn6SWq/B1579TZdkj0pc0bgyRnqm1IMl5YLE2eCNwcqzI/B/Os9cdewdTRq2KvvkZQC2Wd2Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U+Ydp9ka; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U+Ydp9ka"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725520393; x=1757056393;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=7LNlhMFKGtFOttw11QtnX7UvMeTpjZskhNoGqPd2rs4=;
  b=U+Ydp9ka/6MHrfzeNqOAWBmZt/csZb9IG8gmN8G+QWEfuW5rWb1YfV8R
   6mcnrMcE2cyWk+8bHDONLEdR6cLgaKywr2VpN3IYfMOrSWvwa8EdprhLp
   VOz56JgvSVilTaI3gSBRe3XQRf8J4PeIRGY2ocp08YgBKorjQt6ZyXRSD
   +8j0Ne293xxyS14/H1E6Pnw9XXWd0fxixQEwBvqpIFR10KNtr1HMqa3VT
   tLLR/zqY23NR4FBP6/+twj/bhUtHeH82QsAc686zq3cRwtMPCBoOYO/Xo
   NHW84Fxb+UhJWjWTNuKa4YlfG8H4nAPbaevTCuc8YMrStBHOfr1HylBdJ
   w==;
X-CSE-ConnectionGUID: 7KtoEd28RFW+UrAYxRfzsg==
X-CSE-MsgGUID: 6bPZTkyUTpq4DUxpDsrnDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="23726289"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="23726289"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 00:13:11 -0700
X-CSE-ConnectionGUID: 7u4c+i+kRFuFZVYymSFYbA==
X-CSE-MsgGUID: lmoknqD7QfCJLQlnTYwNFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="96263382"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.96.163])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 00:13:06 -0700
Message-ID: <3c95c9d3-a46d-4ce5-b10c-c3261a94f9ee@intel.com>
Date: Thu, 5 Sep 2024 10:13:00 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/8] perf/core: Allow multiple AUX PMU events with the
 same module
To: Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20240823113306.2310957-1-leo.yan@arm.com>
 <20240823113306.2310957-2-leo.yan@arm.com>
 <70a58dca-01dc-408b-a2f7-a854718a405b@intel.com>
 <adfbd1ba-62ca-49c9-893a-3c10780ee186@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <adfbd1ba-62ca-49c9-893a-3c10780ee186@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/09/24 22:35, Leo Yan wrote:
> On 9/3/2024 11:06 AM, Adrian Hunter wrote:
>>> @@ -12345,9 +12345,16 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
>>>
>>>       /*
>>>        * If both events generate aux data, they must be on the same PMU
>>> +      * module but can be with different PMU instances.
>>> +      *
>>> +      * For a built-in PMU module, the 'pmu->module' pointer is NULL,
>>> +      * thus it is not feasible to compare the module pointers when
>>> +      * AUX PMU drivers are built into the kernel image. Instead,
>>> +      * comparing the .setup_aux() callback pointer can determine if
>>> +      * the two PMU events come from the same PMU driver.
>>>        */
>>>       if (has_aux(event) && has_aux(output_event) &&
>>> -         event->pmu != output_event->pmu)
>>> +         event->pmu->setup_aux != output_event->pmu->setup_aux)
>>
>> It is not very flexible and risks someone adding aux PMUs that
>> do not want that rule but accidentally support it.  Another
>> option is to add a PMU callback, but really you need to Peter's
>> feedback.
> 
> Thanks a lot for sharing opinion, Adrian!
> 
> How about below code? An alternative way is to compare the PMU's parent
> device driver, e.g. for Arm SPE PMU events, this can compare if two PMU
> events are using the Arm SPE driver.

IMHO, in the general case, whether 2 AUX area events can
output to the same buffer isn't really related to the device
hierarchy, driver or module.

> 
> /*
>  * If both events generate aux data, they must be on the same PMU
>  * module but can be with different PMU instances.
>  */
> if (has_aux(event) && has_aux(output_event)) {
>         /* It isn't allowed if it fails to find driver pointer */
>         if (!event->pmu->parent || !event->pmu->parent->driver)
>                 goto out;
> 
>         if (!output_event->pmu->parent || !output_event->pmu->parent->driver)
>                 goto out;
> 
>         /*
>          * It isn't allowed if aux events are not same type of PMU
>          * device. This is determined by comparing the associated
>          * driver pointers.
>          */
>         if (event->pmu->parent->driver != output_event->pmu->parent->driver)
>                 goto out;
> }
> 
> I verified the code above, it also works well at my side.
> 
> @Peter.Z, Please let me know if this is okay for you.
> 
> Thanks,
> Leo

