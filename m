Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1231516EC07;
	Wed, 29 May 2024 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716994257; cv=none; b=iOK84W34ED2Dh3aGpEjj8CSzeHhmo3qpTkaDd0sprZerQlr53318qBCU+PmEXwxtyEXMiDT7p1QAE97MMmm+uq7IEcDEBhmnTKyapqQOQCMlf9fKKlTIL4c9CMdrSdGjudNSSNtJPlnlnrvkfoFbsk4Paw1kHAii6rKXQ0h/pmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716994257; c=relaxed/simple;
	bh=LZaXZ+xxvmullqXtZhX9G/679yX+VtdAB8/kH3qPkiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGKsIFwDyd4Snv6m5pcdbJhmYyxt0nHt817rhVfC0SPpjRMUAmAzU8moCuTf7MHG21SZUt3DbLEtJP0UptkIU9f4b2W8RvX/Lgs1MIiwRYwKJMSQ86OOTZFEKHfzy1Bsjyd9uYjr2+58NnCq9yMR6lWUYrm2f2Y4D3ehuBNMbQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42D11339;
	Wed, 29 May 2024 07:51:18 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A42F3F762;
	Wed, 29 May 2024 07:50:51 -0700 (PDT)
Message-ID: <d79b18d7-6930-41fd-8157-eaa55b52df86@arm.com>
Date: Wed, 29 May 2024 15:50:53 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core
 PMUs
To: Ian Rogers <irogers@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Leo Yan <leo.yan@linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240525152927.665498-1-irogers@google.com>
 <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
 <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com>
 <20240527105842.GB33806@debian-dev>
 <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>
 <ZlY0F_lmB37g10OK@x1>
 <CAP-5=fWM8LxrcR4Nf+e2jRtJ-jC0Sa-HYPf56pU5GW8ySdX1CQ@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fWM8LxrcR4Nf+e2jRtJ-jC0Sa-HYPf56pU5GW8ySdX1CQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 28/05/2024 20:51, Ian Rogers wrote:
> On Tue, May 28, 2024 at 12:44 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
>>
>> On Mon, May 27, 2024 at 10:36:45PM -0700, Ian Rogers wrote:
>>> On Mon, May 27, 2024 at 3:58 AM Leo Yan <leo.yan@linux.dev> wrote:
>>>> On Sat, May 25, 2024 at 02:14:26PM -0700, Linus Torvalds wrote:
>>>>> On Sat, 25 May 2024 at 09:43, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>
>>>>>> This makes 'perf record' work for me again.
>>
>>>>> Oh, wait, no it doesn't.
>>
>>>>> It makes just the plain "perf record" without any arguments work,
>>>>> which was what I was testing because I was lazy.
>>
>>>>> So now
>>
>>>>>     $ perf record sleep 1
>>
>>>>> works fine. But
>>
>>>>>     $ perf record -e cycles:pp sleep 1
>>
>>>>> is still completely broken (with or without ":p" and ":pp").
>>
>>>> Seems to me that this patch fails to check if a PMU is a core-attached
>>>> PMU that can support common hardware events. Therefore, we should
>>>> consider adding the following check.
>>
>>>> +++ b/tools/perf/util/parse-events.c
>>>> @@ -1594,6 +1594,9 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
>>>>         while ((pmu = perf_pmus__scan(pmu)) != NULL) {
>>>>                 bool auto_merge_stats;
>>>>
>>>> +               if (hw_config != PERF_COUNT_HW_MAX && !pmu->is_core)
>>>> +                       continue;
>>>> +
>>>>                 if (parse_events__filter_pmu(parse_state, pmu))
>>>>                         continue;
>>
>>>> To be clear, I only compiled this change but I have no chance to test
>>>> it. @Ian, could you confirm this?
>>
>>> Hi Leo,
>>
>>> so the code is working as intended. I believe it also agrees with what
>>> Arnaldo thinks.
>>
>>> If you do:
>>
>>> $ perf stat -e cycles ...
>>
>>> and you have
>>
>>> /sys/devices/pmu1/events/cycles
>>> /sys/devices/pmu2/events/cycles
>>
>>> The output of perf stat should contain counts for pmu1 and pmu2. Were
>>> the event 'data_read' or 'inst_retired.any' we wouldn't be having the
>>
>> Sure, what is being asked is to count events and if those two events in
>> those two PMUs can count, then do what the user asked.
>>
>> For 'perf record' we're asking for sampling, if the event has the name
>> specified and can't be sampled, skip it, warn the user and even so
>> only if verbose mode is asked, something like:
>>
>>   root@x1:~# perf record -e cycles -a sleep 1
>>   [ perf record: Woken up 1 times to write data ]
>>   [ perf record: Captured and wrote 1.998 MB perf.data (4472 samples) ]
>>   root@x1:~# perf evlist
>>   cpu_atom/cycles/
>>   cpu_core/cycles/
>>   dummy:u
>>   root@x1:~#
>>
>> Cool, there are two 'cycles' events, one in a PMU named 'cpu_atom',
>> another in a 'cpu_core' one, both can be sampled, my workload may
>> run/use resources on then, I'm interested, sample both.
>>
>> But if we had some other PMU, to use a name Jiri uses in tests/fake
>> PMUs, the 'krava' PMU and it has a 'cycles' event, so 'krava/cycles/'
>> and for some reason it doesn't support sampling, skip it, then the
>> result should be the same as above.
>>
>> If the user finds it strange after looking at sysfs that 'krava/cycles/'
>> isn't being sampled, the usual workflow is to ask perf for more
>> verbosity, using -v (or multiple 'v' letters to get increasing levels of
>> verbosity), in which case the user would see:
>>
>>   root@x1:~# perf record -v -e cycles -a sleep 1
>>   WARNING: skipping 'krava/cycles/' event, it doesn't support sampling.
>>   [ perf record: Woken up 1 times to write data ]
>>   [ perf record: Captured and wrote 1.998 MB perf.data (4472 samples) ]
>>   root@x1:~# perf evlist

This makes sense to me. I like keeping the old apparent behavior unless
-v is used and it will feel like the tool "just works".

In the context of the commit summary "perf parse-events: Prefer
sysfs/JSON hardware events over legacy":

I don't follow why that should be "Prefer, even if it's an event that
can't be opened, sysfs/JSON...".

Surely it should be "Prefer sysfs/JSON, unless it can't be opened, then
use legacy". If all events can be opened, sure go and open them all. If
only core events can be opened, do that too. If only uncore events can
be opened... etc.

I'm happy to help with the implementation or testing of that on my
big.LITTLE system.

FWIW the hybrid stuff with Perf stat is already working well for me on
Arm since we added PERF_PMU_CAP_EXTENDED_HW_TYPE which Ian suggested.

> 
> The problem here is that we're hiding a problem rather than reporting
> it. Typically we report the issue and more than that we ask the user
> to work around the issue. That would be analogous to wanting the user
> to specify what PMU they want the event to apply to, which has always
> been perf's behavior.
> 

Is the problem you are referring to that there are multiple PMUs with
'cycles' events? Surely that's only a problem in the context of the new
proposed behavior, otherwise it's not really a problem. It's just
something that happens to exist.

Because the user could always use the defaults (no argument) or -e
cycles and historically Perf correctly picked the one that could be
opened. Or if they want the DSU one they could specify it. That can all
still work _and_ we can support "prefer sysfs/JSON" as long as we don't
prefer it when opening the event doesn't work.

Thanks
James

> Thanks,
> Ian
> 
>> - Arnaldo
