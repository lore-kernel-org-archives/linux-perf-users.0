Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8303803C3
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297046; cv=none; b=Y3tyA0k8+v/mKIzwbrerih1yLIsdrfXowTl2aCxeiQNIC51zy7f0mdb91TxG7ObGjGtMObGR9Kx7CihhVx7OhOY+B0nzxxIwUq9Bcf/s6BhSNgTkAElARzvjrt0n0HSiHvieLytc2pMikx5Wu+wu603e7rGtVPxX9/YfnJnFZWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297046; c=relaxed/simple;
	bh=rf2ub5rKKHW/q4CNq/Z2j9d34U3dV6/FffF5KqSTMcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pe4luTligSlo3L9rWAyEaX4lwaCGdd7HRYBmdTQUSm6Su9LG6bXAcfaoHpGPaT8uJp6U2D0EIFlNcKPRKS1zHh7t/F3MoiEjikMAlLJsKhHLxCcKBSrQh5/UHp5pEMe9wUZNNGEbdz3JHEFqxqrquoNh+1wRCtFFc6hHTsKPoTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBVvuisN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBVvuisN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780297045; x=1811833045;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rf2ub5rKKHW/q4CNq/Z2j9d34U3dV6/FffF5KqSTMcc=;
  b=DBVvuisNRGS+k4S27DGqLh07S4Yj7PAhapVwyk4I1u/p7C27NmL4lQb7
   hTfmMjpbR22XEi6m9iJLoZUmJH3kDbVAQoI32mEePgkP61wnRLrEhJUfr
   G9QIDGM0rwpxguKUEFtL0Z+RnpHbxG9tSm8eSCM28OeuwsuIGG6zVQWNA
   lIcbdbSg2EFHXUwiHjWyl3Ohqo9QQOID/9dPf0BAznPmb94bzjfj5T8ii
   ZlYznSiPJyRhtFR4LdDOqkDWnkFWZM+b2fCMPzx8L9056RS9xM51HbGhT
   XHCziP5jnzV8Md9qJOSabIRbwqMiaR8p7TCXoWPaDt64zZJ5u/eUcpx7z
   Q==;
X-CSE-ConnectionGUID: bhLpIL3wTWmf9hnIApBN4Q==
X-CSE-MsgGUID: uDYQDz7KROqTFJYgjbhG7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="92521120"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="92521120"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 23:57:25 -0700
X-CSE-ConnectionGUID: q5qtzKTDS3OH17JnbtGAVQ==
X-CSE-MsgGUID: hVkq+HdoTdSKxQ7CPgSPNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="247465186"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 23:57:23 -0700
Message-ID: <4dd94692-b60f-4c84-9207-e84f70bdd637@linux.intel.com>
Date: Mon, 1 Jun 2026 14:57:21 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v8 13/23] perf/x86: Support XMM sampling using
 sample_simd_vec_reg_* fields
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260529075645.580362-14-dapeng1.mi@linux.intel.com>
 <20260529084935.C73AE1F00893@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260529084935.C73AE1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/29/2026 4:49 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] The validation logic in `perf_simd_reg_validate()` strictly checks unused, flag-gated syscall parameters outside of their respective flag scopes, breaking ABI compatibility.
> --
>
> commit aeb4cf15401ade404bfd333c1c769dd23251abf8
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86: Support XMM sampling using sample_simd_vec_reg_* fields
>
> This patch adds support for sampling XMM registers using the new
> sample_simd_vec_reg_* fields. It introduces ABI tracking for perf_regs
> on x86 and implements validation logic for SIMD registers.
>
>> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
>> index 81204cb7f7239..7b9b38c189de2 100644
>> --- a/arch/x86/kernel/perf_regs.c
>> +++ b/arch/x86/kernel/perf_regs.c
> [ ... ]
>> @@ -74,6 +77,71 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
> [ ... ]
>> +int perf_simd_reg_validate(u16 simd_enabled, u16 vec_qwords,
>> +			   u64 vec_mask_intr, u64 vec_mask_user,
>> +			   u16 pred_qwords, u32 pred_mask_intr,
>> +			   u32 pred_mask_user)
>> +{
>> +	u64 size;
>> +
>> +	if (!simd_enabled) {
>> +		if (vec_qwords || vec_mask_intr || vec_mask_user ||
>> +		    pred_qwords || pred_mask_intr || pred_mask_user)
>> +			return -EINVAL;
> [Severity: Critical]
> Are we unconditionally validating syscall parameters outside their flag scopes
> here?
>
> If userspace sets PERF_SAMPLE_REGS_USER but does not set
> PERF_SAMPLE_REGS_INTR, the vec_mask_intr and pred_mask_intr parameters
> could contain uninitialized stack garbage. Because userspace is not required
> to zero-fill unused arguments, returning -EINVAL for garbage in these unused
> masks could break ABI compatibility for programs recompiled against newer
> kernel headers.

Hmm, it makes sense partly. Would add sample_type argument into this
function and check more accurately.

Thanks.


>
>> +		return 0;
>> +	}
>> +
>> +	if (!vec_qwords) {
>> +		if (vec_mask_intr || vec_mask_user)
>> +			return -EINVAL;
>> +	} else {
>> +		if (vec_qwords != PERF_X86_XMM_QWORDS)
>> +			return -EINVAL;
>> +		if ((!vec_mask_intr && !vec_mask_user) ||
>> +		    (vec_mask_intr & ~PERF_X86_SIMD_VEC_MASK) ||
>> +		    (vec_mask_user & ~PERF_X86_SIMD_VEC_MASK))
>> +			return -EINVAL;
> [Severity: Critical]
> Similarly, could checking these masks cause false -EINVAL errors
> if only one of the sampling flags (INTR or USER) is enabled?
>
> If PERF_SAMPLE_REGS_USER is enabled but PERF_SAMPLE_REGS_INTR is disabled,
> vec_mask_intr might contain random bits that fail the PERF_X86_SIMD_VEC_MASK
> check. Should these validation checks be gated behind the presence of their
> respective flags in the sample_type to prevent regressions?
>
>> +	}
>> +
>> +	if (pred_qwords || pred_mask_intr || pred_mask_user)
>> +		return -EINVAL;
>> +
>> +	size = ((vec_qwords * hweight64(vec_mask_intr)) +
>> +		(vec_qwords * hweight64(vec_mask_user)) +
>> +		(pred_qwords * hweight32(pred_mask_intr)) +
>> +		(pred_qwords * hweight32(pred_mask_user))) * sizeof(u64);
>> +	if (size > U16_MAX)
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
