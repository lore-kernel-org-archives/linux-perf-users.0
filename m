Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7A93264FD
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 01:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783474047; cv=none; b=VlpsCGaF4N8buLQfg7EqC2cWhhAlN6B/mdwRKi1sV0gGK2m1ktFY8kcI7gOvYD7J0pcXAfss4C34sDPQR4EQVk6e+17ZSxwyszl7rYg15DefcuH560Kb+7mt8+wZ+JMMrJuNEoVs/hkSMYCbQ7bRnZ6FOYsBxWc4fdmfK/cnx10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783474047; c=relaxed/simple;
	bh=yBG5PM6JYI8Pn7vjHVqVJ5cRlfNBGbpJi08+sRY33Uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6duOaKxZwoEcINjB+qq0E2gkd1lyybZp1teC6R0l3F/D6K4GDNLb5eFMBRSwuIQQiILUTqIAD6OohrQXEdSwefN53iXDyJixuzrI2UCsssuMP9fNdmFu+gRYX9Mj75qEWMFtb2mIiUpfCQJ7yQozumX5+ojOaKQ6sVcW1vVPJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J/cIeGCf; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J/cIeGCf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783474047; x=1815010047;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yBG5PM6JYI8Pn7vjHVqVJ5cRlfNBGbpJi08+sRY33Uc=;
  b=J/cIeGCfpf5t/XDxPLlxGqKseGadpoUkEQpC7LdmFgbdkWBcfi9bwWni
   ld2jlfMFLnYzGUEYqE7IbG7KdkkDJPHfHlX7/neLvYnU3FwWUpldOl0UH
   C1VPJWDokgFbVnmFy5/WMFiPWoQjsy1/FHNlfl5JuM+zhJhE/pYDILvIE
   7y3JWtsVqjPJruKfFLHkxhmGg4/MvEDPfvzEpZoqPA7YMGFU0Z0yoDjHy
   T+Tu0EYckFADOLoP9wg1ROv7Yn8SVMtlxdJ8Wal3RgZnXjbKRfDNu24Ft
   Z+EGuW+Q2stLlsdFd/ifnoxzKhkxIYOYH6vAS3od+OVdTz9XalPQ6hLC9
   A==;
X-CSE-ConnectionGUID: u53fWdWeRbOgC8aUPKHFQQ==
X-CSE-MsgGUID: KV8rn4ZWRJeEaQ+iP8SDSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="83908204"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="83908204"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 18:27:26 -0700
X-CSE-ConnectionGUID: US24AGCRQYagt7NYU2MnMA==
X-CSE-MsgGUID: 5W6xo2XgQgKpsw/VUFQ6IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="258026960"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 18:27:25 -0700
Message-ID: <73610adf-97b4-4144-87a3-3053be778cbf@linux.intel.com>
Date: Wed, 8 Jul 2026 09:27:22 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 14/24] perf/x86: Support XMM sampling using
 sample_simd_vec_reg_* fields
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
 <20260706015439.3040804-15-dapeng1.mi@linux.intel.com>
 <20260706064600.6D7BA1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260706064600.6D7BA1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/6/2026 2:45 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [Medium] Validation logic unconditionally evaluates flag-gated syscall parameters (`vec_mask_user`, `pred_mask_user`) without checking their respective flag gates, leading to validation bypasses due to uninitialized garbage.
