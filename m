Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1A3C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 21:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 472B96112F
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 21:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbhKHVhO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 16:37:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20772 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240367AbhKHVhN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 16:37:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636407267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YL+rT9Wc1L5zv/olKcrRnksPiuxviTwe2FaTzCrp1n8=;
        b=auvK8yfrtUxvGKdXP84d3xwX5JrBADU7dcENPuDXReA2mo7QbQ5n+qQQNLsbZEQpkAMucJ
        tnKyl8zb4xDtGKPlpHmjz18osBdzT1vgoEtAHh1YAL74Z+YdX0o1EapkkQp9kjI3Gcg9Hd
        B7OMuhUN4p6iuZ94E3A0OO2HT1v3r44=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-tpnAM4tlMfmWmIGOJbr6EQ-1; Mon, 08 Nov 2021 16:34:26 -0500
X-MC-Unique: tpnAM4tlMfmWmIGOJbr6EQ-1
Received: by mail-ed1-f72.google.com with SMTP id v9-20020a50d849000000b003dcb31eabaaso16090053edj.13
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 13:34:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YL+rT9Wc1L5zv/olKcrRnksPiuxviTwe2FaTzCrp1n8=;
        b=oatT9xlK05F5V00KqBS5BuQkSSDshwLCXZHbDNBkkMP1Jm3w7vvIk/G/E1xhEZy8It
         prXjs3AxUjiPRbnMxgMr9VoN5DkrYLFwA9RRWTpM8tJHDTmJ0zdZd5SRlGzqa+ko258y
         P1jUIcBGmvfo96c4uC2sYuG6JYP2zFw1bKdSpahhS/oxaYSK4rcGOMKeNxj+y36QdXJ6
         rBiKj4EwX2FNI0NjaGfjemw09yyFRTeClNHWsgxb98n48DdRyuWmMcOQbPpQfe6UK1+H
         J6EaJIvq37ND90BGRUI6dElIOiH8mQSimmjxMugeBVSGPBFQAj+CTckUVwoLKpYHyI5z
         W6OA==
X-Gm-Message-State: AOAM5334yP0bUhEN0OI3k9QgJM0ieJ3mCICjPWTmp4XjRBW7vJKZct/d
        2RNh/7wT5mIJRPltInOscmW8uc4i7S3FUyCwmmZtlaFdVHCMXQeDz4SY/V9Dm8VBsmYR1exRZ5/
        rfuzZp6TE4FU3i636bKQXu/sbOvrmFA==
X-Received: by 2002:aa7:cb41:: with SMTP id w1mr2988780edt.327.1636407265270;
        Mon, 08 Nov 2021 13:34:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5d+3mJBNKo6cl5RGvbHwNmm8vN5IORJgx9QV51dGcQRH/GOz+gFc9cMr+X9T60eUQVsokoA==
X-Received: by 2002:aa7:cb41:: with SMTP id w1mr2988745edt.327.1636407265019;
        Mon, 08 Nov 2021 13:34:25 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id qk13sm5022306ejc.3.2021.11.08.13.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 13:34:24 -0800 (PST)
Date:   Mon, 8 Nov 2021 22:34:23 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 46/59] perf tools: Add add_numeric callback to struct
 parse_events_ops
Message-ID: <YYmX35S+QpbRFbOX@krava>
References: <20211108133710.1352822-1-jolsa@kernel.org>
 <20211108133710.1352822-47-jolsa@kernel.org>
 <CAP-5=fUZyxqJXDuH1kS7fVXy4osCfQGcv9d5yUwuLHjUZumo5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUZyxqJXDuH1kS7fVXy4osCfQGcv9d5yUwuLHjUZumo5g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Nov 08, 2021 at 10:27:10AM -0800, Ian Rogers wrote:
