Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079FD8C1F;
	Wed, 10 Dec 2025 02:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765333386; cv=none; b=oDPdLTmORZKuM6EfVxQPnm4k3kVLWeHIyQ5JlkQJAmIRyaAKOewKy8Hn+2iHG3/xjdH1MItLW+u1ga/v1boEj6pZk7/vbZsaimPE02t6gm4cj/BONjAbk2/m0N1w/QJRWsjhSuq8jWSTunzb/XE1wgHur0osSwtyRpi8VtUYjf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765333386; c=relaxed/simple;
	bh=sVLlNjrqsAQvsnZWpv/v5jhk8lgaxzA7YqtWl/vVXoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3S90T4VSBP4s+PzMwbJAaFjHmZ7cQjAKnK5JJoE95xpHaM+UG7uIbiCMlqQjJAF5uRLSwfQk4CRpg5C3Z3OXW7bTm75X3061F1TNimeQ/ZJWK773OsyaGt7AUGdL8Jqg7bKSYyKiD5WspVbHjttvEk85yNXWCNI9Ypoh0e22f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDD36175D;
	Tue,  9 Dec 2025 18:22:52 -0800 (PST)
Received: from [10.164.18.52] (unknown [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7E383F7A6;
	Tue,  9 Dec 2025 18:22:54 -0800 (PST)
Message-ID: <d39d633c-a009-41ba-8546-1137509cf678@arm.com>
Date: Wed, 10 Dec 2025 07:52:51 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/19] perf: cs-etm: Set watermark for AUX trace
To: James Clark <james.clark@linaro.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Leo Yan <leo.yan@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Tamas Petz <tamas.petz@arm.com>, Tamas Zsoldos <tamas.zsoldos@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
 <20251201-trbe_buffer_refactor_v1-1-v1-19-7da32b076b28@arm.com>
 <c22b084b-3853-405d-8b43-397786af7be9@arm.com>
 <5ebf1743-b01c-4664-961c-9e1e2aa7ffce@linaro.org>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <5ebf1743-b01c-4664-961c-9e1e2aa7ffce@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 09/12/25 8:24 PM, James Clark wrote:
> 
> 
> On 05/12/2025 4:48 am, Anshuman Khandual wrote:
>> On 01/12/25 4:52 PM, Leo Yan wrote:
>>> The default watermark is half of the total buffer size. In many cases,
>>> the tool can not be notified with sufficient free space, especially when
>>> profiling with small AUX buffer (e.g., 64KiB).
>>
>> Could not smaller AUX buffer be prevented for TRBE instead ?
>>
> 
> It's not really about the size of the buffer but where the wakeup points are. With only two wakeup points (middle and end) once you pass the first one you are immediately into the last chance end section.
> 
> Now the driver is writing into the end section, but Perf is still reading from the first one. Once the end one fills up, you end up with no space left without Perf having a chance to say it's finished reading.

Understood.

> 
> To guarantee free space, there needs to be at least one additional section as a buffer zone. Ideally we'd set the wakeup point at thirds so there were fewer wakeups and still have one free section, but it might not always divide by 3, so 4 is also fine.
> 
> The commit message could probably explain it a bit better though.

Agreed, the commit message should explain this problem in detail. Otherwise it appeared
as if the buffer sizing alone is impacting the perf records collection.

> 
> The reason this is different now is because we want to be able to enable wrap mode as much as possible. If you imagine the scenario where a half way watermark is hit, you can't enable wrap mode without wrapping into Perf's part of the buffer (the beginning) as it's all that's left after the second half.

Got it.

> 
>>>> Setting watermark to quarter of the buffer to notifies the tool to read
>>> data earlier and prevents the data loss.
>>>
>>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>>> ---
>>>   tools/perf/arch/arm/util/cs-etm.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
>>> index ea891d12f8f40beebf8dee1d3db71cad701f5666..649b8b0d0f92b4af45fb97db9da3c5ccf24a978b 100644
>>> --- a/tools/perf/arch/arm/util/cs-etm.c
>>> +++ b/tools/perf/arch/arm/util/cs-etm.c
>>> @@ -424,6 +424,13 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>>>           pr_debug2("%s snapshot size: %zu\n", CORESIGHT_ETM_PMU_NAME,
>>>                 opts->auxtrace_snapshot_size);
>>>   +    if (!opts->auxtrace_snapshot_mode && !opts->auxtrace_sample_mode) {
>>> +        size_t aw = opts->auxtrace_mmap_pages * (size_t)page_size / 4;
>>> +        u32 aux_watermark = aw > UINT_MAX ? UINT_MAX : aw;
>>> +
>>> +        cs_etm_evsel->core.attr.aux_watermark = aux_watermark;
>>> +    }
>>> +
>>>       /*
>>>        * To obtain the auxtrace buffer file descriptor, the auxtrace
>>>        * event must come first.
>>>
>>
> 

