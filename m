Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8C4C433ED
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 May 2021 13:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D58061406
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 May 2021 13:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbhEMN7C (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 May 2021 09:59:02 -0400
Received: from foss.arm.com ([217.140.110.172]:36104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234292AbhEMN6d (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 May 2021 09:58:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79EB61713;
        Thu, 13 May 2021 06:57:23 -0700 (PDT)
Received: from [10.57.81.122] (unknown [10.57.81.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D0533F73B;
        Thu, 13 May 2021 06:57:20 -0700 (PDT)
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
 <20210512012002.GB249068@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
Message-ID: <b0279722-2746-bf58-0e84-224db0d85222@arm.com>
Date:   Thu, 13 May 2021 16:57:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210512012002.GB249068@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 12/05/2021 04:20, Leo Yan wrote:
> On Tue, May 11, 2021 at 04:53:35PM +0300, James Clark wrote:
> 
> [...]
> 
>> Do you have any idea about what to do in the overflow case?
> 
> A quick thinking is to connect the kernel timestamp and correlate the
> overflow case for CoreSight's timestamp, but this approach will cause
> complexity.  And considering if the overflow occurs for not only once
> before the new kernel timestamp is updated, it's hard to handle for
> this case.  So seems to me, printing warning is a better choice.
> 
>> I think I will submit a
>> new patchset that makes the new 'Z' timeless --itrace option work, because that also
>> fixes this issue, without having to do the original workaround change in this RFC.
> 
> Good finding for these options for zero timestamps!
> 
>> But I'd also like to fix this overflow because it masks the issue by making non-zero
>> timestamps appear even though they aren't valid ones.
>>
>> I was thinking that printing a warning in the overflow case would work, but then I would
>> also print a warning for the zero timestamps, and that would make just a single case,
>> rather than two. Unless we just have slightly different warning text?
> 
> Printing two different warnings is okay for me, which is more clear
> for users.
> 
>> Something like this? Without the zero timestamp issue, the underflow issue probably wouldn't
>> be encountered. But at least there would be some visibility if it did:
>>
>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> index 059bcec3f651..5d8abccd34ab 100644
>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> @@ -17,6 +17,7 @@
>>  
>>  #include "cs-etm.h"
>>  #include "cs-etm-decoder.h"
>> +#include "debug.h"
>>  #include "intlist.h"
>>  
>>  /* use raw logging */
>> @@ -294,9 +295,11 @@ cs_etm_decoder__do_soft_timestamp(struct cs_etm_queue *etmq,
>>  static ocsd_datapath_resp_t
>>  cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
>>                                   const ocsd_generic_trace_elem *elem,
>> -                                 const uint8_t trace_chan_id)
>> +                                 const uint8_t trace_chan_id,
>> +                                 const ocsd_trc_index_t indx)
> 
> Do we really need the new argument "indx"?  If print "trace_chan_id",
> can it give the info that the timestamp is attached to which tracer?

I thought that just the channel ID wouldn't be very useful for locating where the
issue is when doing --dump-raw-trace.

By printing "Idx:..." it can be pasted straight into the search in perf and you'll
jump straight to the part where the error happened. If you only have the channel
ID then you'd still need to get a debugger out and find out the index if you want
to look into the problem.

I will include the index in the new patch I will submit now, but I don't insist on
keeping it so let me know what you think.

James

