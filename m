Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9532874FB
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Aug 2026 01:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787621692; cv=none; b=U/Cl/ZjtJK7k5EbBsUGGezv9nT19WcessNVfPQ7Gvglv7kN+eeweocGXTeT6DhIjnTVO/oVQLK0wqJCQzR2puejKWJa0CrYKYbyyYCn1a8gQS6aJjxz4CtyDfQNmJvzZ4uYy6ub30qE2u4C93tyITP9XahCxlM5M/rXJ3bZGzbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787621692; c=relaxed/simple;
	bh=P7/QO4JPQEHE3dTd5tAJtnTSwCT6vZGtX9SRMO4FEJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAmLPcXOvmiQgxkmaLnlgazHeM8PG4sRwdq1ihATfAqYqqQBjx5RCFF4ipBtNFxKgopJ/d+DqL2k2f0xSM1wT1PVGkVohvIwCe7YfAMus+4SqMfC6HshJ+G4az5L9rmSUbwInSLevuiE22hxAX3OtGxSOwS/JlaZg3p1cj88YR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dh1uu3q6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dh1uu3q6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787621690; x=1819157690;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P7/QO4JPQEHE3dTd5tAJtnTSwCT6vZGtX9SRMO4FEJ0=;
  b=Dh1uu3q6XXhSBIGKDkNXhn9m1TuU6Wyycx+eiBeI46yHQr7Iwu7PGVvU
   R5J8IxwwNjUS6nwSq0Kgjti6+B/E8iusuJO2CG6ttlBwdkglRsbxUApru
   Yk8ckjhvIqlJ8KIdq7IlZHlbd8gnV6rOx9UW/CVt700S1Wm94m0smxmLc
   l6mtkiicY9OVG85KP0CzpommM1H5aARm/eItA4nKwfjU8Ix4PftzgrCKr
   xx5WX8aDU0Zedrr+nN7MUjyI2NrLC0BAdrfW9wf+bP2iFNSRk6adMjvor
   CY5cUiG9ttgz80HmUXk5IxSok59iM2P1S9rzYI8yiY4tbJrXpe0Ga/R6c
   g==;
X-CSE-ConnectionGUID: X0vZD7/AQ6GD0z8CNFA76g==
X-CSE-MsgGUID: OVTtRh2sSLe/IqVEHRdQDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88209368"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="88209368"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 18:34:50 -0700
X-CSE-ConnectionGUID: /kfgpZcGSTmubjB/fNLP0Q==
X-CSE-MsgGUID: ULyKWZofSqqD/ALE8vjMiw==
X-ExtLoop1: 1
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 18:34:49 -0700
Message-ID: <c62c2c19-cf0b-4634-89f4-b8b87843552b@linux.intel.com>
Date: Tue, 25 Aug 2026 09:34:47 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND Patch v10 19/23] perf/x86: Support SSP sampling using
 sample_regs_* fields
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-20-dapeng1.mi@linux.intel.com>
 <20260824093900.A8BBB1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260824093900.A8BBB1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/24/2026 5:39 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [Critical] Arbitrary kernel memory read or kernel panic (page fault) via out-of-bounds pointer dereference in `perf_reg_value()` when triggering a hardware event via BPF.
> --
>
> --- Patch [19]: [RESEND Patch v10 19/23] perf/x86: Support SSP sampling using sample_regs_* fields ---
> commit f68aca90e443a6b899f0ff2729c1f378ec1fb548
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86: Support SSP sampling using sample_regs_* fields
>
> This commit adds support for sampling the CET SSP register via the
> sample_regs_* fields. It uses the spare space reclaimed from the original
> XMM space and is gated behind the sample_simd_regs_enabled flag.
>
>> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
>> index 7d4233ed859cd..f8952f7c36cce 100644
>> --- a/arch/x86/kernel/perf_regs.c
>> +++ b/arch/x86/kernel/perf_regs.c
>> @@ -72,6 +72,11 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
>>  					return 0;
>>  				return perf_regs->egpr_regs[idx - PERF_REG_X86_R16];
>>  			}
>> +			if (idx == PERF_REG_X86_SSP) {
>> +				if (!perf_regs->ssp)
>> +					return 0;
>> +				return *perf_regs->ssp;
>> +			}
> [Severity: Critical]
> This is a pre-existing issue, but does this function correctly handle the case
> where regs is not embedded in a struct x86_perf_regs?
>
> If a hardware event is added to a BPF_MAP_TYPE_PERF_EVENT_ARRAY map and
> triggered by a BPF program calling bpf_perf_event_output(),
> perf_prepare_sample() uses the raw pt_regs from the BPF context.
> perf_sample_regs_user() then sets the sample's user regs to
> task_pt_regs(current).
>
> When perf_output_sample_regs() subsequently calls perf_reg_value(), it blindly
> casts this raw pt_regs pointer to struct x86_perf_regs using container_of():
>
> arch/x86/kernel/perf_regs.c:perf_reg_value() {
>     ...
>     if (idx > PERF_REG_X86_R15) {
>         perf_regs = container_of(regs, struct x86_perf_regs, regs);
>         if (perf_regs->abi == PERF_SAMPLE_REGS_ABI_NONE)
>             return 0;
>     ...
> }
>
> Since task_pt_regs(current) is located at the very end of the task's stack
> page, reading fields like the abi or xmm_regs pointer accesses the vmap stack
> guard page, which can trigger a kernel panic. Can this be avoided by verifying
> the origin of the regs pointer before casting?

Same concern with patch 13/23 "perf/x86: Support XMM sampling using
sample_simd_vec_reg_* fields". Copy the comments here.

"

This concern would never happen. Currently any event trying to sample SIMD
and other extended registers would check if its PMU supports the
PERF_PMU_CAP_SIMD_REGS or PERF_PMU_CAP_EXTENDED_REGS (XMM) capability. If
not, the event creation would fail at the beginning. Thanks.

    if (!(pmu->capabilities & PERF_PMU_CAP_SIMD_REGS) &&
        event_has_simd_regs(event)) {
        ret = -EOPNOTSUPP;
        goto err_destroy;
    }

    if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
        event_has_extended_regs(event)) {
        ret = -EOPNOTSUPP;
        goto err_destroy;
    }

"


>
