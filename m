Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35251C4332F
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Nov 2022 22:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiKQWJf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Nov 2022 17:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240381AbiKQWIt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Nov 2022 17:08:49 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCFE7EBC8
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Nov 2022 14:08:23 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id k8so6214976wrh.1
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Nov 2022 14:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7/FTKNAmP6F3iAI6A3xeaew/xWrn0EKEXsTY8o2IBRY=;
        b=hT9jf1YBUrY2/GUlTJ1sNhW99XnZkk1OVcjVRnVj0nUDpXf1Tbg0ovhIzvWi0lH9qC
         l2npItjf5TRqGNoB75JC30SRzoPUtEHJZCki7dL/VF7ghubyOwvw8sq14Y3fHaufOap/
         cRMHP0UjqQ9hWNImTTs7ZO1YWd/tdzysaXsU9YmBmDdsSpkEORBrid7B4sFfqNSDBNqc
         +3+lWC4zZOR+yz8nLV3ddJeahpv3HtxvxTfhLXuaWc7FewzlOst0Un/RCWpcGxBYhpUI
         1Gk8dzzBp5CIZHgsYko442p61qWBpYkN1GpaUrf//msPaNzDf1cE/ugBPAZnbGXucHQ6
         YiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/FTKNAmP6F3iAI6A3xeaew/xWrn0EKEXsTY8o2IBRY=;
        b=P8CDQUT5NrAR2SurKaBzC7E/Mjl7uOqgBTSpR/a9rcp80+Is6rneWbf1vracwpzmVs
         tri4Sp51Mw3P0X2XNLCwUHnMMRxN+QG14Zzt4ezKH67dJy0ZFpfW6F3qCN2u68WQfopp
         HhI8KiMcdez8aKXZhK7tNb5MMEdbtcemJzuy+a6oyP0a37s994Tjobvtf59ES3SasNYQ
         SgTnSow1o1vij3RiCUR4Sf1yTriPMB1c7cOV4R5ttmyfelz3MIW2Gy6YFgLHUIYjCyrD
         GxDLb1+o8C82WEJvp9PgxzEK9WwpxiJDq6gG4dLUozbSprFfhvxyDzaBI8LOqRZwpKyr
         R0Nw==
X-Gm-Message-State: ANoB5plVfqX9x4HOmSsvjpYG0Sg7vyAyBOBJMT4GteIBWrYDq3wi8N2+
        JHSZOd1ukL7H/8g59GR36xQNrLv1Mo5vrm7eMN4MiA==
X-Google-Smtp-Source: AA0mqf7VR+RYn9Xb12dyPHx7g/uaDcUS/zlSYV5fXtRVeSi+ehk7hS0Q/dpJEF2vNXhTnpDSJknubw/rfoJbi4y8YMs=
X-Received: by 2002:adf:f6cc:0:b0:228:dd1d:8a42 with SMTP id
 y12-20020adff6cc000000b00228dd1d8a42mr2701812wrp.375.1668722901599; Thu, 17
 Nov 2022 14:08:21 -0800 (PST)
MIME-Version: 1.0
References: <20221012164244.3027730-1-irogers@google.com> <CAP-5=fW5+boUZqJV6-6VVa2bOcTrErHU3K5Fz-Z54j8uq_kfdw@mail.gmail.com>
 <Y21Hdoc8KsvNMbTQ@kernel.org> <CAP-5=fXbjk31SvZNVzo5x0uDnVndw7Z=BFPah9Dgx=AULkTPaA@mail.gmail.com>
 <f3e704f9-988c-e01f-eb40-13aa405e2857@oracle.com> <259f8e47-bd58-c8dc-c3fd-12e8dd5d013d@oracle.com>
In-Reply-To: <259f8e47-bd58-c8dc-c3fd-12e8dd5d013d@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 17 Nov 2022 14:08:09 -0800
Message-ID: <CAP-5=fV-pfdSP+L4+Gr0D_+MO9bAOSd3s1_2Ayahg5vcqC66HQ@mail.gmail.com>
Subject: Re: [External] : Re: RFC Re: [PATCH v2] perf jevents: Parse metrics
 during conversion
To:     John Garry <john.g.garry@oracle.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Nov 17, 2022 at 10:16 AM John Garry <john.g.garry@oracle.com> wrote:
>
> On 15/11/2022 17:35, John Garry wrote:
> > On 15/11/2022 17:26, Ian Rogers wrote:
> >> On Thu, Nov 10, 2022 at 10:48 AM Arnaldo Carvalho de Melo
> >> <acme@kernel.org> wrote:
> >>>
> >>> Em Fri, Oct 28, 2022 at 10:57:02AM -0700, Ian Rogers escreveu:
> >>>> On Wed, Oct 12, 2022 at 9:42 AM Ian Rogers <irogers@google.com> wrote:
> >>>>>
> >>>>> Currently the 'MetricExpr' json value is passed from the json
> >>>>> file to the pmu-events.c. This change introduces an expression
> >>>>> tree that is parsed into. The parsing is done largely by using
> >>>>> operator overloading and python's 'eval' function. Two advantages
> >>>>> in doing this are:
> >>>>>
> >>>>> 1) Broken metrics fail at compile time rather than relying on
> >>>>>     `perf test` to detect. `perf test` remains relevant for checking
> >>>>>     event encoding and actual metric use.
> >>>>>
> >>>>> 2) The conversion to a string from the tree can minimize the
> >>>>>     metric's string size, for example, preferring 1e6 over 1000000
> >>>>>     and removing unnecessary whitespace. On x86 this reduces the
> >>>>>     string size by 2,823bytes (0.06%).
> >>>>>
> >>>>> In future changes it would be possible to programmatically
> >>>>> generate the json expressions (a single line of text and so a
> >>>>> pain to write manually) for an architecture using the expression
> >>>>> tree. This could avoid copy-pasting metrics for all architecture
> >>>>> variants.
> >>>>>
> >>>>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>>>
> >>>> Ping, PTAL.
> >>>
> >>> That would be really nice if people working with JSON, metrics, could
> >>> take a look at Ian's work and test it with their files, volunteers?
> >>
> >> Perhaps John could help?
> >
> > I'll have a look soon. I have to admit that I have not been tracking the
> > jevents changes as close as before.
>
> At least I can try to test it... so we support python 3.6 and later, right?
>
> I have 3.6 and acme perf/core generated pmu-events.c is ok for me, but
> this patch causes an error:
>
>    GEN     pmu-events/pmu-events.c
>   PERF_VERSION = 6.1.rc3.g39b7ecfa5b4a
>   GEN     perf-archive
>   GEN     perf-iostat
> Traceback (most recent call last):
>   File "pmu-events/jevents.py", line 7, in <module>
>     import metric
>   File "/home/john/kernel-dev2/tools/perf/pmu-events/metric.py", line
> 399, in <module>
>     class MetricGroup:
>   File "/home/john/kernel-dev2/tools/perf/pmu-events/metric.py", line
> 408, in MetricGroup
>     'MetricGroup']]):
> TypeError: 'type' object is not subscriptable
> make[3]: *** [pmu-events/Build:26: pmu-events/pmu-events.c] Error 1
> make[2]: *** [Makefile.perf:672: pmu-events/pmu-events-in.o] Error 2
> make[2]: *** Waiting for unfinished jobs....
>
>
> Any idea?

Apologies, this looks like a fault by me. I'll downgrade my python and
fix this for the next version.

Thanks!
Ian

> Thanks,
> John
