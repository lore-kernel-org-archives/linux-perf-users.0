Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016FA3D34A0
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079457; cv=none; b=aPNZMbvm+JiUDlb/NaUiUHR9aXDTJZqoeiPE1cj8J1EAx/07k9yvoPxSglAJfeK0Hv++0v6cajaw2PpO/emTWdmvwBs4a0Zoml/so7U8ddv6xtRFw3wXFaoQPlm32+NDIy7Rusl+/HvM7MeoS7xLODHH6MuuMynHwH1kltYd6EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079457; c=relaxed/simple;
	bh=F7wl61SLgGH999UP0m+xGqFou03WQyUn6JnQ3wN7dU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BcjN8I7tIdmX+93mv6m+kErvz1e66wsLGmLJVnWgaC5Nw1JygF5+a2h7EVFw0IjwXtNMHuiL7l8XfiJhPqKnj3s/S3cuUYTeQhYdeF3rmo56xULS+Tu04hL2wRLit8kquc1trkTzvtyKPoZHN4+zcybUKEKxuVYs9Yd/kZCfYP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Si2UYPCN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Si2UYPCN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780079454; x=1811615454;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F7wl61SLgGH999UP0m+xGqFou03WQyUn6JnQ3wN7dU4=;
  b=Si2UYPCNKnRkGsXO/SS42h0kOJF6ch551le/LiWDLlnNDTHw4kXlRDU5
   IHR5agPd8KeSSf32qkrbL8kNVrtbgbLeUhbSjmPJjhy31PCR5prCsnk54
   jdUdKw8W+qn3wfN2ZpVS6wi/1bfoxXa7EGn+mlfRejC4sYF0U5toT1YZG
   Xwy9kh9Ag49SuGLNzIYHPRHA6VrSDZesyXbRiPMSWY52IZEGR9YTMchRB
   aE1CXWWJB3G/sr8ZSD9gc88dHYqugRqLMr7hjVbqqDvu/3SvQOTZrIFOw
   jPGeNs6uYn2VtCUMDwzs40HgYAqAnyegE1/SOhNW9h2Zy5K7Zeisri0I2
   w==;
X-CSE-ConnectionGUID: 7vBwTdV9Smu46YbtV4SvOg==
X-CSE-MsgGUID: cek+8p9dQTS2/lNk3y89mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="92053369"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="92053369"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 11:30:53 -0700
X-CSE-ConnectionGUID: YshiFJziRemZABF4WkpxoA==
X-CSE-MsgGUID: ekH2xvH1TuaMyT3C8JjIXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="239917796"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 11:30:53 -0700
Message-ID: <fa098c82-4ce9-4f4d-890c-31b68ed4eca7@intel.com>
Date: Fri, 29 May 2026 13:30:52 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/7] perf/x86/intel/uncore: Guard against invalid box
 control address
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260527151154.130505-2-zide.chen@intel.com>
 <20260527172840.399211F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260527172840.399211F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/27/2026 12:28 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The patch guards box-level operations against invalid (0) control addresses when a discovery unit is missing, but it critically misses event-level operations. This omission allows an unprivileged or privileged user running `perf` to trigger a #GP fault (kernel panic) or PCI configuration space corruption.
> --
> 
> commit 65ddbcdd36196085490e8783cb658d7e20c2e9c5
> Author: Zide Chen <zide.chen@intel.com>
> 
> perf/x86/intel/uncore: Guard against invalid box control address
> 
> This commit guards against a NULL return value from
> intel_uncore_find_discovery_unit() before accessing hardware box control
> addresses. It prevents potential faults when a CPU die is offline during
> uncore enumeration.
> 
>> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
>> index 60e1200c4691d..af2217b44a814 100644
>> --- a/arch/x86/events/intel/uncore_discovery.c
>> +++ b/arch/x86/events/intel/uncore_discovery.c
> 
> [ ... ]
> 
>> @@ -549,6 +560,10 @@ bool intel_generic_uncore_assign_hw_event(struct perf_event *event,
>>  
>>  	if (box->pci_dev) {
>>  		box_ctl = UNCORE_DISCOVERY_PCI_BOX_CTRL(box_ctl);
>> +
>> +		if (!box_ctl)
>> +			return false;
>> +
> 
> [Severity: High]
> This is a pre-existing issue, but does returning false here when box_ctl is
> invalid still leave us vulnerable to hardware access faults during event
> execution?
> 
> When intel_generic_uncore_assign_hw_event() returns false, the caller
> uncore_assign_hw_event() unconditionally falls back to legacy offset
> calculations using uncore_event_ctl(). For discovery PMUs, this results in
> hwc->config_base being set to a small relative offset like 0x0.
> 
> Later, when a user schedules a perf event on this box, the event startup
> routines execute blindly using this base:
> 
> intel_generic_uncore_msr_enable_event()
>     wrmsrq(hwc->config_base, hwc->config);
> 
> Could this result in a fatal #GP fault by executing wrmsrq(0, ...), or
> corrupt PCI configuration space by overwriting the Vendor or Device ID at
> offset 0x0?
> 
> While this patch successfully prevents faults during boot or hotplug box
> initialization, could it leave the crash accessible through user-controlled
> perf execution?

https://lore.kernel.org/lkml/20260512233048.9577-1-zide.chen@intel.com/

With this patch series, if a box fails at init_box(), the associated PMU
is flagged as BROKEN and will not be assigned to any perf event, so the
crash path is not user-accessible.

The box_ctl check in intel_generic_uncore_box_ctl() is a defensive
guard for completeness. In practice it won't be hit, because any box
that reaches hw_event assignment must have successfully completed
init_box() first.

> 
>>  		hwc->config_base = box_ctl + uncore_pci_event_ctl(box, hwc->idx);
>>  		hwc->event_base  = box_ctl + uncore_pci_perf_ctr(box, hwc->idx);
>>  		return true;
> 

