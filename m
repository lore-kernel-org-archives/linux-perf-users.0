Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A427A34A3A5
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778696819; cv=none; b=YyyFHb5z5BgvTPRQbyILX8Ol0zweF2in3XZZ9yobCnhx4szL1kZIhX1euN68FNWrPTebPTLoiChQQ10aq1aipfomkF7XgolMuIQRHUWabSQ2OVmJO2gTBp2PpA7KXF5k0aizbFwpU80ujVk1vIsKUGcT5HvQNBF4vhA0dkl3pF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778696819; c=relaxed/simple;
	bh=807yPwSvud5ryhx0V1RwZOpJ6LEcdQ9y6/DN4ptHnQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IWgC2/vOAjTD/ihtxqXtldhTv+TjbVDdSWtDVdIxT87bgyR7nHJvyOkUb4wQJDXI9P0Rx8OD96owdUVCQgRlNg7g2CIy1izyESWqLl5mI9CoqPcH0SbAaTSETT59CVb1PnPA9xuAMKok5WZo1VNPS8nMGiW2mmOQ51kFEzB5rKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBXCGXso; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBXCGXso"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778696816; x=1810232816;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=807yPwSvud5ryhx0V1RwZOpJ6LEcdQ9y6/DN4ptHnQ0=;
  b=OBXCGXsorezZv2yX2kv9MNa1S2hnf5f1k9bY5OJ1R2U04OjCdbzI8PSF
   pGTPpi3Vjau0bRRxp5NNVOM4iedyde8oXS7yko7z1Bt5C/QCyMNp5Rkfn
   sUDv4xmXIBolzBsuJQkRTs41hFPuILBa2w6O5oopzf6hZV6IxMlzgM3HT
   r9u5r7UCqNIbGhFyNMmjHP00yWr5Ts9sSW3YQpiX7nwzyfQtFecapgLat
   qvqCjqpsUBB/P0w/K0nAVY4lvQ1uecO8S2F7kCII2M3vtRJM3mNuAdjYW
   KO3ameCAxqFXH0avzttSXUZql+q8426QiCpqj4WLW5obJntszjmz3WOKr
   A==;
X-CSE-ConnectionGUID: zN01uQKKRV6vBw9jVUuvZA==
X-CSE-MsgGUID: +7cDmxSYThCFopLnjz3NOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79662165"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="79662165"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 11:26:56 -0700
X-CSE-ConnectionGUID: E1mOQqO9RayKGmFlf+1GoQ==
X-CSE-MsgGUID: nrIJN0H/Qa+dpum1vVmWKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="242161446"
Received: from unknown (HELO [10.241.241.90]) ([10.241.241.90])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 11:26:56 -0700
Message-ID: <ff021ab2-19a9-4d36-b59e-d354035805c0@intel.com>
Date: Wed, 13 May 2026 11:26:55 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] perf/x86/intel/uncore: Implement global init callback
 for GNR uncore
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260511230527.26096-7-zide.chen@intel.com>
 <20260513042548.E22A4C2BCB7@smtp.kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260513042548.E22A4C2BCB7@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/12/2026 9:25 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The return value of `wrmsrq_on_cpu()` is ignored in `uncore_msr_global_init()`, masking hardware initialization failures caused by a CPU hotplug TOCTOU race.
> --
> 
> commit d795e124f297e8f2c0cfee9efd29cdf4ec1993ce
> Author: Zide Chen <zide.chen@intel.com>
> 
> perf/x86/intel/uncore: Implement global init callback for GNR uncore
> 
> This commit adds a generic uncore_msr_global_init() callback for GNR, GRR,
> SRF, and CWF. It writes 0 to the global control register during boot to
> ensure the UBOX PMON units are properly initialized.
> 
>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>> index 19056514b0812..a7780c5cd419a 100644
>> --- a/arch/x86/events/intel/uncore.c
>> +++ b/arch/x86/events/intel/uncore.c
> 
> [ ... ]
> 
>> @@ -1731,6 +1731,17 @@ static int uncore_mmio_global_init(u64 ctl)
>>  	return 0;
>>  }
>>  
>> +static int uncore_msr_global_init(int die, u64 msr)
>> +{
>> +	int cpu = uncore_die_to_cpu(die);
>> +
>> +	if (cpu == -1)
>> +		return -ENODEV;
>> +
>> +	wrmsrq_on_cpu(cpu, msr, 0);
>> +	return 0;
>> +}
> 
> uncore_die_to_cpu() acquires and releases cpus_read_lock() to find an
> online CPU, meaning the selected CPU could be hot-unplugged concurrently
> before wrmsrq_on_cpu() executes.
> 
> If the CPU goes offline, the underlying smp_call_function_single() will
> fail and wrmsrq_on_cpu() will return an error.

As you pointed out in PATCH 4/6, I would move the lock out of
uncore_die_to_cpu() and rely on the caller to manage the lock, then
between uncore_die_to_cpu() and wrmsrq_on_cpu(), CPU hot-unplug cannot
occur.
> Because this function unconditionally returns 0, the caller will assume
> success and proceed to register the PMON units. As noted in the commit
> message, the units will not work unless the MSR is written, which could
> lead to a silent functional failure.
> 
> Does this code need to check and propagate the return value of
> wrmsrq_on_cpu() to prevent this regression?

No, wrmsrq_on_cpu() returns 0 always.

> 

