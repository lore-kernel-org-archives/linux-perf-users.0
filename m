Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57A9432BF1;
	Wed,  5 Aug 2026 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930007; cv=none; b=gd9oCdfNODw97e/APeNlusZZw9IrqfO6rvnMrak9s6ZmZ7sEJdR+O25oCHs+53YGTXhHabad8hNQDotHxrnPEoqFExGyhnnzAoN5Hmsd0FKfPhWlFf4R1h7zEFw+KTh9ie+U8lDeSpKgQIu25CgEWBU/Jo7ft1zZTESO4LKI8dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930007; c=relaxed/simple;
	bh=7xiAm8lZp+LxRkGd/643XnqYU0Rwk4DKYHPOda4fVPY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=F4sOW5p+XtvuEN//5hyek1ScKiU7kGsoLmoJR3BfGS9hHg/DjrSX/zBijvpKvp0y71DN0sETQTJQ7c3E2yLVpxuGgaZQq0X2QwpZCleEMWhfaaqiRMip/02dyfesYb4hHg4w99XUP4xCOxFwKm7s95/937NG1Jd8sug40F1gKdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hFT3V4KQXzb0thx;
	Wed,  5 Aug 2026 19:39:50 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hFT3T3htvzb0thx;
	Wed,  5 Aug 2026 19:39:49 +0800 (CST)
Received: from [10.32.68.20] ([10.32.68.20] [10.32.68.20])
	by zhaoxin.com (8.30) with ESMTP93a415de1611863306424c967f4850be
	Wed, 05 Aug 2026 19:39:48 +0800
X-Eyou-Smtpauth: tonywwangoc@zhaoxin.com
X-Eyou-EnvelopeSender: TonyWWang-oc@zhaoxin.com
X-Eyou-From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
From: "=?UTF-8?B?VG9ueSBXIFdhbmctb2M=?=" <TonyWWang-oc@zhaoxin.com>
Message-ID: <9fa90a4a-6b92-49f3-926d-ce6c2175524f@zhaoxin.com>
Date: Wed, 5 Aug 2026 19:39:40 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] perf/x86: Do not read fixed counter control register
 if there is none
To: Petr Tesarik <ptesarik@suse.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 "CobeChen@zhaoxin.com" <CobeChen@zhaoxin.com>, LouisQi@zhaoxin.com,
 SilviaZhao@zhaoxin.com
References: <20260717150315.2868314-1-ptesarik@suse.com>
 <20260717151858.8ED701F000E9@smtp.kernel.org>
 <20260717175135.450f2788@mordecai>
Content-Language: en-US
In-Reply-To: <20260717175135.450f2788@mordecai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Eyou-Sender: <tonywwang-oc@zhaoxin.com>



