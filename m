Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1002C328B6
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 08:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722242936; cv=none; b=uykl/t0I3WsW4juiS5GT1yV68+/t5/uez6iyBe8386Im/Pjvuy8rraldp4lxcO8ztgOx3rrs1q+MNDQNQuCLur4BEXd5AbBxV/c9UqE6kCVRQ8MUK2ZLimCKAkyPsEyehYqgXyzKLso8/loEYhFQ7MfSASigqAuD8B9TaEjuoGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722242936; c=relaxed/simple;
	bh=86QIq1o6IK2Na9jWAMBiLwSVNgQInMEUpJB/YL/BaPc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=T1A6YwPsgu343uSM026i5FBapu2HZuiqI1E87WtKQJQlMIUK5SeaZqOa8zxLZknbORHb4LIvnm/WOl+0PZXXH5C9VFW4yOoSjJLaX1TPbKtf7gau/T7f0RPI7E6xBZSOg0rn4iu0NQKLvtXg1tidX5kahrL/G/qbbHmfiaiWw78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E420FEC;
	Mon, 29 Jul 2024 01:49:18 -0700 (PDT)
Received: from [10.1.30.18] (PF4Q20KV.arm.com [10.1.30.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2C3B3F766;
	Mon, 29 Jul 2024 01:48:50 -0700 (PDT)
Message-ID: <20d8889f-fed1-4642-9baa-c86228d394f7@arm.com>
Date: Mon, 29 Jul 2024 09:48:57 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH v2 1/4] perf auxtrace: Iterate all AUX events when finish
 reading
To: Adrian Hunter <adrian.hunter@intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 John Garry <john.g.garry@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org
References: <20240725064620.1651819-1-leo.yan@arm.com>
 <20240725064620.1651819-2-leo.yan@arm.com>
 <bb8e5202-bffa-4cd6-b49c-6372d51b405b@intel.com>
Content-Language: en-US
In-Reply-To: <bb8e5202-bffa-4cd6-b49c-6372d51b405b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/2024 4:40 PM, Adrian Hunter wrote:
> On 25/07/24 09:46, Leo Yan wrote:
>> When finished to read AUX trace data from mmaped buffer, based on the
> 
> Here and elsewhere 'mmapped' is more common than 'mmaped' so maybe:
> 
>         mmaped -> mmapped

Will fix.

>> AUX buffer index the core layer needs to search the corresponding PMU
>> event and re-enable it to continue tracing.
>>
>> However, current code only searches the first AUX event. It misses to
>> search other enabled AUX events, thus, it returns failure if the buffer
>> index does not belong to the first AUX event.
>>
>> This patch extends the auxtrace_record__read_finish() function to
>> search for every enabled AUX events, so all the mmaped buffer indexes
>> can be covered.
> 
> Looking at this again, a couple more things came to mind - see below.
> 
>>
>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>> ---
>>  tools/perf/util/auxtrace.c | 25 ++++++++++++++++++++-----
>>  1 file changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
>> index b99e72f7da88..61835a6a9ea3 100644
>> --- a/tools/perf/util/auxtrace.c
>> +++ b/tools/perf/util/auxtrace.c
>> @@ -670,18 +670,33 @@ static int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel,
>>  int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
>>  {
>>       struct evsel *evsel;
>> +     int ret = -EINVAL;
>>
>> -     if (!itr->evlist || !itr->pmu)
>> +     if (!itr->evlist)
>>               return -EINVAL;
>>
>>       evlist__for_each_entry(itr->evlist, evsel) {
>> -             if (evsel->core.attr.type == itr->pmu->type) {
>> +             if (evsel__is_aux_event(evsel)) {
>>                       if (evsel->disabled)
>> -                             return 0;
>> -                     return evlist__enable_event_idx(itr->evlist, evsel, idx);
>> +                             continue;
> 
> That will make the evsel->disabled case an error, which
> might be a problem. Possibly the event can be disabled
> (e.g. via control fifo) but still have data to read out.

If so, we need to extend evlist__enable_event_idx() or create a new function
to check if the memory index is belonged to an evsel. If the idx is found for
an evsel, then we can check the evsel->disabled flag.

>> +                     /*
>> +                      * Multiple AUX events might be opened in a session.
>> +                      * Bail out for success case as the AUX event has been
>> +                      * found and enabled, otherwise, continue to check if
>> +                      * the next AUX event can cover the mmaped buffer with
>> +                      * 'idx'.
>> +                      */
> 
> Thinking about this some more, raised some questions:
> 
> How do we know there is only one AUX event per mmap?

On my test platform, there have two Arm SPE events, the first one's cpumask is
2-5 and the second SPE's cpumask is 6-7. The AUX events do not intersect CPU
maps. Therefore, a mmapped AUX buffer only binds to a AUX event.

I think we can add a checking in the function record__auxtrace_init(). After
it calls auxtrace_record__init(), we can report failure if the AUX events have
the overlapped cpumask.

> They would have to be on different CPUs for that to be true?

Yes.

> And wouldn't --per-thread have all AUX events in every mmap?

Before I roughly tested '--per-thread' mode and did not see issue. But this
time I tested '--per-thread' mode and found the failure by the kernel checking
[1] - it does not allow the different AUX events to bind to the same FD.

Here I need to dig a bit for two options, either we need to fix the perf
tool to open multiple AUX events for '--per-thread' mode, or remove the
kernel's checking to allow different AUX events to bind to same FD.

Thanks a lot for review!

Leo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/events/core.c#n12348

>> +                     ret = evlist__enable_event_idx(itr->evlist, evsel, idx);
>> +                     if (ret >= 0)
>> +                             return ret;
>>               }
>>       }
>> -     return -EINVAL;
>> +
>> +     /* Failed to find an event for the buffer 'idx' */
>> +     if (ret < 0)
>> +             pr_err("Failed to enable event (idx=%d): %d\n", idx, ret);
>> +
>> +     return ret;
>>  }
>>
>>  /*
> 
