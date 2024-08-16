Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A58378C7D;
	Fri, 16 Aug 2024 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723836436; cv=none; b=qiZBqEwMJSmTQKKjCHE3RimGHqaIuEHYL0MF3aaX9ABO/kD7E7UVobIpT3Y3O7wMP/AGj5f+w2ShvXDrlVqGv5Nwe7iIL+oQ0QEpF+ntwHfpB/Qsi7LyKHa6oa2V0Fq15f9pjH5+qs9IiqYzk5rGGTqkHS8MX9bYTL7gx6qfYNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723836436; c=relaxed/simple;
	bh=oBM7Ofa7OHDkP8yklvZowNZEXSSnN7/4X344QkoiaWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=epUxaNXtAE5tUZAik/1nsXbXlcJBncWp7b0jqphxCyjlsErcTh7ALuhH6STdTEswg9pzGOchtboDiRIgO9yc6BS5/Dbq2jhB0Z8kMqlfH4E9BOC1T996CDKKc/ljQOmfTObJRzFAVN1j817zF9bBHA1MbS7wHtT4Qmn32y93UAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V2JQXclu; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2JQXclu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723836434; x=1755372434;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oBM7Ofa7OHDkP8yklvZowNZEXSSnN7/4X344QkoiaWA=;
  b=V2JQXclurKBBdCU2eBS+NKMECPHDLIPzFKcvFnPCK6WCBrdclyNg5WmP
   RRhZwBSWRRXVKo8cztIXonF/7C2qif34cn1GJVUqA7Y9Akw9jUSjyC3B9
   ppJtFtDkvtLz20Itid9Z9FRrmSxANhIpG9q6/kLj9AlkRGfEnJD9/utz2
   ttFMNP9cMJD9Wm8prfy8aUrHkRx6EArCFsn4rrgGeRIM4NFMpUS3Qeilc
   cZT0rDeM+ElAnc5vLjtDuZs/9A8J2wyVetoNsPVsKjCHfp8xjzRiLvVxA
   olFCRLqTT8YJ8zyzm9soR2hd5EvfrqxlQiBFwi+k/YoDjDergJd0nkN7I
   Q==;
