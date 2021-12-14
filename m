Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B25C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Dec 2021 18:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbhLNS0W (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Dec 2021 13:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbhLNS0V (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Dec 2021 13:26:21 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9650EC061574
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Dec 2021 10:26:21 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id q72so25764197iod.12
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Dec 2021 10:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IsQhSGX+S4tLqCY+mBerWoOSqZDOGZjTeodMHL0FP1o=;
        b=HawPYtRZgGhuoB0aTLj9CSTZDqxSzhMZC9JpP53f9lnwNRZY0mLvAysVuG0x80gIs6
         IBBkaps2PS+kq9TY0Pm+A/03zYQa7+uvb2RlIqjZx4GssY7CuusRbeAjXVEzmR7YUyyA
         MoxWI7LBYvGf32b1d3APCsOUey6cFFgj1d3/PqU///iXDLt8ReSsX+FzuD8xi2xucwvc
         a+mdusS9mVxcBs2NaUDhGG5fKkSWwkcPefz5keqpgEzUXV5VH5OTjbIkwGhM9vaJdB4p
         PFDRR6RhgHEQEqWkjivjzt6/r8YtyZBmK6yls+YgT6w03wPuboO0DvRwJHjFTdc1pR9T
         jj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IsQhSGX+S4tLqCY+mBerWoOSqZDOGZjTeodMHL0FP1o=;
        b=x/we/BhiohaYv+FL9VsPueK2fcwJgqmC+0qS/nAGIVumyOubonbjcjv/Ymt7dnFz5o
         zQ0evrWaM+wUpzUDh9PJxYQV8dS5MODl2XvuK4pk6Wtyg4lZlfi3Uf5CHpIKSqaEHNcZ
         Y6QjWnQheWrCXb7/WVLRqlgyFH/qwEi6PACQI3HAmoJVotSolqpxmCfTYU7xB6+BKuC9
         CHwPZ+x4usbu1u6Eum7/0XSR80rgLCMVl+wyaY9DnrtjLtYRtVojlOFeiMwZ1WcIYTWs
         JL5xaeNIZVIOeg+KnHIICulJRJKmRVdniRPP+gCkNmjrTC+Ng9aTR8H1XYxmueOF8cKG
         shBg==
X-Gm-Message-State: AOAM533CFbj/tLU2TAEx381pSC5VdzHzXEptszfGBRUhnTTTYaQ8nAq/
        G3eSL5inXArhfw06w4tlHtPI2KuT2tnBO0v6CEQFlQ==
X-Google-Smtp-Source: ABdhPJzvLxmGCTDbzepf8rJj8aOqfJE61ZNVQJ6vYR0CPi1tTV7vpszIXfGMdQDFs5tX1Ds4fdAmRZXHuyeTLcn2Zmw=
X-Received: by 2002:a6b:b886:: with SMTP id i128mr4815728iof.151.1639506380786;
 Tue, 14 Dec 2021 10:26:20 -0800 (PST)
MIME-Version: 1.0
References: <486e7e8d-de21-5e26-3792-db2fd6991602@foss.arm.com>
 <CAP-5=fUtkCzgsGS6LkCVTuyPmw981Dd-EavtU6uv3o7OB7CnDA@mail.gmail.com> <ba55b083-dbfe-d069-ad67-0322b79112a3@arm.com>
In-Reply-To: <ba55b083-dbfe-d069-ad67-0322b79112a3@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Dec 2021 10:26:08 -0800
Message-ID: <CAP-5=fU2L4xv_507NH9yjuqx=ipA+eODL3dfrJ6pfcsaiZ6qDQ@mail.gmail.com>
Subject: Re: PMU event repository for Arm
To:     James Clark <james.clark@arm.com>
Cc:     Al Grant <al.grant@foss.arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Dec 14, 2021 at 2:23 AM James Clark <james.clark@arm.com> wrote:
>
>
>
> On 10/12/2021 18:47, Ian Rogers wrote:
> > This is very helpful! It is a bit strange seeing the event codes not
> > as hex. Do you have any plans around metrics? What is the flow from
> > this json to the linux/tools/perf json?
>
> Hi Ian,
>
> I can't answer about the metrics part, but we do currently have an internal
> script to convert from this repo to the perf tools jsons. Maybe @Andrew
> can clarify what the plan to upstream this is. I think we struggled to
> find a suitable place to put it.
>
> James

Github? :-) Fwiw, there are some similar scripts [1,2].

It is somewhat laborious getting the latest event data built into perf
for some architectures - download json/csv from one website, get
scripts from github, convert, insert into the perf json folder. A
problem is that perf versions of some the event/metric data is
becoming stale compared to what can be generated. It is best if this
data is sent by vendors, but I also understand that it can be hard for
teams at vendors to test the updates. If we do find something is
broken then what do we update? The original json, the converter
script, or the json in the Linux tree. If we don't change the
code/json in the Linux tree, how do we get the fix in?

Perhaps others have thoughts? It seems possible to host scripts in
Linux that will do the laborious steps above, to enable building perf
with the best event data with the minimum of heroics. Such a build
could be used by those doing packaging. This does somewhat beg the
question as to why we have the perf format json in the tree? There's
also a degree of code sharing that could be done between converter
scripts and the jevents code. We have collections of metrics,
including for ARM, that it would be interesting to get into the Linux
tree. We generate the perf json for those metrics using other tools
like [3] that we've tried to contribute as part of the jevents code in
the past.

Thanks,
Ian

[1] https://github.com/intel/event-converter-for-linux-perf
[2] https://github.com/intel/perfmon-metrics
[3] https://lore.kernel.org/lkml/20201110100346.2527031-1-irogers@google.com/

> >
> > Thanks,
> > Ian
> >
> > On Fri, Dec 10, 2021 at 7:53 AM Al Grant <al.grant@foss.arm.com> wrote:
> >>
> >> Hi, other vendors have shown the value of having a machine-readable
> >> collection of PMU events, and we now have this for Arm:
> >>
> >>    https://github.com/ARM-software/data
> >>
> >> This is equivalent to the tables in about 40 of Arm's public CPU
> >> reference manuals. It includes some details that aren't needed in
> >> tools/perf/pmu-events, but one could be generated from the other.
> >>
> >> There's also a map of CPU ids (MIDR) to CPU names, and an example
> >> script to scan /proc/cpuinfo and retrieve the correct JSON file(s).
> >>
> >> I won't spam linux-perf-users every time we add something, but we
> >> haven't publicized this before, so here it is. Feedback is welcome.
> >>
> >> Al
