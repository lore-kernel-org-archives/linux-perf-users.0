Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793321140;
	b=Xrkn7XSsXL0b7+O0h+o9RLl2qmuNphcIOZi3zzsHwMLYNOg+n/S0EahARHCq+Jis9OzZ
	 WJPUFOW29wUlUo+r+gYYTVrLsb8v/bORcVZ1J5yLNqjINXxHMK0K2SwO5fda84ftcdlmj
	 IhhuIKpXzP+3wdDv2t3GUpBhwaJxU1NLJKxcdAraHEQ14VTUiJfU5nuM4QHi6GPfKAzBg
	 bho2vJiGrEp63pmsvyrtPM9nkgiDIQSOT4QzC4ufkyPeY+nE6T6jjdWHjliHXHdLAECCI
	 t5V6e7ZUfKqQBS7oHjWpW/3rZZ8ZdVt427TuVO1APmBsucIe0fykb1toS32UZy/1cFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793321140;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=dqTSZz88EEh8ZELacMbZ3PLmZPsLOwVoSmrw//6jRJg=;
	b=mIR7jnVM5ga00ASli5Gjkt8BvY3fTs7TlVKYV8DYuZx8E7LJzdTJnQFdQ5O1SmxcS8L2
	 hmsyU7xj/hYOYjEm4KMxK9qf43RFMJ48F5HimSGK4WgJNi+0td84eGM8z2tHQCCdd/i5X
	 yOvvKUBnqjrui3XuUnA0xJgmtFGS+D3HtOGddfZ5/JIN76tW2GNj4G6YCXloZW6oOdlu9
	 CgwFo2xH1hQI41K2+S67zgl1pqKUlMYhlVOBzC6IZyRb5PwKv2kqIDG9a1KKUkIoUBo7m
	 BF1Wf29wPSuh3WIOPsxiS/pWmkXsJGSzQIKfJj4ZnOtw0DFmZxltjfQH6ZuNeFUWYHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J7m3UpnX;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B5D606A31A;
	Fri, 30 Oct 2026 00:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51B5D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J7m3UpnX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793321140; x=1824857140;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M4PqKloQ+6YTYsFOI0TadbR2AC/12M332qvttXbFns4=;
  b=J7m3UpnX8ZFn6CC75yeYVtBr47fFztcAaRF+JXK+I//qdjEgZU9eicJ7
   nyhBP2AQv3hxKOK7Ffrz5R5mK5Q1gSVXzrdG+QM/8V5mEjR0kMVVggCj7
   V6D0BTicIXmm9ZgJzuKiNn2oSjksYGz5HlK4G215EzXyWXnGyO3zYsk0u
   XHSpmVPJSTCQFzgj4qcaOh/GfBwQRVgrn3JTp/9t8vqp1SMksscXIyjg8
   31RMSEOql9j5uY0HBNDXUkjq3LPHXBI/mieiUW4swt2NqAz+o+oC3iW2A
   wwbkIUcRfILmH+PvyI+H4VIU63DuUDUMgwmbFt7Sgsnke4N4c4kD2jxvG
   Q==;
