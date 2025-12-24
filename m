Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDA22ED86F;
	Wed, 24 Dec 2025 06:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766557576; cv=none; b=B/rhN5nop9P5G1TsAE74PrYuTRWRkZp7fdQGE78IuOxvnSF+PaFVjd7FQ8AJbpqj95AiJSs+fCY6Gt65UUJPA87OKvRVgAg11C5c/xJEFoD129C1tt4tjJGSQECI3pISRjl1hAMnLrcRrL/3sqSEZIL2zhCphXc0ZqTDyLgZMhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766557576; c=relaxed/simple;
	bh=UFzFarrCT3yNZvewzjiGsT05S54pIxoQU4+hOPTywEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJM3r2SaiYTE+BZiQ5gYbGlGRajNO1SE9oCdJx2NXi9h7aoO5JhQ99GTuCqnmUxUAt/U8kjRV8YXN1BWZDk8Tm7CZnUCt5qns3MxtaYTk+vXAEDte37f3h6tA8KXSUranSiDsMe44gUXUZo8gpQCQpmjZlGHIMVepZmW6q9ZjXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EWpNcdxt; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EWpNcdxt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766557575; x=1798093575;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UFzFarrCT3yNZvewzjiGsT05S54pIxoQU4+hOPTywEI=;
  b=EWpNcdxtOoiOo1C7zBsecYtTidiLraw7JGWP7dw/rbalmNF0HRZV2vXQ
   in4vB0+CmczV6Rn/c5HeXNlUlSs6Dn99xmjBUs1CpiK/q2JE+5TLpMJfa
   xDP59kLMp0lHV5onMHsXs3P7qOQh2CsGzMG5QtA52GtktU2Xx2Ix0dkvY
   x+6JSYMJkDSV46dbIyz1K0MNKhbsGtnvi0os0Zez+VYeLFKZbOXDUKpd8
   RRtk4E1Fx2bv+tecwUhoH2Fi2Q9bXFIL6lZ7L+exVI0YRaJM6v7Xrk7qF
   Z9As/QXur+G/UIOiBOj82yxOaDE8VtjD6RqWzuqcYvQmLJJ53lMDt7PSl
   w==;
X-CSE-ConnectionGUID: eP/OGw2rQ6KpZHld41qtng==
X-CSE-MsgGUID: eFSbd9/NTum6Rd8pj74PyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="68471290"
X-IronPort-AV: E=Sophos;i="6.21,172,1763452800"; 
   d="scan'208";a="68471290"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 22:26:14 -0800
X-CSE-ConnectionGUID: xCESUGycTbqHbH4j1vqzqw==
X-CSE-MsgGUID: tQsBr7NqQEKakZUjsFUoIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,172,1763452800"; 
   d="scan'208";a="200843999"
Received: from unknown (HELO [10.238.21.57]) ([10.238.21.57])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 22:26:09 -0800
Message-ID: <2c621029-e0d1-4d54-8abc-c25ee9cfb215@linux.intel.com>
Date: Wed, 24 Dec 2025 14:26:07 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 13/19] perf/x86: Enable SSP sampling using
 sample_regs_* fields
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-14-dapeng1.mi@linux.intel.com>
 <3e56e2f1-42bd-45e6-90a7-4105386d63ed@amd.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <3e56e2f1-42bd-45e6-90a7-4105386d63ed@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 12/24/2025 1:45 PM, Ravi Bangoria wrote:
> Hi Dapeng,
>
>> This patch enables sampling of CET SSP register via the sample_regs_*
>> fields.
>>
>> To sample SSP, the sample_simd_regs_enabled field must be set. This
>> allows the spare space (reclaimed from the original XMM space) in the
>> sample_regs_* fields to be used for representing SSP.
>>
>> Similar with eGPRs sampling, the perf_reg_value() function needs to
>> check if the PERF_SAMPLE_REGS_ABI_SIMD flag is set first, and then
>> determine whether to output SSP or legacy XMM registers to userspace.
> 1. The userspace SSP is saved in REGS_INTR even though interrupt regs
>    are of kernel context. Would it be better to pass 0 instead (see the
>    _untested_ patch below).
>
> --- a/arch/x86/kernel/perf_regs.c
> +++ b/arch/x86/kernel/perf_regs.c
> @@ -71,7 +71,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
>  				return perf_regs->egpr_regs[idx - PERF_REG_X86_R16];
>  			}
>  			if (idx == PERF_REG_X86_SSP) {
> -				if (!perf_regs->cet)
> +				if (!perf_regs->cet || !user_mode(regs))

Hmm, I'm not sure if we should add the user_mode() check here. For non-PEBS
case, the SSP value indeed comes from the user space SSP MSR
(MSR_IA32_PL3_SSP) since SSP is not used in kernel now. But for arch-PEBS,
I don't get a clear indication that the SSP value comes from kernel space
SSP (MSR_IA32_PL0_SSP) or the user space SSP (MSR_IA32_PL3_SSP) from the
ISE doc (section 11.4.3 "General-Purpose Register Group"). Let me double
confirm with our HW experts. Thanks for raising this.


>  					return 0;
>  				return perf_regs->cet->user_ssp;
>  			}
>
> 2. Could a simple "--user-regs=ssp / --intr-regs=ssp" (without SIMD/eGPR
>    regs) fallback to an RDMSR instead of XSAVE? Possibly as a future
>    enhancement if the current patches are already upstream ready.

Yeah, good suggestion. Dave ever raised the efficiency concern for using
xsaves to reading SSP
(https://lore.kernel.org/all/3921d500-36ce-409c-8730-6be86a40e334@intel.com/).
I don't see there are security risks by using rdmsr to read SSP value
(Please correct me if it's wrong), I would add an extra patch to implement
this optimization in the tail of next version patch-set. Thanks.


>
> Thanks,
> Ravi
