Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1A21FBCB5;
	Fri,  3 Jan 2025 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735920932; cv=none; b=Xp/BaOXgJrzCG4x5loj+DcrQnCKMmsAJc7Dp7y/ugKgwE77qfcNNG8J+7cdwCSEEihgViJ1SeSe/HSzcLqMg7Mu0gRGzo2R1Iz/HfldhcpWV6w8+cJmTjHDBhbBEaN9ZF/aq8sxdyLBWkLb3cUcH+SaVDu32USpwXZwkTl2eSQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735920932; c=relaxed/simple;
	bh=GVe37z/JcTqiYqP9DG+ieaVOSmdbdYuDfynP4+renwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYrTCem3XaK5EWci/w0Ifvvvex8ONZds/tnXM8k/tilBJ9kpnI2cLH18LVkTL+mtaaBOTZhOrFTk6MCV7Vif3riPHX5vf4JLNuU0GZ3OnpyoW/6nwPNs1VnmTyCAVi4cZUQO8aba8YXfkA9yMElfU4SOGGh7Izs2o1Bfk41KI2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mKCHMS29; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mKCHMS29"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735920931; x=1767456931;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GVe37z/JcTqiYqP9DG+ieaVOSmdbdYuDfynP4+renwg=;
  b=mKCHMS291z5WHKBn5DnJd9wYvsTv1LrNnVDQMyCgGevlD/5R+APjOc8g
   8dYEL2amHiyZgHcoKgQzFHnj+l481JafmkTMlWsuCAWiC0YvP1J5vaLI4
   ymyBdxoBaqsdNbeoiCTc88hJoEEAlmJFq0N77yEg9uwM3PTq63k8XsjMu
   U5uiYcikbD8IZdflDKVgtBizYIJHOFFjHBkMI0R92bcggL/KAJ/TeNPya
   qkn6QxzEcywFNXkrUEchIdFYLokq1+iLf5NOoprMyzUaGTVAS0A1wtztp
   o4TjhX0IjynhvvNXd0a1UBbNqpPVEyiOECYl7FXNCHnhEHvfLm5FBjSPQ
   g==;
X-CSE-ConnectionGUID: vFJ1/b4DSwu11IYK1julpw==
X-CSE-MsgGUID: sGuqgWBdRWmB0F0QFi85fA==
X-IronPort-AV: E=McAfee;i="6700,10204,11304"; a="53581863"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="53581863"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 08:15:30 -0800
X-CSE-ConnectionGUID: 6wMKRm67TPCApTiDBP/NJg==
X-CSE-MsgGUID: nVbhkEWcR0+5OjCziFsVGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="102011115"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 08:15:28 -0800
Received: from [10.246.136.10] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id B2B5420B5713;
	Fri,  3 Jan 2025 08:15:27 -0800 (PST)
Message-ID: <5005ace4-6432-41d4-8b36-47ae3d851552@linux.intel.com>
Date: Fri, 3 Jan 2025 11:15:26 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 3/3] perf/x86/intel: Support PEBS counters snapshotting
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, ak@linux.intel.com, eranian@google.com,
 dapeng1.mi@linux.intel.com
References: <20241218151643.1031659-1-kan.liang@linux.intel.com>
 <20241218151643.1031659-3-kan.liang@linux.intel.com>
 <20241220142221.GN11133@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20241220142221.GN11133@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter,

Sorry for the late response. I was on vacation.

On 2024-12-20 9:22 a.m., Peter Zijlstra wrote:
> On Wed, Dec 18, 2024 at 07:16:43AM -0800, kan.liang@linux.intel.com wrote:
> 
>> @@ -3109,6 +3116,27 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>>  		if (!test_bit(bit, cpuc->active_mask))
>>  			continue;
>>  
> 
>> +		if (is_pebs_counter_event(event))
>> +			x86_pmu.drain_pebs(regs, &data);
>> +
>>  		if (!intel_pmu_save_and_restart(event))
>>  			continue;
>>  
>> @@ -4056,6 +4084,23 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>  		event->hw.flags |= PERF_X86_EVENT_PEBS_VIA_PT;
>>  	}
>>  
>> +	if ((event->attr.sample_type & PERF_SAMPLE_READ) &&
>> +	    (x86_pmu.intel_cap.pebs_format >= 6)) {
> 
> Right, so the event that has SAMPLE_READ on is 'event'
> 
>> +		struct perf_event *leader = event->group_leader;
>> +		bool slots_leader = is_slots_event(leader);
>> +
>> +		if (slots_leader)
>> +			leader = list_next_entry(leader, sibling_list);
> 
> Uh, what, why?

This was to specially handle the perf metric topdown group.

> 
>> +
>> +		if (leader->attr.precise_ip) {
>> +			event->hw.flags |= PERF_X86_EVENT_PEBS_CNTR;
>> +			if (slots_leader) {
>> +				leader->hw.flags |= PERF_X86_EVENT_PEBS_CNTR;
>> +				event->group_leader->hw.flags |= PERF_X86_EVENT_PEBS_CNTR;
>> +			}
>> +		}
> 
> And this is more confusion. You want event to be a PEBS event, not the
> leader, you don't care about the leader.

Right

> >
>> +	}
>> +
>>  	if ((event->attr.type == PERF_TYPE_HARDWARE) ||
>>  	    (event->attr.type == PERF_TYPE_HW_CACHE))
>>  		return 0;
> 
>> +static inline bool is_pebs_counter_event(struct perf_event *event)
>> +{
>> +	return event->hw.flags & PERF_X86_EVENT_PEBS_CNTR;
>> +}
> 
> For that drain_pebs() thing, you want all group members to have
> PEBS_CNTR set.
> 
> That is, if PEBS>=6 and event is PEBS and event has SAMPLE_READ, then
> mark the whole group with PEBS_CNTR

Yes, that was the design.

> 
> SAMPLE_READ doesn't particularly care who's the leader, the event that
> has SAMPLE_READ will read the whole group. Heck they could all have
> SAMPLE_READ and then all their samples will read each-other.

Right. It should be good enough to only set the flag for the
event->group_leader, since there is only one sampling event for a
SAMPLE_READ group.

The hw_config check can be simplified as below.

	if ((event->attr.sample_type & PERF_SAMPLE_READ) &&
	    (x86_pmu.intel_cap.pebs_format >= 6) &&
	    is_sampling_event(event) &&
	    event->attr.precise_ip)
		event->group_leader->hw.flags |= PERF_X86_EVENT_PEBS_CNTR;

Also, Only need to check the leader's flag to indicate the event in a
SAMPLE_READ group.

-static inline bool is_pebs_counter_event(struct perf_event *event)
+static inline bool is_pebs_counter_event_group(struct perf_event *event)
 {
-       return event->hw.flags & PERF_X86_EVENT_PEBS_CNTR;
+       return event->group_leader->hw.flags & PERF_X86_EVENT_PEBS_CNTR;
 }


Thanks,
Kan


