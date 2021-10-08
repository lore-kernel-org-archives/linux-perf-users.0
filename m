Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF2AC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 15:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E8CC6101A
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 15:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242783AbhJHPY5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Oct 2021 11:24:57 -0400
Received: from foss.arm.com ([217.140.110.172]:58712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242780AbhJHPY4 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Oct 2021 11:24:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C30131063;
        Fri,  8 Oct 2021 08:23:00 -0700 (PDT)
Received: from [10.1.25.132] (e124483.cambridge.arm.com [10.1.25.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F00613F66F;
        Fri,  8 Oct 2021 08:22:52 -0700 (PDT)
Message-ID: <90460425-a987-2f18-ba9c-f064af5fb941@arm.com>
Date:   Fri, 8 Oct 2021 16:22:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 02/21] perf pmu: Add const to pmu_events_map.
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        ToastC <mrtoastcheng@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Felix Fietkau <nbd@nbd.name>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Song Liu <songliubraving@fb.com>, Fabian Hemmer <copy@copy.sh>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Denys Zagorui <dzagorui@cisco.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20211007165647.3514803-1-irogers@google.com>
 <20211007165647.3514803-3-irogers@google.com>
 <cee9bbe0-d19a-60ab-68c9-4632bd759274@huawei.com>
From:   Andrew Kilroy <andrew.kilroy@arm.com>
In-Reply-To: <cee9bbe0-d19a-60ab-68c9-4632bd759274@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 08/10/2021 12:01, John Garry wrote:
> On 07/10/2021 17:56, Ian Rogers wrote:
>> The pmu_events_map is generated at compile time and used for lookup. For
>> testing purposes we need to swap the map being used. Having the
>> pmu_events_map be non-const is misleading as it may be an out argument.
>> Make it const and update uses so they work on const too.
>>
>> Signed-off-by: Ian Rogers<irogers@google.com>
> 
> Reviewed-by: John Garry <john.garry@huawei.com>

Got a compile error for this on arm64 when basing these patches on 
acme/perf/core (be8ecc57f180415e8a7c1cc5620c5236be2a7e56):

$ make DEBUG=1 O=output
...<snipped>...
arch/arm64/util/pmu.c:6:24: error: conflicting types for 
‘pmu_events_map__find’
  struct pmu_events_map *pmu_events_map__find(void)
                         ^~~~~~~~~~~~~~~~~~~~
In file included from arch/arm64/util/pmu.c:4:0:
arch/arm64/util/../../../util/pmu.h:126:30: note: previous declaration 
of ‘pmu_events_map__find’ was here
  const struct pmu_events_map *pmu_events_map__find(void);
                               ^~~~~~~~~~~~~~~~~~~~
arch/arm64/util/pmu.c: In function ‘pmu_events_map__find’:
arch/arm64/util/pmu.c:21:10: error: return discards ‘const’ qualifier 
from pointer target type [-Werror=discarded-qualifiers]
    return perf_pmu__find_map(pmu);
           ^~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
/home/andkil01/linux/tools/build/Makefile.build:96: recipe for target 
'/home/andkil01/linux/tools/perf/output/arch/arm64/util/pmu.o' failed
make[6]: *** 
[/home/andkil01/linux/tools/perf/output/arch/arm64/util/pmu.o] Error 1
/home/andkil01/linux/tools/build/Makefile.build:139: recipe for target 
'util' failed
make[5]: *** [util] Error 2
/home/andkil01/linux/tools/build/Makefile.build:139: recipe for target 
'arm64' failed
make[4]: *** [arm64] Error 2
/home/andkil01/linux/tools/build/Makefile.build:139: recipe for target 
'arch' failed
make[3]: *** [arch] Error 2
make[3]: *** Waiting for unfinished jobs....


Andrew
