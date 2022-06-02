Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5D8C43334
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Jun 2022 15:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbiFBP5G (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Jun 2022 11:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236680AbiFBP5D (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Jun 2022 11:57:03 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CCC3B03C
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Jun 2022 08:57:01 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q7so7023584wrg.5
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Jun 2022 08:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Ig/QhQNnSaLYheTCx1UmngTcl4ocLyAvqu6aDJbhrs=;
        b=HE5pG9/aW4cFaYUi6zQUrIpflq8Rz1EmOHhp5Vv9uU3l1AcUZYYvub4GDxHpMx5KMw
         uY/vleFSi86p0QlWLGyezZ9otl0kAng0Rd3nZuX95pp/rRZlldec20Y2LTzHC+jiBqd9
         0QTTJUZlCVjvdcLONhDBx3i7TSkiZXyES1367AcQuiiMjTI21+6pzzLv3z1IFjSC4waw
         IGL/sHVyXuljO7Vjhzo7TPlUN3fyLYUlGWpxnB5Es2TQFHXCVzh3Khxx6SKyM+6jOGEx
         tPpR7YdLpJP/dBJR9nWW5ahN/GhzX9sNawbsOr2kjaQ+lykJiLPoUlblkDuHQTayp2M9
         Wnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Ig/QhQNnSaLYheTCx1UmngTcl4ocLyAvqu6aDJbhrs=;
        b=oedq4c4HrlDBSVggaL+jkIKOhPdh7JfQe3bWAU+ekcTy8ZW9hLu1DaxM14VAv8dh2g
         5PfOGVXv9Xq7TuEpPGe2bh/mZKBR4VMu6GCsvJUlQmu4GJBK19FkyR8AqNJuP3MywiWQ
         //TIQ6uMZOQDDrDfHxZGl9NFyC65Bx9/z2HK0K07BaD4DiFMir5VTf5jmniGP+2VD7lU
         DFhnJnrl9e1MzJggTPBOETBhzZT6m89dXwXEMO7LZvIvTZn2oUdDlpXK+BnS/p/lOE5b
         6g+52iuLiN9XANycG5ihTgjOVnJcwHvS8RywMp4V4MbQ3hVfc1YAeePDYKvTg/84m/II
         AF7g==
X-Gm-Message-State: AOAM530FvysE15y/2PdjO7Re75uRYeiVvm4jIOXfgXhjYA2KONAX7moa
        E6EQFEJKlslJzTIYiO+wHKwL7T6xB2x/hhwU7l3+Sw==
X-Google-Smtp-Source: ABdhPJz5ISXPXoE/MgUc6zgjthJZFFkewnKP4x4ZhIf/sbQktclnaMMA/XyT6n+o3tl8kLWpfpu945b4VsR6Hx2qLxM=
X-Received: by 2002:a05:6000:1acc:b0:20f:f12a:a535 with SMTP id
 i12-20020a0560001acc00b0020ff12aa535mr4463758wry.375.1654185419962; Thu, 02
 Jun 2022 08:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220602153603.1884710-1-zhengjun.xing@linux.intel.com>
In-Reply-To: <20220602153603.1884710-1-zhengjun.xing@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Jun 2022 08:56:45 -0700
Message-ID: <CAP-5=fUw2TdA_nqbhCc7GjG6+XOfst6gW4FGAeshW7xxmq64nA@mail.gmail.com>
Subject: Re: [PATCH] perf record: Support sample-read topdown metric group for
 hybrid platforms
To:     zhengjun.xing@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 2, 2022 at 8:35 AM <zhengjun.xing@linux.intel.com> wrote:
>
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>
> With the hardware TopDown metrics feature, the sample-read feature should
> be supported for a TopDown group, e.g., sample a non-topdown event and read
> a Topdown metric group. But the current perf record code errors are out.
>
> For a TopDown metric group,the slots event must be the leader of the group,
> but the leader slots event doesn't support sampling. To support sample-read
> the TopDown metric group, uses the 2nd event of the group as the "leader"
> for the purposes of sampling.
>
> Only the platform with the TopDown metric feature supports sample-read the
> topdown group. In commit acb65150a47c ("perf record: Support sample-read
> topdown metric group"), it adds arch_topdown_sample_read() to indicate
> whether the TopDown group supports sample-read, it should only work on the
> non-hybrid systems, this patch extends the support for hybrid platforms.
>
> Before:
>
>  # ./perf record -e "{cpu_core/slots/,cpu_core/cycles/,cpu_core/topdown-retiring/}:S" -a sleep 1
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cpu_core/topdown-retiring/).
> /bin/dmesg | grep -i perf may provide additional information.
>
> After:
>
>  # ./perf record -e "{cpu_core/slots/,cpu_core/cycles/,cpu_core/topdown-retiring/}:S" -a sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.238 MB perf.data (369 samples) ]
>
> Fixes: acb65150a47c ("perf record: Support sample-read topdown metric group")
> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/arch/x86/util/evsel.c   |  3 ++-
>  tools/perf/arch/x86/util/evsel.h   |  7 +++++++
>  tools/perf/arch/x86/util/topdown.c | 21 ++++-----------------
>  3 files changed, 13 insertions(+), 18 deletions(-)
>  create mode 100644 tools/perf/arch/x86/util/evsel.h
>
> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
> index ff4561b7b600..3501399cef35 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -5,6 +5,7 @@
>  #include "util/env.h"
>  #include "util/pmu.h"
>  #include "linux/string.h"
> +#include "evsel.h"
>
>  void arch_evsel__set_sample_weight(struct evsel *evsel)
>  {
> @@ -32,7 +33,7 @@ void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr)
>  }
>
>  /* Check whether the evsel's PMU supports the perf metrics */
> -static bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
> +bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
>  {
>         const char *pmu_name = evsel->pmu_name ? evsel->pmu_name : "cpu";
>
> diff --git a/tools/perf/arch/x86/util/evsel.h b/tools/perf/arch/x86/util/evsel.h
> new file mode 100644
> index 000000000000..19ad1691374d
> --- /dev/null
> +++ b/tools/perf/arch/x86/util/evsel.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _EVSEL_H
> +#define _EVSEL_H 1
> +
> +bool evsel__sys_has_perf_metrics(const struct evsel *evsel);
> +
> +#endif
> diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
> index f4d5422e9960..f81a7cfe4d63 100644
> --- a/tools/perf/arch/x86/util/topdown.c
> +++ b/tools/perf/arch/x86/util/topdown.c
> @@ -4,6 +4,7 @@
>  #include "util/pmu.h"
>  #include "util/topdown.h"
>  #include "topdown.h"
> +#include "evsel.h"
>
>  /* Check whether there is a PMU which supports the perf metrics. */
>  bool topdown_sys_has_perf_metrics(void)
> @@ -55,33 +56,19 @@ void arch_topdown_group_warn(void)
>
>  #define TOPDOWN_SLOTS          0x0400
>
> -static bool is_topdown_slots_event(struct evsel *counter)
> -{
> -       if (!counter->pmu_name)
> -               return false;
> -
> -       if (strcmp(counter->pmu_name, "cpu"))
> -               return false;
> -
> -       if (counter->core.attr.config == TOPDOWN_SLOTS)
> -               return true;
> -
> -       return false;
> -}
> -
>  /*
>   * Check whether a topdown group supports sample-read.
>   *
> - * Only Topdown metic supports sample-read. The slots
> + * Only Topdown metric supports sample-read. The slots
>   * event must be the leader of the topdown group.
>   */
>
>  bool arch_topdown_sample_read(struct evsel *leader)
>  {
> -       if (!pmu_have_event("cpu", "slots"))
> +       if (!evsel__sys_has_perf_metrics(leader))
>                 return false;
>
> -       if (is_topdown_slots_event(leader))
> +       if (leader->core.attr.config == TOPDOWN_SLOTS)
>                 return true;
>
>         return false;
> --
> 2.25.1
>
