Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B8227702;
	Wed, 26 Feb 2025 05:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740547247; cv=none; b=KpKh5xt4OCaewNhBDUKa0za6Tu93LBC9e+909008zk3wyXrUSzz6KkM/J3y6AYoEV115a061rzd5pxbwa343ONsdJZFXzi7a66Eka1MDZIhNi0PQ1w/t6YEXKWSZ43HOmaTHiAYYYIKUVVlrFTKFLecyhrgO3x0EUVf6Wbmnu24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740547247; c=relaxed/simple;
	bh=wRuISJ0CvrThQma8rAEWKTUG37ZmBJUoQbY7pexnZoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DzG49zaf6rCFKFSme6a6omXij6q/wsiPnb9xFRRIoVPvxPF/n2VF+dlEqeqeKafEVC+drb4i68ignExeHsCeQpyqzztOd/rvHqbRO+XDFdbartFKgIqAcaXR4V2h90ScBhIoguk9V2nLmkorqZLvYPEu23g18KnLUCBPK9Kuirw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cqo+E+ZB; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cqo+E+ZB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740547245; x=1772083245;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wRuISJ0CvrThQma8rAEWKTUG37ZmBJUoQbY7pexnZoo=;
  b=cqo+E+ZB0CmlTYFRnVAeJyZH8MA13gkTaCPDS+VnoCIWFxuN2ke2n8k2
   H3PsJzN6Ubv0o6nmAa18mkp2TgxgzoKCGSUcz00rySSDbycNOPY9XnTn6
   qPBveeaOhk6yj2pSfE4TY7WeCXzNwV5N5qU16bz7hDLDVdq5VHwia7lkf
   6ZlXxVBXBPx6ChJvfebmH5DkJkxBe5k6DDTxm2B31hHFhB0O6zns9dZLK
   K1AySv4jfWofqgsm9e7p2OvlA/ezYpmz5oFQ32USmj4zmxjX0ZtmVbDq+
   XodPRvfX5gFJqwSwb7OKFHOBtXR8WjByNPFONXMFwyh1eO7sN2f1OzyeY
   A==;
X-CSE-ConnectionGUID: erbSfsoBSjK6OJoaShcvHA==
X-CSE-MsgGUID: Sr0WruwcSsGXnCAtcwiThg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52800149"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52800149"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:20:44 -0800
X-CSE-ConnectionGUID: 4TH+Zm97QvWdUwswQkWgUg==
X-CSE-MsgGUID: ZGx5sWYKQkuCuDNwVVAK/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="121540928"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:20:40 -0800
Message-ID: <c1450cf4-f367-4675-9f5e-90416a996af1@linux.intel.com>
Date: Wed, 26 Feb 2025 13:20:37 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 10/24] perf/x86/intel: Process arch-PEBS records or
 record fragments
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-11-dapeng1.mi@linux.intel.com>
 <20250225103927.GJ11590@noisy.programming.kicks-ass.net>
 <20250225110012.GK31462@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250225110012.GK31462@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/25/2025 7:00 PM, Peter Zijlstra wrote:
> On Tue, Feb 25, 2025 at 11:39:27AM +0100, Peter Zijlstra wrote:
>> On Tue, Feb 18, 2025 at 03:28:04PM +0000, Dapeng Mi wrote:
>>> A significant difference with adaptive PEBS is that arch-PEBS record
>>> supports fragments which means an arch-PEBS record could be split into
>>> several independent fragments which have its own arch-PEBS header in
>>> each fragment.
>>>
>>> This patch defines architectural PEBS record layout structures and add
>>> helpers to process arch-PEBS records or fragments. Only legacy PEBS
>>> groups like basic, GPR, XMM and LBR groups are supported in this patch,
>>> the new added YMM/ZMM/OPMASK vector registers capturing would be
>>> supported in subsequent patches.
>>>
>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>> ---
>>>  arch/x86/events/intel/core.c      |   9 ++
>>>  arch/x86/events/intel/ds.c        | 219 ++++++++++++++++++++++++++++++
>>>  arch/x86/include/asm/msr-index.h  |   6 +
>>>  arch/x86/include/asm/perf_event.h | 100 ++++++++++++++
>>>  4 files changed, 334 insertions(+)
>>>
>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>> index 37540eb80029..184f69afde08 100644
>>> --- a/arch/x86/events/intel/core.c
>>> +++ b/arch/x86/events/intel/core.c
>>> @@ -3124,6 +3124,15 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>>>  			wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
>>>  	}
>>>  
>>> +	/*
>>> +	 * Arch PEBS sets bit 54 in the global status register
>>> +	 */
>>> +	if (__test_and_clear_bit(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT,
>>> +				 (unsigned long *)&status)) {
>> Will arch_pebs hardware ever toggle bit 62?
> This had me looking at the bit 62 handling, and I noticed the thing from
> commit 8077eca079a2 ("perf/x86/pebs: Add workaround for broken OVFL
> status on HSW+").
>
> Did that ever get fixed in later chips; notably I'm assuming ARCH PEBS
> does not suffer this?

I'm not sure if arch-PEBS would still suffer this race condition issue, but
the status cleaning for PEBS counters had been move to out of the 62 bit
handling scope by the commit daa864b8f8e3 ("perf/x86/pebs: Fix handling of
PEBS buffer overflows"). So even arch-PEBS still have this race condition
issue, it still can be covered.


>
> Also, should that workaround have been extended to also include
> GLOBAL_STATUS_PERF_METRICS_OVF in that mask, or was that defect fixed
> for every chip capable of metrics stuff?

hmm,  per my understanding, GLOBAL_STATUS_PERF_METRICS_OVF handling should
only be skipped when fixed counter 3 or perf metrics are included in PEBS
counter group. In this case, the slots and topdown metrics have been
updated by PEBS handler. It should not be processed again.

@Kan Liang, is it correct?


>
> In any case, I think we want a patch clarifying the situation with a
> comment.
>
>
>>> +		handled++;
>>> +		x86_pmu.drain_pebs(regs, &data);
>> 		static_call(x86_pmu_drain_pebs)(regs, &data);
>>
>>> +	}
