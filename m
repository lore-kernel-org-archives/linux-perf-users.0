Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D747CC77B61
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 Apr 2023 20:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344253AbjD0UcU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 27 Apr 2023 16:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344248AbjD0UcU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 Apr 2023 16:32:20 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516D13ABC
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Apr 2023 13:32:18 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3ef36d814a5so822201cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Apr 2023 13:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682627537; x=1685219537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2IXMdwaTTFrx4Coj66/ubvbio61qlQTkstw1d/6UTM=;
        b=6FJm3Ua8TJNcakjBTxQlTKYzRiPls5YFeiueDNbRczYXJ72opYFUCA0Zo7pBkjfaIO
         QeqZXiYFuqW3L/z1bzM3NbQP3+OBGsHS0pzdELmAtv/IVYa7l3XSxoUnA/8/Nx0qfShO
         uP8VD8cFGBbSmgySBoFR+1lNnV+Um1gjMF7uSaNiq68BJeHw82JVnmVAgzOiXSDcglMk
         iDmJfWi/GR4CGxB5JtAhtuF8dNAU58CdOhKT4ejGfhE038InnMdW4uNOm8QDp87o8ft+
         WgGgkob9aODJDAwk8NEiSXRspS0+o+XItngWpN2L/I0AN61L7sbIeYfX7dOsFj1CSSMn
         HAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682627537; x=1685219537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2IXMdwaTTFrx4Coj66/ubvbio61qlQTkstw1d/6UTM=;
        b=il2beXLfQF8RzTunKyfIt6cTUmS1bLCXRj4NwaomVWvATHLi14YGBwaD8VI/YGJbeK
         u74Q7960eAz5gRwImzyLpOOH/O5cUiEq+lEeFsQHiAvC+wdaIrQaW3TskP0lb2KTpDv7
         p3WDXjlz4g8ujxU1rr9Eq/8D1Xc6QuCJjNNpwUwp9RgHWbWyh4xHgz/II6lNsKcPDCWh
         9NPcEeX3MYrIPLm7nGyjrrHMkq2xock7k/Dwg3eZqe0iJl1c7vD/Vpefp9Ig2fYbsnv1
         GK8k2EeGTGk+qDgYbi92BFsOzwjHzLz7HHVSkRudBZeutwBgxx/dIwoOFAEGKs/OJhAb
         CKWw==
X-Gm-Message-State: AC+VfDzxlbScwlESDzytk04fROLNidVwM/AU4jcMX4M3jz8HIAg/Zyri
        UklYFx2Vpi7vAmkncwUK38/S59HL3G8Ih6WElOPs1g==
X-Google-Smtp-Source: ACHHUZ5aH2RMztFPkbEUQ+8DV8XApPCnj/hmi785vFmCl/2/ORqwvFJ1p5OWLG3htnKfAJyWNUym++pcdvpf5MxNVIU=
X-Received: by 2002:a05:622a:8e:b0:3ef:1c85:5b5e with SMTP id
 o14-20020a05622a008e00b003ef1c855b5emr63805qtw.19.1682627537155; Thu, 27 Apr
 2023 13:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230427182906.3411695-1-kan.liang@linux.intel.com>
In-Reply-To: <20230427182906.3411695-1-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 27 Apr 2023 13:32:05 -0700
Message-ID: <CAP-5=fUGhOCdG27Cj4nzSytQbkT3uFhrhUfbB+e6a05t5jo67Q@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Add arch-specific TopdownL1 check for the
 default mode
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        eranian@google.com, ahmad.yasin@intel.com, ak@linux.intel.com,
        perry.taylor@intel.com, samantha.alt@intel.com,
        caleb.biggers@intel.com, weilin.wang@intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Apr 27, 2023 at 11:31=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The default of perf stat fails on several Intel platforms.
