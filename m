Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B017C2D0E4
	for <linux-perf-users@archiver.kernel.org>; Thu, 12 Nov 2020 19:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2D9720759
	for <linux-perf-users@archiver.kernel.org>; Thu, 12 Nov 2020 19:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgKLTmt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 12 Nov 2020 14:42:49 -0500
Received: from foss.arm.com ([217.140.110.172]:56488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgKLTms (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 12 Nov 2020 14:42:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0E381042;
        Thu, 12 Nov 2020 11:42:47 -0800 (PST)
Received: from [10.57.59.253] (unknown [10.57.59.253])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D3633F6CF;
        Thu, 12 Nov 2020 11:42:44 -0800 (PST)
Subject: Re: [PATCH V2 3/3] perf tools: fix perf stat with large socket IDs
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
References: <20201004203545.GB217601@krava>
 <20201028094311.8563-1-james.clark@arm.com>
 <20201028094311.8563-4-james.clark@arm.com> <20201108124412.GA196289@krava>
From:   James Clark <james.clark@arm.com>
Message-ID: <ec3e153b-f5b9-dc70-a012-d180d1f32932@arm.com>
Date:   Thu, 12 Nov 2020 21:42:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201108124412.GA196289@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 08/11/2020 14:44, Jiri Olsa wrote:
> On Wed, Oct 28, 2020 at 09:43:11AM +0000, James Clark wrote:
> 
> SNIP
> 
>> -		 * Encode socket in bit range 31:24
>> -		 * encode die id in bit range 23:16
>>  		 * core_id is relative to socket and die,
>>  		 * we need a global id. So we combine
>>  		 * socket + die id + core id
>>  		 */
>> -		if (WARN_ONCE(env->cpu[cpu].socket_id >> 8, "The socket id number is too big.\n"))
>> -			return cpu_map__empty_aggr_cpu_id();
>> -
>> -		if (WARN_ONCE(env->cpu[cpu].die_id >> 8, "The die id number is too big.\n"))
>> -			return cpu_map__empty_aggr_cpu_id();
>> -
>> -		if (WARN_ONCE(env->cpu[cpu].core_id >> 16, "The core id number is too big.\n"))
>> -			return cpu_map__empty_aggr_cpu_id();
>> -
>> -		core.id = (env->cpu[cpu].socket_id << 24) |
>> -		       (env->cpu[cpu].die_id << 16) |
>> -		       (env->cpu[cpu].core_id & 0xffff);
>> +		core.socket_id = env->cpu[cpu].socket_id;
>> +		core.die_id = env->cpu[cpu].die_id;
>> +		core.core_id = env->cpu[cpu].core_id;
> 
> all 3 functions above look like they could be united just
> to single one, because they are no longer steping on ech
> other data
> 
> perhaps best as separate patch, so the change is clean
> 
> there are also the 'system retrieval counter' functions,
> where it's possible better to keep it separated from
> performance reasons, but here it's just value assigment

Hi Jiri,

I have a new patchset ready without this change, and I started working on this, but I came
across some issues:

For example if all of the members are filled in regardless of the aggregation type,
then the comparison function that actually decides whether cores should be aggregated or
not will need to be modified to accept the current aggregation mode.

This would be possible, but would have a knock on effect when the values are read
from the system if the code is to be shared.

Also there is a second issue where some of the current functions have different failure
conditions. For example if socket can't be read, then that mode will fail, but other
aggregation modes will still work. If we make the change to unify all the functions then
that could get a bit more complicated.

I just wanted to get your opinion whether to submit the broken up set without this extra
change or carry on trying to work out a solution?


Thanks
James

> 
> 
> SNIP
> 
>>  struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *data)
>>  {
>> -	int cpu, s;
>> +	int cpu;
>>  	struct aggr_cpu_id die_id = cpu_map__empty_aggr_cpu_id();
>>  
>>  	if (idx > map->nr)
>> @@ -201,28 +210,20 @@ struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *dat
>>  
>>  	cpu = map->map[idx];
>>  
>> -	die_id.id = cpu_map__get_die_id(cpu);
>> +	die_id.die_id = cpu_map__get_die_id(cpu);
>>  	/* There is no die_id on legacy system. */
>> -	if (die_id.id == -1)
>> -		die_id.id = 0;
>> -
>> -	s = cpu_map__get_socket(map, idx, data).id;
>> -	if (s == -1)
>> -		return cpu_map__empty_aggr_cpu_id();
>> +	if (die_id.die_id == -1)
>> +		die_id.die_id = 0;
> 
> please call the local variable just 'id',
> there are other places like this for socket/core..
> 
> SNIP
> 
>> diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
>> index f654a825dcfb..ba068f245809 100644
>> --- a/tools/perf/util/cpumap.h
>> +++ b/tools/perf/util/cpumap.h
>> @@ -8,7 +8,11 @@
>>  #include <perf/cpumap.h>
>>  
>>  struct aggr_cpu_id {
>> -	int id;
>> +	int socket_id;
>> +	int die_id;
>> +	int core_id;
>> +	int node_id;
>> +	int thread_id;
> 
> please don't use the _id suffix in here, there's already
> id in the struct name
> 
> 
>>  };
>>  
>>  struct cpu_aggr_map {
>> @@ -21,6 +25,7 @@ struct perf_record_cpu_map_data;
>>  
>>  struct perf_cpu_map *perf_cpu_map__empty_new(int nr);
>>  struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr);
>> +
>>  struct perf_cpu_map *cpu_map__new_data(struct perf_record_cpu_map_data *data);
>>  size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size);
>>  size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size);
>> @@ -46,21 +51,6 @@ static inline int cpu_map__socket(struct perf_cpu_map *sock, int s)
>>  	return sock->map[s];
>>  }
> 
> SNIP
> 
