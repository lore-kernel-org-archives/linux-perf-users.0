Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608811AEFDD;
	Thu,  4 Jul 2024 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104269; cv=none; b=IyNBAFvSeKE4IRg3gM0WkuU2OrG6B1l4kdhrszN8f4IuN08msVw7PhGplS0nwiPhJfKbXlqxqd0s9raDsbpYiS0TuEJ5BHiEa+S+efNs40eG2zy8t1JzqT8EFU9528ATF/4dxr9G6nHobFPq581gxCg5vwFVyyCVgGsokXM/wHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104269; c=relaxed/simple;
	bh=jFqIYxXq+6hlKrJxZ91m3PC8f8pW1y9uuJtUbuuX41E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KyTr/ebG0ROrIIP7beJMlp+d9ZwY/fozgCHQirgCROFsNo8OWU05ecIoBF5P75aRCjLuBT1HI00dkRD67ZYI9QB7dGWN/5q+J6ZKIIYMeULohoTQLwe9id/+CnOtyWzs/a22nru+pei/nlyty+HBlg/YjocUQkxj8JfCXoDGy10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ww3rDDEf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ww3rDDEf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720104268; x=1751640268;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jFqIYxXq+6hlKrJxZ91m3PC8f8pW1y9uuJtUbuuX41E=;
  b=Ww3rDDEfbAEbGXOnftTaZYjYQr7jrLS426hhRtmI7u6jsHZglHh4p1k1
   mXNqCUOkvODQgwVBd3ABY+mxBlFz7iCzIhpZrrmtoLjHXS2cr3FsRwk0x
   3DZ5FIBVgi3Q4brEX1+pjn/DNtYN1fOagcB4JiGIjNDwMmF/7dFx5SlYd
   lMq6ojVohEfBmdRWRd1KQzO/l7uVK7IKC/fiN0AZiXX17M90l4rZvrenK
   lJ4mGdd9S0pA3i3nxyzySCucXTKH/aoXKZHzr2uqkUGBpek1fO+iyjeOF
   qJQEzeYDlqVnPGAegZwd/VvY5YT9mwgHfA6EeIQnSVqRqqqBDSz7K0fMh
   A==;
X-CSE-ConnectionGUID: hWHeUhoVTYO/A3pGugZ3QA==
X-CSE-MsgGUID: xpy063gHS+CliJZ1R2IcEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="39902096"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="39902096"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 07:44:27 -0700
X-CSE-ConnectionGUID: SLKlEolvShywUXzgv/ptYQ==
X-CSE-MsgGUID: jos7xj73SBKFk6dHCTBvLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="77355967"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 07:44:28 -0700
Received: from [10.209.189.199] (kliang2-mobl1.ccr.corp.intel.com [10.209.189.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 4764D204150D;
	Thu,  4 Jul 2024 07:44:25 -0700 (PDT)
Message-ID: <f5ec09c0-db5e-4c2f-b516-964e8d7eb2af@linux.intel.com>
Date: Thu, 4 Jul 2024 10:44:23 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] perf/x86: Enable NMI source reporting for
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
 Andi Kleen <andi.kleen@intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
 Zeng Guang <guang.zeng@intel.com>
References: <20240628201839.673086-1-jacob.jun.pan@linux.intel.com>
 <20240628201839.673086-9-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240628201839.673086-9-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-06-28 4:18 p.m., Jacob Pan wrote:
> Program the designated NMI source vector into the performance monitoring
> interrupt (PMI) of the local vector table. PMI handler will be directly
> invoked when its NMI is generated. This avoids the latency of calling all
> NMI handlers blindly.
> 
> Co-developed-by: Zeng Guang <guang.zeng@intel.com>
> Signed-off-by: Zeng Guang <guang.zeng@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> ---
> v3: Program NMI source vector in PVTPC unconditionally (HPA)
> v2: Fix a compile error apic_perfmon_ctr is undefined in i386 config
> ---
>  arch/x86/events/core.c       | 6 ++++--
>  arch/x86/events/intel/core.c | 6 +++---
>  arch/x86/include/asm/apic.h  | 1 +
>  3 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 1ef2201e48ac..be75bdcdd400 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -46,6 +46,7 @@
>  
>  struct x86_pmu x86_pmu __read_mostly;
>  static struct pmu pmu;
> +u32 apic_perfmon_ctr = APIC_DM_NMI;>
>  DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
>  	.enabled = 1,
> @@ -1680,7 +1681,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
>  	 * This generic handler doesn't seem to have any issues where the
>  	 * unmasking occurs so it was left at the top.
>  	 */
> -	apic_write(APIC_LVTPC, APIC_DM_NMI);
> +	apic_write(APIC_LVTPC, apic_perfmon_ctr);
>  
>  	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
>  		if (!test_bit(idx, cpuc->active_mask))
> @@ -1723,7 +1724,8 @@ void perf_events_lapic_init(void)
>  	/*
>  	 * Always use NMI for PMU
>  	 */
> -	apic_write(APIC_LVTPC, APIC_DM_NMI);
> +	apic_perfmon_ctr |= NMI_SOURCE_VEC_PMI;
> +	apic_write(APIC_LVTPC, apic_perfmon_ctr);


It looks like the same value is written unconditionally.

Why not use a macro, e.g., APIC_DM_NMI_WITH_SOURCE, to replace the variable?

Thanks,
Kan

>  }
>  
>  static int
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 38c1b1f1deaa..b4a70457c678 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3093,7 +3093,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
>  	 * NMI handler.
>  	 */
>  	if (!late_ack && !mid_ack)
> -		apic_write(APIC_LVTPC, APIC_DM_NMI);
> +		apic_write(APIC_LVTPC, apic_perfmon_ctr);
>  	intel_bts_disable_local();
>  	cpuc->enabled = 0;
>  	__intel_pmu_disable_all(true);
> @@ -3130,7 +3130,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
>  
>  done:
>  	if (mid_ack)
> -		apic_write(APIC_LVTPC, APIC_DM_NMI);
> +		apic_write(APIC_LVTPC, apic_perfmon_ctr);
>  	/* Only restore PMU state when it's active. See x86_pmu_disable(). */
>  	cpuc->enabled = pmu_enabled;
>  	if (pmu_enabled)
> @@ -3143,7 +3143,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
>  	 * Haswell CPUs.
>  	 */
>  	if (late_ack)
> -		apic_write(APIC_LVTPC, APIC_DM_NMI);
> +		apic_write(APIC_LVTPC, apic_perfmon_ctr);
>  	return handled;
>  }
>  
> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> index 9327eb00e96d..bcf8d17240c8 100644
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -49,6 +49,7 @@ static inline void x86_32_probe_apic(void) { }
>  #endif
>  
>  extern u32 cpuid_to_apicid[];
> +extern u32 apic_perfmon_ctr;
>  
>  #define CPU_ACPIID_INVALID	U32_MAX
>  
