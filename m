Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAC0EB64D9
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 Jul 2023 05:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGLFkY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 12 Jul 2023 01:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjGLFkW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 Jul 2023 01:40:22 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125441716
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Jul 2023 22:40:21 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-403b622101bso122401cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Jul 2023 22:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689140420; x=1691732420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiAkkP1EdbnMW11GKMsPgjH7qLZViInmNnoTvxJOghg=;
        b=i0+S727nPyAqpSy2g6Lc7SX+6EIh8piKjI3Id6+GYQ7Xb/5lH//pDrU/0Sy5dDOvW2
         oCorTl5fFVx5R2YGMDj86YV49WK/sAzlPmOEs0naimiLMYeeNPFzvaC63er5Pr2OkxrE
         PcUR1Ap/VKoRYyEFMmbXq8caFewX+yk1U9OEquF/BbsWLgGeHresVwSVgwxYA8TQIwmd
         Hn75G5psHbLVkITBTYZ2KKPpPJ7HI4/wsLXkeGR6JQKNBovQcsDofFxsMlwxHNaWmSNH
         VoZAc+2gCWrG5meQnjpdbLge5JcCXbqV6JilpXMIpVSJhMY9lspaJ7x8awyOEJAsPGX8
         szJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689140420; x=1691732420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiAkkP1EdbnMW11GKMsPgjH7qLZViInmNnoTvxJOghg=;
        b=IxZHkrpD8R0nuO5V/RcT/px3G6FMB5qmvo/6I6J4F62cTcXJuOOK7X1c8lUDIkD3uV
         q77VYphLPTxdDySyZPtpHgzA54yv4cmwAnANbmNT2tTCo2f4tir2aI/zITLAsWE61LdV
         m2e92eTps3osQllnmtongWIb3KzTNz4hIJ0/fJJKYGDiRWPQMFUou4DvrWSwnA2M3Hbx
         5/43aW6EDuKm44yAehGhYN0+G31PtBQ7W1RWPUB5AEo9OdPSXLKC9xAmCA23Rs1ObX+R
         0RAfqGsIFFJn6zOAQ59DJy/5Zgj1l2TyTEK8bTyTu7otUTq67MsUYmWQYTn8ffkn2rPu
         +BxQ==
X-Gm-Message-State: ABy/qLaYlOfR5O60ELs1KgTFlnGNtqw3LK3tjBtvpgC+DKK2TfBZvzJk
        byB4yRX6AHtcsMWOeoQWS8aiGGCzPwbUyt8IzrlFokiRQKCEMavnnG7c+g==
X-Google-Smtp-Source: APBJJlHwfRGQqV5h0r1U/quRuRwac2oyC+UIwxJkjMht+s97QQICb0a8zOQgj6IisHdkK+loe/01x414bqugznaKuDk=
X-Received: by 2002:a05:622a:588:b0:3f9:a770:7279 with SMTP id
 c8-20020a05622a058800b003f9a7707279mr80910qtb.9.1689140419969; Tue, 11 Jul
 2023 22:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
 <20230628102949.2598096-3-john.g.garry@oracle.com> <CAP-5=fWB9H0KWrXYouepUiAbnfH3u29XuRVN6KXVw3CNbD4xrA@mail.gmail.com>
 <bb828dd4-3c22-7383-008e-ab4f860ed686@oracle.com>
In-Reply-To: <bb828dd4-3c22-7383-008e-ab4f860ed686@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 11 Jul 2023 22:40:08 -0700
Message-ID: <CAP-5=fWZj-vzmF4=iNEw=8DdJetB4HWtHYSzCCvqms9iKdaZ6w@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] perf metrics: Don't iter sys metrics if we
 already found a CPU match
To:     John Garry <john.g.garry@oracle.com>
Cc:     acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        zhangshaokun@hisilicon.com, qiangqing.zhang@nxp.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jul 3, 2023 at 6:09=E2=80=AFAM John Garry <john.g.garry@oracle.com>=
 wrote:
>
> On 30/06/2023 18:41, Ian Rogers wrote:
> > On Wed, Jun 28, 2023 at 3:30=E2=80=AFAM John Garry<john.g.garry@oracle.=
com>  wrote:
> >> In metricgroup__add_metric() we still iter the sys metrics if we alrea=
dy
> >> found a match from the CPU table, which is pretty pointless, so don't
> >> bother.
> >>
> >> Signed-off-by: John Garry<john.g.garry@oracle.com>
> >> ---
> >>   tools/perf/util/metricgroup.c | 7 +++++++
> >>   1 file changed, 7 insertions(+)
> >>
> >> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgro=
up.c
> >> index 4389ccd29fe7..8d2ac2513530 100644
> >> --- a/tools/perf/util/metricgroup.c
> >> +++ b/tools/perf/util/metricgroup.c
> >> @@ -1261,6 +1261,12 @@ static int metricgroup__add_metric(const char *=
pmu, const char *metric_name, con
> >>
> >>                  has_match =3D data.has_match;
> >>          }
>
> Hi Ian,
>
> >> +
> >> +       if (has_match) {
> >> +               ret =3D 0;
> >> +               goto out;
> >> +       }
> >> +
> > I think this can just be:
> >
> > if (!has_match)
>
> But ret has no initial value
>
> >
> > However, I'm not sure I agree with the intent of the change. We may
> > have a metric like IPC and want it to apply to all types of CPU, GPU,
> > etc. If we short-cut here then that won't be possible.
>
> A few points to make on this:
> - Currently we don't have any same-named metrics like this, so not much
> use in supporting it in the code (yet).

We have same named metrics for heterogeneous CPU PMUs:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json?h=3Dperf-tools=
-next#n304
cpu_atom
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json?h=3Dperf-tools=
-next#n1125
cpu_core

> - Even if we had some same-named metrics, I am not sure if it even works
> properly. Do we have any uncore PMU metrics which have same name as CPU
> metrics?

So I was thinking IPC was a generic concept that would apply to a
co-processor on a network card, a GPU, etc.

> - Further to the previous point, do we really want same-named metrics
> for different PMUs in the future? I think event / metric names need to
> be chosen carefully to avoid clash for other PMUs or keywords. For your
> example, if I did ask for IPC metric, I'd like to be able to just know
> I'm getting IPC metric for CPUs or some other PMUs, but not both.

At the moment if you request an event without a PMU, say instructions
retired, we will attempt to open the event on every PMU - legacy
events (PERF_TYPE_HARDWARE, PERF_TYPE_HW_CACHE) only try the core
PMUs. It would seem consistent if metrics tried to open on every PMU
like most events.

Thanks,
Ian

> Thanks,
> John
>
> >
