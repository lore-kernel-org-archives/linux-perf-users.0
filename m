Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44FD15383A
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739448935; cv=none; b=qvYpdvITXAXX49FX+djwTTO823t66LJ4Vfk8A+WJrPtAfjcBPVsh+mQy3OuYWVIed7RpkFUhfiiBs9/UAiVUF09ls4cqTnYUmt8nXtfY8UM76vaqSgMjajgLwnaQVJXGpeYUBy7Aa3DG+l4++1Vxr1TKIb5lm+SU1DpuWHclBzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739448935; c=relaxed/simple;
	bh=jag+z3Nlin3BEoXhQljWEkAWQtC4a+x/4/Qxq7EiIWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=td02sxCOO7mF7JtOlSro3QRhbOSSQiVHVOhIT/Rdwd6dJ4de6lxu3G7e+RXPzfh9C22yBzB/509AE+x6kBO18rgplGn1IvDfZJU0j7iqTzYc7XyncIIFUhAXr6QoPTxqCUmCZf3Cu3t3FDUrmfEc6D5+yBMqXeEiL2JimWMj/1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VhWOzmf9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VhWOzmf9"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43963935585so4530525e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 04:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739448932; x=1740053732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lHgN7iB61XVi5I00SQD99LSvj00C3O7HCL3uRtcvTOY=;
        b=VhWOzmf95AKtR3XQuHgxTsIhTBA4/Bye4MiMC2cYD6UpMfQE9kVQrau/d3ye7X36tn
         B8Ldfk16JmbGvd11dpHnjBtl2pvw7B7jRGw+AFVTm1npIbPYv7OxnTELh9xhNdbTt1bU
         4EiTI3to5xZtDGo/ohwxTYng8QFoeWGgb+8ETtdtFsYzL8FCHzVu64x14SctZyqzxl24
         b2wRAd6bq6s/0IyFs09aDtJTd3xCVlMeFV/4gz5pXlBIx7NV2gbBrwLeK1VvTUidXloW
         ExhVh3AhzuKEa6zivM4C3LFj5KQZtE0fo0XAWQP8WXpJfQAe/XUiqzQFy7Ys+l1kupLa
         MT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739448932; x=1740053732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lHgN7iB61XVi5I00SQD99LSvj00C3O7HCL3uRtcvTOY=;
        b=pvaJFlYmh1jPvXJzP2/HIxTjsvROY2deOUCYt5gp4SusX3Su0I/k+S+yv4JnkDFqHS
         Q9jAACY1BFgBlaTUYQXT0u/bx8STni9aNoh0hgEz3QKQddXTnX9bE2/IHhK6M8NagLKR
         NF8ztjmFTIaX1mm9SIS7KdwckIjAWF8qCgqIyP5OUaERja9rNQG67YWurodkc/m4rDmp
         2EEe1TviOpBxHzgkrX8jF2nCDUhe3XC1KHSZnnuYQo6UwX3cglb/a/Sud6WTr4JbiuBp
         cu7ap4ZSL1IP//pJhJiEkgdl7jvPPZAzG7iCky6LG3B3BwpFR1dCHmCECNVKqKmD0z2b
         B/nQ==
X-Gm-Message-State: AOJu0Yxhb/Txu10YEN7Wskhj20ZAvlCMOT1LNLg5BfCcAWYZs8CnT20g
	2v5zC2JbA/VbmY5Bgdo1iKiUBwFIDH2rDwkCf6P0xQP7Haf6QPKxR+ZVYs58xlc=
X-Gm-Gg: ASbGncuVkJzY5A1OhqgnqyCTcqHJeglXHTYOje8isxpiDVNmAJjOIemjqGB69Fl+8x0
	MOkx4dcpGgfVernXsesPwlsDEK+s8ZVkjSupICaRdC89R5RKYRTY/FLkYkDpOWE4G7/tYStGmYY
	LzRn9gBvfA7PiEtKaMIKH+eFxvpb+Re/a7azpb2llStvd4nKwytWHzWnbIgUj+TH35eO9qYhong
	gh0/kLieXlC6TpbE7D2QAH/ccpgZWJByzUcJvN6ZwaKlrHPHlu+DMKPKvI72OWYHGS5dZvEV0H9
	Ue+e8CFKFUeyRCiJwKwyZL91Nw==
X-Google-Smtp-Source: AGHT+IGzgP5ab6h8wU/Jd1PSahCjx2qh/xwtukA5Hg2dpnOjqafumij/jDNW0YAbrFr3SQve9+Tzow==
X-Received: by 2002:a05:600c:5250:b0:434:a781:f5d5 with SMTP id 5b1f17b1804b1-439581bfcffmr83556545e9.30.1739448932072;
        Thu, 13 Feb 2025 04:15:32 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f8ddbsm1728691f8f.47.2025.02.13.04.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 04:15:31 -0800 (PST)
Message-ID: <c672c3a3-64e3-495a-ae61-ae098d30c6b9@linaro.org>
Date: Thu, 13 Feb 2025 12:15:30 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf stat: Fix non-uniquified hybrid legacy events
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, Robin.Murphy@arm.com,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20250212122413.1184503-1-james.clark@linaro.org>
 <CAP-5=fWywDB40-RgV8LaPqsoffOLdDcYkUB_LHoPvV=R8yas4w@mail.gmail.com>
 <CAP-5=fV0rWEL-ewGpoDwaJ3rvbTPXSx0YTuF5p9=6+h5oUhsfg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fV0rWEL-ewGpoDwaJ3rvbTPXSx0YTuF5p9=6+h5oUhsfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/02/2025 9:38 pm, Ian Rogers wrote:
