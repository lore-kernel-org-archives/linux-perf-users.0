Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AEEEB64D7
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jun 2023 14:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjFZOjO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Jun 2023 10:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjFZOjF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Jun 2023 10:39:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 069B7BF
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 07:39:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 182A12F4;
        Mon, 26 Jun 2023 07:39:47 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29FEF3F663;
        Mon, 26 Jun 2023 07:39:01 -0700 (PDT)
Message-ID: <57ea7d37-83bd-80ba-3342-93598a88ac20@arm.com>
Date:   Mon, 26 Jun 2023 15:39:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: perf-tools-next: Request for testing hybrid changes
Content-Language: en-US
To:     Will Deacon <will@kernel.org>, Ian Rogers <irogers@google.com>
Cc:     John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Namhyung Kim <namhyung@gmail.com>, mark.rutland@arm.com
References: <CAM9d7cgmHuhv1U6yAB-2qUr8SuFjUd-Lqw0kew9MaBVeD8xxGw@mail.gmail.com>
 <CAP-5=fXFBpaN+ajF+u6GAL-3bb9LPR=dwevB_-7N7uUh-c3SPw@mail.gmail.com>
 <a3958a0c-092f-b609-e2ea-0d35fddd4375@arm.com>
 <CAP-5=fX8Nwtra=EgRNh3Ybp+N0BKp4Cw=0uRS9ZCdPyGF4R_bA@mail.gmail.com>
 <20230626123249.GC19941@willie-the-truck>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230626123249.GC19941@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 26/06/2023 13:32, Will Deacon wrote:
> On Fri, Jun 23, 2023 at 07:30:53AM -0700, Ian Rogers wrote:
>> On Fri, Jun 23, 2023 at 1:42 AM James Clark <james.clark@arm.com> wrote:
>>>
>>>
>>>
>>> On 22/06/2023 21:15, Ian Rogers wrote:
>>>> On Thu, Jun 22, 2023 at 11:57 AM Namhyung Kim <namhyung@gmail.com> wrote:
>>>>>
>>>>> Hello,
>>>>>
>>>>> In this development cycle, we've got a big change in how to handle
>>>>> heterogeneous core PMUs. It's mostly tested on Intel hybrid machines
>>>>> but caused some troubles on others.  So I'd like to confirm it works
>>>>> on major platforms without problems.  Especially on ARM64 as it has
>>>>> the big.LITTLE CPUs.
>>>>
>>>>
>>>> Thanks Namhyung. I believe there is a change on ARM64 that makes a
>>>> problem of one type into a slightly different problem. The perf parse
>>>> events logic handles events certain known hardware events using known
>>>> numeric encodings, for example, the cycles event has a type of 0
>>>> (PERF_TYPE_HARDWARE) and a config of 0 (PERF_COUNT_HW_CPU_CYCLES):
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/parse-events.l?h=perf-tools-next#n286
>>>>
>>>> The perf_event_open syscall can specify a CPU number of -1 for any. My
>>>> understanding is that -1 on ARM translates into choose the PMU of the
>>>> current running thread, this means that if a thread migrates from
>>>> between core/PMU types it won't be recorded on the alternate PMU type.
>>>>
>>>> The extended type capability (PERF_PMU_CAP_EXTENDED_HW_TYPE) solves
>>>> this, but appears not to be set on ARM's PMU:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/drivers/perf/arm-cmn.c#n2291
>>>> Could an ARM64 related person fix this?
>>>>
>>>
>>> Yes I was planning to look into this since this thread [1].
>>> It seems like there are still some test failures on Juno which I'm
>>> working through now, even after the fix in that thread. And I was
>>> thinking that it should be possible to support
>>> PERF_PMU_CAP_EXTENDED_HW_TYPE on Arm too.
>>
>> Thanks James, my memory of Juno boards was early bring up work and I
>> don't recall them having heterogeneous PMUs. Presumably this is
>> another issue, I'm happy to help if you can share more details.
>>
>> It is great that you'll look to add PERF_PMU_CAP_EXTENDED_HW_TYPE,
>> there is also the legacy kernel issue. Do you have a plan there or
>> should supporting PERF_PMU_CAP_EXTENDED_HW_TYPE be the plan? As the
>> Linux 6.5 merge window will open soon I'm concerned that these fixes
>> may only make it into 6.6. Should we do anything short-term for 6.5?
>> For example, if extended types aren't supported then disable the
>> wildcard matching of PMUs in the "numeric", really PERF_TYPE_HARDWARE
>> and PERF_TYPE_HW_CACHE, cases?
> 
> What does PERF_PMU_CAP_EXTENDED_HW_TYPE buy us on Arm, given that we've
> supported heterogeneous PMUs for years without issues? In other words,
> what is the benefit of supporting two user ABIs here?
> 
> Will

Aren't there some issues around per-process perf sessions and choosing
which PMU to use?

For example on Juno if I run perf on one of the big cores (1 and 2),
then I only get an accurate cycle count if the process I'm interested in
also runs on a big core:

  taskset --cpu-list 1 perf stat -e cycles -- taskset \
   --cpu-list 1 stress -c 1 -t 1

  1087015046      cycles:u

If the stress process runs on a small core (4 for example) then I get a
much lower count, which I think is only accounting for the taskset
before it finishes pinning stress to the small core:

  taskset --cpu-list 1 perf stat -e cycles -- taskset \
    --cpu-list 4 stress -c 1 -t 1

  68134032      cycles:u

Then if perf starts on a small core it gets even worse, you never get
any cycle counts, even if stress runs on the same core:

  taskset --cpu-list 0 perf stat -e cycles -- taskset \
    --cpu-list 0 stress -c 1 -t 1

  <not counted>      cycles:u

I'm not sure how many of these are just the perf tool doing the wrong
thing and should be fixed in other ways than using
PERF_PMU_CAP_EXTENDED_HW_TYPE. But there is also something to be said
for consistency that if PERF_PMU_CAP_EXTENDED_HW_TYPE is already
understood by the tool as a way to use different PMU types then
supporting it on Arm might make sense.

James
