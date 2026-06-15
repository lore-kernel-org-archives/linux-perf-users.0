Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CC02A1BF
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 01:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781485324; cv=none; b=e5urO+lv34m2/1jZbaEqAx4JKH4hYcZqLRTY7ZH1FADo7HD/A2y26k7LeTvPaJSa+TC/xFhOz0HOfqGb7sJ/ylr+h7SXc7v+vwNdoXlGLup4oTgtwxsi9Ph8f3amKNkid+NoeCSGmAVuDqy6iulpBObnHwhnL497PRABbwZNIeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781485324; c=relaxed/simple;
	bh=qhVi/BMik8rtsVpCECguOol8BUB6YspKoH7wqyqkxzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHTLvFi9XPAAvy/JSy+VMvnsHwQNdueubOJ0P18tILNuvS6PFTuKfVkgG1poSvlH+OvFbBLv8JgY02JhF86GtPkaWA5HT6kR3JuW/IDrngsr5UlUgSVhMVmq1c7v8KG2c6U7KzJM+9MTQhB9jHO8s68zp9U2UBii0uxaQCx1ZZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nlMoUdUJ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlMoUdUJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781485323; x=1813021323;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qhVi/BMik8rtsVpCECguOol8BUB6YspKoH7wqyqkxzw=;
  b=nlMoUdUJSufHCBVsNt8cJqsP+1IHqEnKsLv6iUUoIdzi4jQU0h/ep98l
   P6cC8hGkCEbKzrxyH4tBsCw1EwWU9SAATC5kVZRZZ++k75s6NF8iFcJUG
   SwG/ibato0oN6oaINMBLadMuY0gAbAnFSLUwC3+Hd7rsxdOMyv1iKZaZZ
   iy1S8nCqi5B0E+fcMq3irQNWij6guh819EOIgPG4pWjv8d/EOwZehLyNZ
   D6W++KPqlCHpgqU5C+pwTb1MeDkBjyu7OA8Cy5VjyBmOYGxJKF0x6VqUn
   rH6AWlnid1iVS763KG6WlwDOeQTEn7KAssvDwK0nSppTbzpV4NXdH03B9
   g==;
X-CSE-ConnectionGUID: Q4CxUhoyQwy9YWShfEdbLw==
X-CSE-MsgGUID: ons+MoeCQPOMfQ0Gf0t7zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="92896982"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="92896982"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 18:02:03 -0700
X-CSE-ConnectionGUID: nlJgTxI8TTmD1Zx4aGXFbg==
X-CSE-MsgGUID: QzpexoT1SOaM1dVNBtpCTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="251254600"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 18:02:02 -0700
Message-ID: <42faee03-e583-42e8-a75d-9c4ed43ed7dd@linux.intel.com>
Date: Mon, 15 Jun 2026 09:01:59 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 4/8] perf/x86/intel: Fix kernel address leakages in LBR
 stack
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260612090114.3188886-5-dapeng1.mi@linux.intel.com>
 <20260612091842.8E8AB1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260612091842.8E8AB1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/12/2026 5:18 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Missing Privilege Escalation/Leakage Fix in AMD LBR
> --
>
> commit c04d9132d61b165193dd28c5a358e42d3c52a350
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/intel: Fix kernel address leakages in LBR stack
>
> This commit fixes a kernel address leakage in the Intel LBR stack when
> PERF_SAMPLE_BRANCH_USER is requested. The intel_pmu_lbr_filter function
> previously only validated the privilege level of the "to" address, leaving
> kernel "from" addresses exposed on SYSRET/ERET branches. The fix extends
> software filtering to validate both addresses against the requested filter.
>
> Cc: stable@vger.kernel.org
> Reported-by: Ian Rogers <irogers@google.com>
> Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> index e2657f791e507..16eef15378166 100644
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
> [ ... ]
>
>> @@ -1244,8 +1244,14 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>>  				type |= X86_BR_NO_TX;
>>  		}
>>  
>> -		/* if type does not correspond, then discard */
>> -		if (type == X86_BR_NONE || (br_sel & type) != type) {
>> +		from_plm = kernel_ip(from) ? X86_BR_KERNEL : X86_BR_USER;
>> +		/*
>> +		 * If type does not correspond, then discard.
>> +		 * Specifically reject entries whose from address is in
>> +		 * kernel space when only X86_BR_USER is requested.
>> +		 */
>> +		if (type == X86_BR_NONE || (br_sel & type) != type ||
>> +		    (!(br_sel & X86_BR_KERNEL) && (from_plm & X86_BR_KERNEL))) {
> [Severity: High]
> This isn't a bug introduced by this patch, but does the exact same kernel
> address leakage vulnerability exist in AMD's LBR implementation and remain
> unpatched?
>
> Looking at amd_pmu_lbr_filter() in arch/x86/events/amd/lbr.c, it relies on
> branch_type_fused() to determine the branch type. For kernel-to-user branches
> (like SYSRET), it evaluates the privilege purely based on the target (to)
> address and returns X86_BR_SYSRET | X86_BR_USER.
>
> When user-only branches are requested, br_sel includes X86_BR_USER and
> X86_BR_ANY. Because AMD hardware will record kernel-to-user branches when
> filtering by "ending in CPL > 0", the check in amd_pmu_lbr_filter():
>
>     if (type == X86_BR_NONE || (br_sel & type) != type) {
>         cpuc->lbr_entries[i].from = 0;
>         compress = true;
>     }
>
> evaluates to false since type is fully satisfied by br_sel. This allows the
> branch to bypass the software filter and leaks the kernel from addresses to
> unprivileged users.
>
> Should a similar from_plm validation check be added to amd_pmu_lbr_filter()
> to prevent KASLR bypass on AMD systems?

AMD guys have known the issue, suppose they would post the fix separately.
Thanks.


>
>>  			cpuc->lbr_entries[i].from = 0;
>>  			compress = true;
>>  		}
