Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B4BC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 14:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B310619F6
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 14:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238099AbhKQOFk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 Nov 2021 09:05:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57006 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238051AbhKQOFg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Nov 2021 09:05:36 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHE1Y6t023965;
        Wed, 17 Nov 2021 14:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=87Lijx6+c/beskAGoFTtexlQyM1ItdlcJgQznwQi5Ks=;
 b=HHQfMgOMSToJ5iXzLR6MDyHSq1uLHapOIhM/r7lZIOMYHhlZdbEyvoAUa6KwJkzw9bVk
 9ZIct8wqaGW3pLkPq5ZV76FBGNW8/K9n4EDRo7SB1RCyr6s3vEEke3XEX/S2s4EWjdEv
 WSZwdd6rqeIoAdX89R/d5hpWOs2xG1ZoL2mlbj8LK8cWtCiwHkIoz7tbYPrz/lViJxxH
 oUfPsRxW6fcZtJ1MbzV1ObIkx4XkbFLOtnBpI4xwQe8wOxSU6Cs7Le8Ktr7PDhctZaWp
 ImFFMcP7pWQy78Ew6h8t34ylMNpwWAecK1fAaR2VRcWdQKDTTr+sQt8J06OZf0lyAVsd eA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cd34wg0wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 14:02:26 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AHE2PMa026428;
        Wed, 17 Nov 2021 14:02:25 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cd34wg0vu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 14:02:25 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AHDn3gI002226;
        Wed, 17 Nov 2021 14:02:23 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3ca50ban1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 14:02:22 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AHE2B3X27853288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 14:02:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76B7A42045;
        Wed, 17 Nov 2021 14:02:11 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B9A142063;
        Wed, 17 Nov 2021 14:02:07 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.2.55])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Nov 2021 14:02:06 +0000 (GMT)
Subject: Re: [PATCH 2/2] perf parse-events: Architecture specific leader
 override
To:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Cc:     John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211113071548.372572-1-irogers@google.com>
 <20211113071548.372572-2-irogers@google.com> <YZFBDI6oPMidX0KO@krava>
 <CAP-5=fWzzggdSv7bUm-+Ed6LfoUa1ce02n-bEOCqWWip4L8TLg@mail.gmail.com>
 <CAP-5=fWSHDS3GQorpYEK3qhWSCJE-KJdOK36c0OznZQT88C3YQ@mail.gmail.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <6d1fcb97-223d-7d8e-b5cb-0f10dbc62880@linux.ibm.com>
Date:   Wed, 17 Nov 2021 19:32:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAP-5=fWSHDS3GQorpYEK3qhWSCJE-KJdOK36c0OznZQT88C3YQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0Pr5f_9ldU7W47rDB_sOOOm3q_MnRQEi
X-Proofpoint-ORIG-GUID: G3_sA8SplRGCEFS7QhSqzZLu7UnzND1V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_05,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 clxscore=1011 mlxlogscore=999
 bulkscore=0 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170072
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 11/16/21 6:31 AM, Ian Rogers wrote:
> On Sun, Nov 14, 2021 at 10:17 AM Ian Rogers <irogers@google.com> wrote:
>>
>> On Sun, Nov 14, 2021 at 9:02 AM Jiri Olsa <jolsa@redhat.com> wrote:
>>>
>>> On Fri, Nov 12, 2021 at 11:15:48PM -0800, Ian Rogers wrote:
>>>> Currently topdown events must appear after a slots event:
>>>>
>>>> $ perf stat -e '{slots,topdown-fe-bound}' /bin/true
>>>>
>>>>  Performance counter stats for '/bin/true':
>>>>
>>>>          3,183,090      slots
>>>>            986,133      topdown-fe-bound
>>>>
>>>> Reversing the events yields:
>>>>
>>>> $ perf stat -e '{topdown-fe-bound,slots}' /bin/true
>>>> Error:
>>>> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (topdown-fe-bound).
>>>
>>> why is this actually failing?
>>>
>>>>
>>>> For metrics the order of events is determined by iterating over a
>>>> hashmap, and so slots isn't guaranteed to be first which can yield this
>>>> error.
>>>>
>>>> Change the set_leader in parse-events, called when a group is closed, so
>>>> that rather than always making the first event the leader, if the slots
>>>> event exists then it is made the leader. It is then moved to the head of
>>>> the evlist otherwise it won't be opened in the correct order.
>>>>
>>>> The result is:
>>>>
>>>> $ perf stat -e '{topdown-fe-bound,slots}' /bin/true
>>>>
>>>>  Performance counter stats for '/bin/true':
>>>>
>>>>          3,274,795      slots
>>>>          1,001,702      topdown-fe-bound
>>>>
>>>> A problem with this approach is the slots event is identified by name,
>>>> names can be overwritten like 'cpu/slots,name=foo/' and this causes the
>>>> leader change to fail.
>>>
>>> would it be better then to move this shuffle to the metric code directly,
>>> and make sure it only spits 'good' order of events?
>>>
>>> and keep "-e '{topdown-fe-bound,slots}'" to fail if user specifies that on
>>> the command line
>>
>> It's an alternative to do that, but the people I spoke to preferred
>> having parse-events do this. I'm not sure what Andi's opinion is.
>> There is a general frustration about how brittle the slots event is,
>> and so this does make it less brittle.
> 
> A different problem this fixes is if you have a group like
> '{instructions,slots,topdown-fe-bound}' then slots still has to be the
> group leader even though it is appearing before the topdown event. So
> before the patch:

