Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D84C0015E
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Jul 2023 21:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjGMVgC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Jul 2023 17:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjGMVfz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Jul 2023 17:35:55 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B5D2D78
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jul 2023 14:35:33 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-401d1d967beso106541cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jul 2023 14:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689284132; x=1691876132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUoa5A08dWzHBGesZwp+iuIs8vVoR0P5xBL9pZfFCac=;
        b=sFhi/+DfNipC4AkEm9ehVCMoVGbcidgD+d71VfUxe64Aknr3qWcOedQHMrOhGAe6Zw
         3BJzYV8lIEzwvNzmOe4SzlL/jAzMWuUsESHQD5tWEc+9xxGFoFtdE5rUU6fYXrSM5qrS
         FEedFwfRZ/XbiJddR3v1XgFc/mg6L8LsqLs9BCN2A2GQ5P3UoPcOjhbSgDFZ7TDNSjB7
         sslDXKhjDPD+fjFn5zuRMia5W9jNSpYmvPrGu2kak5elN98E0FRvjvZZg1qYOVEqRs9O
         t193zIFpVZnGDrOiFhODCD8l3RcuNU1n+PXyD/jIjjW7llfcoj9Wlv/fSzZmzbacO/K6
         1qqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689284132; x=1691876132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUoa5A08dWzHBGesZwp+iuIs8vVoR0P5xBL9pZfFCac=;
        b=XJckvSJ24+ToJDFkQM26kXmUEsGBMs26JO23+UsKeGbWp0ySt2eISwTbB2AZZpzoL3
         5GwoEG+WnsOp5uWW/2yXO2A3kXIn1/axrsVTm6M8Vl8Kq2yWeSrRD1k01+IgOEnAEo0F
         dWBsSmGNS9k1oK54OuGIk8WXgpq1Le6pregfWYcLZ4OrN0IWZnqP3dqCbXpTS036KQLX
         VZggsOmpmXjgHHBsPyFHeVqIdWl1Wbbq4A10xBL9hUQSqBVZTB6JcGQIjegXPaGZ1XJv
         47FqP1i4WZBuPtQXkvivi8aSa9fwx2cC0VIDjm5fZmYmuIOjcTA37/UAZa9eMQ4H1mIy
         D+fA==
X-Gm-Message-State: ABy/qLbdjb4dSZaUdpg4lO9TN/RYgZ4pIemzIDJYRBpg7zJCdPNHA9BB
        1BV4zSBc3xhiOWhkGm7KN7nIOPQgmVucvHKmgANExg==
X-Google-Smtp-Source: APBJJlHcr0n0amHwFS1Sn4j8Xig7KC2igjGc/mxuLuJHqedGL7hl5VdbWFneOfb0fZD7HMEgfOacYjJFFwgCxfNF2TM=
X-Received: by 2002:ac8:590d:0:b0:3f8:5b2:aef4 with SMTP id
 13-20020ac8590d000000b003f805b2aef4mr639497qty.28.1689284132081; Thu, 13 Jul
 2023 14:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
 <20230628102949.2598096-5-john.g.garry@oracle.com> <CAP-5=fXa24_LEiyni0Ncyfa5hKwC1GE6y-zi2u8M98M9SwHX+g@mail.gmail.com>
 <CAP-5=fUs=u3PKYP3mVDdzNB8+=GAHaEXG3SGfWJpMELYYqO_hA@mail.gmail.com>
 <d59b6e7c-cead-24d4-a9cb-6552b3154d84@oracle.com> <CAP-5=fUu6xgVDQT4tq=vmRLDMe3ddMLywP11uOLvKSu8Lc6BjQ@mail.gmail.com>
 <897dcf1d-6a04-33d3-9c4f-ea9d1706cdad@oracle.com> <CAP-5=fX+rz928LtFs2MWYUH=6Mcvz0XQcLRkO-n9BnVnX4RYWw@mail.gmail.com>
 <297ddf04-9b35-7613-8efd-2857668b6835@oracle.com>
