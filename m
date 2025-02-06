Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144BD156C5E;
	Thu,  6 Feb 2025 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738871604; cv=none; b=sEl4nkSfZsQxBw6krRxOXzAXOGMXiDNcSM3n3I5sfF620XXe1Nokn8QA7R1AdItJ/rLzfi1ZDWUN/7AI/uquk6Sj5fyN3a941cnmhnuAVoQwncMKA/CROw6XNHJ0a1MGFNGcUSmUpFDmMRBGBAY6JmBl6D62/N8KsGdVGRnMiNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738871604; c=relaxed/simple;
	bh=diAQwsnLHp7+loCA2RcUwjeKzdocP0elwX8QEeabCGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aq3oQJO1sDnh6m5Nbi4aaUlJeaRblB2qKyVEJ2IpAQQ+ubvpsqUbocDzUvIEd/a8BnG5atEHo1pNaPtUwYsfXNamF4PF1JxL/whRuBvI7DO0ZUDs+W7GpjmM0bUdM7jjKGCiRhKUCmY9JtBZiH28EEcW/nmZEZA40SsKYwHz2eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CoNLBikJ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CoNLBikJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738871603; x=1770407603;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=diAQwsnLHp7+loCA2RcUwjeKzdocP0elwX8QEeabCGI=;
  b=CoNLBikJL0RNRPo/2moRLaY0oJ5tZ+c4WBF8T9abeHLSqEInoOK1u915
   KD2i3M34Kbqt+er/jTtYTM+eEpGsxZi2aZAHrNcHaU70oPTZgRrVi+iTm
   uFTyznL84109T5xzC6OAIKjxlhOiQMAvURH2PyN9mwer2z1F8AFRA4MUc
   /oghR+SXLdyxT/zrDvFKKRy2st4uMsvJ30sYnh6M2G6UrD6dNuikLR3Kl
   dwtXL0Rt96lMBvQbVrygIm9Zk5seSTIF6Meqy2w8ejsp2Y82sO1yPw0ED
   7u3OYlZyRQ+UK1YHtvIk4w4OJBXNZMdlN+0u+mABsUqYvcC+uwK7L6Jh4
   g==;
X-CSE-ConnectionGUID: VjTddMpsTzm9GBku2Glo5g==
X-CSE-MsgGUID: TVeUCbBLRk6FL0CtPvUVyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="61977372"
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="61977372"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 11:53:22 -0800
X-CSE-ConnectionGUID: Al2rI4fSTsW7LyL5ZBCuoQ==
X-CSE-MsgGUID: Tj0zKYmERGaymi13fnYepg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="116314294"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 11:53:22 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id AEA7920B5713;
	Thu,  6 Feb 2025 11:53:19 -0800 (PST)
Message-ID: <608077bc-4139-4a97-8dc4-7997177d95c4@linux.intel.com>
Date: Thu, 6 Feb 2025 14:53:17 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/24] perf vendor events: Update/add Graniterapids
 events/metrics
To: Ian Rogers <irogers@google.com>
Cc: Thomas Falcon <thomas.falcon@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>,
 Samantha Alt <samantha.alt@intel.com>,
 Caleb Biggers <caleb.biggers@intel.com>,
 Edward Baker <edward.baker@intel.com>, Michael Petlan <mpetlan@redhat.com>