> On Wed, Feb 12, 2025 at 9:48 AM Ian Rogers <irogers@google.com> wrote:
>>
>> On Wed, Feb 12, 2025 at 4:24 AM James Clark <james.clark@linaro.org> wrote:
>>>
>>> Legacy hybrid events have attr.type == PERF_TYPE_HARDWARE, so they look
>>> like plain legacy events if we only look at attr.type. But legacy events
>>> should still be uniquified if they were opened on a non-legacy PMU.
>>> Previously we looked at the PMU type to determine legacy vs hybrid
>>> events here so revert this particular check to how it was before the
>>> linked fixes commit.
>>>
>>> counter->pmu doesn't need to be null checked twice, in fact it is
>>> required for any kind of uniquification so make that a separate check.
>>>
>>> This restores PMU names on hybrid systems and also changes "perf stat
>>> metrics (shadow stat) test" from a FAIL back to a SKIP (on hybrid). The
>>> test was gated on "cycles" appearing alone which doesn't happen on
>>> here.
>>>
>>> Before:
>>>
>>>    $ perf stat -- true
>>>    ...
>>>       <not counted>      instructions:u                           (0.00%)
>>>             162,536      instructions:u            # 0.58  insn per cycle
>>>    ...
>>>
>>> After:
>>>
>>>   $ perf stat -- true
>>>   ...
>>>       <not counted>      cpu_atom/instructions/u                  (0.00%)
>>>             162,541      cpu_core/instructions/u   # 0.62  insn per cycle
>>>   ...
>>>
>>> Fixes: 357b965deba9 ("perf stat: Changes to event name uniquification")
>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>> ---
>>>   tools/perf/util/stat-display.c | 9 +++++++--
>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
>>> index e65c7e9f15d1..eae34ba95f59 100644
>>> --- a/tools/perf/util/stat-display.c
>>> +++ b/tools/perf/util/stat-display.c
>>> @@ -1688,12 +1688,17 @@ static void evsel__set_needs_uniquify(struct evsel *counter, const struct perf_s
>>>                  return;
>>>          }
>>>
>>> -       if  (counter->core.attr.type < PERF_TYPE_MAX && counter->core.attr.type != PERF_TYPE_RAW) {
>>> +       if (!counter->pmu) {
>>
>> Thanks James, I wish I had a hybrid laptop so I didn't keep breaking
>> things like this. I'm uncomfortable using an evsel having/not-having a
>> PMU as an indication of whether uniquification is necessary. It is
>> kind of a side-effect of parsing whether the PMU variable is non-NULL,
>> it'd kind of be nice to stop things using `evsel->pmu` directly and
>> switch them to `evsel__find_pmu(evsel)`, in the future maybe legacy
>> events will get the core PMU, a tracepoint PMU, etc. so we'd never
>> expect this variable to be NULL.

As it stands evsel__uniquify_counter() unconditionally dereferences 
evsel->pmu which is why I thought it made sense to check that first. But 
if that might change then fair enough.

>>
>> Your commit message gives me enough to think about what the issue is,
>> so let me give it some thought.
> 
> I wonder we should just hoist the hybrid test earlier:
> ```
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index e65c7e9f15d1..e852ac0d9847 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -1688,6 +1688,12 @@ static void evsel__set_needs_uniquify(struct
> evsel *counter, const struct per
> f_s
>                 return;
>         }
> 
> +       if (!config->hybrid_merge && evsel__is_hybrid(counter)) {
> +               /* Unique hybrid counters necessary. */
> +               counter->needs_uniquify = true;
> +               return;
> +       }
> +
>         if  (counter->core.attr.type < PERF_TYPE_MAX &&
> counter->core.attr.type != PERF_TYPE_RAW) {
>                 /* Legacy event, don't uniquify. */
>                 return;
> @@ -1705,12 +1711,6 @@ static void evsel__set_needs_uniquify(struct
> evsel *counter, const struct per
> f_s
>                 return;
>         }
> 
> -       if (!config->hybrid_merge && evsel__is_hybrid(counter)) {
> -               /* Unique hybrid counters necessary. */
> -               counter->needs_uniquify = true;
> -               return;
> -       }
> -
>         /*
>          * Do other non-merged events in the evlist have the same name? If so
>          * uniquify is necessary.
> 
> ```
> 
> The hybrid test is unfortunately expensive at it needs to search for
>> 1 core PMU, which means loading all sysfs PMUs. I think we're already
> paying the cost though.
> 
> Could you check this works James?
> 
> Thanks,
> Ian
> 

Yep that works too.

>> Thanks!
>> Ian
>>
>>> +               /* evsel__uniquify_counter() uses counter->pmu for the name */
>>> +               return;
>>> +       }
>>> +
>>> +       if (counter->pmu->type < PERF_TYPE_MAX && counter->pmu->type != PERF_TYPE_RAW) {
>>>                  /* Legacy event, don't uniquify. */
>>>                  return;
>>>          }
>>>
>>> -       if (counter->pmu && counter->pmu->is_core &&
>>> +       if (counter->pmu->is_core &&
>>>              counter->alternate_hw_config != PERF_COUNT_HW_MAX) {
>>>                  /* A sysfs or json event replacing a legacy event, don't uniquify. */
>>>                  return;
>>> --
>>> 2.34.1
>>>