> On Mon, Nov 8, 2021 at 5:41 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > Adding add_numeric callback to struct parse_events_ops,
> > to allow custom numeric parsing code.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/perf/include/internal/parse-events.h |  5 +++++
> >  tools/perf/util/parse-events.c                 |  2 ++
> >  tools/perf/util/parse-events.h                 |  4 ----
> >  tools/perf/util/parse-events.y                 | 12 ++++++++----
> >  4 files changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
> > index 78dd3f989346..cbcf799f8969 100644
> > --- a/tools/lib/perf/include/internal/parse-events.h
> > +++ b/tools/lib/perf/include/internal/parse-events.h
> > @@ -102,6 +102,11 @@ struct parse_events_ops {
> >         int (*add_pmu_multi)(struct parse_events_state *parse_state,
> >                              char *str, struct list_head *head,
> >                              struct list_head **listp);
> > +
> > +       int (*add_numeric)(struct parse_events_state *parse_state,
> > +                          struct list_head *list,
> > +                          u32 type, u64 config,
> > +                          struct list_head *head_config);
> >  };
> >
> >  struct parse_events_state {
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index c67634c9de0d..a05e1bdb4e60 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1306,6 +1306,7 @@ int parse_events_add_tracepoint(struct parse_events_state *parse_state,
> >                                             err, head_config);
> >  }
> >
> > +static
> >  int parse_events_add_numeric(struct parse_events_state *parse_state,
> >                              struct list_head *list,
> >                              u32 type, u64 config,
> > @@ -2904,4 +2905,5 @@ static struct parse_events_ops parse_state_ops = {
> >         .perf_evsel__delete = perf_evsel__delete_helper,
> >         .add_pmu            = parse_events_add_pmu,
> >         .add_pmu_multi      = parse_events_multi_pmu_add,
> > +       .add_numeric        = parse_events_add_numeric,
> 
> Some documentation on the ops would be awesome :-) Especially as this
> is allowing configuration and it is not immediately clear what that
> could mean when changes happen.

so the ops are to help with perf specific code like 'evsel allocation
and one chicken and egg problem we have in event parsing

to move flex/bison code to libperf I need to move all functions called
from that code to libperf.. and some of those functions end up calling
parser again - the pmu_loopup for terms parsing, which is sharing
parser/flexer code with event parsing

having the ops allows us to keep this 'so far unmovable code' in perf
and move just the flexer/bison, which is the base for everything

I expect some of the callbacks will go away at the end, because the
code for them will be completely in libperf, so there would be no
need for special perf implementation

but yes, I'll put some docs on them

thanks,
jirka

> 
> Thanks,
> Ian
> 
> >  };
> > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> > index fa03f8f70f33..40d192cace03 100644
> > --- a/tools/perf/util/parse-events.h
> > +++ b/tools/perf/util/parse-events.h
> > @@ -79,10 +79,6 @@ int parse_events_load_bpf_obj(struct parse_events_state *parse_state,
> >                               struct list_head *list,
> >                               struct bpf_object *obj,
> >                               struct list_head *head_config);
> > -int parse_events_add_numeric(struct parse_events_state *parse_state,
> > -                            struct list_head *list,
> > -                            u32 type, u64 config,
> > -                            struct list_head *head_config);
> >  int parse_events_add_tool(struct parse_events_state *parse_state,
> >                           struct list_head *list,
> >                           int tool_event);
> > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> > index f903690b3c8a..b23691397374 100644
> > --- a/tools/perf/util/parse-events.y
> > +++ b/tools/perf/util/parse-events.y
> > @@ -436,6 +436,7 @@ PE_VALUE_SYM_SW
> >  event_legacy_symbol:
> >  value_sym '/' event_config '/'
> >  {
> > +       struct parse_events_state *parse_state = _parse_state;
> >         struct list_head *list;
> >         int type = $1 >> 16;
> >         int config = $1 & 255;
> > @@ -443,7 +444,7 @@ value_sym '/' event_config '/'
> >
> >         list = alloc_list();
> >         ABORT_ON(!list);
> > -       err = parse_events_add_numeric(_parse_state, list, type, config, $3);
> > +       err = parse_state->ops->add_numeric(parse_state, list, type, config, $3);
> >         parse_events_terms__delete($3);
> >         if (err) {
> >                 free_list_evsel(_parse_state, list);
> > @@ -454,13 +455,14 @@ value_sym '/' event_config '/'
> >  |
> >  value_sym sep_slash_slash_dc
> >  {
> > +       struct parse_events_state *parse_state = _parse_state;
> >         struct list_head *list;
> >         int type = $1 >> 16;
> >         int config = $1 & 255;
> >
> >         list = alloc_list();
> >         ABORT_ON(!list);
> > -       ABORT_ON(parse_events_add_numeric(_parse_state, list, type, config, NULL));
> > +       ABORT_ON(parse_state->ops->add_numeric(parse_state, list, type, config, NULL));
> >         $$ = list;
> >  }
> >  |
> > @@ -646,12 +648,13 @@ PE_NAME ':' PE_NAME
> >  event_legacy_numeric:
> >  PE_VALUE ':' PE_VALUE opt_event_config
> >  {
> > +       struct parse_events_state *parse_state = _parse_state;
> >         struct list_head *list;
> >         int err;
> >
> >         list = alloc_list();
> >         ABORT_ON(!list);
> > -       err = parse_events_add_numeric(_parse_state, list, (u32)$1, $3, $4);
> > +       err = parse_state->ops->add_numeric(_parse_state, list, (u32)$1, $3, $4);
> >         parse_events_terms__delete($4);
> >         if (err) {
> >                 free(list);
> > @@ -663,12 +666,13 @@ PE_VALUE ':' PE_VALUE opt_event_config
> >  event_legacy_raw:
> >  PE_RAW opt_event_config
> >  {
> > +       struct parse_events_state *parse_state = _parse_state;
> >         struct list_head *list;
> >         int err;
> >
> >         list = alloc_list();
> >         ABORT_ON(!list);
> > -       err = parse_events_add_numeric(_parse_state, list, PERF_TYPE_RAW, $1, $2);
> > +       err = parse_state->ops->add_numeric(_parse_state, list, PERF_TYPE_RAW, $1, $2);
> >         parse_events_terms__delete($2);
> >         if (err) {
> >                 free(list);
> > --
> > 2.31.1
> >
> 

