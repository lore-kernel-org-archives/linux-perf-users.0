Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5262D5227;
	Wed, 16 Apr 2025 01:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744768021; cv=none; b=baWlI2J6PMnTUWCxMQGYobyvoHMwfZ3lZgwmAorEijUWgHA4zQEF+AZLRj3bkQTCKig+50SQOXEUCGGSxXARsNdno5eM66yoYcwM67tbQ4WYPswp+eUxd0LJE4dhoA0uG7/hLkUoYaxYdDdVb/bqIbPUmToYIDINIXx2Egv2fZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744768021; c=relaxed/simple;
	bh=qi3xSS6SZhuIY9bKSw2XWNqnB1vQBn2ZS0P6j2MGY84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7Eu4f4del6MJ2VKhZZZjwEroZgS/g7K9nlPkQGoyRfbiIrsw+8Yo09magddJvDrrIMOmIgLVxyhzpZpM7Jm7BBaXmAGDLpl624F9Rz5koewEbqpXIE/zlVPU4U/sg6WMhA1tIgAQJnKwXl1l0Hu0wdcemSyJ/BZk8XvyCA/pLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XuGCDRLX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XuGCDRLX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744768020; x=1776304020;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qi3xSS6SZhuIY9bKSw2XWNqnB1vQBn2ZS0P6j2MGY84=;
  b=XuGCDRLXgc81w+5ryvKMf3gkAmYjkO1KArm9MS+UhFqNtIBKxkO8Mvu+
   62LNMRPElvbpL4vrXeHgWt32bTeQy4QpjT8wi4wJtTHmLpLgMI/UjVXFM
   lylhJ7bLnj4n57Msi5pqf5V74Gn3Hx9sGb90S2gkE6Tn5Vqjw53pUHNJE
   Xj62QyrETrbe7jPhZXS4nKdrJMAt8H9Yazebd78WlHhdfPtxEZakwC8ct
   DzgSP8lrVEBXkw1lREF0tCYo4u0XFx6bdENztWRVKm0RZtzsdDMCe7Vtz
   50+C2XKMiXI9Py26ud0BG2oV+hgosx2qUqIUcPY7CnFb7YCV6GJGJYgzR
   w==;
X-CSE-ConnectionGUID: hBF4DaW2RNyWgMS4bN99dA==
X-CSE-MsgGUID: JmBiUL+YQI62qywJDz41xQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="45531521"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="45531521"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 18:46:58 -0700
X-CSE-ConnectionGUID: 4psBF8dNQx6BmQySDJq04Q==
X-CSE-MsgGUID: cTkQZyXERJGsm0DxxVhuNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="167454123"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 18:46:54 -0700
Message-ID: <a3269f8a-aff3-4f9e-8f43-b00fee03121a@linux.intel.com>
Date: Wed, 16 Apr 2025 09:46:51 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 12/22] perf/x86/intel: Update dyn_constranit base on
 PEBS event precise level
To: "Liang, Kan" <kan.liang@linux.intel.com>,
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
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <607b1f13-1d5d-4ea7-b0ab-f4c7f4fa319b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/16/2025 12:31 AM, Liang, Kan wrote:
>
> On 2025-04-15 9:53 a.m., Peter Zijlstra wrote:
>> On Tue, Apr 15, 2025 at 11:44:18AM +0000, Dapeng Mi wrote:
>>> arch-PEBS provides CPUIDs to enumerate which counters support PEBS
>>> sampling and precise distribution PEBS sampling. Thus PEBS constraints
>>> should be dynamically configured base on these counter and precise
>>> distribution bitmap instead of defining them statically.
>>>
>>> Update event dyn_constraint base on PEBS event precise level.
>> What if any constraints are there on this? 
> Do you mean the static constraints defined in the
> event_constraints/pebs_constraints?
>
>> CPUID is virt host
>> controlled, right, so these could be the most horrible masks ever.
>>
> Yes, it could be changed by VMM. A sanity check should be required if
> abad mask is given.

Yes, we need a check to restrict the PEBS counter mask into the valid
counter mask, and just realized that we can't use hybrid(event->pmu,
intel_ctrl) to check counter mask and need a minor tweak since it includes
the GLOBAL_CTRL_EN_PERF_METRICS bit.

How about this?

        if (x86_pmu.arch_pebs) {
            u64 cntr_mask = hybrid(event->pmu, intel_ctrl) &
                        ~GLOBAL_CTRL_EN_PERF_METRICS;
            u64 pebs_mask = event->attr.precise_ip >= 3 ?
                        pebs_cap.pdists : pebs_cap.counters;
            if (pebs_mask != cntr_mask)
                event->hw.dyn_constraint = pebs_mask & cntr_mask;
        }


>
>> This can land us in EVENT_CONSTRAINT_OVERLAP territory, no?The dyn_constraint is a supplement of the static constraints. It doesn't
> overwrite the static constraints.
>
> In the intel_get_event_constraints(), perf always gets the static
> constraints first. If the dyn_constraint is defined, it gets the common
> mask of the static constraints and the dynamic constraints. All
> constraint rules will be complied.
>
> 	if (event->hw.dyn_constraint != ~0ULL) {
> 		c2 = dyn_constraint(cpuc, c2, idx);
> 		c2->idxmsk64 &= event->hw.dyn_constraint;
> 		c2->weight = hweight64(c2->idxmsk64);
> 	}
>
> Thanks,
> Kan
>
