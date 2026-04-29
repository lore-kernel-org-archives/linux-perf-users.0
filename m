Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D83330644
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777442415; cv=none; b=DqJ+YmjZsaQhS5V4+LmfTG6gbCls9on41n6oYg45tVrm3qwO5SZaopyPeMT8TgX6NhccN/+TDjOF+pfQ3os5SBFqvBbP/mlB0HYTZQ/qz62N13YhFHrzxJdLd+b6iVkSK6aOhHi7wZw/MB1clYNHlUlzgTIZ/SPTNyPx9hpyXqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777442415; c=relaxed/simple;
	bh=BkQ+ycFN9fP9M3cFVnTDaCMWDWWYU5TuhluCTCWkctI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBRa5htmBf30YOvRg+fgKAGAKfMZiyNN2yp0AvsjimLyXH5acWnpnS9FY379dMSpEnOZUMR20vXFx/RX6HP5cMbDEWWu2ksqsgb3G33FT8I5UBbwszyBFJLEV1Q6Dcd6Ar0dnRvgiW1C/zztnHw644U4SRX3f2VzPUQFkU6mVMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VDbqrCsf; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VDbqrCsf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777442414; x=1808978414;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BkQ+ycFN9fP9M3cFVnTDaCMWDWWYU5TuhluCTCWkctI=;
  b=VDbqrCsf7SDwTr7WEJkry1GiAWZup0GB8J1lWYEhSB/Mhb5eYneKF88k
   A9byc5ep4TuQuFJH8hYmiIlz1urQ7MQE5wrHiemNBJ2XOaGCgCEYVnqA3
   5UhM3L+hP+0R0+fD4kY9+6Op+SdXzgm/esVoEIfP+pzO5MejM4LIKtV8N
   EjkodDla/pITCXmnXjhJ2vTmEuociKNIr1h8j4Fq4+jlyrhBAOFAnqLkx
   MSwE7x4SwAj9E+q13ZHEuVZxKQ9fqY71ZsEs41UmA897LMb5Y2cL7Wg3o
   ceFB7Z+9DE6PP7xIATQlP4sAB+JCYyv8LY24VL3w4k3rsowv6F0fJJUHT
   Q==;
X-CSE-ConnectionGUID: o2gmybT4S7OkYWqwBXFd0w==
X-CSE-MsgGUID: jIZo1i1JTcOJN2jJKMYlgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78257764"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="78257764"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 23:00:13 -0700
X-CSE-ConnectionGUID: qMrBcwtBScSwPwwMk7okQw==
X-CSE-MsgGUID: 8OF/jeC2R5mHqdzVuITMNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="231028290"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 23:00:12 -0700
Message-ID: <6818d74c-7fe9-4cdb-9123-65683f60a5ed@linux.intel.com>
Date: Wed, 29 Apr 2026 14:00:10 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v7 23/24] perf/x86: Activate back-to-back NMI detection
 for arch-PEBS induced NMIs
To: sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260324004118.3772171-24-dapeng1.mi@linux.intel.com>
 <20260425033158.D3A29C19425@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260425033158.D3A29C19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/25/2026 11:31 AM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 2 potential issue(s):
> - [High] Incorrect bitwise operation in intel_pmu_drain_pebs_nhm() corrupts the processed events count.
> - [High] Removing the unconditional `handled` increment causes valid PMIs to be reported as unhandled when `drain_pebs()` returns 0.
> --
>
> commit 0317f48597bdef9b4d93c696bde043840ac1fc6b
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86: Activate back-to-back NMI detection for arch-PEBS induced NMIs
>
> This patch modifies the PEBS handlers to return the count of actually
> processed events instead of void. This count is used in the PMI handler
> to activate back-to-back NMI detection and avoid "suspicious NMI" warnings.
>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
> [ ... ]
>
>> @@ -3558,9 +3558,8 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>>  	if (__test_and_clear_bit(GLOBAL_STATUS_BUFFER_OVF_BIT, (unsigned long *)&status)) {
>>  		u64 pebs_enabled = cpuc->pebs_enabled;
>>  
>> -		handled++;
>>  		x86_pmu_handle_guest_pebs(regs, &data);
>> -		static_call(x86_pmu_drain_pebs)(regs, &data);
>> +		handled += static_call(x86_pmu_drain_pebs)(regs, &data);
> If x86_pmu_drain_pebs() returns 0, will handled fail to increment even though
> the hardware asserted an NMI and set the MSR status bit?
>
> This might happen if the host PEBS buffer is empty, such as when a guest PEBS
> event triggers the PMI and is handled by x86_pmu_handle_guest_pebs() right
> above it. 
>
> Could this cause the core NMI framework to treat the interrupt as unhandled
> and trigger an unknown NMI warning? Is it necessary to ensure handled
> increments by at least 1 when the status bit is explicitly acknowledged?

It's indeed an issue of the guest PEBS event. But for other host events, if
x86_pmu_drain_pebs() returns 0, then it means there must be something
wrong, we should not hide the issue.

I would add an exception for the guest PEBS event.


>
>>  		/*
>>  		 * PMI throttle may be triggered, which stops the PEBS event.
> [ ... ]
>
>> @@ -3587,8 +3586,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>>  	 */
>>  	if (__test_and_clear_bit(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT,
>>  				 (unsigned long *)&status)) {
>> -		handled++;
>> -		static_call(x86_pmu_drain_pebs)(regs, &data);
>> +		handled += static_call(x86_pmu_drain_pebs)(regs, &data);
> Does this share the same issue as above, where a return value of 0 from
> drain_pebs() would result in handled not being incremented for a valid PMI?

As the above mentioned, we should expose the issue if there are something
wrong.


>
> [ ... ]
>
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
> [ ... ]
>
>> @@ -3189,6 +3192,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>>  		if ((counts[bit] == 0) && (error[bit] == 0))
>>  			continue;
>>  
>> +		events_bitmap |= bit;
>>  		event = cpuc->events[bit];
> Will this perform a bitwise OR with the integer index itself rather than
> the expected bitmask?
>
> Because bit is an integer index (e.g., 0 for PMC0, 3 for PMC3), if only PMC3
> overflows, events_bitmap |= 3 (binary 011) results in hweight64(3) returning
> 2. If PMC0 overflows, events_bitmap |= 0 leaves the bitmap at 0.
>
> Should this be events_bitmap |= BIT_ULL(bit) or 1ULL << bit to correctly
> record the processed events?

Yes, we also found this issue locally. Would fix it in next version.

Thanks.


>
