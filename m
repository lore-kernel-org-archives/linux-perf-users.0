Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99AC34BA3C;
	Thu,  9 Oct 2025 02:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759977078; cv=none; b=pqpWiki8+9UtnGJG+88/+qqdghUiF6kF3NyY0LCZT1r0ZuESD2QldVpwaBqdkXFadr4+ejUgJ7XK7t00wLhGrJMAtG0EGczeG5lzlwSpub2qrfe61r6FVWw3WFIGzeoEtkdeNhRf6q5EA4DQIhAU3fowNRRJXY6dK8POktQ2TlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759977078; c=relaxed/simple;
	bh=+7s9Br6cECwXBhfFA8GmgPo2i86Xbi2C0hgsN/FI2gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWBnQGXn6vH/waichiq+MwYI+eDrsPL0gf4/SQeKbqitQb+IyRPOCPGhKCSEQh6kYOTuum4SVgR7YW8v0xE4CgPs0i8sIcyflrqW52YAR7lkBFVWq46uiba9o6fEYg7Mlx/A882ZifwFXTeGlicI9oHOIcj0tqfuC24Dkt6amPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1rvve7h; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1rvve7h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759977077; x=1791513077;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+7s9Br6cECwXBhfFA8GmgPo2i86Xbi2C0hgsN/FI2gk=;
  b=I1rvve7hh+Oyqbtn0oYTrmYcg895zt+J8U94a3dGo8fdzEZKuPKhZaSg
   3t67UlOpVaGPkSZCPZ0D1vFFii36IsDnpi+YXKeshHpsiywGHPAcnorhG
   L23qeENaPk73Z8vLmTw/ESRlbXhg7dd08DMxRx6oxBd18bubsqS8PZ2yA
   Ekce8X9G9fR3ogQDEzTyd0uGY8ZLpaddsP4Ob7Yu/vryqayQuuY2j4ABC
   yGzveZZFFRgvxAzuRrH0+6yD6A4p7HpmoBTOTALdttRch67zazwl9Gmto
   A/WUeMGVpOgaIwe0/K+UQMP/rSRHlT6Mx8jAdfQCZpVerqWS6RFdN8i/O
   A==;
X-CSE-ConnectionGUID: UH3dqJhGSrikMbnN8WyMew==
X-CSE-MsgGUID: JiM3ZekKQF2GcUjfTA0eOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="72792615"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="72792615"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 19:31:15 -0700
X-CSE-ConnectionGUID: 3dsMEZceTeOzWYOdq2p59g==
X-CSE-MsgGUID: x52x1ZdHTACOTyW4G9aN4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="179847110"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.209]) ([10.124.232.209])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 19:31:11 -0700
Message-ID: <fd91b8b2-7e6e-42b6-812d-3cf3ead882d3@linux.intel.com>
Date: Thu, 9 Oct 2025 10:31:08 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v2 0/2] perf record: ratio-to-prev event term for
 auto counter reload
To: "Falcon, Thomas" <thomas.falcon@intel.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "acme@kernel.org" <acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>,
 "namhyung@kernel.org" <namhyung@kernel.org>,
 "jolsa@kernel.org" <jolsa@kernel.org>,
 "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
 "irogers@google.com" <irogers@google.com>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "ak@linux.intel.com" <ak@linux.intel.com>
References: <20250902164047.64261-1-thomas.falcon@intel.com>
 <ed463cd8-495e-4769-b392-372413ca7db6@linux.intel.com>
 <cf7ae59b735f004b5c6dd53b82e3d3e2acfad973.camel@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <cf7ae59b735f004b5c6dd53b82e3d3e2acfad973.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/2/2025 11:38 PM, Falcon, Thomas wrote:
