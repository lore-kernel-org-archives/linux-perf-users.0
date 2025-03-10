Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BC722539F
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Mar 2025 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741601054; cv=none; b=edccg3mQbXvnm/ixIHS83YiFhAjVoWTStFX6MGh3sgbr60kVB4GjU3M2L03rUOa+0SAxmMhArnfU7U1vSurKaGvkvw0qP0FDkf/GrU1o+5626ybt1upCyj/U4kzUgHNTEpSTKsKB7D9AGeTiIV8UCNcel5NivfXwMn/y0tm9Y+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741601054; c=relaxed/simple;
	bh=3QxlT6Ap99BFArhsB77vdhey8O6pDnYMh8VGgowntoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TwItIl3WGGbmt1/y3/LIw6OTD0rMJyxe4UuB1IZ0UpfoZ+lqwrI7nZbHprSAfQrWIw8NPxGeq0yJ7TZN0D3pQal8dtsWXJJgm5Oc2D9O4aCMCC6O0jiUEvTOPQfl8bZjx3wWUmhDPbb3dulr9S0BHKD+0KmHv+OR6v6FgiuUHrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iLQAZ1p/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iLQAZ1p/"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3912baafc58so2855602f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Mar 2025 03:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741601051; x=1742205851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m5TR4eXebuIxD9iUOPxlBw/RPo7J7QSn/HxML4PVdCY=;
        b=iLQAZ1p/gqG7gfR+P2dy2raLn/3Xz1Nmejw15J7Ld8l8M3JYDdzEQYXRkb9Fo5OHCw
         VOl5y/tbHlli33O/CQwPjX+3rQ9FVjM8ctSMc3UkLLIJvWR+uLIoTSjMU7VmuV6iWoiY
         ndqKx0C3oU1qopg/HI6oBqu1yFrRri2eft9ngh54kR/H515bvQy2ss99O5o1qS1o+XjE
         itqGbMODKNkA8QMPgOJ6CrYXH32J1T2IO7+Ogp8WaoZofyF2fUc2ZVwlUQQcS9xIdY/t
         i9U7Ecy1qWXl0Myu7UzhLYjLsTYkRyGOmIwyl0+k4F3QmZZ3FVO07kmh8tvPk90APQV4
         I0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741601051; x=1742205851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5TR4eXebuIxD9iUOPxlBw/RPo7J7QSn/HxML4PVdCY=;
        b=WOaaefTEehNBMJLHFzp23iOWNzcshF9nHLKhzQua1GF24A9aGc9EeR6IsgKPEFqSfJ
         wq0e18ReQf2vDlmf8kMCDAm54WvUD0r0emi7cgLI7xFQ9P9EzN8sAW0UNYeMRio9V5n3
         hlUajsPsNirM3ILEGBl6J2S766BB+1MwuaZ71tuDtz1+3kTu73IN9mZRgVy78IgM5r85
         k8/amwGt+DRbG97HnDaSnUVMCwKhr2t5c8JUcSavKgCZjQdaDpNonHmqAwC+I2B9O4bT
         epvWh6evHLkkflEpWswUN7Pa4rlrLEcnsVV6c+2Ax4RokNhJbhbcRiXRdX0+t3/HUePc
         Kz9g==
X-Forwarded-Encrypted: i=1; AJvYcCVV7xByKXd4RATWjH/xW6ZggISvAyF3iJkBIrvWObXCv4pDP65de2x5VRwo3oM8HU5UE2uv6GO4AbuLl8jwfa0g@vger.kernel.org
X-Gm-Message-State: AOJu0YziTVYOelhx1+8WtXTqYvO5eE7Ynb613JyoYYpJNFeMdPwSNV0U
	y4lfysjutEinPTYz4qt6sJ6qiK/PqQH11QhI0Xgby+skNqfAmbcDj6Yd483D1qM=
X-Gm-Gg: ASbGncvvSzYnJc0EHPyx5W9xDI6HQUMvkBKg61covEDYowA5N98AOP5TBM6/ruphGSR
	cCgWOxkFlTn0Sr8ots04288wGIHiDoQSt1TNNHKSlrlqQ6PKyCetC5VXrAZzByL43Vx+C4lRh/2
	414Usl4GidvMgn6LQVLmxPfnU1jUHhrbUos4MDCGSMNY/kkDJPidZYzNMzbWs49rW2ncrbnM7WK
	QovaSDp00+0eiY7zum4OMl9Kq1QHcUoLu08nno6XGEqnBvN7rHdJ8I16zST5LPtaOVPxSBZ6Jza
	CbgflC9hN96PR/J1Vh96TwyazsXCFKF54CvDb5Z/HHaIk2iCpC1j
