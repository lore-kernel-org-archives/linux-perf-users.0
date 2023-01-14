Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99153C46467
	for <linux-perf-users@archiver.kernel.org>; Sat, 14 Jan 2023 22:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjANWP6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 14 Jan 2023 17:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjANWP5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 14 Jan 2023 17:15:57 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7049EF1
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Jan 2023 14:15:55 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d2so4014814wrp.8
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Jan 2023 14:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YvJxc094w/p+uGKXyvBDSmDnRQCH9LAZXm10L+znEz0=;
        b=TMsTSuIklOVCw6UKn1mcDIcVavhmX1cS1fdBcSC+SDNvJQBKXjUJ3mnIAMwe9yUNKA
         sbQL15wkptk6JoAaaaKIRRb5IMboU9Vj5r/8wD2JkeXi9JGQoSCWCt3hGdiJgPkvF910
         Igtpg+hBDngbqvZ9yug2s0g+aDnRkgQ8oCmthhAY1uvX6eTyQCfSmKbCOzX1lMq1Iwm1
         QDtuIGnMAijPz2w9yRDMF1zV0ZqbQh1e10xWBVw1fI9j5IKeOPN+E79hylqetis++O2S
         6R7Y4JYdmxKV1FV2Tqia+SifEweFHc3ETaltl3kRcboYQ0aFOKWNYHY/eYNWgBq6k3Jp
         1Pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YvJxc094w/p+uGKXyvBDSmDnRQCH9LAZXm10L+znEz0=;
        b=7LTPyRcQ5cBvGbQyUx5HcFmHIcu+E55SbNKFo830i4yeDB4pOIZ4T81Swd40yCgpo7
         2TOYs1fE0BcUVHvN4KyFXHIAAcgHyJbxYDaYgZU/ySJSGHMS5mboCS6TngbpwBJM3yx0
         hwy2dOvvMT3pBblGIKqzLMlWJBOAHfoMBuppmICvx9/6v+OkrSwXDjbkk3HmHmZPqSED
         XAoiCYqnDDTyrySa4PrnnCIUQ6Ai5Afuu08CTks9eNG6z+siXdCTENqh/+nonVg1KOT6
         cul806KBTSckv/Gti4A8Zqq/vomX7nsw6Bz4KU4KLMvGd/jVFPUNJ/XCbeofEfHxj48i
         PAbw==
X-Gm-Message-State: AFqh2kpmPMtEvzqOfVnWBmK1Y/Ntxnpy2RJiz1s2vo3I2LkbcM0HuiyP
        GU6mLHK0+pxg+CIvk7AtrfnQ3rh5pocJdiQSw1Qn+Q==
X-Google-Smtp-Source: AMrXdXu7YeKIwAER2/dhiXDzDoO0vnq+d3GuKpeQtwAPytCfHB+t6AH+kDxFLB/+KUoDBwsa6of67cBPzjekxu7H+MQ=
X-Received: by 2002:a5d:6c65:0:b0:2bd:f8da:9be0 with SMTP id
 r5-20020a5d6c65000000b002bdf8da9be0mr12259wrz.375.1673734554131; Sat, 14 Jan
 2023 14:15:54 -0800 (PST)
MIME-Version: 1.0
References: <1673601740-122788-1-git-send-email-renyu.zj@linux.alibaba.com> <1673601740-122788-2-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1673601740-122788-2-git-send-email-renyu.zj@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 14 Jan 2023 14:15:40 -0800
Message-ID: <CAP-5=fWnOGD7CHYeq0Uino4eHte2WP5Pxz9t4YOtvgxrq-_muA@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] perf pmu: Add #slots literal support for arm64
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jan 13, 2023 at 1:22 AM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>
> The slots in each architecture may be different, so add #slots literal
> to obtain the slots of different architectures, and the #slots can be
> applied in the metric. Currently, The #slots just support for arm64,
> and other architectures will return NAN.
>
> On arm64, the value of slots is from the register PMMIR_EL1.SLOT, which
> I can read in /sys/bus/event_source/device/armv8_pmuv3_*/caps/slots.
> PMMIR_EL1.SLOT might read as zero if the PMU version is lower than
> ID_AA64DFR0_EL1_PMUVer_V3P4 or the STALL_SLOT event is not implemented.
>
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> ---
>  tools/perf/arch/arm64/util/pmu.c | 34 ++++++++++++++++++++++++++++++++--
>  tools/perf/util/expr.c           |  5 +++++
>  tools/perf/util/pmu.c            |  6 ++++++
>  tools/perf/util/pmu.h            |  1 +
>  4 files changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
> index 477e513..5f8667b 100644
> --- a/tools/perf/arch/arm64/util/pmu.c
> +++ b/tools/perf/arch/arm64/util/pmu.c
> @@ -3,8 +3,9 @@
>  #include <internal/cpumap.h>
>  #include "../../../util/cpumap.h"
>  #include "../../../util/pmu.h"
> +#include <api/fs/fs.h>
>
> -const struct pmu_events_table *pmu_events_table__find(void)
> +static struct perf_pmu *pmu_core__find_same(void)

