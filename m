Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC5EC4338F
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 Aug 2021 16:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE75861056
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 Aug 2021 16:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242075AbhHYQz0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 Aug 2021 12:55:26 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3692 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhHYQz0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Aug 2021 12:55:26 -0400
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GvsVs5lK7z67GvM;
        Thu, 26 Aug 2021 00:53:25 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Wed, 25 Aug 2021 18:54:37 +0200
Received: from [10.47.26.214] (10.47.26.214) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 25 Aug
 2021 17:54:36 +0100
Subject: Re: [Question] perf tools: lex parsing issue
To:     Ian Rogers <irogers@google.com>
CC:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <2e52bc21-8e60-f1fc-804b-d8993ca7c482@huawei.com>
 <CAP-5=fXqM4Y5R5BXJb9Caf8NO1Oyz+qFaote3AqFu0MDGCvgAQ@mail.gmail.com>
 <e6157b05-fadd-b15d-17cf-9d964517da9c@huawei.com>
 <CAP-5=fW4dWDH+=VLWc0jjRBDrU2qGQh9aUXhVp-Mvdme2HZrLA@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <055803d6-b483-f839-22fb-d84fad404bcf@huawei.com>
Date:   Wed, 25 Aug 2021 17:58:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAP-5=fW4dWDH+=VLWc0jjRBDrU2qGQh9aUXhVp-Mvdme2HZrLA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.26.214]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 25/08/2021 17:47, Ian Rogers wrote:
> On Wed, Aug 25, 2021 at 7:32 AM John Garry<john.garry@huawei.com>  wrote:
>> On 25/08/2021 01:13, Ian Rogers wrote:
>>
>> Thanks for getting back to me
>>
>>
>>>> + if (term->type_term == PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD) {
>>>> +       term->config = strdup("period");
>>>> + }
>>>> +
>>>> if (!head) {
>>>>           parse_events_term__delete(term);
>>>>           YYABORT;
>>>> --
>>>>
>>>> ----8-----
>>> Agreed this is hacky,
>> This might be a*bit*  better:
>>
>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
>> index e5eae23cfceb..e597beaaa179 100644
>> --- a/tools/perf/util/parse-events.c
>> +++ b/tools/perf/util/parse-events.c
>> @@ -1058,6 +1058,13 @@ static const char
>> *config_term_names[__PARSE_EVENTS__TERM_TYPE_NR] = {
>>          [PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE]       = "aux-sample-size",
>>    };
>>
>> +const char * get_config_term(int term_type)
>> +{
>> +       if (term_type >= __PARSE_EVENTS__TERM_TYPE_NR)
>> +               return "";
>> +       return config_term_names[term_type];
>> +}
>> +
>>    static bool config_term_shrinked;
>>
>>    static bool
>> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
>> index bf6e41aa9b6a..0f658732535f 100644
>> --- a/tools/perf/util/parse-events.h
>> +++ b/tools/perf/util/parse-events.h
>> @@ -90,6 +90,8 @@ enum {
>>          __PARSE_EVENTS__TERM_TYPE_NR,
>>    };
>>
>> +const char *get_config_term(int term_type);
>> +
>>    struct parse_events_array {
>>          size_t nr_ranges;
>>          struct {
>> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
>> index 9321bd0e2f76..8d6d3fae226d 100644
>> --- a/tools/perf/util/parse-events.y
>> +++ b/tools/perf/util/parse-events.y
>> @@ -832,8 +832,9 @@ PE_TERM '=' PE_NAME
>>    PE_TERM '=' PE_VALUE
>>    {
>>          struct parse_events_term *term;
>> +       char *config = strdup(get_config_term($1));
>>
>> -       ABORT_ON(parse_events_term__num(&term, (int)$1, NULL, $3, false, &@1,
>> &@3));
>> +       ABORT_ON(parse_events_term__num(&term, (int)$1, config, $3, false,
>> &@1, &@3));
>>          $$ = term;
>>    }
>>
>>
>>> I think it'd be better to fix this up in the
>>> output. For example:
>>>
>>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>>> index 6cdbee8a12e7..c77c42275efa 100644
>>> --- a/tools/perf/util/pmu.c
>>> +++ b/tools/perf/util/pmu.c
>>> @@ -365,15 +365,21 @@ static int __perf_pmu__new_alias(struct
>>> list_head *list, char *dir, char *name,
>>>           memset(newval, 0, sizeof(newval));
>>>           ret = 0;
>>>           list_for_each_entry(term, &alias->terms, list) {
>>> +               const char * config = term->config;
>>> +
>>>                   if (ret)
>>>                           ret += scnprintf(newval + ret, sizeof(newval) - ret,
>>>                                            ",");
>>> +               if (!config) {
>>> +                       /* Note: config_term_names in parse_events.c
>>> isn't accessible */
>>> +                       config = config_term_names[term->type_term];
>> We could just expose some parse-events.c API, like above.
>>
>>> +               }
>>>                   if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
>>>                           ret += scnprintf(newval + ret, sizeof(newval) - ret,
>>> -                                        "%s=%#x", term->config, term->val.num);
>>> +                                        "%s=%#x", config, term->val.num);
>>>                   else if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
>>>                           ret += scnprintf(newval + ret, sizeof(newval) - ret,
>>> -                                        "%s=%s", term->config, term->val.str);
>>> +                                        "%s=%s", config, term->val.str);
>>>           }
>>>
>>>           alias->name = strdup(name);
>> But how about this alternative simple one:
>>
>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
>> index e5eae23cfceb..9e5df934d22d 100644
>> --- a/tools/perf/util/parse-events.c
>> +++ b/tools/perf/util/parse-events.c
>> @@ -3084,7 +3084,7 @@ int parse_events_term__num(struct
>> parse_events_term **term,
>>          struct parse_events_term temp = {
>>                  .type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
>>                  .type_term = type_term,
>> -               .config    = config,
>> +               .config    = config ? : strdup(config_term_names[type_term]),
>>                  .no_value  = no_value,
>>                  .err_term  = loc_term ? loc_term->first_column : 0,
>>                  .err_val   = loc_val  ? loc_val->first_column  : 0,
>> --
> If you have this change isn't the change to parse_events_term__num()
> unnecessary?

eh, this is parse_events_term__num().

Anyway, yes, this 1-line change in parse_events_term__num() only does 
look to fix it. More testing required, though.

This 1 liner fix looks good to me.

Cheers,
John

