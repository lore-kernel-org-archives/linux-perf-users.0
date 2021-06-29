Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA02BC11F66
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Jun 2021 08:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4F5861DD8
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Jun 2021 08:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbhF2IzA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 29 Jun 2021 04:55:00 -0400
Received: from foss.arm.com ([217.140.110.172]:46496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232621AbhF2Iy7 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Jun 2021 04:54:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6049DD6E;
        Tue, 29 Jun 2021 01:52:32 -0700 (PDT)
Received: from [10.57.14.107] (unknown [10.57.14.107])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB6EF3F694;
        Tue, 29 Jun 2021 01:52:29 -0700 (PDT)
Subject: Re: [PATCH v7 2/2] perf cs-etm: Split --dump-raw-trace by AUX records
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     acme@kernel.org, coresight@lists.linaro.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210624164303.28632-1-james.clark@arm.com>
 <20210624164303.28632-3-james.clark@arm.com>
 <20210628012744.GA158794@leoy-ThinkPad-X240s>
 <c7906b72-e547-da37-c387-23de65831ac4@arm.com>
 <20210628120802.GC200044@leoy-ThinkPad-X240s> <20210628200132.GB1200359@p14s>
From:   James Clark <james.clark@arm.com>
Message-ID: <b9a3ae95-987b-d1de-a242-141e7444aa83@arm.com>
Date:   Tue, 29 Jun 2021 09:52:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210628200132.GB1200359@p14s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 28/06/2021 21:01, Mathieu Poirier wrote:
> On Mon, Jun 28, 2021 at 08:08:02PM +0800, Leo Yan wrote:
>> On Mon, Jun 28, 2021 at 11:38:34AM +0100, James Clark wrote:
>>
>> [...]
>>
>>>>>  static int cs_etm__process_auxtrace_event(struct perf_session *session,
>>>>>  					  union perf_event *event,
>>>>>  					  struct perf_tool *tool __maybe_unused)
>>>>> @@ -2462,7 +2478,8 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
>>>>>  				cs_etm__dump_event(etm, buffer);
>>>>>  				auxtrace_buffer__put_data(buffer);
>>>>>  			}
>>>>> -	}
>>>>> +	} else if (dump_trace)
>>>>> +		dump_queued_data(etm, &event->auxtrace);
>>>>
>>>> IIUC, in the function cs_etm__process_auxtrace_event(), since
>>>> "etm->data_queued" is always true, below flow will never run:
>>>>
>>>>     if (!etm->data_queued) {
>>>>         ......
>>>>
>>>>         if (dump_trace)
>>>>             if (auxtrace_buffer__get_data(buffer, fd)) {
>>>>                     cs_etm__dump_event(etm, buffer);
>>>>                     auxtrace_buffer__put_data(buffer);
>>>>             }
>>>>     }
>>>>
>>>> If so, it's better to use a new patch to polish the code.
>>>>
>>>
>>> Hi Leo,
>>>
>>> I think this is not true in piped mode because there is no auxtrace index.
>>> In that mode, events are processed only in file order and cs_etm__process_auxtrace_event()
>>> is called for each buffer.
>>>
>>> You can reproduce this with something like this:
>>>
>>>      ./perf record -o - ls > stdio.data
>>>      cat stdio.data | ./perf report -i -
>>
>> You are right!  I tried these two commands with cs_etm event, just as
>> you said, in this case, the AUX trace data is not queued; so the flow
>> for "if (!etm->data_queued)" should be kept.  If so, I am very fine
>> for current change.  Thanks for sharing the knowledge.
>>
>>> There are some other Coresight features that don't work as expected in this mode, like
>>> sorting timestamps between CPUs. The aux split patchset won't work either because random
>>> access isn't possible. And the TRBE patch that I'm working on now won't work, because it
>>> also requires the random access to lookup the flags on the AUX record to configure the 
>>> decoder for unformatted trace.
>>
> 
> There is a lot of things happening in this area.  Based on the above should I
> still plan to review this set or should I wait for another revision?

From my point of view, this one is final. It looks like both Leo and I have tested
it with and without his snapshot changes and it's working as expected in both cases.

Thanks
James

> 
> Thanks,
> Mathieu
> 
>> Cool, looking forward for the patches :)
>>
>> Leo
