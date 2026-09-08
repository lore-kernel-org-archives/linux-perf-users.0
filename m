Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0205F2D0617
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857252; cv=none; b=hqWXTjBP8fCzTiuUIrNOVWxwVmi3KIwZvIjR/uCCc2rXXkFRwk1/8SxqpRn5nkNh18lkD5bg6t1ENPjvxM4bpQakmaTZKZ9fHb5x1lDIeO8YJ3vsR8352JoiofIOqknc+raRYe3HaAvu0cy4FwtuSmCn/UI9zReg+Hd7lJ900PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857252; c=relaxed/simple;
	bh=1JSxNXEGXt1lmkdbK4pCt66pK7X1v1X7t2RxjMk7iY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ias7xT02qjvA6Q46i8QpCgnrMAd1WAgBwmqrMEvZ+AzewBNFkoCzKDMrGu+0T9fKnQGXnTt4knm6ALCth3Sr25sXN46rkSLZxC0aGvvIUg2aVQwEWVql+kiow6K0s5kJ9V2oo2L7StN+qogPa+yvqp0c/+qEj/u7nPdjrNvDtK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cUXbUuCh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cUXbUuCh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788857251; x=1820393251;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1JSxNXEGXt1lmkdbK4pCt66pK7X1v1X7t2RxjMk7iY4=;
  b=cUXbUuChzPrQDFl68f9uoIZHnXsMOAFCSLVcGVNiVbTrutnccvffZ4Wx
   VlBE5O2e5HLAzmgDAgHmjAQGijsRVIxTbOs8Ji20L4adSMX1ORzKGCSIk
   gq2wVH1y9Y/JMckgFYYX5xnjg7IhdnFUZbHBmX/9kYE3WL/QCy0FX46pN
   esaJoK/eXzMI16YiB01Rzz3Ev03zyEq9F+8myWhYrJbfQq9MtXe8XUkhr
   /FF1FAnaRvP05ijQG1uF+W3knwBS2otqutgJEx4D8aSqU0EXPKeg45xZc
   0d0Xg3AwIBwg32TREsNe/XmJmwZ1XGOPHh9jYN8hXkbhj+dsr2liOZksh
   Q==;
X-CSE-ConnectionGUID: PPZD5tu9SLilEuQfRQGeWw==
X-CSE-MsgGUID: 8FYJacTdTSmXm/RNs2Mr7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="114792464"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="114792464"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 01:47:30 -0700
X-CSE-ConnectionGUID: GlPXsIsFQ7e2PhgF684lHg==
X-CSE-MsgGUID: jpEjmzgDQRupJyk7JqO6bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="268359945"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 01:47:29 -0700
Message-ID: <b6e12162-afca-454d-aeab-840d531f47d8@linux.intel.com>
Date: Tue, 8 Sep 2026 16:47:27 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/x86: Disable precise sampling for
 PERF_SAMPLE_STACK_USER
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260908075102.540715-1-dapeng1.mi@linux.intel.com>
 <20260908075102.540715-2-dapeng1.mi@linux.intel.com>
 <20260908081501.8428A1F00A3A@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260908081501.8428A1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/8/2026 4:15 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] ABI Breakage / Overly Broad Restriction on Precise Sampling with User Stacks
> --
>
> commit 4f30379fa3ce88165bf1e61c1c825c26d5810b23
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86: Disable precise sampling for PERF_SAMPLE_STACK_USER
>
> This commit disables precise sampling (PEBS/IBS) when PERF_SAMPLE_STACK_USER
> is requested. It attempts to prevent DWARF unwinding failures caused by skid
> between the PEBS/IBS register snapshot and the user stack at PMI return.
>
> Closes: https://lore.kernel.org/all/CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com/
> Fixes: c5ebcedb566e ("perf: Add ability to attach user stack dump to sample")
>
>> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
>> index 3531f9c23b8c9..c67b659d64e2a 100644
>> --- a/arch/x86/events/amd/ibs.c
>> +++ b/arch/x86/events/amd/ibs.c
>> @@ -327,6 +327,9 @@ static int perf_ibs_init(struct perf_event *event)
>>  	if (has_branch_stack(event))
>>  		return -EOPNOTSUPP;
>>  
>> +	if (!x86_pmu_allow_sample_user_stack(event, true))
>> +		return -EINVAL;
> [Severity: High]
> Does this change unconditionally reject AMD IBS events when user stacks are
> requested, since the second parameter is hardcoded to true?
>
> Returning -EINVAL to sys_perf_event_open for configurations that were
> previously valid breaks backward compatibility. Userspace applications
> relying on AMD IBS with PERF_SAMPLE_STACK_USER might now fail unexpectedly.

