Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76CB1A6831
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780278026; cv=none; b=YgZDh9mzqeMyrEixgemoQO0p4SiyyRWl5M7jDjhhP+kwGI2ImeG0SYi2it4bO3S/EqXsCugz/sU3YnCmmo+0Qwl6k9YvaDRF3CFIRw8jMcEJIbSB1imEF4BeyRPJQHJexK6ce4K+7eqY5dEINJlwtNSymANsx57nQLYb4Lw6mHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780278026; c=relaxed/simple;
	bh=aQV126QGyJh6x5c6zGdqFhNSUqpTD4aRp9lT6F/hgBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3XqPGyTm4QiHgD+9qPk3RfVVxqdzT6ITJjtsdUa7YykyWWMc7mGlLgP6cepHzckP2APXxd4LU6HGk/o4dNy+4E6XkDpekSAM33cZQ0cLLJ6kA2ywShPbl2oQguxsHazUkiEl17uCCoWK6VVpyi6WQT6BR0qCo0yOE2XSAdKno0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lUlf3RL4; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lUlf3RL4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780278025; x=1811814025;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aQV126QGyJh6x5c6zGdqFhNSUqpTD4aRp9lT6F/hgBY=;
  b=lUlf3RL4xghigMOj1F53vQF3wy3rU1B1WZ6V8ATVW7OTN+Dv8l/QYsvP
   6oB6MQiIXRUIQ4OiruxCZW5rULbxRIowfjCPhOwNr2vvEXgXk+TCWsq4n
   LwgS58vD/1DbRS9G+YvxxnCiOyk1J9FMJUOa+pbPkwKQ5qVIKxT7tl2++
   adIXr/5IOv/z7xMlas2D0heof6QFeYQ9i2+cjc+g8fzYcy8xLcQV0f3p2
   VdpQPccPKqYw3FV6NPwcEeQa0zPIVd0JL/qz7B1f4HhWp7UAYnLUeGTsu
   PHIp6EjRzTTa9adb2+yXdMzCcba8t04D4q2xp119Dl//HLffNURCzkq+c
   w==;
X-CSE-ConnectionGUID: A966i7NhSyS9KIRugH0F+w==
X-CSE-MsgGUID: Xo13SPViR3mZEvRrOVgS0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="83609260"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="83609260"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 18:40:24 -0700
X-CSE-ConnectionGUID: PVLWLujgSBiI2HtIpn56fQ==
X-CSE-MsgGUID: Rya/I9QCSEGQPFF5TlNiQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="247694588"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 18:40:23 -0700
Message-ID: <9f80cd55-9559-4fca-b56f-32e744d4fac4@linux.intel.com>
Date: Mon, 1 Jun 2026 09:40:20 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v8 02/23] perf/x86: Move hybrid PMU initialization before
 x86_pmu_starting_cpu()
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260529075645.580362-3-dapeng1.mi@linux.intel.com>
 <20260529085116.A92351F0089D@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260529085116.A92351F0089D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/29/2026 4:51 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Use-after-free in `intel_pmu_cpu_dead()` triggered during error rollback if `perf_pmu_register()` fails.
> --
>
> commit a6b6c338247bf2e5f630f8fc0cce5709a4fbe801
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86: Move hybrid PMU initialization before x86_pmu_starting_cpu()
>
> This patch moves the default hybrid PMU structure initialization before
> calling x86_pmu_starting_cpu(). This change prevents key fields like
> capabilities from being inadvertently overwritten during initialization.
>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 4b9e105309c6a..17e122e27e0b7 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
> [ ... ]
>> @@ -2195,8 +2195,20 @@ static int __init init_hw_perf_events(void)
>>  
>>  	pmu.attr_update = x86_pmu.attr_update;
>>  
>> -	if (!is_hybrid())
>> +	if (!is_hybrid()) {
>>  		x86_pmu_show_pmu_cap(NULL);
>> +	} else {
>> +		int i;
>> +
>> +		/*
>> +		 * Init default ops.
>> +		 * Must be called before registering x86_pmu_starting_cpu(),
>> +		 * otherwise some key PMU fields, e.g., capabilities
>> +		 * initialized in x86_pmu_starting_cpu(), would be overwritten.
>> +		 */
>> +		for (i = 0; i < x86_pmu.num_hybrid_pmus; i++)
>> +			x86_pmu.hybrid_pmu[i].pmu = pmu;
> [Severity: High]
> This is a pre-existing issue, but I noticed a potential use-after-free
> during error rollback.
>
> During init_hw_perf_events(), the CPU hotplug states are set up and
> x86_pmu_starting_cpu() sets cpuc->pmu to point to elements within the
> dynamically allocated x86_pmu.hybrid_pmu array.
>
> If the subsequent perf_pmu_register() loop fails, the error path frees the
> x86_pmu.hybrid_pmu array via kfree() and jumps to out2 to unregister the
> CPU hotplug states:
>
>     if (i < x86_pmu.num_hybrid_pmus) {
>         ...
>         kfree(x86_pmu.hybrid_pmu);
>         ...
>         goto out2;
>     }
>     ...
>     out:
>         cpuhp_remove_state(CPUHP_PERF_X86_PREPARE);
>
> Tearing down the CPUHP_PERF_X86_PREPARE state triggers x86_pmu_dead_cpu(),
> which eventually calls intel_pmu_cpu_dead().
>
> Could tearing down CPUHP_PERF_X86_PREPARE evaluate the dangling cpuc->pmu
> pointer in intel_pmu_cpu_dead(), causing cpumask_clear_cpu() to write to
> the array that was just freed?

Yes, it's a bug. Need to check if x86_pmu.num_hybrid_pmus is 0 before
accessing the cpuc->pmu, like this,

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5013c424a0a2..7aecc86b5788 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6378,7 +6378,7 @@ static void intel_pmu_cpu_dead(int cpu)
        release_arch_pebs_buf_on_cpu(cpu);
        intel_cpuc_finish(cpuc);

-       if (is_hybrid() && cpuc->pmu)
+       if (is_hybrid() && x86_pmu.num_hybrid_pmus && cpuc->pmu)
                cpumask_clear_cpu(cpu, &hybrid_pmu(cpuc->pmu)->supported_cpus);
 }

BTW, I would extract these bug fixing and clean-up patches to a separate
patchset and avoid this patchset inflating too much.

Thanks.


>
>> +	}
>>  
>>  	if (!x86_pmu.read)
>>  		x86_pmu.read = _x86_pmu_read;
