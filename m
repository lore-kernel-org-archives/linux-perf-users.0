Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1012264B0
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Aug 2026 01:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787619801; cv=none; b=fVyYBWqE4VfmhZC/vN2YCBRhqCCzWqc8E1dCOdOROutzrT8POb1EF6mAGDN+uGAtrFOufNg3+iOxA2VUnZGXBa+rs/usdXUx/7fOCjZ4AB0/z8iTERrXXJPZ1TkpA+186eALjEcuAzdpRw23CbzFYnPHIpjgnGUviCsYOgEXJ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787619801; c=relaxed/simple;
	bh=ZrjdvHk7cr/xfdowLo193si5pZ+0LUUMJaJjJPWTGns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M2s9o2Qma2YBB4cBltafS2HtdFBZaXULPOg+wXVANNVaUjW3wFX91cA5FGIfqDvuAfoMxVrg5SYsavIU8Npli/tKgmgiHmp+hxyRIGvMLvpSs2tWntRzVJtTb20+PgMPcRBhLqEp9vyMfsWuJXotjP/U5Xr9Ly+iBcEpRR7jN18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gow9gb/D; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gow9gb/D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787619799; x=1819155799;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZrjdvHk7cr/xfdowLo193si5pZ+0LUUMJaJjJPWTGns=;
  b=Gow9gb/DlFcX0Q4Sd0HjrVJjq3Ud8vMPxcMD7KSnBlAklsawCCR4YiS3
   evmn8ARnabeRmerPtXJ/awWrelBq+WhV6cqtqtwA4SDZUjrtPD2Bno4WZ
   lt9GK60Ighf7ZQMpjwPlGUFrQilBuhbe1G6qhfr5+epZ/Wx/zxP2AJi2E
   /7ylVsKF6fWEWvLMR2aTZHFGzXJsy1S4So8JvzfncLm5AkhcJBkgllNf8
   x+BASB/TK/lI2RVP5yVtnv5BpIr27a2E7kpqmBYf++EUHJ2mDcagzgRX1
   M/HCvXNplOK7qXpMHBwdC4ExwGTs8jhPSp3PtTgRDJY96+GvntNBYKSMi
   w==;
X-CSE-ConnectionGUID: AB/U48PvTzK2anCt/qI1lw==
X-CSE-MsgGUID: FVVd5FHXSeqxMWmc3QXitw==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="87846066"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="87846066"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 18:03:18 -0700
X-CSE-ConnectionGUID: mp0gBBiUTM+0D0ZM/mkvaw==
X-CSE-MsgGUID: bIEZhqo1Qiq/XbqH2TeopA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="265834159"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 18:03:16 -0700
Message-ID: <029473ae-0bee-4e67-9bdf-1855ec8e2410@linux.intel.com>
Date: Tue, 25 Aug 2026 09:03:14 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND Patch v10 06/23] x86/fpu/xstate: Add xsaves_nmi() helper
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-7-dapeng1.mi@linux.intel.com>
 <20260824085408.595F21F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260824085408.595F21F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/24/2026 4:54 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] xsaves_nmi() uses the XSAVES instruction which employs hardware 'modified optimization', causing catastrophic data corruption for the interrupted task.
> --
>
> --- Patch [6]: [RESEND Patch v10 06/23] x86/fpu/xstate: Add xsaves_nmi() helper ---
> commit 2691ef22b25df7392d6766bb1de8a6d97a6ee37c
> Author: Kan Liang <kan.liang@linux.intel.com>
>
>     x86/fpu/xstate: Add xsaves_nmi() helper
>
> This commit introduces the xsaves_nmi() helper function to allow the perf
> subsystem to save supported xsave states within an NMI handler. It is intended
> to snapshot SIMD and APX eGPR registers at the exact moment an NMI occurs.
>
>> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
>> index a7b6524a9dea2..d39c01546dee7 100644
>> --- a/arch/x86/kernel/fpu/xstate.c
>> +++ b/arch/x86/kernel/fpu/xstate.c
> [ ... ]
>> @@ -1474,6 +1474,29 @@ void xrstors(struct xregs_state *xstate, u64 mask)
> [ ... ]
>> +void xsaves_nmi(struct xregs_state *xstate, u64 mask)
>> +{
>> +	int err;
>> +
>> +	if (!in_nmi())
>> +		return;
>> +
>> +	XSTATE_OP(XSAVES, xstate, (u32)mask, (u32)(mask >> 32), err);
> [Severity: Critical]
> Does executing the xsaves instruction in this context corrupt the FPU state of
> the interrupted task?
>
> According to the Intel SDM, the xsaves instruction employs a modified
> optimization that unconditionally resets the CPU internal state-component
> tracking, marking all components as unmodified.
>
> If a task is interrupted by an NMI (such as a perf PMI) and this instruction
> executes, won't the subsequent context switch out of the task also see the
> state as unmodified? It seems the normal context-switch xsaves would silently
> skip saving the state to the task FPU buffer, losing any SIMD modifications
> made prior to the NMI.
>
> Additionally, since xsaves skips writing components it considers unmodified,
> could this leak stale SIMD state from previously interrupted tasks into the
> current perf sample buffer?

No, modified optimization is bound with the xstate buffer. Currently perf
use xsaves_nmi() with an dedicated xstate buffer and each sampling xstate
would be cleared before calling the xsaves_nmi(). So it won't impact other
xsaves usages and leak the stale xstate information.

Thanks.


>
>> +	WARN_ON_ONCE(err);
>> +}