In-Reply-To: <297ddf04-9b35-7613-8efd-2857668b6835@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 13 Jul 2023 14:35:20 -0700
Message-ID: <CAP-5=fXSQVyqCfrBJFjHkrRdANuQC=TKR-HHi37hLaQ91rPQiA@mail.gmail.com>
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

On Thu, Jul 13, 2023 at 8:07=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 12/07/2023 18:52, Ian Rogers wrote:
> >> To be crystal clear, when you say ">1 PMU", do you mean ">1 PMU instan=
ce
> >> of the same type" or ">1 PMU type"?
> > So I'm meaning that if you have a MetricExpr where the events are from
> >> 1 PMU, for example memory bandwidth coming from uncore PMUs and then
> > instructions from a core PMU, and you do something like a ratio
> > between these two.
> >
> >>    in a metric wouldn't work though as it would
> >>> appear the event was missing. Having the metric specify the PMU avoid=
s
> >>> these problems, but is verbose.
> >> The message I'm getting - correct me if I am wrong - is that you would
> >> still prefer the PMU specified per event in metric expr, right? We don=
't
> >> do that exactly for sys PMU metrics today - we specify "Unit" instead,=
 like:
> >>
> >> MetricExpr: "sys_pmu_bar_event_foo1 + sys_pmu_bar_event_foo2"
> >> Compat: "baz"
> >> Unit:"sys_pmu_bar"
> >>
> >> And so you prefer something like the following, right?
> >> MetricExpr: "sys_pmu_foo@bar1@ + sys_pmu_foo@bar2@"
> >>
> >> If so, I think that is ok - I just want to get rid of Unit and Compat.
> > I think we're agreeing =F0=9F=98=84
>
> Ok, fine. I need to check on implementing support for that.
>
> Then would you have any idea for testing here?
>
> What I do is to ensure that if we 2x tables like following for separate
> SoCs:
>
> soc_a.json
>
>
> {
>                 "MetricExpr": "pmu_unit@event_foo@ * pmu_unit@event_bar@ =
* 1",
>                 "MetricName": "metric_baz",
> },
> {
>                 "EventCode": "0x84",
>                 "EventName": "event_foo ",
>                 "Compat": "0x00000030",
>                 "Unit": "pmu_unit"
> },
> {
>                 "EventCode": "0x85",
>                 "EventName": "event_bar ",
>                 "Compat": "0x00000030",
>                 "Unit": "pmu_unit"
> },
>
>
>
> soc_b.json
>
>
> {
>                 "MetricExpr": "pmu_unit@event_foo@ * pmu_unit@event_bar@ =
* 2",
>                 "MetricName": "metric_baz",
> },
> {
>                 "EventCode": "0x84",
>                 "EventName": "event_foo ",
>                 "Compat": "0x00000040",
>                 "Unit": "pmu_unit"
> },
> {
>                 "EventCode": "0x85",
>                 "EventName": "event_bar ",
>                 "Compat": "0x00000040",
>                 "Unit": "pmu_unit"
> },
>
> And we have a pmu with name and hw id matching "pmu_unit" and
> "0x00000040" present, that we select metric metric_baz for soc_b

Not sure I'm fully understanding.With the sysfs layout we'd have to
have a way of supporting CPUIDs, we could have a mapfile.csv style
approach or perhaps encode the CPUID into the path. It is complex as
CPUIDs are wildcards in the tool.

> >I think Unit may be useful, say on Intel
> > hybrid I want the tma_fround_bound metric on just cpu_atom. Currently
> > the use of Unit is messy for metrics, ie uncore metrics are associated
> > with core PMUs, and what to do with a MetricExpr with >1 PMU. I think
> > we're learning from trying. I'm just hoping the migration to a sysfs
> > style layout will still be possible, as I can see lots of upside in
> > terms of testing, 1 approach, etc.
>
> Do you have an RFC or something for this "sysfs style layout"? I think
> that it would be easier for me to understand your idea by seeing the SW.

When I get a chance :-) My thought is to first extend jevents.py to
have a second output format, so sysfs style rather than pmu-events.c.
This way we can merge the changes as a jevents.py feature even if we
don't change the perf tool to support it.

Thanks,
Ian

> Thanks,
> John
