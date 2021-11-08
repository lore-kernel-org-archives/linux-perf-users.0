Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495D3C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 21:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 208CE619E2
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 21:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239936AbhKHVTO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 16:19:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29101 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239881AbhKHVTO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 16:19:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636406189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q9r71wIICgSkB0vp0MEBS7D/D9sBjzK8vhl0PJkIfnU=;
        b=Hf8zWZQc4xtAOS0T63C1ztm/N1/pnR2UvoOt+3ys2dXFxrarPVr4Hf28N/DLlw7seWMD6w
        jW9W8HNMilAKJs01nQUs7o+9bI7fqep1Q8y0Aa2KXTVxf+k3rF3yIflT55jqlsTyx3MbHc
        7sjEHXLkq1SrlhxBMeyp802jukOBqa0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-87PFZXiuMtGTX6kZgFioaQ-1; Mon, 08 Nov 2021 16:16:28 -0500
X-MC-Unique: 87PFZXiuMtGTX6kZgFioaQ-1
Received: by mail-ed1-f71.google.com with SMTP id f20-20020a0564021e9400b003e2ad3eae74so15995461edf.5
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 13:16:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q9r71wIICgSkB0vp0MEBS7D/D9sBjzK8vhl0PJkIfnU=;
        b=s3/IRAqw1Yt5VmGuY5GWhiQ/VpCx2sSXpfLOnzEZeZGu9R52e1bGS13Z2vnANT8aGY
         0sbQg5ZCr+RvxeHax7X5/OpWAu/juXYNMdzvTce9J1tBD5s7uHVQyry2tBjVbjU7TbU1
         RvHMcyLYy+4czfFVXGl9SKIYXWjyl4GbJj9RtxZV2xcXWv5w1xKwbq/aX7o0eeQEQVS2
         itlAATAET7IuNFnKRgojU7hEH4j0XHz9tG29+UtSm7CjlR6eTQ/NVIWPOQfYXmaoi+4W
         rA6xz9c50zEFig0Fk5nWxijtjgz0UbZpkpo5vIgcGo6e27AVE9pOEBKeu/7CkqWwGwWw
         7WVg==
X-Gm-Message-State: AOAM532seL+LRDa4lwoFZKcSOiPCbUg8YHJYU78r/SfHCyxZzKbG1LD7
        xnu1dyWPzasxkL+tFvz5iww4IpJKU80hoT4IdOS9s4JJDNhrWAexwkOJMEiPEEsAh3vAr/HmMb6
        BcCO+xj8Y5jJ9CqICGSP7K/GuCU12qw==
X-Received: by 2002:a17:906:90da:: with SMTP id v26mr2855649ejw.442.1636406186833;
        Mon, 08 Nov 2021 13:16:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJztnXt65/ZEfBnPStyvMoBGHfERxoJiZ24fA6yg0ddF23fj+tAFooHRZa9dj2+KAjrvtXS9UQ==
X-Received: by 2002:a17:906:90da:: with SMTP id v26mr2855619ejw.442.1636406186633;
        Mon, 08 Nov 2021 13:16:26 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id eg33sm9844861edb.77.2021.11.08.13.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 13:16:26 -0800 (PST)
Date:   Mon, 8 Nov 2021 22:16:24 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 13/59] libperf: Move exclude_GH to perf_evsel
Message-ID: <YYmTqO/YovsBcELX@krava>
References: <20211108133710.1352822-1-jolsa@kernel.org>
 <20211108133710.1352822-14-jolsa@kernel.org>
 <CAP-5=fVcHtPxS01GJCazeJmF-Jnx07qGAcPpNwM2ocyV7yu63g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVcHtPxS01GJCazeJmF-Jnx07qGAcPpNwM2ocyV7yu63g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Nov 08, 2021 at 09:53:44AM -0800, Ian Rogers wrote:
> On Mon, Nov 8, 2021 at 5:38 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > Moving exclude_GH to perf_evsel struct.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/perf/include/internal/evsel.h | 1 +
> >  tools/perf/util/evsel.c                 | 2 +-
> >  tools/perf/util/evsel.h                 | 1 -
> >  tools/perf/util/parse-events.c          | 4 ++--
> >  4 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
> > index b96c9f4808ca..7f3ee73c5aa5 100644
> > --- a/tools/lib/perf/include/internal/evsel.h
> > +++ b/tools/lib/perf/include/internal/evsel.h
> > @@ -69,6 +69,7 @@ struct perf_evsel {
> >                 const char              *metric_id;
> >                 enum perf_tool_event    tool_event;
> >                 const char              *unit;
> > +               int                     exclude_GH;
> 
> I think it'd be pretty awesome if when these things get moved around
> we added a comment here to explain what the variable means. Perhaps
> even put an example :-) In this case it could explain why this is an
> int and not a bool. This is a while you are here request rather than a
> criticism of the changes which I find fine.

ok, I noticed you added several comments like that already,
I'll put some in here in next version

thanks,
jirka

> 
> Thanks,
> Ian
> 
> >         };
> >  };
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 133b571e1190..802c7de9e8e3 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -431,7 +431,7 @@ struct evsel *evsel__clone(struct evsel *orig)
> >         evsel->use_uncore_alias = orig->use_uncore_alias;
> >         evsel->is_libpfm_event = orig->is_libpfm_event;
> >
> > -       evsel->exclude_GH = orig->exclude_GH;
> > +       evsel->core.exclude_GH = orig->core.exclude_GH;
> >         evsel->sample_read = orig->sample_read;
> >         evsel->core.auto_merge_stats = orig->core.auto_merge_stats;
> >         evsel->collect_stat = orig->collect_stat;
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index f6cc1e78903f..6c3634ed169a 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -62,7 +62,6 @@ struct evsel {
> >                 double                  scale;
> >                 struct cgroup           *cgrp;
> >                 /* parse modifier helper */
> > -               int                     exclude_GH;
> >                 int                     sample_read;
> >                 bool                    snapshot;
> >                 bool                    per_pkg;
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index 1878ea1310d3..89787ebc23ef 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1918,7 +1918,7 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
> >         int exclusive = evsel ? evsel->core.attr.exclusive : 0;
> >
> >         int exclude = eu | ek | eh;
> > -       int exclude_GH = evsel ? evsel->exclude_GH : 0;
> > +       int exclude_GH = evsel ? evsel->core.exclude_GH : 0;
> >         int weak = 0;
> >         int bpf_counter = 0;
> >
> > @@ -2049,7 +2049,7 @@ int parse_events__modifier_event(struct list_head *list, char *str, bool add)
> >                 evsel->core.attr.exclude_host   = mod.eH;
> >                 evsel->core.attr.exclude_guest  = mod.eG;
> >                 evsel->core.attr.exclude_idle   = mod.eI;
> > -               evsel->exclude_GH          = mod.exclude_GH;
> > +               evsel->core.exclude_GH          = mod.exclude_GH;
> >                 evsel->sample_read         = mod.sample_read;
> >                 evsel->precise_max         = mod.precise_max;
> >                 evsel->weak_group          = mod.weak;
> > --
> > 2.31.1
> >
> 

