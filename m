Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BFC409E16
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079441; cv=none; b=WzIpWcVPkDHVhCir6+hm7TDXohPg1CP2FqV3orgLcXllwXuiCXjq4I9YU2UBKYwiIGbik+TbyTqniePUsTlPRybJpexnGuaCoG3eVZvf5VXQrVL3zQsA9YEtDhOaHi2QL3s6o07KzhbzlEb3lXy6IT7PiTrtKV5KFVdZGkvS8WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079441; c=relaxed/simple;
	bh=xdgNo0HQSOKicPxZ1UPYy/3PVWgTvlDD31XlefDemk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nI6VarcVtZ7CCTQA2hQ24yrxvkOayYccz6e3L4UrL2F7Sl6wVs2ALEtkre4otbIXObwA/BPTYHhI2j/dhV6QpsNfz6YBETcMSbYMNWvvnFrCqCHgu1hFbT2shciW+rUYR8F0wqQmvyHMrzax6Rf44fXsskCg7ZifLjbt8+VS6UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ij/Uy7gM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ij/Uy7gM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780079439; x=1811615439;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xdgNo0HQSOKicPxZ1UPYy/3PVWgTvlDD31XlefDemk4=;
  b=ij/Uy7gMOPK1IVAXggs269iNwMJDUMLE7XRlYbnKLqbIiBxzoNHpxLuL
   GqKkXTinqmw+1iikRnizHzbaZiHotEwt1q9Q+4X24h54Ji+CJt70FBVYU
   keMkChnlcvIuALoSgij7Gr+G4kS3+5wH0TS0qr07IZSaamlgbVsRumKVf
   xS6HresKRbtzzgS+7xPUyaUyagPnaly9/i1YJWpx5ivKSH5N8cguAOINP
   JjGLUPPvKkFyiEwsHmov4+/c8ScK3qRlZ/uivEzUaTNGuPhRNG7NHJkKD
   8i3Lzk1yETeXt7ZehwY4AMZno00O8outA9sgCz3VhYxOEFZi3Dbk3wcnA
   Q==;
X-CSE-ConnectionGUID: qLuaYFymQeqn/gu33+9W7A==
X-CSE-MsgGUID: SCiOQJL1SUCWOi82ytpvAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="92053355"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="92053355"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 11:30:38 -0700
X-CSE-ConnectionGUID: /WBZGfffR3Ovjw5wspLNLw==
X-CSE-MsgGUID: cylIfI2vTgem8KryQoHmOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="239917748"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 11:30:37 -0700
Message-ID: <8037384e-e3d5-4479-a3f1-00ec7f943272@intel.com>
Date: Fri, 29 May 2026 13:30:36 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 7/7] perf/x86/intel/uncore: Implement global init
 callback for GNR uncore
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260527151154.130505-7-zide.chen@intel.com>
 <20260527204547.2E3D11F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260527204547.2E3D11F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/27/2026 3:45 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] Calling `uncore_die_to_cpu()` without holding `cpus_read_lock()` introduces a race condition with CPU hotplug, potentially aborting PMU discovery.
