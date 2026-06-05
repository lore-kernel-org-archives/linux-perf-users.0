Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EAE30BB8A
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 03:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780629665; cv=none; b=WLdDtvntF2mMqGVX6+hZ31blHcO2HXxMVGV2YajoIhRtnDGHOS8WCc0EkrRcy8th4YdjOP6Qo1UTCaPqG6YnxEOvMK4yH6wMP8InegzVe2MlCAMlN2hPCxU5lx5c/ZDocEVcXydq7Jqm8brALVN7eowrTQvuGAOv3i4iFfW5U6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780629665; c=relaxed/simple;
	bh=YSKSLVvJIsk2simEXanDqXtjTSTpaaUrvdjBJn+1q+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W660caEN9PvSAox0Y/k6YAlg1u0fRgw2Kz67eIa+5WLFbxiQZw6b7nvzGNXbL4P7IGywFNrPgPbEpadYjY1hRQuu9nLejuNWGjtsvijAhv/Ea+PGtoExXzLC7QZMtOVE25lsY5JeVJ2/ipgBYtT3bv0gYB2/DlNn4YR4qlbhNr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mS3mFkh9; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mS3mFkh9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780629662; x=1812165662;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YSKSLVvJIsk2simEXanDqXtjTSTpaaUrvdjBJn+1q+0=;
  b=mS3mFkh9+IVT0cwLyQaRl+65831PGpqxe/6v5I2NoPCMw69O0G85CVNL
   6uSOc9/rU5BpMI8unNHgIz42AMkbzHer9RTWew2TErp8uHSnMgKizmaTG
   kpIF3WKsP5MRRxn0wLnTMBFV/YPTwz7Hx3SRb/m/r5+RfOKtReo55S2mf
   xG4hyuUa8q0S45ffFgg7P7agzMGEmjxmYbHXU6UtdHOAkNS/VJR4p10xP
   9Y7DQKE1ZSWZw91TpQ3L47H0BQRfX9dHFn5rNEAfneJNK0rKtlVapOxnj
   WALmboYW5K9FqLn2AsgGfAn3v77ncJ9DXxCr7FqY9hggXRVsq3YknJ4BS
   Q==;
X-CSE-ConnectionGUID: 5QKyRoXbSvawWjU1F6R64g==
X-CSE-MsgGUID: dm8MwQD6SuaYMlOekyinSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="85315585"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="85315585"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 20:21:01 -0700
X-CSE-ConnectionGUID: 0qVBI0ppQVS2PHWo5U2sKg==
X-CSE-MsgGUID: 5E9VT2P3Rhe0VBYDAH4aug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="243641065"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 20:21:00 -0700
Message-ID: <416aca8a-4d45-44ef-b730-ef699b2d3c83@linux.intel.com>
Date: Fri, 5 Jun 2026 11:20:57 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] perf/x86/intel: Fix kernel address leakages in LBR
 stack
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260605011136.2043393-6-dapeng1.mi@linux.intel.com>
 <20260605013328.86D661F00893@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260605013328.86D661F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/5/2026 9:33 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] The exact same kernel address leak (KASLR bypass) vulnerability exists in the AMD LBR software filter (`amd_pmu_lbr_filter`), but the patch only fixes the Intel implementation.
> - [High] On Arch LBR CPUs that do not support hardware branch type decoding, the software filter incorrectly classifies all branches as conditional jumps (JCC).
> - [Medium] The software filter fails to drop branches executing in user space (e.g., SYSCALL) when only kernel branches are requested, diverging from hardware filter behavior.
> --
>
> commit e5f3b8c6179b0acb53df2e9f20348cf3b8f5a8be
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/intel: Fix kernel address leakages in LBR stack
>
> This commit fixes a kernel address leakage in the LBR stack on Intel
> platforms prior to arch-LBR. It extends the software filtering in
> intel_pmu_lbr_filter() to check the "from" address privilege level,
> preventing kernel addresses from leaking to user space.
>
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> index 16977e4c6f8a5..deef81c16571a 100644
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
>> @@ -1212,7 +1212,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>>  {
>>  	u64 from, to;
>>  	int br_sel = cpuc->br_sel;
>> -	int i, j, type, to_plm;
>> +	int i, j, type, to_plm, from_plm;
>>  	bool compress = false;
>>  
>>  	/* if sampling all branches, then nothing to filter */
> [Severity: High]
> This is a pre-existing issue, but does this function correctly handle Arch
> LBR CPUs that do not support hardware branch type decoding?
>
> If an Arch LBR CPU does not support hardware branch type decoding
> (LBR_INFO.BR_TYPE), the x86_lbr_type static key remains false and
> get_lbr_br_type() returns 0.
>
> Earlier in intel_pmu_lbr_filter(), the code checks:
>
>     if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
>         type <= ARCH_LBR_BR_TYPE_KNOWN_MAX) {
>
> Since 0 <= 5 is always true, it maps arch_lbr_br_type_map[0] to X86_BR_JCC,
> bypassing the software decoding fallback in branch_type().
>
> Does this force all logged branches to be treated as conditional jumps on
> these processors, destroying branch filtering accuracy?

Yes, it's an issue. If arch-LBR can't support hardware branch type
decoding, it should fallback to software branch type decoding, like this,

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index deef81c16571..fcdbb6feda73 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1232,6 +1232,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
                 * OTHER_BRANCH branch type still rely on software decoding.
                 */
                if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
+                   static_branch_likely(&x86_lbr_type) &&
                    type <= ARCH_LBR_BR_TYPE_KNOWN_MAX) {
                        to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
                        type = arch_lbr_br_type_map[type] | to_plm;


>
> [ ... ]
>
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
> [Severity: Medium]
> This is a pre-existing issue, but does this logic miss the symmetric check
> for scrubbing user-to-kernel branches from kernel-only samples?
>
> If a user requests only kernel branches (X86_BR_USER is not set), a SYSCALL
> (which goes from user to kernel) will be retained because the hardware
> filters based on destination CPL (kernel) and the software filter sees a
> valid to_plm.
>
> Should there be a check like:
>
>     (!(br_sel & X86_BR_USER) && (from_plm & X86_BR_USER))
>
> to prevent user-space addresses from polluting kernel-only branch traces?

Yes, this can be enhanced.


>
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does the exact same KASLR
> bypass vulnerability exist in the AMD LBR software filter?
>
> AMD's software filter in arch/x86/events/amd/lbr.c:amd_pmu_lbr_filter()
> uses branch_type_fused(), which only factors in the destination privilege
> level.
>
> When a user requests only user-space branches (PERF_SAMPLE_BRANCH_USER),
> hardware can still record kernel-to-user branches (like SYSRET) because
> the destination is in user space.
>
> Since the AMD filter evaluates (br_sel & type) == type as true based only
> on the destination, it keeps the branch, exposing the kernel "from" address
> to unprivileged userspace.
>
> Should a similar fix be applied to amd_pmu_lbr_filter()?

AMD guys have known this issue, the AMD specific fix would posted separately.

Thanks.


>
>>  			cpuc->lbr_entries[i].from = 0;
>>  			compress = true;
>>  		}
