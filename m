Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2375CC5519F
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Nov 2020 15:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C28DF2463D
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Nov 2020 15:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgKQPtB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 Nov 2020 10:49:01 -0500
Received: from foss.arm.com ([217.140.110.172]:60210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgKQPtB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Nov 2020 10:49:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EE281FB;
        Tue, 17 Nov 2020 07:49:00 -0800 (PST)
Received: from [10.57.59.185] (unknown [10.57.59.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F2613F719;
        Tue, 17 Nov 2020 07:48:59 -0800 (PST)
Subject: Re: [PATCH V2 2/3] perf tools: Replace aggregation ID with a struct
From:   James Clark <james.clark@arm.com>
To:     John Garry <john.garry@huawei.com>,
        linux-perf-users@vger.kernel.org, jolsa@redhat.com
References: <20201004203545.GB217601@krava>
 <20201028094311.8563-1-james.clark@arm.com>
 <20201028094311.8563-3-james.clark@arm.com>
 <0024879f-d326-966d-86b0-8cda91483bfe@huawei.com>
 <5ca5f80d-cae1-3756-13f7-21db6da89840@arm.com>
Message-ID: <fcc716b1-34f0-c03a-57aa-8ad4a1c753a4@arm.com>
Date:   Tue, 17 Nov 2020 17:48:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5ca5f80d-cae1-3756-13f7-21db6da89840@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 17/11/2020 17:05, James Clark wrote:
> 
> Hi John,
> 
> Sorry I missed your review comments here. Replies below:
> 
> On 12/11/2020 17:18, John Garry wrote:
>>
>>>   +static void cpu_aggr_map__delete(struct cpu_aggr_map *map)
>>> +{
>>> +    if (map) {
>>
>> is this check just paranoia?
>>
>>> +        WARN_ONCE(refcount_read(&map->refcnt) != 0,
>>> +              "cpu_aggr_map refcnt unbalanced\n");
>>
>> and this?
>>
>>> +        free(map);
>>> +    }
>>> +}
>>> +
> 
> The cpu_aggr_map__delete and cpu_aggr_map__put functions were direct
> copies of cpu_map__delete and cpu_map__put. I suppose there is more
> control over the usages of the new ones so the check could possibly be avoided.
> 
> It all depends on whether perf_stat__exit_aggr_mode() is only ever called
> once or not. But I think it might make sense to leave the checks for
> consistency and in case the maps are used somewhere else in the future.
> 
> 
>>> +static void cpu_aggr_map__put(struct cpu_aggr_map *map)
>>> +{
>>> +    if (map && refcount_dec_and_test(&map->refcnt))
>>> +        cpu_aggr_map__delete(map);
>>> +}
>>> +
>>>   static void perf_stat__exit_aggr_mode(void)
>>
>> ...
>>
>>>   +struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr)
>>> +{
>>> +    struct cpu_aggr_map *cpus = malloc(sizeof(*cpus) + sizeof(struct aggr_cpu_id) * nr);
>>> +
>>
>> if (!cpus)
>>     return NULL
>>
>> cpus->nr = nr;
>> ...
>>
>> this avoids extra indentation and {}
>>
> 
> Do you think I should also make this change to the existing perf_cpu_map__empty_new() function
> above for consistency?
> 
> 
>>> +    if (cpus != NULL) {
>>> +        int i;
>>> +
>>> +        cpus->nr = nr;
>>> +        for (i = 0; i < nr; i++)
>>> +            cpus->map[i] = cpu_map__empty_aggr_cpu_id();
>>> +
>>> +        refcount_set(&cpus->refcnt, 1);
>>> +    }
>>> +
>>> +    return cpus;
>>> +}
>>> +
>>>   static int cpu__get_topology_int(int cpu, const char *name, int *value)
>>>   {
>>>       char path[PATH_MAX];
>>> @@ -111,40 +128,47 @@ int cpu_map__get_socket_id(int cpu)
>>>       return ret ?: value;
>>>   }
>>>   -int cpu_map__get_socket(struct perf_cpu_map *map, int idx, void *data __maybe_unused)
>>> +struct aggr_cpu_id cpu_map__get_socket(struct perf_cpu_map *map, int idx,
>>> +                    void *data __maybe_unused)
>>>   {
>>>       int cpu;
>>> +    struct aggr_cpu_id socket = cpu_map__empty_aggr_cpu_id();
>>>         if (idx > map->nr)
>>> -        return -1;
>>> +        return cpu_map__empty_aggr_cpu_id();
>>>         cpu = map->map[idx];
>>>   -    return cpu_map__get_socket_id(cpu);
>>> +    socket.id = cpu_map__get_socket_id(cpu);
>>> +    return socket;
>>>   }
>>>   -static int cmp_ids(const void *a, const void *b)
>>> +static int cmp_aggr_cpu_id(const void *a_pointer, const void *b_pointer)
>>>   {
>>> -    return *(int *)a - *(int *)b;
>>> +    struct aggr_cpu_id *a = (struct aggr_cpu_id *)a_pointer;
>>> +    struct aggr_cpu_id *b = (struct aggr_cpu_id *)b_pointer;
>>> +
>>> +    return a->id - b->id;
>>>   }
>>>   -int cpu_map__build_map(struct perf_cpu_map *cpus, struct perf_cpu_map **res,
>>> -               int (*f)(struct perf_cpu_map *map, int cpu, void *data),
>>> +int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
>>> +               struct aggr_cpu_id (*f)(struct perf_cpu_map *map, int cpu, void *data),
>>>                  void *data)
>>>   {
>>> -    struct perf_cpu_map *c;
>>> +    struct cpu_aggr_map *c;
>>>       int nr = cpus->nr;
>>> -    int cpu, s1, s2;
>>> +    int cpu, s2;
>>> +    struct aggr_cpu_id s1;
>>>         /* allocate as much as possible */
>>> -    c = calloc(1, sizeof(*c) + nr * sizeof(int));
>>> +    c = calloc(1, sizeof(*c) + nr * sizeof(struct aggr_cpu_id));
>>>       if (!c)
>>>           return -1;
>>>         for (cpu = 0; cpu < nr; cpu++) {
>>>           s1 = f(cpus, cpu, data);
>>>           for (s2 = 0; s2 < c->nr; s2++) {
>>> -            if (s1 == c->map[s2])
>>> +            if (cpu_map__compare_aggr_cpu_id(s1, c->map[s2]))
>>>                   break;
>>>           }
>>>           if (s2 == c->nr) {
>>> @@ -153,7 +177,7 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct perf_cpu_map **res,
>>>           }
>>>       }
>>>       /* ensure we process id in increasing order */
>>> -    qsort(c->map, c->nr, sizeof(int), cmp_ids);
>>> +    qsort(c->map, c->nr, sizeof(struct aggr_cpu_id), cmp_aggr_cpu_id);
>>>         refcount_set(&c->refcnt, 1);
>>>       *res = c;
>>> @@ -167,23 +191,24 @@ int cpu_map__get_die_id(int cpu)
>>>       return ret ?: value;
>>>   }
>>>   -int cpu_map__get_die(struct perf_cpu_map *map, int idx, void *data)
>>> +struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *data)
>>>   {
>>> -    int cpu, die_id, s;
>>> +    int cpu, s;
>>> +    struct aggr_cpu_id die_id = cpu_map__empty_aggr_cpu_id();
>>>         if (idx > map->nr)
>>> -        return -1;
>>> +        return cpu_map__empty_aggr_cpu_id();
>>>         cpu = map->map[idx];
>>>   -    die_id = cpu_map__get_die_id(cpu);
>>> +    die_id.id = cpu_map__get_die_id(cpu);
>>>       /* There is no die_id on legacy system. */
>>> -    if (die_id == -1)
>>> -        die_id = 0;
>>> +    if (die_id.id == -1)
>>> +        die_id.id = 0;
>>>   -    s = cpu_map__get_socket(map, idx, data);
>>> +    s = cpu_map__get_socket(map, idx, data).id;
>>>       if (s == -1)
>>> -        return -1;
>>> +        return cpu_map__empty_aggr_cpu_id();
>>>         /*
>>>        * Encode socket in bit range 15:8
>>> @@ -191,13 +216,14 @@ int cpu_map__get_die(struct perf_cpu_map *map, int idx, void *data)
>>>        * we need a global id. So we combine
>>>        * socket + die id
>>>        */
>>> -    if (WARN_ONCE(die_id >> 8, "The die id number is too big.\n"))
>>> -        return -1;
>>> +    if (WARN_ONCE(die_id.id >> 8, "The die id number is too big.\n"))
>>> +        return cpu_map__empty_aggr_cpu_id();
>>>         if (WARN_ONCE(s >> 8, "The socket id number is too big.\n"))
>>> -        return -1;
>>> +        return cpu_map__empty_aggr_cpu_id();
>>>   -    return (s << 8) | (die_id & 0xff);
>>> +    die_id.id = (s << 8) | (die_id.id & 0xff);
>>> +    return die_id;
>>>   }
>>>     int cpu_map__get_core_id(int cpu)
>>> @@ -211,21 +237,22 @@ int cpu_map__get_node_id(int cpu)
>>>       return cpu__get_node(cpu);
>>>   }
>>>   -int cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data)
>>> +struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data)
>>>   {
>>> -    int cpu, s_die;
>>> +    int cpu;
>>> +    struct aggr_cpu_id core = cpu_map__empty_aggr_cpu_id();
>>>         if (idx > map->nr)
>>
>> should pre-existing code be idx >= map->nr? I didn't check the code any deeper
> 
> I think you might be right. But there is a mixture of > and >= throughout the file.
> So either the same mistake has been made several times or it's not zero indexed.
> 
> I will look into it.

Hi Garry,

Yes > is an issue and it should be >=. It probably hasn't caused a problem because
the function is never called with idx out of bounds.

I think I'd like to fix this in a separate patchset after this one as it's unrelated
to my change. Although it might have to wait until it's merged otherwise there would
probably be an annoying conflict.

What do you think?


Thanks
James

> 
> Thanks
> James
>>
>>> -        return -1;
>>> +        return cpu_map__empty_aggr_cpu_id();
>>>         cpu = map->map[idx];
>>>   
