Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E626115CD74
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2024 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933223; cv=none; b=SdWKdapWHQ7ZmEv4Eq4gxzUQxBFYjQYN/ImwMA1laLT565yU0M872sQz1xHqQc1ukE7FDZzd6WOI32oV1w2eeaP4IJf+hXFSTMOCTwsyjXUfvDgeS6rbHaVmRjd+fVz3cjhFZpXvbd6n3vPzlKSoYORvejVOZlVBNcM5XICUG+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933223; c=relaxed/simple;
	bh=xe5OY/9ZjVbsr7lFyy22dh5yAyFas67uxglVTKbHL3I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=TbMauxJvL/7qP3jw0fMljvF0w7sqvq/ZQPyXfoVvJF4X6+/az0ypMx0dAtrExOyd6l3wEsYawfrXvCTP+WBP8FeFjvjqytfoxkz6EuPC2vPkpKrRMJ0rITfyYBJBPcm8zbWW8KESOzjgIOr+2G9iuV6upzc7D2J/dTgdvlcWPwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vrei8Ots; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vrei8Ots"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733933222; x=1765469222;
  h=message-id:date:mime-version:subject:from:to:references:
   in-reply-to:content-transfer-encoding;
  bh=xe5OY/9ZjVbsr7lFyy22dh5yAyFas67uxglVTKbHL3I=;
  b=Vrei8OtsZYAyjowu4sFGsj83f8xZ9+uwLwZLuSLRlFhFPlMqUos9Pl1M
   hOixYGEJCcGuIaP7UJuZrkwDXV+f8+tMrhdd/RVet3PizypS6EGwSZZ/3
   XMdxRRGU3C1ja6DzVXC5ljWJg9o2+NxGbWOJH3nrMkm6/JNI9XbB8fSMc
   EKLQH1rEhgFe+SiDT8xeA/zWGUAVJdV7zOd3+PN7JoX9sI8AZN3NmTDWD
   3fmaBl3SyKikZ8Lr4nC/F9xuDVaVBoHwiTxY6RVvVGKnp2wj/BIXIshww
   mOjy6tL2vyddpLLI8EXIs3VvEo+tSmPgrI5Ky6BRRaFco2txCWEOxeW6T
   A==;
X-CSE-ConnectionGUID: rfOkhPLaSCSaAzPboEuLSw==
X-CSE-MsgGUID: 53ISvamRRDy6+lBwcvWh9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="44990966"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="44990966"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 08:06:59 -0800
X-CSE-ConnectionGUID: FQbpT7cmT8+E6EfeYFTZgA==
X-CSE-MsgGUID: 5dXttBtjT2OwCHt/b71UFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="100382209"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 08:06:53 -0800
Received: from [10.246.136.4] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 9043620B5703;
	Wed, 11 Dec 2024 08:06:52 -0800 (PST)
Message-ID: <71775d41-bf73-48e3-b5a6-6bce46658931@linux.intel.com>
Date: Wed, 11 Dec 2024 11:06:51 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Update perf tools topdown documentation
From: "Liang, Kan" <kan.liang@linux.intel.com>
To: James Clark <james.clark@linaro.org>, Andi Kleen <ak@linux.intel.com>,
 linux-perf-users@vger.kernel.org
References: <20241210193554.93013-1-ak@linux.intel.com>
 <01513f7b-390c-4e2e-a6e8-54c268e8acf2@linaro.org>
 <c1e008c4-d2c2-4088-aad2-a86987099c35@linux.intel.com>
