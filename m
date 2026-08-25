Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FABA233946
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Aug 2026 01:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787621427; cv=none; b=gikaj8MmG6557NruYtuvZoRwbwW6cJCKUqfN3RKn0WL+2O5nuvK+S474BzJrY4YmGljxOd93EPqpHA6DLq1d2UMgH+V9UAt+gZo7JsVqjmRXMiNoNBiz47LA5C8eM6OG8EB4lcm6SQtU3bvqhF1DPx4B6yQy2+eGJQX382jeebM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787621427; c=relaxed/simple;
	bh=xDnJuiEIKpZQaNrfUfvJ5gqcOD6H3VDivm+vcWwH3ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y70CSNw9Nf33fK8gCm4o6TYSA1E6Os2qW6cBBaz8hEE95onUhFyQl24QWHgNyMFSqjB8eAgeWRSwwhazQwjsnpxlUbUvMZzxxdr5zOYcaGlvFQ+zN2miqNDrMgzMnUGJ+D0RYEYgDcdgDwGZFWwzFSzM6Wfo6K7PsoAHgi0i140=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/oWceac; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/oWceac"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787621426; x=1819157426;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xDnJuiEIKpZQaNrfUfvJ5gqcOD6H3VDivm+vcWwH3ps=;
  b=l/oWceac0QuhtiEcsGPq+exnPvFPsSi5IOqwSBztP8vHxCilWvXdIGr2
   a/fsWLJWaqNUoQ0PNrihRefhEXUgeZ2UamEQX10zLcfumyOrSC4TXUkIE
   yeLUcF+kddQ9/D0vz3Zis43Myw/lQ5J8L9Bw3hxPVSolZaq5bklPsV+hx
   O7AdpyBSh56I8IF2qwj0PW7hvJQQwYP8ZKhujOjNJV89gmy7ki09V4zOD
   ft0xKcgaQ+PwEyr4By9LN2nB8KDoIniy5uA0tChGWYkilvR6Fz++ppJ07
   EnlH7gzzIhdP0qzjHbk/coLq59Xm/V5OS79/2QkSaH9HqC/N5rs6WsroT
   Q==;
X-CSE-ConnectionGUID: z7NmHPzGTw+QNwbbT0wDIA==
X-CSE-MsgGUID: GVDU94a5Q5Wxbb+d9zvlRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="99431975"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="99431975"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 18:30:25 -0700
X-CSE-ConnectionGUID: /kXOXLxtRvCY7KvszNjomQ==
X-CSE-MsgGUID: 94Y7HTIISWKr28AljOWcXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="266615851"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 18:30:24 -0700
Message-ID: <22b84e22-2f38-4ffb-a731-0ecf5b598f7c@linux.intel.com>
Date: Tue, 25 Aug 2026 09:30:22 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND Patch v10 15/23] perf/x86: Support ZMM sampling using
 sample_simd_vec_reg_* fields
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-16-dapeng1.mi@linux.intel.com>
 <20260824085828.79B8B1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260824085828.79B8B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/24/2026 4:58 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Relaxed vector mask validation allows users to request sampling of XMM16-31 and YMM16-31 registers, but the kernel silently outputs zeroes for them.
> --
>
> --- Patch [15]: [RESEND Patch v10 15/23] perf/x86: Support ZMM sampling using sample_simd_vec_reg_* fields ---
> commit 88766819a94c672c41219599404eada3a0d0fa19
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86: Support ZMM sampling using sample_simd_vec_reg_* fields
>
> This patch adds support for sampling up to 32 ZMM registers via the
> sample_simd_vec_reg_* fields. ZMM0-15 are assembled from XMM, YMMH,
> and ZMMH components, while ZMM16-31 are extracted as a whole.
>
>> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
>> index 01de7799f907b..f59551200f18c 100644
>> --- a/arch/x86/events/perf_event.h
>> +++ b/arch/x86/events/perf_event.h
> [ ... ]
>> @@ -209,6 +209,60 @@ static inline bool event_needs_ymm(struct perf_event *event)
> [ ... ]
>> +static inline bool __event_needs_high16_zmm(struct perf_event *event,
>> +					    u64 sample_type)
>> +{
>> +	if (!event->attr.sample_simd_regs_enabled)
>> +		return false;
>> +	if (event->attr.sample_simd_vec_reg_qwords < PERF_X86_ZMM_QWORDS)
>> +		return false;
> [Severity: Medium]
> Will this abort collection of high-register state for XMM16-31 or YMM16-31
> requests?
>
> When sample_simd_vec_reg_qwords is less than PERF_X86_ZMM_QWORDS (e.g., 2 for
> XMM or 4 for YMM), this returns false. Consequently, the hardware state for
> the high 16 registers is not extracted.
>
>> +
>> +	if ((sample_type & PERF_SAMPLE_REGS_USER) &&
> [ ... ]
>> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
>> index 0076974498eee..93370d4657860 100644
>> --- a/arch/x86/kernel/perf_regs.c
>> +++ b/arch/x86/kernel/perf_regs.c
> [ ... ]
>> @@ -123,7 +136,8 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
>>  
>>  	if (vec_qwords) {
>>  		if (vec_qwords != PERF_X86_XMM_QWORDS &&
>> -		    vec_qwords != PERF_X86_YMM_QWORDS)
>> +		    vec_qwords != PERF_X86_YMM_QWORDS &&
>> +		    vec_qwords != PERF_X86_ZMM_QWORDS)
>>  			return -EINVAL;
>>  		if (vec_mask & ~PERF_X86_SIMD_VEC_MASK)
>>  			return -EINVAL;
> [Severity: Medium]
> Does this validation allow users to request sampling of XMM16-31 and YMM16-31
> registers?
>
> With PERF_X86_SIMD_VEC_MASK expanded to 32 bits, this check now allows bits
> 16-31 to be set in the user mask for XMM and YMM requests.
>
> Because bitmap_full(&mask, PERF_X86_SIMD_XMM_REGS) only validates that the
> first 16 bits are set and ignores the rest, it won't reject masks that include
> the upper 16 registers.
>
> Combined with __event_needs_high16_zmm() returning false for non-ZMM requests,
> does this mean the kernel will silently accept invalid UAPI configurations for
> XMM16-31/YMM16-31 and return zeroes to userspace instead of actual data or an
> error?

Yeah, it's indeed a defect. Would submit a independent patch to enhance the
check. Thanks.


>
