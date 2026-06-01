Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38A33314B9
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 07:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780298077; cv=none; b=rtJIZd0uIqO386PyDeBHr196KxGYWvlEBJhP/oiiXdnCQgzkFMmgv/w3Z5iCJQ+1M8tWi99Af2zKsf1ruAQfEcLAa1t2v3uPkQgD1xtK00cQ0Kex68hwoJlxA+QxnQjHCsXslmklTarOvMtTaFf8EU0OtKpo+cYsbc672qofXSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780298077; c=relaxed/simple;
	bh=RXNHJqsRLxRjxYiSLZQML7BAh8g4+PfRZhrk7wzvgoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZugmG2pg1pynw1Doay7MqWkb50cnS58jnX1e4eoYwqQN4eBkAJJU5Lr+lFeq4JKGBtBFkz0ItcHrn+RqPMj16nVwXBLhrx8DZjqPgXZq+8kl7VXSmmcyEslZTE8vW2hJ7foiVfetjHri+oNo15uHy6Py0rgsvNMBie8sdXCyARM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JbE5pCk2; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JbE5pCk2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780298076; x=1811834076;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RXNHJqsRLxRjxYiSLZQML7BAh8g4+PfRZhrk7wzvgoE=;
  b=JbE5pCk2Gf7YKLL9J2KQgCCAdO2frd+qtcSm9AWAdG7UB+hCqVY3jXUS
   SzGj8+K//dYrAY6t8HHecqSakpYG5Le5dolxtjsEWKxQCkOFicjjrooUr
   +x8l9CFDIwIpON5QTZb0Dw542PntnwWeW9XC0/HOqhJrqqwBTQxGgeHOk
   zo1B12fhqYE/KumD92wjkdUs1XRJyHl22I++x+EsPe06jwYC7L7gbCreh
   dwCfrOxSgxuFoQPcnX46fmnVqoLnydRzKuMsKFvzH0nOY4UiNlBxKNSXV
   Gk8/TgjndnBwHoUvcm4RhBeKZsBBwjKNASzDp2n5HUinTGis/U2amnoNE
   w==;
X-CSE-ConnectionGUID: ohtajoLmRTaxtAOT19JmeA==
X-CSE-MsgGUID: NSSmCFgbSuu6eqj9PWTM3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="80187824"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="80187824"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 00:14:35 -0700
X-CSE-ConnectionGUID: FgSuiE2OTz24NqTSd5FLpw==
X-CSE-MsgGUID: Cl/ECFuwRUmLX+xHpdtPew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="248409220"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 00:14:34 -0700
Message-ID: <ed9aca04-2ce2-40d8-b286-524c145f6612@linux.intel.com>
Date: Mon, 1 Jun 2026 15:14:31 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v8 14/23] perf/x86: Support YMM sampling using
 sample_simd_vec_reg_* fields
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260529075645.580362-15-dapeng1.mi@linux.intel.com>
 <20260529084759.A4F051F00893@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260529084759.A4F051F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/29/2026 4:47 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [Medium] The `event_needs_ymm()` function evaluates flag-gated syscall parameters outside their corresponding flag gate (`PERF_SAMPLE_REGS_USER` / `PERF_SAMPLE_REGS_INTR`).
>
> Pre-existing issues:
> - [High] The function `perf_simd_reg_validate` improperly returns an error when unused, flag-gated parameters are not zero-filled, breaking ABI compatibility.
> --
>
> commit f738764532819a2044a1239c400d83c8404d4843
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86: Support YMM sampling using sample_simd_vec_reg_* fields
>
> This patch introduces support for sampling YMM registers via the
> sample_simd_vec_reg_* fields. It updates the perf_simd_reg_value function
> to assemble the XMM and YMMH halves into a complete YMM register and
> sets the sample_simd_vec_reg_qwords to 4 for YMM sampling.
>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
> [ ... ]
>> @@ -1967,6 +1973,8 @@ static void x86_pmu_sample_xregs(struct perf_event *event,
>>  
>>  	if (event_needs_xmm(event))
>>  		mask |= XFEATURE_MASK_SSE;
>> +	if (event_needs_ymm(event))
>> +		mask |= XFEATURE_MASK_YMM;
>>  
>>  	mask &= x86_pmu.ext_regs_mask;
>>  	if (sample_type & PERF_SAMPLE_REGS_USER) {
> [Severity: Medium]
> Does this evaluate flag-gated syscall parameters outside their flag gate?
>
> According to the syscall parameter trust boundaries, userspace is not
> required to zero-fill unused fields, so they may contain arbitrary garbage
> when their flag is absent.
>
> The event_needs_ymm() helper checks event->attr.sample_simd_regs_enabled
> and event->attr.sample_simd_vec_reg_qwords.
>
> However, in x86_pmu_sample_xregs(), this check happens before we verify if
> the sample type actually includes PERF_SAMPLE_REGS_USER or
> PERF_SAMPLE_REGS_INTR.
>
> Could this cause the kernel to read uninitialized userspace values when
> those sample_type flags are not set?

Ok, would check if PERF_SAMPLE_REGS_INTR or PERF_SAMPLE_REGS_USER is set
before calling x86_pmu_sample_xregs(), like this,

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f990256fb2ff..cf621ab2cd46 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2060,6 +2060,10 @@ void x86_pmu_update_perf_regs(struct perf_event *event,
 {
        u64 sample_type = event->attr.sample_type;

+       if (!(sample_type &
+             (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)))
+               return;
+
        if (!event_needs_xmm(event) &&
            !event_has_simd_regs(event))
                return;

>
>> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
>> --- a/arch/x86/kernel/perf_regs.c
>> +++ b/arch/x86/kernel/perf_regs.c
> [ ... ]
>> @@ -121,7 +128,8 @@ int perf_simd_reg_validate(u16 simd_enabled, u16 vec_qwords,
>>  		if (vec_mask_intr || vec_mask_user)
>>  			return -EINVAL;
>>  	} else {
>> -		if (vec_qwords != PERF_X86_XMM_QWORDS)
>> +		if (vec_qwords != PERF_X86_XMM_QWORDS &&
>> +		    vec_qwords != PERF_X86_YMM_QWORDS)
>>  			return -EINVAL;
> [Severity: High]
> This isn't a bug introduced by this patch, but does the surrounding
> validation code in perf_simd_reg_validate() inappropriately reject legal
> syscalls?
>
> When simd_enabled is 0, the function checks if vec_qwords, vec_mask_intr,
> and other parameters are zero, returning -EINVAL if they are not.
>
> Since userspace isn't required to zero-fill unused arguments outside their
> flag gate, these parameters could contain garbage.
>
> Is it possible that enforcing zero-fill on these unused arguments
> functionally breaks ABI compatibility by failing requests that should be
> valid under the trust boundary rules?

As previous comments said, would introduce an extra argument "sample_type"
for perf_simd_reg_validate() and then do corresponding validate more
accurately.

Thanks.


>
