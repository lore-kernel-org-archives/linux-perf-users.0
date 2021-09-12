Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3658DC433F5
	for <linux-perf-users@archiver.kernel.org>; Sun, 12 Sep 2021 16:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DB3460F92
	for <linux-perf-users@archiver.kernel.org>; Sun, 12 Sep 2021 16:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhILQXT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 12 Sep 2021 12:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhILQXT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 12 Sep 2021 12:23:19 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE26C061574
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Sep 2021 09:22:04 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id w1so7553763ilv.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Sep 2021 09:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=otoclXzkeEyh1j5woX95Y4BqIi75kMI2Nh4wsDY6AGA=;
        b=J7A03fcq6bX5nWDXODfrfwoyuUGPjfa7chFuRo2TPD+7goaB40SBkbW4Xto5jkU4xX
         C8H1omZlj6UlASwls0BrHY9UEfZn7NU255trKjja3Hi/JlLbuBXthlV9UD/mT2IkqHg4
         9zvUqWbMGuXnYbnKY+xtQfQNQUQykwJG7L6t0jjaSSa0Ap7XxP8AO/DZj+UTc7Z5Fli/
         i7o389nArRNR4GqU4ofkA8aHGlhKF+xh8Adg15p/zYQmvaBB6X/p9qOv3Ygcbn4L9FD8
         p+zdZGAdzHexHUThpwYH5YVpL+2alakEqKGD7WPiGU6w8eSK/QVRTim47zKCCrvAn15y
         BOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=otoclXzkeEyh1j5woX95Y4BqIi75kMI2Nh4wsDY6AGA=;
        b=gL2zOjbVGI5uqPqTdTHQ6iVcmZxR2D+PDxgRCDRlbkPtU4DDzxmQviIfTWzW/XQd9L
         sBO8sceL0YL+NqN4YYEoBhF29F6mCBlvqCh5llJsvIgj7nY5FIcq+Zr4Cmsmepjp9jOh
         8GRzmIIvohcvCfX3FlvDc75h8AFFNgKXfBJ6ZY3gTSMMoBlAG9jzF/ot9Njk1WlxWRr6
         LE3Zkh4XwPdJeIBmeoH660nZ+qg28cmHhVwylTa5tBVpEVG+k/qmRIbsdkEztZwGj19f
         V66oy5TQ/5G/AQyLjdH2yGQLWO4/XqALb3MFK7f/1sUKCP7ys++KksZFx7+QFUvIP/a4
         cyXg==
X-Gm-Message-State: AOAM532h+KrqoDGiQgiRjwyBr3dGFNPZ2DB2Fia02hEBYoV9wGQ79nki
        TJexGo29QJRIAcPg6xz4gQh+LT70osGtBmr+dZbDjw==
X-Google-Smtp-Source: ABdhPJxZtjAMA83btV+BO9F4/YYS/EF5aCSpX1bcziNEwxakUBREbdF/05VAQ5f5ze/rU14PN/ocF642baXn5FVE/HE=
X-Received: by 2002:a92:870f:: with SMTP id m15mr4804880ild.2.1631463723915;
 Sun, 12 Sep 2021 09:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210910232249.739661-1-irogers@google.com> <YTz3YFXpJ0UT3R7z@kernel.org>
 <YTz8DL1Nuwp+XmzE@kernel.org>
In-Reply-To: <YTz8DL1Nuwp+XmzE@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 12 Sep 2021 09:21:51 -0700
Message-ID: <CAP-5=fVQ7Y1XUmUx74D4ipX59yWGWAi62SdybsQT6OFhhPRr_w@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Ignore Documentation dependency file
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Sep 11, 2021 at 11:57 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Sat, Sep 11, 2021 at 03:37:20PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Sep 10, 2021 at 04:22:49PM -0700, Ian Rogers escreveu:
> > > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > Fixes: a81df63a5df3 ("perf doc: Fix doc.dep")
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Thanks for the patch, but you forgot to mention _why_ we should ignore
> > that file, I'll try to figure out.
>
> Added this, probably anodine, but better than nothing :-)
>
> ---
> When building directly on the checked out repository the build process
> produces a file that should be ignored, so add it to .gitignore.
> ---

Sounds good to me.

Thanks,
Ian

> - Arnaldo
> >
> > > ---
> > >  tools/perf/.gitignore | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
> > > index e555e9729758..8e0163b7ef01 100644
> > > --- a/tools/perf/.gitignore
> > > +++ b/tools/perf/.gitignore
> > > @@ -39,3 +39,4 @@ pmu-events/jevents
> > >  feature/
> > >  fixdep
> > >  libtraceevent-dynamic-list
> > > +Documentation/doc.dep
> > > --
> > > 2.33.0.309.g3052b89438-goog
> >
> > --
> >
> > - Arnaldo
>
> --
>
> - Arnaldo
