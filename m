Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02334C433B4
	for <linux-perf-users@archiver.kernel.org>; Tue, 11 May 2021 13:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C150B61004
	for <linux-perf-users@archiver.kernel.org>; Tue, 11 May 2021 13:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhEKNys (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 11 May 2021 09:54:48 -0400
Received: from foss.arm.com ([217.140.110.172]:48240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231599AbhEKNyr (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 11 May 2021 09:54:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4AC7101E;
        Tue, 11 May 2021 06:53:40 -0700 (PDT)
Received: from [10.57.81.122] (unknown [10.57.81.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 561543F718;
        Tue, 11 May 2021 06:53:37 -0700 (PDT)
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
From:   James Clark <james.clark@arm.com>
Message-ID: <da07f930-ccd7-2b46-7b0f-0e9da3bf9482@arm.com>
Date:   Tue, 11 May 2021 16:53:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210510053904.GB4835@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 10/05/2021 08:39, Leo Yan wrote:
> Hi James,
> 

[...]
> 
>>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>> index b01d363b9301..947e44413c6e 100644
>>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>> @@ -320,7 +320,10 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
>>>  	 * which instructions started by subtracting the number of instructions
>>>  	 * executed to the timestamp.
>>>  	 */
>>> -	packet_queue->cs_timestamp = elem->timestamp - packet_queue->instr_count;
>>> +	if (packet_queue->instr_count >= elem->timestamp)
>>> +		packet_queue->cs_timestamp = 0;
>>> +	else
>>> +		packet_queue->cs_timestamp = elem->timestamp - packet_queue->instr_count;
> 
> Actually here have two situations: one case is "elem->timestamp" is zero,
> another case is the overflow for "elem->timestamp".
> 
> So the change should be like:
> 
>    if (!elem->timestamp)
>        packet_queue->cs_timestamp = 0;
>    else if (packet_queue->instr_count >= elem->timestamp)
>        /* handle overflow? */
>    else
>       packet_queue->cs_timestamp = elem->timestamp - packet_queue->instr_count;
> 
> It's better to think about how to handle the overflow in this case.

Do you have any idea about what to do in the overflow case? I think I will submit a
new patchset that makes the new 'Z' timeless --itrace option work, because that also
fixes this issue, without having to do the original workaround change in this RFC.

But I'd also like to fix this overflow because it masks the issue by making non-zero
timestamps appear even though they aren't valid ones.

I was thinking that printing a warning in the overflow case would work, but then I would
also print a warning for the zero timestamps, and that would make just a single case,
rather than two. Unless we just have slightly different warning text?

Something like this? Without the zero timestamp issue, the underflow issue probably wouldn't
be encountered. But at least there would be some visibility if it did:

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 059bcec3f651..5d8abccd34ab 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -17,6 +17,7 @@
 
 #include "cs-etm.h"
 #include "cs-etm-decoder.h"
+#include "debug.h"
 #include "intlist.h"
 
 /* use raw logging */
@@ -294,9 +295,11 @@ cs_etm_decoder__do_soft_timestamp(struct cs_etm_queue *etmq,
 static ocsd_datapath_resp_t
 cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
                                  const ocsd_generic_trace_elem *elem,
-                                 const uint8_t trace_chan_id)
+                                 const uint8_t trace_chan_id,
+                                 const ocsd_trc_index_t indx)
 {
        struct cs_etm_packet_queue *packet_queue;
+       static bool warned_timestamp_zero = false;
 
        /* First get the packet queue for this traceID */
        packet_queue = cs_etm__etmq_get_packet_queue(etmq, trace_chan_id);
@@ -320,7 +323,20 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
         * which instructions started by subtracting the number of instructions
         * executed to the timestamp.
         */
-       packet_queue->timestamp = elem->timestamp - packet_queue->instr_count;
+       if (!elem->timestamp) {
+               packet_queue->timestamp = 0;
+               if (!warned_timestamp_zero) {
+                       pr_err("Zero Coresight timestamp found at Idx:%" OCSD_TRC_IDX_STR
+                               ". Decoding may be improved with --itrace=Z...\n", indx);
+                       warned_timestamp_zero = true;
+               }
+       }
+       else if (packet_queue->instr_count >= elem->timestamp) {
+               packet_queue->timestamp = 0;
+               pr_err("Timestamp calculation underflow at Idx:%" OCSD_TRC_IDX_STR "\n", indx);
+       }
+       else
+               packet_queue->timestamp = elem->timestamp - packet_queue->instr_count;
        packet_queue->next_timestamp = elem->timestamp;
        packet_queue->instr_count = 0;
 
@@ -542,7 +558,7 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
 
 static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
                                const void *context,
-                               const ocsd_trc_index_t indx __maybe_unused,
+                               const ocsd_trc_index_t indx,
                                const u8 trace_chan_id __maybe_unused,
                                const ocsd_generic_trace_elem *elem)
 {
@@ -579,7 +595,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
                break;
        case OCSD_GEN_TRC_ELEM_TIMESTAMP:
                resp = cs_etm_decoder__do_hard_timestamp(etmq, elem,
-                                                        trace_chan_id);
+                                                        trace_chan_id,
+                                                         indx);
                break;
        case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
                resp = cs_etm_decoder__set_tid(etmq, packet_queue,


James

> 
> Thanks,
> Leo
> 
