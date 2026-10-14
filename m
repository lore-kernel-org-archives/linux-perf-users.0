Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CFC4B26F8;
	Wed, 14 Oct 2026 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968500; cv=none; b=S9tbZT4fuKqMJ1UWgMbVgsGkcgxDDt20ESGzhBylLaYsj3ccEFraQgaj+4h60IYq6HAYJdDxkWREca+xlMeJ9ixbz7XrJOZD/QHs9bfHHWYeznTtC9O+N5dRiNYYIavvJMA4nWgeyO3gQHy8JqP+6270sdRTBNVDAUUura8hXNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968500; c=relaxed/simple;
	bh=nrXWFJqDvnKa+L3lKJ12jqTvm6csARDqXZ85Q9WA68E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gStIug3HjUXcpB7NpuWyoR1/u7e7FWRkOfNKLOhUR+9Uh4MbUNw5XnE9akbtKD0hAcM85ypq+drEx3Veo3cTlweEnkqnMCC4GRkPigZ1WwWNfcxsGqCl0xPd/SGWeeKZVx80GYhybNTnCDfS4/caR7lNDPlFdOqDLwYQa3kMi9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MeFlV/pr; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MeFlV/pr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791968497; x=1823504497;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=nrXWFJqDvnKa+L3lKJ12jqTvm6csARDqXZ85Q9WA68E=;
  b=MeFlV/pr2EZJytj7gxlVpuLgqCqoNCirnK8lyevSbUOCcWe85LeVq3+p
   RHu0z455vlDM3H3HwhBwHDCHfW8wc5WxxEAsnUGTO7t9CMWHB7s859VlZ
   X1hFPjFwPkXSpiLQbAussixnBAnoVz8c964tiBH/VpovW01t+iVFKj6wv
   fKdzvTAWATCY6lkcsaELC3a7opjlRTfJgwoJriYKeU47Xts+6122YchXI
   1W1biQfy8sbmVrStbEzfhISS4q6p9yyDQWOAUBbdJHdaqaxU4OtN6zD33
   fXlBjyE9xp5pKYiA55ENIBOWe4rtf7ItTiVWjXntOHOXvjvSDbJ5qHT+E
   g==;
X-CSE-ConnectionGUID: ugK7h37+R5GXh1IMaoTspQ==
X-CSE-MsgGUID: 8ZE0/iJvRk6B4AOsVd03OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="609193"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="609193"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 02:01:35 -0700
X-CSE-ConnectionGUID: zqhIqvLzQcy6BxXW1mPqwA==
X-CSE-MsgGUID: l6hnnZDtR/yQ+9aP4Gym2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1307833"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 02:01:31 -0700
Message-ID: <eb6c7bda-0dcf-4fac-ad69-9f5b24abc21b@linux.intel.com>
Date: Wed, 14 Oct 2026 17:01:27 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd/lbr: Limit branch snapshots to valid entries
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
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
 <becc5593-69ef-4800-bc2b-0fb217165910@linux.intel.com>
