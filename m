Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C21C1D416C
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 01:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781485732; cv=none; b=HyVqV0AYg5ZbuZwiGo6eH9es9o1FcJju8IEmNKJWn+PLAP2UzpjmWsanWU3KtBdhY9czBmeC2MZ3XIkbieeCajFptJjF/hAB3mcvQTBAiDu8nXBwOnLiTxkCSlm49YZBHh58VrT1DCOPxy/CdGQ4EeEE3woEe9dRkO10Q07Mxls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781485732; c=relaxed/simple;
	bh=2cIcsCvKnwMKqPtykZo2xdOIhv/jORdM497BMTBjIvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLP2+n/87i8CxRmperawam3Wc+6BHFrfiwyxUm+lChE05/ReV50Fvsj9COk7yBpPOvCvqXMNoRfiq2nnhH5+s65HINtgxQl2/c0G7pql4CUM8Nyu0Tt0eMIM36MgHAF9ahhq0JWAJT3jNC/k8YJxtJfk+w9VF50r/VJ3V2E648Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xv0jccvW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xv0jccvW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781485731; x=1813021731;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2cIcsCvKnwMKqPtykZo2xdOIhv/jORdM497BMTBjIvU=;
  b=Xv0jccvWGlqvLlFD0WJ7tOf94IWnMxShOrxYjLVq3/zKrgtlXT2UxCxU
   7C4FJGO5AmOzxfY+TMmYbnqMrmjveLYiRVX+qFu65WuIVlcmoSAEKIjcn
   aFB8GnACxIdl9qDe88hjCNFkZ8DH0coEjDgUE0C77T/g80SPnZ4e7EcZ9
   1p9MPxKx4WSjD99AWKevuiWygtMp1wb99FIEDvWfyMeoJwKg+7QvYhegV
   9NUJOTRqiBIdq8fmYAbtXT5AQvZCx+5Oqinr10zFPsaKKbmwZvMGdq/eK
   7qcJjAaT/pnNkPWTRGfdUYQ5ucW4ZVHs54Av3sY+pUA//1GQ3FZlttFBI
   Q==;
X-CSE-ConnectionGUID: 5mqbdIJxSbGeZcED3NONzw==
X-CSE-MsgGUID: gTWjbMZkR3O/yDruX0O7AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="104892756"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="104892756"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 18:08:50 -0700
X-CSE-ConnectionGUID: K58lDKO/R3WPXSlcVdcZ/Q==
X-CSE-MsgGUID: hVf3muYuT/ehm6d1B46lAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="271007189"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 18:08:50 -0700
Message-ID: <45c6a869-6e61-467f-9904-5b21a4164e93@linux.intel.com>
Date: Mon, 15 Jun 2026 09:08:47 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 5/8] perf/x86/intel: Validate the return value of
 intel_pmu_init_hybrid()
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260612090114.3188886-6-dapeng1.mi@linux.intel.com>
 <20260612093119.7FA3E1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260612093119.7FA3E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/12/2026 5:31 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Relocating `intel_pmu_arch_lbr_init()` below `intel_pmu_check_event_constraints_all()` bypasses the dynamic constraint validation for branch counters.
> --
>
> commit 4ceb25a65fdf63fe8fa33e932139cf0a5d28e924
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/intel: Validate the return value of intel_pmu_init_hybrid()
>
> This patch validates the return value of intel_pmu_init_hybrid() to avoid a
> null-pointer dereference. It also defers intel_pmu_arch_lbr_init() until after
> hybrid PMU initialization succeeds to avoid destroying the kmem cache on
> failure.
>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index db52e7e53a6cd..74dbf24b0ab63 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
> [ ... ]
>> @@ -8829,6 +8842,9 @@ __init int intel_pmu_init(void)
>>  
>>  	intel_pmu_check_event_constraints_all(NULL);
>>  
>> +	if (boot_cpu_has(X86_FEATURE_ARCH_LBR))
>> +		intel_pmu_arch_lbr_init();
>> +
> [Severity: Medium]
> Does moving intel_pmu_arch_lbr_init() below
> intel_pmu_check_event_constraints_all() bypass the dynamic constraint
> validation for branch counters?
>
> When intel_pmu_check_event_constraints_all() runs, it eventually calls
> intel_pmu_check_dyn_constr(). This check relies on the PMU_FL_BR_CNTR flag
> and the x86_pmu.lbr_counters mask:
>
> arch/x86/events/intel/core.c:intel_pmu_check_dyn_constr() {
>     ...
> 		case DYN_CONSTR_BR_CNTR:
> 			if (x86_pmu.flags & PMU_FL_BR_CNTR)
> 				mask = x86_pmu.lbr_counters;
> 			break;
>     ...
> }
>
> Because intel_pmu_arch_lbr_init() is now deferred until after this validation,
> the PMU_FL_BR_CNTR flag hasn't been set yet. Will this cause the dynamic
> constraint check for branch counters to evaluate to false and be skipped?

That's right, should move intel_pmu_arch_lbr_init() just before
intel_pmu_check_event_constraints_all(), just like this,

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 74dbf24b0ab6..edf6f8732234 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -8840,11 +8840,11 @@ __init int intel_pmu_init(void)
                pr_cont("AnyThread deprecated, ");
        }

-       intel_pmu_check_event_constraints_all(NULL);
-
        if (boot_cpu_has(X86_FEATURE_ARCH_LBR))
                intel_pmu_arch_lbr_init();

+       intel_pmu_check_event_constraints_all(NULL);
+
        /*
         * Access LBR MSR may cause #GP under certain circumstances.
         * Check all LBR MSR here.

Thanks.


>
>>  	/*
>>  	 * Access LBR MSR may cause #GP under certain circumstances.
>>  	 * Check all LBR MSR here.