X-Google-Smtp-Source: AGHT+IFM86KWsSXRjerJvwy8yxVrYTDtHaS4+7EH0ehT052V0UcRsIeCalsmjFXPLR9tann+qby1QA==
X-Received: by 2002:a05:6000:1a86:b0:38f:2a32:abbb with SMTP id ffacd0b85a97d-39132d325c1mr6018702f8f.4.1741601050770;
        Mon, 10 Mar 2025 03:04:10 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.65.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01d81csm14555714f8f.58.2025.03.10.03.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 03:04:10 -0700 (PDT)
Message-ID: <8bd875a5-6540-4137-ae7a-22ec516c4716@linaro.org>
Date: Mon, 10 Mar 2025 10:04:08 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] perf list: Collapse similar events across PMUs
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Leo Yan <leo.yan@arm.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250304-james-perf-hybrid-list-v1-0-a363ffac283c@linaro.org>
 <20250304-james-perf-hybrid-list-v1-2-a363ffac283c@linaro.org>
 <CAP-5=fX+aSDLMDL3DMNCQ4tDuhaZPv-L6OgfOso3q5wf7anoGg@mail.gmail.com>
 <12da919e-5674-4b12-a51d-ed767cc0b1ac@linaro.org>
 <CAP-5=fWVw499hZ7WM7A+vUmxALX7M-kYXoEehQkv-fh6qHOoOg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fWVw499hZ7WM7A+vUmxALX7M-kYXoEehQkv-fh6qHOoOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/03/2025 5:35 pm, Ian Rogers wrote:
> On Fri, Mar 7, 2025 at 6:08 AM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 05/03/2025 9:40 pm, Ian Rogers wrote:
>>> On Tue, Mar 4, 2025 at 5:50 AM James Clark <james.clark@linaro.org> wrote:
>>>>
>>>> Instead of showing multiple line items with the same event name and
>>>> description, show a single line and concatenate all PMUs that this
>>>> event can belong to.
>>>>
>>>> Don't do it for json output. Machine readable output doesn't need to be
>>>> minimized, and changing the "Unit" field to a list type would break
>>>> backwards compatibility.
>>>>
>>>> Before:
>>>>    $ perf list -v
>>>>    ...
>>>>    br_indirect_spec
>>>>          [Branch speculatively executed,indirect branch. Unit: armv8_cortex_a53]
>>>>    br_indirect_spec
>>>>          [Branch speculatively executed,indirect branch. Unit: armv8_cortex_a57]
>>>>
>>>> After:
>>>>
>>>>    $ perf list -v
>>>>    ...
>>>>    br_indirect_spec
>>>>          [Branch speculatively executed,indirect branch. Unit: armv8_cortex_a53,armv8_cortex_a57]
>>>>
>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>> ---
>>>>    tools/perf/builtin-list.c      |  2 ++
>>>>    tools/perf/util/pmus.c         | 75 +++++++++++++++++++++++++++++++++++++-----
>>>>    tools/perf/util/print-events.h |  1 +
>>>>    3 files changed, 70 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
>>>> index fed482adb039..aacd7beae2a0 100644
>>>> --- a/tools/perf/builtin-list.c
>>>> +++ b/tools/perf/builtin-list.c
>>>> @@ -516,6 +516,7 @@ int cmd_list(int argc, const char **argv)
>>>>                   .print_event = default_print_event,
>>>>                   .print_metric = default_print_metric,
>>>>                   .skip_duplicate_pmus = default_skip_duplicate_pmus,
>>>> +               .collapse_events = true
>>>
>>> So collapse_events is put in the callbacks but isn't a callback. I
>>> think skipping duplicates and collapsing are the same thing, I'd
>>> prefer it if there weren't two terms for the same thing. If you prefer
>>> collapsing as a name then default_skip_duplicate_pmus can be
>>> default_collapse_pmus.
>>>
>>
>> I can use the existing callback and rename it. That does have the effect
>> of disabling this behavior in verbose mode which may be useful or may be
>> unexpected to some people. But it seems pretty 50/50 so fewer callbacks
>> are probably better.
>>
>>>>           };
>>>>           const char *cputype = NULL;
>>>>           const char *unit_name = NULL;
>>>> @@ -574,6 +575,7 @@ int cmd_list(int argc, const char **argv)
>>>>                           .print_event = json_print_event,
>>>>                           .print_metric = json_print_metric,
>>>>                           .skip_duplicate_pmus = json_skip_duplicate_pmus,
>>>> +                       .collapse_events = false
>>>>                   };
>>>>                   ps = &json_ps;
>>>>           } else {
>>>> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
>>>> index 4d60bac2d2b9..cb1b14ade25b 100644
>>>> --- a/tools/perf/util/pmus.c
>>>> +++ b/tools/perf/util/pmus.c
>>>> @@ -453,17 +453,50 @@ static int cmp_sevent(const void *a, const void *b)
>>>>           /* Order by PMU name. */
>>>>           if (as->pmu == bs->pmu)
>>>>                   return 0;
>>>> -       return strcmp(as->pmu_name ?: "", bs->pmu_name ?: "");
>>>> +       ret = strcmp(as->pmu_name ?: "", bs->pmu_name ?: "");
>>>> +       if (ret)
>>>> +               return ret;
>>>> +
>>>> +       /* Order by remaining displayed fields for purposes of deduplication later */
>>>> +       ret = strcmp(as->scale_unit ?: "", bs->scale_unit ?: "");
>>>> +       if (ret)
>>>> +               return ret;
>>>> +       ret = !!as->deprecated - !!bs->deprecated;
>>>> +       if (ret)
>>>> +               return ret;
>>>> +       ret = strcmp(as->desc ?: "", bs->desc ?: "");
>>>> +       if (ret)
>>>> +               return ret;
>>>> +       return strcmp(as->long_desc ?: "", bs->long_desc ?: "");
>>>>    }
>>>>
>>>> -static bool pmu_alias_is_duplicate(struct sevent *a, struct sevent *b)
>>>> +enum dup_type {
>>>> +       UNIQUE,
>>>> +       DUPLICATE,
>>>> +       SAME_TEXT
>>>> +};
>>>> +
>>>> +static enum dup_type pmu_alias_duplicate_type(struct sevent *a, struct sevent *b)
>>>>    {
>>>>           /* Different names -> never duplicates */
>>>>           if (strcmp(a->name ?: "//", b->name ?: "//"))
>>>> -               return false;
>>>> +               return UNIQUE;
>>>> +
>>>> +       /* Duplicate PMU name and event name -> hide completely */
>>>> +       if (strcmp(a->pmu_name, b->pmu_name) == 0)
>>>> +               return DUPLICATE;
>>>> +
>>>> +       /* Any other different display text -> not duplicate */
>>>> +       if (strcmp(a->topic ?: "", b->topic ?: "") ||
>>>> +           strcmp(a->scale_unit ?: "", b->scale_unit ?: "") ||
>>>> +           a->deprecated != b->deprecated ||
>>>> +           strcmp(a->desc ?: "", b->desc ?: "") ||
>>>> +           strcmp(a->long_desc ?: "", b->long_desc ?: "")) {
>>>> +               return UNIQUE;
>>>> +       }
>>>>
>>>> -       /* Don't remove duplicates for different PMUs */
>>>> -       return strcmp(a->pmu_name, b->pmu_name) == 0;
>>>> +       /* Same display text but different PMU -> collapse */
>>>> +       return SAME_TEXT;
>>>>    }
>>>>
>>>>    struct events_callback_state {
>>>> @@ -501,6 +534,21 @@ static int perf_pmus__print_pmu_events__callback(void *vstate,
>>>>           return 0;
>>>>    }
>>>>
>>>> +static void concat_pmu_names(char *pmu_names, size_t size, const char *a, const char *b)
>>>> +{
>>>> +       size_t len = strlen(pmu_names);
>>>> +       size_t added;
>>>> +
>>>> +       if (len)
>>>> +               added = snprintf(pmu_names + len, size - len, ",%s", b);
>>>> +       else
>>>> +               added = snprintf(pmu_names, size, "%s,%s", a, b);
>>>> +
>>>> +       /* Truncate with ... */
>>>> +       if (added > 0 && added + len >= size)
>>>> +               sprintf(pmu_names + size - 4, "...");
>>>> +}
>>>> +
>>>>    void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *print_state)
>>>>    {
>>>>           struct perf_pmu *pmu;
>>>> @@ -510,6 +558,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
>>>>           struct events_callback_state state;
>>>>           bool skip_duplicate_pmus = print_cb->skip_duplicate_pmus(print_state);
>>>>           struct perf_pmu *(*scan_fn)(struct perf_pmu *);
>>>> +       char pmu_names[128] = {0};
>>>>
>>>>           if (skip_duplicate_pmus)
>>>>                   scan_fn = perf_pmus__scan_skip_duplicates;
>>>> @@ -539,12 +588,21 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
>>>>           qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
>>>>           for (int j = 0; j < len; j++) {
>>>>                   /* Skip duplicates */
>>>> -               if (j < len - 1 && pmu_alias_is_duplicate(&aliases[j], &aliases[j + 1]))
>>>> -                       goto free;
>>>> +               if (j < len - 1) {
>>>> +                       enum dup_type dt = pmu_alias_duplicate_type(&aliases[j], &aliases[j + 1]);
>>>> +
>>>> +                       if (dt == DUPLICATE) {
>>>> +                               goto free;
>>>> +                       } else if (print_cb->collapse_events && dt == SAME_TEXT) {
>>>> +                               concat_pmu_names(pmu_names, sizeof(pmu_names),
>>>> +                                                aliases[j].pmu_name, aliases[j+1].pmu_name);
>>>> +                               goto free;
>>>> +                       }
>>>> +               }
>>>
>>> I think a label called 'free' is a little unfortunate given the
>>> function called free.
>>> When I did things with sevent I was bringing over previous `perf list`
>>> code mainly so that the perf list output before and after the changes
>>> was identical. I wonder if this logic would be better placed in the
>>> callback like default_print_event which already maintains state
>>> (last_topic) to optionally print different things. This may better
>>> encapsulate the behavior rather than the logic being in the PMU code.
>>>
>>
>> Yeah I can have a look at putting it in one of the callbacks. But in the
>> end builtin-list.c is the only user of perf_pmus__print_pmu_events()
>> anyway so makes you wonder if the whole thing can be moved to
>> builtin-list and open coded without the callbackyness.
> 
> I wanted to hide some of the innards of pmus, so I think that's the
> reason it is as it is. The whole `sevent` was pre-existing and
> maintained so that the output was the same.
> 
>>>>
>>>>                   print_cb->print_event(print_state,
>>>>                                   aliases[j].topic,
>>>> -                               aliases[j].pmu_name,
>>>> +                               pmu_names[0] ? pmu_names : aliases[j].pmu_name,
>>>>                                   aliases[j].name,
>>>>                                   aliases[j].alias,
>>>>                                   aliases[j].scale_unit,
>>>> @@ -553,6 +611,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
>>>>                                   aliases[j].desc,
>>>>                                   aliases[j].long_desc,
>>>>                                   aliases[j].encoding_desc);
>>>
>>> The encoding_desc will have a PMU with the suffix removed as per
>>> skipping duplicates:
>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.c?h=perf-tools-next#n1954
>>> So I think something like:
>>> ```
>>>     br_mis_pred_retired
>>>          [Instruction architecturally executed,mispredicted branch. Unit:
>>>           armv9_cortex_a510,armv9_cortex_a710]
>>> ```
>>> Would have an encoding of `armv9_cortex_a510/.../` without the a710
>>> encoding being present. That said, I'm not sure anyone cares :-)
>>>
>>> Thanks,
>>> Ian
>>>
>>
>> Ah, in that case I'll disable it for --detailed as well as --json. I
>> could compare encoding_desc in pmu_alias_duplicate_type() but they'll
>> always be different because of the PMU name, so there's no point. And
>> displaying multiple encoding_descs would be fiddly too.
> 
> So I'd like not to have the encoding_desc removed. It is useful for
> debugging.. I meant by people not caring that the format of that
> string is under specified, so the PMU name not being 100% accurate
> likely doesn't affect people.
> 
> Thanks,
> Ian
> 
> 

By 'disabled' I meant disable this collapsing of PMU names, so with 
--detailed you'll get the existing full list of events with their 
encoding_descs, no change there. Sorry for the confusion.

>>>> +               pmu_names[0] = '\0';
>>>>    free:
>>>>                   zfree(&aliases[j].name);
>>>>                   zfree(&aliases[j].alias);
>>>> diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
>>>> index 445efa1636c1..e91f9f830a2a 100644
>>>> --- a/tools/perf/util/print-events.h
>>>> +++ b/tools/perf/util/print-events.h
>>>> @@ -27,6 +27,7 @@ struct print_callbacks {
>>>>                           const char *threshold,
>>>>                           const char *unit);
>>>>           bool (*skip_duplicate_pmus)(void *print_state);
>>>> +       bool collapse_events;
>>>>    };
>>>>
>>>>    /** Print all events, the default when no options are specified. */
>>>>
>>>> --
>>>> 2.34.1
>>>>
>>

