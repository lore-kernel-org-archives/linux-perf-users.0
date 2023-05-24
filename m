Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2544C77B7A
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 May 2023 22:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbjEXWe2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 May 2023 18:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbjEXWe1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 May 2023 18:34:27 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57945FA
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:33:55 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f38824a025so79511cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684967626; x=1687559626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyEU5OsCRY/yGoB6PyW2OQuIJez0sdTCx6qaItf1S5g=;
        b=Pgl6cxxgci78kLAVU3hg5HMNg/JWkpyFvcdoo7xA5rg8xgZhMVlxlT+Yp1KJiQPDV9
         KVlEHeEQ/2U1Fmpz4m12yJKxKHU2Piu4kVGo0I617XtgVJBekNUvjalakgghIqx/7yue
         ukMnjDcqPDTo2jQ04zIY4+RGPCDXx8qi6jmU73IB1yRGJbUHZxtjXvW8fii3Km5nutln
         v+2YN7qaWbRuWMk0kcekLo0+UpBzF8FbsvakNqaAvwGdpuDC4MXI54CAO3fBm0UYYGqG
         JfxxuVDafqJhHbL61c+6ibKAa8Ea6lfaaF5UFdi8SNEJJ+Tay6PBQDD5rT5dgKChC5ro
         6Aug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684967626; x=1687559626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyEU5OsCRY/yGoB6PyW2OQuIJez0sdTCx6qaItf1S5g=;
        b=L3EhiYsmjCmClPb/6/xkb7oXNTJerG7+xDsHyv/8SMC49zgbUS8afXpwIzUAUwVXeH
         5jHR1K2K00Cu7bhpJbp6k0RrWwUWEST/jTbbgGCbbt6k1PKH5RZa2nnUT1hdHH6rDW3h
         /vdhKet9sxuiI8HkaXP92z2VJorQGuVDBLcQcIMvrGYbft18spYBQs4/PROJnvS6dBFd
         Jqmz0SzbLHv0ab6nhSlU6XK5QiP3FfV3Q7QUiijcHrTsA3NPcJ9JxQlt0jsLXKteyCIP
         ESybLlmIcgAfAElwKR0NXfaJKpTDgPeZAFPT7gWTzukyr/bTwdn9XAG4MB1PqERL3U0P
         ftrg==
X-Gm-Message-State: AC+VfDwMKsI/KniR7t030dCOUgaKltWygFqS7cbk3ZXUsYH8RXrmv8bJ
        My0R/RNlTGvzGKVe2unzhe4/n8IwO8cT1qu8OFYufg==
X-Google-Smtp-Source: ACHHUZ6ypVkdPL/mT9z01cqJVuftf3vL0nnB4J8vZMW9cZ9/h7eku9mZP2smMJE7b1PMYn4eLC7Pccl9wHHj1DZ2iY4=
X-Received: by 2002:a05:622a:1a0c:b0:3f5:3110:21bf with SMTP id
 f12-20020a05622a1a0c00b003f5311021bfmr102238qtb.10.1684967625676; Wed, 24 May
 2023 15:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com> <CA+JHD93cMBrcw0O6bwazzACsPr+HhVVGMKf8ZYLnCV0dEm1gmw@mail.gmail.com>
