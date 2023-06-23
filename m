Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AC7EB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 08:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjFWImx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 04:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjFWImw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 04:42:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 204C9212E
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 01:42:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82E41C14;
        Fri, 23 Jun 2023 01:43:33 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D71B83F64C;
        Fri, 23 Jun 2023 01:42:47 -0700 (PDT)
Message-ID: <a3958a0c-092f-b609-e2ea-0d35fddd4375@arm.com>
Date:   Fri, 23 Jun 2023 09:42:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: perf-tools-next: Request for testing hybrid changes
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>, Mike Leach <mike.leach@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Namhyung Kim <namhyung@gmail.com>
References: <CAM9d7cgmHuhv1U6yAB-2qUr8SuFjUd-Lqw0kew9MaBVeD8xxGw@mail.gmail.com>
 <CAP-5=fXFBpaN+ajF+u6GAL-3bb9LPR=dwevB_-7N7uUh-c3SPw@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fXFBpaN+ajF+u6GAL-3bb9LPR=dwevB_-7N7uUh-c3SPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 22/06/2023 21:15, Ian Rogers wrote:
> On Thu, Jun 22, 2023 at 11:57 AM Namhyung Kim <namhyung@gmail.com> wrote:
>>
>> Hello,
>>
>> In this development cycle, we've got a big change in how to handle
>> heterogeneous core PMUs. It's mostly tested on Intel hybrid machines
>> but caused some troubles on others.  So I'd like to confirm it works
>> on major platforms without problems.  Especially on ARM64 as it has
>> the big.LITTLE CPUs.
> 
> 
> Thanks Namhyung. I believe there is a change on ARM64 that makes a
> problem of one type into a slightly different problem. The perf parse
> events logic handles events certain known hardware events using known
> numeric encodings, for example, the cycles event has a type of 0
> (PERF_TYPE_HARDWARE) and a config of 0 (PERF_COUNT_HW_CPU_CYCLES):
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/parse-events.l?h=perf-tools-next#n286
> 
> The perf_event_open syscall can specify a CPU number of -1 for any. My
> understanding is that -1 on ARM translates into choose the PMU of the
> current running thread, this means that if a thread migrates from
> between core/PMU types it won't be recorded on the alternate PMU type.
> 
> The extended type capability (PERF_PMU_CAP_EXTENDED_HW_TYPE) solves
> this, but appears not to be set on ARM's PMU:
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/drivers/perf/arm-cmn.c#n2291
> Could an ARM64 related person fix this?
> 

Yes I was planning to look into this since this thread [1].
It seems like there are still some test failures on Juno which I'm
working through now, even after the fix in that thread. And I was
thinking that it should be possible to support
PERF_PMU_CAP_EXTENDED_HW_TYPE on Arm too.

[1]: https://lore.kernel.org/all/ZIxza13x+AwApbQb@kernel.org/

> The perf tool is expecting it to be supported and so it tries to open
> the event for each core PMU, so the cycles event will open for each of
> a BIG.little PMU, however, as the extended type isn't supported the
> same event will be opened twice and the migration problem still
> exists. This problem exists for all PERF_TYPE_HARDWARE events (10) and
> all PERF_TYPE_HW_CACHE events (42).
> 
> Assuming the capability issue is fixed, there is still an open issue
> about how to properly support these 52 events on older kernels. It
> would be possible to use the architecture standard events, so cycles
> can map to cpu_cycles, instructions to sw_incr, cache-references to
> l1d_cache (probably), etc. I'm not sure this will work for all 52
> events and the plumbing in the perf tool isn't straightforward.
> There's also the question of whether such a change of events should
> happen when we know the perf_event_open will be given a CPU, should
> that case not wildcard PMUs?>
> I'm happy to provide more context/details.
> 
> Thanks,
> Ian
> 
>> Also we are transitioning from Arnaldo's tree to new repositories in
>> git.kernel.org:
>>
>>  * kernel/git/perf/perf-tools (for the fixes on the current dev cycle)
>>  * kernel/git/perf/perf-tools-next (for new features for the next cycle)
>>
>> There is a branch with the same name.  Please check out
>> perf-tools-next and play with it.
>>
>> Thanks,
>> Namhyung