> - [High] Use of the unsafe `wrmsrq_on_cpu()` function with an unvalidated MSR index can trigger a General Protection Fault (#GP) and crash the kernel.
> - [High] The required global initialization write is only performed during discovery and is missed upon system resume, leaving PMON units uninitialized after sleep.
> - [Medium] PMU discovery permanently fails for a die if all of its CPUs are offline during module initialization.
> --
> 
> commit d885055ecaea97356a710a83b6d4de7ee7d6ba76
> Author: Zide Chen <zide.chen@intel.com>
> Subject: perf/x86/intel/uncore: Implement global init callback for GNR uncore
> 
> This commit implements a global initialization callback for GNR uncore to
> explicitly write 0 to the global control register at boot. This triggers
> hardware initialization properly for UBOX PMON units on Sierra Forest and
> Clearwater Forest.
> 
>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>> index 4b3a1fa5b41b7..7857959c6e823 100644
>> --- a/arch/x86/events/intel/uncore.c
>> +++ b/arch/x86/events/intel/uncore.c
> [ ... ]
>> @@ -1731,6 +1731,16 @@ static int uncore_mmio_global_init(u64 ctl)
>>  	return 0;
>>  }
>>  
>> +static int uncore_msr_global_init(int die, u64 msr)
>> +{
>> +	int cpu = uncore_die_to_cpu(die);
>> +
>> +	if (cpu == -1)
>> +		return -ENODEV;
> 
> [Severity: Medium]
> If a die has no online CPUs during module load or boot, this will return
> -ENODEV and abort parsing the discovery table for that die. Since there
> is no mechanism to re-trigger discovery when a CPU on that die is later
> brought online via hotplug, will the uncore PMUs for that die remain
> permanently unavailable?

Yes, this is expected.


> [Severity: High]
> Is this safe against CPU hotplug? uncore_discovery_pci() invokes
> __parse_discovery_table() without holding cpus_read_lock(). If the
> selected CPU goes offline in the narrow window between uncore_die_to_cpu()
> and the subsequent wrmsrq_on_cpu() call, smp_call_function_single() will
> return -ENXIO and silently abort PMU discovery for the entire die.

You are right, it's better to hold the cpus_read_lock() in the
uncore_discovery_pci() path as well.

diff --git a/arch/x86/events/intel/uncore_discovery.c
b/arch/x86/events/intel/uncore_discovery.c
index 77fc26fc6e9e..fd74da91c12b 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -399,7 +399,6 @@ static bool uncore_discovery_msr(struct
uncore_discovery_domain *domain)
        if (!die_mask)
                return false;

-       cpus_read_lock();
        for_each_online_cpu(cpu) {
                die = topology_logical_die_id(cpu);
                if (__test_and_set_bit(die, die_mask))
@@ -414,8 +413,6 @@ static bool uncore_discovery_msr(struct
uncore_discovery_domain *domain)
                __parse_discovery_table(domain, base, die, &parsed);
        }

-       cpus_read_unlock();
-
        kfree(die_mask);
        return parsed;
 }
@@ -429,10 +426,15 @@ bool uncore_discovery(struct uncore_plat_init *init)
        for (i = 0; i < UNCORE_DISCOVERY_DOMAINS; i++) {
                domain = &init->domain[i];
                if (domain->discovery_base) {
+
+                       cpus_read_lock();
+
                        if (!domain->base_is_pci)
                                ret |= uncore_discovery_msr(domain);
                        else
                                ret |= uncore_discovery_pci(domain);
+
+                       cpus_read_unlock();
                }
        }

> 
>> +
>> +	return wrmsrq_on_cpu(cpu, msr, 0);
>> +}
> 
> [Severity: High]
> Can this trigger a General Protection Fault (#GP)? The msr parameter is
> derived from a 64-bit value dynamically read from the hardware/firmware
> discovery table. If the firmware provides an invalid value, an MMIO physical
> address, or if the table is corrupted, wrmsrq_on_cpu() will execute a bare
> wrmsr instruction. Should this use wrmsrq_safe_on_cpu() to gracefully handle
> invalid MSR indices?
> 
> [Severity: High]
> Since domain->global_init() is only called once during initial uncore
> discovery, what happens during S3 suspend or hibernation? The hardware drops
> power and loses its state, reverting the FRZ_ALL bit back to the default.
> Without a suspend/resume callback to re-trigger this explicit global
> initialization write, will the UBOX PMON units silently fail to work after
> the system resumes from sleep?

It's supposed not be impacted by S3.
> 
> [ ... ]
>> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
>> index af2217b44a814..e36613d934b1f 100644
>> --- a/arch/x86/events/intel/uncore_discovery.c
>> +++ b/arch/x86/events/intel/uncore_discovery.c
> [ ... ]
>> @@ -287,7 +287,7 @@ static int __parse_discovery_table(struct uncore_discovery_domain *domain,
>>  	if (!io_addr)
>>  		return -ENOMEM;
>>  
>> -	if (domain->global_init && domain->global_init(global.ctl)) {
>> +	if (domain->global_init && domain->global_init(die, global.ctl)) {
>>  		ret = -ENODEV;
>>  		goto out;
>>  	}
> 