In-Reply-To: <CA+JHD93cMBrcw0O6bwazzACsPr+HhVVGMKf8ZYLnCV0dEm1gmw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 24 May 2023 15:33:30 -0700
Message-ID: <CAP-5=fXY-EanZze4_YsmrcsFiAyPxU2FudTT_2qcAshRUJ5yvQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] PMU refactoring and improvements
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 24, 2023 at 3:21=E2=80=AFPM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On Wed, May 24, 2023, 7:18 PM Ian Rogers <irogers@google.com> wrote:
>>
>> Separate the code in pmu.[ch] into the set/list of PMUs and the code
>> for a particular PMU. Move the set/list of PMUs code into
>> pmus.[ch]. Clean up hybrid code and remove hybrid PMU list, it is
>> sufficient to scan PMUs looking for core ones. Add core PMU list and
>> perf_pmus__scan_core that just reads core PMUs. Switch code that skips
>> non-core PMUs during a perf_pmus__scan, to use the
>> perf_pmus__scan_core variant. Don't scan sysfs for PMUs if all such
>> PMUs have been previously scanned/loaded. Scanning just core PMUs, for
>> the cases it is applicable, can improve the sysfs reading time by more
>> than 4 fold on my laptop, as servers generally have many more uncore
>> PMUs the improvement there should be larger:
>>
>> ```
>> $ perf bench internals pmu-scan -i 1000
>> Computing performance of sysfs PMU event scan for 1000 times
>>   Average core PMU scanning took: 989.231 usec (+- 1.535 usec)
>>   Average PMU scanning took: 4309.425 usec (+- 74.322 usec)
>> ```
>>
>> The patch "perf pmu: Separate pmu and pmus" moves and renames a lot of
>> functions, and is consequently large. The changes are trivial, but
>> kept together to keep the overall number of patches more reasonable.
>>
>> v3. Address fixing hybrid user specified CPU maps by doing it in
>>     propagate maps. Remove nearly all references to cpu_core/cpu_atom
>>     in particular by removing is_pmu_hybrid - hybrid is now >1 core
>>     PMU. Addresses comments by Kan and Namhyung.
>> v2. Address Kan's review comments wrt "cycles" -> "cycles:P" and
>>     "uncore_pmus" -> "other_pmus".
>
>
> Is this series bisectable wrt 'perf test'?

Yep, I wrote it running 'perf test' at each commit. It is somewhat
laborious for me to test on hybrid, so I didn't test smaller things on
that, but I'm guessing that's not a concern anyway. I hope to follow
up with adding an ability to have a non-sysfs directory containing
fake PMUs for testing.

Thanks,
Ian

