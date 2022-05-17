Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AB6C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 May 2022 02:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbiEQCyS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 16 May 2022 22:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbiEQCyQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 May 2022 22:54:16 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D20C4578A
        for <linux-perf-users@vger.kernel.org>; Mon, 16 May 2022 19:54:15 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m1so22804099wrb.8
        for <linux-perf-users@vger.kernel.org>; Mon, 16 May 2022 19:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ogwqf23Klwp9j3f+tkv7Xz3HefBp63TbWbDqRWio0dA=;
        b=KSA2PxSN4WfHF6X4XOj1Wrg6lS4OTVpoviWMiUzWfUWhs5exm9kHxYjfSheRIr4EZB
         PWYlQ9m1eaI3cmaw0Uo2OoRa3KrgonRHYdmhMtYaF4usPTV6YxlIm47Pxr0sVjwiFbOr
         7t8ZR8f2B3Hsvz72JlL6llW3Nm/4uDlVszbO5vkvM/jSrdET+PTQ9ygtYoni3yWOCeDh
         Pzf9x0iXVskwvB0auOiWW8tRm6+DovXib3bjKQ97dWX8tNBY+8SHvbUdntngmSimK4wk
         ezddMQl2do/i1XrNvZ4lkM3revgDva6U5Jz4WTc74lMsj0z5uGY7D3uOrpvKSWANykGV
         TooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ogwqf23Klwp9j3f+tkv7Xz3HefBp63TbWbDqRWio0dA=;
        b=XLgFFXgOOnqY1Cm8dGhscKhZdeuGj0GWDV4lb+9iKESP51Oo1/qtMttPTgvq0s6jkD
         FXr1tvse3wrxNjx4PvpZnNYYVs1EI/8duiOx2A6dsFAFxB0qL4ScTgUbqCOioaOuJDwG
         H51QH2J0CBw97Q/wXDG33bcr46uoBuvwu0rF1XCNOENbWIHWtVA/Qq+Ym6hUJQsdoHD3
         bDlvZqfk5Dcl+0YXNOLfY2gb9vM7XQrZiJ58AX4K/bPiNqqkI7U0uBcDeyWL3GDeBsAe
         GpEHJP8CxiuhqaOO3uhDMbAMi/IE/0Dv94+xQ3G2aycfHUgVZuUa89k7THa/ZqnPlxjq
         70sw==
X-Gm-Message-State: AOAM531GSTFe7qXPcoU95h2OCEYi/zzXiytIfKq1wGg3/3KaP5QMXt2f
        FjoCjEaEXw6DR+lPKIFZUgvvejEfsnd7DzMtO9TsVw==
X-Google-Smtp-Source: ABdhPJyq4YeUkQ3b8WJdUd66WXxR/cXXj+RD9Jf+akN7d03gOnLeuzlfWkPvqjM9aC5sgHxPbrOchObXLu8JFMbWwrg=
X-Received: by 2002:a05:6000:78b:b0:20d:101b:2854 with SMTP id
 bu11-20020a056000078b00b0020d101b2854mr3837402wrb.300.1652756053462; Mon, 16
 May 2022 19:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220516152436.1104757-1-kan.liang@linux.intel.com> <20220516152436.1104757-5-kan.liang@linux.intel.com>
