Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF783260A2E
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2025 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741711266; cv=none; b=rorIfVI7bSHV4Jq5CC2oWVVcLMesMQre+jMPVjKE2tu7jWJekeJn0s1hcAqLRuHCPKMdbauhxgXVz3mAGCgVCH216ahZ92HdIaBQaKbMqt4DXusZHM2Op0xQpYCToOs78g/cB4g7L/hsfRJzkUjEmCId5mgXfyL4Cxl1y5388oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741711266; c=relaxed/simple;
	bh=QyJt0OO5pmJH9V2UvRhRXrU2TWNoCtI9OvSlO4HN5o0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0nOM600DVB8XlMkYIgjmgCMLgQzda6LDriZ8GcmTXlafYrbF5QzIy2MyHyMea1I5kIuPzhpLfu8bpfZj9123zMuSGigE8FlPNiqJxEsD0n7pWCsl5sgfMi+yLjN+Td7cbxHEi+SqfLLzLXOMDQBOJG6v4TbaW/BZ0ymsRxtLOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YKNNXU8d; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YKNNXU8d"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so18411395e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2025 09:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741711263; x=1742316063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fk2mxgnNybKLjQhWtJ1SHXhrETin8pYENyUeQqOMkNA=;
        b=YKNNXU8d7sKjMGUMUhpcBxNUmdr8ic2u+NIbLricFlh9RUrGBAFYjyB9GN7z1jJo00
         WpdeVkx1GzIonBRa5CWYPPm1FtqKXj61mwsNGgwXStzCWssoMUK0MANo4i6y1IqxeybS
         tG2Arycx1TVxs410OgP0CY+2cObTMfiwNSnZ5S/+lyG9xvJ/Ogqucn0uEHrgg/zmymqM
         lwiZXEysBLLErrzP0Ryg7ByCbyX5IasIAT2L2lF/BmdlLkVos6Np/DYv8iQu6NWL1syD
         jyor18lfvZu8iwE07/o6rYvsfIY21j+/PlAm+/cAYH0KebmpXIKtnSJSEUZW4yNYfgXi
         xxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741711263; x=1742316063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fk2mxgnNybKLjQhWtJ1SHXhrETin8pYENyUeQqOMkNA=;
        b=rRq3eI5dUyaRAJptalEAo4rMkZN1ek+LmTyOuHCNRDz1o7ZbcnnheCNSojQm0NO5Dz
         d5RUPLui/JrD1bh0uch+WE+xvrdKpRcg87HWFKtu7C7i+G6ONlaAPLhKghph+DsvqF3D
         HMvTEzozc2XvXKf9RBvTyo60OD6jLqJjQ+w8Ct111B7UsVILBMnyUYX2NY+7EiJxOxiw
         v+W6W1zrxo70ytGBAAJRLEOoSOJuZtd/AzDDxF4EqaCnVh7oqkGD5lSHK8ME0gXYBd06
         Yy9NaHRShdGU8LcTlYu6kI3V8sZ3i0X08KqssKGTUJeHfuevq7KeuFSUxVA62m33HhIp
         0SZA==
X-Forwarded-Encrypted: i=1; AJvYcCXcT6ql59AALJ9EJZ/22569CvUXWeBGQzdtkByEPKqIB8P3MeeOnRnA+AeU7T5bO60HuYd/83UnHT23EVrAhr/Z@vger.kernel.org
X-Gm-Message-State: AOJu0YzU8QWjm0j8yDPtDSP4i1tPpiPE2AZxRretGDcWqwnqTJi4Cdzt
	dGMZIrCayUBzfFWAH8mTFesvvJrwJ7tPNr0QVeSUAvyvBDsE5nGo4t9TsyCoy9g=
X-Gm-Gg: ASbGnctWLPDGd2HibeIr3ffO+OuBeaCuJbtSy+wy2qK8dixphuOwPcVrjpLOGCYJyYT
	XHY+Ru9HBCH6cDKXJjsiGFI0vs5/1Zw+NcxIRjUZ+yk2eQHs6yoYwr/yQNvZFklQozM1Uv/sUg3
	yAnz37Q/ZN6n4uqcjdPSlxFxRveBLAS9pFHp2V9y2xVJj49U4PFhp8UMYIHy+Hh9COxzygiJYnJ
	LOfYfDmW0Q0eJMQFXrKHKXW6TuZbxnVGlJ+LRq1LR7cUvzCeTJKPKgF+6ROSzItiBsjQKqGQuL+
	i43dhXI3sWRkBnZE3AvjAFqcU6r4zgFlYW0zI0YyFwosUPKxXXQR