I'm not an IBS expert, but it looks there are two ways to trigger IBS
sampling, one is to set the precise_ip to 1, just like PEBS, the other is
directly to create IBS events. Both of these 2 cases should be disabled to
sample user stack, otherwise returned user stack and IP would be
inconsistent and break DWARF unwinding. So only PMI-based user stack
sampling is allowed.


>
>> +
>>  	/* handle exclude_{user,kernel} in the IRQ handler */
>>  	if (event->attr.exclude_host || event->attr.exclude_guest ||
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index d1af33d96d0a3..a26ea8baea731 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -596,6 +596,9 @@ int x86_pmu_hw_config(struct perf_event *event)
>>  		/* There's no sense in having PEBS for non sampling events: */
>>  		if (!is_sampling_event(event))
>>  			return -EINVAL;
>> +
>> +		if (!x86_pmu_allow_sample_user_stack(event, false))
>> +			return -EINVAL;
> [Severity: High]
> Can this break existing perf setups for Intel PEBS events?
>
> Tools issuing commands like perf record -e cycles:pp --call-graph dwarf
> rely on precise_ip and PERF_SAMPLE_STACK_USER. Rejecting this setup with
> -EINVAL prevents previously accepted workflows from functioning.

Yes, but it seems there is no better way to fix this issue. An alternative
way to fix this issue is still to return the PMI context register state
rather than the PEBS precise registers for user stack sampling, but this
actually falls back the imprecise PMI-based sampling. This even make the
thing worse, user requires to get precise samplings, but perf silently
returns imprecise records, this would mislead user. 


>
>>  	}
>>  	/*
>> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
>> index eae24bb35dc14..ca52597cc39a1 100644
>> --- a/arch/x86/events/perf_event.h
>> +++ b/arch/x86/events/perf_event.h
> [ ... ]
>
>> @@ -1273,6 +1273,25 @@ static inline bool is_counter_pair(struct hw_perf_event *hwc)
>>  	return hwc->flags & PERF_X86_EVENT_PAIR;
>>  }
>>  
>> +static inline bool
>> +x86_pmu_allow_sample_user_stack(struct perf_event *event, bool ibs)
>> +{
>> +	if (!(event->attr.sample_type & PERF_SAMPLE_STACK_USER))
>> +		return true;
>> +
>> +	/*
>> +	 * PERF_SAMPLE_STACK_USER needs to return the user stack and
>> +	 * user registers to user space when the PMI exits. Since the skid
>> +	 * from the PEBS/IBS sample and PMI delivery, the PEBS/IBS register
>> +	 * snapshot (especially IP/SP/BP) can diverge from the user stack
>> +	 * at PMI return. That mismatch breaks DWARF unwinding.
>> +	 *
>> +	 * Therefore, disable precise sampling for PERF_SAMPLE_STACK_USER
>> +	 * and permit only PMI-based sampling for this case.
>> +	 */
>> +	return !(event->attr.precise_ip || ibs);
> [Severity: High]
> Is the assumption about skid accurate for kernel-space profiling?

No, the skid happens on from the PEBS/IBS record generation between PMI
delivery. The skid is inevitable and would lead to inconsistency between
PEBS/IBS register snapshot and user stack.

Thanks.


>
> When profiling a syscall or with exclude_user=1, the user-space stack and
> registers are frozen upon kernel entry, meaning there is zero skid between
> them. 
>
> By unconditionally banning precise sampling with user stacks, does this
> unintentionally prevent the valid use-case of precisely profiling kernel
> events while still capturing accurate user callgraphs?
>
>> +}
>> +
