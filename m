Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE966144D37;
	Thu, 18 Jul 2024 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721324883; cv=none; b=P5lyWVSYKQISj4ms60H2YklbJxHgPpJPSMa6cxhVqRVFu57s2u5kXSsBiI3MJ8BpkXcsPy3lYQUm6YGhbtTLwWodFEk2bCPJK3CDoLEG7B+AXDpheA1HTR8s+dN7Kh/nWBhD7lxOjlWmeGEW/GjbuXeioiZsTbcRqAmmxmbM/FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721324883; c=relaxed/simple;
	bh=3/kqY1TSxTnbSmHQNPbYNycSBGkkf5or3v0kGKJPk/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y3t/DtM+L+MIFzzp7TIXBUtLCfhAys5nOtmwUIVfaPiVZZcJwsNj1SDeTpWPVQHaG/YGwG1J+UQ5dTm//TpD/DqG9QoUOg/TZoQGXY8BAZCUc0mdbbGxR5fykFMh9nXeloZ17ubFMsYUjA3nRZW3JDnmEyEZDkOLTEQDlsPsB60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7YLiS3W; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7YLiS3W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721324882; x=1752860882;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3/kqY1TSxTnbSmHQNPbYNycSBGkkf5or3v0kGKJPk/A=;
  b=k7YLiS3Wtef1Iz3/5xydq9gRCljMR4RGAgWjopZk5CY8Mve4QiP9CaX6
   a6o9GSEF+zqZi80Z2IDdk6yCBaP/qOWnQQQhE54AMYv5mL7SbcFP0/ogM
   2OZunFR60oUGSqvWo271zUfLHg0yxDl/mBGHebisq9S+bC3dGsKtMVdSJ
   lohTYC4p/1T6jHqCuHllp8tWBzayICfnZeEL+WrBjYelaPjhtssXibKlP
   f8Z/0Hzo7UswlK85Lk0FWz2VfbCggRld86Uyk1JCCfFJ8VXJfIeaVcsp9
   pcQe19UiP7UknqRdOzd89C/aepCmTnagBdQX1evQm91cSfGuHXkSbomun
   Q==;
