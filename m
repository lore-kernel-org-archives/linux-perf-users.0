Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154BA18FDBD;
	Tue,  9 Jul 2024 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537454; cv=none; b=GbUoBbIV0DDJHM8oeI979fazeyhPZZvN80unMbCxY4QuFm3P9Q/W4fR/oHVk73H8bYRhvdy0M6cU/1jx/p4SjV9z/E7vpApKjWo6AGPoAKBqjQGtFT2bnzm9ZlskbIsGKLgkOypUu69Y5k43g/sBDdwU1IAJeBL/l3iv/6p3Jtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537454; c=relaxed/simple;
	bh=GCSDwXOWFZkc9huLYqRuNrJ/14e9sx/LUwzMnc2pKrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQHA5eYjidT5TkuZ+xcC2xX50ZeUrbpx+hEoRsrGkp6Ij8Tw2xlESDe9eZwtdXRWkxkFlXTgNXXx/EyMAHpWeiIMB+wqAYmmZTkVNP1IibcvWaOMpNDwi7CiJwursfDgaenZ42VlbedrhXYHh/Q+5N+eJEk62qyQ50Bbo8cAS0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AN0eLQke; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AN0eLQke"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720537452; x=1752073452;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GCSDwXOWFZkc9huLYqRuNrJ/14e9sx/LUwzMnc2pKrs=;
  b=AN0eLQkeWyEkTOglbLWMQFl+/euhk3nbBCwyNd6+hfvc3tuY9OjHB99S
   pwm3pgTfCagcj0qYkWJvAU9jXe4pkJbIVzlguBQALYFieoU5scyjHTgwa
   waGfOfBojjG0Up6HJM2ZfOtGlSZfMBhY+RKwV5Dn0wPCchZQ8ld14W733
   cN9ga/EmHhbJysI9Wz/khPQ7RIXnToV+aD4vasik3jRsErJ3RwxggnNqd
   z2h6213xGazSRVXK9d9OlZtmCTK47+AtPcobcNsRr5z7r4C7ZS8QXT6Nr
   8hZ2dpp48QQe3jTvgVLH/dqT8to3aMmIgc5nnoNx6i5Bnp+5beJltt3VT
   w==;
X-CSE-ConnectionGUID: TdqBC4CNRuO/Qc7Rnd35aw==
X-CSE-MsgGUID: Oxpq/u/YQYuNOX/Vtkj1VQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17669063"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="17669063"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 08:04:11 -0700
X-CSE-ConnectionGUID: UlaX7gnsQD6sSrVnmHD1Xw==
X-CSE-MsgGUID: RDVfSdQBShuxGRviDkc9Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="47806393"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 08:04:11 -0700
Received: from [10.212.46.239] (kliang2-mobl1.ccr.corp.intel.com [10.212.46.239])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id A3E1420B8CFF;
	Tue,  9 Jul 2024 08:04:08 -0700 (PDT)
Message-ID: <96037040-3b00-4d9a-9ff0-568b7b7b4f30@linux.intel.com>
Date: Tue, 9 Jul 2024 11:04:07 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/11] perf/x86: Enable NMI source reporting for
 perfmon
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, X86 Kernel <x86@kernel.org>,
 Sean Christopherson <seanjc@google.com>, LKML
 <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Xin Li <xin3.li@intel.com>, linux-perf-users@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tony Luck <tony.luck@intel.com>,
 Andy Lutomirski <luto@kernel.org>, acme@kernel.org,
 Andi Kleen <andi.kleen@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 "Mehta, Sohil" <sohil.mehta@intel.com>, Zeng Guang <guang.zeng@intel.com>
References: <20240709143906.1040477-1-jacob.jun.pan@linux.intel.com>
 <20240709143906.1040477-9-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240709143906.1040477-9-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-07-09 10:39 a.m., Jacob Pan wrote:
> Program the designated NMI source vector into the performance monitoring
> interrupt (PMI) of the local vector table. PMI handler will be directly
> invoked when its NMI is generated. This avoids the latency of calling all
> NMI handlers blindly.
> 
> Co-developed-by: Zeng Guang <guang.zeng@intel.com>
> Signed-off-by: Zeng Guang <guang.zeng@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
> v4: Use a macro for programming PVTPC unconditionally (Kan)
> v3: Program NMI source vector in PVTPC unconditionally (HPA)
> v2: Fix a compile error apic_perfmon_ctr is undefined in i386 config
> ---
>  arch/x86/events/core.c       | 4 ++--
>  arch/x86/events/intel/core.c | 6 +++---
>  arch/x86/include/asm/apic.h  | 2 ++
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 1ef2201e48ac..e69c52f9d662 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1680,7 +1680,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
>  	 * This generic handler doesn't seem to have any issues where the
>  	 * unmasking occurs so it was left at the top.
>  	 */
> -	apic_write(APIC_LVTPC, APIC_DM_NMI);
> +	apic_write(APIC_LVTPC, APIC_PERF_NMI);
>  
>  	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
>  		if (!test_bit(idx, cpuc->active_mask))
> @@ -1723,7 +1723,7 @@ void perf_events_lapic_init(void)
>  	/*
>  	 * Always use NMI for PMU
>  	 */
> -	apic_write(APIC_LVTPC, APIC_DM_NMI);
> +	apic_write(APIC_LVTPC, APIC_PERF_NMI);
>  }
>  
>  static int
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 38c1b1f1deaa..e7e114616e24 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3093,7 +3093,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
>  	 * NMI handler.
>  	 */
>  	if (!late_ack && !mid_ack)
> -		apic_write(APIC_LVTPC, APIC_DM_NMI);
> +		apic_write(APIC_LVTPC, APIC_PERF_NMI);
>  	intel_bts_disable_local();
>  	cpuc->enabled = 0;
>  	__intel_pmu_disable_all(true);
> @@ -3130,7 +3130,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
>  
>  done:
>  	if (mid_ack)
> -		apic_write(APIC_LVTPC, APIC_DM_NMI);
> +		apic_write(APIC_LVTPC, APIC_PERF_NMI);
>  	/* Only restore PMU state when it's active. See x86_pmu_disable(). */
>  	cpuc->enabled = pmu_enabled;
>  	if (pmu_enabled)
> @@ -3143,7 +3143,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
>  	 * Haswell CPUs.
>  	 */
>  	if (late_ack)
> -		apic_write(APIC_LVTPC, APIC_DM_NMI);
> +		apic_write(APIC_LVTPC, APIC_PERF_NMI);
>  	return handled;
>  }
>  
> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> index 9327eb00e96d..d284eff7849c 100644
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -30,6 +30,8 @@
>  #define APIC_EXTNMI_ALL		1
>  #define APIC_EXTNMI_NONE	2
>  
> +#define APIC_PERF_NMI		(APIC_DM_NMI | NMI_SOURCE_VEC_PMI)
> +
>  /*
>   * Define the default level of output to be very little
>   * This can be turned up by using apic=verbose for more
