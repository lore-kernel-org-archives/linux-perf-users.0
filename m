Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF951175A7B
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Aug 2026 01:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787620767; cv=none; b=mAnQgU531/WMkkKpu/Nylm2lxLiKZSqUV9BujRZqJYdVUppZkbiRzTeooHFhYsMMMjYatL7Ut4s91Tzb1c9RvTjHRQL6HF88pPVHhysEuX78O6nuZoAnYkMN4LWYVWuzxhv/3f7keacB22S2J7+XeQHLlz79NnDXWHF9qhV4qi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787620767; c=relaxed/simple;
	bh=aE4C7Gws0Jr25vQUGoyg/SN3mVXihQcH49n/TogKX64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gisCpfc46zHbEI1YqYyicwafUEwMeb5pVm+BSuWNW9D07oAfxevZVJri2Hk/cFapJMzvGITQdzHgWt0NLZKXOvYa2mo2Rl0ijy1oFJ9Yji9ii2fQI6tg/4ZKK+qgUMokENOyMcZe9WnX7dD0eSn/8EFKnCPFeoFEEcX3ZRbgBTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fCL2iwE/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fCL2iwE/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787620765; x=1819156765;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aE4C7Gws0Jr25vQUGoyg/SN3mVXihQcH49n/TogKX64=;
  b=fCL2iwE/1eCHlaejEQcJobmQFhfYbVxjCq4oGgT9zPPUsq9UhdOi49ox
   iCnFQH4KtUcdERIYr9r80i0A4ufuFuIRPK8NX/CwDaQujVH2fCf4vadQo
   /f77m9opguIkQCylQdsU6WaT2n5Ip614xMUa2RJS4sMmu4Dh9Z5l4Y95y
   QKPc9KBzAo/EJz9wn3PU8AWvl5tfP61JW/yinnAQ/FURXG/m0dC7pfJrL
   3BOOat03DJyuSNC0cPkdvNdFU2ocZb8zMD77FP37OdfslLVFouU72L9vE
   ev7TPto85sysv/Ifl+DFY+WhgjaKztZKkGjn6O21i1iNniQojyiNk9HQg
   w==;
X-CSE-ConnectionGUID: 6TxrqM4yS7aoQ/2ilybyPg==
X-CSE-MsgGUID: rWaQG/hoQqmQnoTLyhc3YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="91760417"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="91760417"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 18:19:25 -0700
X-CSE-ConnectionGUID: whZAwxkLSUioozyCVt3jSQ==
X-CSE-MsgGUID: sPZkUMdESqK22C4kXyFt8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="305391389"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 18:19:25 -0700
Message-ID: <31313fb4-52a8-45de-9fe1-abac05dd8b6d@linux.intel.com>
Date: Tue, 25 Aug 2026 09:19:22 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND Patch v10 12/23] perf: Add sampling support for SIMD
 registers
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-13-dapeng1.mi@linux.intel.com>
 <20260824085454.7A65E1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260824085454.7A65E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/24/2026 4:54 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Unbounded or improperly ordered SIMD register sample size calculation causes a `u16` size overflow in `perf_event_header.size`, leading to ring buffer memory corruption.
> --
>
> --- Patch [12]: [RESEND Patch v10 12/23] perf: Add sampling support for SIMD registers ---
> commit e9a1c0bea3274c1464a1ceda195d11e8cdb5abe5
> Author: Kan Liang <kan.liang@linux.intel.com>
> perf: Add sampling support for SIMD registers
>
> This patch introduces new attribute fields in struct perf_event_attr to
> specify and retrieve SIMD registers during profiling. It also adds the
> PERF_SAMPLE_REGS_ABI_SIMD flag and a new output format to indicate the
> configuration and contents of these wider registers when sampled.
>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 801cf34cf519b..6cc655e7694d4 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
> [ ... ]
>> @@ -8775,6 +8866,10 @@ void perf_prepare_sample(struct perf_sample_data *data,
>>  			u64 mask = event->attr.sample_regs_intr;
>>  
>>  			size += hweight64(mask) * sizeof(u64);
>> +			if (event_has_simd_regs(event)) {
>> +				size += perf_update_xregs_size(event, true);
>> +				data->regs_intr.abi |= PERF_SAMPLE_REGS_ABI_SIMD;
>> +			}
>>  		}
>>  
>>  		data->dyn_size += size;
> [Severity: High]
> This is a pre-existing issue, but does adding potentially large SIMD
> registers here guarantee an overflow of the 16-bit event size?
>
> Looking at perf_prepare_sample() in kernel/events/core.c,
> PERF_SAMPLE_STACK_USER is processed before this and maximizes the stack
> dump size to fit within U16_MAX. By appending the size of SIMD registers
> (which could be up to 32KB) after the stack truncation step, the total
> dyn_size can easily exceed 65535 bytes if a user configures a perf event
> with both PERF_SAMPLE_STACK_USER (requesting near 64KB) and
> PERF_SAMPLE_REGS_INTR with SIMD registers enabled.
>
> When perf_prepare_header() later writes the total size to header->size,
> the value will be silently truncated because header->size is a u16. Can
> this lead to the kernel writing more data than it reserved, causing ring
> buffer memory corruption?

The next patch "perf/x86: Support XMM sampling using sample_simd_vec_reg_*
fields" would add extra check for the extended register size, it would
ensure the extended register size won't exceed U16_MAX / 2. Thanks.

    size = sizeof(u64) * 4;
    size += (hweight64(vec_mask) * vec_qwords +
         hweight32(pred_mask) * pred_qwords) * sizeof(u64);
    /*
     * INTR_REGS and USR_REGS could be sampled simultaneously,
     * so roughly restrict the size to half of U16_MAX.
     */
    if (size >= U16_MAX / 2)
        return -EINVAL;


>