X-CSE-ConnectionGUID: 5CH1hI1CTBS8yTi9FRvwyw==
X-CSE-MsgGUID: ttwN4inKTpCCEjy6OlRu8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22284390"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="22284390"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 12:27:13 -0700
X-CSE-ConnectionGUID: 1cG+eiw+QpGWwWA7UCC5GA==
X-CSE-MsgGUID: 0YHeI16JQS2E05y6KtEPIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="90495462"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 12:27:13 -0700
Received: from [10.212.50.43] (kliang2-mobl1.ccr.corp.intel.com [10.212.50.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 4434120CFED0;
	Fri, 16 Aug 2024 12:27:11 -0700 (PDT)
Message-ID: <705dc2fe-7ab3-458a-9b5a-7ea0b30756b8@linux.intel.com>
Date: Fri, 16 Aug 2024 15:27:10 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel: Restrict period on Haswell
To: Thomas Gleixner <tglx@linutronix.de>, Li Huafei <lihuafei1@huawei.com>,
 peterz@infradead.org, mingo@redhat.com
Cc: acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Vince Weaver <vincent.weaver@maine.edu>
References: <87sev7nom4.ffs@tglx>
 <a42a3e35-2166-4539-930b-21ea0921e8d8@linux.intel.com> <87frr7nd28.ffs@tglx>
 <70657c5e-f771-456b-a5ac-3df590249288@linux.intel.com> <875xs2oh69.ffs@tglx>
 <166fdbdf-b24d-4267-b42d-f11348b87b1b@linux.intel.com> <87wmkhlk1l.ffs@tglx>
 <059d6217-10a5-4d2a-b639-90806c04a13b@linux.intel.com> <87plq9l5d2.ffs@tglx>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <87plq9l5d2.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Thomas,

On 2024-08-15 7:43 p.m., Thomas Gleixner wrote:
> On Thu, Aug 15 2024 at 16:15, Kan Liang wrote:
>> On 2024-08-15 2:26 p.m., Thomas Gleixner wrote:
>>>> Implication: When this erratum occurs, the fixed-function performance
>>>> counter IA32_FIXED_CTR0 may over count by up to 32.
>>>
>>> Sure. That's only explaining half of the problem.
>>>
>>> As I demonstrated in the non-contended case even with a count of 2 (I
>>> tried 1 too) the status bit is never set on the second check.
>>>
>>
>> Do you mean the below example? The status bit (32) of the fixed counter
>> 0 is always set.
> 
> When HT is off or the threads are not running the handler concurrently
> then there is zero looping. Once they start do fiddle concurrently the
> looping starts and potentially never ends.
> 
>> 65.147782: x86_perf_event_set_period: idx:    32 period:         1 left:  2
>> 65.147783: intel_pmu_handle_irq:      loops: 001 status: 100000000
>>
>> 65.147784: x86_perf_event_set_period: idx:    32 period:         1 left:  2
>> 65.147784: intel_pmu_handle_irq:      loops: 002 status: 100000000
> 
> So in the non-concurrent (which includes !HT) case the status check
> after handling the event is always 0. This never gets into a loop, not
> even once.
> 
>>>> It should explains that the issue is gone with the magic number 32 or
>>>> disabling the Hyper-Threading.
>>>
>>> It explains only half of it. If you use 32, then the counter is set to
>>> -32 so the overcount of 32 will still bring it to 0, which should set
>>> the status bit, no?
>>
>> I think it's up to 32, not always 32.
>> I don't have more details regarding the issue. The architect of HSW has
>> left. I'm asking around internally to find the original bug report of
>> the erratum. Hope there are more details in the report.
> 
> See below.
> 
>>>> I also found a related discussion about 9 years ago.
>>>> https://lore.kernel.org/lkml/alpine.DEB.2.11.1505181343090.32481@vincent-weaver-1.umelst.maine.edu/
>>>> Vince tried the workaround but it seems not work.
>>>
>>> Let me play with that. :)
>>
>> Appreciate it.
> 
> I got it actually working. The inital sequence which "worked" is:
> 
>     1) Clear bit 32  in IA32_PERF_GLOBAL_CTRL
>     2) Clear bit 0/1 in IA32_PERF_FIXED_CTR_CTRL
>     3) Zero the IA32_FIXED_CTR0 MSR
>     4) Set IA32_FIXED_CTR0 to (-left) & mask;
>     5) Set bit 0/1 in IA32_PERF_FIXED_CTR_CTRL
>     6) Set bit 32  in IA32_PERF_GLOBAL_CTRL
> 
> If I omit #3 it does not work. If I flip #5 and #6 it does not work.
> 
> So the initial "working" variant I had was hacking this sequence into
> x86_perf_event_set_period() (omitting the fixed counter 0 conditionals
> for readability):
> 
> 	rdmsrl(MSR_CORE_PERF_GLOBAL_CTRL, cglbl);
> 	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, cglbl & ~(1ULL << 32));
> 
> 	rdmsrl(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, cfixd);
> 	wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, cfixd & ~3ULL);
> 
> 	wrmsrl(hwc->event_base, 0);
> 	wrmsrl(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);
> 
> 	wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, cfixd);
> 	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, cglbl);
> 
> Now I thought, that needs to be in intel/core.c and implemented a proper
> quirk. And of course being smart I decided it's a brilliant idea to use
> the cached values instead of the rdmsrl()s.
> 
> 	cglbl = hybrid(cpuc->pmu, intel_ctrl) & ~cpuc->intel_ctrl_guest_mask;
> 	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, cglbl & ~(1ULL << 32));
> 
>         cfixd = cpuc->fixed_ctrl_val;
> 	wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, cfixd & ~3ULL);
> 
> 	wrmsrl(hwc->event_base, 0);
> 	wrmsrl(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);
> 
> 	wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, cfixd);
> 	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, cglbl);
> 
> Surprise, surprise, that does not work. So I went back and wanted to
> know which rdmslr() is curing it:
> 
> 	rdmsrl(MSR_CORE_PERF_GLOBAL_CTRL, cglbl);
> 	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, cglbl & ~(1ULL << 32));
> 
>         cfixd = cpuc->fixed_ctrl_val;
> 	wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, cfixd & ~3ULL);
> 
> 	wrmsrl(hwc->event_base, 0);
> 	wrmsrl(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);
> 
> 	wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, cfixd);
> 	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, cglbl);
> 
> This worked. Using the rdmsrl() only for MSR_ARCH_PERFMON_FIXED_CTR_CTRL
> did not.
> 
> Now I got bold and boiled it down to:
> 
> 	rdmsrl(MSR_CORE_PERF_GLOBAL_CTRL, cglbl);
> 
> 	wrmsrl(hwc->event_base, 0);
> 	wrmsrl(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);
> 
> and the whole thing still worked. *BLINK*
> 
> Exactly zero loop entries in the trace when running 100 instances of
> that cve test case, which otherwise spams the trace with entries and
> ends up in the loop > 100 path within a split second.
> 
> Removing the zeroing of the counter makes it come back, but reducing the
> whole nonsense to:
> 
> 	wrmsrl(hwc->event_base, 0);
> 	wrmsrl(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);
> 

