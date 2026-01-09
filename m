Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE79C13B;
	Fri,  9 Jan 2026 01:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767922272; cv=none; b=CsbLXL2h4cmHfL/GWxkX8lVMsA3FkKLcBov5NJzXCLvEcfBFiiK50H6+pfzPR8TWWdZlylfWOOgDgFRpq33TgYiTvyVCiSVA3T1aa5y51McyFdT/bddeCTSvCY9i5oe1h4N/Hd0G/7ow7L2We8t+Fib+VWeLDU7WAQ7r2uacW5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767922272; c=relaxed/simple;
	bh=atgpXFJyrfWquoJryVhd48MdKo72LYVYUKiL3UwplRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nqtn5jWohvZ4DM7P4gcDuLLqNEB+MsJN/KvG5k3H+iHDYpaDRc178GAAQLviDgsUt9Sxki0xKIMKOBe1F03EXalbINXgCEP81JVZtJ1ZRwa5S4ZxLtWl08IxMAYyg/Md0v1sTFSsUM39hNva0IdwQCGEta2vuegHk3NZe60JaaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aGNJqUSI; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aGNJqUSI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767922271; x=1799458271;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=atgpXFJyrfWquoJryVhd48MdKo72LYVYUKiL3UwplRA=;
  b=aGNJqUSIZte37bf+hAfXGQJAtI6iOyqLTLKQjO3rR6C4rOFZc4OGpymL
   eX8GjYr0CGTTzx+F3OEyxbeO9L1wBIZg6qDBvbcljDLmRyoMRNbvmOL6Q
   8udI4QEQzY2LcLCcL5YFCq9Ej5Ktl+hrBYW0R5HXqZ8nyv6Rr+M1B3xSS
   NDdM8itDN/uuSvVqNl5KZEuuqYpOwYINAI5w8t5pA9aS/+LH9JHBMOHYK
   zkDBmhjKG2l4K1f1+2jfooG1wBymR6Rnsx2eR5XoQPBkR9BgyOeMidnSL
   S0YY2d+5E2yW7rEzBsPuQcmI5XxWCreOaI0bEy4PUAGVXUHQT4lTqc7YU
   w==;
X-CSE-ConnectionGUID: xB4pc3hLSGa4/owPVEGnVA==
X-CSE-MsgGUID: gWhJoaoVQKeF8xqKiYAkjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="69356948"
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="69356948"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 17:31:10 -0800
X-CSE-ConnectionGUID: 1/6zvZQfQmalggsSWwEQ9A==
X-CSE-MsgGUID: oP29j8GMS12blSBH4caYCQ==
X-ExtLoop1: 1
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 17:31:06 -0800
Message-ID: <b455ea34-dc59-454e-a1d5-cb8db3a586fb@linux.intel.com>
Date: Fri, 9 Jan 2026 09:31:04 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] perf/x86/intel: Support newly introduced 4 OMR MSRs
 for DMR & NVL
To: "Chen, Zide" <zide.chen@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20251120053431.491677-1-dapeng1.mi@linux.intel.com>
 <20251120053431.491677-2-dapeng1.mi@linux.intel.com>
 <b866d09f-bb92-41f3-b120-f5389f7fa290@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <b866d09f-bb92-41f3-b120-f5389f7fa290@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/9/2026 3:34 AM, Chen, Zide wrote:
