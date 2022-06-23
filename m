Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C909C43334
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Jun 2022 11:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiFWL5R (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Jun 2022 07:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbiFWL5Q (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Jun 2022 07:57:16 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD5E4D270
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Jun 2022 04:57:15 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k22so21168707wrd.6
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Jun 2022 04:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X3ySZJDusRzirICooVQnq3Muwhk4u9wKcv/U8cr1I1Q=;
        b=MIaxpF2TZZA3FpFGmkf7iWuzW/e+FJLhNne/KTmdFaLIXQFCFGKtBdrlCC2JnGJeB8
         0eRcChSfkE/D9VXARFkCEMpq3bW6wM2ZVEMVM2pjKROzObn40jfAYNRkGRTReEc2RrbP
         bB9h4oqrZ55jkqHx/ksW0+tnLNBjXhbX3oZhs59XMwaAt94gZCEus5nDCyFpnctoH0Bn
         xk6uu0E0azOzs7HARrYISg21uigZaXOGDf9j72TOaV5uMiGL0EcbWArKQD/eCpZluQZA
         EdDOh4wm91p+05qK9w5D91ghd5WVEaoHDTqRKucObYUq/pKAr83QkofwKpCHkvEfpqYM
         rcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X3ySZJDusRzirICooVQnq3Muwhk4u9wKcv/U8cr1I1Q=;
        b=iQlPo1KXVysT2LjIUSohFEOyTuahZ0qqZ/qZoZF0a64Izi9JDJDCZmw+EUhGPKYDE8
         SJlYXMcLDQEXvGEQk2jxnWVas98HVB3okl04T9HXOyP2ep/CaCnO7yt/0JQWkzzyru7P
         9LLbe1dPdzyZIdoJCPGEGPnFjfanvGatf6f+/g2GMkRCln/QjHJNG/OwSPhGjmCxqPVQ
         B0kBgH59pHCWUrYzhSRwUSq2Ejp+1xem3ecUoLDp88tuzCiAyAw+L0byvOJ9kExKn3O/
         65At1/bArw4inRZCA4TrIeo3oRy+5xSlmjokqKF4nVQmR2DUEi8kXrubI+OZzDTbxlsu
         RBcA==
X-Gm-Message-State: AJIora8ktbHejyCl0eY/vVemVt89haOmR8c24pyBM8U5TYV558jmXtf1
        fgdaLGFDKcsYCWAljYyyUzPbU+AtbRtqiNmoQhdchg==
X-Google-Smtp-Source: AGRyM1sVD9I3aAnpb/HGS8kvIzbhOxa+Mad9aCTXn7yixnbJgFwA0Irpw3jVe6TCur5lEYr108BlYSbGJ0TCikxRqkY=
X-Received: by 2002:a5d:5a1a:0:b0:21b:883a:28a1 with SMTP id
 bq26-20020a5d5a1a000000b0021b883a28a1mr8112947wrb.40.1655985434225; Thu, 23
 Jun 2022 04:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220618000907.433350-1-irogers@google.com> <YrLA5NMBv1uIx7UD@krava>
 <YrLGkqDMVidTtFMG@krava>
In-Reply-To: <YrLGkqDMVidTtFMG@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 23 Jun 2022 04:57:01 -0700
Message-ID: <CAP-5=fVQ86hY_1z7rAXZTw=DRyrX3P28G6xx+WQT18skJYvwXQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Rewrite jevents program in python
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 22, 2022 at 12:36 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Wed, Jun 22, 2022 at 09:12:40AM +0200, Jiri Olsa wrote:
> > On Fri, Jun 17, 2022 at 05:09:03PM -0700, Ian Rogers wrote:
> > > New architectures bring new complexity, such as Intel's hybrid
> > > models. jevents provides an alternative to specifying events in the
> > > kernel and exposing them through sysfs, however, it is difficult to
> > > work with. For example, an error in the json input would yield an
> > > error message but no json file or location. It is also a challenge to
> > > update jsmn.c given its forked nature.
> > >
> > > The changes here switch from jevents.c to a rewrite in python called
> > > jevents.py. This means there is a build time dependency on python, but
> > > such a dependency already exists for asciidoc (used to generate perf's
> > > man pages). If the build detects that python isn't present or is older
> > > than version 3.6 (released Dec. 2016) then an empty file is
> > > substituted for the generated one.
> > >
> > > A challenge with this code is in avoiding regressions. For this reason
> > > the jevents.py produces identical output to jevents.c, validated with a
> > > test script and build target.
> > >
> > > v6. Fixes an annotation and use of removesuffix that aren't present in
> > >     Python 3.6. Linter issues are also fixed.The code was tested on
> > >     Python 3.6 and 3.8 with docker.
> >
> > hi,
> > I'm getting test failures with this:
> >
> >  10: PMU events                                                      :
> >  10.1: PMU event table sanity                                        : FAILED!
> >  10.2: PMU event map aliases                                         : FAILED!
> >  10.3: Parsing of PMU event table metrics                            : Ok
> >  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
> >
> > I can see that pass without the patchset, verbose run shows:
> >
> >       [jolsa@krava perf]$ sudo ./perf test -vv 'PMU event map aliases'
> >        10: PMU events                                                      :
> >        10.2: PMU event map aliases                                         :
> >       --- start ---
> >       test child forked, pid 272763
> >       Using CPUID GenuineIntel-6-8C-1
> >       intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
> >       could not find test events map
> >       testing core PMU cpu aliases: failed
> >       test child finished with -1
> >       ---- end ----
> >       PMU events subtest 2: FAILED!
> >       [jolsa@krava perf]$ sudo ./perf test -vv 'PMU event table sanity'
> >        10: PMU events                                                      :
> >        10.1: PMU event table sanity                                        :
> >       --- start ---
> >       test child forked, pid 272771
> >       could not find test events map
> >       test child finished with -1
> >       ---- end ----
> >       PMU events subtest 1: FAILED!
>
> ah, ok I did not notice:
>
> Makefile.config:909: Python interpreter too old (older than 3.6) disabling jevent generation
>
> I installed python3-devel and it's ok
>
> should we make above tests SKIP in case there's empty pmu-events.c ?

Hmm.. I didn't know the empty case was failing, that seems
sub-optimal. It'd also be nice to report here a skip for not being
compiled in rather than a pass. Let me take a look later.

Thanks,
Ian

> thanks,
> jirka
