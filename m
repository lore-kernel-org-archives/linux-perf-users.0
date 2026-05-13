Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D934E3764
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 17:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778695110; cv=none; b=g8RoSwNmcsgTydO4XpMkfq2Az5E/P/MPy1axg9rEqWe433WvnVLOGyR03otN5aqdd9kazr/lJ/dzXXpQSBLWfc7ZevUDVmC4rCNXpVOQbwnZ+4p0Yq4ynOfDTnilDcSMJaJRgIoAFRrqoQE9OTHBEbwmZ7HHcHSSYcGVVsDs8H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778695110; c=relaxed/simple;
	bh=iHtF7j50sm6BXxHPOKn2ajdwXG5Cq44c3Eq4hlEbY5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzCCcYgHD0xJZwc/CRdrmWeTlDojYlULfdeotsoJNBI1PfkgvJAms3VpERyXeMqtQCmEL1GoDNEl02rWfiit57orL1Cyl/jp0JdjL4+0GA8ARijGAyZMcOGQyrsjLcQgCnFneq/drrhdqaU7hT8k3z/pwsgEjy5qM0zZaHR9+yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QQBqrMNJ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QQBqrMNJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778695109; x=1810231109;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iHtF7j50sm6BXxHPOKn2ajdwXG5Cq44c3Eq4hlEbY5E=;
  b=QQBqrMNJgN0AJJ1cRg3TmZTSMgQEwjRdI16SR2z6JLTX5vkVGgj9exJM
   oHfg1WVZ0RDW0eCkwBSMq12y6DwWyRRI00oogZ4eXxJr1JvhVvIp3UQ47
   bD3VU9qdeQSyAW5Wl9RMttcwuyeMmhk3CTb9NQCdn6FfTAWby+84Vlf8z
   Ri21Bf2pGZ3F5kx+NmdsyA4AgSzyjJZenm6i2tczDl9s1pug/Hi2QFbzc
   LRYXl0n1Fs3Ynkm+hBquqMp+q31Loo56PYEl+D5Jnkxm2dNlC6EAIZ0KO
   fKpwIFZPplb/M5A4clG1spil2LL5aOoUrvMv3IiD15UpJ4AIcmG+NfZMM
   Q==;
X-CSE-ConnectionGUID: fFTWw7R9S0WSpeLuKQ/ypw==
X-CSE-MsgGUID: oDYzgLq9R621O8aaqLHWhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="91015885"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="91015885"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 10:58:28 -0700
X-CSE-ConnectionGUID: u/jHuEjSQvub+lpTNieV5w==
X-CSE-MsgGUID: k1pWA18ZSUS6PxjhpKoQdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="238043631"
Received: from unknown (HELO [10.241.241.90]) ([10.241.241.90])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 10:58:29 -0700
Message-ID: <80135abe-c525-4a3d-a75c-438f70b6076b@intel.com>
Date: Wed, 13 May 2026 10:58:28 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] perf/x86/intel/uncore: Defer ADL global PMON enable
 to enable_box()
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260511230527.26096-4-zide.chen@intel.com>
 <20260513023345.ED78AC2BCB0@smtp.kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260513023345.ED78AC2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/12/2026 7:33 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The deferred global PMON enablement permanently leaks the hardware power state after the first use, nullifying the intended power savings.
> --
> 
> commit ce0046bfd8b6ed5388332db6e76ea45581716939
> Author: Zide Chen <zide.chen@intel.com>
> 
> perf/x86/intel/uncore: Defer ADL global PMON enable to enable_box()
> 
> This commit drops adl_uncore_msr_init_box() and defers programming the
> ADL_UNC_PERF_GLOBAL_CTL MSR to enable_box(). The goal is to save power by
> ensuring the global control register is only enabled when a box is actually
> used.
> 
>> diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
>> index 3dbc6bacbd9de..edddd4f9ab5fc 100644
>> --- a/arch/x86/events/intel/uncore_snb.c
>> +++ b/arch/x86/events/intel/uncore_snb.c
> [ ... ]
>> -static void adl_uncore_msr_init_box(struct intel_uncore_box *box)
>> -{
>> -	if (box->pmu->pmu_idx == 0)
>> -		wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
>> -}
>> -
>>  static void adl_uncore_msr_enable_box(struct intel_uncore_box *box)
>>  {
>>  	wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
> 
> Does this unintentionally leave the hardware power state permanently enabled
> after the first use?
> 
> The Linux perf core framework unconditionally calls perf_pmu_enable(), which
> maps to uncore_pmu_enable() and executes enable_box(), at the end of PMU
> transactions. This includes event removal sequences:
> 
> perf_pmu_disable()
>    event->pmu->del()
>    perf_pmu_enable()
> 
> Since adl_uncore_msr_enable_box() unconditionally writes
> SNB_UNC_GLOBAL_CTL_EN, it seems the global PMON control is immediately
> re-enabled and remains active even when zero events are in use, negating
> the intended power savings.

> Additionally, if a check like if (box->n_active) were added here, could
> that silently break concurrent perf sessions on other uncore boxes?

The additional power consumption occurs as soon as the MSR is written to
any value — not because the global control remains enabled.  So checking
n_active or disabling the global control when no events are active
wouldn't help.

> Because disable_box() unconditionally clears the shared MSR during
> transactions if pmu_idx == 0, failing to re-enable it would leave PMON
> globally disabled for the entire die. Safely managing dynamic power for this
> shared global MSR might require a package-level active reference count
> across all boxes.

Again, for the power consumption concern, the only thing we need to do
is to postpone the write to the global control MSR (0x2ff0), and after
the first write, it's irrelevant.

Regarding the concern of the disable_box(), I'd like to address it
separately from this patch. The fix here is simply to defer the first
write until it's actually needed.


>> @@ -587,7 +581,6 @@ static void adl_uncore_msr_exit_box(struct intel_uncore_box *box)
>>  }
>>  
>>  static struct intel_uncore_ops adl_uncore_msr_ops = {
>> -	.init_box	= adl_uncore_msr_init_box,
>>  	.enable_box	= adl_uncore_msr_enable_box,
>>  	.disable_box	= adl_uncore_msr_disable_box,
>>  	.exit_box	= adl_uncore_msr_exit_box,
> 

