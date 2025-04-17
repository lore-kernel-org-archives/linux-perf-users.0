Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C31184E;
	Thu, 17 Apr 2025 01:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744852525; cv=none; b=LLcjAa+0ggOmT4PbL8nLzsabpjcILbQ3J2SvtV9P4IJRyavin/YRb5bGdgAKX3kDsktdMFHR3Wz0mCMNjs+tHSb9R9BDCUgFKaf/UN1v6s0w6ENRfF19ya14KhOcvZ+b2DSXwEJuNyi22fY69M7hMXmC7rIB4FG4Ly4NwFmiNpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744852525; c=relaxed/simple;
	bh=amr6vgsdm/bR4XZmhanRpSp3TvMOJseVw7y8GlsWa0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gz9ZIp9pseyytoqMQAPvvu00VcmC4Bz8vnxhzJIZESUvIWkAs+e2djyhhE6ffgv9t0KGkkWf9W1AaXAO521QAKEKiJu3QBzHPI1tkKWuSC6M2iQKoT5/pxdbgNfi4lsqCjVEVPV4RlAZpkdK4nh3wUQJXPCO4NXTMFF64u6nASo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AqnsX7qO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AqnsX7qO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744852524; x=1776388524;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=amr6vgsdm/bR4XZmhanRpSp3TvMOJseVw7y8GlsWa0Y=;
  b=AqnsX7qOjs4k5a18RFVnjwzT19GsxDtMuxVzbEUm5TieTL0y6ERnNNTB
   OVUhx1+hztZOpOgdCCg5v8NTa8P4n19vQmQNcyH3CyL+O3rXxZYafuKqV
   YPTw3l8Vowdq7H11MhZKQB8ue/NcyqL4z40E+vgF7r5hDOxbf1Ribx3gS
   +Z/CwRsQLLoxqZXDs8mBP30imIn9Fv5jNeU828TbDvilkgUsxQVF/07Yl
   3UD8HSC7n2y9qCfMOQr2HXVMimARgVzDJOyocJxnPX4d6Lfv2+nWE0cUa
   Qfpa1zW0lycy6EmqYu9Ui94n2miVroJMKqZ2ogdt6USe9DntSg3bS1cAX
   g==;
X-CSE-ConnectionGUID: lMBcJ1PRT0WlAqn9Tkk8yg==
X-CSE-MsgGUID: 55PC6qRITfqILUTUFFPiAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="50247421"
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="50247421"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 18:15:23 -0700
X-CSE-ConnectionGUID: ANCZp8RaQqiMsZfscb+Vlw==
X-CSE-MsgGUID: XVHW47IARmGHPAmZtw11og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="153831948"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 18:15:19 -0700
Message-ID: <3989d25c-2961-46b4-8f77-3c1eab63866a@linux.intel.com>
Date: Thu, 17 Apr 2025 09:15:16 +0800
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
 <a3269f8a-aff3-4f9e-8f43-b00fee03121a@linux.intel.com>
 <a998c0c3-1ec5-4dbe-95fa-fd37648de96a@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <a998c0c3-1ec5-4dbe-95fa-fd37648de96a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/16/2025 9:59 PM, Liang, Kan wrote:
>
> On 2025-04-15 9:46 p.m., Mi, Dapeng wrote:
>> On 4/16/2025 12:31 AM, Liang, Kan wrote:
>>> On 2025-04-15 9:53 a.m., Peter Zijlstra wrote:
>>>> On Tue, Apr 15, 2025 at 11:44:18AM +0000, Dapeng Mi wrote:
>>>>> arch-PEBS provides CPUIDs to enumerate which counters support PEBS
>>>>> sampling and precise distribution PEBS sampling. Thus PEBS constraints
>>>>> should be dynamically configured base on these counter and precise
>>>>> distribution bitmap instead of defining them statically.
>>>>>
>>>>> Update event dyn_constraint base on PEBS event precise level.
>>>> What if any constraints are there on this? 
>>> Do you mean the static constraints defined in the
>>> event_constraints/pebs_constraints?
>>>
>>>> CPUID is virt host
>>>> controlled, right, so these could be the most horrible masks ever.
>>>>
>>> Yes, it could be changed by VMM. A sanity check should be required if
>>> abad mask is given.
>> Yes, we need a check to restrict the PEBS counter mask into the valid
>> counter mask, and just realized that we can't use hybrid(event->pmu,
>> intel_ctrl) to check counter mask and need a minor tweak since it includes
>> the GLOBAL_CTRL_EN_PERF_METRICS bit.
>>
>> How about this?
>>
>>         if (x86_pmu.arch_pebs) {
>>             u64 cntr_mask = hybrid(event->pmu, intel_ctrl) &
>>                         ~GLOBAL_CTRL_EN_PERF_METRICS;
>>             u64 pebs_mask = event->attr.precise_ip >= 3 ?
>>                         pebs_cap.pdists : pebs_cap.counters;
>>             if (pebs_mask != cntr_mask)
>>                 event->hw.dyn_constraint = pebs_mask & cntr_mask;
>>         }
>>
> The mask isn't changed after boot. The sanity check should only be done
> once. I think it can be done in the update_pmu_cap() when perf retrieves
> the value. If a bad mask is detected, the PEBS should be disabled.

Yeah, it makes sense. Would do.


>
> Thanks,
> Kan>
>>>> This can land us in EVENT_CONSTRAINT_OVERLAP territory, no?The dyn_constraint is a supplement of the static constraints. It doesn't
>>> overwrite the static constraints.
>>>
>>> In the intel_get_event_constraints(), perf always gets the static
>>> constraints first. If the dyn_constraint is defined, it gets the common
>>> mask of the static constraints and the dynamic constraints. All
>>> constraint rules will be complied.
>>>
>>> 	if (event->hw.dyn_constraint != ~0ULL) {
>>> 		c2 = dyn_constraint(cpuc, c2, idx);
>>> 		c2->idxmsk64 &= event->hw.dyn_constraint;
>>> 		c2->weight = hweight64(c2->idxmsk64);
>>> 	}
>>>
>>> Thanks,
>>> Kan
>>>
>
