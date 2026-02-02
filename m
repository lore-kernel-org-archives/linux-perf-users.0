Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02582E2DF3
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Feb 2026 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026340; cv=none; b=BkqgkoUpgQB+xDyF1FBzylh87oUdv23fpwRhEp5zipRq/nqVGoXcblGtno5P2Lmygsixb+uM0wp9q5btl+QUFyMBGAWzzNwJ0S6/ZBbIlu6LTT4Gu6D9Mc1G3Py97UMCJxcxdqgPJRgdZCrjYmGGARdvJeg9RZ0ZOBTpJPyMSFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026340; c=relaxed/simple;
	bh=ZFSEx04YNBhGtDRF/gsi2m6rZGee19zAcSBvYvVCEjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKBnK7fOy7KObqN6iOd6wQy4CkWyAjmD2iVHVppy3sqlx6pIr+ulRYTvQjBQ8hP8rc0wxgBrDyDrAlH6SIQBTQU6D4UeKbe4CLP2vKY/MVTn68mkeyzKx0jcdTuK5Uf13PaTbzE7n8PxCzBQoetesEJJRZemsMWdXRG50FrTeuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xhrp5jk3; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xhrp5jk3"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-432d256c2e6so3428403f8f.3
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Feb 2026 01:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770026336; x=1770631136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q3+G72CDBB1fZxT87aoM4udjUxdGJbmDHiZtO7gTgFU=;
        b=xhrp5jk3aqt1uKWvzKSb5deCDZkRbpEU9gKXP6T3O+FHQiD7Ztg5ksvsUTHRPmJN8B
         IR88Kp1Sw634lOkM7vsNH8nzOCL9V1axSlt0iGFfWQ0PIXUB5dSn30p2EyGR1albq+2K
         HSiGS2MbBc9BCcyGcnzQWb0FYrjBoVt7Hnam15r3ccLN6IATcF2Di6kb5p+gqOc4jOEE
         QzFbk22vfp0wGEmtVWUlkgNBrKHoMO6wzRmG7u0NvBPPWMmuZMk6NlvjpwnvdtWhnTcj
         CEHTBoO1ycnUVEQbQPYtBde1heCUAi/gHLe6kbycL8dmrlc6bdtIWFvXqnS6YOedVoGq
         z2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770026336; x=1770631136;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q3+G72CDBB1fZxT87aoM4udjUxdGJbmDHiZtO7gTgFU=;
        b=hytGVVM5uHbEpaeEezusX50r9Q5lPBouxVUYwjMnVolBWKbavyBWTqfDOLeOhTFQlm
         +zMSJiCu0Dmx1/U8NkXpZmme1XelZA1v9bQy9sveKiFodHrZ5G9HU/ICcoPru7hPS0Qb
         Z4thAia1D2NsfnTEzKgd6ivDt9J72my6GX6qsMGXdSv5pHM07lGEsDO67nZk1FvJtD8x
         AKhl+4ZSqCvUANGLdrm9ULlBvtGYeCxAHEZr4v42iRGdzjKQ+lVwI19J0NXmN6aY+8w2
         BKESXgipFzQJKuXB9oSMIXC+NZia8JH0xGbvpdLc4FfzwjUJ2nBPLJazWuhIpLdmAJ84
         zOxA==
X-Forwarded-Encrypted: i=1; AJvYcCWGhPCoLnOxBZ6LwhD1gpr/97tuNyr0AjoVdfJQQGIoVpb6N1NqmMxPcRvdKJLx0Y01+S5Ohw7PraycqMDzzF0Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1cxR6vuHCfpKfMJ7/ggOhD0ZWRK7NYwPxgnuZs4aptphpU3Ak
	K+z966Qc/F/PqP8Aog3CGZhT91x9+LC+ZSOyEy+5D7Z2ZALv1KaEyVhAOICT2a2m3Ws=
X-Gm-Gg: AZuq6aL7GsfH4HLmdkepfg4M1ITMWV+IhUuHvN+aJ1kNOzqGFtwC2JBYe27Fbt+fVS5
	BxgeSEyh1bM9lbHdgWkQYrsakKqKSJYzOe7OH7d3pa/3KEgkWHwmXQnR6Qf4APshYsmIxZj82qW
	Wq1bpIECy4Tj8kajJT6T3sWp1ORJAVclT0o0Gujgm50/m0IIqB3fL/cWLIHFX3Z9lTk6DAoG2BO
	MrK+2SrYkdoyCW2lkJTTWxZAFasviQwH7NvyjvCkgvETlP1M/CAnUVBuGtcYH5rlLYr2q6KGRvM
	kJuLSV+ZcGTrXvS06FZfoyC4jbHcGRmv9jUjpbnjekonzAZBLKf6CFM7+ymor9JCB1kzrFqcZZh
	NJ+BhWwlJOo/0XFnIrqLfLZOgKeAuAtg+7emgUzlV4D+ByXYUphyftQGk3tgwJA4XmLfQiFvtJw
	S32zgV0G5o9yPpELHvyVnBnGNfdjM=