References: <20250205173140.238294-1-irogers@google.com>
 <20250205173140.238294-12-irogers@google.com>
 <7692d2d6-16d5-4f50-8c3a-37f1db356426@linux.intel.com>
 <CAP-5=fU+9MgMbQKpFix+Jw8k+-_yfAs-F+FYE4CmTWxevPmd-A@mail.gmail.com>
 <9fa56c75-2ee6-4901-9e04-0ec23412fd62@linux.intel.com>
 <CAP-5=fWpbXSwZq5biRZ1fjcSJY2DO4g=cv-0K8jZ1Gzv3bOfhA@mail.gmail.com>
 <58e08371-8d43-4f84-baaf-64b0af95c7cb@linux.intel.com>
 <CAP-5=fX+u_Un-WYKA35sc366kniuXFVfRDT+dzWd-axTG5PmpA@mail.gmail.com>
 <51732c12-b5d7-4b81-8ea5-79e87b87795d@linux.intel.com>
 <CAP-5=fWQj01O3WmGLoAf6O_uEeMHpOUqVWvHi3nW_kGj4VtZWg@mail.gmail.com>
 <145ce38d-67c5-47e5-9625-0ae9e9831fd9@linux.intel.com>
 <f0eb58c2-afba-4810-96d5-61f1c942ed57@linux.intel.com>
 <CAP-5=fW3eY70Vh_GuTVB=M2MFcpe-WqRy76cK++UMYT5OKMtLg@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fW3eY70Vh_GuTVB=M2MFcpe-WqRy76cK++UMYT5OKMtLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025-02-06 2:05 p.m., Ian Rogers wrote:
> On Thu, Feb 6, 2025 at 10:59 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>> On 2025-02-06 1:53 p.m., Liang, Kan wrote:
>>>>> However, when I dump the debug information,
>>>>> ./perf stat -M tma_frontend_bound -vvv
>>>>>
>>>>> I got below debug information. I have no idea where the slot is from.
>>>>> It seems the perf code mess up the p-core metrics with the e-core
>>>>> metrics. But why only slot?
>>>>> It seems a bug of perf tool.
>>>>>
>>>>> found event cpu_atom@CPU_CLK_UNHALTED.CORE@
>>>>> found event cpu_atom@TOPDOWN_FE_BOUND.ALL@
>>>>> found event slots
>>>>> Parsing metric events
>>>>>
>>>>> '{cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/TOPDOWN_FE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.ALL!3/,slots/metric-id=slots/}:W'
>>> It because the perf adds "slot" as a tool event for the e-core Topdown
>>> metrics.
>>> There is no "slot" event for e-core.
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/
>>> tools/perf/util/metricgroup.c#n1481
>>>
>>> I will check why "slot" event is added as a tool event for e-core?
>>> That doesn't make sense.
>>
>>
>> BTW: I checked the list of the tool events. Except the slots, others are
>> all SW (or non-HW) events which should always be available.
>> Slots is a HW event and only be available for p-core.
>> It doesn't look like a good fit here.
>>
>> static const char *const tool_pmu__event_names[TOOL_PMU__EVENT_MAX] = {
>>         NULL,
>>         "duration_time",
>>         "user_time",
>>         "system_time",
>>         "has_pmem",
>>         "num_cores",
>>         "num_cpus",
>>         "num_cpus_online",
>>         "num_dies",
>>         "num_packages",
>>         "slots",
>>         "smt_on",
>>         "system_tsc_freq",
>> };
> 
> IIRC it was added on metric changes I wasn't a reviewer on:
> https://lore.kernel.org/r/1673940573-90503-2-git-send-email-renyu.zj@linux.alibaba.com
> and then carried forward by me. The event should only be enabled on aarch64:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/tool_pmu.c?h=perf-tools-next#n38
> Where is the slots event added to the metric expr (expression) string?
> The metric should have events pulled out, parsed and
> parse_events__sort_events_and_fix_groups deal with related issues to
> this. I thought it was a requirement that the slots be in the metric -
> or else why is the converter script injecting them? :-)
> 


No, it's the perf tool which inject the "slots" event in parse_ids().

In parse_groups(), the tool_events[] is constructed here.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/metricgroup.c#n1557

In the find_tool_events(), the tool_pmu__event_to_str() is used to
compare the tool_events. It only check the event name, no PMU or arch.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/metricgroup.c#n1389

So the tool_events[TOOL_PMU__EVENT_SLOTS] is set to true, because the
p-core Topdown metrics has "slots" event.

The tool_events is shared. So when parsing the e-core metrics, the
"slots" is automatically added.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/metricgroup.c#n1476

I think we may need a similar fix in the tool_pmu__event_to_str() to
skip the "slots" for x86.

Thanks,
Kan