Content-Language: en-US
In-Reply-To: <becc5593-69ef-4800-bc2b-0fb217165910@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/13/2026 8:53 PM, Mi, Dapeng wrote:
> On 10/13/2026 3:46 PM, Peter Zijlstra wrote:
>> On Tue, Oct 13, 2026 at 12:14:58PM +0530, Sandipan Das wrote:
>>> On 12-10-2026 21:00, Peter Zijlstra wrote:
>>>> On Wed, Oct 07, 2026 at 11:40:02PM +0530, Sandipan Das wrote:
>>>>> The branch snapshot callback used by bpf_get_branch_snapshot() copies
>>>>> up to x86_pmu.lbr_nr entries from cpuc->lbr_entries[], even when the
>>>>> last LBR read kept fewer branches. The entries past lbr_stack.nr are
>>>>> invalid, but they end up reaching BPF programs.
>>>>>
>>>>> Limit copying to lbr_stack.nr entries and also reset lbr_stack.nr when
>>>>> amd_pmu_lbr_read() skips reading the registers, so that a stale count
>>>>> is never reused.
>>>>>
>>>>> Fixes: a4d18112e531 ("perf/x86/amd: Support capturing LBR from software events")
>>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>>>> Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
>>>>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>>>>> ---
>>>>>  arch/x86/events/amd/core.c | 2 +-
>>>>>  arch/x86/events/amd/lbr.c  | 4 +++-
>>>>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
>>>>> index 49b6b8fce566..bf631f60757c 100644
>>>>> --- a/arch/x86/events/amd/core.c
>>>>> +++ b/arch/x86/events/amd/core.c
>>>>> @@ -944,7 +944,7 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
>>>>>  	cpuc = this_cpu_ptr(&cpu_hw_events);
>>>>>  
>>>>>  	amd_pmu_lbr_read();
>>>>> -	cnt = min(cnt, x86_pmu.lbr_nr);
>>>>> +	cnt = min(cnt, cpuc->lbr_stack.nr);
>>>>>  	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
>>>>>  
>>>>>  	amd_pmu_v2_enable_all(0);
>>>>> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
>>>>> index 1e1b2f08cb51..a00d3850c4a8 100644
>>>>> --- a/arch/x86/events/amd/lbr.c
>>>>> +++ b/arch/x86/events/amd/lbr.c
>>>>> @@ -165,8 +165,10 @@ void amd_pmu_lbr_read(void)
>>>>>  	struct branch_entry entry;
>>>>>  	int out = 0, idx, i;
>>>>>  
>>>>> -	if (!cpuc->lbr_users)
>>>>> +	if (!cpuc->lbr_users) {
>>>>> +		cpuc->lbr_stack.nr = 0;
>>>>>  		return;
>>>>> +	}
>>>>>  
>>>>>  	for (i = 0; i < x86_pmu.lbr_nr; i++) {
>>>>>  		entry.from.full	= amd_pmu_lbr_get_from(i);
>>>> You now seem to deviate from what the Intel code does. Please clarify.
>>> Yes, it is a deviation. I thought of proposing the following but didn't
>>> proceed because I was not sure about the if condition in the second hunk
>>> which considers things other than cpuc->lbr_users for an early return.
>> Dapeng, can you look into this? I would really like to keep behaviour
>> consistent where possible.
> Sure.
>
>
>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>> index 0a34d674df59..5dfb9e9156e8 100644
>>> --- a/arch/x86/events/intel/core.c
>>> +++ b/arch/x86/events/intel/core.c
>>> @@ -2822,7 +2822,7 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
>>>         struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>>
>>>         intel_pmu_lbr_read();
>>> -       cnt = min_t(unsigned int, cnt, x86_pmu.lbr_nr);
>>> +       cnt = min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
>>>
>>>         memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
>>>         intel_pmu_enable_all(0);
>>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>>> index 0b446d8912e4..6b070490f461 100644
>>> --- a/arch/x86/events/intel/lbr.c
>>> +++ b/arch/x86/events/intel/lbr.c
>>> @@ -1026,8 +1026,10 @@ void intel_pmu_lbr_read(void)
>>>          * but this simple approach seems to work for now.
>>>          */
>>>         if (!cpuc->lbr_users || vlbr_exclude_host() ||
>>> -           cpuc->lbr_users == cpuc->lbr_pebs_users)
>>> +           cpuc->lbr_users == cpuc->lbr_pebs_users) {
>>> +               cpuc->lbr_stack.nr = 0;
> I checked the code, and it looks safe to clear cpuc->lbr_stack.nr here. For
> PEBS events with the LBR group, the LBR stack is populated again for each
> PEBS record, so this should not affect the LBR trace for PEBS events.

I test the changes on SPR for the 3 cases, pure LBR PEBS sampling, pure LBR
non-PEBS sampling and the PEBS/non-PEBS mixed LBR sampling. No issue is
found for the LBR stack sampling.

Sandipan, would you mind to post the fixes for Intel LBR with the AMD fixes
together? Thanks.


>
> But I’m not fully sure if it's intentional for the
> bpf_get_branch_snapshot() helper. Clearing lbr_stack.nr to 0 prevents the
> BPF helper from reading LBR data from PEBS although the LBR data could be
> stale since it comes from the past PEBS record instead of the runtime
> hardware LBR state. That seems reasonable and correct, but the side effect
> is that the BPF helper can't read the LBR stack when all LBR events are
> PEBS events. Not sure if it's intentional and expected. 
>
> I’d like to run some tests for this change tomorrow to confirm the
> behavior. Thanks.
>
>
>>>                 return;
>>> +       }
>>>
>>>         x86_pmu.lbr_read(cpuc);
>>>
