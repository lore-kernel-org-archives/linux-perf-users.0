Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE94C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Feb 2022 09:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbiBXJLX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbiBXJLO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Feb 2022 04:11:14 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED5B1B3714
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Feb 2022 01:10:38 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id w37so1215228pga.7
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Feb 2022 01:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vgz+DNy0VNpm44gwsOqUcOZ0+pKQ0dd8+5zMGXKsN7w=;
        b=Ne7KZLtzZmeT3iTDyHpjSoskCsyGdNWkx2FrCh9wyxseUEjDeM0HzZs+Q9OJCUwxJN
         VmErp+CX6tgeSZLfaHgC9IG8ezh4gOoWFW3fYaoFWo4076Rlh1XH6vwdtd4RtF71q7cz
         rJr8C85bNxwxrhzlq5WTT0p3rEg+of7xlH4gAU9hjEJtXYTyM02vGkG2Lq7TndeiLW79
         FcuP8SdhysK+AvELLfN+/mkoAHLwH/7Q1n3x2kogvS958dVR5kNl5HG1WJFOq8edX1xG
         IYv/C7IMwoT37FtEWsej1ANgV5vFEdWeHEj/yVKiL9rkLsDgII1yiunr6aGX4fRRTuts
         wP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vgz+DNy0VNpm44gwsOqUcOZ0+pKQ0dd8+5zMGXKsN7w=;
        b=haAP0um7gfAuik7flw8s3qv1uNFhL+Cc2XIqLdvSVnL2OchO5dpX9r/0mMTCrKO1Ct
         hkVfpZa5NqIGqb2OPw/IA0c6wXZTkod57rXop26Njrgb1txDypZeBUQL2oFJc2j2LioM
         izHXIDnJSx0BY4oRr7YykzNzDFUtMDzG7YqEZ+vjZPJ4ynSnTD43G/0x3trmBjSS13bh
         baNzgr3oSh66qeO8ruUdQdjjmjfyszW0/A5KZ5MYlVUUaKrhFA5oSQzvhGlDcIdOuOxv
         jNmcbXoLumZp5DKdjrP6IiAurZaOUhISPLjp71WjgJWTwywp47dWUxLd61UfHwW8PSc0
         bTqA==
X-Gm-Message-State: AOAM531i7G9FAlLtgpJwVESn8AkGkgGY11ZGO8d9GSp5dUTwUNYJ76yn
        0vCuIRv5iohex8FyDa6dm6K538ZNUSXkXUVzs68=
X-Google-Smtp-Source: ABdhPJwfsMk8KfVSLg9DZZ25CR8vRskIJIfetfE0w4EiUC72GOrjMycVtXu/QZARarDy/fL+n/Yhmp1qz8jBm12dUgs=
X-Received: by 2002:a05:6a00:8d1:b0:4c9:f1a0:e0d0 with SMTP id
 s17-20020a056a0008d100b004c9f1a0e0d0mr1841778pfu.53.1645693838244; Thu, 24
 Feb 2022 01:10:38 -0800 (PST)
MIME-Version: 1.0
References: <20220223131349.134897-1-tz.stoyanov@gmail.com>
 <YhY9p9wsYgXtdYnt@kernel.org> <YhZ651X4Fs9KJMa6@krava>
In-Reply-To: <YhZ651X4Fs9KJMa6@krava>
From:   Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Date:   Thu, 24 Feb 2022 11:10:22 +0200
Message-ID: <CAPpZLN5KYTZVTKz8NR3psSgwujzvNvw_cnXu+noDKfYjDQjjtA@mail.gmail.com>
Subject: Re: [PATCH] libperf: Fix read_size calculations
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Feb 23, 2022 at 8:20 PM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Wed, Feb 23, 2022 at 10:59:03AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Feb 23, 2022 at 03:13:49PM +0200, Tzvetomir Stoyanov (VMware) escreveu:
> > > Reading the counters from perf descriptor fails because of size
> > > mismatch when PERF_FORMAT_GROUP is set. The group count must include the
> > > parent and the count of siblings.
> >
> > Yeah, it should match the calculation done in the kernel, in
> > __perf_event_read_size(), that has...
> >
> > static void __perf_event_read_size(struct perf_event *event, int nr_siblings)
> > {
> >         int entry = sizeof(u64); /* value */
> >         int size = 0;
> >         int nr = 1;
> >
> >         if (event->attr.read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
> >                 size += sizeof(u64);
> >
> >         if (event->attr.read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
> >                 size += sizeof(u64);
> >
> >         if (event->attr.read_format & PERF_FORMAT_ID)
> >                 entry += sizeof(u64);
> >
> >         if (event->attr.read_format & PERF_FORMAT_GROUP) {
> >                 nr += nr_siblings;
> >                 size += sizeof(u64);
> >         }
> >
> >         size += entry * nr;
> >         event->read_size = size;
> > }
> >
> > So this bug has been with us since forever (well, 2017), so we need:
> >
> > Fixes: 5c30af92f2b1e9d8 ("libperf: Adopt perf_evsel__read() function from tools/perf")
> >
> > To fix it in libperf and probably:
> >
> > Fixes: de63403bfd14ae8d ("perf tools: Add perf_evsel__read_size function")
> >
> > To get this to stable kernels versions predating the move of this
> > function to libperf.
> >
> > Jiri?
> >
> > - Arnaldo
> >
> > > Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> > > ---
> > >  tools/lib/perf/evsel.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> > > index 210ea7c06ce8..4597a53c0152 100644
> > > --- a/tools/lib/perf/evsel.c
> > > +++ b/tools/lib/perf/evsel.c
> > > @@ -299,7 +299,7 @@ int perf_evsel__read_size(struct perf_evsel *evsel)
> > >             entry += sizeof(u64);
> > >
> > >     if (read_format & PERF_FORMAT_GROUP) {
> > > -           nr = evsel->nr_members;
> > > +           nr += evsel->nr_members;
>
> hum, I'll double check but AFAICS from tests/parse-events.c,
> nr_members already includes both parent (leader) and members,
> which is different from nr_siblings in kernel
>
> can you please provide more details?

You are right, I didn't call the perf_evlist__set_leader() API, that's
why the leader wasn't counted. When I call that API and revert this
patch, everything looks OK.
Thanks Jiri!

>
> thanks,
> jirka
>
> > >             size += sizeof(u64);
> > >     }
> > >
> > > --
> > > 2.34.1
> >
> > --
> >
> > - Arnaldo



-- 
Tzvetomir (Ceco) Stoyanov
VMware Open Source Technology Center