Content-Language: en-US
In-Reply-To: <c1e008c4-d2c2-4088-aad2-a86987099c35@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-12-11 10:49 a.m., Liang, Kan wrote:
> 
> 
> On 2024-12-11 5:13 a.m., James Clark wrote:
>>
>>
>> On 10/12/2024 7:35 pm, Andi Kleen wrote:
>>> - Document and give examples for the Lunar Lake perf metrics reset mode.
>>> - Fix the error handling for mmap (it returns -1 on error, not 0)
>>> - Clarify the slots placement documentation. It is not Icelake specific
>>> and also applies for non sampling.
>>>
>>> Signed-off-by: Andi Kleen <ak@linux.intel.com>
>>> ---
>>>   tools/perf/Documentation/topdown.txt | 33 +++++++++++++++++++++++-----
>>>   1 file changed, 28 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/tools/perf/Documentation/topdown.txt b/tools/perf/
>>> Documentation/topdown.txt
>>> index 5c17fff694ee..3e2340f3f78e 100644
>>> --- a/tools/perf/Documentation/topdown.txt
>>> +++ b/tools/perf/Documentation/topdown.txt
>>> @@ -87,7 +87,7 @@ if (slots_fd < 0)
>>>     /* Memory mapping the fd permits _rdpmc calls from userspace */
>>>   void *slots_p = mmap(0, getpagesize(), PROT_READ, MAP_SHARED,
>>> slots_fd, 0);
>>> -if (!slot_p)
>>> +if (slot_p == (void*)-1L)
>>>       .... error ...
>>>     /*
>>> @@ -107,7 +107,7 @@ if (metrics_fd < 0)
>>>     /* Memory mapping the fd permits _rdpmc calls from userspace */
>>>   void *metrics_p = mmap(0, getpagesize(), PROT_READ, MAP_SHARED,
>>> metrics_fd, 0);
>>> -if (!metrics_p)
>>> +if (metrics_p == (void*)-1L)
>>>       ... error ...
>>>     Note: the file descriptors returned by the perf_event_open calls
>>> must be memory
>>> @@ -290,15 +290,38 @@ This "opens" a new measurement period.
>>>   A program using RDPMC for TopDown should schedule such a reset
>>>   regularly, as in every few seconds.
>>>   -Limits on Intel Ice Lake
>>> -========================
>>> +Newer Intel CPUs (Lunar Lake, Arrow Lake+) support resetting the perf
>>> +metrics automatically RDPMC, which can avoid a system call or needing
>>
>> Minor nit: "automatically using RDPMC"?
> 
> The RDPMC can automatically reset the perf metrics.
> Maybe change it to "automatically resetting the perf metrics RDPMC"
> 

The new post can be found at
https://lore.kernel.org/lkml/20241211160318.235056-2-kan.liang@linux.intel.com/

I also added the reviewed-by in the new patch.

Please let me know if there are more comments.

Thanks,
Kan

> Thanks,
> Kan
>>
>> Reviewed-by: James Clark <james.clark@linaro.org>
>>>> +to schedule special resets.
>>> +
>>> +This is available if /sys/devices/cpu*/cap/metrics_clear
>>> +exists, and requires setting an opt-in bit when opening the
>>> +slots counter:
>>> +
>>> +if (access("/sys/devices/cpu/cap/metrics_clear") &&
>>> +    access("/sys/devices/cpu_core/cap/metrics_clear"))
>>> +     ... functionality not supported ...
>>> +
>>> +#define INTEL_TD_CFG_METRIC_CLEAR 1ULL
>>> +
>>> +struct perf_event_attr slots_event = {
>>> +    ... same as slots example above ...
>>> +    .config1 = INTEL_TD_CFG_METRIC_CLEAR,
>>> +};
>>> +
>>> +... open and map counter same as example above ...
>>> +
>>> +Then any metric read will reset the metrics and slots.
>>> +
>>> +Using perf metrics with perf stat
>>> +=================================
>>>     Four pseudo TopDown metric events are exposed for the end-users,
>>>   topdown-retiring, topdown-bad-spec, topdown-fe-bound and topdown-be-
>>> bound.
>>>   They can be used to collect the TopDown value under the following
>>>   rules:
>>>   - All the TopDown metric events must be in a group with the SLOTS
>>> event.
>>> -- The SLOTS event must be the leader of the group.
>>> +- The SLOTS event must be the first entry of the group.
>>>   - The PERF_FORMAT_GROUP flag must be applied for each TopDown metric
>>>     events
>>>   
>>
>>
> 
> 

