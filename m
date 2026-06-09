Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92E5388371
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998034; cv=none; b=QcM2FcIHr8+vh48awgQdJxpahR3cwcCvOVB/RILHVnefiwgztylcMkDMQFya+XUFTqDCphFyK9yRvdIboR3AErKaqgbt596rtoGNF/RRZBEdjFbdS2rxMQSN0bAuUBZLnPZoivb+MLLggh2craIWAUXXAZUVP5JFIjiFusO2INg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998034; c=relaxed/simple;
	bh=FJLCTGuJhMCEoNGqlEV+f8PRH+CAzvgQ3BPnKyRY1HQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3o/F5JJZAffPRGYrzQ6qm/SUOWD3JVX+s2lyX8H+WUzyixgY0gMyJ7G1SqDzti1NMQ5OLSuV1EV0BUO/ytbUxeVodsBkwJ07JoSN3MVFfoOPBujFuGvGG62VyCdWPlDYB4Q0f5YaFUUcdBHlGA4bnMyzbh+FCRoM0gl5ySVIak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBg5/8lv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBg5/8lv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780998033; x=1812534033;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FJLCTGuJhMCEoNGqlEV+f8PRH+CAzvgQ3BPnKyRY1HQ=;
  b=IBg5/8lvLY3tvpFazjLNLroQl+9/MDJ8VvLrDOMlczSxYI+cyVyO15PP
   JhuS/gkeecsMC/c8hwcjL/7HdyJzDaR4w3uiSucd3rLDVCOcLTXmMIcqR
   der9PuUrd3s3xerVSnP72it1bBLPtBAUCthgmSQuGR7YBV9IEmitVKre/
   zAMyZ1rgbAEskDCK+Ddrp98TN/1QRS/SOO++DVIYTdhV1bgBhrINP3m9N
   wL7AGSMfKOmJ61nFNtRaX98pzbgh3hYnVjJBG6dUQJYR5vVYRmc2Ngj5m
   jVimu5praOXkZC+94IaNQNaT6JHtDNtHjKZN3y4NZaX1ssS5nuI8dxIkD
   Q==;
X-CSE-ConnectionGUID: 2IsXjIfiQUGNCW/HMylSog==
X-CSE-MsgGUID: kPZyYpmNSJuuOAW4LZvyag==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81864612"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81864612"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 02:40:32 -0700
X-CSE-ConnectionGUID: RgXWwCjsQk+VNt1TMLf+yw==
X-CSE-MsgGUID: JYjTwejYRuib9rvG7w6L6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="241646696"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 02:40:31 -0700
Message-ID: <2fc34158-debd-467c-b8fe-b9c04df2a19e@linux.intel.com>
Date: Tue, 9 Jun 2026 17:40:29 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 5/9] perf/x86/intel: Drop LBR entries whose privilege
 level mismatches br_sel
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260609050222.2458129-6-dapeng1.mi@linux.intel.com>
 <20260609052128.811C51F00893@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260609052128.811C51F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/9/2026 1:21 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] The kernel address leak in LBR stacks fixed here for Intel PMUs still exists in AMD PMUs (both AMD LBR and AMD BRS), allowing KASLR bypass.
> --
>
> commit 955fb4f61b3305a8e4972ee94bb41e752a3dd25c
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/intel: Drop LBR entries whose privilege level mismatches br_sel
>
> This commit fixes an issue where kernel branch addresses could be exposed
> to user space in user-only branch stacks. It extends the software filter
> in intel_pmu_lbr_filter() to validate both the from and to addresses
> against the requested branch privilege filter.
>
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> index 171fdf1962ade..9a63209cc7878 100644
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
> [ ... ]
>
>> @@ -1246,8 +1246,16 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>>  				type |= X86_BR_NO_TX;
>>  		}
>>  
>> -		/* if type does not correspond, then discard */
>> -		if (type == X86_BR_NONE || (br_sel & type) != type) {
>> +		from_plm = kernel_ip(from) ? X86_BR_KERNEL : X86_BR_USER;
>> +		/*
>> +		 * If type does not correspond, then discard.
>> +		 * Especially filter out the entries whose from or to address is
>> +		 * a kernel address while only X86_BR_USER is set. This prevents
>> +		 * kernel address from being leaked into a user-space-only LBR stack.
>> +		 */
>> +		if (type == X86_BR_NONE || (br_sel & type) != type ||
>> +		    (!(br_sel & X86_BR_KERNEL) && (from_plm & X86_BR_KERNEL)) ||
>> +		    (!(br_sel & X86_BR_USER) && (from_plm & X86_BR_USER))) {
>>  			cpuc->lbr_entries[i].from = 0;
>>  			compress = true;
>>  		}
> [Severity: High]
> This is a pre-existing issue, but does the AMD PMU code suffer from this
> same vulnerability?
>
> Looking at the AMD LBR software filter, it appears to only check the
> target privilege level and is missing the from_plm privilege validation:
>
> arch/x86/events/amd/lbr.c:amd_pmu_lbr_filter() {
>     ...
>     /* If type does not correspond, then discard */
>     if (type == X86_BR_NONE || (br_sel & type) != type) {
>         cpuc->lbr_entries[i].from = 0;  /* mark invalid */
>     ...
> }
>
> Similarly, the AMD BRS filter explicitly only validates the to address
> and ignores the from address:
>
> arch/x86/events/amd/brs.c:amd_brs_match_plm() {
>     ...
>     if (!(type & plm_k) && kernel_ip(to))
>         return 0;
>
>     if (!(type & plm_u) && !kernel_ip(to))
>         return 0;
>
>     return 1;
> }
>
> Could kernel addresses from kernel-to-user branches leak into user-space
> LBR stacks on AMD systems through these paths, bypassing KASLR in the
> same way?

Yes, this is a known issue and AMD guys would post the fixing patches
separately. Thanks.


>