Thanks for all the testing. So the trick is to clear the counter before
writing to it. That sounds like a usual way to trigger some ucode magic.


> makes the loop problem go away, but it "works" so well that the stupid
> frequency adjustment algorithm keeps the left == 1, i.e count == 2 case
> stay long enough around to trigger 'hung task messages' ....
> 
> Now I looked more at the dmesg output of all the experiments. In all
> "working" cases except one running these 100 instances of cve... results
> in a varying cascade of
> 
>    perf: interrupt took too long (2503 > 2500), lowering ...
> 
> messages.
> 
> The one case where this does not happen is when the limit is
> unconditionally set to 32. But when I apply this limit only for the
> fixed counter 0 it comes back.


Yes, that sounds there is something wrong with < 32 as well.

> 
> Now I looked at when these 'took too long' problems surface aside of the
> obvious case of extensive looping. They are unrelated to the hyper
> threading issue as I can reproduce with smt=off too.
> 
> They always happen when a counter was armed with a count < 32 and two
> events expired in the same NMI. The test case uses fixed counter 0 and
> general counter 0 for the other event.
> 
> So that erratum is a good hint, but that hardware does have more issues
> than it tells.
> 
> So I think we should just apply that limit patch with a proper change
> log and also make it:
> 
> hsw_limit(...)
> {
> 	*left = max(*left, erratum_hsw11(event) ? 128 : 32;);
> }
>

The HSW11 is also BDM11. It sounds like we need the trick from both bdw
and nhm.

How about this?

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e8bd45556c30..42f557a128b9 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4664,6 +4664,12 @@ static void nhm_limit_period(struct perf_event
*event, s64 *left)
 	*left = max(*left, 32LL);
 }

+static void hsw_limit_period(struct perf_event *event, s64 *left)
+{
+	nhm_limit_period(event, left);
+	bdw_limit_period(event, left);
+}
 static void glc_limit_period(struct perf_event *event, s64 *left)
 {
 	if (event->attr.precise_ip == 3)

Do you plan to post the "limit" patch for HSW?
Or should I send the patch?

> or such.
> 
> That limit won't cure the overcount issue from that HSM154 erratum, but
> *SHRUG*.
> 

The code is there without the fixed for ~10 years. I didn't find
complains. I guess it should be fine to leave it as is.

Thanks,
Kan
