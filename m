Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6851CA84;
	Mon, 22 Jul 2024 20:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721681577; cv=none; b=LdTPUU7r5ZZ9xEsh4gnIfEffOrCR45vNJnyjzQcq/gRtwHAsSJ7+WZ/abr6EPILXn/IDYgiHWSGF6dS3PAACv+jOQ5DStNVVFp30FhxNcbelbZb8KOhy1L26RkGX2sUQaxx31xJfhk5JHQfBj+kZOBFr/6uicpKDx6OrqIbVSS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721681577; c=relaxed/simple;
	bh=RmHuyXP/6xE6ldcEsFfQfJ2Bk5xSkbeaBLt/u+qQE80=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GLkL25Z/uJE76piiCs2eyKOw0OBx3hwzANupR70izav6YLv5OATiMB6ngjKadjLzOILJQKISm6YvBlSmRClHpB8AvGPJcwCAI59Qzb0WAX9rfOQQ/J+LG9FY4oaPak43tJXU5ODWiEYpLep/Vzt/o/Vv1jGgC6OwhoyT0l2otjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 529CC1007;
	Mon, 22 Jul 2024 13:53:13 -0700 (PDT)
Received: from [10.57.12.31] (unknown [10.57.12.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C4A53F5A1;
	Mon, 22 Jul 2024 13:52:45 -0700 (PDT)
Message-ID: <951fc660-58a2-4b8a-a763-5a1e4d807c75@arm.com>
Date: Mon, 22 Jul 2024 21:52:34 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/6] perf auxtrace: Iterate all AUX events when finish
 reading
To: Adrian Hunter <adrian.hunter@intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240721202113.380750-1-leo.yan@arm.com>
 <20240721202113.380750-5-leo.yan@arm.com>
 <9f08c5cb-fb4b-4994-9128-0484aa6c06d7@intel.com>
 <9f301b09-e040-456c-9bd3-6d5e96ebc8f4@arm.com>
 <1cb6fdfc-0405-4bfb-acd4-ed3b24744c8b@intel.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <1cb6fdfc-0405-4bfb-acd4-ed3b24744c8b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/2024 4:59 PM, Adrian Hunter wrote:

[...]

>>>> @@ -670,18 +670,25 @@ static int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel,
>>>>   int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
>>>>   {
>>>>        struct evsel *evsel;
>>>> +     int ret = -EINVAL;
>>>>
>>>>        if (!itr->evlist || !itr->pmu)
>>>>                return -EINVAL;
>>>>
>>>>        evlist__for_each_entry(itr->evlist, evsel) {
>>>> -             if (evsel->core.attr.type == itr->pmu->type) {
>>>> +             if (evsel__is_aux_event(evsel)) {
>>>
>>> If the type is the same, then there is no need to
>>> change the logic here?
>>
>> No, the type is not same for AUX events. Every event has its own type
>> value, this is likely related to recent refactoring.
>>
>> As a result, 'itr->pmu' only maintains the first registered AUX event,
>> comparing to it the tool will find _only_ one AUX event. This is why here
>> changes to use the evsel__is_aux_event() to detect AUX event.
>>
>>> Otherwise, maybe that should be a separate patch
>>
>> Could you explain what is a separate patch for?
> 
> No need.
> 
>>
>> After this change, the field 'itr->pmu' will be redundant (at least this
>> is the case for Arm SPE). I am preparing a refactoring patches for cleaning up
>> and see if can totally remove the field 'itr->pmu' (if all AUX events
>> have no issue.
> 
> For this function, 'itr->pmu' could be removed in this patch
> since it is not used anymore.

Thanks for confirmation. I will use a separate patch for removing 'itr-pmu'
after it is not used anymore.

>>>>                        if (evsel->disabled)
>>>> -                             return 0;
>>>> -                     return evlist__enable_event_idx(itr->evlist, evsel, idx);
>>>> +                             continue;
>>>> +                     ret = evlist__enable_event_idx(itr->evlist, evsel, idx);
>>>> +                     if (ret >= 0)
>>>
>>> Should this be:
>>>
>>>                          if (ret < 0)
>>
>> Here the logic is to iterate all AUX events, even if an AUX event fails to
>> find the buffer index, it will continue to next AUX event.
>>
>> So it directly bails out for success (as we have found the matched AUX
>> event and enabled it). For the failure cause, it will continue for checking
>> next event - until all events have been checked and no event is matched
>> for buffer index, the failure will be handled at the end of the function.
> 
> Thanks for the explanation. Could probably use a small comment.

Will do.

Thanks,
Leo
