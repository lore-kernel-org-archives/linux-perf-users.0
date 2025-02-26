Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C373822171E
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581851; cv=none; b=Y0raOIg+ckZs/PdzEW16iPSCmbV7KC6uKXEAtotRQ8/8BRR1ZuLDXag9/obmyusxJrOaKxctHrcRAjEB1ePZL9UqACFL9OwWt9irsxMYG+QcgOU8/MtlqVCIBKQe6rXM89TFt3m8hXKJyU9sjJioTHcAxmHOtk0aWA0eTypwQFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581851; c=relaxed/simple;
	bh=xsQqRac3KhHAjGKeiuhAqyewKWPVXbOdO5xdk//08qM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ih7lI1h0VYbzKbS1EcLBF8Q35B+kZ0NXbmrXM0k0QICWSURUEOA0Ezhm9qvzjmv9ASralTYjNEktImuMmx6H/sN9tfbgzP7IBh4Oo3TDSY7AL2Wi7OqTXQ9++wIuGoBdlKd584kjUL/EM0Zg1Sy+G0s+RkhnfI1lJ+8rV20vFeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=md+5RwPQ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="md+5RwPQ"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f31f7732dso639912f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 06:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740581848; x=1741186648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EELEdUuYTIdIUcX+n7fUBL2a5h1Ygw+loHh/F2zSigE=;
        b=md+5RwPQTbeThdION6kJmywDd2wXp24lhsGPmEPAev1aT/LLEAY/L/a5+7AifEydua
         CE2QsfC1CoJKzmP/WdY9yZ3zkJB6XEwfQ6gfHkCMeWgIAaAadnxpjvvk+9xvd6nVZTR7
         wNSzT0Xwz4osx/htM5QAdexjILvTTgaAQGY1gALAtPsVjtHxCZ/fHbfFAy77sKQKcPLg
         rm+6W81xtE28bL4FSTax+s76H/y91CD3vYMIeFW4XuYTI2dCf51rli/u4Zi4LR+th023
         I6tZ6TwaVCFCw3od2vO1MwaTKQ64ewppOtLgMMyKOamk8+bYQOa2N9tlIHuUZyNu5Iq1
         8jsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740581848; x=1741186648;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EELEdUuYTIdIUcX+n7fUBL2a5h1Ygw+loHh/F2zSigE=;
        b=NfkrLMYS3RGnQV0o6cvfAfAhHAXKWXaggxvIXyDRzJb/pZygWpg7gU7M+eXx7LgOGA
         0goGVZDaMEpUu7NemjlMEOaxQwHV11EsD+RRPN4+DwYGgfWKDnrptnW76m0Q/0jkCNU3
         ShG0l+Jk0tU3VMquAPc+CTTYFeAH+XCiQfd7nLgIgQrS0eMdYtNCrGreTU+BHd0kK8rE
         /qE2zQdtBegbcY70Odi9qE9fAxRx3wCFOYwarlA7ffE0amFzI6wzZuJArLfZnyDuG6/F
         iyMBkmfWimlLnNMIuqPgu++NwGaXKAGx4n3traYqgYh7PQKhTHLIGEGqkAlmKVzPR1r/
         yG4Q==
X-Gm-Message-State: AOJu0YyqmRBPyoCjwKUwfhLJkSi2zgXbxPmOazs9V4F53Luxh7/5M/e2
	4DrrsRCOc3YVjecxLT89BhJR6YUKRc4BMhrJNJ1uZWchl+5US35ejf5FEcYWZ1c=
X-Gm-Gg: ASbGncuvLzLxDdG+M0dWk5HksVFu1wSXuizzs35uwkJXQO5OuFae56GKsujxlTU9wRB
	URvvPlb4KfhR+E1AIvf7KIJBviLR/K50X2TzQ6tv4BiwxEr19L/S2eo42nSJCnzTl+N12aelb9w
	+9JHV6JOJgFqx+2w0UxCNRle28WA+KVU/Vz3bhutuM0lv5zi+SuiBjpCwXHuW5BuK5wRRNJev61
	fk6FNZOjwHdy18cV21u9U2TyWRL5E18E+RpeZLJJFQGb8U+8hr30sUgABHkCjB78tOkNz/Pd72k
	RnYetYmv8yXk44CD9CugaxdFSZo0G+32dw==
