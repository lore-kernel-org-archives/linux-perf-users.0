Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6111D353EC2
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770630614; cv=none; b=dZ5ovphQaEJ1k+A8xBnh1AhdQKkVVR3tSSJyBcY9HrEumAvUT+zb07PtRkqNyZhHOVo83wUguwKwbY9973cTE4adjiZdh/j7wcx6TTBw62vh7S2ebG8GrIY+DMBnY067H6gy9x0m48txZbnEri+GaP4Wblp1xv4/mXFcZxIdluk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770630614; c=relaxed/simple;
	bh=4E6x9EaVH4+pNZ5y/P/vyD+SMQEXY457/Yohnd+Mwyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1qbdxuOjoJQywg95hpF2LKY+4P/K0YxIwwutsmI4ZQa/PZbf7HSOw25eXBNnJwT49+dlwVlisa0VwPPVPI90p8qFqAxWs5mQ9LPfF/QrdSaLgSk+KALhwRbPrBuSv0fSU82q5s/x9nKWrsMcfVw4tyHYEKEWfKwnAc/bSym9vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JT8EgiBZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JT8EgiBZ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ee07570deso23795625e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 01:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770630613; x=1771235413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AgB5oGGHd4upF7pskvXaLtjuNDEPrMYM5N/AR0FlTwA=;
        b=JT8EgiBZ85OhNjZAzMiObeydlu1vILr6SwCYwMG5Y7AR6uqo0ShQX9N1zsB8F6/+iq
         zCm9C6uNihU+nWA9q8oshXowFEmGn9GIQjc3CM7jnG9LMKHxNrC0S1KjCZaUnkOQ5qCF
         7G/5TvLu2qvjp/k+Iy+NbO2Pm3D3it28XCGcBggXFUmMF69zTJdC21i9ITqJFS0l18QA
         FjGa58dRU/OrX1IZ7ewPpkCSOegN4s+SxCIk+2s70IdRu2cAIJ3U+odEAeza6Tl3pKvm
         H/Vrt4FTIWFw/b9vZrKnzUrIx9vR2ncMg2ZCX31tAuR+1fQFKJE5YJnoBSTONgC+eDnG
         f1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770630613; x=1771235413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AgB5oGGHd4upF7pskvXaLtjuNDEPrMYM5N/AR0FlTwA=;
        b=Vpu9BRdnUpd0aAlqmHHl7WXy8FgB0vfHe9DPgLETdhfs0EUTnOImzNfoILdxGVtQmL
         o4EhXGMdV++uIxcoEmKLbLG/v7CmC5M5jpizIFMtLXAWJfzmcAojyaFkjaDAUKuH6Qsf
         3QJxzDXgWo+i9HExLlhgLw+rIz6WBCFhb8CzBbV6KYvp1bsLjz8jWrV6Mc8YF3YbMliV
         CVtDqoDuBIUwroTBG5yGAdJu60TlRLOIHDL3uvAmWebr8FJ3U9UBZmaO8w79ZIzQIvdt
         FBIqUNs74909YZ3+qDPHtnF4Jq8QuhKdL2mh99OB76vySmVbPusfuqieTn6ntmD0cVp4
         jLZg==
X-Forwarded-Encrypted: i=1; AJvYcCVjWIpTKwlFNxLvU2f4SFFXlwxyWpk+R2VmibVyg/K25V6ZhSLh/n5EXVwzEO/BphDyBEtm6HAaMLAh3AEtYtfU@vger.kernel.org
X-Gm-Message-State: AOJu0YwdDShEfRpkXzZzkJN/mH1XuE9XoATdI5roGgy6Py2fASzbUmPU
	paW+z5NvWQOgl1ce/l+e2VTfgqRqwTy5rn1klc3Fu2YvBoHOrcwSu/QGOe9RXBkPCco=
X-Gm-Gg: AZuq6aKgbkWRMY9PDWt/CDyY9I9hxRjSh+CvqKoZijZg6t7JqNqDcx7MvpYcxdOgFaY
	nnYbfgBi9tmFzhYsQrYvemz+CI5HbrNGCvaLqqAd/jjOBcu1pPVHcbYmNdK84HdYI1RRztnWlBZ
	ODNKxi9pZ9ObjXP+ycXmYJvdu3xcSMNmU9TgFUvWvosV5IWnmrsV1r02ZeOicQVZqC3QUE5q438
	LIpj+TESciZXdJehmQxBSkR4YY+eGcthV+ptx/fht9/E9Wr8Kb+AK3sVJJ86z9byuKb0pTKGIpA
	SN6zxzBSmZwUtKH4k/Mt9fOaSSb2BDgwyVX/Nr+cavyP5+l68QI4rpSWAWNezU/zFBmrajM1c++
	kE8vOzYRX1kUDE5O976jmsZi5Q6C44eDdJ0fPWJCC3rDl8j0W5myLFsB2ognO3kNeL7n4wbcZa4
	oRr8neuqpnOE/rJA5D
