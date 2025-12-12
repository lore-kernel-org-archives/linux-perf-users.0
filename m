Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD02B2749D2
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765550643; cv=none; b=dbmb37Fxud9ilMyzzFYDZtSvAzOfjv2nRps0H/3GHXV4PIzE/A+G2LjbiirhtG11/jEGqxiT9P70bSyn6pCHhTzSeA1Rv+8270oPjUhwDsHbDehbH3zimovdqgxNc2/79JWql1DwpRzHzLvYobIUxSejEqWAdg/LExJBwixY0l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765550643; c=relaxed/simple;
	bh=Vz3bP9Hd0yox4cV5bwSg3xHl1QRXGbfcGv+4AwVQT0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZoVfa0sEIB2vF3J3jJ65tJN5cByYiWK2llsmXgyPdOv7NIp6HfKKM8v87Z89qgqJfCHodEv/HX7Vcx18UTem12hqEdIZcQnqr5gZxmcg9fvH52va8ns3ZctbFYS22lWZ/lpec7oW1q/k6fGJvD9e0Hf1/obUKC+Jt+7eHsK8nDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fm89Qfyn; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fm89Qfyn"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b7a72874af1so203500966b.3
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 06:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765550640; x=1766155440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UHks+Tz5Tz1S6b0QtdZfqGNmwtHIR1PhIe2ld/ROsMY=;
        b=fm89QfynIhLxrXoOgJSL/2VBOFdEkmWGL7aFiOuGFiRDe9k7qzSIMNSaCN1ekHz/oC
         Bp8r+YCIBAzU+dMSH82mI1YWKxhhb8VpL6kBWn8ZvUIVcHMsd8Rf10Gvt/koi46Hbe6b
         kwvk7idvHrswgqVnAnSLjdowHkVOP4aTgADBLg9KzNxzo/hAvK6TwPgt4beKIrfCT22c
         Mb7tq0H09kQi0aL7Ebc6kNY9Q8PCAkb5Cf87tXyl5ohO1GbsTG4sCDMMsb0MwqBPdAqD
         zuOv6CAC5P7wsmWSbr6co4yyab67xadgpSkCz1xtcplDZVmS0+WNoIAuVME6rdsqKyZU
         ocaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765550640; x=1766155440;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UHks+Tz5Tz1S6b0QtdZfqGNmwtHIR1PhIe2ld/ROsMY=;
        b=ZaRTj11uWUBAzbtcjNY9l6mpJRHx5/uKzYLgEWfUNi0qPj5e6PX56DQCtx/rNZeYhF
         ZSjtXj1SU/YOhyK7pmAJpfjK5JVWyF3xWvNm819kuY3z2sih1P9H5+3k79XY0/5C989e
         zEk95F4N8vHmp7KKEHfpLVd+XQz5YIUqpYu+12SREmjrH/hbm/lqmAD+O6xUv8Ju7ckd
         wQIlrirSLuJHJSU0dSJb1LPZCxd1A8XWmjVKoBfNNrm0JXJPjUbj94nJZWwhVC9FVV4s
         5PvYZY2rXCr+FOhyJaJLh0dvptfidMYF6ZXA5xbNRWZuIvzAMxB1jrSSX6Km2Z/h1aaw
         85Rg==
X-Gm-Message-State: AOJu0Yx93I4tj3atnOUcA3PWJsaEtX3DhS/0dy+fePeTDf92OqXM4rEE
	bLMPH4Qfqjld3/K4sbHV5b6YdsG81HqSpdaOeby2JnRrx0ASkCzM9FBJ2NF5QHvQWZ8=
X-Gm-Gg: AY/fxX4ZXkqgEjXThLMnj+hu5WVfGCn3sVJwpzyL6VeW+agqE/wEUSzSvzmAFeoq7aO
	22x9tMsPXI98m9ibvYcio5/irNn528O2bdI9umY2oWjpXs9jN8PwsrIdjtRGBDHnbqWn8oMWewh
	uiNVE3isyYoQDP0n48NtOYjBES2eoxecteAXtFr6jrqkMVU3SDT+X1hqr9lx+kTpxn+bjJi6UKF
	h6PoKoFqfE03U0Z+nkG0uDkgOa+3EJfrtEVLOt3XsOEkrFDPbhgqw1h9zGeAchSSYeXXuleRwMI
	Ol7ZiJnjKcttszI7jy1tWVwucV5NJggSQr0sDwVxgHpfx4IGN7AulqxwnOwwXvNpsjQ2Itfr4HO
	4rpM5/DJazYDbZBL37DANYK6PTJuZG4f/NAFxfhw6UcABYNwU3VlZxJRZxAYpgMvJaI4D93Hpwi
	Mz1Cfjf10PJ5Q7MMHe6JRO
