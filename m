Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AA22853FD
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 02:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776135456; cv=none; b=BDhd+o8uKBs8j/XVdD0D5AKCPNgohuoAqRr9wAeTsN9ILaOj6yen1GJOWrjK49m/hc7gEne/ZGG4x5PIP9uQL7Ia8o+JwWPYeMWd0wKXkOyv6fsvlItaXNJYvOjg4DO9QxXe7KT5NWpqL5bWBevhj6c/JItAgrAuwknrLjJ9pWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776135456; c=relaxed/simple;
	bh=I8QBk6V9KiUQJdpyZi3I9aLmH1uKlWnR6WnL5+GfI0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJgyZw5oD80Bdc3fXYTXPFN42RI9th2uKcZfENRn2Ytx+vOw1yrHoWfZ6Sv2YbtGl6XJBZZxUi++p9AdSE5yNb9Wnc/2s8LREUlxsyeXr5XnbuObEXe3YPJhKmLV01Okbbz5gmftKoJtobtpg/kPiQnKynXE6OHLnapoSDoT5l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V9FN9kAG; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V9FN9kAG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776135454; x=1807671454;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I8QBk6V9KiUQJdpyZi3I9aLmH1uKlWnR6WnL5+GfI0s=;
  b=V9FN9kAGloCFsFDDmE1RG4hTWdrsPzOC3vP393PlWHszqxkFeZlNxy8I
   6sKlHgRJcbYYsbiNq0FnKeK8nyhH7hkkQs2E0WyNfbpUlzcS7++MpR6oJ
   epTxEK+Jo69HD4Xy9kBjOmuo3joax+njNJbfFm0pLQmpgjaBo+/wYSRz8
   oZSD5Wvae2UIJqNvJiqwX/0J3w6ji/RgotjuU47WYhPgxmIoysbS8ttuH
   WLn8uok15VNWng5t28MmRu0X62rDZOZWP+W629Xit2PYJF1AHS9XKQSGm
   9U8h/yEsVMghOLcIG+kuxTFgzqzNN8tZNh19jNo0jkl0P6WpZ3Mej+GrY
   g==;
X-CSE-ConnectionGUID: lMj/JS75RZq6v8NnuQa3XQ==
X-CSE-MsgGUID: Kv/6x2M5TZOWVzVbZk/ZeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="80967910"
X-IronPort-AV: E=Sophos;i="6.23,178,1770624000"; 
   d="scan'208";a="80967910"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 19:57:33 -0700
X-CSE-ConnectionGUID: Z6ekcJ5cQamxgT+0SizzYQ==
X-CSE-MsgGUID: zlXleB48QqaIDLAAz2pMvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,178,1770624000"; 
   d="scan'208";a="234894951"
Received: from unknown (HELO [10.238.1.30]) ([10.238.1.30])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 19:57:32 -0700
Message-ID: <7d3ba145-23e7-4cec-97ff-699c4ae679dd@linux.intel.com>
Date: Tue, 14 Apr 2026 10:57:30 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf/x86/intel: Clear stale ACR mask before updating
 new mask
To: sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260413010157.535990-2-dapeng1.mi@linux.intel.com>
 <20260413013558.0EFE3C19424@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260413013558.0EFE3C19424@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/13/2026 9:35 AM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 2 potential issue(s):
> - [High] Incomplete Fix: Early return bypasses the newly added stale mask cleanup for subsequent events.
> - [High] Missing bounds check on user-provided mask allows cross-event PMU interference (cross-wiring).
> --
>
> commit f516548e46c9feac44792cd958b5c0a840d60d43
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/intel: Clear stale ACR mask before updating new mask
>
> This commit clears the ACR mask before applying a new one to prevent
> stale bits from persisting during event rescheduling. It ensures the
> hardware state does not get polluted by previous configurations.
>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 4768236c054bb..58c236ce47474 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -3344,6 +3344,9 @@ static void intel_pmu_acr_late_setup(struct cpu_hw_events *cpuc)
>>  			event = cpuc->event_list[j];
>>  			if (event->group_leader != leader->group_leader)
>>  				break;
>> +
>> +			/* Clear stale ACR mask first. */
>> +			event->hw.config1 = 0;
>>  			for_each_set_bit(idx, (unsigned long *)&event->attr.config2, X86_PMC_IDX_MAX) {
>>  				if (i + idx >= cpuc->n_events ||
>>  				    !is_acr_event_group(cpuc->event_list[i + idx]))
> Could this validation check allow unprivileged users to cross-wire the PMU?
>
> Since is_acr_event_group() only verifies that the target event belongs to any
> ACR group, rather than the same group_leader, does this allow a user-provided
> out-of-bounds bit in config2 to point to an independent, system-wide ACR event
> running on the same CPU?
>
> If so, it seems the hardware counter index of an unrelated privileged event
> could be blindly copied into the user's hw.config1.

It couldn't be. The above "if (event->group_leader !=
leader->group_leader)" has checked if the events are in a same ACR group.


>
>>  					return;
> Does this early return bypass the newly added stale mask cleanup for subsequent
> events?
>
> Because attr.config2 is user-controlled, a user could supply a malformed mask
> with an out-of-bounds bit to intentionally trigger this early return.
>
> Since it returns from intel_pmu_acr_late_setup() completely, wouldn't this skip
> the event->hw.config1 = 0 cleanup for all subsequent ACR events scheduled on the
> same CPU, leaving them with a polluted hardware state?

Yes, it's possible. It looks we have to do twice iteration for the
event_list.  The 1st iteration is to clear the stale hw.config1 and the 2nd
iteration is to validate and parse the ACR mask. Would fix it in next
version. Thanks.



>
