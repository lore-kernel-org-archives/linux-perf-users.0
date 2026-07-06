Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F49424654
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329004; cv=none; b=l78saPTaq0uF9AqPM/SUR8Xwb3Jf5LKZiGh8CQczVVaSLnTTXWgUGnDGnE22pcIcgqFsafLTeUtm8aM0TVzBBntgiM6Ajwcn4brXdOQuniAObsXTL7NopBSQRZg7odTuq5VCI/KKdHvy2/3Zu9acDpzKmDlydFqJz1Tp0olG2qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329004; c=relaxed/simple;
	bh=LACsIA95rSlNKd1FfVfjivSxeutfUCwgCYU+klgkwa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e12w9njKDiS3tLD6jQ8PVThZC5KoN88H4/ErZU0N7cqMGEOeBw2fQGdjKviu2OKFb4C+C0MSC/k/0B30Ns5GHC2UC8lBrFY9vB15efJgP1o1hsK2qGzjcUYLr2byw16lOXkEmR128tokMhkcQvM4Z7LKDf9dNP1hqvi+D3TnLMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kjsqSLm1; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kjsqSLm1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783328998; x=1814864998;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LACsIA95rSlNKd1FfVfjivSxeutfUCwgCYU+klgkwa0=;
  b=kjsqSLm1SZ2UNQQN79Otaq/ln7SXx4RLe1npa3ALjzjSjciMLgA5MXdu
   6YsJzUaSD1LMRraxTKTUZtbDJVyh3DiFyAnKXyhndZE0qwTJSBSq6Iy3Q
   4vH2IkNxjTauKtYNN9DPTx+B11ME9fwTsKMBHQxwzAMNUP/9lgW0Np6w0
   SIKxW5sAiuGgzYWfRYl5o/mSotxKEFz83MWggpyPky8sXJ31VVVRScuuo
   RzjMKpCZ1ygcbCINRsyzX027dWOuM/ZrUYOtFXfjAIAGAd/Yq8adTVAoD
   e6DrdCP4Mzb1FkYmd+F0+UUq+k/ojZHJOlDNcjdynkiWzElcmNyBTH0fF
   Q==;
X-CSE-ConnectionGUID: 1MfxmdUmTSeA+wkdH37cNA==
X-CSE-MsgGUID: WQEKhTmeQ4KwTa7+4/cdvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="94604283"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="94604283"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 02:09:53 -0700
X-CSE-ConnectionGUID: zekXHhQwRG+9N+R9ljDYgg==
X-CSE-MsgGUID: R4iJn+zQQCO7q3lVUx1XRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="253775505"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 02:09:52 -0700
Message-ID: <f0413b94-34cf-44fb-b1fa-400e39a62b0c@linux.intel.com>
Date: Mon, 6 Jul 2026 17:09:44 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 07/24] x86/fpu/xstate: Add xsaves_nmi() helper
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
 <20260706015439.3040804-8-dapeng1.mi@linux.intel.com>
 <20260706021841.9F1AC1F00A3A@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260706021841.9F1AC1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/6/2026 10:18 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The use of the XSAVES instruction in xsaves_nmi() breaks FPU snapshotting to independent buffers due to the hardware's 'modified optimization', leading to a cross-process information leak.
> --
>
> commit e8d6f39a5d4512be90e9976febc30b8f46c0ea64
> Author: Kan Liang <kan.liang@linux.intel.com>
>
> x86/fpu/xstate: Add xsaves_nmi() helper
>
> This commit adds a new xsaves_nmi() helper to safely save supported xsave
> states from within an NMI handler. The helper is intended for the perf
> subsystem to snapshot SIMD and APX eGPRs registers.
>
>> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
>> index a7b6524a9dea2..d39c01546dee7 100644
>> --- a/arch/x86/kernel/fpu/xstate.c
>> +++ b/arch/x86/kernel/fpu/xstate.c
> [ ... ]
>
>> +void xsaves_nmi(struct xregs_state *xstate, u64 mask)
>> +{
>> +	int err;
>> +
>> +	if (!in_nmi())
>> +		return;
>> +
>> +	XSTATE_OP(XSAVES, xstate, (u32)mask, (u32)(mask >> 32), err);
> [Severity: High]
> Does this code leak stale data into the perf samples? 
>
> The XSAVES instruction uses a hardware modified optimization that tracks
> whether a state component was modified since the last XRSTORS. If a
> component is unmodified, XSAVES skips writing it to memory while still
> setting its presence bit in the XSTATE_BV header.
>
> When the perf subsystem calls xsaves_nmi() in x86_pmu_sample_xregs()
> with an independent per-CPU buffer like ext_regs_buf, skipping the memory
> write leaves whatever stale data was previously in that buffer.
>
> Because the bit in XSTATE_BV is still set, won't the perf subsystem
> read this stale data (potentially from other tasks) and leak it to
> user-space?

No, not exactly. The modified optimization only works when xrstors is
called for the same xstate area.

Copy the description about modified optimization from section 13.6 in SDM
vol. 1.

"

A processor that implements the modified optimization saves information
about the most recent execution of
XRSTOR or XRSTORS in a quantity called XRSTOR_INFO, a 4-tuple containing
the following: (1) the CPL;
(2) whether the logical processor was in VMX non-root operation; (3) *the
linear address of the XSAVE area; *and
(4) the XCOMP_BV field in the XSAVE area. An execution of XSAVEOPT or
XSAVES uses the modified optimization
only if that execution corresponds to XRSTOR_INFO on these four parameters.

"

Since xsaves_nmi() uses a dedicated xstate area and never call xrstors
instruction for this dedicated xstate area, the modified optimization won't
really happen.

Thanks.


>
>> +	WARN_ON_ONCE(err);
>> +}