Hi Ian,
     Thanks for the patch series. We also have similar scenario in case
of powerpc for L2/L3 bus events, where it needs specific event as a
group leader. So the solution in this patch series will be helpful in
handling it.

Patch series looks good to me.

Reviewed-by: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain


> 
> $ perf stat -e '{instructions,slots,topdown-fe-bound}' -a -- sleep 2
> 
>  Performance counter stats for 'system wide':
> 
>      <not counted>      instructions
>      <not counted>      slots
>    <not supported>      topdown-fe-bound
> 
>        2.006410898 seconds time elapsed
> 
> After:
> 
> $ perf stat -e '{instructions,slots,topdown-fe-bound}' -a -- sleep 2
> 
>  Performance counter stats for 'system wide':
> 
>         2572632080      slots
>          362537420      instructions
>          742416906      topdown-fe-bound
> 
>        2.005875050 seconds time elapsed
> 
> Thanks,
> Ian
> 
>>>>
>>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>>> ---
>>>>  tools/perf/arch/x86/util/evlist.c | 17 +++++++++++++++++
>>>>  tools/perf/util/evlist.h          |  1 +
>>>>  tools/perf/util/parse-events.c    | 16 +++++++++++-----
>>>>  tools/perf/util/parse-events.h    |  4 ++--
>>>>  tools/perf/util/parse-events.y    | 12 ++++++++----
>>>>  5 files changed, 39 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
>>>> index 0b0951030a2f..1624372b2da2 100644
>>>> --- a/tools/perf/arch/x86/util/evlist.c
>>>> +++ b/tools/perf/arch/x86/util/evlist.c
>>>> @@ -17,3 +17,20 @@ int arch_evlist__add_default_attrs(struct evlist *evlist)
>>>>       else
>>>>               return parse_events(evlist, TOPDOWN_L1_EVENTS, NULL);
>>>>  }
>>>> +
>>>> +struct evsel *arch_evlist__leader(struct list_head *list)
>>>> +{
>>>> +     struct evsel *evsel, *first;
>>>> +
>>>> +     first = list_entry(list->next, struct evsel, core.node);
>>>> +
>>>> +     if (!pmu_have_event("cpu", "slots"))
>>>> +             return first;
>>>> +
>>>> +     __evlist__for_each_entry(list, evsel) {
>>>> +             if (evsel->pmu_name && !strcmp(evsel->pmu_name, "cpu") &&
>>>> +                     evsel->name && strstr(evsel->name, "slots"))
>>>> +                     return evsel;
>>>> +     }
>>>> +     return first;
>>>> +}
>>>> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
>>>> index 97bfb8d0be4f..993437ffe429 100644
>>>> --- a/tools/perf/util/evlist.h
>>>> +++ b/tools/perf/util/evlist.h
>>>> @@ -110,6 +110,7 @@ int __evlist__add_default_attrs(struct evlist *evlist,
>>>>       __evlist__add_default_attrs(evlist, array, ARRAY_SIZE(array))
>>>>
>>>>  int arch_evlist__add_default_attrs(struct evlist *evlist);
>>>> +struct evsel *arch_evlist__leader(struct list_head *list);
>>>>
>>>>  int evlist__add_dummy(struct evlist *evlist);
>>>>
>>>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
>>>> index 6308ba739d19..a2f4c086986f 100644
>>>> --- a/tools/perf/util/parse-events.c
>>>> +++ b/tools/perf/util/parse-events.c
>>>> @@ -1821,22 +1821,28 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
>>>>       return ret;
>>>>  }
>>>>
>>>> -void parse_events__set_leader(char *name, struct list_head *list,
>>>> -                           struct parse_events_state *parse_state)
>>>> +__weak struct evsel *arch_evlist__leader(struct list_head *list)
>>>> +{
>>>> +     return list_entry(list->next, struct evsel, core.node);
>>>> +}
>>>> +
>>>> +struct list_head *parse_events__set_leader(char *name, struct list_head *list,
>>>> +                                     struct parse_events_state *parse_state)
>>>>  {
>>>>       struct evsel *leader;
>>>>
>>>>       if (list_empty(list)) {
>>>>               WARN_ONCE(true, "WARNING: failed to set leader: empty list");
>>>> -             return;
>>>> +             return NULL;
>>>>       }
>>>>
>>>>       if (parse_events__set_leader_for_uncore_aliase(name, list, parse_state))
>>>> -             return;
>>>> +             return NULL;
>>>>
>>>> -     leader = list_entry(list->next, struct evsel, core.node);
>>>> +     leader = arch_evlist__leader(list);
>>>>       __perf_evlist__set_leader(list, &leader->core);
>>>>       leader->group_name = name ? strdup(name) : NULL;
>>>> +     return &leader->core.node;
>>>>  }
>>>>
>>>>  /* list_event is assumed to point to malloc'ed memory */
>>>> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
>>>> index c7fc93f54577..8a6e6b4d5cbe 100644
>>>> --- a/tools/perf/util/parse-events.h
>>>> +++ b/tools/perf/util/parse-events.h
>>>> @@ -211,8 +211,8 @@ int parse_events_copy_term_list(struct list_head *old,
>>>>
>>>>  enum perf_pmu_event_symbol_type
>>>>  perf_pmu__parse_check(const char *name);
>>>> -void parse_events__set_leader(char *name, struct list_head *list,
>>>> -                           struct parse_events_state *parse_state);
>>>> +struct list_head *parse_events__set_leader(char *name, struct list_head *list,
>>>> +                                     struct parse_events_state *parse_state);
>>>>  void parse_events_update_lists(struct list_head *list_event,
>>>>                              struct list_head *list_all);
>>>>  void parse_events_evlist_error(struct parse_events_state *parse_state,
>>>> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
>>>> index 174158982fae..5358c400f938 100644
>>>> --- a/tools/perf/util/parse-events.y
>>>> +++ b/tools/perf/util/parse-events.y
>>>> @@ -199,20 +199,24 @@ group_def
>>>>  group_def:
>>>>  PE_NAME '{' events '}'
>>>>  {
>>>> -     struct list_head *list = $3;
>>>> +     struct list_head *new_head, *list = $3;
>>>>
>>>>       inc_group_count(list, _parse_state);
>>>> -     parse_events__set_leader($1, list, _parse_state);
>>>> +     new_head = parse_events__set_leader($1, list, _parse_state);
>>>> +     if (new_head)
>>>> +             list_move(new_head, list);
>>>
>>> why not put these last 2 lines to parse_events__set_leader as well?
>>
>> I can move that, but I'll try to motivate having it this way. The list
>> logic in Linux I find troublesome. In parse-events.y we have a list
>> head that is just a next, prev pointer and not full evsel in a list.
>> So for {topdown-fe-bound,slots} in parse-events.y we have a list of:
>>
>> head -next-> evsel("topdown-fe-bound") -next-> evsel("slots")
>>
>> But in __perf_evlist__set_leader the list doesn't have the head:
>>
>> evsel("topdown-fe-bound") -next-> evsel("slots")
>>
>> The list_move is changing the list to:
>>
>> head -next-> evsel("slots") -next-> evsel("topdown-fe-bound")
>>
>> which isn't possible in __perf_evlist__set_leader as the head has
>> gone. I felt having the list_move in parse_events__set_leader made it
>> look like the leader is being placed second rather than at the head.
>> So this was an attempt to make the code more intention revealing, but
>> that could also be done by some comments, it's just in
>> parse_events__set_leader we have the two styles of lists in play.
>>
>> While I'm complaining, there are many brittle assumptions about evlist
>> that it may be worth adding some more assertions for. There is already
>> an assertion that the leader was opened before its siblings. There are
>> assumptions that the idx given to an evsel are incremental and that
>> for the leader 'idx - prev->idx' will yield the number of list
>> elements. My concern is for libperf users, it doesn't seem
>> unreasonable that they will want to manipulate the evlist but given
>> the assumptions they will likely find bugs - such as idx being used to
>> index an array and reordering breaking things. The metric code would
>> be a customer of reordering were it to need to move slots, but when I
>> experimented with this it easily broke things - which motivates doing
>> it in parse-events or more likely for the metrics, when generating the
>> parse-events string.
>>
>> Thanks,
>> Ian
>>
>>
>>
>>
>>>>       free($1);
>>>>       $$ = list;
>>>>  }
>>>>  |
>>>>  '{' events '}'
>>>>  {
>>>> -     struct list_head *list = $2;
>>>> +     struct list_head *new_head, *list = $2;
>>>>
>>>>       inc_group_count(list, _parse_state);
>>>> -     parse_events__set_leader(NULL, list, _parse_state);
>>>> +     new_head = parse_events__set_leader(NULL, list, _parse_state);
>>>> +     if (new_head)
>>>> +             list_move(new_head, list);
>>>
>>> same
>>>
>>> thanks,
>>> jirka
>>>