X-Google-Smtp-Source: AGHT+IHKv4qghuGYkCaZpHLDagHbYH6knF8B9qQyOzogc+5no/W9/ycCRhfOa51vJUPRsJWoSYDF2A==
X-Received: by 2002:a05:6000:1888:b0:388:c61d:4415 with SMTP id ffacd0b85a97d-38f6f515211mr18005127f8f.18.1740581848061;
        Wed, 26 Feb 2025 06:57:28 -0800 (PST)
Received: from [192.168.1.247] ([145.224.66.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd882644sm5779464f8f.42.2025.02.26.06.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 06:57:27 -0800 (PST)
Message-ID: <f2f19e27-907c-4af5-88c6-88e02fbb2e15@linaro.org>
Date: Wed, 26 Feb 2025 14:57:26 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf stat: Fix non-uniquified hybrid legacy events
From: James Clark <james.clark@linaro.org>
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, Robin.Murphy@arm.com,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20250212122413.1184503-1-james.clark@linaro.org>
 <CAP-5=fWywDB40-RgV8LaPqsoffOLdDcYkUB_LHoPvV=R8yas4w@mail.gmail.com>
 <CAP-5=fV0rWEL-ewGpoDwaJ3rvbTPXSx0YTuF5p9=6+h5oUhsfg@mail.gmail.com>
 <c672c3a3-64e3-495a-ae61-ae098d30c6b9@linaro.org>
 <Z66b9-I_MkmX7pg5@google.com>
 <6c9d8c3a-d5f7-4b88-9dda-74b9b3d4484c@linaro.org>
Content-Language: en-US
In-Reply-To: <6c9d8c3a-d5f7-4b88-9dda-74b9b3d4484c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14/02/2025 10:45 am, James Clark wrote:
> 
> 
> On 14/02/2025 1:27 am, Namhyung Kim wrote:
>> Hello,
>>
>> On Thu, Feb 13, 2025 at 12:15:30PM +0000, James Clark wrote:
>>>
>>>
>>> On 12/02/2025 9:38 pm, Ian Rogers wrote:
>>>> On Wed, Feb 12, 2025 at 9:48 AM Ian Rogers <irogers@google.com> wrote:
>>>>>
>>>>> On Wed, Feb 12, 2025 at 4:24 AM James Clark 
>>>>> <james.clark@linaro.org> wrote:
>>>>>>
>>>>>> Legacy hybrid events have attr.type == PERF_TYPE_HARDWARE, so they 
>>>>>> look
>>>>>> like plain legacy events if we only look at attr.type. But legacy 
>>>>>> events
>>>>>> should still be uniquified if they were opened on a non-legacy PMU.
>>>>>> Previously we looked at the PMU type to determine legacy vs hybrid
>>>>>> events here so revert this particular check to how it was before the
>>>>>> linked fixes commit.
>>>>>>
>>>>>> counter->pmu doesn't need to be null checked twice, in fact it is
>>>>>> required for any kind of uniquification so make that a separate 
>>>>>> check.
>>>>>>
>>>>>> This restores PMU names on hybrid systems and also changes "perf stat
>>>>>> metrics (shadow stat) test" from a FAIL back to a SKIP (on 
>>>>>> hybrid). The
>>>>>> test was gated on "cycles" appearing alone which doesn't happen on
>>>>>> here.
>>>>>>
>>>>>> Before:
>>>>>>
>>>>>>     $ perf stat -- true
>>>>>>     ...
>>>>>>        <not counted>      instructions:u                           
>>>>>> (0.00%)
>>>>>>              162,536      instructions:u            # 0.58  insn 
>>>>>> per cycle
>>>>>>     ...
>>>>>>
>>>>>> After:
>>>>>>
>>>>>>    $ perf stat -- true
>>>>>>    ...
>>>>>>        <not counted>      cpu_atom/instructions/u                  
>>>>>> (0.00%)
>>>>>>              162,541      cpu_core/instructions/u   # 0.62  insn 
>>>>>> per cycle
>>>>>>    ...
>>>>>>
>>>>>> Fixes: 357b965deba9 ("perf stat: Changes to event name 
>>>>>> uniquification")
>>>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>>>> ---
>>>>>>    tools/perf/util/stat-display.c | 9 +++++++--
>>>>>>    1 file changed, 7 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/ 
>>>>>> stat-display.c
>>>>>> index e65c7e9f15d1..eae34ba95f59 100644
>>>>>> --- a/tools/perf/util/stat-display.c
>>>>>> +++ b/tools/perf/util/stat-display.c
>>>>>> @@ -1688,12 +1688,17 @@ static void 
>>>>>> evsel__set_needs_uniquify(struct evsel *counter, const struct perf_s
>>>>>>                   return;
>>>>>>           }
>>>>>>
>>>>>> -       if  (counter->core.attr.type < PERF_TYPE_MAX && counter- 
>>>>>> >core.attr.type != PERF_TYPE_RAW) {
>>>>>> +       if (!counter->pmu) {
>>>>>
>>>>> Thanks James, I wish I had a hybrid laptop so I didn't keep breaking
>>>>> things like this. I'm uncomfortable using an evsel having/not-having a
>>>>> PMU as an indication of whether uniquification is necessary. It is
>>>>> kind of a side-effect of parsing whether the PMU variable is non-NULL,
>>>>> it'd kind of be nice to stop things using `evsel->pmu` directly and
>>>>> switch them to `evsel__find_pmu(evsel)`, in the future maybe legacy
>>>>> events will get the core PMU, a tracepoint PMU, etc. so we'd never
>>>>> expect this variable to be NULL.
>>>
>>> As it stands evsel__uniquify_counter() unconditionally dereferences
>>> evsel->pmu which is why I thought it made sense to check that first. 
>>> But if
>>> that might change then fair enough.
>>>
>>>>>
>>>>> Your commit message gives me enough to think about what the issue is,
>>>>> so let me give it some thought.
>>>>
>>>> I wonder we should just hoist the hybrid test earlier:
>>>> ```
>>>> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat- 
>>>> display.c
>>>> index e65c7e9f15d1..e852ac0d9847 100644
>>>> --- a/tools/perf/util/stat-display.c
>>>> +++ b/tools/perf/util/stat-display.c
>>>> @@ -1688,6 +1688,12 @@ static void evsel__set_needs_uniquify(struct
>>>> evsel *counter, const struct per
>>>> f_s
>>>>                  return;
>>>>          }
>>>>
>>>> +       if (!config->hybrid_merge && evsel__is_hybrid(counter)) {
>>>> +               /* Unique hybrid counters necessary. */
>>>> +               counter->needs_uniquify = true;
>>>> +               return;
>>>> +       }
>>>> +
>>>>          if  (counter->core.attr.type < PERF_TYPE_MAX &&
>>>> counter->core.attr.type != PERF_TYPE_RAW) {
>>>>                  /* Legacy event, don't uniquify. */
>>>>                  return;
>>>> @@ -1705,12 +1711,6 @@ static void evsel__set_needs_uniquify(struct
>>>> evsel *counter, const struct per
>>>> f_s
>>>>                  return;
>>>>          }
>>>>
>>>> -       if (!config->hybrid_merge && evsel__is_hybrid(counter)) {
>>>> -               /* Unique hybrid counters necessary. */
>>>> -               counter->needs_uniquify = true;
>>>> -               return;
>>>> -       }
>>>> -
>>>>          /*
>>>>           * Do other non-merged events in the evlist have the same 
>>>> name? If so
>>>>           * uniquify is necessary.
>>>>
>>>> ```
>>>>
>>>> The hybrid test is unfortunately expensive at it needs to search for
>>>>> 1 core PMU, which means loading all sysfs PMUs. I think we're already
>>>> paying the cost though.

Yeah perf_pmus__num_core_pmus() has already been called by this point, 
even if doing something like opening the event on a single PMU so I 
think it's fine.

>>>>
>>>> Could you check this works James?
>>>>
>>>> Thanks,
>>>> Ian
>>>>
>>>
>>> Yep that works too.
>>
>> James, can I take it as your Tested-by?
>>
> 
> Yep sure
> 
>> Ian, can you please send a formal patch with that?
>>
>> Thanks,
>> Namhyung
>>
> 

I just noticed that there wasn't another patch so I sent the V2.


