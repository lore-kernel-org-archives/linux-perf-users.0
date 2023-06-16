Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C218EB64D8
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Jun 2023 22:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjFPWJR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Jun 2023 18:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjFPWJQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Jun 2023 18:09:16 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C2AB5
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jun 2023 15:09:13 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3fddc620055so38481cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jun 2023 15:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686953353; x=1689545353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mj8CpQAE+1cLVAgDQiQwgKaiuYNs7JQDL4TMFX8aZ/8=;
        b=rK4GBjhRwveidGYPaRho+hkgRrt9MmV3pkMchET1QkpFWWw7uw7VH/fbo+z/4pZ9Eg
         XS+1axP/fIB0zbcJjzvZ152tb68rvGXEcurK237BcvXl0p5kgkNaxHTBeTeWaFKaCuRT
         SBUPWDmBQEZTfw8oOmdO9WKZjX/mcGUvz+THg6JCwnDCy5Szgm6A7rs52pHiEsr++8R0
         6Ss46oSZkJbmXzDx/el+52QPiZBtEHykm9otetJz30qTfXDKfFqoaOBh8e0ePI584l/W
         fgMQ/iXalDZI1dZnswJKCrM29dHOzhg2WHtk5qewPsp5hhZi8L7y090Y/Y0kn3oXYc/R
         /auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686953353; x=1689545353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mj8CpQAE+1cLVAgDQiQwgKaiuYNs7JQDL4TMFX8aZ/8=;
        b=EoAQgfpP4EcMGAX2bkXssXy/D4V2YYoPG6XnF7dK8itR6mOZgsvW858MTmSxYyZluc
         s6S49HEJ9fMdYAutYU8sYKFKMHGVYmdWrEnsAKsqzOnWeaQ/eudU3cqsuCAFViYEMmR6
         aLnUzgNQu2/AWF55f/bOFlBit26xobKuzLCbJDz1LgTpMO6fiYfpm69KCE3DvW4g2OBA
         PVqVHR6SVKlLKALLcgB8h9R2/3dxdgQ4de3AbUYm0XfQswSkaTWpSEzOQNNINZuXeHy8
         JKsxiBsQwjUPgHOSv8jmzlVApys0L2yTdaCjOEhylsqn534vYzF9WgG3LqEmAzV1IrEb
         ZNfg==
X-Gm-Message-State: AC+VfDxRF28u2wiFr/6r9mJRHkNC+6yoZcQ1pDIbmKIcYOWPOYAg1S1c
        /y7pp4pKpgtRbzVKVp6A+uxkIZjMvyt82kK2CmY6nw==
X-Google-Smtp-Source: ACHHUZ4U36CUqDBZjr9M+DzshunXSrJ+TSjGU/dLImIo5TD5etwLc0PZ3s4bgLd2svZNolcJEeU+lRqWjvgQy5F2F8Y=
X-Received: by 2002:ac8:5bc3:0:b0:3f8:5b2:aef2 with SMTP id
 b3-20020ac85bc3000000b003f805b2aef2mr678128qtb.26.1686953352735; Fri, 16 Jun
 2023 15:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fU+0VXckQiq3E8yqaySNZ+-DDZahEd1OY0uKPWnfFsafg@mail.gmail.com>
 <e7f0930a-a9fc-d768-a472-bd9af6fafdf5@linux.ibm.com> <CAP-5=fWjqJH0h607cVb1T7pRxDeq4cZBz5TECMajpnkvVNWHEQ@mail.gmail.com>
 <a19a30b0-8f16-5871-6856-503eadf56e3c@linux.ibm.com> <ZIshkbmQR7oOFiHu@kernel.org>
 <CAP-5=fVYy6jMd9Nw7iqqsm_G-qW__Lo8kFeCocJ0W2no4XTbpg@mail.gmail.com>
 <ZIxza13x+AwApbQb@kernel.org> <ZIx1Y9mWc13huQt2@kernel.org>
 <CAP-5=fVpU6Bm1REcANEu2qsE5eQH2VOx2uz+X0VSoH76r_d7uQ@mail.gmail.com>
 <ZIyTlR+jJ27YKPVx@kernel.org> <ZIzYgImv61OGK1wA@kernel.org>
