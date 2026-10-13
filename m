Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA957501299;
	Tue, 13 Oct 2026 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895999; cv=none; b=Hnly0BchmUp8zc/3mR+3Bi6m7qzJftty4hTO3G2aKY/LKpCUy1e224RThf7QEwd+8/b/py5IYG3u+Mdnl+obdh7r6+hGEO6wJ9OUzQ+sEF3j2+MT+p7UdYRlpB1+p5h70nuIQXZ6fTj8FWbK1NJgEzYrGDeRypImUSC9GMXRQyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895999; c=relaxed/simple;
	bh=axOM5j3vOY7t9ZLps+wPbthA9ApS1l0Pw7wVAlogkDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dri7Miz8Ojdf45I7lBjuQQi813p5/hRUTXnACRRD9UPxQDxi1czxEmIM3TaVTFZzlC2A/6aVXX3QAWTZ0ya/kDFxH805/gJ6dXJeZIH1bwML4aqnV+nkNMV98nhPQBZEmTv3LrNIk7eC0XNXCL5iw45CLnX+0PoaSLMxRZBaxXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHGkjZku; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHGkjZku"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791895998; x=1823431998;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=axOM5j3vOY7t9ZLps+wPbthA9ApS1l0Pw7wVAlogkDc=;
  b=KHGkjZkuLRAYuiI/EhiyzJTJ7dptm1DvbYj9gScAffWtvU/nBsyxKq3R
   /ihUq9NutsqIcXjBL2/fpy8/Bhel/KFfCKrHpoe6l9ry/TLlGPbIraZN0
   tR0ia5gOJFmENT3mtfAfphyS0grcX6vc9avpIKERtn7iYYpPZ2hbNUGjX
   M4MI2/E/0Ryy+0+saxe0KP8p+sHIq0HdSWR1NXRvsLkpTkvjnVHZnrorK
   0b9azZDGfc9nXXWHxEIdewRYoO1m2Qm8+qyVGb98DwuCSrEUSe7skqVjm
   6Rz5xDQ4AiNVWof7cosXx/dRohooSXHuoY8ytIa8u12I+3MOEzLqRotLI
   A==;
X-CSE-ConnectionGUID: IWaWJgvPSOeiINzu+RUoZA==
X-CSE-MsgGUID: 3w53d/FMQQK2qu3+nATHIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="721127"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="721127"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 05:53:17 -0700
X-CSE-ConnectionGUID: rkZEuAPGSFixoIRqexWFAQ==
X-CSE-MsgGUID: jtkGNHzqTl20mhueRPt3oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1229565"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 05:53:11 -0700
Message-ID: <becc5593-69ef-4800-bc2b-0fb217165910@linux.intel.com>
Date: Tue, 13 Oct 2026 20:53:08 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd/lbr: Limit branch snapshots to valid entries
To: Peter Zijlstra <peterz@infradead.org>, Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>
References: <20261007181002.4005262-1-sandipan.das@amd.com>
 <20261012153014.GU4121339@noisy.programming.kicks-ass.net>
 <94d387f2-ff07-4895-a722-e8ded4203309@amd.com>
 <20261013074625.GC2009045@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20261013074625.GC2009045@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/13/2026 3:46 PM, Peter Zijlstra wrote:
> On Tue, Oct 13, 2026 at 12:14:58PM +0530, Sandipan Das wrote:
>> On 12-10-2026 21:00, Peter Zijlstra wrote:
>>> On Wed, Oct 07, 2026 at 11:40:02PM +0530, Sandipan Das wrote:
>>>> The branch snapshot callback used by bpf_get_branch_snapshot() copies
>>>> up to x86_pmu.lbr_nr entries from cpuc->lbr_entries[], even when the
>>>> last LBR read kept fewer branches. The entries past lbr_stack.nr are
>>>> invalid, but they end up reaching BPF programs.
>>>>
>>>> Limit copying to lbr_stack.nr entries and also reset lbr_stack.nr when
>>>> amd_pmu_lbr_read() skips reading the registers, so that a stale count
>>>> is never reused.
>>>>
>>>> Fixes: a4d18112e531 ("perf/x86/amd: Support capturing LBR from software events")
>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>>> Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
>>>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>>>> ---
>>>>  arch/x86/events/amd/core.c | 2 +-
>>>>  arch/x86/events/amd/lbr.c  | 4 +++-
>>>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
>>>> index 49b6b8fce566..bf631f60757c 100644
>>>> --- a/arch/x86/events/amd/core.c
>>>> +++ b/arch/x86/events/amd/core.c
>>>> @@ -944,7 +944,7 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
>>>>  	cpuc = this_cpu_ptr(&cpu_hw_events);
>>>>  
>>>>  	amd_pmu_lbr_read();
>>>> -	cnt = min(cnt, x86_pmu.lbr_nr);
>>>> +	cnt = min(cnt, cpuc->lbr_stack.nr);
>>>>  	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
>>>>  
>>>>  	amd_pmu_v2_enable_all(0);
>>>> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
>>>> index 1e1b2f08cb51..a00d3850c4a8 100644
>>>> --- a/arch/x86/events/amd/lbr.c
>>>> +++ b/arch/x86/events/amd/lbr.c
>>>> @@ -165,8 +165,10 @@ void amd_pmu_lbr_read(void)
>>>>  	struct branch_entry entry;
>>>>  	int out = 0, idx, i;
>>>>  
>>>> -	if (!cpuc->lbr_users)
>>>> +	if (!cpuc->lbr_users) {
>>>> +		cpuc->lbr_stack.nr = 0;
>>>>  		return;
>>>> +	}
>>>>  
>>>>  	for (i = 0; i < x86_pmu.lbr_nr; i++) {
>>>>  		entry.from.full	= amd_pmu_lbr_get_from(i);
>>> You now seem to deviate from what the Intel code does. Please clarify.
>> Yes, it is a deviation. I thought of proposing the following but didn't
>> proceed because I was not sure about the if condition in the second hunk
>> which considers things other than cpuc->lbr_users for an early return.
> Dapeng, can you look into this? I would really like to keep behaviour
> consistent where possible.

Sure.


>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 0a34d674df59..5dfb9e9156e8 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -2822,7 +2822,7 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
>>         struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>
>>         intel_pmu_lbr_read();
>> -       cnt = min_t(unsigned int, cnt, x86_pmu.lbr_nr);
>> +       cnt = min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
>>
>>         memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
>>         intel_pmu_enable_all(0);
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> index 0b446d8912e4..6b070490f461 100644
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
>> @@ -1026,8 +1026,10 @@ void intel_pmu_lbr_read(void)
>>          * but this simple approach seems to work for now.
>>          */
>>         if (!cpuc->lbr_users || vlbr_exclude_host() ||
>> -           cpuc->lbr_users == cpuc->lbr_pebs_users)
>> +           cpuc->lbr_users == cpuc->lbr_pebs_users) {
>> +               cpuc->lbr_stack.nr = 0;
I checked the code, and it looks safe to clear cpuc->lbr_stack.nr here. For
PEBS events with the LBR group, the LBR stack is populated again for each
PEBS record, so this should not affect the LBR trace for PEBS events.

But I’m not fully sure if it's intentional for the
bpf_get_branch_snapshot() helper. Clearing lbr_stack.nr to 0 prevents the
BPF helper from reading LBR data from PEBS although the LBR data could be
stale since it comes from the past PEBS record instead of the runtime
hardware LBR state. That seems reasonable and correct, but the side effect
is that the BPF helper can't read the LBR stack when all LBR events are
PEBS events. Not sure if it's intentional and expected. 

I’d like to run some tests for this change tomorrow to confirm the
behavior. Thanks.


>>                 return;
>> +       }
>>
>>         x86_pmu.lbr_read(cpuc);
>>
