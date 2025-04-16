Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F811DC993;
	Wed, 16 Apr 2025 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811998; cv=none; b=ElLzvThjHNwM85IQwhnDkVjBopWc8OpWxIqwL+rJkDOW1ec0jG1uBuswCRIgRylmfv/dmWFM/W9pYsil4mJoM4zu1HQJEqPskGBHVGeWiVe+NyuQGMtDzTZX1wC6ubcXmn7MDElTA5YxAHp/J8C5lIv4qEnS4WvbwIm1aN/ddEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811998; c=relaxed/simple;
	bh=93Uol4HY+e4bLu/S0Vc2E9tIOWiiPPs3FKuHcrh+xKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XH6dY+MKqxPTo1LrhFcDDvLILeF6txNe924i2bArRtTQ/5wyomuhKSxsYgRdon11RhkYrnTcXDo57kxO2vXBlHN7KPehPHQ1D0+arJw6WhkVS8oWqhV9l9BdnVTAvNNt1EG1G7dgPMsGAr2gorRaX96XECyW+coaVftPzeNOYtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CqLyD8mM; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CqLyD8mM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744811997; x=1776347997;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=93Uol4HY+e4bLu/S0Vc2E9tIOWiiPPs3FKuHcrh+xKk=;
  b=CqLyD8mMJSvKlKuovQJPqc6HasCe2za15HZUnM+aXSCInarkkJeV/47P
   yNdSRlYBO9bLy2nuxZ8MiAapdW1rwqDD8CgEiKm5UGf4rgzCay1tCuYdH
   AdlxzKViXEUBX/WiekgXHQ/8fiopdCaK8PBcT9oarZmb5vzN74q2BPte1
   hZ/wSduZf6gAXUYSq4v4xzPO5pd0+FAQ6HYHogsga74HTJjIaSKK11965
   8hcT0eUP4nQvNNB4FlXr/t5iwgUgG0/G2dhYvyo7H5iVdFNGF+zarySG2
   stnYNSUnyOd/jBkKV3WV+GPN2cFv+PN31UTafFiEgbVdWBuiOPSUWtRZV
   g==;
X-CSE-ConnectionGUID: YTGgphlOTL+Vpvv8+AiizA==
X-CSE-MsgGUID: 2fwrHDGcSOO0apV7biFPGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="57027294"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="57027294"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 06:59:54 -0700
X-CSE-ConnectionGUID: HT7ItroSTnOpop/CPNvwRg==
X-CSE-MsgGUID: Bs/22orTTfSZjMOPklpgdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="130447041"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 06:59:54 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id B731820B5736;
	Wed, 16 Apr 2025 06:59:52 -0700 (PDT)
Message-ID: <a998c0c3-1ec5-4dbe-95fa-fd37648de96a@linux.intel.com>
Date: Wed, 16 Apr 2025 09:59:51 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 12/22] perf/x86/intel: Update dyn_constranit base on
 PEBS event precise level
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
 <20250415114428.341182-13-dapeng1.mi@linux.intel.com>
 <20250415135323.GC4031@noisy.programming.kicks-ass.net>
 <607b1f13-1d5d-4ea7-b0ab-f4c7f4fa319b@linux.intel.com>
 <a3269f8a-aff3-4f9e-8f43-b00fee03121a@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <a3269f8a-aff3-4f9e-8f43-b00fee03121a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025-04-15 9:46 p.m., Mi, Dapeng wrote:
> 
> On 4/16/2025 12:31 AM, Liang, Kan wrote:
>>
>> On 2025-04-15 9:53 a.m., Peter Zijlstra wrote:
>>> On Tue, Apr 15, 2025 at 11:44:18AM +0000, Dapeng Mi wrote:
>>>> arch-PEBS provides CPUIDs to enumerate which counters support PEBS
>>>> sampling and precise distribution PEBS sampling. Thus PEBS constraints
>>>> should be dynamically configured base on these counter and precise
>>>> distribution bitmap instead of defining them statically.
>>>>
>>>> Update event dyn_constraint base on PEBS event precise level.
>>> What if any constraints are there on this? 
>> Do you mean the static constraints defined in the
>> event_constraints/pebs_constraints?
>>
>>> CPUID is virt host
>>> controlled, right, so these could be the most horrible masks ever.
>>>
>> Yes, it could be changed by VMM. A sanity check should be required if
>> abad mask is given.
> 
> Yes, we need a check to restrict the PEBS counter mask into the valid
> counter mask, and just realized that we can't use hybrid(event->pmu,
> intel_ctrl) to check counter mask and need a minor tweak since it includes
> the GLOBAL_CTRL_EN_PERF_METRICS bit.
> 
> How about this?
> 
>         if (x86_pmu.arch_pebs) {
>             u64 cntr_mask = hybrid(event->pmu, intel_ctrl) &
>                         ~GLOBAL_CTRL_EN_PERF_METRICS;
>             u64 pebs_mask = event->attr.precise_ip >= 3 ?
>                         pebs_cap.pdists : pebs_cap.counters;
>             if (pebs_mask != cntr_mask)
>                 event->hw.dyn_constraint = pebs_mask & cntr_mask;
>         }
> 

The mask isn't changed after boot. The sanity check should only be done
once. I think it can be done in the update_pmu_cap() when perf retrieves
the value. If a bad mask is detected, the PEBS should be disabled.

Thanks,
Kan>
>>
>>> This can land us in EVENT_CONSTRAINT_OVERLAP territory, no?The dyn_constraint is a supplement of the static constraints. It doesn't
>> overwrite the static constraints.
>>
>> In the intel_get_event_constraints(), perf always gets the static
>> constraints first. If the dyn_constraint is defined, it gets the common
>> mask of the static constraints and the dynamic constraints. All
>> constraint rules will be complied.
>>
>> 	if (event->hw.dyn_constraint != ~0ULL) {
>> 		c2 = dyn_constraint(cpuc, c2, idx);
>> 		c2->idxmsk64 &= event->hw.dyn_constraint;
>> 		c2->weight = hweight64(c2->idxmsk64);
>> 	}
>>
>> Thanks,
>> Kan
>>
> 

