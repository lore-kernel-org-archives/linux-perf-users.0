Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A0A3A718C
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697319; cv=none; b=j0rZIWLtDvPNXMSgyEezw5IKbSgXmXvJlmto0+L8kO6YdGHYYPabDUyz8f7eTvtEKsWcnqEFpvEwwcEsc5d+3r26x5AqmjjOLytKxLdPkvBw4AAMPp6SJpUgJt6McVBGOG1GmuRNWTdMae1hTsh1h+x1bmoTYl7qNe698JgzOAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697319; c=relaxed/simple;
	bh=9i3eVrMGco7pjsCKsuakWwMGNLf6iCp4C2rreBxC+6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pvtBMKrlY8AHNotPXLG5xgxnw+63J9l0ltnq2zVRpYHgVwNUHUewldQqDHDntN1FrX2VFS5BRVLRReJoR3RDBhZqNPeXSdcS24xbBRzSUk8EjYRWaFRIUyIh5Rxx+qHUY4Ijf2gdi9AOlAPc4PIzWtLze96E/imLQv/KDKnF0dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQV5v6xi; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQV5v6xi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778697318; x=1810233318;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9i3eVrMGco7pjsCKsuakWwMGNLf6iCp4C2rreBxC+6I=;
  b=SQV5v6xiOYa3PSIs3rkMx+OUs95MITsfKczNOjbAd2WotOAU3Rwj03TZ
   ZwR+xppfH8SXfH8oIIgzkGdvOBX+tBTevVb3BGtxvjegftRKU/2cdovnt
   mMQMYoEGS+HGhQfQRHgyxf7j8og3zWODNwxyPNTGc2MFCH2P9v07apqne
   15uOo4gw9/u0scJPUeTaUeIttVnj7gQePV6/8gcq6qR7dYw7BmOmnaYJQ
   tFfzJIadVbSiI61y9ahcvpZaX4POKxwt8MNHV+K/6OvhbL/QUeGo8EIFM
   Cgq/kFRbDcFrNj0vcm5fAAoKwmrF620PkWZe6oIO7XpYCQXVt4bntUQFW
   Q==;
X-CSE-ConnectionGUID: xNEW1Fe/TFSGDou0f6Ft1w==
X-CSE-MsgGUID: H+zVxMwUSmGuuOTc/LuiIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79662709"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="79662709"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 11:35:18 -0700
X-CSE-ConnectionGUID: WNl30lHKSfCcw1UOfUP7vQ==
X-CSE-MsgGUID: 7SOaDgu0QSiFMvKI2vB7Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="242163126"
Received: from unknown (HELO [10.241.241.90]) ([10.241.241.90])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 11:35:18 -0700
Message-ID: <61a7734a-752b-4452-ae18-511f0da6aa6a@intel.com>
Date: Wed, 13 May 2026 11:35:17 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] perf/x86/intel/uncore: Fix discovery unit lookup for
 multi-die systems
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260511230527.26096-2-zide.chen@intel.com>
 <20260513014918.E1D66C2BCB0@smtp.kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260513014918.E1D66C2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/12/2026 6:49 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Unchecked return value causes a write to MSR 0x0 when a PMON discovery unit is not found for the current die, leading to a #GP fault and kernel panic.
> --
> 
> commit 618972be846a765ebeeda359a995bf217a4d825c
> Author: Zide Chen <zide.chen@intel.com>
> 
> perf/x86/intel/uncore: Fix discovery unit lookup for multi-die systems
> 
> This commit updates intel_generic_uncore_box_ctl() to look up discovery
> units using box->dieid instead of hardcoding -1. This ensures the
> correct node is selected on multi-die systems.
> 
>> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
>> index 583cbd06b9b88..1d22d7c00ee06 100644
>> --- a/arch/x86/events/intel/uncore_discovery.c
>> +++ b/arch/x86/events/intel/uncore_discovery.c
>> @@ -481,7 +481,7 @@ static u64 intel_generic_uncore_box_ctl(struct intel_uncore_box *box)
>>  	struct intel_uncore_discovery_unit *unit;
>>  
>>  	unit = intel_uncore_find_discovery_unit(box->pmu->type->boxes,
>> -						-1, box->pmu->pmu_idx);
>> +						box->dieid, box->pmu->pmu_idx);
>>  	if (WARN_ON_ONCE(!unit))
>>  		return 0;
> 
> Could returning 0 here cause a regression during CPU hotplug if a die is
> brought online later?

You're right, it's problematic, but not a regression — it's caused by a
pre-existing bug.

With or without this patch, intel_uncore_find_discovery_unit() could
return NULL, causing intel_generic_uncore_box_ctl() to return 0, and all
callers should check the return value before accessing hardware.

The CPU offline scenario you described is just one example of this. I'll
fix it in a separate patch.


> If a CPU die is offline during boot, uncore_discovery_msr() skips it,
> meaning no PMON units are added to the discovery RB-tree for that dieid.
> 
> When the die is later brought online, uncore_event_cpu_online()
> allocates boxes based on the globally maximum number of discovered units
> and calls uncore_box_init().
> 
> The initialization function unconditionally calls
> intel_generic_uncore_msr_init_box(), which writes to the returned address
> without checking if it is 0:
> 
> arch/x86/events/intel/uncore_discovery.c:intel_generic_uncore_msr_init_box() {
> 	wrmsrq(intel_generic_uncore_box_ctl(box), GENERIC_PMON_BOX_CTL_INT);
> }
> 
> Because the lookup now strictly matches box->dieid instead of safely
> falling back with -1 to an identical unit on another die,
> intel_uncore_find_discovery_unit() will return NULL for this die.
> 
> This results in intel_generic_uncore_box_ctl() returning 0. Calling
> wrmsrq(0, ...) writes directly to MSR 0x0 (IA32_P5_MC_ADDR), which will
> trigger a #GP fault and crash the system.
> 
> Similar unvalidated accesses also occur in PCI configuration space
> via intel_generic_uncore_pci_init_box():
> 
> arch/x86/events/intel/uncore_discovery.c:intel_generic_uncore_pci_init_box() {
> 	struct pci_dev *pdev = box->pci_dev;
> 	int box_ctl = intel_pci_uncore_box_ctl(box);
> 
> 	__set_bit(UNCORE_BOX_FLAG_CTL_OFFS8, &box->flags);
> 	pci_write_config_dword(pdev, box_ctl, GENERIC_PMON_BOX_CTL_INT);
> }
> 
> Should the callers be updated to check the return value of
> intel_generic_uncore_box_ctl() before attempting hardware accesses?
> 