> On Tue, 2025-09-30 at 15:28 +0800, Mi, Dapeng wrote:
>> On 9/3/2025 12:40 AM, Thomas Falcon wrote:
>>> The Auto Counter Reload (ACR)[1] feature is used to track the
>>> relative rates of two or more perf events, only sampling
>>> when a given threshold is exceeded. This helps reduce overhead
>>> and unnecessary samples. However, enabling this feature
>>> currently requires setting two parameters:
>>>
>>>  -- Event sampling period ("period")
>>>  -- acr_mask, which determines which events get reloaded
>>>     when the sample period is reached.
>>>
>>> For example, in the following command:
>>>
>>> perf record -e "{cpu_atom/branch-misses,period=200000,\
>>> acr_mask=0x2/ppu,cpu_atom/branch-instructions,period=1000000,\
>>> acr_mask=0x3/u}" -- ./mispredict
>>>
>>> The goal is to limit event sampling to cases when the
>>> branch miss rate exceeds 20%. If the branch instructions
>>> sample period is exceeded first, both events are reloaded.
>>> If branch misses exceed their threshold first, only the
>>> second counter is reloaded, and a sample is taken.
>>>
>>> To simplify this, provide a new “ratio-to-prev” event term
>>> that works alongside the period event option or -c option.
>>> This would allow users to specify the desired relative rate
>>> between events as a ratio, making configuration more intuitive.
>>>
>>> With this enhancement, the equivalent command would be:
>>>
>>> perf record -e "{cpu_atom/branch-misses/ppu,\
>>> cpu_atom/branch-instructions,period=1000000,ratio_to_prev=5/u}" \
>>> -- ./mispredict
>> Hi Tom,
>>
>> Does this "ratio-to-prev" option support 3 and more events in ACR
>> group?
>>
> Hi Dapeng,
>
> The 'ratio-to-prev' option only supports groups with two events at this
> time. For larger event groups, the "acr_mask" term is available.
>
>> If not, should we consider to support the cases there are 3 and more
>> events
>> in the ACR group? (If I remember correct, the PMU driver should
>> support it).
>>
> Correct.
>
>> e.g.,
>>
>> perf record -e
>> "{cpu_atom/branch-
>> misses,period=200000,acr_mask=0x6/p,cpu_atom/branches,period=1000000,
>> acr_mask=0x7/,cpu_atom/branches,period=1000000,acr_mask=0x7/}"
>> -- sleep 1
>>
>> Of course, this is just an example that indicates the cases are
>> supported,
>> it doesn't mean the command is meaningful. But we can't exclude that
>> users
>> have such real requirements.
>>
>> If we want to support 3 and more events in ACR group (if not
>> already), we'd
>> better rename the "ratio-to-prev" option to "ratio-to-head" and only
>> allow
>> the group leader can be set the sampling period explicitly with
>> "period"
>> option and the sampling period of all other group members can only be
>> calculated base on the sampling period of group leader and
>> the "ratio-to-head", maybe like this.
>>
>> perf record -e
>> "{cpu_atom/branch-misses,period=200000/p,cpu_atom/branches,ratio-to-
>> head=5/,cpu_atom/branches,ratio-to-head=5/}"
>> -- sleep 1
>>
>> Thanks.
>>
>>
> Thanks, those are good suggestions, but the goal of the feature was to
> provide users a way to utilize ACR to make simple comparisons without
> needing to use the "acr_mask" field. For tests comparing larger event
> groups, the acr_mask field may be used instead.

Yeah, I understand the intent is to get a new simple option for using the
ACR feature. But we already support 2 events for the ACR group, why not we
make it more generic and can support more events? 


>
> Thanks,
> Tom
>
>>> or
>>>
>>> perf record -e "{cpu_atom/branch-misses/ppu,\
>>> cpu_atom/branch-instructions,ratio-to-prev=5/u}" -c 1000000 \
>>> -- ./mispredict
>>>
>>> [1]
>>> https://lore.kernel.org/lkml/20250327195217.2683619-1-kan.liang@linux.intel.com/
>>>
>>> Changes in v2 (mostly suggested by Ian Rogers):
>>>
>>> -- Add documentation explaining acr_mask bitmask used by ACR
>>> -- Move ACR specific implementation to arch/x86/
>>> -- Provide test cases for event parsing and perf record tests
>>>
>>> Thomas Falcon (2):
>>>   perf record: Add ratio-to-prev term
>>>   perf record: add auto counter reload parse and regression tests
>>>
>>>  tools/perf/Documentation/intel-acr.txt | 53 ++++++++++++++++++
>>>  tools/perf/Documentation/perf-list.txt |  2 +
>>>  tools/perf/arch/x86/util/evsel.c       | 53 ++++++++++++++++++
>>>  tools/perf/tests/parse-events.c        | 54 ++++++++++++++++++
>>>  tools/perf/tests/shell/record.sh       | 40 ++++++++++++++
>>>  tools/perf/util/evsel.c                | 76
>>> ++++++++++++++++++++++++++
>>>  tools/perf/util/evsel.h                |  1 +
>>>  tools/perf/util/evsel_config.h         |  1 +
>>>  tools/perf/util/parse-events.c         | 22 ++++++++
>>>  tools/perf/util/parse-events.h         |  3 +-
>>>  tools/perf/util/parse-events.l         |  1 +
>>>  tools/perf/util/pmu.c                  |  3 +-
>>>  12 files changed, 307 insertions(+), 2 deletions(-)
>>>  create mode 100644 tools/perf/Documentation/intel-acr.txt
>>>
