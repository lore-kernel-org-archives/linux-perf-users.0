Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFAB1CB9E2
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2024 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932161; cv=none; b=ZzYF8aaO+DKZsBi0GE48EeqTiACQwlV6l6El+Bi6GmT/1UpNzp9L5EsZRdqVcbTS1iW8XouulGWIkPGekTYaQaRZOLmhWjVZsS3SpOOUR3VhdcVgN8QY7j5KwVefQXmE8sISkJjszVTVlPUH3F8FCb5DwBW5FrjbxjylzqdU42A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932161; c=relaxed/simple;
	bh=EYg2Af2GvUzYsF0sPh/X9kaU8o7ArZXiPlD9JAsGy8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jcD8onpHNTnBVwRZm4eZWGdYy8sNyRA/H7uTb/hyt5RWUO2l2jgevpdZfMbYG/64fuErA9qrNdBULx3zmG2OXBH6uGo1FFjiWXe/AW/ph5AsYn83LfHWxyjaDVft+ZOIqcfjIwuNS6CDSLjxKplWIbAAf33YEVQNS5UssfmYpLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CK6zGF10; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CK6zGF10"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733932160; x=1765468160;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=EYg2Af2GvUzYsF0sPh/X9kaU8o7ArZXiPlD9JAsGy8U=;
  b=CK6zGF108Wgh2h52Sx8XPti2a4LmNh908aoCtHAGBSwq39Rjrc7ycEHA
   jLP+7MTlUma98OPVzkM1M+eFDfFBYIaqYKPo3Sr9Ew0r91faS6bwVKI6c
   WYeTJy0Jb/F/NjooqeNqyveofWemPJA5LRzO+8rhnK/VRTVe9l+f/Uf0c
   83tjeaT+QJEDV5EiJTHnOAmIz8SXwZGG5hXMBioQg5KX83CuzwazZyWGj
   +yCH4D2PR/9hr82uRm5Ho5P/NXdLIJm6qHgcw8XShw6APiqpIgewbDPY7
   2CPOYMpJxZkYQPFW+z709iGj+nJvfcQ+fIod455EPfif878JJnorhdwGz
   w==;
X-CSE-ConnectionGUID: wDO33MZ7Sf6agrEvJtZYiA==
X-CSE-MsgGUID: cSwtm2v8Rji3ZzSS4VpVTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34045754"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="34045754"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 07:49:19 -0800
X-CSE-ConnectionGUID: VY/GvoPZSaqJ2KO1zbiS9Q==
X-CSE-MsgGUID: 7QEsA6NGTna+8hcfXa7bgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="99951507"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 07:49:19 -0800
Received: from [10.246.136.4] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 6FF3220B5703;
	Wed, 11 Dec 2024 07:49:18 -0800 (PST)
Message-ID: <c1e008c4-d2c2-4088-aad2-a86987099c35@linux.intel.com>
Date: Wed, 11 Dec 2024 10:49:17 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Update perf tools topdown documentation
To: James Clark <james.clark@linaro.org>, Andi Kleen <ak@linux.intel.com>,
 linux-perf-users@vger.kernel.org
References: <20241210193554.93013-1-ak@linux.intel.com>
 <01513f7b-390c-4e2e-a6e8-54c268e8acf2@linaro.org>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <01513f7b-390c-4e2e-a6e8-54c268e8acf2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-12-11 5:13 a.m., James Clark wrote:
> 
> 
> On 10/12/2024 7:35 pm, Andi Kleen wrote:
>> - Document and give examples for the Lunar Lake perf metrics reset mode.
>> - Fix the error handling for mmap (it returns -1 on error, not 0)
>> - Clarify the slots placement documentation. It is not Icelake specific
>> and also applies for non sampling.
>>
>> Signed-off-by: Andi Kleen <ak@linux.intel.com>
>> ---
>>   tools/perf/Documentation/topdown.txt | 33 +++++++++++++++++++++++-----
>>   1 file changed, 28 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/topdown.txt b/tools/perf/
>> Documentation/topdown.txt
>> index 5c17fff694ee..3e2340f3f78e 100644
>> --- a/tools/perf/Documentation/topdown.txt
>> +++ b/tools/perf/Documentation/topdown.txt
>> @@ -87,7 +87,7 @@ if (slots_fd < 0)
>>     /* Memory mapping the fd permits _rdpmc calls from userspace */
>>   void *slots_p = mmap(0, getpagesize(), PROT_READ, MAP_SHARED,
>> slots_fd, 0);
>> -if (!slot_p)
>> +if (slot_p == (void*)-1L)
>>       .... error ...
>>     /*
>> @@ -107,7 +107,7 @@ if (metrics_fd < 0)
>>     /* Memory mapping the fd permits _rdpmc calls from userspace */
>>   void *metrics_p = mmap(0, getpagesize(), PROT_READ, MAP_SHARED,
>> metrics_fd, 0);
>> -if (!metrics_p)
>> +if (metrics_p == (void*)-1L)
>>       ... error ...
>>     Note: the file descriptors returned by the perf_event_open calls
>> must be memory
>> @@ -290,15 +290,38 @@ This "opens" a new measurement period.
>>   A program using RDPMC for TopDown should schedule such a reset
>>   regularly, as in every few seconds.
>>   -Limits on Intel Ice Lake
>> -========================
>> +Newer Intel CPUs (Lunar Lake, Arrow Lake+) support resetting the perf
>> +metrics automatically RDPMC, which can avoid a system call or needing
> 
> Minor nit: "automatically using RDPMC"?

The RDPMC can automatically reset the perf metrics.
Maybe change it to "automatically resetting the perf metrics RDPMC"

Thanks,
Kan
> 
> Reviewed-by: James Clark <james.clark@linaro.org>
> >> +to schedule special resets.
>> +
>> +This is available if /sys/devices/cpu*/cap/metrics_clear
>> +exists, and requires setting an opt-in bit when opening the
>> +slots counter:
>> +
>> +if (access("/sys/devices/cpu/cap/metrics_clear") &&
>> +    access("/sys/devices/cpu_core/cap/metrics_clear"))
>> +     ... functionality not supported ...
>> +
>> +#define INTEL_TD_CFG_METRIC_CLEAR 1ULL
>> +
>> +struct perf_event_attr slots_event = {
>> +    ... same as slots example above ...
>> +    .config1 = INTEL_TD_CFG_METRIC_CLEAR,
>> +};
>> +
>> +... open and map counter same as example above ...
>> +
>> +Then any metric read will reset the metrics and slots.
>> +
>> +Using perf metrics with perf stat
>> +=================================
>>     Four pseudo TopDown metric events are exposed for the end-users,
>>   topdown-retiring, topdown-bad-spec, topdown-fe-bound and topdown-be-
>> bound.
>>   They can be used to collect the TopDown value under the following
>>   rules:
>>   - All the TopDown metric events must be in a group with the SLOTS
>> event.
>> -- The SLOTS event must be the leader of the group.
>> +- The SLOTS event must be the first entry of the group.
>>   - The PERF_FORMAT_GROUP flag must be applied for each TopDown metric
>>     events
>>   
> 
> 