X-Received: by 2002:a05:600c:34d1:b0:482:ef72:5787 with SMTP id 5b1f17b1804b1-483201da065mr134091865e9.1.1770630612708;
        Mon, 09 Feb 2026 01:50:12 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320396ccbsm121940985e9.0.2026.02.09.01.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 01:50:12 -0800 (PST)
Message-ID: <b4fb6943-361b-4c48-a199-8944cef53cfc@linaro.org>
Date: Mon, 9 Feb 2026 09:50:09 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf vendor events arm64: Add Tegra410 Olympus PMU events
To: Besar Wicaksono <bwicaksono@nvidia.com>
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
 Jon Hunter <jonathanh@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Ian Rogers <irogers@google.com>
References: <20260127225909.3296202-1-bwicaksono@nvidia.com>
 <CAP-5=fUxhbR1xs1f9mrkcUXZZNLrVqDG0ebhwW--WtgVRnNxNw@mail.gmail.com>
 <40988c57-ee6f-4693-afe4-2615dc43f395@linaro.org>
 <MW5PR12MB5681E958BDDCEB137E65CE54A09FA@MW5PR12MB5681.namprd12.prod.outlook.com>
 <45c02424-f090-42bc-8165-03b4ef2c0a6c@linaro.org>
 <MW5PR12MB5681FAEA87806E8BACF7B8C8A067A@MW5PR12MB5681.namprd12.prod.outlook.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <MW5PR12MB5681FAEA87806E8BACF7B8C8A067A@MW5PR12MB5681.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/02/2026 12:27 am, Besar Wicaksono wrote:
> 
> 
>> -----Original Message-----
>> From: James Clark <james.clark@linaro.org>
>> Sent: Monday, February 2, 2026 3:59 AM
>> To: Besar Wicaksono <bwicaksono@nvidia.com>; Ian Rogers
>> <irogers@google.com>
>> Cc: john.g.garry@oracle.com; will@kernel.org; mike.leach@linaro.org;
>> leo.yan@linux.dev; mark.rutland@arm.com;
>> alexander.shishkin@linux.intel.com; jolsa@kernel.org;
>> adrian.hunter@intel.com; peterz@infradead.org; mingo@redhat.com;
>> acme@kernel.org; namhyung@kernel.org; linux-tegra@vger.kernel.org; linux-
>> arm-kernel@lists.infradead.org; linux-perf-users@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Thomas Makin <tmakin@nvidia.com>; Vikram Sethi
>> <vsethi@nvidia.com>; Rich Wiley <rwiley@nvidia.com>; Sean Kelley
>> <skelley@nvidia.com>; Yifei Wan <YWan@nvidia.com>; Thierry Reding
>> <treding@nvidia.com>; Jon Hunter <jonathanh@nvidia.com>; Matt Ochs
>> <mochs@nvidia.com>
>> Subject: Re: [PATCH] perf vendor events arm64: Add Tegra410 Olympus PMU
>> events
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On 30/01/2026 6:08 pm, Besar Wicaksono wrote:
>>> Thank you James and Ian for the comments.
>>> I will try to address the spelling mistakes on v2.
>>>
>>> Please see my other comments inline.
>>>
>>>> -----Original Message-----
>>>> From: James Clark <james.clark@linaro.org>
>>>> Sent: Wednesday, January 28, 2026 3:37 AM
>>>> To: Ian Rogers <irogers@google.com>; Besar Wicaksono
>>>> <bwicaksono@nvidia.com>
>>>> Cc: john.g.garry@oracle.com; will@kernel.org; mike.leach@linaro.org;
>>>> leo.yan@linux.dev; mark.rutland@arm.com;
>>>> alexander.shishkin@linux.intel.com; jolsa@kernel.org;
>>>> adrian.hunter@intel.com; peterz@infradead.org; mingo@redhat.com;
>>>> acme@kernel.org; namhyung@kernel.org; linux-tegra@vger.kernel.org;
>> linux-
>>>> arm-kernel@lists.infradead.org; linux-perf-users@vger.kernel.org; linux-
>>>> kernel@vger.kernel.org; Thomas Makin <tmakin@nvidia.com>; Vikram
>> Sethi
>>>> <vsethi@nvidia.com>; Rich Wiley <rwiley@nvidia.com>; Sean Kelley
>>>> <skelley@nvidia.com>; Yifei Wan <ywan@nvidia.com>; Thierry Reding
>>>> <treding@nvidia.com>; Jon Hunter <jonathanh@nvidia.com>; Matt Ochs
>>>> <mochs@nvidia.com>
>>>> Subject: Re: [PATCH] perf vendor events arm64: Add Tegra410 Olympus
>> PMU
>>>> events
>>>>
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 28/01/2026 8:03 am, Ian Rogers wrote:
>>>>> On Tue, Jan 27, 2026 at 3:00 PM Besar Wicaksono
>>>> <bwicaksono@nvidia.com> wrote:
>>>>>>
>>>>>> Add JSON files for NVIDIA Tegra410 Olympus core PMU events.
>>>>>> Also updated the common-and-microarch.json.
>>>>>>
>>>>>> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
>>>>>> ---
>>>>>>     .../arch/arm64/common-and-microarch.json      |  90 +++
>>>>>>     tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
>>>>>>     .../arch/arm64/nvidia/t410/branch.json        |  45 ++
>>>>>>     .../arch/arm64/nvidia/t410/brbe.json          |   6 +
>>>>>>     .../arch/arm64/nvidia/t410/bus.json           |  48 ++
>>>>>>     .../arch/arm64/nvidia/t410/exception.json     |  62 ++
>>>>>>     .../arch/arm64/nvidia/t410/fp_operation.json  |  78 ++
>>>>>>     .../arch/arm64/nvidia/t410/general.json       |  15 +
>>>>>>     .../arch/arm64/nvidia/t410/l1d_cache.json     | 122 +++
>>>>>>     .../arch/arm64/nvidia/t410/l1i_cache.json     | 114 +++
>>>>>>     .../arch/arm64/nvidia/t410/l2d_cache.json     | 134 ++++
>>>>>>     .../arch/arm64/nvidia/t410/ll_cache.json      | 107 +++
>>>>>>     .../arch/arm64/nvidia/t410/memory.json        |  46 ++
>>>>>>     .../arch/arm64/nvidia/t410/metrics.json       | 722
>>>> ++++++++++++++++++
>>>>>>     .../arch/arm64/nvidia/t410/misc.json          | 646 ++++++++++++++++
>>>>>>     .../arch/arm64/nvidia/t410/retired.json       |  94 +++
>>>>>>     .../arch/arm64/nvidia/t410/spe.json           |  42 +
>>>>>>     .../arm64/nvidia/t410/spec_operation.json     | 230 ++++++
>>>>>>     .../arch/arm64/nvidia/t410/stall.json         | 145 ++++
>>>>>>     .../arch/arm64/nvidia/t410/tlb.json           | 158 ++++
>>>>>>     20 files changed, 2905 insertions(+)
>>>>>>     create mode 100644 tools/perf/pmu-
>>>> events/arch/arm64/nvidia/t410/branch.json
>>>>>>     create mode 100644 tools/perf/pmu-
>>>> events/arch/arm64/nvidia/t410/brbe.json
>>>>>>     create mode 100644 tools/perf/pmu-
>>>> events/arch/arm64/nvidia/t410/bus.json
>>>>>>     create mode 100644 tools/perf/pmu-
>>>> events/arch/arm64/nvidia/t410/exception.json
>>>>>>     create mode 100644 tools/perf/pmu-
>>>> events/arch/arm64/nvidia/t410/fp_operation.json
>>>>>>     create mode 100644 tools/perf/pmu-
>>>> events/arch/arm64/nvidia/t410/general.json
>>>>>>     create mode 100644 tools/perf/pmu-
>>>> events/arch/arm64/nvidia/t410/l1d_cache.json
>>>>>>     create mode 100644 tools/perf/pmu-
>>>> events/arch/arm64/nvidia/t410/l1i_cache.json
>>>>>>     create mode 100644 tools/perf/pmu-
>>>> events/arch/arm64/nvidia/t410/l2d_cache.json
>>>>>>     create mode 100644 tools/perf/pmu-
>>>> events/arch/arm64/nvidia/t410/ll_cache.json
>>>>>>     create mode 100644 tools/perf/pmu-
>>>> events/arch/arm64/nvidia/t410/memory.json
>>>>>>     create mode 100644 tools/perf/pmu-
>>>> events/arch/arm64/nvidia/t410/metrics.json
>>>>>>     create mode 100644 tools/perf/pmu-
>>>> events/arch/arm64/nvidia/t410/misc.json
>>>>>>     create mode 100644 tools/perf/pmu-
>>>> events/arch/arm64/nvidia/t410/retired.json
>>>>>>     create mode 100644 tools/perf/pmu-
>>>> events/arch/arm64/nvidia/t410/spe.json
>>>>>>     create mode 100644 tools/perf/pmu-
>>>> events/arch/arm64/nvidia/t410/spec_operation.json
>>>>>>     create mode 100644 tools/perf/pmu-
>>>> events/arch/arm64/nvidia/t410/stall.json
>>>>>>     create mode 100644 tools/perf/pmu-
>>>> events/arch/arm64/nvidia/t410/tlb.json
>>>>>>
>>>>>> diff --git a/tools/perf/pmu-events/arch/arm64/common-and-
>>>> microarch.json b/tools/perf/pmu-events/arch/arm64/common-and-
>>>> microarch.json
>>>>>> index 468cb085d879..6af15776ff17 100644
>>>>>> --- a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
>>>>>> +++ b/tools/perf/pmu-events/arch/arm64/common-and-
>> microarch.json
>>>>>> @@ -179,6 +179,11 @@
>>>>>>             "EventName": "BUS_CYCLES",
>>>>>>             "BriefDescription": "Bus cycle"
>>>>>>         },
>>>>>> +    {
>>>>>> +        "EventCode": "0x001E",
>>>>>> +        "EventName": "CHAIN",
>>>>>> +        "BriefDescription": "Chain a pair of event counters."
>>>>>> +    },
>>>>>
>>>>> Cool stuff :-)
>>>>>
>>>>> For wider counters AMD does something similar, but should this be an
>>>>> implementation detail rather than an exposed event? How does it
>>>>> operate as an event?
>>>>>
>>>>
>>>> CHAIN should be excluded from the json, it's used internally by the
>>>> driver when you want 64 bit counters. Userspace can't use it because it
>>>> can't control where counters are placed to make sure they're adjacent.
>>>>
>>>
>>> Sure, will address this in V2.
>>>
>>>>> [snip]
>>>>>> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv
>>>> b/tools/perf/pmu-events/arch/arm64/mapfile.csv
>>>>>> index bb3fa8a33496..7f0eaa702048 100644
>>>>>> --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
>>>>>> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
>>>>>> @@ -46,3 +46,4 @@
>>>>>>     0x00000000500f0000,v1,ampere/emag,core
>>>>>>     0x00000000c00fac30,v1,ampere/ampereone,core
>>>>>>     0x00000000c00fac40,v1,ampere/ampereonex,core
>>>>>> +0x000000004e0f0100,v1,nvidia/t410,core
>>>>>> diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/branch.json
>>>> b/tools/perf/pmu-events/arch/arm64/nvidia/t410/branch.json
>>>>>> new file mode 100644
>>>>>> index 000000000000..532bc59dc573
>>>>>> --- /dev/null
>>>>>> +++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/branch.json
>>>>>> @@ -0,0 +1,45 @@
>>>>>> +[
>>>>>> +    {
>>>>>> +        "ArchStdEvent": "BR_MIS_PRED",
>>>>>> +        "PublicDescription": "The Event counts Branches which are
>>>> speculatively executed and mis-predicted."
>>>>>
>>>>> nit: The capitalization on Event and Branches, as well as other words,
>>>>> is a little unusual.
>>>>>
>>>>
>>>> If there's nothing specific to this CPU then the public description
>>>> could be left out entierly. The common strings already say the same
>>>> thing as this:
>>>>
>>>>        {
>>>>            "PublicDescription": "Mispredicted or not predicted branch
>>>>                                  speculatively executed",
>>>>            "EventCode": "0x10",
>>>>            "EventName": "BR_MIS_PRED",
>>>>            "BriefDescription": "Mispredicted or not predicted branch
>>>>                                 speculatively executed"
>>>>        },
>>>>
>>>>
>>>
>>> I will check on this and other events.
> 
> James, on a second thought, the description of the events was imported from
> Olympus TRM. So just to keep my import flow simpler, if there is no major
> concern, I would prefer to keep the description as is.
> 
> Thanks
> Besar
> 

Yes I think it's fine, you're already not overwriting BriefDescription 
so it will use the common ones from common-and-microarch.json by default 
unless running in verbose mode.

