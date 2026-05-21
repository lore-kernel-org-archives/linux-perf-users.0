Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18573B5F48
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779362981; cv=none; b=lDreMv4H2FaxTU41yEcCbJ/Vb9DNlpgc/cWh85JIFsgad9Kjr4zKTwvHc44XgKYMHIZEp38Q+7hMI2P/X9xEU7EkD0+yV6Dvbt87Z5ivgiNh1to3dE6CU/cQqyqklyHtd/t393fbqPsuS9a/ExQhKTRCHhqzpjOXZ0qKpQRyMxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779362981; c=relaxed/simple;
	bh=KO81wUmQWVMyP47zhIoYPSJNHBMRcrbI7hmqneZ4D2k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MPLJXnfrW63wYSYSZwncLHxzSqdmPVIEtgAzBvUEAyGHcapDCwXJRsuXFDtbRKY2/vyTeQl/awoc5kx9vTR5+oR5gkAfTfVwnK1Tw5VcJaiW+mH/NtBpVWDvPBdt3jDkj+LahlwtLo5sb2IPlBPwpBxmt66PbbC9tkd9BXEX6ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bEFx7RCq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bEFx7RCq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779362980; x=1810898980;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=KO81wUmQWVMyP47zhIoYPSJNHBMRcrbI7hmqneZ4D2k=;
  b=bEFx7RCqmisZnzhrHupPkbeX/obbr1otR3KFZPguIXEOh9QeMteCzJjf
   hsD4I3w/cO2xW4R2LQBthoW8lsShMdLvTK+PZ8jwLd9eiZZtrR7dTkmGo
   upaBQBXGkCDQo93ky/AP2dNiHFNvOcicHiEsuhqM8WsJazJf92xbCklYn
   sEVC3fO9HO7OrWXGudVHo8t0/AeovEhUESHnxeZQIv4csUkCikY8ujaOu
   2i1iypTNCnQaKYklycmRvMEoSzQV5Tadcdn7n6/dWlCDM76RsgTGdcE/o
   xamhFR8edUGr/WTjsBfDFazB49V6nkqY5EDsHaRzQHxrwu/j7kFUP95h+
   g==;
X-CSE-ConnectionGUID: nKpqZUO8SFyXnYJExk6Akw==
X-CSE-MsgGUID: NQrMIMrfRGqpvOy5DpyruQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="90853073"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="90853073"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 04:29:39 -0700
X-CSE-ConnectionGUID: QqlXOKBTRfeIO3qvY/QYxQ==
X-CSE-MsgGUID: UT9xbuOESDKc8lJe+EOlcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="244788747"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 04:29:38 -0700
Message-ID: <a75397bd-6122-4fa8-8197-334b2fbbb5af@linux.intel.com>
Date: Thu, 21 May 2026 19:29:35 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] perf/x86/intel: Ensure guest PEBS path doesn't set
 unwanted PERF_GLOBAL_CTRL bits
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko@lists.linux.dev, linux-perf-users@vger.kernel.org
References: <20260508231353.406465-2-seanjc@google.com>
 <20260508234018.F06AEC2BCB0@smtp.kernel.org>
 <ccea937f-8ad5-4a6e-b6a4-917f2ee02579@linux.intel.com>
 <agZiTeGgRO4PJ9mI@google.com>
 <02461927-589b-4179-9f93-2f9e10172879@linux.intel.com>
