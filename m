Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D271428F1;
	Mon, 22 Jul 2024 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660953; cv=none; b=uVwjLqnDDTMxT0KWyA4vcMRthhY6MHzzY2l5/cdkOgvISkr3+OtjtN4pNCfGTvHSs7fR6bs65SlQZRn5G5UUWzRyV5eIs8noEBgvTk2aY3xibYgv7qk+aFJCaum5AAwTfHRMmJX8dJ+2j8SY0t4lfU457C0a3piv5uGIVsdaSic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660953; c=relaxed/simple;
	bh=Hfv9+kZfD60RQzK59bj8xQyH0gZc0y+O4A+egPOKYkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q3qmD0IyDXg19MvtMI3kpSDZY2S8jWFCmQDvOGHJw/jgo66Vn0Qxta/MGbrwcxQF51AKz0VDXW4Lm09ooOzcztw+3OWS77ZAAteVFgkVVKl3YoLvaWKhlmWk8wz7v6EER4BULmAL8PgTlF8O4Ph4xMrQeNTl/gE3jhUu5dX5r28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EF20FEC;
	Mon, 22 Jul 2024 08:09:36 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC4783F5A1;
	Mon, 22 Jul 2024 08:09:08 -0700 (PDT)
Message-ID: <9f301b09-e040-456c-9bd3-6d5e96ebc8f4@arm.com>
Date: Mon, 22 Jul 2024 16:09:07 +0100
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
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <9f08c5cb-fb4b-4994-9128-0484aa6c06d7@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/24 12:13, Adrian Hunter wrote:

[...]

> On 21/07/24 23:21, Leo Yan wrote:
>> When finished to read AUX trace data from mmaped buffer, based on the
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
>>
>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>> ---
>>   tools/perf/util/auxtrace.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
>> index e2f317063eec..95be330d7e10 100644
>> --- a/tools/perf/util/auxtrace.c
>> +++ b/tools/perf/util/auxtrace.c
>> @@ -670,18 +670,25 @@ static int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel,
>>   int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
>>   {
>>        struct evsel *evsel;
>> +     int ret = -EINVAL;
>>
>>        if (!itr->evlist || !itr->pmu)
>>                return -EINVAL;
>>
>>        evlist__for_each_entry(itr->evlist, evsel) {
>> -             if (evsel->core.attr.type == itr->pmu->type) {
>> +             if (evsel__is_aux_event(evsel)) {
> 
> If the type is the same, then there is no need to
> change the logic here?

No, the type is not same for AUX events. Every event has its own type
value, this is likely related to recent refactoring.

As a result, 'itr->pmu' only maintains the first registered AUX event,
comparing to it the tool will find _only_ one AUX event. This is why here
changes to use the evsel__is_aux_event() to detect AUX event.

> Otherwise, maybe that should be a separate patch

Could you explain what is a separate patch for?

After this change, the field 'itr->pmu' will be redundant (at least this
is the case for Arm SPE). I am preparing a refactoring patches for cleaning up
and see if can totally remove the field 'itr->pmu' (if all AUX events
have no issue.

> 
>>                        if (evsel->disabled)
>> -                             return 0;
>> -                     return evlist__enable_event_idx(itr->evlist, evsel, idx);
>> +                             continue;
>> +                     ret = evlist__enable_event_idx(itr->evlist, evsel, idx);
>> +                     if (ret >= 0)
> 
> Should this be:
> 
>                          if (ret < 0)

Here the logic is to iterate all AUX events, even if an AUX event fails to
find the buffer index, it will continue to next AUX event.

So it directly bails out for success (as we have found the matched AUX
event and enabled it). For the failure cause, it will continue for checking
next event - until all events have been checked and no event is matched
for buffer index, the failure will be handled at the end of the function.

Thanks,
Leo

> 
>> +                             return ret;
> 
> And will need a common error path for the pr_err() below.
> 
>>                }
>>        }
>> -     return -EINVAL;
>> +
>> +     if (ret < 0)
>> +             pr_err("Failed to event enable event (idx=%d): %d\n", idx, ret);
>> +
>> +     return ret;
>>   }
>>
>>   /*
> 
