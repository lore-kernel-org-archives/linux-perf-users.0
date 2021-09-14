Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5EFC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Sep 2021 09:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4DF661108
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Sep 2021 09:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhINJKL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:10:11 -0400
Received: from foss.arm.com ([217.140.110.172]:41602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhINJKL (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Sep 2021 05:10:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 393A21FB;
        Tue, 14 Sep 2021 02:08:54 -0700 (PDT)
Received: from [10.57.94.84] (unknown [10.57.94.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A2F43F719;
        Tue, 14 Sep 2021 02:08:50 -0700 (PDT)
Subject: Re: [PATCH v5 2/9] coresight: tmc-etr: Add barrier after updating AUX
 ring buffer
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Song Liu <songliubraving@fb.com>, x86@kernel.org,
        =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org
References: <20210809111407.596077-1-leo.yan@linaro.org>
 <20210809111407.596077-3-leo.yan@linaro.org>
 <20210829105500.GB14461@leoy-ThinkPad-X240s>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <1aa47806-30a7-9a23-7c16-5a1665d20469@arm.com>
Date:   Tue, 14 Sep 2021 10:08:49 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210829105500.GB14461@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 29/08/2021 11:55, Leo Yan wrote:
> Hi Mathieu, Suzuki,
> 
> On Mon, Aug 09, 2021 at 07:14:00PM +0800, Leo Yan wrote:
>> Since a memory barrier is required between AUX trace data store and
>> aux_head store, and the AUX trace data is filled with memcpy(), it's
>> sufficient to use smp_wmb() so can ensure the trace data is visible
>> prior to updating aux_head.
>>
>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Could you pick up patches 02 and 03 in this series?  Please note,
> patch 02 has the review tag from Suzuki, but I didn't receive the
> review tag for patch 03.
> 
> If anything need to follow up, just let me know.  Thanks!

I have picked up both the patches.

Thanks
Suzuki

> 
>> ---
>>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> index acdb59e0e661..13fd1fc730ed 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> @@ -1563,6 +1563,14 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
>>   	 */
>>   	if (etr_perf->snapshot)
>>   		handle->head += size;
>> +
>> +	/*
>> +	 * Ensure that the AUX trace data is visible before the aux_head
>> +	 * is updated via perf_aux_output_end(), as expected by the
>> +	 * perf ring buffer.
>> +	 */
>> +	smp_wmb();
>> +
>>   out:
>>   	/*
>>   	 * Don't set the TRUNCATED flag in snapshot mode because 1) the
>> -- 
>> 2.25.1
>>