X-CSE-ConnectionGUID: t182dYJ/RUukW739fStsaQ==
X-CSE-MsgGUID: TAKusAsAQ4uc+hN/0x6DaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="19049623"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="19049623"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 10:47:53 -0700
X-CSE-ConnectionGUID: MwKLsyUNSEuv7AEhvlG7Dw==
X-CSE-MsgGUID: YT+A57voRxyZJ/kxR8H1tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="55704720"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 10:47:52 -0700
Received: from [10.212.127.244] (kliang2-mobl1.ccr.corp.intel.com [10.212.127.244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 4798920CFED5;
	Thu, 18 Jul 2024 10:47:49 -0700 (PDT)
Message-ID: <64030eab-6e95-494a-ab72-bc33792ef723@linux.intel.com>
Date: Thu, 18 Jul 2024 13:47:47 -0400
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
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fUfoMZ0HjCNoJe6hgEMi5ciY+LqFjBbLzfiZgO6dioshA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-07-18 11:39 a.m., Ian Rogers wrote:
> On Thu, Jul 18, 2024 at 7:33 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-07-17 8:30 p.m., Ian Rogers wrote:
>>> If an event file exists in sysfs, check if a event.cpus file exists
>>> and read a perf_cpu_map from it if it does. This allows particular
>>> events to have a different set of CPUs compared to the PMU.
>>>
>>> One scenario where this could be useful is when a PMU is set up with a
>>> cpumask/events per SMT thread but some events record for all SMT
>>> threads. Programming an event on each SMT thread will cause
>>> unnecessary counters to be programmed and the aggregate value to be
>>> too large.
>>
>> If I understand the scenario correctly, I think the issue should have
>> been addressed since ICX, with the introduction of  the "SMT-aware
>> events". Is there a specific event which still has the issue on newer
>> platforms?
> 
> Nothing comes to mind, but it is there on popular machines like Skylake.
> 
>>>
>>> Another scenario where this could be useful if when a PMU has
>>> historically had a cpumask at the package level, but now newer per
>>> die, core or CPU information is available.
>>
>> The traditional way to support new counters with a different scope is to
>> add a new PMU.
>>
>>>
>>> Additional context for the motivation is in these patches and
>>> conversation:
>>> https://lore.kernel.org/lkml/20240711102436.4432-1-Dhananjay.Ugwekar@amd.com/
>>
>> I don't see the advantages of the new event.cpus way.
>> The aggregation should be the same.
> 
> Agreed. My concern is that we may end up with a pattern of
> <pmu>_per_pkg, <pmu>_per_core, <pmu>_per_cpu, <pmu>_per_l3, etc. just
> for the sake of the cpumask.

The cstate PMUs already do so, e.g., cstate_core, cstate_pkg.

From another perspective, it discloses the scope information in a PMU
name. If a user only cares about the information of a package, they just
need to focus on everything under <pmu>_pkg. Otherwise, they have to go
through all the events.

> 
>> The RAPL counters are free-running counters. So there is no difference
>> whether grouping or not grouping.
> 
> Should the RAPL counters return true for perf_pmu__is_software? In the
> tool we currently return false and won't allow grouping, these events
> with other hardware events. The intent in perf_pmu__is_software was to
> emulate the way the kernel allows/disallows groups - software context
> events can be in a hardware context but otherwise I don't believe the
> grouping is allowed.

No, it's not allowed for the RAPL counters.

If the motivation is to find another way to group counters with
different scope, it may not work.

We once tried to mix the perf_invalid_context PMUs in a group. But it's
denied.
https://yhbt.net/lore/all/20150415172856.GA5029@twins.programming.kicks-ass.net/

The event.cpus still faces the same issues.

> 
>> But it makes the kernel driver complex, since it has to maintain at
>> least two different cpumasks.
> 
> Two drivers each maintaining a cpumask or 1 driver maintaining 2
> cpumasks, it seems like there is chance for code reuse in both cases.
> I'm not seeing how it adds to complexity particularly.

Yes, there are some cleanup opportunities for the cpumask/hotplug codes.

We may even abstracts some generic interfaces for pkg or core level PMUs.

Eventually, the complexity/duplication should be able to be reduced.

> 
>> The tool becomes complex either, since it has to take care of the
>> per-event CPU override case.
> 
> I'm not sure I agree with this. What we need for perf_event_open is a
> perf_event_attr, we dress these up as evsels which also have the
> ability to be for >1 CPU or thread. Longer term I think evsels can
> also have >1 PMU, for the wildcard cases like uncore memory
> controllers - this would remove the need for resorting evsels except
> for topdown events which have thrown us a giant bundle of challenges.
> Anyway, so an evsel is perf_event_attr information paired with CPU
> information, it makes sense to me that the parser should do this
> pairing. What's harder in the evsel/evlist setup is trying to fix CPU
> maps up not in parsing, like with __perf_evlist__propagate_maps where
> the parsing is trying to leave crumbs around (like system_wide,
> has_user_cpus, is_pmu_core) so the map propagation works properly.
> 
>> The json file must also be updated to add a
>> new field cpumask.
> 
> Yeah, I don't like this as it means we end up putting CPU information
> into the json that isn't the same for every CPU variant of the same
> architecture model. Maybe we can have some kind of "scope" enum value
> in the json and then when the scope differs from the PMU's, core scope
> vs the PMU's hyperthread scope, then in the tool we can figure out the
> cpumask from the topology in sysfs. Maybe we should just always use
> the topology and get rid of cpumask files in sysfs, replacing them
> with "scope" files. Will Deacon pushed back on having ARM PMUs
> supporting hot plugging
> (https://lore.kernel.org/lkml/20240701142222.GA2691@willie-the-truck/)
> where the main thing hot plugging handler needs to maintain is set the
> cpumask.

Not just the cpumask but also migrate the context for some PMUs, see
perf_pmu_migrate_context().

It seems we really need a shared cpumask in the generic code, so the
drivers don't need to handle the hotplug everywhere. I will think about it.

Thanks,
Kan

