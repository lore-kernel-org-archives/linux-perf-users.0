Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A653BC433B4
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 May 2021 13:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778EC61108
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 May 2021 13:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbhEMNMB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 May 2021 09:12:01 -0400
Received: from foss.arm.com ([217.140.110.172]:35242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230498AbhEMNMA (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 May 2021 09:12:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED629ED1;
        Thu, 13 May 2021 06:10:50 -0700 (PDT)
Received: from [10.57.81.122] (unknown [10.57.81.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 665753F73B;
        Thu, 13 May 2021 06:10:48 -0700 (PDT)
Subject: Re: [RFC PATCH] perf cs-etm: Handle valid-but-zero timestamps
To:     Leo Yan <leo.yan@linaro.org>
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210507095814.17933-1-james.clark@arm.com>
 <3926c523-3fdb-66de-8b9c-b68290a5053e@arm.com>
 <20210510053904.GB4835@leoy-ThinkPad-X240s>
 <da07f930-ccd7-2b46-7b0f-0e9da3bf9482@arm.com>
 <20210512020826.GC249068@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
Message-ID: <347cb510-0057-4687-5b29-22568d228b7a@arm.com>
Date:   Thu, 13 May 2021 16:10:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210512020826.GC249068@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 12/05/2021 05:08, Leo Yan wrote:
> On Tue, May 11, 2021 at 04:53:35PM +0300, James Clark wrote:
> 
> [...]
> 
>>         /* First get the packet queue for this traceID */
>>         packet_queue = cs_etm__etmq_get_packet_queue(etmq, trace_chan_id);
>> @@ -320,7 +323,20 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
>>          * which instructions started by subtracting the number of instructions
>>          * executed to the timestamp.
>>          */
>> -       packet_queue->timestamp = elem->timestamp - packet_queue->instr_count;
>> +       if (!elem->timestamp) {
>> +               packet_queue->timestamp = 0;
>> +               if (!warned_timestamp_zero) {
>> +                       pr_err("Zero Coresight timestamp found at Idx:%" OCSD_TRC_IDX_STR
>> +                               ". Decoding may be improved with --itrace=Z...\n", indx);
>> +                       warned_timestamp_zero = true;
>> +               }
>> +       }
>> +       else if (packet_queue->instr_count >= elem->timestamp) {
> 
> Nitpick: I personally think should use the condition ">" rather than ">=".

Yes, good catch. I actually changed this because I realised that
if they are equal it shouldn't print an error.

> 
>> +               packet_queue->timestamp = 0;
>> +               pr_err("Timestamp calculation underflow at Idx:%" OCSD_TRC_IDX_STR "\n", indx);
>> +       }
>> +       else
>> +               packet_queue->timestamp = elem->timestamp - packet_queue->instr_count;
> 
> Nitpick for coding style, as described in
> Documentation/process/coding-style.rst, section "3) Placing Braces and
> Spaces", so here should use braces with the format:

Ok I will update and run it through checkpatch.pl before posting.

[...]
