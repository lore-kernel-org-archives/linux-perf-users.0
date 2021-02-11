Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F677C433DB
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Feb 2021 13:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 674D464DC3
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Feb 2021 13:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhBKNor (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Feb 2021 08:44:47 -0500
Received: from foss.arm.com ([217.140.110.172]:52168 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231998AbhBKNnC (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Feb 2021 08:43:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3D70113E;
        Thu, 11 Feb 2021 05:41:38 -0800 (PST)
Received: from [10.57.43.88] (unknown [10.57.43.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36B8B3F73B;
        Thu, 11 Feb 2021 05:41:35 -0800 (PST)
Subject: Re: [PATCH 1/8] perf arm-spe: Enable sample type PERF_SAMPLE_DATA_SRC
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Al Grant <al.grant@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20210119144658.793-1-james.clark@arm.com>
 <20210122125157.GG356537@kernel.org>
From:   James Clark <james.clark@arm.com>
Message-ID: <28c8e10d-7061-05ae-caa4-e87d0cb6a306@arm.com>
Date:   Thu, 11 Feb 2021 15:41:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210122125157.GG356537@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 22/01/2021 14:51, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jan 19, 2021 at 04:46:51PM +0200, James Clark escreveu:
>> From: Leo Yan <leo.yan@linaro.org>
>>
>> This patch is to enable sample type PERF_SAMPLE_DATA_SRC for Arm SPE in
>> the perf data, when output the tracing data, it tells tools that it
>> contains data source in the memory event.
>>
>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>> Signed-off-by: James Clark <james.clark@arm.com>
> 
> I see two Signed-off-by, ok, any Reviewed-by?
> 
> - Arnaldo

Hi Arnaldo,

I have submitted v2 and added my reviewed-by and tested-by.

I didn't change any of the authors as Leo suggested because I only
modified the last two patches which we dropped anyway to not show
any misleading PID data when run from a container.


Thanks
James

> 
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Jiri Olsa <jolsa@redhat.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: John Garry <john.garry@huawei.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Al Grant <al.grant@arm.com>
>> Cc: Andre Przywara <andre.przywara@arm.com>
>> Cc: Wei Li <liwei391@huawei.com>
>> Cc: Tan Xiaojun <tanxiaojun@huawei.com>
>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  tools/perf/util/arm-spe.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
>> index 8901a1656a41..b134516e890b 100644
>> --- a/tools/perf/util/arm-spe.c
>> +++ b/tools/perf/util/arm-spe.c
>> @@ -803,7 +803,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>>  	attr.type = PERF_TYPE_HARDWARE;
>>  	attr.sample_type = evsel->core.attr.sample_type & PERF_SAMPLE_MASK;
>>  	attr.sample_type |= PERF_SAMPLE_IP | PERF_SAMPLE_TID |
>> -		PERF_SAMPLE_PERIOD;
>> +			    PERF_SAMPLE_PERIOD | PERF_SAMPLE_DATA_SRC;
>>  	if (spe->timeless_decoding)
>>  		attr.sample_type &= ~(u64)PERF_SAMPLE_TIME;
>>  	else
>> -- 
>> 2.28.0
>>
> 
