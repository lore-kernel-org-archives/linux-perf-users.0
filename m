Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC3EC432BE
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 Aug 2021 16:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A571960F42
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 Aug 2021 16:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbhHYQsb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 Aug 2021 12:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbhHYQsb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Aug 2021 12:48:31 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D75DC061757
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Aug 2021 09:47:45 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id e186so31700677iof.12
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Aug 2021 09:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1FgyeDNXu+SPwDid8GWI1y2chMLMfaZqunjLEeYGHH8=;
        b=SHTwtUM0ppNJvbmpNeRtCSTC/mAeiMvLZgmCdj2Q914GBFYKPtoNbvbMUeECUCqWxo
         FRtkkhCdimxfCXrcw2bfjPd7BHnMTd0CuiV6+910CGU4kTL1aqcp61l2m1Wt4N2BHdYl
         FLRkHiYr8rbSTLUtwc8GnPeXRveDTJLjffFcB5IKaDo1ZtvAm5xTAYGAy8sqL0Kr6cRc
         ZAP7tXIdRuGQq8dsuGgdp0HUOt3vHyMN8rXmk6r/5tMePYjXHe20R3fYSNMe7OpULESb
         APBahW1wpJnRs3oqdEsgBXYcGDsAmyavxgWioIGy4g4sLBzVBqyL8ogaIOmWGqci9wtc
         xZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1FgyeDNXu+SPwDid8GWI1y2chMLMfaZqunjLEeYGHH8=;
        b=tSuXsy1NZNBYP+FWQa3cTJp5sIXDLmhUMR/XWWQ623T5pPo6v98ec0hkNl3Tc3Pc1P
         BQs9Hvk+bQ9CGCxkswFX8mtQ+B9eRVqP4BCoisEXzzhCh2GRcaEo0GHIXYpSIunJJAR4
         L71QYEESosCinS4fHhgB8z7f3xkrEvLeGuGmlmr89Cyi4IGEljMkNMZrgVNeUVY4x6eB
         005OY3wCo/w7G5FCColb/XGdZYUDqCwGMvrr7YNOxAoN3UfuSfCY3OXMHS15QVfujr1O
         WZ2fSYt+o3EGwtTfrWK+C8BE+OCOO4MV2CcM9cj6fF+l/zqp/Lcm0X+129HBdUQnBgbK
         egSQ==
X-Gm-Message-State: AOAM530Q7b3sPmi+L6OK9J62qU2W0Zn875RUsxJ/2bFl4YWw64IRxmmf
        3flvWO+ZIJhSaSDsvAnMKbExSwxlprwYQVjdUDngXw==
X-Google-Smtp-Source: ABdhPJwp+248KVpk9Gq2H08Xfq9HwzVS4o7/0gHR8oGjZuRZ0GOtGj84Br4dHPPEBQc5A09I2DVnVY2Wj5GIBOEXqQc=
X-Received: by 2002:a05:6638:349e:: with SMTP id t30mr36355574jal.142.1629910064685;
 Wed, 25 Aug 2021 09:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <2e52bc21-8e60-f1fc-804b-d8993ca7c482@huawei.com>
 <CAP-5=fXqM4Y5R5BXJb9Caf8NO1Oyz+qFaote3AqFu0MDGCvgAQ@mail.gmail.com> <e6157b05-fadd-b15d-17cf-9d964517da9c@huawei.com>