In-Reply-To: <ZIzYgImv61OGK1wA@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 16 Jun 2023 15:09:00 -0700
Message-ID: <CAP-5=fVLh8sv=SOBTMTv7D_Va9VCiVqa0pdSA0YR83dJxGSktw@mail.gmail.com>
Subject: Re: Hybrid PMU issues on aarch64. was: Re: perf test failures in
 linux-next on s390
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 16, 2023 at 2:47=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Jun 16, 2023 at 01:53:41PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > > presumably with the #ifdef you just get 1 PMU - shame. I think rather
> > > than do an #ifdef we can do something like call is_event_supported:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/t=
ools/perf/util/print-events.c?h=3Dperf-tools-next#n232
> > > so:
> > > bool perf_pmus__supports_extended_type(void)
> > >   struct perf_pmu *pmu =3D NULL;
> > >   if (perf_pmus__num_core_pmus() <=3D 1)
> > >      return false;
> > >   while((pmu =3D perf_pmus__scan_core(pmu) !=3D NULL) {
> > >     return is_event_supported(PERF_TYPE_HARDWARE,
> > > PERF_COUNT_HW_CPU_CYCLES | ((__u64)pmu->type << PERF_PMU_TYPE_SHIFT);
> > >  }
> > > return false;
> > > }
> > > We probably don't want to do this for each call of
> > > perf_pmus__supports_extended_type so you could use a static and
> > > pthread_once, etc.
> > >
> > > This would mean if this regression is introduced elsewhere than ARM i=
t
> > > will self heal. It will also mean that when ARM support extended type=
s
> > > in the kernel, they will get the normal heterogeneous behavior.
> >
> > That looks better, I'll try it when I get back to my office.
>
> End result, Ack?
>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index a2032c1b7644..d891d72c824e 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -4,6 +4,7 @@
>  #include <subcmd/pager.h>
>  #include <sys/types.h>
>  #include <dirent.h>
> +#include <pthread.h>
>  #include <string.h>
>  #include <unistd.h>
>  #include "debug.h"
> @@ -492,9 +493,35 @@ int perf_pmus__num_core_pmus(void)
>         return count;
>  }
>
> +static bool __perf_pmus__supports_extended_type(void)
> +{
> +       struct perf_pmu *pmu =3D NULL;
> +
> +       if (perf_pmus__num_core_pmus() <=3D 1)
> +               return false;
> +
> +       while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL) {
> +               if (!is_event_supported(PERF_TYPE_HARDWARE, PERF_COUNT_HW=
_CPU_CYCLES | ((__u64)pmu->type << PERF_PMU_TYPE_SHIFT)))
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
> +static bool perf_pmus__do_support_extended_type;
> +
> +static void perf_pmus__init_supports_extended_type(void)
> +{
> +       perf_pmus__do_support_extended_type =3D __perf_pmus__supports_ext=
ended_type();
> +}
> +
>  bool perf_pmus__supports_extended_type(void)
>  {
> -       return perf_pmus__num_core_pmus() > 1;
> +       static pthread_once_t extended_type_once =3D PTHREAD_ONCE_INIT;
> +
> +       pthread_once(&extended_type_once, perf_pmus__init_supports_extend=
ed_type);
> +
> +       return perf_pmus__do_support_extended_type;
>  }
>
>  struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
> diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-event=
s.c
> index 7a5f87392720..a7566edc86a3 100644
> --- a/tools/perf/util/print-events.c
> +++ b/tools/perf/util/print-events.c
> @@ -229,7 +229,7 @@ void print_sdt_events(const struct print_callbacks *p=
rint_cb, void *print_state)
>         strlist__delete(sdtlist);
>  }
>
> -static bool is_event_supported(u8 type, u64 config)
> +bool is_event_supported(u8 type, u64 config)
>  {
>         bool ret =3D true;
>         int open_return;
> diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-event=
s.h
> index e75a3d7e3fe3..d7fab411e75c 100644
> --- a/tools/perf/util/print-events.h
> +++ b/tools/perf/util/print-events.h
> @@ -3,6 +3,7 @@
>  #define __PERF_PRINT_EVENTS_H
>
>  #include <linux/perf_event.h>
> +#include <linux/types.h>
>  #include <stdbool.h>
>
>  struct event_symbol;
> @@ -36,5 +37,6 @@ void print_symbol_events(const struct print_callbacks *=
print_cb, void *print_sta
>                          unsigned int max);
>  void print_tool_events(const struct print_callbacks *print_cb, void *pri=
nt_state);
>  void print_tracepoint_events(const struct print_callbacks *print_cb, voi=
d *print_state);
> +bool is_event_supported(u8 type, u64 config);
>
>  #endif /* __PERF_PRINT_EVENTS_H */
