Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2731FC2FD;
	Mon, 22 Jul 2024 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721666740; cv=none; b=TWp+i89p1PrSf+D8SolxrGGNDENn6X2WLSHktk5Jm8uVDMxR2sl2DTrtDXN1KC/QH4HtykzOuG4nRmG5ld/NJb7s9Jruc/d50a/gOFkhLXX1hLULM75LjQnLf+50xWDQzzQf3EO65eDRoU/hPjnmsHbVRRenH3sDgboWNbXUIWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721666740; c=relaxed/simple;
	bh=ETYLw21kbSQSjFu61FymF6xrk6sFkW23q48JZFsEk40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNbnzZnynHK+SJlLUpprXmN8ZFGXvbLmiE9GvzLKgXDqJgRl9Vro7b0e4nSi365RGfu6UZct1UYxYNuagWXhecar44ulVlqQu5wQS9gQ/GITWN3QFyAg3FLwQ74PfcSI5qcMLge8NJT01WTXEmmArP6OlS2UB1+p6k1V7gHmHX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f5SGAZIL; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f5SGAZIL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721666738; x=1753202738;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ETYLw21kbSQSjFu61FymF6xrk6sFkW23q48JZFsEk40=;
  b=f5SGAZILbychz9EofFnuunSmJeUwOV8X8msvSAXSk6+dwDYexxhXKWxO
   cWm4isIm3L2+sKVVakDihfBzj9YAkAPibLyTFiWamjMbibhq/2NQnHvWM
   qF9VYpDM8CkHed8KcZFSw/44YQsDrK2e8TiDoBND2zNB1OouUI9dFNDmg
   81cH3G0vvEuLuwcIYO1ikdgDpPTMWD+IBzGXkumnjYsmQh0Cqd16/oyKU
   TFhnYWKFpCQPNB8zVxedjlMUIPXJEV7RPLX1tuQR3++YtK6TAlkmlZc4K
   KpCD4vVh521ew8W1z4A3UAZlqBoMP51nUdgo0C6bcLfc0wnXHM2VKobLT
   A==;
X-CSE-ConnectionGUID: tu0ROH8WRcqSUBACDsV6fg==
X-CSE-MsgGUID: hEEwcL5lTja5o5q/VvgcQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="29833277"
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="29833277"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 09:45:37 -0700
X-CSE-ConnectionGUID: q7kPepZ/SqWRJ/HnOznk3g==
X-CSE-MsgGUID: RiVLx5vjTLqzhuYvchLAog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="56790003"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 09:45:37 -0700
Received: from [10.212.80.152] (kliang2-mobl1.ccr.corp.intel.com [10.212.80.152])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id F410520CFEE1;
	Mon, 22 Jul 2024 09:45:33 -0700 (PDT)
Message-ID: <aef9d7fd-ac33-45a3-91ed-2b4d3f0f70b5@linux.intel.com>
Date: Mon, 22 Jul 2024 12:45:32 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] perf pmu: Add support for event.cpus files in
 sysfs
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
 James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Dominique Martinet <asmadeus@codewreck.org>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, ananth.narayan@amd.com,
 gautham.shenoy@amd.com, kprateek.nayak@amd.com, sandipan.das@amd.com
References: <20240718003025.1486232-1-irogers@google.com>
 <20240718003025.1486232-4-irogers@google.com>
 <92ceb8b5-240a-4715-98db-c73e8e9d3e50@linux.intel.com>
 <CAP-5=fUfoMZ0HjCNoJe6hgEMi5ciY+LqFjBbLzfiZgO6dioshA@mail.gmail.com>
 <64030eab-6e95-494a-ab72-bc33792ef723@linux.intel.com>
 <CAP-5=fVMV4ZmGk4-XguqV=LAuif-MgAL+BK=mMAE1tC3f3tbhQ@mail.gmail.com>
 <e8872317-8e18-48aa-9f23-b98af9345bed@linux.intel.com>
 <CAP-5=fUjEYwdOdmfa5N7b8OOLWDitJKBdeOr8-+UOYWA5+ehkA@mail.gmail.com>
 <775d8f1d-437d-47a3-b4b2-da476e914cf5@linux.intel.com>
 <CAP-5=fUH+n+f_q1Tc-a3oV3vDV60VGOLANRFWUemDen197rYog@mail.gmail.com>
 <862f6bb1-ab67-4286-8c27-465b2f29de64@linux.intel.com>
 <CAP-5=fVdiFYVP8RsE+JuhOCoGSyybv0ZUn=Sixv1ZcEe8G7=2A@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fVdiFYVP8RsE+JuhOCoGSyybv0ZUn=Sixv1ZcEe8G7=2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-07-22 11:43 a.m., Ian Rogers wrote:
> On Mon, Jul 22, 2024 at 6:57 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-07-19 6:02 p.m., Ian Rogers wrote:
>>> On Fri, Jul 19, 2024 at 9:35 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>> On 2024-07-19 10:59 a.m., Ian Rogers wrote:
>>>>> Thanks Kan. I'm not wondering about a case of 2 CPUs, say on CPU0 and
>>>>> solely its perf event context, I want to know its core power and
>>>>> package power as a group so I never record one without the other. That
>>>>> grouping wouldn't be possible with 2 PMUs.
>>>>
>>>> For power, to be honest, I don't think it improves anything. It gives
>>>> users a false image that perf can group these counters.
>>>> But the truth is that perf cannot. The power counters are all
>>>> free-running counters. It's impossible to co-schedule them (which
>>>> requires a global mechanism to disable/enable all counters, e.g.,
>>>> GLOBAL_CTRL for core PMU). The kernel still has to read the counters one
>>>> by one while the counters keep running. There are no differences with or
>>>> without a group for the power events.
>>>
>>> Ok, so power should copy cstate with _core, _pkg, etc. I agree the
>>> difference is small and I like the idea of being consistent. Do we
>>> want to add "event.cpus" support to the tool anyway for potential
>>> future uses?
>>
>> The only thing I can imagine is that it may be used to disclose the
>> event constraint information, Or even more to update/override the event
>> constraint information (which requires kernel update.). But what I'm
>> worried about is that it may be abused. It's very easy to confuse an
>> event and a counter in a PMU.
> 
> So you mean if you have a dual socket machine and an uncore PMU with a
> cpumask of "0,48" you worry that someone setting an event on CPU 47
> may think they are getting a CPU on the second socket? Perhaps if the
> user can express an intent to the tool, say "perf stat
> -randomly-select-uncore-cpus ...", then this can be avoided. I'm not
> sure I'm worried about this as specifying the CPU for an event to use
> is already something of a more niche/advanced thing to be doing.
> 

