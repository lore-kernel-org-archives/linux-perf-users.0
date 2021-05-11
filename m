Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385C3C433ED
	for <linux-perf-users@archiver.kernel.org>; Tue, 11 May 2021 10:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0141A61936
	for <linux-perf-users@archiver.kernel.org>; Tue, 11 May 2021 10:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhEKKI5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 11 May 2021 06:08:57 -0400
Received: from foss.arm.com ([217.140.110.172]:44518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230146AbhEKKI5 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 11 May 2021 06:08:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A79FF169E;
        Tue, 11 May 2021 03:07:50 -0700 (PDT)
Received: from [10.57.81.122] (unknown [10.57.81.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FDA53F719;
        Tue, 11 May 2021 03:07:47 -0700 (PDT)
Subject: Re: [RFC PATCH] perf cs-etm: Handle valid-but-zero timestamps
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Coresight ML <coresight@lists.linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Al Grant <al.grant@arm.com>, branislav.rankov@arm.com,
        Denis Nikitin <denik@chromium.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210507095814.17933-1-james.clark@arm.com>
 <3926c523-3fdb-66de-8b9c-b68290a5053e@arm.com>
 <CAJ9a7VjAvr9uKYqo9VJhFRB74vt6Jxf0G+Fm2OFm-dxAVdbpsw@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <b4407fb2-c393-9e85-acaa-80b30b4783ec@arm.com>
Date:   Tue, 11 May 2021 13:07:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJ9a7VjAvr9uKYqo9VJhFRB74vt6Jxf0G+Fm2OFm-dxAVdbpsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 07/05/2021 17:09, Mike Leach wrote:
> Hi James,
> 
> 1) Not sure about this particular target - but previously all 0
> timestamps have been the result of not enabling a clock or the
> coresight timestamp generator.
> 
> 2) Given that you can synthesise timestamps when all the values are
> all 0 - does this not imply that they could be synthesised when they
> are not present at all?

Yes they could, perhaps we could change our command line arguments to remove
recording of timestamps completely. But I think that the auto enabling of
timestamps for per-cpu mode is only additive so there is no way to disable
it on the command line.

Perhaps we could make a change there instead to make the event configuration more flexible.

There is a similar concept with the --timestamp argument where it has both
"not set" and "set, but set to false" variables to distinguish between when the user hasn't
provided anything and when they've provided the negative:

	OPT_BOOLEAN_SET('T', "timestamp", &record.opts.sample_time,
			&record.opts.sample_time_set,

opts.sample_time is whether timestamps are on or not and
opts.sample_time_set is whether the user provided any argument, true or false.

Thanks
James

> 
> Cheers
> 
> Mike
> 
> On Fri, 7 May 2021 at 11:02, James Clark <james.clark@arm.com> wrote:
>>
>>
>>
>> On 07/05/2021 12:58, James Clark wrote:
>>> There is an intermittent issue on Trogdor devices that
>>> results in all Coresight timestamps having a value of zero.
>>
>> I've attached a file here that has the issue. From the dump you
>> can see the zero timestamps:
>>
>>         Idx:69; ID:10;  I_TIMESTAMP : Timestamp.; Updated val = 0x0
>>         Idx:71; ID:10;  I_ATOM_F1 : Atom format 1.; E
>>         Idx:72; ID:10;  I_ADDR_S_IS0 : Address, Short, IS0.; Addr=0xFFFFFFE723C65824 ~[0x5824]
>>
>> This doesn't have an impact on decoding as they end up being
>> decoded in file order as in with timeless mode.
>>
>> James
>>
>>> Because zero is currently treated as "not found" rather
>>> than "found but zero", this breaks the decoding flow
>>> when it would otherwise work.
>>>
>>> This patch adds an out parameter and return code so
>>> the difference between zero and non-existent timestamps
>>> can be determined.
>>>
>>> There is also a change to fix an underflow.
>>>
>>> Although this is a workaround, the change is technically
>>> a valid way of writing the cs_etm__etmq_get_timestamp()
>>> function. It could have been written similarly to this
>>> without trying to work around this issue, so it's no less
>>> correct. But, because it's a workaround to a problem
>>> elsewhere, I will submit this as an RFC for feedback.
>>>
>>> This patch applies on top of the "[PATCH v2 0/2] perf
>>> cs-etm: Set time on synthesised samples to preserve ordering"
>>> patchset.
>>>
>>> Co-developed-by: Denis Nikitin <denik@chromium.org>
>>> Signed-off-by: Denis Nikitin <denik@chromium.org>
>>> Signed-off-by: James Clark <james.clark@arm.com>
>>> ---
>>>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  5 ++++-
>>>  tools/perf/util/cs-etm.c                      | 22 +++++++++----------
>>>  2 files changed, 15 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>> index b01d363b9301..947e44413c6e 100644
>>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>> @@ -320,7 +320,10 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
>>>        * which instructions started by subtracting the number of instructions
>>>        * executed to the timestamp.
>>>        */
>>> -     packet_queue->cs_timestamp = elem->timestamp - packet_queue->instr_count;
>>> +     if (packet_queue->instr_count >= elem->timestamp)
>>> +             packet_queue->cs_timestamp = 0;
>>> +     else
>>> +             packet_queue->cs_timestamp = elem->timestamp - packet_queue->instr_count;
>>>       packet_queue->next_cs_timestamp = elem->timestamp;
>>>       packet_queue->instr_count = 0;
>>>
>>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>>> index e5c1a1b22a2a..1969921c406a 100644
>>> --- a/tools/perf/util/cs-etm.c
>>> +++ b/tools/perf/util/cs-etm.c
>>> @@ -210,13 +210,14 @@ void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
>>>       etmq->pending_timestamp_chan_id = trace_chan_id;
>>>  }
>>>
>>> -static u64 cs_etm__etmq_get_timestamp(struct cs_etm_queue *etmq,
>>> +static int cs_etm__etmq_get_timestamp(struct cs_etm_queue *etmq,
>>> +                                   u64 *timestamp,
>>>                                     u8 *trace_chan_id)
>>>  {
>>>       struct cs_etm_packet_queue *packet_queue;
>>>
>>>       if (!etmq->pending_timestamp_chan_id)
>>> -             return 0;
>>> +             return -ENODATA;
>>>
>>>       if (trace_chan_id)
>>>               *trace_chan_id = etmq->pending_timestamp_chan_id;
>>> @@ -224,13 +225,15 @@ static u64 cs_etm__etmq_get_timestamp(struct cs_etm_queue *etmq,
>>>       packet_queue = cs_etm__etmq_get_packet_queue(etmq,
>>>                                                    etmq->pending_timestamp_chan_id);
>>>       if (!packet_queue)
>>> -             return 0;
>>> +             return -ENODATA;
>>>
>>>       /* Acknowledge pending status */
>>>       etmq->pending_timestamp_chan_id = 0;
>>>
>>>       /* See function cs_etm_decoder__do_{hard|soft}_timestamp() */
>>> -     return packet_queue->cs_timestamp;
>>> +     if (timestamp)
>>> +             *timestamp = packet_queue->cs_timestamp;
>>> +     return 0;
>>>  }
>>>
>>>  static void cs_etm__clear_packet_queue(struct cs_etm_packet_queue *queue)
>>> @@ -864,11 +867,10 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
>>>                * Function cs_etm_decoder__do_{hard|soft}_timestamp() does all
>>>                * the timestamp calculation for us.
>>>                */
>>> -             cs_timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
>>> -
>>> -             /* We found a timestamp, no need to continue. */
>>> -             if (cs_timestamp)
>>> +             if (!cs_etm__etmq_get_timestamp(etmq, &cs_timestamp, &trace_chan_id)) {
>>> +                     /* We found a timestamp, no need to continue. */
>>>                       break;
>>> +             }
>>>
>>>               /*
>>>                * We didn't find a timestamp so empty all the traceid packet
>>> @@ -2286,9 +2288,7 @@ static int cs_etm__process_queues(struct cs_etm_auxtrace *etm)
>>>               if (ret)
>>>                       goto out;
>>>
>>> -             cs_timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
>>> -
>>> -             if (!cs_timestamp) {
>>> +             if (cs_etm__etmq_get_timestamp(etmq, &cs_timestamp, &trace_chan_id)) {
>>>                       /*
>>>                        * Function cs_etm__decode_data_block() returns when
>>>                        * there is no more traces to decode in the current
>>>
> 
> 
> 
