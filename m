Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91195C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 21:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76E8761361
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 21:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238871AbhKHV1l (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 16:27:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36248 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240209AbhKHV1l (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 16:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636406696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kaoNyHE3puJvLcC/DzVmgRmeHaZoVpU0y3ia0s2BUQE=;
        b=cuCKhJ5Hn+8OUpwTSWvWw1yOWLK6hl1HMiO7Sw/yHXw1OEbLMAm9RgVY7r3l5Nxd6p4MAV
        w/Nw/WFj8FCal0lWxY3YHOqmvrLVKcUzUw6QQrZINujjuuz2TfI+/bwsBuJzY5XFgysyM4
        OqV32/ifagwLN+f1shAVeNk+p/o9n6Q=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-hcVVGo97MiuC9uV8SCXIdw-1; Mon, 08 Nov 2021 16:24:54 -0500
X-MC-Unique: hcVVGo97MiuC9uV8SCXIdw-1
Received: by mail-ed1-f71.google.com with SMTP id w12-20020a056402268c00b003e2ab5a3370so16055526edd.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 13:24:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kaoNyHE3puJvLcC/DzVmgRmeHaZoVpU0y3ia0s2BUQE=;
        b=47ZUWw3UzBrAUVLwSRhBErdmMqvwSJOopwOEU2MtcjjlrrHo4l2Vyn3F6s3ZDcmGM/
         AMn5k5yInQ7TGXRBPAZQtHkoeuWamR4y4jEESXkBLuXOF7VA1ccEVaGnsKMadLnKBHUy
         dwogbKpHmaEGimwLEPr6grztBTS69fbZv7/HZygyUsrpM8TKi+FjCEfTkeWjdVRM+py8
         UPOmD4k2XOqwn4QR1yz1lUTIQV2jWTBc2rGBoigUIAinAhGSig7iI/LqTAypu4AWWBDI
         PkAWIClfIpkJoPz2y8otNe93xvfb9m0Ma2VqEIiC23sCreT5r0Om2pjb2p2f9xa22/jl
         gE+g==
X-Gm-Message-State: AOAM5330S1Z3Z8gXSB3TyHMP/TUSyvoPPbc8pqG0uXau/6/MF0OezdjZ
        eTk7huuJ7PkmPkpWuibyInsUfrW9oqEVQDDQjoGFUZxnDZl+CdzSQfmDUoY6oLEMsh7S42+tB0E
        tlLzS+48idGJGEmnx1BpYdHql9Yu4Ew==
X-Received: by 2002:a17:906:15d0:: with SMTP id l16mr2904016ejd.462.1636406693341;
        Mon, 08 Nov 2021 13:24:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJydpdXxT3lwtjsekF7bKg2n0cSuiuoyQ7M00ZTcXHEGokafzMY+YtbR8b7i++q/yeeEYBJ6Ew==
X-Received: by 2002:a17:906:15d0:: with SMTP id l16mr2903983ejd.462.1636406693102;
        Mon, 08 Nov 2021 13:24:53 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id ga1sm8847438ejc.40.2021.11.08.13.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 13:24:52 -0800 (PST)
Date:   Mon, 8 Nov 2021 22:24:51 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 42/59] libperf: Move in parse_events_name function
Message-ID: <YYmVoyPAk2DEnN4o@krava>
References: <20211108133710.1352822-1-jolsa@kernel.org>
 <20211108133710.1352822-43-jolsa@kernel.org>
 <CAP-5=fVE+YswCCeAYEtA85u9ggZZ59o_-ONn2W31rWV24fpWQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVE+YswCCeAYEtA85u9ggZZ59o_-ONn2W31rWV24fpWQQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Nov 08, 2021 at 10:23:59AM -0800, Ian Rogers wrote:
> On Mon, Nov 8, 2021 at 5:41 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > Moving parse_events_name function to libperf.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/perf/include/internal/parse-events.h |  1 +
> >  tools/lib/perf/parse-events.c                  | 12 ++++++++++++
> >  tools/perf/util/parse-events.c                 | 12 ------------
> >  tools/perf/util/parse-events.h                 |  1 -
> >  4 files changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
> > index 1d7ee03b8a80..11a85a118480 100644
> > --- a/tools/lib/perf/include/internal/parse-events.h
> > +++ b/tools/lib/perf/include/internal/parse-events.h
> > @@ -137,4 +137,5 @@ void parse_events__handle_error(struct parse_events_error *err, int idx,
> >                                 char *str, char *help);
> >  void parse_events_evlist_error(struct parse_events_state *parse_state,
> >                                int idx, const char *str);
> > +int parse_events_name(struct list_head *list, const char *name);
> >  #endif /* __LIBPERF_PARSE_EVENTS_H */
> > diff --git a/tools/lib/perf/parse-events.c b/tools/lib/perf/parse-events.c
> > index 07c89a3601b1..6efc2bb73cdf 100644
> > --- a/tools/lib/perf/parse-events.c
> > +++ b/tools/lib/perf/parse-events.c
> > @@ -580,3 +580,15 @@ void parse_events_evlist_error(struct parse_events_state *parse_state,
> >
> >         parse_events__handle_error(parse_state->error, idx, strdup(str), NULL);
> >  }
> > +
> > +int parse_events_name(struct list_head *list, const char *name)
> > +{
> > +       struct perf_evsel *evsel;
> > +
> > +       __perf_evlist__for_each_entry(list, evsel) {
> > +               if (!evsel->name)
> > +                       evsel->name = strdup(name);
> 
> It is a pre-existing problem but there should probably be an ENOMEM check here.

and we even return int.. thanks for noticing, will fix

jirka

> 
> Thanks,
> Ian
> 
> > +       }
> > +
> > +       return 0;
> > +}
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index 0f2bf2b48888..1469bdf88f2b 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1721,18 +1721,6 @@ void parse_events__set_leader(char *name, struct list_head *list,
> >         leader->core.group_name = name ? strdup(name) : NULL;
> >  }
> >
> > -int parse_events_name(struct list_head *list, const char *name)
> > -{
> > -       struct evsel *evsel;
> > -
> > -       __evlist__for_each_entry(list, evsel) {
> > -               if (!evsel->core.name)
> > -                       evsel->core.name = strdup(name);
> > -       }
> > -
> > -       return 0;
> > -}
> > -
> >  static int
> >  comp_pmu(const void *p1, const void *p2)
> >  {
> > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> > index cc7c6449d423..5530614e7a10 100644
> > --- a/tools/perf/util/parse-events.h
> > +++ b/tools/perf/util/parse-events.h
> > @@ -63,7 +63,6 @@ struct perf_pmu_event_symbol {
> >
> >  void parse_events__shrink_config_terms(void);
> >  void parse_events__clear_array(struct parse_events_array *a);
> > -int parse_events_name(struct list_head *list, const char *name);
> >  int parse_events_add_tracepoint(struct parse_events_state *parse_state,
> >                                 struct list_head *list,
> >                                 const char *sys, const char *event,
> > --
> > 2.31.1
> >
> 

