Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAF113B293
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 01:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809755; cv=none; b=i58VyS//HdcUZ37PfmZIvGG3NmeRUAnYxum/ggGckjWiEyJILCNoY73xne8KFOoJbfHxW/9hbuqcBXDDQOJ3rBFKJsqN9UBbbD9C/9CGQoxYjrLqJoEwY5e1VAZqPb3kHW7WKvldsqaxVb83JM2mclElDMuHqlpNTv9+wftYtRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809755; c=relaxed/simple;
	bh=859jxnNacsWW86iVWEeda0G442DHiR3l2meAN16pUo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JEVBVZNcULFu+SnQ9Vw2AOnaB34rrIoYpdUKpcKba9PsGUFDCGJoF7r4ykGayCVmFZNtSvrtvfOTBHLjSe7XaqeFWCtbEnsgLkWTXR03ZAiOYNlCTouA1uhxrSbjC6BcO/pSqBpxB5/lqMVvsPK4MPiERtYBHtzRCN2gQSWNf78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7gSPbo3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7gSPbo3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778809754; x=1810345754;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=859jxnNacsWW86iVWEeda0G442DHiR3l2meAN16pUo8=;
  b=K7gSPbo3HOhOtRs0AaMVpsx8iGr8DsLDyortaETgCRY5kt2kf6/3I2Cc
   afuGrCc9EHnOt7lRIDRyI/LG3MH2UqwROPHR/rUHBi2YE+9s5eearFhSK
   2L4ar7qjLrYZLO6s64+r+heKJjMEFYD49u1x4eVwpUTHEmMyPdqDWDC7w
   n/cXaV8EYowI9qqWc59LYZQe/Zk6nwUtCdTYq4Pwv+N/a6LKDtF5L2qa/
   5pqeluG4HQYYZ56qUuuFjeVOEh9qBafxwblnQQqlF7aaotjvCwWmMAUOK
   RtH/KY62aGlpvkgJcY2smSLPOUbBZkvyu53XYw3+Qil/Al2EfX82RVfYk
   Q==;
X-CSE-ConnectionGUID: N42EWd/7Rnij/FDCzBdZaQ==
X-CSE-MsgGUID: gnxaVxxXTTWyF867R1/62Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="78787693"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="78787693"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 18:49:13 -0700
X-CSE-ConnectionGUID: R/8MXpBdR1S0SoCPRxe2Zw==
X-CSE-MsgGUID: AeR+tu4BRrK1t561oUYBTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="240363056"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 18:49:12 -0700
Message-ID: <02461927-589b-4179-9f93-2f9e10172879@linux.intel.com>
Date: Fri, 15 May 2026 09:49:10 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] perf/x86/intel: Ensure guest PEBS path doesn't set
 unwanted PERF_GLOBAL_CTRL bits
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko@lists.linux.dev, linux-perf-users@vger.kernel.org
References: <20260508231353.406465-2-seanjc@google.com>
 <20260508234018.F06AEC2BCB0@smtp.kernel.org>
 <ccea937f-8ad5-4a6e-b6a4-917f2ee02579@linux.intel.com>
 <agZiTeGgRO4PJ9mI@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <agZiTeGgRO4PJ9mI@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/15/2026 8:01 AM, Sean Christopherson wrote:
> On Tue, May 12, 2026, Dapeng Mi wrote:
>> On 5/9/2026 7:40 AM, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>> - [High] The host PEBS collision check fails to mask non-counter bits, incorrectly disabling guest PEBS for events like Store Latency.
>>> --
>>>
>>> Note: The format of this report has been altered due to recitation
>>> restrictions. The original patch code is not quoted directly, and findings are
>>> provided as a free-form summary.
>>>
>>> commit 39adc53b360e88595a3be6fc59b18b048d9e9921
>>> Author: Sean Christopherson <seanjc@google.com>
>>>
>>> perf/x86/intel: Ensure guest PEBS path doesn't set unwanted PERF_GLOBAL_CTRL bits
>>>
>>> This commit masks the pebs counter values being reinstated into the global
>>> control msr for a guest with perf's desired value. This is done to ensure the
>>> hypervisor doesn't unintentionally enable counters.
>>>
>>> In intel_guest_get_msrs(), the host pebs collision check evaluates the host
>>> field of the pebs_enable array entry to determine if the host is actively
>>> using pebs. If it is, guest pebs is disabled.
>>>
>>> Is it possible for this check to falsely detect a host collision due to
>>> non-counter bits being set?
>>>
>>> When a guest configures a store latency pebs event, a backing perf event is
>>> created. In intel_pmu_pebs_enable(), this sets both the counter index bit
>>> and bit 63 in cpuc->pebs_enabled.
>>>
>>> Because the host field is calculated as cpuc->pebs_enabled masked against
>>> the inverse of cpuc->intel_ctrl_guest_mask, and the guest mask exclusively
>>> tracks valid counter indices (never including bit 63), bit 63 remains set in
>>> the host field.
>>>
>>> Consequently, the check for whether the host is actively using pebs will
>>> evaluate to true even when only the guest is using pebs. This introduces a
>>> regression where guest pebs is completely disabled, silently breaking guest
>>> store latency events.
>>>
>>> Should the host pebs usage evaluation also be masked by intel_ctrl to prevent
>>> non-counter bits from triggering a false collision?
>> Hmm, I suspect if the issue could happen on real hardwares.  
> OMG, it took me _so_ long to understand what Sashiko was complaining about.  I'm
> pretty sure I read Sashiko's response like four times, and it didn't click until
> I read your response.
>
> In case anyone is feeling as dense as me, Sashiko is saying this:
>
> 	/*
> 	 * FIXME: Allow guest and host usage of PEBS events to co-exist instead
> 	 *        of disabling guest PEBS entirely if the host is using PEBS.
> 	 *        What exactly goes wrong if guest and host are using PEBS is
> 	 *        unknown.
> 	 */
> 	if (pebs_mask & ~cpuc->intel_ctrl_exclude_host_mask)
> 		guest_pebs_mask = 0;
>
> should probably be masked by intel_ctrl as well.

Yes, the comment of Sashiko is some kind of misleading. Strictly speaking,
the comment should be made for the next patch 2/9 instead of this patch.


>
>> The function intel_pmu_pebs_enable() indeed sets extra bits into
>> cpuc->pebs_enabled for load latency and specific store events, like below
>> code shows.
>>
>> ```
>>
>> ......
>>
>>     if ((event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT) && (x86_pmu.version < 5))
>>         cpuc->pebs_enabled |= 1ULL << (hwc->idx + 32);
>>     else if (event->hw.flags & PERF_X86_EVENT_PEBS_ST)
>>         cpuc->pebs_enabled |= 1ULL << 63;
>>
>> ......
>>
>> ```
>>
>> But these 2 cases should only be hit on quite old platforms (prior to
>> Icelake). On these platforms, only GP counters support PEBS sampling and
>> pebs_capable would be set PEBS_COUNTER_MASK, and so these extra bits would
>> be filtered out by the pebs_capable and pebs_mask won't really contain
>> these extra bits. 
> Thanks for digging into this!  I was staring and just going "huh!?" over and over
> in my head :-)

:)


>
>> Anyway, we could optimize the code further like below and thoroughly filter
>> away these extra bits. (only building, not test on real HW)
> Hmm, I think I'd rather figure out what it would take to drop the FIXME entirely.
> And if we need to keep the check, I'm a-ok risking false positives until we have
> a better understanding of why the check exists.

Kan Liang should be the best man who knows the history, but he has left
Intel. I would check this with other guys internally and look at if they
know the reason.

Thanks.


>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 854881b5e696..6eee7636a822 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -4997,7 +4997,7 @@ static struct perf_guest_switch_msr
>> *intel_guest_get_msrs(int *nr,
>>         struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>         struct perf_guest_switch_msr *arr = cpuc->guest_switch_msrs;
>>         u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
>> -       u64 pebs_mask = cpuc->pebs_enabled & x86_pmu.pebs_capable;
>> +       u64 pebs_mask = cpuc->pebs_enabled & x86_pmu.pebs_capable & intel_ctrl;
>>         u64 guest_pebs_mask;
>>         int global_ctrl;
>>
>> @@ -5049,7 +5049,7 @@ static struct perf_guest_switch_msr
>> *intel_guest_get_msrs(int *nr,
>>          * the guest wants to use for PEBS, (c) are not excluded from counting
>>          * in the guest, and (d) _are_ excluded from counting in the host.
>>          */
>> -       guest_pebs_mask = pebs_mask & intel_ctrl & guest_pebs->enable &
>> +       guest_pebs_mask = pebs_mask & guest_pebs->enable &
>>                           ~cpuc->intel_ctrl_exclude_guest_mask &
>>                           cpuc->intel_ctrl_exclude_host_mask;
>>
