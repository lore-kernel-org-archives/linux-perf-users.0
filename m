Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4859CC7EE2C
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Aug 2023 16:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378726AbjHRQxN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 18 Aug 2023 12:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378891AbjHRQxK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 18 Aug 2023 12:53:10 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635FB2D64
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Aug 2023 09:53:08 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-4036bd4fff1so7981cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Aug 2023 09:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692377587; x=1692982387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOgfV8O4d74IyTRhaN2kBm4tewwlywsS0T8VEyXL6Hc=;
        b=dUkcpCvkYRV46MWlSDmtEoWekeZh8rCwKw0Pv1h3exO8WF/FljdgTRXKY3Ef3bmHnT
         ySY3QSL1TmdNcV5YOErN+vW2nXfGU71t3zOz76mQkFGS3v89fDi/bETjTvYw1M4nQ+Pn
         HKKtPXIJFJXCnrn8vZPPmyP1eQfwrSnSMS+5Ohj2RGXVke9ICkcZzCRrd03fbnTy/Ef3
         HoDdQglac4ghjRbd15rEra+h8LeyFWbS0D5ozNmcvj9E64BwB2CW/49wSj8b3mIiWwpx
         7EHpItAnI4eUn1F/zMGPhG7jTz8sD+1nyH3t+yZbrExRM41T32Ic7ofAqXMK9yuJhA5E
         Gdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692377587; x=1692982387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOgfV8O4d74IyTRhaN2kBm4tewwlywsS0T8VEyXL6Hc=;
        b=Pimdh6c9jHJ2hGpVDT3bU62/++XAPNrCGWYaa2g2I6fHVs+mlavqCPvifhHvoKczvs
         ns/7S9+dCxMA6sxRbMLA2fp3rKV/yzaQk7XCC6Ir3NaNR8Ql03+3spMbRx1ZzPnl8E/x
         EPg+A/pqPLoU3kDLx6NTFtOJJTq37FT6x51Do23Mb8PcEphFDou4zBohIdAM9KqGHVEf
         5gL1AZOqqmIiS3vkZl6Jt/AWdDM7WQ1AkWlGg4LSB7BUMZbxGXJcOYK4BTJgfskB834W
         4/M8A8EjgqXZjsGfFfj+B96hIFCMZ3fq/ya2KSVbdKzAq9QY1XzwqHtAGgUusb8GIBVh
         0zFw==
X-Gm-Message-State: AOJu0YwaHSU5xTZodUrePjpDKZ+yr5fnErzOqA1eowMmpBVyFzOYlBES
        E/xv3JK9S+N4C3/guCAGFgPwV5JfrXte31pk741PHA==
X-Google-Smtp-Source: AGHT+IEvsScuGghYPQzyO5SFtdeRAoKBin1hRnfMngpJ2XIXEPWs6y8F7LfcuToWFL9qRLXzkIp+nzH4pBRI7NXGq0o=
X-Received: by 2002:a05:622a:1b8d:b0:3de:1aaa:42f5 with SMTP id
 bp13-20020a05622a1b8d00b003de1aaa42f5mr172788qtb.15.1692377587402; Fri, 18
 Aug 2023 09:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230815130722.1223744-1-liwei391@huawei.com> <CAP-5=fX2v=vV8eUX3x2i+vcYQQ=W9_tswh4VXy4nP9R3MPh=2Q@mail.gmail.com>
 <dcf0a583-2876-3305-709e-ffe820e2f2df@huawei.com>