X-Google-Smtp-Source: AGHT+IE3svTtW70pxSeY9K0szvV0szRg7UnbT0HaZetFEyEZG4iGhZlbXeVU+9M6CTK3kAp5gnBY8g==
X-Received: by 2002:a17:907:8694:b0:b73:1e09:7377 with SMTP id a640c23a62f3a-b7d23aa5631mr230371666b.58.1765550639940;
        Fri, 12 Dec 2025 06:43:59 -0800 (PST)
Received: from [192.168.0.108] ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa29be92sm574681666b.10.2025.12.12.06.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 06:43:59 -0800 (PST)
Message-ID: <99e9614d-a956-40dc-a86b-a4c5aea0fe8a@linaro.org>
Date: Fri, 12 Dec 2025 16:43:57 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] perf parse-events: Refactor get_config_terms()
 to remove macros
To: Ian Rogers <irogers@google.com>
Cc: Linux perf Profiling <linux-perf-users@vger.kernel.org>,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, leo.yan@arm.com
References: <20251208-james-perf-config-bits-v2-0-4ac0281993b0@linaro.org>
 <20251208-james-perf-config-bits-v2-1-4ac0281993b0@linaro.org>
 <6ba6bde3-f56b-4354-b336-4739cb1edb71@linaro.org>
 <CAP-5=fV_Y5W2RyJhBgnk49JuTf8EsyisY-LfL3sVhC4TVRC_gg@mail.gmail.com>
 <d275d2fb-8670-4832-b9c4-de98376e58ad@linaro.org>
 <CAP-5=fW6_MVrezxT6ssjhWnYtF_51nvuFCCSPaHzqwYw9EK4Wg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fW6_MVrezxT6ssjhWnYtF_51nvuFCCSPaHzqwYw9EK4Wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 09/12/2025 20:09, Ian Rogers wrote:
> On Tue, Dec 9, 2025 at 9:55 AM James Clark <james.clark@linaro.org> wrote:
>>
>> On 09/12/2025 15:58, Ian Rogers wrote:
>>> On Tue, Dec 9, 2025 at 4:48 AM James Clark <james.clark@linaro.org> wrote:
>>>>
>>>> On 08/12/2025 2:22 pm, James Clark wrote:
>>>>> The ADD_CONFIG_TERM() macros build the __type argument out of a partial
>>>>> EVSEL__CONFIG_TERM_x enum name. This means that they can't be called
>>>>> from a function where __type is a variable and it's also impossible to
>>>>> grep the codebase to find usages of these enums as they're never typed
>>>>> in full.
>>>>>
>>>>> Fix this by removing the macros and replacing them with an
>>>>> add_config_term() function. It seems the main reason these existed in
>>>>> the first place was to avoid type punning and to write to a specific
>>>>> field in the union, but the same thing can be achieved with a single
>>>>> write to a u64 'val' field.
>>>>>
>>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>>> ---
>>>>>     tools/perf/util/evsel_config.h |   1 +
>>>>>     tools/perf/util/parse-events.c | 146 ++++++++++++++++++++++++-----------------
>>>>>     2 files changed, 86 insertions(+), 61 deletions(-)
>>>>>
>>>>> diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
>>>>> index bcd3a978f0c4..685fd8d5c4a8 100644
>>>>> --- a/tools/perf/util/evsel_config.h
>>>>> +++ b/tools/perf/util/evsel_config.h
>>>>> @@ -50,6 +50,7 @@ struct evsel_config_term {
>>>>>                 u64           cfg_chg;
>>>>>                 char          *str;
>>>>>                 int           cpu;
>>>>> +             u64           val;
>>>>>         } val;
>>>>>         bool weak;
>>>>>     };
>>>>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
>>>>> index 17c1c36a7bf9..d5b009b4ebab 100644
>>>>> --- a/tools/perf/util/parse-events.c
>>>>> +++ b/tools/perf/util/parse-events.c
>>>>> @@ -1116,105 +1116,107 @@ static int config_attr(struct perf_event_attr *attr,
>>>>>         return 0;
>>>>>     }
>>>>>
>>>>> -static int get_config_terms(const struct parse_events_terms *head_config,
>>>>> -                         struct list_head *head_terms)
>>>>> +static struct evsel_config_term *add_config_term(enum evsel_term_type type,
>>>>> +                                              struct list_head *head_terms,
>>>>> +                                              bool weak)
>>>>>     {
>>>>> -#define ADD_CONFIG_TERM(__type, __weak)                              \
>>>>> -     struct evsel_config_term *__t;                  \
>>>>> -                                                             \
>>>>> -     __t = zalloc(sizeof(*__t));                             \
>>>>> -     if (!__t)                                               \
>>>>> -             return -ENOMEM;                                 \
>>>>> -                                                             \
>>>>> -     INIT_LIST_HEAD(&__t->list);                             \
>>>>> -     __t->type       = EVSEL__CONFIG_TERM_ ## __type;        \
>>>>> -     __t->weak       = __weak;                               \
>>>>> -     list_add_tail(&__t->list, head_terms)
>>>>> -
>>>>> -#define ADD_CONFIG_TERM_VAL(__type, __name, __val, __weak)   \
>>>>> -do {                                                         \
>>>>> -     ADD_CONFIG_TERM(__type, __weak);                        \
>>>>> -     __t->val.__name = __val;                                \
>>>>> -} while (0)
>>>>> +     struct evsel_config_term *t;
>>>>>
>>>>> -#define ADD_CONFIG_TERM_STR(__type, __val, __weak)           \
>>>>> -do {                                                         \
>>>>> -     ADD_CONFIG_TERM(__type, __weak);                        \
>>>>> -     __t->val.str = strdup(__val);                           \
>>>>> -     if (!__t->val.str) {                                    \
>>>>> -             zfree(&__t);                                    \
>>>>> -             return -ENOMEM;                                 \
>>>>> -     }                                                       \
>>>>> -     __t->free_str = true;                                   \
>>>>> -} while (0)
>>>>> +     t = zalloc(sizeof(*t));
>>>>> +     if (!t)
>>>>> +             return NULL;
>>>>> +
>>>>> +     INIT_LIST_HEAD(&t->list);
>>>>> +     t->type = type;
>>>>> +     t->weak = weak;
>>>>> +     list_add_tail(&t->list, head_terms);
>>>>>
>>>>> +     return t;
>>>>> +}
>>>>> +
>>>>> +static int get_config_terms(const struct parse_events_terms *head_config,
>>>>> +                         struct list_head *head_terms)
>>>>> +{
>>>>>         struct parse_events_term *term;
>>>>>
>>>>>         list_for_each_entry(term, &head_config->terms, list) {
>>>>> +             struct evsel_config_term *new_term;
>>>>> +             enum evsel_term_type new_type;
>>>>> +             char *str = NULL;
>>>>> +             u64 val;
>>>>> +
>>>>>                 switch (term->type_term) {
>>>>>                 case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
>>>>> -                     ADD_CONFIG_TERM_VAL(PERIOD, period, term->val.num, term->weak);
>>>>> +                     new_type = EVSEL__CONFIG_TERM_PERIOD;
>>>>> +                     val = term->val.num;
>>>>>                         break;
>>>>>                 case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
>>>>> -                     ADD_CONFIG_TERM_VAL(FREQ, freq, term->val.num, term->weak);
>>>>> +                     new_type = EVSEL__CONFIG_TERM_FREQ;
>>>>> +                     val = term->val.num;
>>>>>                         break;
>>>>>                 case PARSE_EVENTS__TERM_TYPE_TIME:
>>>>> -                     ADD_CONFIG_TERM_VAL(TIME, time, term->val.num, term->weak);
>>>>> +                     new_type = EVSEL__CONFIG_TERM_TIME;
>>>>> +                     val = term->val.num;
>>>>>                         break;
>>>>>                 case PARSE_EVENTS__TERM_TYPE_CALLGRAPH:
>>>>> -                     ADD_CONFIG_TERM_STR(CALLGRAPH, term->val.str, term->weak);
>>>>> +                     new_type = EVSEL__CONFIG_TERM_CALLGRAPH;
>>>>> +                     str = term->val.str;
>>>>>                         break;
>>>>>                 case PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE:
>>>>> -                     ADD_CONFIG_TERM_STR(BRANCH, term->val.str, term->weak);
>>>>> +                     new_type = EVSEL__CONFIG_TERM_BRANCH;
>>>>> +                     str = term->val.str;
>>>>>                         break;
>>>>>                 case PARSE_EVENTS__TERM_TYPE_STACKSIZE:
>>>>> -                     ADD_CONFIG_TERM_VAL(STACK_USER, stack_user,
>>>>> -                                         term->val.num, term->weak);
>>>>> +                     new_type = EVSEL__CONFIG_TERM_STACK_USER;
>>>>> +                     val = term->val.num;
>>>>>                         break;
>>>>>                 case PARSE_EVENTS__TERM_TYPE_INHERIT:
>>>>> -                     ADD_CONFIG_TERM_VAL(INHERIT, inherit,
>>>>> -                                         term->val.num ? 1 : 0, term->weak);
>>>>> +                     new_type = EVSEL__CONFIG_TERM_INHERIT;
>>>>> +                     val = term->val.num ? 1 : 0;
>>>>>                         break;
>>>>>                 case PARSE_EVENTS__TERM_TYPE_NOINHERIT:
>>>>> -                     ADD_CONFIG_TERM_VAL(INHERIT, inherit,
>>>>> -                                         term->val.num ? 0 : 1, term->weak);
>>>>> +                     new_type = EVSEL__CONFIG_TERM_INHERIT;
>>>>> +                     val = term->val.num ? 0 : 1;
>>>>>                         break;
>>>>>                 case PARSE_EVENTS__TERM_TYPE_MAX_STACK:
>>>>> -                     ADD_CONFIG_TERM_VAL(MAX_STACK, max_stack,
>>>>> -                                         term->val.num, term->weak);
>>>>> +                     new_type = EVSEL__CONFIG_TERM_MAX_STACK;
>>>>> +                     val = term->val.num;
>>>>>                         break;
>>>>>                 case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
>>>>> -                     ADD_CONFIG_TERM_VAL(MAX_EVENTS, max_events,
>>>>> -                                         term->val.num, term->weak);
>>>>> +                     new_type = EVSEL__CONFIG_TERM_MAX_EVENTS;
>>>>> +                     val = term->val.num;
>>>>>                         break;
>>>>>                 case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
>>>>> -                     ADD_CONFIG_TERM_VAL(OVERWRITE, overwrite,
>>>>> -                                         term->val.num ? 1 : 0, term->weak);
>>>>> +                     new_type = EVSEL__CONFIG_TERM_OVERWRITE;
>>>>> +                     val = term->val.num ? 1 : 0;
>>>>>                         break;
>>>>>                 case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
>>>>> -                     ADD_CONFIG_TERM_VAL(OVERWRITE, overwrite,
>>>>> -                                         term->val.num ? 0 : 1, term->weak);
>>>>> +                     new_type = EVSEL__CONFIG_TERM_OVERWRITE;
>>>>> +                     val = term->val.num ? 0 : 1;
>>>>>                         break;
>>>>>                 case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
>>>>> -                     ADD_CONFIG_TERM_STR(DRV_CFG, term->val.str, term->weak);
>>>>> +                     new_type = EVSEL__CONFIG_TERM_DRV_CFG;
>>>>> +                     str = term->val.str;
>>>>>                         break;
>>>>>                 case PARSE_EVENTS__TERM_TYPE_PERCORE:
>>>>> -                     ADD_CONFIG_TERM_VAL(PERCORE, percore,
>>>>> -                                         term->val.num ? true : false, term->weak);
>>>>> +                     new_type = EVSEL__CONFIG_TERM_PERCORE;
>>>>> +                     val = term->val.num ? true : false;
>>>>>                         break;
>>>>>                 case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
>>>>> -                     ADD_CONFIG_TERM_VAL(AUX_OUTPUT, aux_output,
>>>>> -                                         term->val.num ? 1 : 0, term->weak);
>>>>> +                     new_type = EVSEL__CONFIG_TERM_AUX_OUTPUT;
>>>>> +                     val = term->val.num ? 1 : 0;
>>>>>                         break;
>>>>>                 case PARSE_EVENTS__TERM_TYPE_AUX_ACTION:
>>>>> -                     ADD_CONFIG_TERM_STR(AUX_ACTION, term->val.str, term->weak);
>>>>> +                     new_type = EVSEL__CONFIG_TERM_AUX_ACTION;
>>>>> +                     str = term->val.str;
>>>>>                         break;
>>>>>                 case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
>>>>> -                     ADD_CONFIG_TERM_VAL(AUX_SAMPLE_SIZE, aux_sample_size,
>>>>> -                                         term->val.num, term->weak);
>>>>> +                     new_type = EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE;
>>>>> +                     val = term->val.num;
>>>>>                         break;
>>>>>                 case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
>>>>> -                     ADD_CONFIG_TERM_STR(RATIO_TO_PREV, term->val.str, term->weak);
>>>>> +                     new_type = EVSEL__CONFIG_TERM_RATIO_TO_PREV;
>>>>> +                     str = term->val.str;
>>>>>                         break;
>>>>>                 case PARSE_EVENTS__TERM_TYPE_USER:
>>>>>                 case PARSE_EVENTS__TERM_TYPE_CONFIG:
>>>>> @@ -1229,7 +1231,23 @@ do {                                                           \
>>>>>                 case PARSE_EVENTS__TERM_TYPE_RAW:
>>>>>                 case PARSE_EVENTS__TERM_TYPE_CPU:
>>>>>                 default:
>>>>> -                     break;
>>>>> +                     /* Don't add a new term for these ones */
>>>>> +                     continue;
>>>>> +             }
>>>>> +
>>>>> +             new_term = add_config_term(new_type, head_terms, term->weak);
>>>>> +             if (!new_term)
>>>>> +                     return -ENOMEM;
>>>>> +
>>>>> +             if (str) {
>>>>> +                     new_term->val.str = strdup(str);
>>>>> +                     if (!new_term->val.str) {
>>>>> +                             zfree(&new_term);
>>>>> +                             return -ENOMEM;
>>>>> +                     }
>>>>> +                     new_term->free_str = true;
>>>>> +             } else {
>>>>
>>>> This will incorrectly hit the else if term->val.str is NULL. Not sure if
>>>> that can happen but will fix anyway.
>>>>
>>>>> +                     new_term->val.val = val;
>>>>
>>>> There's an uninitialized variable warning for val here on release
>>>> builds. Will fix too
>>>
>>> I'm not sure how I feel about the change, but did you check that it is
>>> ubsan clean? I worry it is introducing writes to "val" and then reads
>>> from say "period" in the evsel_config_term val union. I believe ubsan
>>> will flag this as:
>>> https://en.cppreference.com/w/cpp/language/union.html
>>> "It is undefined behavior to read from the member of the union that
>>> wasn't most recently written."
>>>
>>> Thanks,
>>> Ian
>>>
>>
>> Maybe for C++, but not for C [1]:
>>
>>     Accessing my_union.i after most recently writing to the other member,
>>     my_union.d, is an allowed form of type-punning in C, provided that the
>>     member read is not larger than the one whose value was set
>>
>> Type punning with unions is widely used in the kernel and there are a
>> couple of instances in Perf. There are tons of discussions about it on
>> the mailing lists too. I can check it with ubsan though.
> 
> Thanks. I'm mostly worried about ubsan being clean. One of those
> mailing list discussions, or sadly outside the usual trolls lack of
> discussion, is my trying to remove a prevalent source of type punning:
> https://lore.kernel.org/lkml/20251016205126.2882625-1-irogers@google.com/
> 
> Ian
> 

No ubsan issues on any Perf tests from this, but I did forget a free in 
the new test that I saw with asan so I'll send a new version.


>> [1]: https://en.wikipedia.org/wiki/Type_punning#C_and_C++
>>
>>>>>                 }
>>>>>         }
>>>>>         return 0;
>>>>> @@ -1290,10 +1308,16 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
>>>>>                 }
>>>>>         }
>>>>>
>>>>> -     if (bits)
>>>>> -             ADD_CONFIG_TERM_VAL(CFG_CHG, cfg_chg, bits, false);
>>>>> +     if (bits) {
>>>>> +             struct evsel_config_term *new_term;
>>>>> +
>>>>> +             new_term = add_config_term(EVSEL__CONFIG_TERM_CFG_CHG,
>>>>> +                                        head_terms, false);
>>>>> +             if (!new_term)
>>>>> +                     return -ENOMEM;
>>>>> +             new_term->val.cfg_chg = bits;
>>>>> +     }
>>>>>
>>>>> -#undef ADD_CONFIG_TERM
>>>>>         return 0;
>>>>>     }
>>>>>
>>>>>
>>>>
>>

