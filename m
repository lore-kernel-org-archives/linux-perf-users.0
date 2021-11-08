Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C661C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 21:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D526A611C0
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 21:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240137AbhKHV0u (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 16:26:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56133 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240132AbhKHV0u (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 16:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636406645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CuxsvYIzJHSasluwKsqZGK7YqsHO70z8NS1grVlrrX4=;
        b=QNkVDV5gKLRzxdth+p7fpT3VKy7GUOD0iXu/QvHE2JsIu/XduOJj31WnG3CmayBpYXn1vR
        CVolLsgz3UpPoYUzLLdZMxSLOJBTDBWF8PQwBzucBIi24ru7AFWQr9DR99iHuArBl9F+eG
        klQCMsy53go2NY7MvZfXjV4bvTiucU0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-HF9-Z1zjNOCYPHDbyaatOw-1; Mon, 08 Nov 2021 16:24:04 -0500
X-MC-Unique: HF9-Z1zjNOCYPHDbyaatOw-1
Received: by mail-ed1-f72.google.com with SMTP id w12-20020aa7da4c000000b003e28acbf765so16026305eds.6
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 13:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CuxsvYIzJHSasluwKsqZGK7YqsHO70z8NS1grVlrrX4=;
        b=R38yqijmxvNSkFCYuKFmsVfYV+NER6R75lCe0ibt9+cHZQ3GIx+zBBsyR3cp1/V7OV
         +x3Wi3TXGuJ4go8og8b6Si0+R/PYZeQX8UDx3MQGPE+3jtfdSKMkk8GLMyeHr3fQKb4x
         1JqpIipADqZhNN5OyvFyMkUbKvcnlRk+bExDhwFquBl57jpPCK7VVhyMKo5x2hjFzK0x
         O9Fj0v3+bwaJ/M+V1aJqgl0NbHQO2lFPMm/G+WbydEWhJwVAySWhrWhaGNBrzHRLWcrP
         b/WJCtBEBK4IlxyGUh8sX5ny8ep2I8rBrYxkxfUq292fkr9B91Q2dgBv+2zyJefa1NHO
         XHHA==
X-Gm-Message-State: AOAM531IvclppIeTEcfUnykEjULuAvjHuzOKWS8gIEhcLX1HA1tjsgXR
        mFRDBSt2x09wUgSez7ETvEbcxX7jxdy1lFnLc1OJU+6ucp4/J5tPrGzPVRLTrIuOP+lCQ/0/8q5
        mXStzOC3ILFkPu/cge6LH9X0dbXurJw==
X-Received: by 2002:a17:906:1249:: with SMTP id u9mr2978116eja.96.1636406642929;
        Mon, 08 Nov 2021 13:24:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+pBculdTdY9wGz6CCYRq8tfIXUMLO3S6feSx/FQtFLZO5Z1ooFZ76KQMamwU8ppk9tfCJ6w==
X-Received: by 2002:a17:906:1249:: with SMTP id u9mr2978089eja.96.1636406642729;
        Mon, 08 Nov 2021 13:24:02 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id bm2sm9895311edb.39.2021.11.08.13.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 13:24:02 -0800 (PST)
Date:   Mon, 8 Nov 2021 22:24:00 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 30/59] libperf: Move in struct parse_events_state
Message-ID: <YYmVcCNMFXOEl6IQ@krava>
References: <20211108133710.1352822-1-jolsa@kernel.org>
 <20211108133710.1352822-31-jolsa@kernel.org>
 <CAP-5=fWQtYizPSXw2NPLBhV-W-a=sK_aKC6HNSwNACGE0hUiGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWQtYizPSXw2NPLBhV-W-a=sK_aKC6HNSwNACGE0hUiGQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Nov 08, 2021 at 10:21:14AM -0800, Ian Rogers wrote:
> On Mon, Nov 8, 2021 at 5:40 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > Moving in struct parse_events_state to libperf
> > together with related structs.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../lib/perf/include/internal/parse-events.h  | 29 +++++++++++++++++++
> >  tools/perf/util/parse-events.h                | 28 ------------------
> >  2 files changed, 29 insertions(+), 28 deletions(-)
> >
> > diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
> > index 46f632efd71b..aff13afa08e1 100644
> > --- a/tools/lib/perf/include/internal/parse-events.h
> > +++ b/tools/lib/perf/include/internal/parse-events.h
> > @@ -5,6 +5,7 @@
> >  #include <linux/types.h>
> >  #include <linux/list.h>
> >  #include <unistd.h>
> > +#include <linux/perf_event.h>
> >
> >  struct event_symbol {
> >         const char      *symbol;
> > @@ -74,6 +75,34 @@ struct parse_events_term {
> >         bool weak;
> >  };
> >
> > +struct parse_events_error {
> > +       int   num_errors;       /* number of errors encountered */
> > +       int   idx;      /* index in the parsed string */
> > +       char *str;      /* string to display at the index */
> > +       char *help;     /* optional help string */
> > +       int   first_idx;/* as above, but for the first encountered error */
> > +       char *first_str;
> > +       char *first_help;
> > +};
> 
> Just to note that this will conflict with the patches in:
> https://lore.kernel.org/lkml/YYfyEcPfj5ct7w7Q@kernel.org/
> Which may mean a bit larger change.

right, thanks for heads up.. I'm ok with rebasing this on top of that
and other changes.. I did that many times already ;-)

jirka

> 
> Thanks,
> Ian
> 
> > +struct parse_events_ops {
> > +       struct perf_evsel* (*perf_evsel__new)(struct perf_event_attr *attr, int idx);
> > +       struct perf_evsel* (*perf_evsel__new_tp)(const char *sys, const char *name, int idx);
> > +};
> > +
> > +struct parse_events_state {
> > +       struct list_head           list;
> > +       int                        idx;
> > +       int                        nr_groups;
> > +       struct parse_events_error *error;
> > +       struct perf_evlist        *evlist;
> > +       struct list_head          *terms;
> > +       int                        stoken;
> > +       struct perf_pmu           *fake_pmu;
> > +       char                      *hybrid_pmu_name;
> > +       struct parse_events_ops   *ops;
> > +};
> > +
> >  int parse_events_term__num(struct parse_events_term **term,
> >                            int type_term, char *config, u64 num,
> >                            bool novalue,
> > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> > index 2f75e823124f..057b92778d17 100644
> > --- a/tools/perf/util/parse-events.h
> > +++ b/tools/perf/util/parse-events.h
> > @@ -61,34 +61,6 @@ struct perf_pmu_event_symbol {
> >         enum perf_pmu_event_symbol_type type;
> >  };
> >
> > -struct parse_events_error {
> > -       int   num_errors;       /* number of errors encountered */
> > -       int   idx;      /* index in the parsed string */
> > -       char *str;      /* string to display at the index */
> > -       char *help;     /* optional help string */
> > -       int   first_idx;/* as above, but for the first encountered error */
> > -       char *first_str;
> > -       char *first_help;
> > -};
> > -
> > -struct parse_events_ops {
> > -       struct perf_evsel* (*perf_evsel__new)(struct perf_event_attr *attr, int idx);
> > -       struct perf_evsel* (*perf_evsel__new_tp)(const char *sys, const char *name, int idx);
> > -};
> > -
> > -struct parse_events_state {
> > -       struct list_head           list;
> > -       int                        idx;
> > -       int                        nr_groups;
> > -       struct parse_events_error *error;
> > -       struct perf_evlist        *evlist;
> > -       struct list_head          *terms;
> > -       int                        stoken;
> > -       struct perf_pmu           *fake_pmu;
> > -       char                      *hybrid_pmu_name;
> > -       struct parse_events_ops   *ops;
> > -};
> > -
> >  void parse_events__handle_error(struct parse_events_error *err, int idx,
> >                                 char *str, char *help);
> >  void parse_events__shrink_config_terms(void);
> > --
> > 2.31.1
> >
> 