X-CSE-ConnectionGUID: 4ZQuNp+pRlKp0/cSp7Cvzg==
X-CSE-MsgGUID: 6H+7snwmTzKP0Yn03xwtAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2071727"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="2071727"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 17:45:39 -0700
X-CSE-ConnectionGUID: 2AaxHfzmRZSTr+ZYbMytHA==
X-CSE-MsgGUID: i1jLULhJTdWRBrIo/d77LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="7077310"
Received: from unknown (HELO [10.238.2.61]) ([10.238.2.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 17:45:34 -0700
Message-ID: <3d477ba2-d2af-44a4-a615-3664b0c79c01@linux.intel.com>
Date: Fri, 30 Oct 2026 08:45:31 +0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 01/18] perf/x86: Disable LBR if x86_pmu.lbr_nr exceeds
 MAX_LBR_ENTRIES
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Sandipan Das <sandipan.das@amd.com>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-2-dapeng1.mi@linux.intel.com>
 <20261029093845.GI1779021@noisy.programming.kicks-ass.net>
 <041e5185-ff2d-4423-af5d-aed6628973c5@linux.intel.com>
 <20261029101927.GB1813469@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20261029101927.GB1813469@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/29/2026 6:19 PM, Peter Zijlstra wrote:
> On Thu, Oct 29, 2026 at 05:56:15PM +0800, Mi, Dapeng wrote:
>> On 10/29/2026 5:38 PM, Peter Zijlstra wrote:
>>> On Thu, Oct 29, 2026 at 12:38:57PM +0800, Dapeng Mi wrote:
>>>> Add a sanity check for x86_pmu.lbr_nr. If the hardware reports more LBR
>>>> entries than MAX_LBR_ENTRIES, disable LBR to avoid out-of-bounds access
>>>> in the cached LBR stack handling path.
>>> Cute, can this actually happen?
>> Currently it won't happen on real hardware since the maximum LBR stack
>> depth what hardware supports is 32. But it's better have this sanity check
>> assume the LBR stack depth could be extended to 64 or larger.
>>
>>
>>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>>> ---
>>>>  arch/x86/events/amd/lbr.c    | 8 +++++++-
>>>>  arch/x86/events/intel/core.c | 7 +++++++
>>>>  2 files changed, 14 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
>>>> index a55646fcb846..96c5b5e56053 100644
>>>> --- a/arch/x86/events/amd/lbr.c
>>>> +++ b/arch/x86/events/amd/lbr.c
>>>> @@ -433,7 +433,13 @@ __init int amd_pmu_lbr_init(void)
>>>>  	ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
>>>>  	x86_pmu.lbr_nr = ebx.split.lbr_v2_stack_sz;
>>>>  
>>>> -	pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
>>>> +	if (x86_pmu.lbr_nr > MAX_LBR_ENTRIES) {
>>>> +		pr_warn("LBR entries %d exceeds max %d, disable LBR.\n",
>>>> +			x86_pmu.lbr_nr, MAX_LBR_ENTRIES);
>>>> +		x86_pmu.lbr_nr = 0;
>>>> +	} else {
>>>> +		pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
>>>> +	}
>>>>  
>>>>  	return 0;
>>>>  }
>>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>>> index 0a34d674df59..10c694db85ea 100644
>>>> --- a/arch/x86/events/intel/core.c
>>>> +++ b/arch/x86/events/intel/core.c
>>>> @@ -9023,6 +9023,13 @@ __init int intel_pmu_init(void)
>>>>  	 */
>>>>  	if (x86_pmu.lbr_tos && !check_msr(x86_pmu.lbr_tos, 0x3UL))
>>>>  		x86_pmu.lbr_nr = 0;
>>>> +
>>>> +	if (x86_pmu.lbr_nr > MAX_LBR_ENTRIES) {
>>>> +		pr_warn("LBR entries %d exceeds max %d, disable LBR.\n",
>>>> +			x86_pmu.lbr_nr, MAX_LBR_ENTRIES);
>>>> +		x86_pmu.lbr_nr = 0;
>>>> +	}
>>>> +
>>>>  	for (i = 0; i < x86_pmu.lbr_nr; i++) {
>>>>  		if (!(check_msr(x86_pmu.lbr_from + i, 0xffffUL) &&
>>>>  		      check_msr(x86_pmu.lbr_to + i, 0xffffUL)))
>>> Would it make sense to have but one copy of this check in
>>> init_hw_perf_events(), after calling into the micro-arch code?
>> Yes, that's what the previous version does, but Sashiko complains it's too
>> late.
>>
>> "
>>
>> Does zeroing x86_pmu.lbr_nr here in init_hw_perf_events() happen too late,
>> after intel_pmu_init() and amd_pmu_init() have already configured hardware
>> and driver state using the unvalidated x86_pmu.lbr_nr value?
>>
>> "
>>
>> https://lore.kernel.org/all/sashiko-outbox-179814@kernel.org/
>>
>> It makes sense in some ways, so move the sanity check into the vendor init
>> in this version. 
> Urgh. But there are no events yet that early, none of that can actually
> happen.
>
> If we're really worried about this, change the micro-arch init to spawn
> in disabled state and we call x86_pmu_enable_all() at the end.
>
> Also, this is before x86_pmu_static_call_update(), nothing really
> 'works' yet anyway.

Yeah, I agree. I don't think it would cause any real functionality issue by
deferring the LBR disabling into init_hw_perf_events(). The only flaw is
that the vendor pmu init function has already printed the LBR stack depth
which indicates LBR works, and then init_hw_perf_events() prints LBR is
disabled. It may cause some confusion for uses. But anyway, I don't think
it's a big deal.