I'm not sure "find_same" is the best name here. I suspect it should be
"find_core_pmu" which would agree with is_arm_pmu_core. Unfortunately
"core" has become an overloaded term sometimes used interchangeably
with CPU, hyperthread or SMT thread, it was a model name for Intel and
it is used to distinguish a set of SMT threads running together from a
single one. Anyway, for consistency I think perf_pmu__find_core_pmu is
the most appropriate name (or pmu__find_core_pmu, I'm not sure why we
get the extra perf_ prefix sometimes, in general that indicates the
functionality is in libperf).

Aside from that, lgtm. Thanks,
Ian

>  {
>         struct perf_pmu *pmu = NULL;
>
> @@ -19,8 +20,37 @@ const struct pmu_events_table *pmu_events_table__find(void)
>                 if (pmu->cpus->nr != cpu__max_cpu().cpu)
>                         return NULL;
>
> -               return perf_pmu__find_table(pmu);
> +               return pmu;
>         }
>
>         return NULL;
>  }
> +
> +const struct pmu_events_table *pmu_events_table__find(void)
> +{
> +       struct perf_pmu *pmu = pmu_core__find_same();
> +
> +       if (pmu)
> +               return perf_pmu__find_table(pmu);
> +
> +       return NULL;
> +}
> +
> +double perf_pmu__cpu_slots_per_cycle(void)
> +{
> +       char path[PATH_MAX];
> +       unsigned long long slots = 0;
> +       struct perf_pmu *pmu = pmu_core__find_same();
> +
> +       if (pmu) {
> +               scnprintf(path, PATH_MAX,
> +                       EVENT_SOURCE_DEVICE_PATH "%s/caps/slots", pmu->name);
> +               /*
> +                * The value of slots is not greater than 32 bits, but sysfs__read_int
> +                * can't read value with 0x prefix, so use sysfs__read_ull instead.
> +                */
> +               sysfs__read_ull(path, &slots);
> +       }
> +
> +       return (double)slots;
> +}
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 00dcde3..9d3076a 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -19,6 +19,7 @@
>  #include <linux/zalloc.h>
>  #include <ctype.h>
>  #include <math.h>
> +#include "pmu.h"
>
>  #ifdef PARSER_DEBUG
>  extern int expr_debug;
> @@ -448,6 +449,10 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
>                 result = topology->core_cpus_lists;
>                 goto out;
>         }
> +       if (!strcmp("#slots", literal)) {
> +               result = perf_pmu__cpu_slots_per_cycle() ?: NAN;
> +               goto out;
> +       }
>
>         pr_err("Unrecognized literal '%s'", literal);
>  out:
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 2bdeb89..cbb4fbf 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -19,6 +19,7 @@
>  #include <regex.h>
>  #include <perf/cpumap.h>
>  #include <fnmatch.h>
> +#include <math.h>
>  #include "debug.h"
>  #include "evsel.h"
>  #include "pmu.h"
> @@ -1993,3 +1994,8 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
>         *ucpus_ptr = unmatched_cpus;
>         return 0;
>  }
> +
> +double __weak perf_pmu__cpu_slots_per_cycle(void)
> +{
> +       return NAN;
> +}
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 69ca000..fd414ba 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -259,4 +259,5 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
>
>  char *pmu_find_real_name(const char *name);
>  char *pmu_find_alias_name(const char *name);
> +double perf_pmu__cpu_slots_per_cycle(void);
>  #endif /* __PMU_H */
> --
> 1.8.3.1
>
