Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E233312837
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 03:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776135631; cv=none; b=jg1/invQ+pJh9Aj1l8/72ZbCh1ANmtKuYIhgVOgzw4qjMkn6OU69jpRt4zPoA1TFDst7nL2D7fospZQX25xeBquv77nXKb65OwxjPRBPu+fhgNDu61KsLQTYo1ADA0oPOFWsXvzKGkJZsBYncZ/Nq9ahjJQqVHXsMh93mtYOwjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776135631; c=relaxed/simple;
	bh=snEL+u1iXKB5S1S+Xa0IgVvXR72Ovnt2OhYzwlBBdtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GmCSDlCn3EmNoOFVJNb8rIpCDNaS+gCj1bD5kDsOO4OzJl15d4UfFPYUDV6Bg3Zw8yX0i3YBVBVIXyb11wOrotEEDSVuSyZZicGN9ZaCQn7HzwcnCeUf7w6hhiuQL53K4d4t42vQgGBL+/dS15LaCuD/J6EVENthzrOkdlSclJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dr7lmbbt; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dr7lmbbt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776135629; x=1807671629;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=snEL+u1iXKB5S1S+Xa0IgVvXR72Ovnt2OhYzwlBBdtE=;
  b=Dr7lmbbtIVJRPaZseKdFdViNEX+8igaXCOoTlqCqSkWgrZpoSeBMZo+8
   vBmVSvAMh9lC7whxx4C3jAsZPnRqvn6QfGGMWXmaCKG+SSQdnu8rOMMTq
   a9vSgrZ8QaIxQDsGN0NZqRwOqjTZL5EHm7ZtjahoTe3dVQgyAdIxL86fR
   7s0h9bx+/4h+fExrdF7oCDksDyOwM3x7ExyMHjqa37jd5fLXaRtv0B9cb
   nRgYvHfPdH9gl/GcYtZCmW8DkYkU3Z+la2/DXuFXdPRNhsrrY871BZXB9
   sS7PfjMBjnnc8NIe7lMKW2vVbXtmlaO0HKpPG6w5HqEY91QcwJ986VTau
   g==;
X-CSE-ConnectionGUID: ieXvKT+hRMS1ubTfqXC8vw==
X-CSE-MsgGUID: rPBf3qaPQfWrwSgdgXQABw==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="80968088"
X-IronPort-AV: E=Sophos;i="6.23,178,1770624000"; 
   d="scan'208";a="80968088"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 20:00:28 -0700
X-CSE-ConnectionGUID: VvDCiJ0FTcmhjveoTx049A==
X-CSE-MsgGUID: zLDT/+htTUuT+2/W7UAGHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,178,1770624000"; 
   d="scan'208";a="234895467"
Received: from unknown (HELO [10.238.1.30]) ([10.238.1.30])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 20:00:28 -0700
Message-ID: <133ce7fc-3dcc-4e34-8101-b501107d4b5c@linux.intel.com>
Date: Tue, 14 Apr 2026 11:00:26 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf/x86/intel: Fix redundant branch type check in
 intel_pmu_lbr_filter()
To: sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260414021440.928068-1-dapeng1.mi@linux.intel.com>
 <20260414025359.E9F0FC2BCAF@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260414025359.E9F0FC2BCAF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/14/2026 10:53 AM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Medium] Meaningful code and commit message mismatch due to a false premise
> --
>
> commit 98c2839085a2b609f94d9f3f338217d29525fd08
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/intel: Fix redundant branch type check in intel_pmu_lbr_filter()
>
> This commit modifies the branch filter logic to mask out privilege level
> bits before checking if a branch type is X86_BR_NONE.
>
>> In intel_pmu_lbr_filter(), the 'type' variable is bitwise ORed with
>> 'to_plm' (which contains X86_BR_USER and/or X86_BR_KERNEL bits). Because
>> of this, 'type' can never equal X86_BR_NONE (0) after the assignment.
>>
>> As a result, the subsequent check 'if (type == X86_BR_NONE)' is dead code
>> and the entries with X86_BR_NONE type would not be skipped eventually.
> Is this description entirely accurate? 
>
> Looking at intel_pmu_lbr_filter(), the bitwise OR with to_plm only happens
> in the X86_FEATURE_ARCH_LBR path:
>
> intel_pmu_lbr_filter() {
>     ...
>     if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
>         type <= ARCH_LBR_BR_TYPE_KNOWN_MAX) {
>         to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
>         type = arch_lbr_br_type_map[type] | to_plm;
>     } else
>         type = branch_type(from, to, cpuc->lbr_entries[i].abort);
>     ...
> }
>
> In the software fallback path, type is assigned the result of branch_type().
> If branch_type() cannot decode the branch and returns X86_BR_NONE (0),
> wouldn't type evaluate to exactly X86_BR_NONE without any to_plm bits set?

No, the branch_type() would bitwise ored the to_plm at last as below code
shows.

```

/*
     * branch priv level determined by target as
     * is done by HW when LBR_SELECT is implemented
     */
    if (ret != X86_BR_NONE)
        ret |= to_plm;

```

Thanks.


>
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> index 72f2adcda7c68..16977e4c6f8a5 100644
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
>> @@ -1245,7 +1245,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>>  		}
>>  
>>  		/* if type does not correspond, then discard */
>> -		if (type == X86_BR_NONE || (br_sel & type) != type) {
>> +		if ((type & ~X86_BR_PLM) == X86_BR_NONE || (br_sel & type) != type) {
> While masking out ~X86_BR_PLM doesn't appear to break the software fallback
> behavior since (0 & ~X86_BR_PLM) == 0, the original check for X86_BR_NONE
> appears to have been functional and necessary for that path.
>
> Could the commit message be updated to clarify that the check was not actually
> dead code for the software fallback path?
>