>
> Pre-existing issues:
> - [Critical] The functions `perf_reg_value` and `perf_simd_reg_value` unsafely assume the provided `pt_regs *` is always embedded within an `x86_perf_regs` structure, leading to out-of-bounds reads and arbitrary pointer dereferences for software events and `PERF_SAMPLE_REGS_USER`.
> --
>
> commit 9c74aceec4401218b750679a5b08ba8009aa85a3
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86: Support XMM sampling using sample_simd_vec_reg_* fields
>
> This commit adds support for sampling XMM registers by introducing a new ABI
> field and extracting XMM values through the sample_simd_vec_reg_* fields. It
> adds a new perf_simd_reg_value function to retrieve the values and updates
> the SIMD registration validation logic.
>
>> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
>> index 81204cb7f7239..8514baefb400e 100644
>> --- a/arch/x86/kernel/perf_regs.c
>> +++ b/arch/x86/kernel/perf_regs.c
> [ ... ]
>
>> @@ -63,6 +63,9 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
>>  
>>  	if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
>>  		perf_regs = container_of(regs, struct x86_perf_regs, regs);
>> +		/* SIMD registers are moved to dedicated sample_simd_vec_reg */
>> +		if (perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
> [Severity: Critical]
> This isn't a bug introduced by this patch, but evaluating perf_regs->abi
> here relies on an unsafe cast.
>
> For tracepoints and PERF_SAMPLE_REGS_USER, regs points to a bare pt_regs
> instance rather than an embedded x86_perf_regs struct. The container_of()
> cast accesses memory outside the bounds of the pt_regs struct.
>
> Could this allow an attacker to control the out-of-bounds pointers (like
> xmm_regs) and read arbitrary kernel memory into the perf ring buffer?

This is not a bug. The software PMU has no such caps,
PERF_PMU_CAP_EXTENDED_REGS or PERF_PMU_CAP_SIMD_REGS, so if software events
want to sample these extended regs, the event creation would fail.


>
>> +			return 0;
>>  		if (!perf_regs->xmm_regs)
>>  			return 0;
>>  		return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
> [ ... ]
>
>> @@ -74,6 +77,77 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
>>  	return regs_get_register(regs, pt_regs_offset[idx]);
>>  }
>>  
>> +u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
>> +			u16 qwords_idx, bool pred)
>> +{
>> +	struct x86_perf_regs *perf_regs =
>> +			container_of(regs, struct x86_perf_regs, regs);
>> +
>> +	if (!(perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD))
> [Severity: Critical]
> This is a pre-existing issue, but this new code copies the same unsafe
> container_of() cast pattern.
>
> Since regs is not actually embedded in an x86_perf_regs struct when
> called for PERF_SAMPLE_REGS_USER, reading perf_regs->abi reads
> out-of-bounds memory.

Ditto.


>
>> +		return 0;
>> +
>> +	if (pred)
>> +		return 0;
> [ ... ]
>
>> +int perf_simd_reg_validate(u64 sample_type, u16 simd_enabled,
>> +			   u16 vec_qwords, u64 vec_mask_intr,
>> +			   u64 vec_mask_user, u16 pred_qwords,
>> +			   u32 pred_mask_intr, u32 pred_mask_user)
>> +{
>> +	u64 size = 0;
>> +
>> +	if (!(sample_type &
>> +	      (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)))
>> +		return 0;
>> +
>> +	if (!simd_enabled)
>> +		return 0;
>> +
>> +	if (vec_qwords) {
>> +		if (vec_qwords != PERF_X86_XMM_QWORDS)
>> +			return -EINVAL;
>> +		if (!vec_mask_intr && !vec_mask_user)
>> +			return -EINVAL;
> [Severity: Medium]
> Does this logic evaluate flag-gated parameters without checking their
> respective flag gates?
>
> PERF_SAMPLE_REGS_INTR and PERF_SAMPLE_REGS_USER are independent flags. If a
> user sets INTR but not USER, vec_mask_user is outside its flag gate and
> can contain arbitrary garbage from userspace.
>
> If vec_mask_intr is 0 (an invalid configuration), but the garbage in
> vec_mask_user is non-zero, this check passes and the validation is bypassed.
>
> Should these masks be validated against their respective sample_type flags
> before checking if they are both empty?

Yes, the perf_simd_reg_validate() would be enhanced to validate the
REGS_USER and REGS_INTR configuration separately.

Thanks.


>
>> +		if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
>> +		    (vec_mask_intr & ~PERF_X86_SIMD_VEC_MASK))
>> +			return -EINVAL;
