Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D08C433FE
	for <linux-perf-users@archiver.kernel.org>; Sun, 13 Feb 2022 01:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiBMBrl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 12 Feb 2022 20:47:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiBMBrl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 12 Feb 2022 20:47:41 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3232360067;
        Sat, 12 Feb 2022 17:47:37 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id n5so9807579ilk.12;
        Sat, 12 Feb 2022 17:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XcUWEf3ZhSye+IepyjW5pUNCJztEYnaHtpPfhkyEwp8=;
        b=qqMFL8K00cU1nsd6oRgsvD3HBRptzkkTCktRWPBGTppaKZIZBRwvYgQiBAB2r0hbEQ
         s0axjnXTY4aXvA+LXKt/8UgDKvGoyYTYr4MlonBk68kXZvBwhtL8zHeQj36gDoivaVD/
         I60bDlw4pWCJhRbEEf4zwjAFSGjnGfVouPgtbQ9Jfh5tL5DegsFSk3Dcg49P/EfZiCN2
         GDHr/bi7ihhswf/sj+2JeocWmp4dI6/Iyf5r3gHp6SET6KwZXA0CWqSgBCQGjUdMtFrX
         i34Fu4Z4vUNaTx0UubG+tTKnxLYs5DwTaFO1jaFhV09J7pZGBIVwwSF9RwvoeofO9fwZ
         HPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XcUWEf3ZhSye+IepyjW5pUNCJztEYnaHtpPfhkyEwp8=;
        b=hGFi4YZ8p/nGvAHrG2V5KqMfKRANtvBDYNxGBE7BDY+opKD3LeSjiiL9m7yWgeBDin
         QcpGbxlxXRe5XZez2Hn62xToX2WRFqBhKbz53d6/tVqsDQUYGhU73SUOMSv7k9dnNU1G
         4ivwcImBPdo5hlVjskcr52/z2jLLfJiF8+gVWAtCvVXWQpB6JlKdJbU9FLRxLpJiG5TQ
         29bwrR1t+e3S7U+tx89IIzOkthJeuCdMXdh/C92qBb8z2iWwz/lZmRcf1OnHqDWfwmXp
         7J3YUN3vVC6h2quhQrGmEXb1W6+BKzrHqQcKOrPiOpT9rkuD4w0UNM3+6XDaAiM0qjyO
         j7XQ==
X-Gm-Message-State: AOAM531Tc3Gy8qjS/8J4ni4V+2LGp7GkwViiq/iJHjoOMZY0LpNZMO6m
        Fzeis957YTOXBA/YQr6BsGOso0Rrh56KuwcxyWA=
X-Google-Smtp-Source: ABdhPJxrZ2+g1wyHgUPE+Lqk0NHnHECdUUUoD09e7FwHZdZL4DKM4pRGjb/dH4SrAX9X/k5z9rUPAOVP+tfkqFa+e1U=
X-Received: by 2002:a05:6e02:190e:: with SMTP id w14mr4343381ilu.71.1644716856565;
 Sat, 12 Feb 2022 17:47:36 -0800 (PST)
MIME-Version: 1.0
References: <20220212155125.3406232-1-andrii@kernel.org> <Ygf56M45VuWfippn@krava>
In-Reply-To: <Ygf56M45VuWfippn@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 12 Feb 2022 17:47:25 -0800
Message-ID: <CAEf4Bzav96MoZh08s7UZfnLQPTRbF+UvuWA75r0GPkYTRGdsYg@mail.gmail.com>
Subject: Re: [PATCH v6 perf/core 0/2] perf: stop using deprecated bpf APIs
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Christy Lee <christylee@fb.com>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Feb 12, 2022 at 10:18 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Sat, Feb 12, 2022 at 07:51:23AM -0800, Andrii Nakryiko wrote:
> > libbpf's bpf_prog_load() and bpf__object_next() APIs are deprecated.
> > remove perf's usage of these deprecated functions. After this patch
> > set, the only remaining libbpf deprecated APIs in perf would be
> > bpf_program__set_prep() and bpf_program__nth_fd().
> >
> > v5 -> v6:
> >   - rebase onto perf/core tree (Arnaldo);
>
> looks good, tests are passing for me

great, thanks for checking!

>
> jirka
>
> > v4 -> v5:
> >   - add bpf_perf_object__add() and use it where appropriate (Jiri);
> >   - use __maybe_unused in first patch;
> > v3 -> v4:
> >   - Fixed commit title
> >   - Added weak definition for deprecated function
> > v2 -> v3:
> >   - Fixed commit message to use upstream perf
> > v1 -> v2:
> >   - Added missing commit message
> >   - Added more details to commit message and added steps to reproduce
> >     original test case.
> >
> > Christy Lee (2):
> >   perf: Stop using deprecated bpf_load_program() API
> >   perf: Stop using deprecated bpf_object__next() API
> >
> >  tools/perf/tests/bpf.c       | 14 ++----
> >  tools/perf/util/bpf-event.c  | 13 +++++
> >  tools/perf/util/bpf-loader.c | 98 +++++++++++++++++++++++++++++-------
> >  3 files changed, 96 insertions(+), 29 deletions(-)
> >
> > --
> > 2.30.2
> >
