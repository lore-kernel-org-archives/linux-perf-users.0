Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05211E520A
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 06:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776666597; cv=none; b=RUY9BL+NopUWt6b4wym5A+2SwACNquW123FlEKuJfnZLo0K0AGni93fAAU0aK2vN/sS+eGKTc4wlOynZfNRAzfbqI0UrmVgCS+jsFPWNvEjNHpWfM1ky9DxrT8OPRPXz+budmAO/NbJ+e8DLx8shh1ueToOVc/aAC1mDqDPxJlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776666597; c=relaxed/simple;
	bh=1Ra7/auaM/ncTKwPBO4545LhzHNHnwhdeNxrxdwl+ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDBeHmHlC7Px04ajFUuTVdnPjG/IaDLPOFLu8wVPTeu/vQ2eI/RqQfaOdbqXCBo3gm8NZWU4i+2qPj3rvF/Yahx1xZG5mWHvCiIsUby+kmAvR/ISTC7eXQ4Fkd+XrV+k7TIzHUkp3BcWpUyvtrzLqA2tqleVMWeC94txCJDRryE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AnUenNIf; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AnUenNIf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776666596; x=1808202596;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1Ra7/auaM/ncTKwPBO4545LhzHNHnwhdeNxrxdwl+ao=;
  b=AnUenNIf52ZGcyJYKqE+SW9eqsb5EFxsCy/sMH1P0ZJIckzWyMyE62Jz
   CtBgLF5a/VT9Z+fo6seHoi5aa+U74bCZfsJA1MJ2bzGTlBJsv+gFDxwWz
   rqvSMjy8+Yvok9tsZIs78LCzl/FjYY9zIZgIC4MToa/0af4uq7TxOjrMT
   12u9drKF4GVjJOajBNLAJFDn5a5JeX1mreDNx5H3y8c9mOfnUnXnzbr3o
   2t+LdEdYPkFGv3qoCXYtr+PSSPAAqB6aae+f7QSFuHCF7lvIhkCH7/JQg
   xXw+EnAZoh1nOZdDtntBVjFJf9pkwvHKcRWBZjMElW6CJ3dc59JnV2sjA
   g==;
X-CSE-ConnectionGUID: wliNkESgQ3SYgHguQmqPVw==
X-CSE-MsgGUID: rJmu43pdSm2hBePnLM3rDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="87876411"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="87876411"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2026 23:29:56 -0700
X-CSE-ConnectionGUID: 8Hay3BLeQ6O6jNsIhuB5qg==
X-CSE-MsgGUID: LmUCF3wQT5ONzKTWMi+hBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="236616440"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2026 23:29:54 -0700
Message-ID: <717f00c7-be8d-4f69-88ab-5a060a6a7e65@linux.intel.com>
Date: Mon, 20 Apr 2026 14:29:51 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 1/4] perf/x86/intel: Clear stale ACR mask before
 updating new mask
To: sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260420024528.2130065-2-dapeng1.mi@linux.intel.com>
 <20260420032402.A8971C19425@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260420032402.A8971C19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/20/2026 11:24 AM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [High] Unvalidated user input in ACR setup leads to cross-user hardware state corruption and PMU DoS
> --
>
> commit 67dc3d7b096879ed6418f54978bf45536496156f
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/intel: Clear stale ACR mask before updating new mask
>
> This commit zeroes out the ACR mask (event->hw.config1) for all scheduled
> events before applying a new mask. This ensures that bits from a previous
> stale ACR mask do not persist and pollute the hardware state during event
> rescheduling.
>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 4768236c054bb..774ae9a4eeaf8 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -3334,6 +3334,12 @@ static void intel_pmu_acr_late_setup(struct cpu_hw_events *cpuc)
>>  	struct perf_event *event, *leader;
>>  	int i, j, idx;
>>  
>> +	/* Clear stale ACR mask first. */
>> +	for (i = 0; i < cpuc->n_events; i++) {
>> +		event = cpuc->event_list[i];
>> +		event->hw.config1 = 0;
>> +	}
>> +
> Does this new clearing loop inadvertently amplify an existing regression where
> a single user can disable Auto Counter Reload for all processes on the same CPU?
>
> Looking further down in the same function, the code iterates over
> user-controlled bits from event->attr.config2:
>
> arch/x86/events/intel/core.c:intel_pmu_acr_late_setup() {
>     ...
>     for_each_set_bit(idx, (unsigned long *)&event->attr.config2, X86_PMC_IDX_MAX) {
>         if (i + idx >= cpuc->n_events ||
>             !is_acr_event_group(cpuc->event_list[i + idx]))
>             return;
>         __set_bit(cpuc->assign[i + idx], (unsigned long *)&event->hw.config1);
>     }
>     ...
> }
>
> Because idx is derived from the user-controlled event->attr.config2 mask
> without being validated against the actual size of the event group, a
> user could provide an artificially large idx.
>
> The validation in intel_pmu_hw_config() only checks the weight of the mask
> using hweight64(), rather than checking the actual bit indices, leaving this
> exposed. Subsequent patches in the series do not fix this.
>
> If the computed index hits a non-ACR event or exceeds cpuc->n_events, the
> loop triggers an early return. Since the newly added code zeroes out
> event->hw.config1 for all scheduled events before this loop, wouldn't this
> early return leave all subsequent valid ACR events with a cleared mask?
>
> Additionally, if the out-of-bounds idx points to another user's valid ACR
> group, is_acr_event_group() returns true, and the code proceeds to update
> the event->hw.config1 with the victim's hardware counter index.
>
> Could this also result in cross-user state corruption of event->hw.config1
> when the event overflows and cross-reloads the victim's counter?

That looks a real potential issue. Current validation for the acr_mask
needs to be enhanced. The acr_mask from user space should not exceeds the
index bitmap of current ACR events group.
Thanks.


>
>>  	for (i = 0; i < cpuc->n_events; i++) {
>>  		leader = cpuc->event_list[i];
>>  		if (!is_acr_event_group(leader))
