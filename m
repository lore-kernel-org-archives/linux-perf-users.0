Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1FBEB64DA
	for <linux-perf-users@archiver.kernel.org>; Thu, 20 Jul 2023 17:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjGTRMm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 20 Jul 2023 13:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjGTRMi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 20 Jul 2023 13:12:38 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449EB1986
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Jul 2023 10:12:34 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40540a8a3bbso11991cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Jul 2023 10:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689873153; x=1690477953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgKroFQPLE09VW7HU3YORU1IlmMjxO1ihJQVJHL39LQ=;
        b=PmpgAEC9wBqpCZYdZxsWDBfnVbgW1YecjRUFlxot9ncNaQCJT9kX69lXdR5KpoXsZL
         Nm4/8R0WUIKhT2lSBo799JzJ/V1RQt18Dmu0oZYm4gUrhPCxa1SNl9+n9/xi4lsUKoI/
         FVzTb/wdwTTikh/OksLuaR1yisCLVHHjNJUKmShZz8ZmEee6CT2Bc+QlARjMgkDqqkTp
         RUSgn9b8/mSnCbwsOeoFhVf490OdtPWU/Nd3UBYKKeLalFAdRonXC3nKG/DYQYtUgcA5
         DSJ+H6nJgkfIGHRW/l+A6ot32nnJB3cAd4mGcgoHJmIf86iwrYBLEReHYzYh1E1u5wOm
         tGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689873153; x=1690477953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgKroFQPLE09VW7HU3YORU1IlmMjxO1ihJQVJHL39LQ=;
        b=PXjI2yyW2kZGecQL9JHPEMpGzoQ0CqR4jtJPy8I3gD3gQy8hxV06UiH6HQixo6G6V/
         a9DS4Rqc8Zkduw86VuraG6W26pgX/1Q0GeYutuLCDzlQeOUVIu/lBRuuz2UfCpJ+qPzR
         4wF9ej6G3e+0xUlCCLSrA3OuN92YfEg7zymo/z8KsrJWhl8zYgPr+TxG4wZG7sgRGrSP
         V71zJyjWySSrgiNXyNpabZbt2hBKScCw9GgTTi/zywG8wofhbdNbCcABNppwXBKGXz2/
         +Q8eXiutxwrVBZIRAEGEJxpFHflwgivHp4mxBPlHuAdAnoiO4RWtFGhMvzFkRJ4XJCgc
         G5qw==
X-Gm-Message-State: ABy/qLZOcpl3kxG92HLzavDsOHf0YTuTIi0gg7fEryau6Jjnaixei3YD
        5LBXT2puFZr7fMOUqE0rNsjvU0rHF4ojqqzCBpV9og==
X-Google-Smtp-Source: APBJJlEMHAQAkn3EOSoeN59vhib89c/M3lOEfHFqzpjCi8fuoQp1QCtrjNPaI3mqm7wzrdESJWupioX6p/5j0+OVcq0=
X-Received: by 2002:ac8:7f83:0:b0:403:b1d0:2f0a with SMTP id
 z3-20020ac87f83000000b00403b1d02f0amr320764qtj.28.1689873153170; Thu, 20 Jul
 2023 10:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230710122138.1450930-1-james.clark@arm.com> <20230710122138.1450930-2-james.clark@arm.com>
 <e111d9ac-c4f6-c541-313b-7a3a6acfb5d2@arm.com> <597f53e0-5a5b-75a1-4054-253630a941f2@arm.com>
In-Reply-To: <597f53e0-5a5b-75a1-4054-253630a941f2@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 20 Jul 2023 10:12:21 -0700
Message-ID: <CAP-5=fVpjJLBNCd4LJ7krX1tpqUT-S_DCRebXR1ioTCGFsF6Pw@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capability
To:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jul 11, 2023 at 7:12=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
>
>
> On 11/07/2023 13:01, Anshuman Khandual wrote:
> >
> >
> > On 7/10/23 17:51, James Clark wrote:
> >> This capability gives us the ability to open PERF_TYPE_HARDWARE and
> >> PERF_TYPE_HW_CACHE events on a specific PMU for free. All the
> >> implementation is contained in the Perf core and tool code so no chang=
e
> >> to the Arm PMU driver is needed.
> >>
> >> The following basic use case now results in Perf opening the event on
> >> all PMUs rather than picking only one in an unpredictable way:
> >>
> >>   $ perf stat -e cycles -- taskset --cpu-list 0,1 stress -c 2
> >>
> >>    Performance counter stats for 'taskset --cpu-list 0,1 stress -c 2':
> >>
> >>          963279620      armv8_cortex_a57/cycles/                (99.19=
%)
> >>          752745657      armv8_cortex_a53/cycles/                (94.80=
%)
> >>
> >> Fixes: 55bcf6ef314a ("perf: Extend PERF_TYPE_HARDWARE and PERF_TYPE_HW=
_CACHE")
> >> Suggested-by: Ian Rogers <irogers@google.com>
> >> Signed-off-by: James Clark <james.clark@arm.com>

Hi ARM Linux and ARM Linux PMU people,

Could this patch be picked up for Linux 6.5? I don't see it in the
tree and it seems a shame to have to wait for it. The other patches do
cleanup and so waiting for 6.6 seems okay.

Thanks,
Ian

> >> ---
> >>  drivers/perf/arm_pmu.c | 7 ++++++-
> >>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> >> index 277e29fbd504..d8844a9461a2 100644
> >> --- a/drivers/perf/arm_pmu.c
> >> +++ b/drivers/perf/arm_pmu.c
> >> @@ -875,8 +875,13 @@ struct arm_pmu *armpmu_alloc(void)
> >>               * configuration (e.g. big.LITTLE). This is not an uncore=
 PMU,
> >>               * and we have taken ctx sharing into account (e.g. with =
our
> >>               * pmu::filter callback and pmu::event_init group validat=
ion).
> >> +             *
> >> +             * PERF_PMU_CAP_EXTENDED_HW_TYPE is required to open the =
legacy
> >
> > s/legacy/generic ? These hardware events are still around.
>
> True, I thought I saw it mentioned that way somewhere, but I can
> probably just remove it altogether. PERF_TYPE_HARDWARE and
> PERF_TYPE_HW_CACHE is enough.
>
>
> >
> >> +             * PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE events on a
> >> +             * specific PMU.
> >>               */
> >> -            .capabilities   =3D PERF_PMU_CAP_HETEROGENEOUS_CPUS | PER=
F_PMU_CAP_EXTENDED_REGS,
> >> +            .capabilities   =3D PERF_PMU_CAP_HETEROGENEOUS_CPUS | PER=
F_PMU_CAP_EXTENDED_REGS |
> >> +                              PERF_PMU_CAP_EXTENDED_HW_TYPE,
> >>      };
> >>
> >>      pmu->attr_groups[ARMPMU_ATTR_GROUP_COMMON] =3D