Content-Language: en-US
In-Reply-To: <02461927-589b-4179-9f93-2f9e10172879@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/15/2026 9:49 AM, Mi, Dapeng wrote:
> On 5/15/2026 8:01 AM, Sean Christopherson wrote:
>> On Tue, May 12, 2026, Dapeng Mi wrote:
>>> On 5/9/2026 7:40 AM, sashiko-bot@kernel.org wrote:
>>>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>>> - [High] The host PEBS collision check fails to mask non-counter bits, incorrectly disabling guest PEBS for events like Store Latency.
>>>> --
>>>>
>>>> Note: The format of this report has been altered due to recitation
>>>> restrictions. The original patch code is not quoted directly, and findings are
>>>> provided as a free-form summary.
>>>>
>>>> commit 39adc53b360e88595a3be6fc59b18b048d9e9921
>>>> Author: Sean Christopherson <seanjc@google.com>
>>>>
>>>> perf/x86/intel: Ensure guest PEBS path doesn't set unwanted PERF_GLOBAL_CTRL bits
>>>>
>>>> This commit masks the pebs counter values being reinstated into the global
>>>> control msr for a guest with perf's desired value. This is done to ensure the
>>>> hypervisor doesn't unintentionally enable counters.
>>>>
>>>> In intel_guest_get_msrs(), the host pebs collision check evaluates the host
>>>> field of the pebs_enable array entry to determine if the host is actively
>>>> using pebs. If it is, guest pebs is disabled.
>>>>
>>>> Is it possible for this check to falsely detect a host collision due to
>>>> non-counter bits being set?
>>>>
>>>> When a guest configures a store latency pebs event, a backing perf event is
>>>> created. In intel_pmu_pebs_enable(), this sets both the counter index bit
>>>> and bit 63 in cpuc->pebs_enabled.
>>>>
>>>> Because the host field is calculated as cpuc->pebs_enabled masked against
>>>> the inverse of cpuc->intel_ctrl_guest_mask, and the guest mask exclusively
>>>> tracks valid counter indices (never including bit 63), bit 63 remains set in
>>>> the host field.
>>>>
>>>> Consequently, the check for whether the host is actively using pebs will
>>>> evaluate to true even when only the guest is using pebs. This introduces a
>>>> regression where guest pebs is completely disabled, silently breaking guest
>>>> store latency events.
>>>>
>>>> Should the host pebs usage evaluation also be masked by intel_ctrl to prevent
>>>> non-counter bits from triggering a false collision?
>>> Hmm, I suspect if the issue could happen on real hardwares.  
>> OMG, it took me _so_ long to understand what Sashiko was complaining about.  I'm
>> pretty sure I read Sashiko's response like four times, and it didn't click until
>> I read your response.
>>
>> In case anyone is feeling as dense as me, Sashiko is saying this:
>>
>> 	/*
>> 	 * FIXME: Allow guest and host usage of PEBS events to co-exist instead
>> 	 *        of disabling guest PEBS entirely if the host is using PEBS.
>> 	 *        What exactly goes wrong if guest and host are using PEBS is
>> 	 *        unknown.
>> 	 */
>> 	if (pebs_mask & ~cpuc->intel_ctrl_exclude_host_mask)
>> 		guest_pebs_mask = 0;
>>
>> should probably be masked by intel_ctrl as well.
> Yes, the comment of Sashiko is some kind of misleading. Strictly speaking,
> the comment should be made for the next patch 2/9 instead of this patch.
>
>
>>> The function intel_pmu_pebs_enable() indeed sets extra bits into
>>> cpuc->pebs_enabled for load latency and specific store events, like below
>>> code shows.
>>>
>>> ```
>>>
>>> ......
>>>
>>>     if ((event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT) && (x86_pmu.version < 5))
>>>         cpuc->pebs_enabled |= 1ULL << (hwc->idx + 32);
>>>     else if (event->hw.flags & PERF_X86_EVENT_PEBS_ST)
>>>         cpuc->pebs_enabled |= 1ULL << 63;
>>>
>>> ......
>>>
>>> ```
>>>
>>> But these 2 cases should only be hit on quite old platforms (prior to
>>> Icelake). On these platforms, only GP counters support PEBS sampling and
>>> pebs_capable would be set PEBS_COUNTER_MASK, and so these extra bits would
>>> be filtered out by the pebs_capable and pebs_mask won't really contain
>>> these extra bits. 
>> Thanks for digging into this!  I was staring and just going "huh!?" over and over
>> in my head :-)
> :)
>
>
>>> Anyway, we could optimize the code further like below and thoroughly filter
>>> away these extra bits. (only building, not test on real HW)
>> Hmm, I think I'd rather figure out what it would take to drop the FIXME entirely.
>> And if we need to keep the check, I'm a-ok risking false positives until we have
>> a better understanding of why the check exists.
> Kan Liang should be the best man who knows the history, but he has left
> Intel. I would check this with other guys internally and look at if they
> know the reason.

Just checked the commit history, It looks the reason of disabling guest
PEBS here is to avoid breaking the host !exclude_guest PEBS event sampling.
Host may create !exclude_guest event to profile both root and non-root
mode, but it's conflicted with guest PEBS sampling in non-root mode. So
guest PEBS sampling has to be disabled if there are active host PEBS
events. Thanks.


>
> Thanks.
>
>
>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>> index 854881b5e696..6eee7636a822 100644
>>> --- a/arch/x86/events/intel/core.c
>>> +++ b/arch/x86/events/intel/core.c
>>> @@ -4997,7 +4997,7 @@ static struct perf_guest_switch_msr
>>> *intel_guest_get_msrs(int *nr,
>>>         struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>>         struct perf_guest_switch_msr *arr = cpuc->guest_switch_msrs;
>>>         u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
>>> -       u64 pebs_mask = cpuc->pebs_enabled & x86_pmu.pebs_capable;
>>> +       u64 pebs_mask = cpuc->pebs_enabled & x86_pmu.pebs_capable & intel_ctrl;
>>>         u64 guest_pebs_mask;
>>>         int global_ctrl;
>>>
>>> @@ -5049,7 +5049,7 @@ static struct perf_guest_switch_msr
>>> *intel_guest_get_msrs(int *nr,
>>>          * the guest wants to use for PEBS, (c) are not excluded from counting
>>>          * in the guest, and (d) _are_ excluded from counting in the host.
>>>          */
>>> -       guest_pebs_mask = pebs_mask & intel_ctrl & guest_pebs->enable &
>>> +       guest_pebs_mask = pebs_mask & guest_pebs->enable &
>>>                           ~cpuc->intel_ctrl_exclude_guest_mask &
>>>                           cpuc->intel_ctrl_exclude_host_mask;
>>>