The perf tool can specify any CPU the users want, as long as the kernel
can respond properly. I'm not worried about it. The "event.cpus" is
exposed by the kernel. The main concern is also from the kernel side.
Some drivers may use it to distinguish different scopes of counters. So
they can combine various types of counters into a single PMU, which may
break some rules they don't realize. An example is the above 'group' rule.

>>> This would at least avoid problems with newer kernels and
>>> older perf tools were we to find a good use for it.
>>>
>>>>> My understanding had been that for core PMUs a "perf stat -C" option
>>>>> would choose the particular CPU to count the event on, for an uncore
>>>>> PMU the -C option would override the cpumask's "default" value. We
>>>>> have code to validate this:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/evlist.c?h=perf-tools-next#n2522
>>>>> But it seems now that overriding an uncore PMU's default CPU is
>>>>> ignored.
>>>>
>>>> For the uncore driver, no matter what -C set, it writes the default CPU
>>>> back.
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/arch/x86/events/intel/uncore.c#n760
>>>>
>>>>> If you did:
>>>>> $ perf stat -C 1 -e data_read -a sleep 0.1
>>>>> Then the tool thinks data_read is on CPU1 and will set its thread
>>>>> affinity to CPU1 to avoid IPIs. It seems to fix this we need to just
>>>>> throw away the -C option.
>>>> The perf tool can still read the the counter from CPU1 and no IPIs
>>>> because of the PMU_EV_CAP_READ_ACTIVE_PKG().
>>>>
>>>> Not quite sure, but it seems only the open and close may be impacted and
>>>> silently changed to CPU0.
>>>
>>> There's also enable/disable. Andi did the work and there were some
>>> notable gains but likely more on core events. Ultimately it'd be nice
>>> to be opening, closing.. everything in parallel given the calls are
>>> slow and the work is embarrassingly parallel.
>>> It feels like the cpumasks for uncore could still do with some cleanup
>>> wrt -C I'm just unsure at the moment what this should be. Tbh, I'm
>>> tempted to rewrite evlist propagate maps as someone may look at it and
>>> think I believe in what it is doing. The parallel stuff we should grab
>>> Riccardo's past work.
>>
>> For core PMU, the parallel may not work, because the core PMU is usually
>> MSR based. Perf has to access the MSRs on the specific CPU. IPIs may be
>> triggered if the users try to operate them from the other CPUs.
> 
> Right, I think the idea would be to have as many threads as you have
> CPUs then give each thread affinity to a different CPU. The work done
> on the thread would match the CPU they have affinity with to avoid the
> IPIs. Because of the use of RCU in the kernel perf code it is possible
> to hit RCU synchronize where IPIs are sent after 200ms IIRC. If you
> get an RCU synchronize needing an IPI then "200ms x num CPUs" can mean
> seconds of delay in a serial implementation (500 CPUs would be 100
> seconds). With parallel code a worst case slow down shouldn't increase
> with the number of CPUs. On laptops, .. this doesn't matter much.
> 
>> But the parallel is good for the counters in the MMIO space. The
>> counters can be accessed from any CPU. There are more and more counters
>> which are moved to the MMIO space, e.g., new uncore PMUs, IOMMU PMU,
>> TMPI (for power), etc.
> 
> Sounds good but I'm wondering how we can get the tool in the right
> place for doing affinity games. For the MMIO case life's good and we
> don't care. How can the tool know one case from another? Should the
> tool always be just following the cpumask? What about on ARM where the
> cpumasks are broken?

The cpumask cannot tell such information. For example, the counters of
the uncore PMUs can be located in three different places, MSRs, the PCI
config space, and the MMIO space. But the scope of the uncore counters
is the same. So the cpumask is the same for various uncore PMUs.
To get the information, the kernel has to be updated, e.g., add a
caps/counter_type in sysfs.

Thanks,
Kan
> 
> Thanks,
> Ian
> 
>> Thanks,
>> Kan
>>>
>>> Thanks,
>>> Ian
>>>
>>>
>>>> Thanks,
>>>> Kan
>>>>>
>>>>>>> 2) do the /sys/devices/<pmu>/events/event.(unit|scale|per-pkg|snapshot)
>>>>>>> files parse correctly and have a corresponding event.
>>>>>>> 3) keep adding opening events on the PMU to a group to make sure that
>>>>>>> when counters are exhausted the perf_event_open fails (I've seen this
>>>>>>> bug on AMD)
>>>>>>> 4) are the values in the type file unique
>>>>>>>
>>>>>>
>>>>>> The rest sounds good to me.
>>>>>
>>>>> Cool. Let me know if you can think of more.
>>>>>
>>>>> Thanks,
>>>>> Ian
>>>>>
>>>>>> Thanks,
>>>>>> Kan
>>>>>
>>>
> 