In-Reply-To: <20220516152436.1104757-5-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 16 May 2022 19:54:00 -0700
Message-ID: <CAP-5=fXwAyJDkntgf-WPsiTg73sFpobZ5J-pr+cAFK4QKPhJtw@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] perf parse-events: Move slots event for the hybrid
 platform too
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        zhengjun.xing@linux.intel.com, adrian.hunter@intel.com,
        ak@linux.intel.com, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, May 16, 2022 at 8:25 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The commit 94dbfd6781a0 ("perf parse-events: Architecture specific
> leader override") introduced a feature to reorder the slots event to
> fulfill the restriction of the perf metrics topdown group. But the
> feature doesn't work on the hybrid machine.
>
> $perf stat -e "{cpu_core/instructions/,cpu_core/slots/,cpu_core/topdown-retiring/}" -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>      <not counted>      cpu_core/instructions/
>      <not counted>      cpu_core/slots/
>    <not supported>      cpu_core/topdown-retiring/
>
>        1.002871801 seconds time elapsed
>
> A hybrid platform has a different PMU name for the core PMUs, while
> current perf hard code the PMU name "cpu".
>
> Introduce a new function to check whether the system supports the perf
> metrics feature. The result is cached for the future usage.
>
> For X86, the core PMU name always has "cpu" prefix.
>
> With the patch,
>
> $perf stat -e "{cpu_core/instructions/,cpu_core/slots/,cpu_core/topdown-retiring/}" -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>         76,337,010      cpu_core/slots/
>         10,416,809      cpu_core/instructions/
>         11,692,372      cpu_core/topdown-retiring/
>
>        1.002805453 seconds time elapsed
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/arch/x86/util/evlist.c  |  5 +++--
>  tools/perf/arch/x86/util/topdown.c | 24 ++++++++++++++++++++++++
>  tools/perf/arch/x86/util/topdown.h |  7 +++++++
>  3 files changed, 34 insertions(+), 2 deletions(-)
>  create mode 100644 tools/perf/arch/x86/util/topdown.h
>
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> index 75564a7df15b..68f681ad54c1 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -3,6 +3,7 @@
>  #include "util/pmu.h"
>  #include "util/evlist.h"
>  #include "util/parse-events.h"
> +#include "topdown.h"
>
>  #define TOPDOWN_L1_EVENTS      "{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound}"
>  #define TOPDOWN_L2_EVENTS      "{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound,topdown-heavy-ops,topdown-br-mispredict,topdown-fetch-lat,topdown-mem-bound}"
> @@ -25,12 +26,12 @@ struct evsel *arch_evlist__leader(struct list_head *list)
>
>         first = list_first_entry(list, struct evsel, core.node);
>
> -       if (!pmu_have_event("cpu", "slots"))
> +       if (!topdown_sys_has_perf_metrics())
>                 return first;
>
>         /* If there is a slots event and a topdown event then the slots event comes first. */
>         __evlist__for_each_entry(list, evsel) {
> -               if (evsel->pmu_name && !strcmp(evsel->pmu_name, "cpu") && evsel->name) {
> +               if (evsel->pmu_name && !strncmp(evsel->pmu_name, "cpu", 3) && evsel->name) {
>                         if (strcasestr(evsel->name, "slots")) {
>                                 slots = evsel;
>                                 if (slots == first)
> diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
> index 2f3d96aa92a5..5e86859279e3 100644
> --- a/tools/perf/arch/x86/util/topdown.c
> +++ b/tools/perf/arch/x86/util/topdown.c
> @@ -3,6 +3,30 @@
>  #include "api/fs/fs.h"
>  #include "util/pmu.h"
>  #include "util/topdown.h"
> +#include "topdown.h"
> +
> +bool topdown_sys_has_perf_metrics(void)
> +{
> +       static bool has_perf_metrics;
> +       static bool cached;
> +       struct perf_pmu *pmu;
> +
> +       if (cached)
> +               return has_perf_metrics;
> +
> +       /*
> +        * The perf metrics feature is a core PMU feature.
> +        * The PERF_TYPE_RAW type is the type of a core PMU.
> +        * The slots event is only available when the core PMU
> +        * supports the perf metrics feature.
> +        */
> +       pmu = perf_pmu__find_by_type(PERF_TYPE_RAW);
> +       if (pmu && pmu_have_event(pmu->name, "slots"))
> +               has_perf_metrics = true;
> +
> +       cached = true;
> +       return has_perf_metrics;
> +}
>
>  /*
>   * Check whether we can use a group for top down.
> diff --git a/tools/perf/arch/x86/util/topdown.h b/tools/perf/arch/x86/util/topdown.h
> new file mode 100644
> index 000000000000..46bf9273e572
> --- /dev/null
> +++ b/tools/perf/arch/x86/util/topdown.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _TOPDOWN_H
> +#define _TOPDOWN_H 1
> +
> +bool topdown_sys_has_perf_metrics(void);
> +
> +#endif
> --
> 2.35.1
>
