Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C2CC4338F
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Aug 2021 20:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6CD161246
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Aug 2021 20:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhHWUss (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 Aug 2021 16:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbhHWUsr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Aug 2021 16:48:47 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F57AC061575
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Aug 2021 13:48:04 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id h29so18400335ila.2
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Aug 2021 13:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zLS9jHLALutIbPfMAvQtZQNv8NmxuoeFKVJ4owche3c=;
        b=f0ff9e+cHuwlsz40CDVdhMwu+Y1P6KZ++e/fMChA2myIbIbgH/kvMI6BEnTrOpCHfc
         K7oblfLqQK3cAuZ/7F3JHQsF2TycbT0fED4oVX9+/wJy6JoEKSrc6h+SAKGzGS8wFOWB
         bEpt7puw5M8gWwhH6oKVysMdn3WsmnkWwWoyVjBC0BliqqD/96WB0mssmDg2mFs3VjPx
         N2QUp0s2Q3u1LIsLk2zeUXmYPtPboyUOULtSV70e4NjC/fs2oNC5q+5iEfKwT7XHmJr6
         WbZ+1CdwO1MrwJeRcLg4yzVm1KGiLxg8YQztuK7n9umR4j94Da4ZLS5XyW8QD7uOefzo
         ezbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLS9jHLALutIbPfMAvQtZQNv8NmxuoeFKVJ4owche3c=;
        b=d1t6jKPajofdHznFvamSA7GASWEL0UlQxiGz56/CXRoLsBeAC6xTIgcA1V9DetAGyd
         VdANqMpBYJQxKB5W/pmXAq/va/oZBrF2p0Gme+h1xobSYltCDtIpkmbIbQlBtkjmqJd2
         Ieyfq8KWjB9PHLUhcu9dHHhCo6UQtW8+yKJzXFm/1Sh1hBJRrA3e5c99FZU8Oo0Oz1YJ
         vxFRUOxtglTyCGILI/6xMm6CsoQ+DyHJ6wYZKQnu4NehyZLEUsOaNLKxnyncuwNjqZ3j
         k4ofkfVBjUpMHg1Q9zODiWXTbsN48sSVyJadg1xpr4RK/D/fIfg8VgpTN3rBovzPp4VZ
         CJaw==
X-Gm-Message-State: AOAM530m/tyFwRXJW0chvvvSIiF/RtvvKWioYFPcOoq/YuepQJ3vb3do
        Q/QU/ZE0ypV8KTQFlJk3sS5Kiw7Q8j+ctR1BHVGN8Q==
X-Google-Smtp-Source: ABdhPJy0zo5sFtM+bsrybcGrHH2jHSecxZcgo9HEld36xXs4sjsjP+Z1GS5ekQBwoR/zOcNvBBTNmfmOd/8LaKw5ytw=
X-Received: by 2002:a92:c68a:: with SMTP id o10mr23957128ilg.163.1629751683450;
 Mon, 23 Aug 2021 13:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <3c4f8dd64d07373d876990ceb16e469b4029363f.camel@gmail.com> <b7a9f309-9765-2a64-026e-efa835989add@linux.intel.com>
In-Reply-To: <b7a9f309-9765-2a64-026e-efa835989add@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 23 Aug 2021 13:47:51 -0700
Message-ID: <CAP-5=fV1+WKKWVYVivDt1uE8P9koKre-=Boh0-P1vTD6uiw2=A@mail.gmail.com>
Subject: Re: [GSoC] Multi-threading in perf: Final Report
To:     "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Cc:     Riccardo Mancini <rickyman7@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Aug 23, 2021 at 4:40 AM Bayduraev, Alexey V
<alexey.v.bayduraev@linux.intel.com> wrote:
>
> On 21.08.2021 12:41, Riccardo Mancini wrote:
> > Hi,
> >
> > this is the final report of my project "Multi-threading in perf",
> > developed as part of the Google Summer of Code with the Linux Foundation.
> > https://summerofcode.withgoogle.com/projects/#4670070929752064
> <SNIP>
> >
> > Review activity:
> > PATCHSET Introduce threaded trace streaming for basic perf record operation
> >   Link: https://lore.kernel.org/lkml/cover.1629186429.git.alexey.v.bayduraev@linux.intel.com/
> >   Contribution: helped in fixing some bugs, performed extensive testing
>
> Hi Riccardo,
>
> Thank you very much for the deep review and extensive testing of
> this patchset, it was very helpful and allowed us to improve
> the quality of the feature used in our product.
>
> Good luck,
> Alexey

Likewise, thank you Riccardo! It is always implied but not said often
enough, thank you Arnaldo! I'm hoping the success of Riccardo's work
will be an example for next year and we can also get more mentor
volunteers.

Thanks!
Ian

> > PATCHSET perf tools: Add PMU alias support
> >   Link: https://lore.kernel.org/lkml/20210729070619.20726-1-yao.jin@linux.intel.com/
> >   Link: https://lore.kernel.org/lkml/20210729070619.20726-1-yao.jin@linux.intel.com/
> >   Contribution: helped in fixing some memory bugs
> >
> >
