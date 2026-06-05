Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C9B2FFDD6
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780630206; cv=none; b=d7B0+g9fWIs/SF3uTfCMJPOzlPdGUEMlP3/8q/2zeSGEpXDQQD80kB3L0SYy4PZ3bTi6HwSV+o0q7HpRnbsJhf67COxzfPKJ/tAKPF5EZIGUZhfi0SLwj08n194HPIYtnIxJnLY3/zb9Q92B9uVh1poEi9sjBNJCEm4rHoU8DmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780630206; c=relaxed/simple;
	bh=sw3Uej78Mii/oeKD0wJrHv0CVA6uHA/+8ensnDOLcJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xaydh4fsU1b6Xt5Wo7D+DDTF97fqVPqgpglG0DTAo+kYIlQw+N5Fqy2+tm8V55XCuSmylDYmpsrH+Uqq3DnkdnsgLgxMczN1DwMvZCH4zG1CCZrxQ4aUuiC6b9jAWDd4jBjPusvl7w8JWr0UvmTOq45alz7OKii/+VTZhGOGJF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Juaw2qMa; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Juaw2qMa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780630202; x=1812166202;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sw3Uej78Mii/oeKD0wJrHv0CVA6uHA/+8ensnDOLcJA=;
  b=Juaw2qMaP4iNGPQ4H7Hvg5tR44dfEifz1zj3Z23nEVRpLcxk8Yv18Vww
   ezfIuMylm19PE8NWiEeOxLMJlbVcpofuhzRQFhdA9tOkGDVXTPSpcwgi/
   5MaKIPiorxb2Kd3MIk8PXcW/aXCAnihwq1HrkTnRmOBG7UILA2U4CKEu1
   qHUVwMUvneLcQ63vkPjGR02mq45ZU2giFjdDCG4W2JiToIIvknY4uZXSP
   fRgRwldlKsRGy8vCfqHSeZrMdd3xPk1rTOAkIqeV5hg+jKCIwrD8csEp4
   B8IonejLuSseqZvt5bP5bZ4HhQX7XH/cTK9xCQemQQ7eXqz5lT3BvweIM
   w==;
X-CSE-ConnectionGUID: kiuCdY25Q8qH+/YBXaTgCg==
X-CSE-MsgGUID: 6dfYUkzJS46Nn/iA083iRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="85316024"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="85316024"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 20:30:02 -0700
X-CSE-ConnectionGUID: Bo5EYTa3QgOTgf2NjctudA==
X-CSE-MsgGUID: +l9dOC+YTiqbMgGHQbRVAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="243642507"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 20:30:01 -0700
Message-ID: <633befb1-d3ed-4cc3-b515-449fbc98a44b@linux.intel.com>
Date: Fri, 5 Jun 2026 11:29:58 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] perf/x86/intel: Validate return value of
 intel_pmu_init_hybrid()
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260605011136.2043393-7-dapeng1.mi@linux.intel.com>
 <20260605013609.38A451F00893@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260605013609.38A451F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/5/2026 9:36 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Unnecessary error handling and dead cleanup code for early boot memory allocation failure.
> --
>
> commit e6fc94eb7f63fa466e8e1aeaed9a0d18231a88dc
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/intel: Validate return value of intel_pmu_init_hybrid()
>
> This commit validates the return value of intel_pmu_init_hybrid() to prevent
> attempts to access the uninitialized x86_pmu.hybrid_pmu[] array due to
> allocation failure. It adds error paths that destroy the task_ctx_cache when
> an error occurs.
>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index ea3ab3050a3b1..efd9caa3502c5 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -8539,7 +8540,9 @@ __init int intel_pmu_init(void)
>>  		 *
>>  		 * Initialize the common PerfMon capabilities here.
>>  		 */
>> -		intel_pmu_init_hybrid(hybrid_big_small);
>> +		ret = intel_pmu_init_hybrid(hybrid_big_small);
>> +		if (ret < 0)
>> +			goto err;
> [Severity: Low]
> Is this error handling necessary for an early boot function?
>
> Since intel_pmu_init() in arch/x86/events/intel/core.c is marked with __init,
> it executes only during early boot. At this stage, if a physical memory
> allocation fails, the system typically cannot boot anyway. Handling memory
> allocation failures and returning -ENOMEM here is likely dead code.

Even it's in early boot, it's better not to trigger an invalid memory
access error which could cause misleading.


>
> [ ... ]
>
>> @@ -8885,6 +8900,10 @@ __init int intel_pmu_init(void)
>>  	intel_aux_output_init();
>>  
>>  	return 0;
>> +
>> +err:
>> +	kmem_cache_destroy(x86_get_pmu(smp_processor_id())->task_ctx_cache);
> [Severity: Low]
> Will this cleanup code in intel_pmu_init() actually free anything?
>
> If the allocation fails during intel_pmu_init_hybrid() and we jump to the err
> label, task_ctx_cache has not been allocated yet. It is only allocated later
> in the function via intel_pmu_lbr_init() or intel_pmu_arch_lbr_init().
>
> This guarantees task_ctx_cache is NULL when this error path is taken, meaning
> this call to kmem_cache_destroy() acts as a no-op.

No, intel_pmu_arch_lbr_init() which is called before
intel_pmu_init_hybrid() could create the LBR needed slab cache
"task_ctx_cache". If intel_pmu_init_hybrid() returns error, the created
slab cache needs to be destroyed.

Thanks.

>
>> +	return ret;
>>  }
>>
