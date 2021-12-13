Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B1CC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Dec 2021 16:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240509AbhLMQL7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Dec 2021 11:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240593AbhLMQL5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Dec 2021 11:11:57 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36023C061574
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Dec 2021 08:11:57 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id m12so2521016ild.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Dec 2021 08:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GWZEvFuar9rN105nEC+aiw/ydL2RBtp76S79ck0h82E=;
        b=o0PDk65VJg7zIfkIafamReiLcsf3Pebser72g/jI4vXeBBE017j+eMW4nXD0GRsIuK
         mtiVAPJtb4fIRuFusxRTONW6NJIKsscth4NMs+JxOp7EO1xXELTgnjy0k8amKMpU9awP
         l6H1s3dhZT2UpCG6J8I49ePRQqbK2pNFElxenc/kcpecNCZZGkMO6uyC65Mug4fKRx4V
         lXoAy4lnWInoilZ37/TFud5N/htbGRyx/mo03blRAqFXYLDjP6kmUrbflV0rrl0IOY1w
         FRFQo/reHAQ2LF215vHE+FeTT/k5TkRzbHpZStGLp9ZfMG/uYS2aGDKXJrZ+8TOf1UjG
         1gnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GWZEvFuar9rN105nEC+aiw/ydL2RBtp76S79ck0h82E=;
        b=JFzlZTigRduLV1ONtBrQsUAgXu0hKT2YLcrAfZwikefp1mndoFteqg6w8B0uvsssJ4
         Bh4MNzk/pi+HedqyyjJ9GxAbFkhXhoPJOWiaR6lyzii6iNXDUmtVZA+QHhkDxpWJeF4p
         IB2/gJj8nkt9VcQMABUWX7vuvjM66buZRvzo27/kO34UuZklm0ReXL7I4PYaCbG0JoED
         nIp6GuA+i5zOexRF1TGXc/gi1F2kIM//HopESORqpsZ0grgoj5ju8Vycxn1u5hQVdlep
         CrNxPLTIrYitIdpHsoBmaiTQ5cgfxDYgTawDjKxfMeI8dUpzCw66czjFYFMkWSUj6Rsa
         a5xA==
X-Gm-Message-State: AOAM533r6PGvNHUaB2J+TDnP524EhMDxkCHOWVRp1fGhBN1rlIHUEjhR
        s2wCoYDw2eegcq4fr60upIlEEDLRJjbWTjebhtVgkQ==
X-Google-Smtp-Source: ABdhPJy2kmLpJTHaTFfVt4wg/dvac+Oj1qYrg+RBsMJiJrDgT1spIieIP9CENP91Xyvli29ipWu2zzWtuk9yux3421o=
X-Received: by 2002:a05:6e02:168a:: with SMTP id f10mr8997823ila.2.1639411916494;
 Mon, 13 Dec 2021 08:11:56 -0800 (PST)
MIME-Version: 1.0
References: <20211208024607.1784932-1-irogers@google.com> <20211208024607.1784932-22-irogers@google.com>
 <YbT6/kEmnAmkxrJC@krava>
In-Reply-To: <YbT6/kEmnAmkxrJC@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Dec 2021 08:11:44 -0800
Message-ID: <CAP-5=fUKEo_JVX+L=Momk_ES8npR=K+reswph-gRwLW0Om1_qw@mail.gmail.com>
Subject: Re: [PATCH 21/22] perf cpumap: Trim the cpu_aggr_map
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Dec 11, 2021 at 11:24 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Dec 07, 2021 at 06:46:06PM -0800, Ian Rogers wrote:
> > cpu_aggr_map__new removes duplicates, when this happens shrink the
> > array.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/cpumap.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> > index 8a72ee996722..985c87f1f1ca 100644
> > --- a/tools/perf/util/cpumap.c
> > +++ b/tools/perf/util/cpumap.c
> > @@ -185,7 +185,12 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
> >                       c->nr++;
> >               }
> >       }
> > -
> > +     /* Trim. */
> > +     if (c->nr != cpus->nr) {
> > +             c = realloc(c, sizeof(struct cpu_aggr_map) + sizeof(struct aggr_cpu_id) * c->nr);
> > +             if (!c)
> > +                     return NULL;
> > +     }
>
> curious.. we should do this, but did you detect some big waste in here?

No real size implications, but I was after coaxing address sanitizer
into detecting potential index out of bounds problems.

Thanks,
Ian

> thanks,
> jirka
>
> >       /* ensure we process id in increasing order */
> >       qsort(c->map, c->nr, sizeof(struct aggr_cpu_id), aggr_cpu_id__cmp);
> >
> > --
> > 2.34.1.400.ga245620fadb-goog
> >
>