In-Reply-To: <dcf0a583-2876-3305-709e-ffe820e2f2df@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 18 Aug 2023 09:52:55 -0700
Message-ID: <CAP-5=fV1JkLNu7OwH7vkqw=qGVZJJg0+K5+vmm6gU4zEknK3Sg@mail.gmail.com>
Subject: Re: [PATCH] perf header: Fix missing PMU caps recording in write_pmu_caps
To:     "liwei (GF)" <liwei391@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-perf-users@vger.kernel.org, huawei.libin@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 18, 2023 at 2:14=E2=80=AFAM liwei (GF) <liwei391@huawei.com> wr=
ote:
>
> Hi Ian:
>
> On 2023/8/17 11:31, Ian Rogers wrote:
> (SNIP)
> >>
> >> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> >> index 52fbf526fe74..7d2bd1fb8ef2 100644
> >> --- a/tools/perf/util/header.c
> >> +++ b/tools/perf/util/header.c
> >> @@ -1618,22 +1618,10 @@ static int write_pmu_caps(struct feat_fd *ff,
> >>         if (!nr_pmu)
> >>                 return 0;
> >>
> >> -       /*
> >> -        * Write hybrid pmu caps first to maintain compatibility with
> >> -        * older perf tool.
> >> -        */
> >> -       if (perf_pmus__num_core_pmus() > 1) {
> >> -               pmu =3D NULL;
> >> -               while ((pmu =3D perf_pmus__scan_core(pmu))) {
> >> -                       ret =3D __write_pmu_caps(ff, pmu, true);
> >> -                       if (ret < 0)
> >> -                               return ret;
> >> -               }
> >> -       }
> >> -
> >>         pmu =3D NULL;
> >>         while ((pmu =3D perf_pmus__scan(pmu))) {
> >> -               if (pmu->is_core || !pmu->nr_caps)
> >> +               if (!pmu->name || !strcmp(pmu->name, "cpu") ||
> >> +                   !pmu->nr_caps)
> >>                         continue;
> >>
> >>                 ret =3D __write_pmu_caps(ff, pmu, true);
> >
> > Sorry for the breakage. I think all of the branches are interfering
> > here, I think a simpler solution is:
> >
> > ```
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -1605,8 +1605,7 @@ static int write_pmu_caps(struct feat_fd *ff,
> >        int ret;
> >
> >        while ((pmu =3D perf_pmus__scan(pmu))) {
> > -               if (!pmu->name || !strcmp(pmu->name, "cpu") ||
> > -                   perf_pmu__caps_parse(pmu) <=3D 0)
> > +               if (perf_pmu__caps_parse(pmu) <=3D 0)
> >                        continue;
> >                nr_pmu++;
> >        }
> > @@ -1619,23 +1618,13 @@ static int write_pmu_caps(struct feat_fd *ff,
> >                return 0;
> >
> >        /*
> > -        * Write hybrid pmu caps first to maintain compatibility with
> > -        * older perf tool.
> > +        * Note older perf tools assume core PMUs come first, this is a=
 property
> > +        * of perf_pmus__scan.
> >         */
> > -       if (perf_pmus__num_core_pmus() > 1) {
> > -               pmu =3D NULL;
> > -               while ((pmu =3D perf_pmus__scan_core(pmu))) {
> > -                       ret =3D __write_pmu_caps(ff, pmu, true);
> > -                       if (ret < 0)
> > -                               return ret;
> > -               }
> > -       }
> > -
> >        pmu =3D NULL;
> >        while ((pmu =3D perf_pmus__scan(pmu))) {
> > -               if (pmu->is_core || !pmu->nr_caps)
> > +               if (perf_pmu__caps_parse(pmu) <=3D 0)
> >                        continue;
> > -
> >                ret =3D __write_pmu_caps(ff, pmu, true);
> >                if (ret < 0)
> >                        return ret;
> > ```
> >
> > Could you try it out?
> >
>
> I have tested your patch, it does make "perf script" work, but your modif=
ication
> records all the pmus with caps, including "cpu" on x86. This does not mat=
ch the
> spec in tools/perf/Documentation/perf.data-file-format.txt:
>
>         HEADER_PMU_CAPS =3D 31,
>
>         List of pmu capabilities (except cpu pmu which is already
>         covered by HEADER_CPU_PMU_CAPS). Note that hybrid cpu pmu
>         capabilities are also stored here.
>
> ---
> The header info of perf.data:
>
> # bpf_prog_info 5809: bpf_prog_6deef7357e7b4530 addr 0xffffffffc11a10e3 s=
ize 61
> # cpu pmu capabilities: branches=3D32, max_precise=3D3, pmu_name=3Dskylak=
e
> # cpu pmu capabilities: branches=3D32, max_precise=3D3, pmu_name=3Dskylak=
e
> # intel_pt pmu capabilities: topa_multiple_entries=3D1, psb_cyc=3D1, sing=
le_range_output=3D1, mtc_periods=3D249, ip_filtering=3D1, output_subsys=3D0=
, cr3_filtering=3D1, psb_periods=3D3f, cycle_thresholds=3D3fff, power_event=
_t>
> # missing features: TRACING_DATA BRANCH_STACK GROUP_DESC AUXTRACE STAT CL=
OCKID DIR_FORMAT COMPRESSED CLOCK_DATA HYBRID_TOPOLOGY
>
>
> Thanks,
> Wei

Thanks Wei! I'll update the patch I wrote and skip "cpu" with the
comment that it is already covered by HEADER_CPU_PMU_CAPS. It feels
that caps should really cover hybrid, but I was trying to refactor and
cleanup not change the perf.data format.

Thanks,
Ian