> Skylake:
>
> $ perf stat true
> Error:
> Access to performance monitoring and observability operations is limited.
> Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
> access to performance monitoring and observability operations for process=
es
> without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
> More information can be found at 'Perf events and tool security' document=
:
> https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
> perf_event_paranoid setting is 2:
>   -1: Allow use of (almost) all events by all users
>       Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
> > =3D 0: Disallow raw and ftrace function tracepoint access
> > =3D 1: Disallow CPU event access
> > =3D 2: Disallow kernel profiling
>
> ADL (hybrid):
>
> ./perf stat
> Segmentation fault (core dumped)
>
> The default of perf stat was switched to TopdownL1 Json metric since
> commit 94b1a603fca7("perf stat: Add TopdownL1 metric as a default if
> present"). But the patch only checks whether the TopdownL1 is present
> in the event list. It doesn't check whether the hardware has the
> capability to provide a clean output for the default mode.
>
> Add arch_has_topdown_metric() to check the hardware capability as well.
> Drop the TopdownL1 support in the defalut mode for pre-ICL and hybrid
> platforms. Users can still use -M TopdownL1 to access the TopdownL1
> on pre-ICL platforms.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>
> The patch tries to workaround the serious issues on pre-ICL and hybrid
> platforms with the default mode of perf stat. It could be a temporary
> fix for the upcoming 6.4. So we have more time to look for a proper fix
> for all metrics issues and output issues with 6.5.
>
> Thanks,
> Kan
>
>  tools/perf/arch/x86/util/topdown.c | 14 ++++++++++++++
>  tools/perf/builtin-stat.c          |  2 +-
>  tools/perf/util/stat-display.c     |  2 +-
>  tools/perf/util/topdown.c          |  6 ++++++
>  tools/perf/util/topdown.h          |  2 ++
>  5 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/uti=
l/topdown.c
> index 9ad5e5c7bd27..5d861e851619 100644
> --- a/tools/perf/arch/x86/util/topdown.c
> +++ b/tools/perf/arch/x86/util/topdown.c
> @@ -3,6 +3,7 @@
>  #include "util/evsel.h"
>  #include "util/pmu.h"
>  #include "util/topdown.h"
> +#include "util/metricgroup.h"
>  #include "topdown.h"
>  #include "evsel.h"
>
> @@ -48,3 +49,16 @@ bool arch_topdown_sample_read(struct evsel *leader)
>
>         return false;
>  }
> +
> +bool arch_has_topdown_metric(const char *name)
> +{
> +       /*
> +        * Disable the Topdown events in the default mode
> +        * for hybrid platforms and old platform which
> +        * doesn't support the Topdown metric feature.
> +        */
> +       if (!pmu_have_event("cpu", "slots"))
> +               return false;

The only platform crashing with this are hybrid ones, I think the test
should be:

if (perf_pmu__has_hybrid())
   return false;

> +
> +       return metricgroup__has_metric(name);
> +}
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index efda63f6bf32..0b865155656d 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1885,7 +1885,7 @@ static int add_default_attributes(void)
>                  * Add TopdownL1 metrics if they exist. To minimize
>                  * multiplexing, don't request threshold computation.
>                  */
> -               if (metricgroup__has_metric("TopdownL1") &&
> +               if (arch_has_topdown_metric("TopdownL1") &&
>                     metricgroup__parse_groups(evsel_list, "TopdownL1",
>                                             /*metric_no_group=3D*/false,
>                                             /*metric_no_merge=3D*/false,
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index e6035ecbeee8..73b2ff2ddf29 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -747,7 +747,7 @@ static void uniquify_event_name(struct evsel *counter=
)
>         int ret =3D 0;
>
>         if (counter->uniquified_name || counter->use_config_name ||
> -           !counter->pmu_name || !strncmp(counter->name, counter->pmu_na=
me,
> +           !counter->pmu_name || !strncmp(evsel__name(counter), counter-=
>pmu_name,

This fix is here:
https://lore.kernel.org/lkml/20230426070050.1315519-1-irogers@google.com/T/=
#mfce90d81aac130bbbf4743310b9ab918fc73d012

Thanks,
Ian

>                                            strlen(counter->pmu_name)))
>                 return;
>
> diff --git a/tools/perf/util/topdown.c b/tools/perf/util/topdown.c
> index 18fd5fed5d1a..f3a9ebc52f8b 100644
> --- a/tools/perf/util/topdown.c
> +++ b/tools/perf/util/topdown.c
> @@ -1,8 +1,14 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "topdown.h"
> +#include "metricgroup.h"
>  #include <linux/kernel.h>
>
>  __weak bool arch_topdown_sample_read(struct evsel *leader __maybe_unused=
)
>  {
>         return false;
>  }
> +
> +__weak bool arch_has_topdown_metric(const char *name)
> +{
> +       return metricgroup__has_metric(name);
> +}
> diff --git a/tools/perf/util/topdown.h b/tools/perf/util/topdown.h
> index 1996c5fedcd7..7e83c8b247f2 100644
> --- a/tools/perf/util/topdown.h
> +++ b/tools/perf/util/topdown.h
> @@ -8,4 +8,6 @@ struct evsel;
>
>  bool arch_topdown_sample_read(struct evsel *leader);
>
> +bool arch_has_topdown_metric(const char *name);
> +
>  #endif
> --
> 2.35.1
>
