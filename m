Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062A9C47094
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Jun 2021 14:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5A12610E6
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Jun 2021 14:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhFJO4Y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 10 Jun 2021 10:56:24 -0400
Received: from foss.arm.com ([217.140.110.172]:33760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230322AbhFJO4U (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 10 Jun 2021 10:56:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48FB3106F;
        Thu, 10 Jun 2021 07:54:24 -0700 (PDT)
Received: from [10.57.5.44] (unknown [10.57.5.44])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA2023F719;
        Thu, 10 Jun 2021 07:54:21 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] coresight: etm-perf: Correct buffer syncing for
 snapshot
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Denis Nikitin <denik@google.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20210528161552.654907-1-leo.yan@linaro.org>
 <20210528161552.654907-2-leo.yan@linaro.org>
 <f29d2d68-2735-dddf-b872-6163d1dbc8f0@arm.com>
 <20210601103504.GC10026@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
Message-ID: <71158b94-863d-97d3-323a-e2406b708db7@arm.com>
Date:   Thu, 10 Jun 2021 17:54:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210601103504.GC10026@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 01/06/2021 13:35, Leo Yan wrote:
> Hi James,
> 
> On Tue, Jun 01, 2021 at 12:53:16PM +0300, James Clark wrote:
> 
> [...]
> 
>> Hi Leo,
>>
>> I was testing out snapshot mode (without your patch) and I noticed that it
>> only ever collects from the last CPU. For example on a 4 core system,
>> the CPU ID of the AUX records and the AUXTRACE buffers is always 3.
>>
>> This is with systemwide tracing, and running "stress -m 2 -c 2".
>> Is this something that your patch fixes, or am I doing something wrong, or
>> is it just a coincidence?
> 
> No, I think it's quite likely caused by blow code:
> 
> static unsigned long
> tmc_update_etr_buffer(struct coresight_device *csdev,
>                       struct perf_output_handle *handle,
>                       void *config)
> {
>     unsigned long flags, offset, size = 0;
> 
>     ...
> 
>     /* Don't do anything if another tracer is using this sink */
>     if (atomic_read(csdev->refcnt) != 1) {
>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
>         goto out;
>     }
> 
>     ...
> 
>     return size;
> }
> 
> When using the system wide tracing, it updates the AUX ring buffer
> until the last tracer is stopped.  Thus whis is why it only records
> AUX ring buffer for the last CPU.
> 
> But this makes sense for me, this is because the last CPU is used to
> copy trace data to AUX ring buffer (so the perf event PERF_RECORD_AUX
> occurs on CPU3), but when you decode the trace data, you should can
> see the activities from other CPUs.
> 
> Thanks,
> Leo
> 

I have one more issue around snapshot mode which I'd like to check if it's
related to this patchset.

In "[PATCH v5 0/1] perf cs-etm: Split Coresight decode by aux records",
I added the warning for a missing AUXTRACE buffer as you suggested.
Now this warning gets triggered on the last AUX record when using
snapshot mode. I don't know if you are able to reproduce this.

Thanks
James