X-Received: by 2002:a05:6000:1acb:b0:435:9bf5:b336 with SMTP id ffacd0b85a97d-435f3a91ee5mr16585849f8f.19.1770026335909;
        Mon, 02 Feb 2026 01:58:55 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10ee040sm42490396f8f.11.2026.02.02.01.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 01:58:55 -0800 (PST)
Message-ID: <45c02424-f090-42bc-8165-03b4ef2c0a6c@linaro.org>
Date: Mon, 2 Feb 2026 09:58:53 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf vendor events arm64: Add Tegra410 Olympus PMU events
To: Besar Wicaksono <bwicaksono@nvidia.com>, Ian Rogers <irogers@google.com>
Cc: "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
 "will@kernel.org" <will@kernel.org>,
 "mike.leach@linaro.org" <mike.leach@linaro.org>,
 "leo.yan@linux.dev" <leo.yan@linux.dev>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
 "namhyung@kernel.org" <namhyung@kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Thomas Makin <tmakin@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>,
 Rich Wiley <rwiley@nvidia.com>, Sean Kelley <skelley@nvidia.com>,
 Yifei Wan <YWan@nvidia.com>, Thierry Reding <treding@nvidia.com>,
 Jon Hunter <jonathanh@nvidia.com>, Matt Ochs <mochs@nvidia.com>
References: <20260127225909.3296202-1-bwicaksono@nvidia.com>
 <CAP-5=fUxhbR1xs1f9mrkcUXZZNLrVqDG0ebhwW--WtgVRnNxNw@mail.gmail.com>
 <40988c57-ee6f-4693-afe4-2615dc43f395@linaro.org>
 <MW5PR12MB5681E958BDDCEB137E65CE54A09FA@MW5PR12MB5681.namprd12.prod.outlook.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <MW5PR12MB5681E958BDDCEB137E65CE54A09FA@MW5PR12MB5681.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 30/01/2026 6:08 pm, Besar Wicaksono wrote:
> Thank you James and Ian for the comments.
> I will try to address the spelling mistakes on v2.
> 
> Please see my other comments inline.
> 
>> -----Original Message-----
>> From: James Clark <james.clark@linaro.org>
>> Sent: Wednesday, January 28, 2026 3:37 AM
>> To: Ian Rogers <irogers@google.com>; Besar Wicaksono
>> <bwicaksono@nvidia.com>
>> Cc: john.g.garry@oracle.com; will@kernel.org; mike.leach@linaro.org;
>> leo.yan@linux.dev; mark.rutland@arm.com;
>> alexander.shishkin@linux.intel.com; jolsa@kernel.org;
>> adrian.hunter@intel.com; peterz@infradead.org; mingo@redhat.com;
>> acme@kernel.org; namhyung@kernel.org; linux-tegra@vger.kernel.org; linux-
>> arm-kernel@lists.infradead.org; linux-perf-users@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Thomas Makin <tmakin@nvidia.com>; Vikram Sethi
>> <vsethi@nvidia.com>; Rich Wiley <rwiley@nvidia.com>; Sean Kelley
>> <skelley@nvidia.com>; Yifei Wan <ywan@nvidia.com>; Thierry Reding
>> <treding@nvidia.com>; Jon Hunter <jonathanh@nvidia.com>; Matt Ochs
>> <mochs@nvidia.com>
>> Subject: Re: [PATCH] perf vendor events arm64: Add Tegra410 Olympus PMU
>> events
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On 28/01/2026 8:03 am, Ian Rogers wrote:
>>> On Tue, Jan 27, 2026 at 3:00 PM Besar Wicaksono
>> <bwicaksono@nvidia.com> wrote:
>>>>
>>>> Add JSON files for NVIDIA Tegra410 Olympus core PMU events.
>>>> Also updated the common-and-microarch.json.
>>>>
>>>> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
>>>> ---
>>>>    .../arch/arm64/common-and-microarch.json      |  90 +++
>>>>    tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
>>>>    .../arch/arm64/nvidia/t410/branch.json        |  45 ++
>>>>    .../arch/arm64/nvidia/t410/brbe.json          |   6 +
>>>>    .../arch/arm64/nvidia/t410/bus.json           |  48 ++
>>>>    .../arch/arm64/nvidia/t410/exception.json     |  62 ++
>>>>    .../arch/arm64/nvidia/t410/fp_operation.json  |  78 ++
>>>>    .../arch/arm64/nvidia/t410/general.json       |  15 +
>>>>    .../arch/arm64/nvidia/t410/l1d_cache.json     | 122 +++
>>>>    .../arch/arm64/nvidia/t410/l1i_cache.json     | 114 +++
>>>>    .../arch/arm64/nvidia/t410/l2d_cache.json     | 134 ++++
>>>>    .../arch/arm64/nvidia/t410/ll_cache.json      | 107 +++
>>>>    .../arch/arm64/nvidia/t410/memory.json        |  46 ++
>>>>    .../arch/arm64/nvidia/t410/metrics.json       | 722
>> ++++++++++++++++++
>>>>    .../arch/arm64/nvidia/t410/misc.json          | 646 ++++++++++++++++
>>>>    .../arch/arm64/nvidia/t410/retired.json       |  94 +++
>>>>    .../arch/arm64/nvidia/t410/spe.json           |  42 +
>>>>    .../arm64/nvidia/t410/spec_operation.json     | 230 ++++++
>>>>    .../arch/arm64/nvidia/t410/stall.json         | 145 ++++
>>>>    .../arch/arm64/nvidia/t410/tlb.json           | 158 ++++
>>>>    20 files changed, 2905 insertions(+)
>>>>    create mode 100644 tools/perf/pmu-
>> events/arch/arm64/nvidia/t410/branch.json
>>>>    create mode 100644 tools/perf/pmu-
>> events/arch/arm64/nvidia/t410/brbe.json
>>>>    create mode 100644 tools/perf/pmu-
>> events/arch/arm64/nvidia/t410/bus.json
>>>>    create mode 100644 tools/perf/pmu-
>> events/arch/arm64/nvidia/t410/exception.json
>>>>    create mode 100644 tools/perf/pmu-
>> events/arch/arm64/nvidia/t410/fp_operation.json
>>>>    create mode 100644 tools/perf/pmu-
>> events/arch/arm64/nvidia/t410/general.json
>>>>    create mode 100644 tools/perf/pmu-
>> events/arch/arm64/nvidia/t410/l1d_cache.json
>>>>    create mode 100644 tools/perf/pmu-
>> events/arch/arm64/nvidia/t410/l1i_cache.json
>>>>    create mode 100644 tools/perf/pmu-
>> events/arch/arm64/nvidia/t410/l2d_cache.json
>>>>    create mode 100644 tools/perf/pmu-
>> events/arch/arm64/nvidia/t410/ll_cache.json
>>>>    create mode 100644 tools/perf/pmu-
>> events/arch/arm64/nvidia/t410/memory.json
>>>>    create mode 100644 tools/perf/pmu-
>> events/arch/arm64/nvidia/t410/metrics.json
>>>>    create mode 100644 tools/perf/pmu-
>> events/arch/arm64/nvidia/t410/misc.json
>>>>    create mode 100644 tools/perf/pmu-
>> events/arch/arm64/nvidia/t410/retired.json
>>>>    create mode 100644 tools/perf/pmu-
>> events/arch/arm64/nvidia/t410/spe.json
>>>>    create mode 100644 tools/perf/pmu-
>> events/arch/arm64/nvidia/t410/spec_operation.json
>>>>    create mode 100644 tools/perf/pmu-
>> events/arch/arm64/nvidia/t410/stall.json
>>>>    create mode 100644 tools/perf/pmu-
>> events/arch/arm64/nvidia/t410/tlb.json
>>>>
>>>> diff --git a/tools/perf/pmu-events/arch/arm64/common-and-
>> microarch.json b/tools/perf/pmu-events/arch/arm64/common-and-
>> microarch.json
>>>> index 468cb085d879..6af15776ff17 100644
>>>> --- a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
>>>> +++ b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
>>>> @@ -179,6 +179,11 @@
>>>>            "EventName": "BUS_CYCLES",
>>>>            "BriefDescription": "Bus cycle"
>>>>        },
>>>> +    {
>>>> +        "EventCode": "0x001E",
>>>> +        "EventName": "CHAIN",
>>>> +        "BriefDescription": "Chain a pair of event counters."
>>>> +    },
>>>
>>> Cool stuff :-)
>>>
>>> For wider counters AMD does something similar, but should this be an
>>> implementation detail rather than an exposed event? How does it
>>> operate as an event?
>>>
>>
>> CHAIN should be excluded from the json, it's used internally by the
>> driver when you want 64 bit counters. Userspace can't use it because it
>> can't control where counters are placed to make sure they're adjacent.
>>
> 
> Sure, will address this in V2.
> 
>>> [snip]
>>>> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv
>> b/tools/perf/pmu-events/arch/arm64/mapfile.csv
>>>> index bb3fa8a33496..7f0eaa702048 100644
>>>> --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
>>>> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
>>>> @@ -46,3 +46,4 @@
>>>>    0x00000000500f0000,v1,ampere/emag,core
>>>>    0x00000000c00fac30,v1,ampere/ampereone,core
>>>>    0x00000000c00fac40,v1,ampere/ampereonex,core
>>>> +0x000000004e0f0100,v1,nvidia/t410,core
>>>> diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/branch.json
>> b/tools/perf/pmu-events/arch/arm64/nvidia/t410/branch.json
>>>> new file mode 100644
>>>> index 000000000000..532bc59dc573
>>>> --- /dev/null
>>>> +++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/branch.json
>>>> @@ -0,0 +1,45 @@
>>>> +[
>>>> +    {
>>>> +        "ArchStdEvent": "BR_MIS_PRED",
>>>> +        "PublicDescription": "The Event counts Branches which are
>> speculatively executed and mis-predicted."
>>>
>>> nit: The capitalization on Event and Branches, as well as other words,
>>> is a little unusual.
>>>
>>
>> If there's nothing specific to this CPU then the public description
>> could be left out entierly. The common strings already say the same
>> thing as this:
>>
>>       {
>>           "PublicDescription": "Mispredicted or not predicted branch
>>                                 speculatively executed",
>>           "EventCode": "0x10",
>>           "EventName": "BR_MIS_PRED",
>>           "BriefDescription": "Mispredicted or not predicted branch
>>                                speculatively executed"
>>       },
>>
>>
> 
> I will check on this and other events.
> 
>>> [snip]
>>>> diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.json
>> b/tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.json
>>>> new file mode 100644
>>>> index 000000000000..18c2fd58ee9e
>>>> --- /dev/null
>>>> +++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.json
>>>> @@ -0,0 +1,722 @@
>>>> +[
>>>> +    {
>>>> +        "MetricName": "backend_bound",
>>>> +        "MetricExpr": "100 * (STALL_SLOT_BACKEND / CPU_SLOT)",
>>>> +        "BriefDescription": "This metric is the percentage of total slots that
>> were stalled due to resource constraints in the backend of the processor.",
>>>> +        "ScaleUnit": "1percent of slots",
>>>> +        "MetricGroup": "TopdownL1"
>>>
>>> Note, on x86 we place TopdownL1 in the Default metric group so it is
>>> shown by `perf stat` when it isn't given events or metrics to compute.
>>> Perhaps you want to do something similar?
>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-
>> next.git/tree/tools/perf/pmu-events/arch/x86/icelake/icl-
>> metrics.json?h=tmp.perf-tools-next#n116
>>>
>>> Thanks,
>>> Ian
>>
>> That's currently true for the Arm topdown metrics in sbsa.json, but we
>> probably don't actually want this because there aren't enough counters
>> for the perf stat defaults plus topdown and it results in multiplexing
>> and bad results.
>>
>> I was planning to change it but we also don't currently expose the
>> number of counters available either...
>>
> 
> Agree with James, we may not be able to cover all the events in
> Default + TopdownL1 group.
> 
> Ian, James, in general, is it fine to put some metrics in a same group because
> they are actually correlating even though it may cause multiplexing?
> For example, "Miss_Ratio" group in this patch provides miss ratio from L1, L2, TLB, etc.
> It's convenient to have this and get the miss ratio from all cache levels.
> There are many events needed for this group and it might not be accurate due to
> multiplexing, but user can get a (rough) broad view in the beginning.
> 
> Thanks,
> Besar

Yes I think it makes sense to put them all in the same group if they are 
the same feature. I suppose my point about possibly not wanting to open 
TopdownL1 by default is a separate issue to whether they should be in 
the group or not. I just thought it was a good time to mention it.


