Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D41EC43381
	for <linux-perf-users@archiver.kernel.org>; Sun, 14 Mar 2021 17:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3317F64EB5
	for <linux-perf-users@archiver.kernel.org>; Sun, 14 Mar 2021 17:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbhCNR3h (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 14 Mar 2021 13:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbhCNR3Y (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 14 Mar 2021 13:29:24 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C582C061574
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Mar 2021 10:29:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso18121542wmi.0
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Mar 2021 10:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l41A18Hz65JCdHvie538vZEMzuenwuoSbfPoqPwrfPg=;
        b=bokGFEftBZ1bv2YB9NIrNN2YTEf6rEZITNWqrj3FIZSWmzX6/uhT0lLMWnQTv5/W0k
         LnqgOYXnNcrUVahz0ttoCqYfTtcSYJOYUVAIuQg9+NVcz2T4spp5khwI91coVB7rA4xk
         p6TkGn15dZOpMzSDKgYzJRoS1g9BykDzw6r+aBr8gjB8aGzJA2AC2lMIEPsoDwTWGXFc
         u9gJl0pbYRED4ObNuJSJNhMNP3+bucZxX8XiFi7Ztw08l3e0vRa6t8tNKa4OKOmYV8V5
         y3jWvMMMoU/2wFwLrKXiu0RsMWv8BoeqNFkllSzIStQvP1ItAk5HbZZ1aKdPlNBuUD9T
         1HRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l41A18Hz65JCdHvie538vZEMzuenwuoSbfPoqPwrfPg=;
        b=sNPBi+7euzVd9rE/AoOYXRpT9eL3uXph/QeanD9eYbE70WOBtsBXGSPmI+DejcPNB2
         7m3uDqs6ClK4xhDbadfAlrcQduy8PFUTo33aCQZoQsJE/uqYq37FjlKzZFD3PsLz1z3o
         4POTnTv4H4jL8Q7/mdHxIa13k52JoVilwbnUqWDOVqpRfxXajBNhGsa1xIVrObbCnS4x
         rS5exlhud9FvdCRmsU3+11UHplP5+qVAZOafrHh2+z7stBwA+jXg/5pXTB2ZulNElUQX
         w88XIptuHiRtGoGp58laSBlN6WSlDGTVeW4kZnOut/cmeKU9aYSkroszfLnjSwz8Yf4j
         Lotw==
X-Gm-Message-State: AOAM531zKRCAFFURNXLRIMZ7vEm2kX/lfN5jN1BZ0Joo7RvvGvb5W0c/
        Qvwjyhp3/cj5srDwwHOS80mIt8eHTWV0Lm1tgsfNiA==
X-Google-Smtp-Source: ABdhPJw8x5h01GvBNKv4fOTmI9P56sDbZFwLKHxBEi3fHM7n/NtXuJQc5lx5+3EDo1u7E4HVUHtAX6lLFNF3H3EvVbM=
X-Received: by 2002:a7b:c188:: with SMTP id y8mr22053673wmi.76.1615742961335;
 Sun, 14 Mar 2021 10:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fXevQSmPPu2d3QixSJH=8Y5cb379angt36mATj96E7ZPw@mail.gmail.com>
 <6935438.x6IAOlLzNv@agathebauer>
In-Reply-To: <6935438.x6IAOlLzNv@agathebauer>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 14 Mar 2021 10:29:09 -0700
Message-ID: <CAP-5=fUsFKOj3iN4h7DPAeT-GrEby8T0JJEj1zTBxw5L4q_oBQ@mail.gmail.com>
Subject: Re: Linux Foundation accepted for Google Summer-of-Code 2021
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Aveek Basu <basu.aveek@gmail.com>,
        Till Kamppeter <till@linux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Milian,

Thanks for the email and hotspot is a very interesting project!

On Sat, Mar 13, 2021 at 8:25 AM Milian Wolff <milian.wolff@kdab.com> wrote:
>
> On Mittwoch, 10. M=C3=A4rz 2021 17:32:25 CET Ian Rogers wrote:
> > Hi,
> >
> > I'm happy to share that the Linux Foundation has been accepted into
> > the Google Summer-of-Code 2021 and we are looking for students
> > interested in profiling, perf, etc. to apply to do projects.
> >
> > The main details on the Linux foundation application are here:
> > https://wiki.linuxfoundation.org/gsoc/google-summer-code-2021
> >
> > Details on potential projects with perf here:
> > https://wiki.linuxfoundation.org/gsoc/2021-gsoc-perf
> >
> > Please help to share, especially to students.
> >
> > Additional project ideas, mentors and help is also appreciated.
>
> As the maintainer of hotspot [1], I'd be happy to discuss how we could re=
use
> the prior art in providing a GUI around `perf report` and more. Consideri=
ng
> that hotspot is already a pretty successfull project, I wonder why we hav=
e to
> reinvent the wheel to provide a gtk-based GUI - is it really just the
> framework choice - Qt vs. GTK? Or are there other reasons?

There are a few issues:
 - there's an observation that the gtk support in perf was bitrotting.
Having a student project in this area would hopefully improve this
situation.
 - commands like perf report even in text mode are slow, single
threaded, etc. Again, an area where a student project can help out.
 - wrt UI there is also pprof (https://github.com/google/pprof) which
I think a web UI is interesting beyond just Qt, GTK, etc. Having the
code be within the perf tool means that testing can be automated, it
is easy for shared contributions, the kernel and user APIs aren't
separated by projects..

> [1]: https://github.com/KDAB/hotspot/
>
> Generally, I would love to see a proper library provided by perf that cou=
ld be
> used to do the `perf report` and/or `perf annotate` data processing.

There is a library interface developing:
https://github.com/torvalds/linux/tree/master/tools/lib/perf

but it is mainly focussed on say 'perf record' than 'perf report'.
Perhaps you could mentor a project to refactor the report APIs, which
could be integrated with hotspot? If so, we can update the GSoC wiki.

It'd be nice to refactor things like event parsing into a library, in
part to make unit and fuzz testing easier. The event sorting is a big
source of perf's slowness and something that should be reasonable to
parallelize, an issue here is a lack of a thread pool and other
abstractions. These dependencies across projects can be something that
is tricky.

> As I said - I'm happy to discuss this topic in more detail with anyone
> interested in this topic.

I'm interested! There is an IRC channel #perf see www.oftc.net, but
I'd suggest the mailing list is better for discussion. I know that BPF
is doing regular office hours. I could imagine that similar for perf
would be useful, but I also know that maintainers are busy folks.

Thanks!
Ian

> Cheers
>
> --
> Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
> KDAB (Deutschland) GmbH, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt, C++ and OpenGL Experts