>
> On 11/19/2025 9:34 PM, Dapeng Mi wrote:
>> Diamond Rapids and Nova Lake feature an expanded facility called
>> the Off-Module Response (OMR) facility, which replaces the Off-Core
>> Response (OCR) Performance Monitoring of previous processors.
>>
>> Legacy microarchitectures used the OCR facility to evaluate off-core
>> and multi-core off-module transactions. The properly renamed, OMR
>> facility, improves the OCR capability for scalable coverage of new
>> memory systems of multi-core module systems.
>>
>> Similarly with OCR, 4 additional off-module configuration MSRs
>> OFFMODULE_RSP_0 ~ OFFMODULE_RSP_3 are introduced to specify
>> attributes of the off-module transaction.
>>
>> For more details about OMR, please refer to section 16.1 "OFF-MODULE
>>  RESPONSE (OMR) FACILITY" in ISE documentation.
>>
>> This patch adds support for these 4 OMR events.
>>
>> ISE link: https://www.intel.com/content/www/us/en/content-details/869288/intel-architecture-instruction-set-extensions-programming-reference.html
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/intel/core.c     | 45 +++++++++++++++++++++++---------
>>  arch/x86/events/perf_event.h     |  5 ++++
>>  arch/x86/include/asm/msr-index.h |  5 ++++
>>  3 files changed, 42 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index aad89c9d9514..5970f7c20101 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -3529,17 +3529,24 @@ static int intel_alt_er(struct cpu_hw_events *cpuc,
>>  	struct extra_reg *extra_regs = hybrid(cpuc->pmu, extra_regs);
>>  	int alt_idx = idx;
>>  
>> -	if (!(x86_pmu.flags & PMU_FL_HAS_RSP_1))
>> -		return idx;
>> -
>> -	if (idx == EXTRA_REG_RSP_0)
>> -		alt_idx = EXTRA_REG_RSP_1;
>> -
>> -	if (idx == EXTRA_REG_RSP_1)
>> -		alt_idx = EXTRA_REG_RSP_0;
>> +	if (idx == EXTRA_REG_RSP_0 || idx == EXTRA_REG_RSP_1) {
>> +		if (!(x86_pmu.flags & PMU_FL_HAS_RSP_1))
>> +			return idx;
>> +		if (++alt_idx > EXTRA_REG_RSP_1)
>> +			alt_idx = EXTRA_REG_RSP_0;
>> +		if (config & ~extra_regs[alt_idx].valid_mask)
>> +			return idx;
>> +	}
>>  
>> -	if (config & ~extra_regs[alt_idx].valid_mask)
>> -		return idx;
>> +	if (idx >= EXTRA_REG_OMR_0 && idx <= EXTRA_REG_OMR_3) {
>> +		if (!(x86_pmu.flags & PMU_FL_HAS_OMR))
>> +			return idx;
>> +		if (++alt_idx > EXTRA_REG_OMR_3)
>> +			alt_idx = EXTRA_REG_OMR_0;
>> +		if (config &
>> +		    ~extra_regs[alt_idx - EXTRA_REG_OMR_0].valid_mask)
> Why minus EXTRA_REG_OMR_0?

This is to get the valid_mask of correct pre-defined extra_regs entry. ALL
the entries of extra_regs for OCR/OMR must be put the head of the whole
extra_regs entries (from index 0 starts), so we need to minus the 
EXTRA_REG_OMR_0 base.

See below comments of intel_pnc_extra_regs[].

static struct extra_reg intel_pnc_extra_regs[] __read_mostly = {
    /* must define OMR_X first, see intel_alt_er() */
    INTEL_UEVENT_EXTRA_REG(0x012a, MSR_OMR_0, 0x40ffffff0000ffffull, OMR_0),
    INTEL_UEVENT_EXTRA_REG(0x022a, MSR_OMR_1, 0x40ffffff0000ffffull, OMR_1),
    INTEL_UEVENT_EXTRA_REG(0x042a, MSR_OMR_2, 0x40ffffff0000ffffull, OMR_2),
    INTEL_UEVENT_EXTRA_REG(0x082a, MSR_OMR_3, 0x40ffffff0000ffffull, OMR_3),
    INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x01cd),
    INTEL_UEVENT_EXTRA_REG(0x02c6, MSR_PEBS_FRONTEND, 0x9, FE),
    INTEL_UEVENT_EXTRA_REG(0x03c6, MSR_PEBS_FRONTEND, 0x7fff1f, FE),
    INTEL_UEVENT_EXTRA_REG(0x40ad, MSR_PEBS_FRONTEND, 0xf, FE),
    INTEL_UEVENT_EXTRA_REG(0x04c2, MSR_PEBS_FRONTEND, 0x8, FE),
    EVENT_EXTRA_END
};

I suppose I need to add a comment here to avoid the confusion. Thanks.


>
>> +			return idx;
>> +	}
>>  
>>  	return alt_idx;
>>  }
>> @@ -3547,16 +3554,28 @@ static int intel_alt_er(struct cpu_hw_events *cpuc,
>>  static void intel_fixup_er(struct perf_event *event, int idx)
>>  {
>>  	struct extra_reg *extra_regs = hybrid(event->pmu, extra_regs);
>> -	event->hw.extra_reg.idx = idx;
>> +	int omr_idx;
>>  
>> -	if (idx == EXTRA_REG_RSP_0) {
>> +	event->hw.extra_reg.idx = idx;
>> +	switch (idx) {
>> +	case EXTRA_REG_RSP_0:
>>  		event->hw.config &= ~INTEL_ARCH_EVENT_MASK;
>>  		event->hw.config |= extra_regs[EXTRA_REG_RSP_0].event;
>>  		event->hw.extra_reg.reg = MSR_OFFCORE_RSP_0;
>> -	} else if (idx == EXTRA_REG_RSP_1) {
>> +		break;
>> +	case EXTRA_REG_RSP_1:
>>  		event->hw.config &= ~INTEL_ARCH_EVENT_MASK;
>>  		event->hw.config |= extra_regs[EXTRA_REG_RSP_1].event;
>>  		event->hw.extra_reg.reg = MSR_OFFCORE_RSP_1;
> Keep same style?
> case EXTRA_REG_RSP_0 ... EXTRA_REG_RSP_1:

Yeah, good idea. Thanks.


>
>> +		break;
>> +	case EXTRA_REG_OMR_0 ... EXTRA_REG_OMR_3:
>> +		omr_idx = idx - EXTRA_REG_OMR_0;
>> +		event->hw.config &= ~ARCH_PERFMON_EVENTSEL_UMASK;
>> +		event->hw.config |= 1ULL << (8 + omr_idx);
>> +		event->hw.extra_reg.reg = MSR_OMR_0 + omr_idx;
>> +		break;
>> +	default:
>> +		pr_warn("The extra reg idx %d is not supported.\n", idx);
>>  	}
>>  }
>>  