In-Reply-To: <e6157b05-fadd-b15d-17cf-9d964517da9c@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 25 Aug 2021 09:47:32 -0700
Message-ID: <CAP-5=fW4dWDH+=VLWc0jjRBDrU2qGQh9aUXhVp-Mvdme2HZrLA@mail.gmail.com>
Subject: Re: [Question] perf tools: lex parsing issue
To:     John Garry <john.garry@huawei.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Aug 25, 2021 at 7:32 AM John Garry <john.garry@huawei.com> wrote:
>
> On 25/08/2021 01:13, Ian Rogers wrote:
>
> Thanks for getting back to me
>
>
> >> + if (term->type_term == PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD) {
> >> +       term->config = strdup("period");
> >> + }
> >> +
> >> if (!head) {
> >>          parse_events_term__delete(term);
> >>          YYABORT;
> >> --
> >>
> >> ----8-----
> > Agreed this is hacky,
>
> This might be a *bit* better:
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index e5eae23cfceb..e597beaaa179 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1058,6 +1058,13 @@ static const char
> *config_term_names[__PARSE_EVENTS__TERM_TYPE_NR] = {
>         [PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE]       = "aux-sample-size",
>   };
>
> +const char * get_config_term(int term_type)
> +{
> +       if (term_type >= __PARSE_EVENTS__TERM_TYPE_NR)
> +               return "";
> +       return config_term_names[term_type];
> +}
> +
>   static bool config_term_shrinked;
>
>   static bool
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index bf6e41aa9b6a..0f658732535f 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -90,6 +90,8 @@ enum {
>         __PARSE_EVENTS__TERM_TYPE_NR,
>   };
>
> +const char *get_config_term(int term_type);
> +
>   struct parse_events_array {
>         size_t nr_ranges;
>         struct {
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index 9321bd0e2f76..8d6d3fae226d 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -832,8 +832,9 @@ PE_TERM '=' PE_NAME
>   PE_TERM '=' PE_VALUE
>   {
>         struct parse_events_term *term;
> +       char *config = strdup(get_config_term($1));
>
> -       ABORT_ON(parse_events_term__num(&term, (int)$1, NULL, $3, false, &@1,
> &@3));
> +       ABORT_ON(parse_events_term__num(&term, (int)$1, config, $3, false,
> &@1, &@3));
>         $$ = term;
>   }
>
>
> > I think it'd be better to fix this up in the
> > output. For example:
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 6cdbee8a12e7..c77c42275efa 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -365,15 +365,21 @@ static int __perf_pmu__new_alias(struct
> > list_head *list, char *dir, char *name,
> >          memset(newval, 0, sizeof(newval));
> >          ret = 0;
> >          list_for_each_entry(term, &alias->terms, list) {
> > +               const char * config = term->config;
> > +
> >                  if (ret)
> >                          ret += scnprintf(newval + ret, sizeof(newval) - ret,
> >                                           ",");
> > +               if (!config) {
> > +                       /* Note: config_term_names in parse_events.c
> > isn't accessible */
> > +                       config = config_term_names[term->type_term];
>
> We could just expose some parse-events.c API, like above.
>
> > +               }
> >                  if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
> >                          ret += scnprintf(newval + ret, sizeof(newval) - ret,
> > -                                        "%s=%#x", term->config, term->val.num);
> > +                                        "%s=%#x", config, term->val.num);
> >                  else if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
> >                          ret += scnprintf(newval + ret, sizeof(newval) - ret,
> > -                                        "%s=%s", term->config, term->val.str);
> > +                                        "%s=%s", config, term->val.str);
> >          }
> >
> >          alias->name = strdup(name);
>
> But how about this alternative simple one:
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index e5eae23cfceb..9e5df934d22d 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -3084,7 +3084,7 @@ int parse_events_term__num(struct
> parse_events_term **term,
>         struct parse_events_term temp = {
>                 .type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
>                 .type_term = type_term,
> -               .config    = config,
> +               .config    = config ? : strdup(config_term_names[type_term]),
>                 .no_value  = no_value,
>                 .err_term  = loc_term ? loc_term->first_column : 0,
>                 .err_val   = loc_val  ? loc_val->first_column  : 0,
> --

If you have this change isn't the change to parse_events_term__num()
unnecessary? This 1 liner fix looks good to me.

Thanks,
Ian

> >
> > It looks like a similar fix is needed in format_alias.
>
> And the change in parse_events_term__num(), above, seems to resolve that.
>
> Previously we would have something like these in format_alias():
>
> buf=i915/bcs0-busy, pmu name=i915, alias->name=bcs0-busy ->str=(null)=0x1000
>
> And now:
>
> buf=i915/bcs0-busy, pmu name=i915, alias->name=bcs0-busy ->str=config=0x1000
>
>
> Thoughts?
>
> Thanks,
> John
>