X-Google-Smtp-Source: AGHT+IE8o/3Q+XaiODgAikjAiV03ym4Bfmrkd/dvbae0xbgZy7IED5uwuHXUUbta0XTP7Ubz90GQ9A==
X-Received: by 2002:a05:600c:b95:b0:43c:ec97:75db with SMTP id 5b1f17b1804b1-43cec97779fmr130648945e9.11.1741711262812;
        Tue, 11 Mar 2025 09:41:02 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.65.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d073555e5sm16064985e9.4.2025.03.11.09.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 09:41:02 -0700 (PDT)
Message-ID: <7047e241-95dd-46e5-b573-6ab5982a6a1f@linaro.org>
Date: Tue, 11 Mar 2025 16:41:00 +0000
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
 <39f7e3ae-d274-4de4-8b8e-bcf1ad6f0932@linaro.org>
 <CAP-5=fU8LWyKrxn==ieO+dOCyvDML5Qnf23K=5bqHdHMvGx-eA@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fU8LWyKrxn==ieO+dOCyvDML5Qnf23K=5bqHdHMvGx-eA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/03/2025 3:14 pm, Ian Rogers wrote:
> On Tue, Mar 11, 2025 at 7:13 AM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 07/03/2025 5:35 pm, Ian Rogers wrote:
>>> On Fri, Mar 7, 2025 at 6:08 AM James Clark <james.clark@linaro.org> wrote:
>>>>
>>>>
>>>>
>>>> On 05/03/2025 9:40 pm, Ian Rogers wrote:
>>>>> On Tue, Mar 4, 2025 at 5:50 AM James Clark <james.clark@linaro.org> wrote:
>>>>>>
>>>>>> Instead of showing multiple line items with the same event name and
>>>>>> description, show a single line and concatenate all PMUs that this
>>>>>> event can belong to.
>>>>>>
>>>>>> Don't do it for json output. Machine readable output doesn't need to be
>>>>>> minimized, and changing the "Unit" field to a list type would break
>>>>>> backwards compatibility.
>>>>>>
>>>>>> Before:
>>>>>>     $ perf list -v
>>>>>>     ...
>>>>>>     br_indirect_spec
>>>>>>           [Branch speculatively executed,indirect branch. Unit: armv8_cortex_a53]
>>>>>>     br_indirect_spec
>>>>>>           [Branch speculatively executed,indirect branch. Unit: armv8_cortex_a57]
>>>>>>
>>>>>> After:
>>>>>>
>>>>>>     $ perf list -v
>>>>>>     ...
>>>>>>     br_indirect_spec
>>>>>>           [Branch speculatively executed,indirect branch. Unit: armv8_cortex_a53,armv8_cortex_a57]
>>>>>>
>>>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>>>> ---
>>>>>>     tools/perf/builtin-list.c      |  2 ++
>>>>>>     tools/perf/util/pmus.c         | 75 +++++++++++++++++++++++++++++++++++++-----
>>>>>>     tools/perf/util/print-events.h |  1 +
>>>>>>     3 files changed, 70 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
>>>>>> index fed482adb039..aacd7beae2a0 100644
>>>>>> --- a/tools/perf/builtin-list.c
>>>>>> +++ b/tools/perf/builtin-list.c
>>>>>> @@ -516,6 +516,7 @@ int cmd_list(int argc, const char **argv)
>>>>>>                    .print_event = default_print_event,
>>>>>>                    .print_metric = default_print_metric,
>>>>>>                    .skip_duplicate_pmus = default_skip_duplicate_pmus,
>>>>>> +               .collapse_events = true
>>>>>
>>>>> So collapse_events is put in the callbacks but isn't a callback. I
>>>>> think skipping duplicates and collapsing are the same thing, I'd
>>>>> prefer it if there weren't two terms for the same thing. If you prefer
>>>>> collapsing as a name then default_skip_duplicate_pmus can be
>>>>> default_collapse_pmus.
>>>>>
>>>>
>>>> I can use the existing callback and rename it. That does have the effect
>>>> of disabling this behavior in verbose mode which may be useful or may be
>>>> unexpected to some people. But it seems pretty 50/50 so fewer callbacks
>>>> are probably better.
>>>>
>>>>>>            };
>>>>>>            const char *cputype = NULL;
>>>>>>            const char *unit_name = NULL;
>>>>>> @@ -574,6 +575,7 @@ int cmd_list(int argc, const char **argv)
>>>>>>                            .print_event = json_print_event,
>>>>>>                            .print_metric = json_print_metric,
>>>>>>                            .skip_duplicate_pmus = json_skip_duplicate_pmus,
>>>>>> +                       .collapse_events = false
>>>>>>                    };
>>>>>>                    ps = &json_ps;
>>>>>>            } else {
>>>>>> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
>>>>>> index 4d60bac2d2b9..cb1b14ade25b 100644
>>>>>> --- a/tools/perf/util/pmus.c
>>>>>> +++ b/tools/perf/util/pmus.c
>>>>>> @@ -453,17 +453,50 @@ static int cmp_sevent(const void *a, const void *b)
>>>>>>            /* Order by PMU name. */
>>>>>>            if (as->pmu == bs->pmu)
>>>>>>                    return 0;
>>>>>> -       return strcmp(as->pmu_name ?: "", bs->pmu_name ?: "");
>>>>>> +       ret = strcmp(as->pmu_name ?: "", bs->pmu_name ?: "");
>>>>>> +       if (ret)
>>>>>> +               return ret;
>>>>>> +
>>>>>> +       /* Order by remaining displayed fields for purposes of deduplication later */
>>>>>> +       ret = strcmp(as->scale_unit ?: "", bs->scale_unit ?: "");
>>>>>> +       if (ret)
>>>>>> +               return ret;
>>>>>> +       ret = !!as->deprecated - !!bs->deprecated;
>>>>>> +       if (ret)
>>>>>> +               return ret;
>>>>>> +       ret = strcmp(as->desc ?: "", bs->desc ?: "");
>>>>>> +       if (ret)
>>>>>> +               return ret;
>>>>>> +       return strcmp(as->long_desc ?: "", bs->long_desc ?: "");
>>>>>>     }
>>>>>>
>>>>>> -static bool pmu_alias_is_duplicate(struct sevent *a, struct sevent *b)
>>>>>> +enum dup_type {
>>>>>> +       UNIQUE,
>>>>>> +       DUPLICATE,
>>>>>> +       SAME_TEXT
>>>>>> +};
>>>>>> +
>>>>>> +static enum dup_type pmu_alias_duplicate_type(struct sevent *a, struct sevent *b)
>>>>>>     {
>>>>>>            /* Different names -> never duplicates */
>>>>>>            if (strcmp(a->name ?: "//", b->name ?: "//"))
>>>>>> -               return false;
>>>>>> +               return UNIQUE;
>>>>>> +
>>>>>> +       /* Duplicate PMU name and event name -> hide completely */
>>>>>> +       if (strcmp(a->pmu_name, b->pmu_name) == 0)
>>>>>> +               return DUPLICATE;
>>>>>> +
>>>>>> +       /* Any other different display text -> not duplicate */
>>>>>> +       if (strcmp(a->topic ?: "", b->topic ?: "") ||
>>>>>> +           strcmp(a->scale_unit ?: "", b->scale_unit ?: "") ||
>>>>>> +           a->deprecated != b->deprecated ||
>>>>>> +           strcmp(a->desc ?: "", b->desc ?: "") ||
>>>>>> +           strcmp(a->long_desc ?: "", b->long_desc ?: "")) {
>>>>>> +               return UNIQUE;
>>>>>> +       }
>>>>>>
>>>>>> -       /* Don't remove duplicates for different PMUs */
>>>>>> -       return strcmp(a->pmu_name, b->pmu_name) == 0;
>>>>>> +       /* Same display text but different PMU -> collapse */
>>>>>> +       return SAME_TEXT;
>>>>>>     }
>>>>>>
>>>>>>     struct events_callback_state {
>>>>>> @@ -501,6 +534,21 @@ static int perf_pmus__print_pmu_events__callback(void *vstate,
>>>>>>            return 0;
>>>>>>     }
>>>>>>
>>>>>> +static void concat_pmu_names(char *pmu_names, size_t size, const char *a, const char *b)
>>>>>> +{
>>>>>> +       size_t len = strlen(pmu_names);
>>>>>> +       size_t added;
>>>>>> +
>>>>>> +       if (len)
>>>>>> +               added = snprintf(pmu_names + len, size - len, ",%s", b);
>>>>>> +       else
>>>>>> +               added = snprintf(pmu_names, size, "%s,%s", a, b);
>>>>>> +
>>>>>> +       /* Truncate with ... */
>>>>>> +       if (added > 0 && added + len >= size)
>>>>>> +               sprintf(pmu_names + size - 4, "...");
>>>>>> +}
>>>>>> +
>>>>>>     void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *print_state)
>>>>>>     {
>>>>>>            struct perf_pmu *pmu;
>>>>>> @@ -510,6 +558,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
>>>>>>            struct events_callback_state state;
>>>>>>            bool skip_duplicate_pmus = print_cb->skip_duplicate_pmus(print_state);
>>>>>>            struct perf_pmu *(*scan_fn)(struct perf_pmu *);
>>>>>> +       char pmu_names[128] = {0};
>>>>>>
>>>>>>            if (skip_duplicate_pmus)
>>>>>>                    scan_fn = perf_pmus__scan_skip_duplicates;
>>>>>> @@ -539,12 +588,21 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
>>>>>>            qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
>>>>>>            for (int j = 0; j < len; j++) {
>>>>>>                    /* Skip duplicates */
>>>>>> -               if (j < len - 1 && pmu_alias_is_duplicate(&aliases[j], &aliases[j + 1]))
>>>>>> -                       goto free;
>>>>>> +               if (j < len - 1) {
>>>>>> +                       enum dup_type dt = pmu_alias_duplicate_type(&aliases[j], &aliases[j + 1]);
>>>>>> +
>>>>>> +                       if (dt == DUPLICATE) {
>>>>>> +                               goto free;
>>>>>> +                       } else if (print_cb->collapse_events && dt == SAME_TEXT) {
>>>>>> +                               concat_pmu_names(pmu_names, sizeof(pmu_names),
>>>>>> +                                                aliases[j].pmu_name, aliases[j+1].pmu_name);
>>>>>> +                               goto free;
>>>>>> +                       }
>>>>>> +               }
>>>>>
>>>>> I think a label called 'free' is a little unfortunate given the
>>>>> function called free.
>>>>> When I did things with sevent I was bringing over previous `perf list`
>>>>> code mainly so that the perf list output before and after the changes
>>>>> was identical. I wonder if this logic would be better placed in the
>>>>> callback like default_print_event which already maintains state
>>>>> (last_topic) to optionally print different things. This may better
>>>>> encapsulate the behavior rather than the logic being in the PMU code.
>>>>>
>>>>
>>>> Yeah I can have a look at putting it in one of the callbacks. But in the
>>>> end builtin-list.c is the only user of perf_pmus__print_pmu_events()
>>>> anyway so makes you wonder if the whole thing can be moved to
>>>> builtin-list and open coded without the callbackyness.
>>>
>>> I wanted to hide some of the innards of pmus, so I think that's the
>>> reason it is as it is. The whole `sevent` was pre-existing and
>>> maintained so that the output was the same.
>>>
>>
>> Looking at this a bit more it is possible to move all of
>> perf_pmus__print_pmu_events() (including its dependencies and perf list
>> specifics) out of pmus.c into print-events.c without exposing any new
>> innards of pmus. Only struct pmu_event_info would be used, but that's
>> not private and is already used elsewhere.
>>
>> It's difficult to do this change only in the print_event callback
>> because it relies on having the _next_ event, not the previous event.
>> We're already tracking last_topic, and if we start passing all the
>> next_* items too it gets a bit unmanageable.
>>
>> If it's all moved then doing display specific processing across the
>> whole list becomes quite easy.
> 
> I'm not sure I follow all of this. If things can be moved to a more
> obvious location, printing code in print-events.c, and we maintain
> encapsulation then that sounds great to me.

I'll give it a go, I think I can come up with something.

> I'm not clear on the next event issue.

For example, pmu_alias_is_duplicate() needs the current and next event, 
so it's not easy to move that behavior to builtin-list.c. And my change 
to collapse similar events across PMUs also requires the next rather 
than previous event.

> My hope with the print routines in builtin-list.c was
> that anyone could come along and add another for whatever rendering
> took their fancy. I didn't want it to be like the logic in
> stat-display.c, where there are multiple levels of call backs, global
> state, odd things like passing NULL meaning display column headers,
> and the whole thing being a confusing rats nest where a change nearly
> always ripples through and breaks something somewhere. Particularly
> compare the json output in stat-display.c and builtin-list.c, my hope
> was that builtin-list.c would be the model for reimplementing the
> stat-display.c one. Others may have different opinions.
> 
> Thanks,
> Ian

Makes sense. If I make pmus.c return a list then anyone can loop over 
the list and do whatever display they want. It removes the need for the 
callback but does require that the consumer know the type of the list 
item. It could be struct sevent or even drop that and directly use 
struct pmu_event_info.

Having the whole list gives you a lot more flexibility than just the 
small window that the print event callback gives you.


