Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D3E215F42
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 01:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784510251; cv=none; b=XYo/eUh0eonaACFKYBIPisSPYMgnObprSoVzXSUb8nUivvj4gWt22+6iLMYY/UB0GborC7RmT3hc8MmKDUNaGV0xSFZvq95WMBWp64Iixv4Tmj2DJ7oMjjtjJuukusBgwsHyKXLFwPwX2bSE+q0Qkq67D4mEvKzEINOQFxHu9bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784510251; c=relaxed/simple;
	bh=9vF/ctZKE3xEJvNUtmf9XLuXyU44ih+tJ7Zvnw155e0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TpPHu+OchF65OCA7TMeWAb3RjQ3jSoAbrKovE3DxvMiu/imPT15zjbh/FvE7a24q6XhS2Nflw/EU3CXiulnNb2NXP+UwHugy7CaMDH212T/R5inWUH+ExKXE8IAjQDxC+cSqvg7GXqhtwYTaFTN6rMrXo3XxLFf5aBzslcZWQAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6wCCYjY; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6wCCYjY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784510249; x=1816046249;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9vF/ctZKE3xEJvNUtmf9XLuXyU44ih+tJ7Zvnw155e0=;
  b=e6wCCYjYBpQHJkYUTJbPYcuefkbMGF95TKpQt1wc7JiM8EcbTGdcskaR
   ggr57JsDwK/l4m0E7Ec7j2HfkQPJVsXmZkGoBgc8Il6vTWzcXmwAx1FgC
   amA4h4NqlMz1eTT01VpElboEzpLA6C6pORS1pMaSFw/LiGILuLcvi3Fi7
   Bo2oE8QyJX5XDLagnuIiKVtTFEtZ2LzZQ30PMo2H8LklzLwymJoHIWLg1
   MyC20xDQ44HEC03nr3F9j3x6VbcfwW0OvBJl/dDFUSgUYwWEXF/I1by7w
   KQ5/QCoxhB1ynTiOOqRU09O/0fYsODCOdNrTZpkdorQ4lcvB0w5Ygox0G
   g==;
X-CSE-ConnectionGUID: zRuC/fjkQuKNyjXC7EEevA==
X-CSE-MsgGUID: bPuAYE5GQrm8sOyF0QtZFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="102513300"
X-IronPort-AV: E=Sophos;i="6.25,173,1779174000"; 
   d="scan'208";a="102513300"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 18:17:29 -0700
X-CSE-ConnectionGUID: 6/3V++uLQHu+g3v0pRsN4w==
X-CSE-MsgGUID: Z02feXOySQOfapnCcI2+9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,173,1779174000"; 
   d="scan'208";a="256143886"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 18:17:28 -0700
Message-ID: <0bfddc69-2534-4250-aabe-8e9c4421e287@linux.intel.com>
Date: Mon, 20 Jul 2026 09:17:24 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 1/8] perf/x86: Unregister PMI handler on PMU init
 failure
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
 <20260717080342.1879573-2-dapeng1.mi@linux.intel.com>
 <20260717083310.79B551F00A3A@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260717083310.79B551F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/17/2026 4:33 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Pre-existing Use-After-Free window for `cpuc->pmu` if `perf_pmu_register()` fails on hybrid systems.
> --
>
> --- Patch [1]: [Patch v3 1/8] perf/x86: Unregister PMI handler on PMU init failure ---
> commit 841a0ed2adb8a95774faf3b5508e90fdd97d9135
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86: Unregister PMI handler on PMU init failure
>
> This commit fixes an NMI handler leak in init_hw_perf_events() by unregistering
> the NMI handler when PMU initialization fails before clearing the x86_pmu state.
>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index af0b67ffb43d8..872d07a5fa80d 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
> [ ... ]
>> @@ -2273,6 +2273,8 @@ static int __init init_hw_perf_events(void)
>>  	cpuhp_remove_state(CPUHP_AP_PERF_X86_STARTING);
>>  out:
>>  	cpuhp_remove_state(CPUHP_PERF_X86_PREPARE);
>> +pmi_unregister:
>> +	unregister_nmi_handler(NMI_LOCAL, "PMI");
>>  out_bad_pmu:
> [Severity: High]
> This is a pre-existing issue, but does this error path leave a dangling
> pointer that could lead to a Use-After-Free?
>
> On hybrid systems, if perf_pmu_register() fails, the error path frees the
> x86_pmu.hybrid_pmu structures. However, CPUHP_AP_PERF_X86_STARTING was already
> set up, so cpuc->pmu on all online CPUs was initialized to point to these
> now-freed structures.
>
> The CPU hotplug state rollback doesn't set cpuc->pmu back to NULL. Since
> x86_pmu_static_call_update() has already routed x86_pmu_guest_get_msrs to
> intel_guest_get_msrs(), and the perf_is_hybrid static key remains enabled,
> could a subsequent KVM guest launch trigger a UAF?
>
> When KVM calls perf_guest_get_msrs(), it jumps to intel_guest_get_msrs(),
> which unconditionally dereferences the dangling cpuc->pmu pointer:
>
> arch/x86/events/intel/core.c:intel_guest_get_msrs() {
>     ...
>     u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
>     ...
> }

This issue would be fixed in the subsequent patch 2/8 which would reset
"perf_is_hybrid" to false. So hybrid() would never touch these freed
structures. Thanks.


>
>>  	memset(&x86_pmu, 0, sizeof(x86_pmu));
>>  	return err;