> - Arnaldo
>>
>>
>> Ian Rogers (35):
>>   perf cpumap: Add intersect function
>>   perf tests: Organize cpu_map tests into a single suite
>>   perf cpumap: Add equal function
>>   libperf cpumap: Add "any CPU"/dummy test function
>>   perf pmu: Detect ARM and hybrid PMUs with sysfs
>>   perf pmu: Add is_core to pmu
>>   perf evsel: Add is_pmu_core inorder to interpret own_cpus
>>   perf pmu: Add CPU map for "cpu" PMUs
>>   perf evlist: Propagate user CPU maps intersecting core PMU maps
>>   perf evlist: Allow has_user_cpus to be set on hybrid
>>   perf target: Remove unused hybrid value
>>   perf tools: Warn if no user requested CPUs match PMU's CPUs
>>   perf evlist: Remove evlist__warn_hybrid_group
>>   perf evlist: Remove __evlist__add_default
>>   perf evlist: Reduce scope of evlist__has_hybrid
>>   perf pmu: Remove perf_pmu__hybrid_mounted
>>   perf pmu: Rewrite perf_pmu__has_hybrid to avoid list
>>   perf x86: Iterate hybrid PMUs as core PMUs
>>   perf topology: Avoid hybrid list for hybrid topology
>>   perf evsel: Compute is_hybrid from PMU being core
>>   perf header: Avoid hybrid PMU list in write_pmu_caps
>>   perf metrics: Remove perf_pmu__is_hybrid use
>>   perf stat: Avoid hybrid PMU list
>>   perf mem: Avoid hybrid PMU list
>>   perf pmu: Remove perf_pmu__hybrid_pmus list
>>   perf pmus: Prefer perf_pmu__scan over perf_pmus__for_each_pmu
>>   perf x86 mem: minor refactor to is_mem_loads_aux_event
>>   perf pmu: Separate pmu and pmus
>>   perf pmus: Split pmus list into core and other
>>   perf pmus: Allow just core PMU scanning
>>   perf pmus: Avoid repeated sysfs scanning
>>   perf pmus: Ensure all PMUs are read for find_by_type
>>   perf pmus: Add function to return count of core PMUs
>>   perf pmus: Remove perf_pmus__has_hybrid
>>   perf pmu: Remove is_pmu_hybrid
>>
>>  tools/lib/perf/cpumap.c                 |  61 +++
>>  tools/lib/perf/evlist.c                 |  25 +-
>>  tools/lib/perf/include/internal/evsel.h |   9 +
>>  tools/lib/perf/include/perf/cpumap.h    |  14 +
>>  tools/perf/arch/arm/util/auxtrace.c     |   7 +-
>>  tools/perf/arch/arm/util/cs-etm.c       |   4 +-
>>  tools/perf/arch/arm64/util/pmu.c        |   6 +-
>>  tools/perf/arch/x86/tests/hybrid.c      |   7 +-
>>  tools/perf/arch/x86/util/auxtrace.c     |   5 +-
>>  tools/perf/arch/x86/util/evlist.c       |  25 +-
>>  tools/perf/arch/x86/util/evsel.c        |  27 +-
>>  tools/perf/arch/x86/util/intel-bts.c    |   4 +-
>>  tools/perf/arch/x86/util/intel-pt.c     |   4 +-
>>  tools/perf/arch/x86/util/mem-events.c   |  17 +-
>>  tools/perf/arch/x86/util/perf_regs.c    |  15 +-
>>  tools/perf/arch/x86/util/topdown.c      |   5 +-
>>  tools/perf/bench/pmu-scan.c             |  60 +--
>>  tools/perf/builtin-c2c.c                |   9 +-
>>  tools/perf/builtin-list.c               |   4 +-
>>  tools/perf/builtin-mem.c                |   9 +-
>>  tools/perf/builtin-record.c             |  29 +-
>>  tools/perf/builtin-stat.c               |  14 +-
>>  tools/perf/builtin-top.c                |  10 +-
>>  tools/perf/tests/attr.c                 |  11 +-
>>  tools/perf/tests/builtin-test.c         |   4 +-
>>  tools/perf/tests/cpumap.c               |  92 ++++-
>>  tools/perf/tests/event_groups.c         |   7 +-
>>  tools/perf/tests/parse-events.c         |  15 +-
>>  tools/perf/tests/parse-metric.c         |   9 +-
>>  tools/perf/tests/pmu-events.c           |   6 +-
>>  tools/perf/tests/switch-tracking.c      |  14 +-
>>  tools/perf/tests/tests.h                |   4 +-
>>  tools/perf/tests/topology.c             |  16 +-
>>  tools/perf/util/Build                   |   2 -
>>  tools/perf/util/cpumap.c                |   4 +-
>>  tools/perf/util/cpumap.h                |   4 +-
>>  tools/perf/util/cputopo.c               |  12 +-
>>  tools/perf/util/env.c                   |   5 +-
>>  tools/perf/util/evlist-hybrid.c         | 162 --------
>>  tools/perf/util/evlist-hybrid.h         |  15 -
>>  tools/perf/util/evlist.c                |  64 +++-
>>  tools/perf/util/evlist.h                |   9 +-
>>  tools/perf/util/evsel.c                 |  60 +--
>>  tools/perf/util/evsel.h                 |   3 -
>>  tools/perf/util/header.c                |  27 +-
>>  tools/perf/util/mem-events.c            |  25 +-
>>  tools/perf/util/metricgroup.c           |   9 +-
>>  tools/perf/util/parse-events.c          |  25 +-
>>  tools/perf/util/parse-events.y          |   3 +-
>>  tools/perf/util/pfm.c                   |   6 +-
>>  tools/perf/util/pmu-hybrid.c            |  52 ---
>>  tools/perf/util/pmu-hybrid.h            |  32 --
>>  tools/perf/util/pmu.c                   | 483 ++----------------------
>>  tools/perf/util/pmu.h                   |  25 +-
>>  tools/perf/util/pmus.c                  | 465 ++++++++++++++++++++++-
>>  tools/perf/util/pmus.h                  |  15 +-
>>  tools/perf/util/print-events.c          |  15 +-
>>  tools/perf/util/python-ext-sources      |   1 -
>>  tools/perf/util/stat-display.c          |  19 +-
>>  tools/perf/util/target.h                |   1 -
>>  60 files changed, 1002 insertions(+), 1089 deletions(-)
>>  delete mode 100644 tools/perf/util/evlist-hybrid.c
>>  delete mode 100644 tools/perf/util/evlist-hybrid.h
>>  delete mode 100644 tools/perf/util/pmu-hybrid.c
>>  delete mode 100644 tools/perf/util/pmu-hybrid.h
>>
>> --
>> 2.40.1.698.g37aff9b760-goog
>>
