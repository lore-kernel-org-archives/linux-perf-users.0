Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EBDC4708F
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 13:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DE48613B1
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 13:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhFANKz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Jun 2021 09:10:55 -0400
Received: from foss.arm.com ([217.140.110.172]:49652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233409AbhFANKy (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Jun 2021 09:10:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16C2F6D;
        Tue,  1 Jun 2021 06:09:13 -0700 (PDT)
Received: from [10.57.9.215] (unknown [10.57.9.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44B683F719;
        Tue,  1 Jun 2021 06:09:09 -0700 (PDT)
Subject: Re: [RFC PATCH v3] perf cs-etm: Split Coresight decode by aux records
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Al Grant <al.grant@arm.com>,
        branislav.rankov@arm.com, Denis Nikitin <denik@chromium.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210527104234.24313-1-james.clark@arm.com>
 <11822824-7486-2333-f039-bfd801b86922@arm.com>
 <CANLsYkynQbGRhOmyramX+nSHvVnH_nSJb=t03Dp-2WeXP3ZYAw@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <dcf7cbe3-2d97-bf99-7025-3f62e2f09be1@arm.com>
Date:   Tue, 1 Jun 2021 16:09:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CANLsYkynQbGRhOmyramX+nSHvVnH_nSJb=t03Dp-2WeXP3ZYAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 27/05/2021 18:37, Mathieu Poirier wrote:
> On Thu, 27 May 2021 at 07:46, James Clark <james.clark@arm.com> wrote:
>>
>>
>>
>> On 27/05/2021 13:42, James Clark wrote:
>>> Populate the auxtrace queues using AUX records rather than whole
>>> auxtrace buffers.
>>>
>> ...
>>> Snapshot mode still needs to be tested.
>>>
>>
>> Snapshot mode is also working, but needs the following patch applied to reverse aux_offset
>> from the end of the buffer to the beginning:
> 
> It might be better to send another revision with this patch included
> in to make sure everyone is looking at (and testing) the same thing.

I've sent v4 with it applied. There was actually a mistake which broke the normal mode,
so it was a good idea to apply it.

> 
>>
>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>> index 5d6c03488187..9db556e14dfa 100644
>> --- a/tools/perf/util/cs-etm.c
>> +++ b/tools/perf/util/cs-etm.c
>> @@ -2700,6 +2700,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session,
>>         struct perf_record_auxtrace *auxtrace_event;
>>         union perf_event auxtrace_fragment;
>>         bool matchesCpuPid;
>> +       __u64 aux_offset;
>>         struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
>>                                                    struct cs_etm_auxtrace,
>>                                                    auxtrace);
>> @@ -2730,19 +2731,26 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session,
>>         else
>>                 matchesCpuPid = auxtrace_event->cpu == sample->cpu;
>>
>> +       /*
>> +        * In snapshot/overwrite mode, the head points to the end of the buffer so aux_offset needs
>> +        * to have the size subtracted so it points to the beginning as in normal mode.
>> +        */
>> +       if (aux_event->flags && PERF_AUX_FLAG_OVERWRITE)
>> +               aux_offset = aux_event->aux_offset - aux_event->aux_size;
>> +       else
>> +               aux_offset = aux_event->aux_offset;
>> +
>>         if (matchesCpuPid &&
>> -           aux_event->aux_offset >= auxtrace_event->offset &&
>> -           aux_event->aux_offset + aux_event->aux_size <=
>> -                       auxtrace_event->offset + auxtrace_event->size) {
>> +           aux_offset >= auxtrace_event->offset &&
>> +           aux_offset + aux_event->aux_size <= auxtrace_event->offset + auxtrace_event->size) {
>>                 /*
>>                  * If this AUX event was inside this buffer somewhere, create a new auxtrace event
>>                  * based on the sizes of the aux event, and queue that fragment.
>>                  */
>>                 auxtrace_fragment.auxtrace = *auxtrace_event;
>>                 auxtrace_fragment.auxtrace.size = aux_event->aux_size;
>> -               auxtrace_fragment.auxtrace.offset = aux_event->aux_offset;
>> -               file_offset += aux_event->aux_offset - auxtrace_event->offset +
>> -                               auxtrace_event->header.size;
>> +               auxtrace_fragment.auxtrace.offset = aux_offset;
>> +               file_offset += aux_offset - auxtrace_event->offset + auxtrace_event->header.size;
>>                 return auxtrace_queues__add_event(&etm->queues,
>>                                                session,
>>                                                &auxtrace_fragment,
>>
>>
