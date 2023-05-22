Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40770C7EE23
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 May 2023 05:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjEVFaz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 May 2023 01:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEVFay (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 May 2023 01:30:54 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA0AA8
        for <linux-perf-users@vger.kernel.org>; Sun, 21 May 2023 22:30:53 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-33828a86ee2so255475ab.0
        for <linux-perf-users@vger.kernel.org>; Sun, 21 May 2023 22:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684733452; x=1687325452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcdvohU0f2w+fIMIX4DbPiChuLXgbqb9UEE/pNtU84k=;
        b=6N8KkioYqaNwktef6Iq8E5OZXCmKbj1txma/kt5JIFjoTBgLmhUyqho/o6d1DY9PMi
         /Gqat1eCV+T88xSdtMX9+zK4vQFfYdY18H8uyte14d9SVQ5fVhfwve/W05l3TbR3Mg7S
         hUV/HYC0LWDD0V/jwvyDYk2uxpUqU5NoduKYg/PZISq+U1849p0A+CLMKFg95+7H7leb
         XeDeQIkDrqAxJVQ0aOZAiaq/OSNCwdInkHBw/gi4LoI/QGpR0PUtTGUbgMiXwQ0p/2b9
         hJxe3oaVOzLYLUnQ9wdQzeWEksLNEnvks+TGSvXN1/DJyRTDm9rI3zOVGnwxiH+o/dnX
         z5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684733452; x=1687325452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcdvohU0f2w+fIMIX4DbPiChuLXgbqb9UEE/pNtU84k=;
        b=c6EE7U0LUIXnZBNtu/PUBsD++2zsQFf7RTvkUY+EBBmpx/JP3PFapehDM6DAssu2kD
         SNeAIH8gC9V9wA4ECHQMay9wpDikVexyYyzHX6ltwm1gFlOy9xQJ6ccQm0j+SYgX8uNC
         E/qfz30XOe8jzFyppO8OwfwGTz+XnvkeVTZh30lfLvuCAI2wGQGF4XSO5IPiUC2ee6yU
         hVZ4qXO76AsPpAgNVRUcFPZcZgLMtEhQoaDTrMEbn6Y71Hi5I7cXev3M0awIom0QB2zB
         xQpCdGaSyohIyfi35IhaoCKyF2F9YTYcz1JfwVIXamefk5Bpxv4PLe+/n10cJp/GvhUZ
         IQ4w==
X-Gm-Message-State: AC+VfDxgxHaxmEhWER4DHs7gbcVSoECMHl+2tFPkAYi55gN06VS35/pS
        PsFvzR7+FQhmkA3Y9IJ2v6uh/CPyREELJmjNxuOM7g==
X-Google-Smtp-Source: ACHHUZ5aHxjgOROb+esLKY1PeiXeNdAKL5G4yO/Acvbmkrtd0rm5Ip7bPbLL4suDd4QhlbFlqRnwRoZbENEIyp37PCo=
X-Received: by 2002:a05:6e02:1a0a:b0:32a:f2a9:d1b7 with SMTP id
 s10-20020a056e021a0a00b0032af2a9d1b7mr783043ild.10.1684733452291; Sun, 21 May
 2023 22:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230517145803.559429-1-irogers@google.com> <20230517145803.559429-21-irogers@google.com>
 <efd8389a-aef1-96de-273a-ebac565cb852@linux.intel.com>
In-Reply-To: <efd8389a-aef1-96de-273a-ebac565cb852@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 21 May 2023 22:30:40 -0700
Message-ID: <CAP-5=fV5zgPs_VayVhMq-pu7C1A_QeFvbq=jtC04GBS9T4yV2w@mail.gmail.com>
Subject: Re: [PATCH v1 20/23] perf pmus: Split pmus list into core and uncore
To:     "Liang, Kan" <kan.liang@linux.intel.com>
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
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, May 21, 2023 at 1:07=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
> On 2023-05-17 10:58 a.m., Ian Rogers wrote:
> > Split the pmus list into core and uncore. This will later allow for
> > the core and uncore pmus to be populated separately.
>
> I think the "uncore pmus" here means the other non-core PMUs, right? If
> so, I think the "uncore pmus" is misleading, since we have a dedicated
> uncore driver/PMU. Maybe we can use "other pmus" instead.
>
> Thanks,
> Kan

I'm okay with other PMUs. I'll change it in v2.

Thanks,
Ian

> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/pmus.c | 52 ++++++++++++++++++++++++++++++------------
> >  1 file changed, 38 insertions(+), 14 deletions(-)
> >
> > diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > index 2fb28e583366..dd029a810147 100644
> > --- a/tools/perf/util/pmus.c
> > +++ b/tools/perf/util/pmus.c
> > @@ -12,13 +12,19 @@
> >  #include "pmu.h"
> >  #include "print-events.h"
> >
> > -static LIST_HEAD(pmus);
> > +static LIST_HEAD(core_pmus);
> > +static LIST_HEAD(uncore_pmus);
> >
> >  void perf_pmus__destroy(void)
> >  {
> >       struct perf_pmu *pmu, *tmp;
> >
> > -     list_for_each_entry_safe(pmu, tmp, &pmus, list) {
> > +     list_for_each_entry_safe(pmu, tmp, &core_pmus, list) {
> > +             list_del(&pmu->list);
> > +
> > +             perf_pmu__delete(pmu);
> > +     }
> > +     list_for_each_entry_safe(pmu, tmp, &uncore_pmus, list) {
> >               list_del(&pmu->list);
> >
> >               perf_pmu__delete(pmu);
> > @@ -29,7 +35,12 @@ static struct perf_pmu *pmu_find(const char *name)
> >  {
> >       struct perf_pmu *pmu;
> >
> > -     list_for_each_entry(pmu, &pmus, list) {
> > +     list_for_each_entry(pmu, &core_pmus, list) {
> > +             if (!strcmp(pmu->name, name) ||
> > +                 (pmu->alias_name && !strcmp(pmu->alias_name, name)))
> > +                     return pmu;
> > +     }
> > +     list_for_each_entry(pmu, &uncore_pmus, list) {
> >               if (!strcmp(pmu->name, name) ||
> >                   (pmu->alias_name && !strcmp(pmu->alias_name, name)))
> >                       return pmu;
> > @@ -53,7 +64,7 @@ struct perf_pmu *perf_pmus__find(const char *name)
> >               return pmu;
> >
> >       dirfd =3D perf_pmu__event_source_devices_fd();
> > -     pmu =3D perf_pmu__lookup(&pmus, dirfd, name);
> > +     pmu =3D perf_pmu__lookup(is_pmu_core(name) ? &core_pmus : &uncore=
_pmus, dirfd, name);
> >       close(dirfd);
> >
> >       return pmu;
> > @@ -72,7 +83,7 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, co=
nst char *name)
> >       if (pmu)
> >               return pmu;
> >
> > -     return perf_pmu__lookup(&pmus, dirfd, name);
> > +     return perf_pmu__lookup(is_pmu_core(name) ? &core_pmus : &uncore_=
pmus, dirfd, name);
> >  }
> >
> >  /* Add all pmus in sysfs to pmu list: */
> > @@ -93,7 +104,7 @@ static void pmu_read_sysfs(void)
> >       while ((dent =3D readdir(dir))) {
> >               if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, "=
.."))
> >                       continue;
> > -             /* add to static LIST_HEAD(pmus): */
> > +             /* add to static LIST_HEAD(core_pmus) or LIST_HEAD(uncore=
_pmus): */
> >               perf_pmu__find2(fd, dent->d_name);
> >       }
> >
> > @@ -104,24 +115,37 @@ struct perf_pmu *perf_pmus__find_by_type(unsigned=
 int type)
> >  {
> >       struct perf_pmu *pmu;
> >
> > -     list_for_each_entry(pmu, &pmus, list)
> > +     list_for_each_entry(pmu, &core_pmus, list) {
> >               if (pmu->type =3D=3D type)
> >                       return pmu;
> > -
> > +     }
> > +     list_for_each_entry(pmu, &uncore_pmus, list) {
> > +             if (pmu->type =3D=3D type)
> > +                     return pmu;
> > +     }
> >       return NULL;
> >  }
> >
> > +/*
> > + * pmu iterator: If pmu is NULL, we start at the begin, otherwise retu=
rn the
> > + * next pmu. Returns NULL on end.
> > + */
> >  struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu)
> >  {
> > -     /*
> > -      * pmu iterator: If pmu is NULL, we start at the begin,
> > -      * otherwise return the next pmu. Returns NULL on end.
> > -      */
> > +     bool use_core_pmus =3D !pmu || pmu->is_core;
> > +
> >       if (!pmu) {
> >               pmu_read_sysfs();
> > -             pmu =3D list_prepare_entry(pmu, &pmus, list);
> > +             pmu =3D list_prepare_entry(pmu, &core_pmus, list);
> > +     }
> > +     if (use_core_pmus) {
> > +             list_for_each_entry_continue(pmu, &core_pmus, list)
> > +                     return pmu;
> > +
> > +             pmu =3D NULL;
> > +             pmu =3D list_prepare_entry(pmu, &uncore_pmus, list);
> >       }
> > -     list_for_each_entry_continue(pmu, &pmus, list)
> > +     list_for_each_entry_continue(pmu, &uncore_pmus, list)
> >               return pmu;
> >       return NULL;
> >  }
