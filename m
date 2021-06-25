Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D831C49EA7
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Jun 2021 13:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E767A61962
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Jun 2021 13:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhFYN1k (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Jun 2021 09:27:40 -0400
Received: from foss.arm.com ([217.140.110.172]:55846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhFYN1k (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Jun 2021 09:27:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A5B031B;
        Fri, 25 Jun 2021 06:25:19 -0700 (PDT)
Received: from [10.57.8.165] (unknown [10.57.8.165])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 391E73F694;
        Fri, 25 Jun 2021 06:25:17 -0700 (PDT)
Subject: Re: [PATCH v5 5/5] perf arm-spe: Don't wait for PERF_RECORD_EXIT
 event
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>, Al Grant <Al.Grant@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210519071939.1598923-1-leo.yan@linaro.org>
 <20210519071939.1598923-6-leo.yan@linaro.org>
From:   James Clark <james.clark@arm.com>
Message-ID: <369fd454-d94d-daa1-ead4-b42645ec4282@arm.com>
Date:   Fri, 25 Jun 2021 14:25:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519071939.1598923-6-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 19/05/2021 08:19, Leo Yan wrote:
> When decode Arm SPE trace, it waits for PERF_RECORD_EXIT event (the last
> perf event) for processing trace data, which is needless and even might
> cause logic error, e.g. it might fail to correlate perf events with Arm
> SPE events correctly.
> 
> So this patch removes the condition checking for PERF_RECORD_EXIT event.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/arm-spe.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 5c5b438584c4..58b7069c5a5f 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -717,11 +717,7 @@ static int arm_spe_process_event(struct perf_session *session,
>  					sample->time);
>  		}
>  	} else if (timestamp) {
> -		if (event->header.type == PERF_RECORD_EXIT) {
> -			err = arm_spe_process_queues(spe, timestamp);
> -			if (err)
> -				return err;
> -		}
> +		err = arm_spe_process_queues(spe, timestamp);
>  	}
>  
>  	return err;
> 

For the whole set:
Reviewed-by: James Clark <james.clark@arm.com>
Tested-by: James Clark <james.clark@arm.com>

I see a big improvement in decoding involving multiple processes because the timestamps are now
correlated with the comm and mmap events.

For example perf-exec samples are visible right before the exec is done, and on an
application that forks, samples are visible from all processes. For example:

   perf record -e arm_spe// -- bash -c "stress -c 1"
   perf script

   perf-exec  4502 [003] 259755.050409:          1    l1d-access:  ffff80001014b840 sched_clock+0x40 ([kernel.kallsyms])
   perf-exec  4502 [003] 259755.050409:          1    tlb-access:  ffff80001014b840 sched_clock+0x40 ([kernel.kallsyms])
   perf-exec  4502 [003] 259755.050409:          1        memory:  ffff80001014b840 sched_clock+0x40 ([kernel.kallsyms])
   perf-exec  4502 [003] 259755.050411:          1    tlb-access:  ffff800010120fb8 __rcu_read_lock+0x0 ([kernel.kallsyms])
   bash  4502 [003] 259755.050411:          1   branch-miss:  ffff8000105b2a40 memcpy+0x80 ([kernel.kallsyms])
   bash  4502 [003] 259755.050411:          1    tlb-access:                 0 [unknown] ([unknown])
   ...
   stress  4502 [003] 259755.051468:          1    l1d-access:  ffff800010259a24 __vma_adjust+0x1f4 ([kernel.kallsyms])
   stress  4502 [003] 259755.051468:          1    tlb-access:  ffff800010259a24 __vma_adjust+0x1f4 ([kernel.kallsyms])
   stress  4502 [003] 259755.051468:          1        memory:  ffff800010259a24 __vma_adjust+0x1f4 ([kernel.kallsyms])

Previously samples were only attributed to 'stress', which was obviously wrong.

James

