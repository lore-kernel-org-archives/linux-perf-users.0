Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA6D2BE7AB
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Apr 2026 06:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777530812; cv=none; b=Rs4PaBUQq6ZNO/LtW6qH62dpXGvnyiVzVyIjvb+fuXpA/KPNxEFumaFHs70EfMNbQXH8DivLbeK3czS+rUYgKoBk6/9ZTvlvA6exNygPkjLMz+wzc0c5QDy91w6HE3rrEYg+L1dL6EJRQaC+FUJNgTEKWD28op9anVVIuXu2j4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777530812; c=relaxed/simple;
	bh=sDpmAsvNqvSmAgGNpriWcHiHSu8IdvNaeqsC4Im+dus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1n2f0P2PBnunDOetnXMM3xfQpIjhlVNJpE5jvfQ2p2PEgkkiKnVA5c2qbVZcOWRc22xks++s/eSYrU4dI1mMxemcg1L4za5cJY0Tvp3OCC39hDSdalVT+F0UIWx36uBrylY5iZKks9mwC2W97BJSZ2HZxchrFdJa5PseC85NzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/PILmAe; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/PILmAe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777530810; x=1809066810;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sDpmAsvNqvSmAgGNpriWcHiHSu8IdvNaeqsC4Im+dus=;
  b=a/PILmAe7ca5/4MU4zscx31RPzMicHv26/3Dbgrm3OD2/5xTQ3tAv1Tz
   cjgx/p4a3+TTMazNuewKXn3s3SxhKBL15MoLAAnDFo32RPPh/nzX2fgql
   3cwgukgNWhGFj7OrK2fazLGh4iov20njaYN8KNP+tysKQSQfR7VTtIF0H
   MPAWSfWnS1CTBRAX+uth2Cqt/bNXT3sW+iwAx724c5tr1xGiW879Dbh0K
   nGSKEvgQL4Xk8EGZdlOw3ToY4/PnJeNp7zIeIHxGmu2UWCjVI21zQe6LG
   IhForArWZfo85IyC1d3hRLt/fWFiZ3phCxkEAhdzKRaBdRJXcxVJ5ezph
   A==;
X-CSE-ConnectionGUID: S4HMcIfISJqzq8MMxCS0VQ==
X-CSE-MsgGUID: eNTJYrF9Q5yTmePFSvXobg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="95894010"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="95894010"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 23:33:30 -0700
X-CSE-ConnectionGUID: XUq8BrW+TPOw/JbI4X/s6w==
X-CSE-MsgGUID: Os2bmA49TMq2CcG/3X0Pqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="236257797"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 23:33:29 -0700
Message-ID: <ceeae017-1fb7-4290-9df2-27d45b6de750@linux.intel.com>
Date: Thu, 30 Apr 2026 14:33:26 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 3/5] perf/x86/intel: Disable PMI for self-reloaded ACR
 events
To: sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260430002558.712334-4-dapeng1.mi@linux.intel.com>
 <20260430023637.37B6AC19425@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260430023637.37B6AC19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/30/2026 10:36 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Event PMIs can be permanently disabled due to a stale `hw.config1` state when an ACR group is broken up.
> --
>
> commit cfc30b699ff51679e8ae587b226916cfd6fbe7bc
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/intel: Disable PMI for self-reloaded ACR events
>
> This commit disables Performance Monitoring Interrupts (PMI) for all events
> configured with Auto Counter Reload (ACR) self-reload to prevent spurious
> "unknown reason" NMI warnings.
>
> [ ... ]
>
>> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
>> index fad87d3c8b2c..524668dcf4cc 100644
>> --- a/arch/x86/events/perf_event.h
>> +++ b/arch/x86/events/perf_event.h
>> @@ -137,6 +137,16 @@ static inline bool is_acr_event_group(struct perf_event *event)
>>  	return check_leader_group(event->group_leader, PERF_X86_EVENT_ACR);
>>  }
>>  
>> +static inline bool is_acr_self_reload_event(struct perf_event *event)
>> +{
>> +	struct hw_perf_event *hwc = &event->hw;
>> +
>> +	if (hwc->idx < 0)
>> +		return false;
>> +
>> +	return test_bit(hwc->idx, (unsigned long *)&hwc->config1);
>> +}
> Can this cause PMIs to be permanently disabled if an ACR group is broken up?
>
> If the original group leader is closed, perf_group_detach() promotes the
> siblings to standalone events, making them their own leaders. These new
> standalone events no longer have the PERF_X86_EVENT_ACR flag (as it was only
> set on the original leader).
>
> Because they lack the flag, intel_pmu_acr_late_setup() skips them, and
> their hw.config1 field retains the stale physical counter bitmask from when
> they were in the ACR group.
>
> Since is_acr_self_reload_event() checks hw.config1 without validating if the
> event is still in an ACR group via is_acr_event_group(), could a detached
> event that gets assigned to a counter matching the stale bitmask incorrectly
> return true here?
>
> This would cause intel_pmu_enable_event() to incorrectly clear the
> ARCH_PERFMON_EVENTSEL_INT bit, breaking PMI generation and sampling for a
> now-normal event.

I'm not sure if the issue could really happen in reality. If the group
leader is disabled (I'm not fully understand the what does the "closed"
mean, I suppose it means disable), all ACR events would be disabled as well.

But it's fine to add a sanity check whether the event is an ACR event in
the is_acr_self_reload_event().

Thanks.


>
>>  struct amd_nb {
>>  	int nb_id;  /* NorthBridge id */
>>  	int refcnt; /* reference count */
