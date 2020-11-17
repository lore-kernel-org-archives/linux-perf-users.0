Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486D2C64E69
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Nov 2020 14:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 067A822240
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Nov 2020 14:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbgKQOuZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 Nov 2020 09:50:25 -0500
Received: from foss.arm.com ([217.140.110.172]:59362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728894AbgKQOuZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Nov 2020 09:50:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8E6E101E;
        Tue, 17 Nov 2020 06:50:24 -0800 (PST)
Received: from [10.57.59.185] (unknown [10.57.59.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21ECC3F718;
        Tue, 17 Nov 2020 06:50:23 -0800 (PST)
Subject: Re: [PATCH 02/13 v4] perf tools: Use allocator for perf_cpu_map
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
 <20201113172654.989-3-james.clark@arm.com> <20201115211732.GB1081385@krava>
From:   James Clark <james.clark@arm.com>
Message-ID: <ba3819b1-8bb3-7bf8-7c80-3698a45f75f1@arm.com>
Date:   Tue, 17 Nov 2020 16:50:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201115211732.GB1081385@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 15/11/2020 23:17, Jiri Olsa wrote:
> On Fri, Nov 13, 2020 at 07:26:43PM +0200, James Clark wrote:
>> Use the existing allocator for perf_cpu_map to avoid use
>> of raw malloc. This could cause an issue in later commits
>> where the size of perf_cpu_map is changed.
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
>>  tools/perf/util/cpumap.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
>> index dc5c5e6fc502..fd7d0a77a9e6 100644
>> --- a/tools/perf/util/cpumap.c
>> +++ b/tools/perf/util/cpumap.c
>> @@ -132,15 +132,16 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct perf_cpu_map **res,
>>  		       int (*f)(struct perf_cpu_map *map, int cpu, void *data),
>>  		       void *data)
>>  {
>> -	struct perf_cpu_map *c;
>>  	int nr = cpus->nr;
>> +	struct perf_cpu_map *c = perf_cpu_map__empty_new(nr);
>>  	int cpu, s1, s2;
>>  
>> -	/* allocate as much as possible */
>> -	c = calloc(1, sizeof(*c) + nr * sizeof(int));
>>  	if (!c)
>>  		return -1;
>>  
>> +	/* Reset size as it may only be partially filled */
>> +	c->nr = 0;
>> +
>>  	for (cpu = 0; cpu < nr; cpu++) {
>>  		s1 = f(cpus, cpu, data);
>>  		for (s2 = 0; s2 < c->nr; s2++) {
> 
> also remove refcount_set call down here,
> it's already in set in perf_cpu_map__empty_new

Oops yeah, good catch. Removed in V5

James
> 
> thanks,
> jirka
> 
>> -- 
>> 2.28.0
>>
> 
