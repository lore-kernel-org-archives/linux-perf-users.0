Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4E1EB64DC
	for <linux-perf-users@archiver.kernel.org>; Fri, 14 Jul 2023 15:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbjGNPzn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 14 Jul 2023 11:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbjGNPzm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 14 Jul 2023 11:55:42 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0F235B0
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Jul 2023 08:55:40 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-346099c6f43so148465ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Jul 2023 08:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689350139; x=1691942139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0wcA0R1kHucxzZH40EnE+hInwj14nD8x/U7vnwaiGg=;
        b=XDvUek7NjDvQof9k2daN7LDpxDlzC8HwPD3ksis8wNdmkpFVbYsziHmHfu1tVODpBO
         povGF+KfrxyKbfBnihTv6j1I4Dw8n1WKL0uCX+FCKewB+fCi/nVqSBMS34Bs7+ugmYhl
         yYwVBlHxekuJGkHSWIT0b8OC0u+8G5zwVQtM7tuHgB6tAgPi/+SoRvTigSfuzY43E5DF
         8fASQEHZ0Qmh4qwsBi1DZzkA1CmQkXjobvZm4iETWFpTM4fy3NA/vw4pXAbAMd7IdreJ
         2f0nQoPJUZpAmQzAekygswJj/LH0FjPPiH8Ao0OuUADKEp4/BiokNO+QnkCWke008vDm
         71Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689350139; x=1691942139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0wcA0R1kHucxzZH40EnE+hInwj14nD8x/U7vnwaiGg=;
        b=RneAQVI6gUwK7jHoHzuPmcNeKQJlaATKu77tWt6UKfoELfJtCjSPJB8hrNTcQ8Xnxa
         NKfae499f/Dgqv33l1dL6nDjkO/nX9M1UnjGOpJv6Qakz0stNf1X/yOH9SLJ8tMuVCtz
         ZyJcF+ouEwt+4+Y/VOQJQkw/Y+6uMiA5AVYMDNwGmsd+B4+Ywt3SSaK0r77psZS5e+hC
         1vfHnJRomd8zZuHakpnuBN+KxaF+TnMyilKhuNyyKe84LCLAFD4sl6bjbCj9gaDnOdM0
         2WR9RSngaKGL2VvEw+9EU5bSvlEW12hz/K+ZLegWItNkxkXlZHKQYlRxTem/3uxQi451
         hbGw==
X-Gm-Message-State: ABy/qLZpEegLPiJoofx2Bg7eT1gFhuUgBEDwlfYwvvTSWMmt7gNx34ai
        sSA1/9Zd0eEQzA/YUjOVel6/RfrlAAHsNZ0k5ZaNxA==
X-Google-Smtp-Source: APBJJlGzeSynixfQMtz3tHpC9QZlS/cqh8YwKR1/uOZPUfaz6/4k0E47uFuxGtNhq2wt06mxaZ+Uj03LIcFwCaA+r3E=
X-Received: by 2002:a05:6e02:1d0a:b0:335:6626:9f38 with SMTP id
 i10-20020a056e021d0a00b0033566269f38mr914173ila.0.1689350139434; Fri, 14 Jul
 2023 08:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
 <20230628102949.2598096-5-john.g.garry@oracle.com> <CAP-5=fXa24_LEiyni0Ncyfa5hKwC1GE6y-zi2u8M98M9SwHX+g@mail.gmail.com>
 <CAP-5=fUs=u3PKYP3mVDdzNB8+=GAHaEXG3SGfWJpMELYYqO_hA@mail.gmail.com>
 <d59b6e7c-cead-24d4-a9cb-6552b3154d84@oracle.com> <CAP-5=fUu6xgVDQT4tq=vmRLDMe3ddMLywP11uOLvKSu8Lc6BjQ@mail.gmail.com>
 <897dcf1d-6a04-33d3-9c4f-ea9d1706cdad@oracle.com> <CAP-5=fX+rz928LtFs2MWYUH=6Mcvz0XQcLRkO-n9BnVnX4RYWw@mail.gmail.com>
 <297ddf04-9b35-7613-8efd-2857668b6835@oracle.com> <CAP-5=fXSQVyqCfrBJFjHkrRdANuQC=TKR-HHi37hLaQ91rPQiA@mail.gmail.com>
 <eb011f48-b953-3647-4699-734ebdf1876a@oracle.com>
In-Reply-To: <eb011f48-b953-3647-4699-734ebdf1876a@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 14 Jul 2023 08:55:27 -0700
Message-ID: <CAP-5=fXJxVpYQ84hXiMxy4LUi7xs1puXdDhbp6d6N2ArnqKJuQ@mail.gmail.com>
Subject: Re: [PATCH RFC 4/9] perf jevents: Add sys_events_find_events_table()
To:     John Garry <john.g.garry@oracle.com>
Cc:     acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jul 14, 2023 at 4:58=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 13/07/2023 22:35, Ian Rogers wrote:
> >>
> >> {
> >>                  "MetricExpr": "pmu_unit@event_foo@ * pmu_unit@event_b=
ar@ * 2",
> >>                  "MetricName": "metric_baz",
> >> },
> >> {
> >>                  "EventCode": "0x84",
> >>                  "EventName": "event_foo ",
> >>                  "Compat": "0x00000040",
> >>                  "Unit": "pmu_unit"
> >> },
> >> {
> >>                  "EventCode": "0x85",
> >>                  "EventName": "event_bar ",
> >>                  "Compat": "0x00000040",
> >>                  "Unit": "pmu_unit"
> >> },
> >>
> >> And we have a pmu with name and hw id matching "pmu_unit" and
> >> "0x00000040" present, that we select metric metric_baz for soc_b
> > Not sure I'm fully understanding.With the sysfs layout we'd have to
> > have a way of supporting CPUIDs, we could have a mapfile.csv style
> > approach or perhaps encode the CPUID into the path. It is complex as
> > CPUIDs are wildcards in the tool.
>
> I am not sure why you mention CPUIDs. sys events and their metrics are
> matched only on Unit and Compat.
>
> Furthermore, my solution here is based what we have today, and would not
> be based on this sysfs solution which you mention.
>
> >
> >>> I think Unit may be useful, say on Intel
> >>> hybrid I want the tma_fround_bound metric on just cpu_atom. Currently
> >>> the use of Unit is messy for metrics, ie uncore metrics are associate=
d
> >>> with core PMUs, and what to do with a MetricExpr with >1 PMU. I think
> >>> we're learning from trying. I'm just hoping the migration to a sysfs
> >>> style layout will still be possible, as I can see lots of upside in
> >>> terms of testing, 1 approach, etc.
> >> Do you have an RFC or something for this "sysfs style layout"? I think
> >> that it would be easier for me to understand your idea by seeing the S=
W.
> > When I get a chance =F0=9F=98=84 My thought is to first extend jevents.=
py to
> > have a second output format, so sysfs style rather than pmu-events.c.
> > This way we can merge the changes as a jevents.py feature even if we
> > don't change the perf tool to support it.
>
> ok, fine, but I would still like this progress this work now. It has
> been sitting around for some time and was really difficult to rebase
> (since I was not tumbling my baseline).

Sure, the sysfs thing is a distraction until we have it. In this
series my main concern was in the changes of the event lookup and
having implied PMUs. You mentioned doing these changes so I was
waiting for a v2.

Thanks,
Ian

> Thanks,
> John