On 2026/7/17 23:51, Petr Tesarik wrote:
> On Fri, 17 Jul 2026 15:18:58 +0000
> sashiko-bot@kernel.org wrote:
> 
>> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>>
>> New issues:
>> - [Medium] Using `x86_pmu.fixedctr` as a capability flag is conceptually flawed and suppresses valid debug output on Zhaoxin.
>>
>> Pre-existing issues:
>> - [High] Zhaoxin PMU fails to initialize `x86_pmu.fixedctr`, leading to broken fixed counters and unsafe RDMSR accesses.
>> - [High] Undefined behavior in `GENMASK_ULL` during Zhaoxin PMU initialization if fixed counters are missing.
>> --
>>
>> --- Patch [1]: [PATCH 1/1] perf/x86: Do not read fixed counter control register if there is none ---
>> commit d0dd53a6709a65141e2d105b19abad4d851825d4
>> Author: Petr Tesarik <ptesarik@suse.com>
>>
>> perf/x86: Do not read fixed counter control register if there is none
>>
>> This patch skips reading the MSR_ARCH_PERFMON_FIXED_CTR_CTRL register
>> during perf debug output if fixed counters are not implemented. This avoids
>> a #GP on AMD CPUs with PerfMonV2 that do not implement this register.
>>
>>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>>> index 576baa9a52c5b..3055d59e0e82f 100644
>>> --- a/arch/x86/events/core.c
>>> +++ b/arch/x86/events/core.c
>>> @@ -1572,13 +1572,16 @@ void perf_event_print_debug(void)
>>>   		rdmsrq(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
>>>   		rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, status);
>>>   		rdmsrq(MSR_CORE_PERF_GLOBAL_OVF_CTRL, overflow);
>>> -		rdmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, fixed);
>>>   
>>>   		pr_info("\n");
>>>   		pr_info("CPU#%d: ctrl:       %016llx\n", cpu, ctrl);
>>>   		pr_info("CPU#%d: status:     %016llx\n", cpu, status);
>>>   		pr_info("CPU#%d: overflow:   %016llx\n", cpu, overflow);
>>> -		pr_info("CPU#%d: fixed:      %016llx\n", cpu, fixed);
>>> +
>>> +		if (x86_pmu.fixedctr) {
>>
>> [Severity: Medium]
>> Is it safe to use x86_pmu.fixedctr as a capability flag here?
> 
> Good question. In fact, I thought about it, and yes, introducing a new
> flag would be the cleanest solution, but it seemed overkill just for
> this debugging output.
> 
> AFAIK the MSR offset of the fixed perf counters cannot be zero, because
> those MSR addresses have been assigned to other architectural MSRs since
> Pentium times...
> 
>> The x86_pmu.fixedctr field is an MSR address, not a boolean capability
>> flag. While this check works for most architectures, the Zhaoxin PMU driver
>> fails to initialize this field, leaving it as 0. Because of this, the check
>> evaluates to false and inadvertently suppresses the debug output of
>> MSR_ARCH_PERFMON_FIXED_CTR_CTRL on Zhaoxin systems.
> 
> I don't know about Zhaoxin. Do these syste have fixed performance
> counters and a corresponding global control register?
> 
Yes, Zhaoxin system have fixed performance counters and a corresponding 
global control register.

> Adding Tony W Wang to the recipient list...
> 
> Petr T
> 
> --
> 
>>> +			rdmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL,
>>> fixed);
>>> +			pr_info("CPU#%d: fixed:      %016llx\n",
>>> cpu, fixed);
>>> +		}
>>>   		if (pebs_constraints) {
>>>   			rdmsrq(MSR_IA32_PEBS_ENABLE, pebs);
>>>   			pr_info("CPU#%d: pebs:       %016llx\n",
>>> cpu, pebs);
>> [ ... ]
>>
>>
>> [Severity: High]
>> This is a pre-existing issue and was not introduced by the patch under
>> review, but the lack of initialization for x86_pmu.fixedctr causes
>> other issues.
>>
>> In the Zhaoxin PMU driver setup:
>>
>> arch/x86/events/zhaoxin/core.c:zhaoxin_pmu
>> static const struct x86_pmu zhaoxin_pmu __initconst = {
>>      ...
>>      /* missing .fixedctr = MSR_ARCH_PERFMON_FIXED_CTR0 */
>> };
>>
This issue has indeed resulted in an “perf -e instructions” bug on 
Zhaoxin processors. Although Tanze submitted a patch in 2025, it seems 
it has not yet been merged to mainstream.
https://lkml.org/lkml/2025/6/19/141


>> Because this remains 0, x86_pmu_fixed_ctr_addr() returns 0 + idx
>> instead of the correct MSR. This causes fixed counter 0 to silently
>> return without updating in x86_perf_event_update():
>>
>> arch/x86/events/core.c:x86_perf_event_update() {
>>      ...
>>      if (unlikely(!hwc->event_base))
>>          return 0;
>>      ...
>> }
>>
>> It also leads to unsafe MSR reads when iterating over the fixed
>> counter mask in perf_event_print_debug():
>>
>> arch/x86/events/core.c:perf_event_print_debug() {
>>      ...
>>      for_each_set_bit(idx, fixed_cntr_mask, X86_PMC_IDX_MAX) {
>>          ...
>>          rdmsrq(x86_pmu_fixed_ctr_addr(idx), pmc_count);
>>          ...
>>      }
>> }
>>
>> Could this lead to reads from arbitrary low MSRs like MSR 0, 1, or 2,
>> potentially triggering a system crash if a user programs fixed counter
>> events or triggers SysRq-P?
>>
>>
>> [Severity: High]
>> This is a pre-existing issue and was not introduced by the patch under
>> review, but does this bitmask generation in the Zhaoxin PMU
>> initialization risk undefined behavior?
>>
>> arch/x86/events/zhaoxin/core.c:zhaoxin_pmu_init() {
>>      ...
>>      x86_pmu.fixed_cntr_mask64 =
>> GENMASK_ULL(edx.split.num_counters_fixed - 1, 0); ...
>> }
>>
>> If a hypervisor configures the CPU to report 0 fixed counters,
>> edx.split.num_counters_fixed - 1 wraps to -1. Expanding
>> GENMASK_ULL(-1, 0) results in a right-shift by 64, which is undefined
>> behavior in C. On x86, this yields ~0ULL, making the kernel assume 64
>> fixed counters exist.
>>
>> Could this cause the kernel to attempt reading 64 undefined MSRs
>> during debug output or event initialization, leading to #GP
>> exceptions?
>>
This issue may exist. Can the code be changed as follows?

if (edx.split.num_counters_fixed == 0) {
     x86_pmu.fixed_cntr_mask64 = 0;
} else {
     x86_pmu.fixed_cntr_mask64 = 
GENMASK_ULL(edx.split.num_counters_fixed - 1, 0);
}


In addition, this issue also appears to exist in the Intel PMU driver, 
should we fix them together?

Sincerely!
TonyWWang-oc

