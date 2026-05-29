Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08C7409631
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 18:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079489; cv=none; b=Q5Psp9JO7zzrqiG2V6QnR1pIe/djkFISc+mEZ8N1+bpLRsHgzy3Zn76AURtQT+v6JPMcSp2TWiBcColH4B6wS6Kux4V2uX+Vg3Ud8nJP3zhmgSMdyRv3EUNbXRf0i7Wy1ljvA4XP99XfINp7nhZUEqNCbwNzI5lmciXqoudDEqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079489; c=relaxed/simple;
	bh=aOpV+WHwjbYXZcQYmtA5ng/AE6qGHgqNNihA1wvQi9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8fd+zHvKgQAHYugoRoAgja3p4kRIvG8Z3D+jRV2VzLZvk+XA+/epGybtt+TY3RMTUGen6jXq8+XnehUDH6Y/FqPteDzc28x4eba5zq0M0pbLlQdluBruNgzeoPLyk4DhPrJSzb013Se0NWKO8rie97OAUrBBJmf7oa7hAZ/d3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DS0Nwaov; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DS0Nwaov"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780079489; x=1811615489;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aOpV+WHwjbYXZcQYmtA5ng/AE6qGHgqNNihA1wvQi9o=;
  b=DS0NwaovGmHZoPCbXpFHDPCXA8nLngQTbllxuXEkmiEL66Pdl7hLyvBg
   YhaZ6N7ybEkTjsH6n4UQ6AjMbYIXNFFD9sMsbLzdRK/Eycl1WhCYNFQaV
   mdL8rv7X+x/Y/cytzAxnJGu7W/m/WdhB4uQPgSGsToFGsiJX+xXM588dk
   lOd7PgiuoPeRp6zzVRddp8xStO/xeBtW5gSRPaNRO5FiHxmcvugTWwfVU
   B8K7CwVrdNFnxpuAe++bfMAqOyU5C/F3NgErfdO6gejAzbP9ULGDK0Ixv
   Ea00cMs4cg6Ch0cB4FSjyGdA+112WKycgEBSZ9pp2gGpxGiFeaZrhnW2Q
   Q==;
X-CSE-ConnectionGUID: VkTJLj1mS9qWMw4DL5uoyA==
X-CSE-MsgGUID: J4c+7dGpSQCaoN2kgnLaFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="92053417"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="92053417"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 11:31:28 -0700
X-CSE-ConnectionGUID: 58ahwfUDSIanbpVAPatT6Q==
X-CSE-MsgGUID: v9/0BumMS82ZMTmjbz0wPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="239917954"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 11:31:28 -0700
Message-ID: <08c10ac8-1d24-4659-afd7-dd55f6dd3ec8@intel.com>
Date: Fri, 29 May 2026 13:31:27 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/7] perf/x86/intel/uncore: Fix discovery unit lookup
 for multi-die systems
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260527151154.130505-1-zide.chen@intel.com>
 <20260527154508.329CA1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260527154508.329CA1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/27/2026 10:45 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] Unhandled return value of 0 from `intel_generic_uncore_box_ctl()` causes fatal writes to MSR 0 or PCI offset 0.
> --
> 
> Note: The format of this report has been altered to provide a free-form summary without directly quoting the original patch code, due to automated recitation restrictions.
> 
> commit e9069bffe8688f6e4044b8f15ff7ac27dcdbb094
> Author: Zide Chen <zide.chen@intel.com>
> Subject: perf/x86/intel/uncore: Fix discovery unit lookup for multi-die systems
> 
> This commit fixes a unit lookup issue on multi-die systems by using the box's
> die ID instead of a hardcoded -1. It also removes a warning when a discovery
> unit is not found, as offline CPU dies will now rightfully return a NULL unit.
> 
> [Severity: Critical]
> In the updated intel_generic_uncore_box_ctl(), returning 0 when the unit is
> not found (such as for offline dies) appears to introduce a regression in
> its callers.

This is fixed in patch 2/7. It's better to move this patch after 2/7.
> Looking at callers like intel_generic_uncore_msr_init_box() and
> intel_generic_uncore_pci_init_box(), they seem to use the returned control
> address blindly. If 0 is returned, MSR-based uncores would attempt to write
> to MSR 0x0 (IA32_P5_MC_ADDR), which triggers a general protection fault and
> panics the kernel on modern CPUs. For PCI uncores, writing to offset 0
> targets the read-only vendor and device ID, which could trigger AER NMIs.
> 
> Is it safe to return 0 here without adding validation to the callers? I
> note that this is fixed later in the patch series by a commit named
> "perf/x86/intel/uncore: Guard against invalid box control address", but
> does leaving it unhandled in this commit break git bisectability?
> 

