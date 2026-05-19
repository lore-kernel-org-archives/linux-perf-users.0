Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD603BFE21
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174728; cv=none; b=W476kDqEDGZpceN5EuwCT8n5rX3VqF15b+IJZ8QgtsJwvBoBdA+ldWL7/P1zmxcYZBo2lD7sNZZOf6Mm3Tg47HH0Caf4JQ6ZBNvD4sRZ4GSHSF6A9mabtU+ie0z0PsM4Lje6xhZi32TzNab3o7rvPU42POUA+DO1PR6Ru97hYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174728; c=relaxed/simple;
	bh=NioyVw3nWytLIZJ38e+tRTTVV3GGNRqa4I3VXameMpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VAfNfGHH9x6UUFM5EIw240bO1SxgjFSGZHFo5/M3AuYIfwpD+oD2EYYkP7qqigtxZA0ediVt0nHHwKlWFvtKhAwYO3vRQcvgP6Rj7zrC6lM+DzOPsFH/dTTOykWws5YQCK+b3ewkwsWKn6QzzhV5l6yvF7Ajcy/7piUXMkO172M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AWq9hKhh; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AWq9hKhh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779174724; x=1810710724;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NioyVw3nWytLIZJ38e+tRTTVV3GGNRqa4I3VXameMpo=;
  b=AWq9hKhh1EMNVdboH5L86eKydnjwczC2h5FZ8jShTXRzMRC81zce7rte
   jmUU00+mDKW8b8o/NEle44jwncZROEX+45lpW7a34hJYB1/4xHUmMVhel
   7cEmK8JerjuHVPnUmOipUUSHfh5ig+J2Ud2XBIEb/OqzupZEQNqgi+X+/
   kC//gf6X9PhR/q6blA07b5A45tsLhBWImils3bd1SRU0rS26radC/XAS7
   2LsQp0OABQFVuRz4aopC5Jzw/opyGKhyxZA8v2v6d1FW0yi1Li2XbqXLT
   FoWkIZcIEZJiUnPXKB1P9WqDWz0nihrE4efRLMpWHFpdyfMz4d9r70XBM
   A==;
X-CSE-ConnectionGUID: FLbAT88gRoOaB0NznYJ1HQ==
X-CSE-MsgGUID: T2UJCO49QqGDHj+M/utRkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="79186170"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="79186170"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 00:12:02 -0700
X-CSE-ConnectionGUID: Bdt0b/T5S8O3rpv7LCF4tw==
X-CSE-MsgGUID: OYE6s582RD2tpXpTM0f76g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="244679447"
Received: from unknown (HELO [10.238.3.164]) ([10.238.3.164])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 00:12:01 -0700
Message-ID: <cf56e302-2bfb-4632-b778-1c2a03786ef8@linux.intel.com>
Date: Tue, 19 May 2026 15:11:39 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] perf/x86/intel: Update event constraints and
 cache_extra_regs[] for ADL
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260515061143.338553-5-dapeng1.mi@linux.intel.com>
 <20260515063847.1B308C2BCB0@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260515063847.1B308C2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/15/2026 2:38 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The commit introduces a bisectability regression for MTL and ARL-U platforms by temporarily applying incorrect Alderlake-specific cache event structures.
> - [Low] Unnecessary duplication of the Golden Cove hardware cache event IDs array.
> --
>
> commit 58bdcbf21858fcf6337dcba2e5e091a86ddafd3c
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/intel: Update event constraints and cache_extra_regs[] for ADL
>     
> This commit updates the hard-coded event constraints and cache_extra_regs[]
> for Alderlake according to the latest ADL perfmon events. It introduces
> ADL-specific variants of structures and functions to reflect differences
> in L3/node related OCR events.
>
>> Please note these changes would temporarily impact other platforms like
>> MTL/ARL-U which shares hard-coded event structures, but it would be
>> fixed soon in subsequent patches.
> Does this introduce a bisectability regression for Meteorlake and Arrowlake-U
> platforms?
>
> Every commit needs to be self-contained and functionally correct to keep the
> tree bisectable. I noticed the fixes are included later in the series.
>
> Could the patch series be reorganized to avoid leaving any platform in a
> regressed state during bisection?

Hmm, it would not introduce a bisectability regression. The hard coded
cache event MSR value table are already inaccurate before this patch.
Although the changes would impact the MTL/ARL-U, but it doesn't introduce
new issues.


>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 0d0edc2d1b906..7948e3afc2916 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
> [ ... ]
>
>> @@ -713,6 +715,80 @@ static __initconst const u64 glc_hw_cache_event_ids
>>   },
>>  };
>>  
>> +/* ADL P-core (Golden cove) specific event code. */
>> +static __initconst const u64 adl_glc_hw_cache_event_ids
>> +				[PERF_COUNT_HW_CACHE_MAX]
>> +				[PERF_COUNT_HW_CACHE_OP_MAX]
>> +				[PERF_COUNT_HW_CACHE_RESULT_MAX] =
>> +{
>> + [ C(L1D ) ] = {
>> +	[ C(OP_READ) ] = {
>> +		[ C(RESULT_ACCESS) ] = 0x81d0,
>> +		[ C(RESULT_MISS)   ] = 0xe124,
>> +	},
>> +	[ C(OP_WRITE) ] = {
>> +		[ C(RESULT_ACCESS) ] = 0x82d0,
>> +	},
>> + },
> [ ... ]
>
>> + [ C(BPU ) ] = {
>> +	[ C(OP_READ) ] = {
>> +		[ C(RESULT_ACCESS) ] = 0x4c4,
>> +		[ C(RESULT_MISS)   ] = 0x4c5,
>> +	},
>> +	[ C(OP_WRITE) ] = {
>> +		[ C(RESULT_ACCESS) ] = -1,
>> +		[ C(RESULT_MISS)   ] = -1,
>> +	},
>> +	[ C(OP_PREFETCH) ] = {
>> +		[ C(RESULT_ACCESS) ] = -1,
>> +		[ C(RESULT_MISS)   ] = -1,
>> +	},
>> + },
>> +};
> This array appears to be identical to the existing glc_hw_cache_event_ids
> array, except that the C(NODE) entries are omitted and default to zero.
>
> Instead of duplicating the entire array and risking silent divergence when
> future updates are made, could we dynamically clear the C(NODE) entries for
> Alderlake during initialization?
>
> A similar pattern of localized overrides is already utilized in
> intel_pmu_init_grt() for the C(ITLB) event.

The new introduced adl_glc_hw_cache_event_ids[] table would be called by
multiple places, It looks clearer to define a new table instead of
overwriting the old table.

Thanks.


>
