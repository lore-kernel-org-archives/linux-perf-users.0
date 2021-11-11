Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5863EC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 13:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 237A161212
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 13:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhKKNNT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 08:13:19 -0500
Received: from foss.arm.com ([217.140.110.172]:39338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231380AbhKKNNS (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 08:13:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E33CED1;
        Thu, 11 Nov 2021 05:10:26 -0800 (PST)
Received: from [10.57.58.62] (unknown [10.57.58.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAD353F70D;
        Thu, 11 Nov 2021 05:10:23 -0800 (PST)
Subject: Re: [PATCH v2 4/4] perf arm-spe: Support hardware-based PID tracing
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org
References: <20211109115020.31623-1-german.gomez@arm.com>
 <20211109115020.31623-5-german.gomez@arm.com>
 <CAM9d7cg7Lp49xOc3BOhM4O9fqs7i+v6cNd=eaKWjDbREiE3Pvg@mail.gmail.com>
 <20211111074148.GC102075@leoy-ThinkPad-X240s>
 <CAM9d7cjW_=hDkHVWchNFDyqZXbbBwMb224hbZTMsCe34MLL-4Q@mail.gmail.com>
 <20211111083002.GA106401@leoy-ThinkPad-X240s>
 <5c0e255b-e140-d157-7dfd-b27a43e128c9@arm.com>
 <20211111124257.GB106654@leoy-ThinkPad-X240s>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <19f1e8c8-5c46-0954-112e-eca57c564e97@arm.com>
Date:   Thu, 11 Nov 2021 13:10:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211111124257.GB106654@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi, thanks for looking into it

On 11/11/2021 12:42, Leo Yan wrote:
> On Thu, Nov 11, 2021 at 12:23:08PM +0000, German Gomez wrote:
>> On 11/11/2021 08:30, Leo Yan wrote:
>>> On Wed, Nov 10, 2021 at 11:59:05PM -0800, Namhyung Kim wrote:
> [...]
>
>>>>>>> +static int arm_spe_set_tid(struct arm_spe_queue *speq, pid_t tid)
>>>>>>> +{
>>>>>>> +       struct arm_spe *spe = speq->spe;
>>>>>>> +       int err = machine__set_current_tid(spe->machine, speq->cpu, tid, tid);
>>>>>> I think we should pass -1 as pid as we don't know the real pid.
>>>>>>
>>>>> AFAICT, I observe one case for machine__set_current_tid() returning error
>>>>> is 'speq->cpu' is -1 (this is the case for per-thread tracing).  In
>>>>> this case, if pass '-1' for pid/tid, it still will return failure.
>>>>>
>>>>> So here should return the error as it is.  Am I missing anything?
>>>> I'm not saying about the error.  It's about thread status.
>>>> In the machine__set_current_tid(), it calls
>>>> machine__findnew_thread() with given pid and tid.
>>>>
>>>> I suspect it can set pid to a wrong value if the thread has
>>>> no pid value at the moment.
>>> Here we should avoid to write pid '-1' with
>>> machine__set_current_tid().
>> If the kernel is writing the tids to the contextidr, isn't it wrong to
>> assume tid == pid when decoding the context packets here? I haven't
>> observed any impact in the built-in commands though, so there must be
>> something I'm not seeing.
> Okay, let me correct myself :)
>
> I checked Intel-pt's implementation, I understand now that we need to 
> distinguish the cases for pid/tid from context switch event and only tid
> from SPE context packet.
>
> Since the context switch event contains the correct pid and tid
> values, we should set both of them, see Intel-PT's implementation [1].
>
> As Namhyung pointed, we need to set pid as '-1' when we only know the
> tid value from SPE context packet; see [2].

I will correct this and resend the patch for SPE.

Thanks,
German

>
> So we should use the same with Intel-pt.
>
> Sorry for I didn't really understand well Namhyung's suggestion and
> thanks you both pointed out the issue.
>
> Leo
>
> P.s. an offline topic is we should send a patch to fix cs-etm issue
> as well [3].
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/intel-pt.c#n2920
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/intel-pt.c#n2215
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/cs-etm.c#n1121
