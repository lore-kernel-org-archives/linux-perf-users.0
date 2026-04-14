Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF03313E30
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 05:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776145314; cv=none; b=NGWSFhml0wZJ8YLlEvXTXCgi3tFwKze9ZNwY5bPBOlKY9mwYHXqjCmF06jTXdWvZfgQPcISc8j4Whv8unPN1EcO6CyIns5fe+z20+8DW8UJ3Re3rEWQ86GVdPDjlH62+CAd2w3QwZgkpTyMt0ClE6UTZxXw30ZK1lqx/yJvHINQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776145314; c=relaxed/simple;
	bh=WhM7y1PbpushOIS/C/VU5u7la+Pct9BbJzUIPWTRtQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBZ9o33WHE7945jO/YxBXIy2wu7+MxhnStembX1/Zi304W0Xg1RwX2kgh6ZtiUVO6ZYMnUPNKiMtTyTjraC6JJ4wArevpLEXrp+wGN5+/6rSKeJ6kQvpmLw0xmrp4PQ/5eb/0b974GZmoz4Sn8X/Xm8vYLNackjDfjUMcYLBbmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fAhvit1s; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fAhvit1s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776145309; x=1807681309;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WhM7y1PbpushOIS/C/VU5u7la+Pct9BbJzUIPWTRtQM=;
  b=fAhvit1sOB2Q29z7zhfgSkz6e/PKUtEoPSjbijTrfbyI8bWApqDni2AN
   mJiOBG9NBVoUoyg/5Xb4O8z58ImlOvA+zpKPZjHAMFPr9wcC1Ra2iILpg
   4UtH148loFVcwunKt/wWykebPvPcyK2AGmYxzwLuCxy86z+NkP07W7PBI
   nY4X36D6JrnVJC3+RmGOS2jnUlzdPof94mGPX+fYYG3qhyCilZpwQNooL
   UqAaiDhfIlK1PMAr8/3CG003u0ful779X9IyATw6kPs8c1OZDBT19Qdpr
   YH1MKmGAXkuywoRWgisnKaug596usuCGnnD8owtDJAm250x8CGqA8e0Ks
   A==;
X-CSE-ConnectionGUID: fKu2RUgRSDWtc5u+nPc/+w==
X-CSE-MsgGUID: 9uBjaX7IQjexi0Ic78JGdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="64624727"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="64624727"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 22:41:27 -0700
X-CSE-ConnectionGUID: etRj/eaMTvyJqCzdBKRg+Q==
X-CSE-MsgGUID: 3e9i+87MQMCKSU1w8FTBSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,178,1770624000"; 
   d="scan'208";a="260410037"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 22:41:26 -0700
Message-ID: <0b02aea9-a0b3-44cd-96ed-679f1339ccf4@linux.intel.com>
Date: Tue, 14 Apr 2026 13:41:23 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/x86/intel: Fix kernel address leakages in LBR
 stack
To: sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260414021440.928068-2-dapeng1.mi@linux.intel.com>
 <20260414031613.CC82EC2BCAF@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260414031613.CC82EC2BCAF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/14/2026 11:16 AM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [High] The patch addresses kernel address leakage in Intel's LBR software filter but overlooks identical vulnerabilities in AMD's LBR and BRS software filters.
> --
>
> commit 8dbb741871f5824e6032a6a5fa35f5db78494ff9
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/intel: Fix kernel address leakages in LBR stack
>
> This commit fixes a kernel address leakage in the Intel LBR stack by extending
> the software filtering to check both the source and destination addresses.
> Prior to this change, kernel-to-user branches like SYSRET could leak kernel
> addresses to user space even when PERF_SAMPLE_BRANCH_USER was requested.
>
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> index 16977e4c6f8a5..deef81c16571a 100644
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
> [ ... ]
>> @@ -1244,8 +1244,15 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>>  				type |= X86_BR_NO_TX;
>>  		}
>>  
>> -		/* if type does not correspond, then discard */
>> -		if ((type & ~X86_BR_PLM) == X86_BR_NONE || (br_sel & type) != type) {
>> +		from_plm = kernel_ip(from) ? X86_BR_KERNEL : X86_BR_USER;
>> +		/*
>> +		 * If type does not correspond, then discard.
>> +		 * Especially filter out the entries whose from or to address
>> +		 * is a kernel address while only X86_BR_USER is set. This prevents
>> +		 * kernel address from being leaked into a user-space-only LBR stack.
>> +		 */
>> +		if ((type & ~X86_BR_PLM) == X86_BR_NONE || (br_sel & type) != type ||
>> +		    (!(br_sel & X86_BR_KERNEL) && (from_plm & X86_BR_KERNEL))) {
>>  			cpuc->lbr_entries[i].from = 0;
>>  			compress = true;
>>  		}
> This patch successfully addresses the kernel address leakage in Intel's LBR
> software filter, but does it leave AMD platforms exposed to the same KASLR
> bypass?
>
> Looking at arch/x86/events/amd/lbr.c, amd_pmu_lbr_filter() appears to classify
> branch privilege levels based exclusively on the destination address via
> branch_type_fused(). Does this mean it classifies kernel-to-user branches as
> user-space and leaks the source kernel address?
>
> Similarly in arch/x86/events/amd/brs.c, amd_brs_drain() filters branches
> using amd_brs_match_plm() which explicitly checks only kernel_ip(to). Would
> this also blindly accept the branch and log the source kernel address?
>
> Should equivalent privilege level checks for the source address be added to
> the AMD routines to fully resolve the issue across platforms?

AMD guys have known the issue, suppose they would post the fix in a
separate patch. Thanks.


>
