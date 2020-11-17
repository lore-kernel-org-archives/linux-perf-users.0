Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837FFC2D0E4
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Nov 2020 14:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C5A92168B
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Nov 2020 14:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgKQOwW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 Nov 2020 09:52:22 -0500
Received: from foss.arm.com ([217.140.110.172]:59488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728820AbgKQOwV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Nov 2020 09:52:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3889730E;
        Tue, 17 Nov 2020 06:52:21 -0800 (PST)
Received: from [10.57.59.185] (unknown [10.57.59.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A59A43F718;
        Tue, 17 Nov 2020 06:52:19 -0800 (PST)
Subject: Re: [PATCH 07/13 v4] perf tools: restrict visibility of functions
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
References: <20201113172654.989-1-james.clark@arm.com>
 <20201113172654.989-8-james.clark@arm.com> <20201115211742.GC1081385@krava>
From:   James Clark <james.clark@arm.com>
Message-ID: <743b4758-8b35-0fb0-1c68-c5fff6d90b8b@arm.com>
Date:   Tue, 17 Nov 2020 16:52:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201115211742.GC1081385@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 15/11/2020 23:17, Jiri Olsa wrote:
> On Fri, Nov 13, 2020 at 07:26:48PM +0200, James Clark wrote:
>> These cpu_aggr_map refcounting functions are only used in
>> builtin-stat.c so their visibilty can be reduced to just
>> that file.
>>
>> No functional changes.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Jiri Olsa <jolsa@redhat.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Thomas Richter <tmricht@linux.ibm.com>
>> Cc: John Garry <john.garry@huawei.com>
>> ---
>>  tools/perf/builtin-stat.c | 15 +++++++++++++++
>>  tools/perf/util/cpumap.c  | 15 ---------------
>>  tools/perf/util/cpumap.h  |  2 --
>>  3 files changed, 15 insertions(+), 17 deletions(-)
>>
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index 7daac139f6cc..344e50651b55 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -1326,6 +1326,21 @@ static int perf_stat_init_aggr_mode(void)
>>  	return stat_config.cpus_aggr_map ? 0 : -ENOMEM;
>>  }
>>  
>> +static void cpu_aggr_map__delete(struct cpu_aggr_map *map)
>> +{
>> +	if (map) {
>> +		WARN_ONCE(refcount_read(&map->refcnt) != 0,
>> +			  "cpu_aggr_map refcnt unbalanced\n");
>> +		free(map);
>> +	}
>> +}
>> +
>> +static void cpu_aggr_map__put(struct cpu_aggr_map *map)
>> +{
>> +	if (map && refcount_dec_and_test(&map->refcnt))
>> +		cpu_aggr_map__delete(map);
>> +}
> 
> you could add them directly as static and skip this change

I think I was trying to avoid the compilation error from the static
functions not being used. But I moved the addition into the commit
where they are used in V5.

James

> 
> jirka
> 
>> +
>>  static void perf_stat__exit_aggr_mode(void)
>>  {
>>  	cpu_aggr_map__put(stat_config.aggr_map);
>> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
>> index e831a18ec95e..e90270f0be57 100644
>> --- a/tools/perf/util/cpumap.c
>> +++ b/tools/perf/util/cpumap.c
>> @@ -112,21 +112,6 @@ struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr)
>>  	return cpus;
>>  }
>>  
>> -void cpu_aggr_map__delete(struct cpu_aggr_map *map)
>> -{
>> -	if (map) {
>> -		WARN_ONCE(refcount_read(&map->refcnt) != 0,
>> -			  "cpu_aggr_map refcnt unbalanced\n");
>> -		free(map);
>> -	}
>> -}
>> -
>> -void cpu_aggr_map__put(struct cpu_aggr_map *map)
>> -{
>> -	if (map && refcount_dec_and_test(&map->refcnt))
>> -		cpu_aggr_map__delete(map);
>> -}
>> -
>>  static int cpu__get_topology_int(int cpu, const char *name, int *value)
>>  {
>>  	char path[PATH_MAX];
>> diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
>> index d82822ddcbce..b112069038be 100644
>> --- a/tools/perf/util/cpumap.h
>> +++ b/tools/perf/util/cpumap.h
>> @@ -21,8 +21,6 @@ struct perf_record_cpu_map_data;
>>  
>>  struct perf_cpu_map *perf_cpu_map__empty_new(int nr);
>>  struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr);
>> -void cpu_aggr_map__delete(struct cpu_aggr_map *map);
>> -void cpu_aggr_map__put(struct cpu_aggr_map *map);
>>  
>>  struct perf_cpu_map *cpu_map__new_data(struct perf_record_cpu_map_data *data);
>>  size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size);
>> -- 
>> 2.28.0
>>
> 
