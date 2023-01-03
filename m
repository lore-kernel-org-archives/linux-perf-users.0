Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9771FC3DA7D
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 Jan 2023 07:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjACHNk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 3 Jan 2023 02:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjACHNh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 Jan 2023 02:13:37 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA41286
        for <linux-perf-users@vger.kernel.org>; Mon,  2 Jan 2023 23:13:36 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso20280356wmb.3
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Jan 2023 23:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bL4qkQY7ur6FxEmH4uMUcgyWiP9jzss/wcqg6hA1vvc=;
        b=botSm1VheZsYvGXLqhMaEe5RTe7SgEuPJj2bCMFlzT7veP0FMPFIuHwagbfNOktSo2
         oCElw2pXGJMT9469Qi24DHxYIjWpWF/ZmkFmlJ/9CDegKzgIbcRRdZybe/zBxZID4fz/
         EaLqavjuH80VAje7SDOebQ/boj+T58z2m9WXd+EOZGbvjbJD9OqLnHZtO1C8oE+2tXhG
         VGH66T96pLtCsHa/lh+YLooV1x4yzHR+QvXq2RI0MdW9raPgnvS+LD4fn6uQbSeXSneH
         VU6alAiG8L/Fi5w9KC5gqOK3c4/77cFoqMOzALZtrO0aG+4sEjHVVO/NCumUUVZ8TGHI
         WkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bL4qkQY7ur6FxEmH4uMUcgyWiP9jzss/wcqg6hA1vvc=;
        b=Ir7EDhra5m1Q++uy4wcoqJdCWFAZ21h2KrUeSn6DFg9ATrrkjp0sEzFgEQQuhajAF/
         J5d6TewQ6etJ2p8DWJVFqZvNG6hath45VyeiKXcjSP1wBTbnCMWoNXyFAF2sJ7MlNhNo
         j5jJbSGaylT9OK6h3ECLbiNWRK6jpZ3rcvnhK3upfYni0T7YOjb+dY8LMXSn5yuSPIfI
         p0uHJFNfbwgSfTZBTx4KvJkDmZhgwRR6SroULophIki5vn5a/jxn5KnfroFrzdQjeZlz
         uWvKSbUTYvWC3X1AyVvZDCDargB22XKaiFJuIpDgO1ebSWa4VXUZDisBFKoV4ctec6a2
         Ra1A==
X-Gm-Message-State: AFqh2krwEXXkLRed/Byu4WAWKuF8v7jX+AYhgmIP1XyYZmFd5piHxZA2
        wvVWilb4ks3qk9TMOmMvFSeGZjqou8C7leDk5TpmKA==
X-Google-Smtp-Source: AMrXdXsiPM53BzYmpWSLs+wy529TjV+TlAkQcJPMm0CAsFpg9Gf9NR8N9a+8bhII07Fgb6lEiAHV7uvqZp8CNHVIJXU=
X-Received: by 2002:a05:600c:217:b0:3c6:c109:2d9 with SMTP id
 23-20020a05600c021700b003c6c10902d9mr2836661wmi.149.1672730014782; Mon, 02
 Jan 2023 23:13:34 -0800 (PST)
MIME-Version: 1.0
References: <fa4b3115-d555-3d7f-54d1-018002e99350@secunet.com> <d372f704-fa4a-344f-7a15-d97bfb13ac1d@leemhuis.info>
In-Reply-To: <d372f704-fa4a-344f-7a15-d97bfb13ac1d@leemhuis.info>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 2 Jan 2023 23:13:22 -0800
Message-ID: <CAP-5=fXkpbfxGo8ozTJRCXVm0eS6tZ+9XSLchTfcVHmvvhBq5A@mail.gmail.com>
Subject: Re: [v6.2-rc1] Regression with installing perf tool
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Torsten Hilbrich <torsten.hilbrich@secunet.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jan 2, 2023 at 7:06 AM Linux kernel regression tracking
(#info) <regressions@leemhuis.info> wrote:
>
> [TLDR: I'm adding this report to the list of tracked Linux kernel
> regressions; all text you find below is based on a few templates
> paragraphs you might have encountered already already in similar form.
> See link in footer if these mails annoy you.]
>
> [CCing Arnaldo]
>
> On 02.01.23 14:16, Torsten Hilbrich wrote:
> >
> > I recently tried a kernel build based on v6.2-rc2 and had some regression when trying to install the perf command. It seems that the commit:
> >
> > commit 746bd29e348f99b44c14cb2b2a57f1d3efb66538
> > Author: Ian Rogers <irogers@google.com>
> > Date:   Tue Nov 15 23:22:11 2022 -0800
> >
> >     perf build: Use tools/lib headers from install path
> >
> >     Switch -I from tools/lib to the install path for the tools/lib
> >     libraries. Add the include_headers build targets to prepare target, as
> >     well as pmu-events.c compilation that dependes on libperf.
> >
> > Causes the the following command to fail: "make -C tools/ perf_install"
> >
> > Full logs are attached as file.
> >
> > The basic error is that the adding of $(LIBAPI), $(LIBSYMBOLS) and others to the prepare target seems to has problems when the subdir variable is set by the tools/Makefile.
> >
> > The call chains seems to include
> >
> > - "make -C tools perf_install" which calls:
> > - "make  subdir=perf --no-print-directory -C perf install" which then fails
> >
> > The beginning of tools/scripts/Makfile.include then seems to construct a name like /build/git/linux/tools/perf/libapi/perf/ (when building in /build/git/linux) and this directory does not exist.
> >
> > We only need the perf tool in this case, so we don't care much about the optional features which are missing.
> Thanks for the report. To be sure the issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> tracking bot:
>
> #regzbot ^introduced 746bd29e348f99b44c14cb2b2a57f1d3efb66538
> #regzbot title perf build: problems when trying to install the perf command
> #regzbot ignore-activity
>
> This isn't a regression? This issue or a fix for it are already
> discussed somewhere else? It was fixed already? You want to clarify when
> the regression started to happen? Or point out I got the title or
> something else totally wrong? Then just reply and tell me -- ideally
> while also telling regzbot about it, as explained by the page listed in
> the footer of this mail.
>
> Reminder for developers: When fixing the issue, add 'Link:' tags
> pointing to the report (see page linked in footer for details).
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

Thanks, hopeful fix in:
https://lore.kernel.org/lkml/20230103070916.2407873-1-irogers@google.com/

Ian

> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> That page also explains what to do if mails like this annoy you.
