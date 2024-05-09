Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2974780632;
	Thu,  9 May 2024 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289852; cv=none; b=aQYknsOPLt694793JU/UCoxmpzJMc11x46M59C40iOr4FUiOrFnSe5oeHFS7+112EJxmMmyhsqt/rl0z4kv5PIfAttqvdSu/luW41KvJAznE1sg4XYDh9bHi2AmU66gJd4tMq4ElzazQU0Op17ZnzxOjUpHxOBKKmK4tkiWmrC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289852; c=relaxed/simple;
	bh=8l4i02fHZwUgQR0T4Cv/JbdYBuOYoD/Gitn8jMnH5bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSmOkHUARMFbWaf6qHRN7dcxnOln/20Gv7eUzKRxgqjKlwm8qE4Gy8JeVjbhC+ejJkYylGHbr7Y+yKZ5ogUXU/Cn9ugTxAa317D4RGVIIaJ2zrkdFK2ngSQ2oXYUBdqsGZVkzbnoPMb3YB4LF3+pfxseuyNSwrGaVGbwhXZ6zkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUGzm4Yj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUGzm4Yj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60891C116B1;
	Thu,  9 May 2024 21:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715289851;
	bh=8l4i02fHZwUgQR0T4Cv/JbdYBuOYoD/Gitn8jMnH5bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RUGzm4YjjqhfXzsgMidlEzQD4Gzj1y/k5l98J3fqXg4XF6Btdfp5OwRHslKOLI/kv
	 po8ODhHlWpak4SwoNlYx37XoKu98MP6T2U7UfZKbrACoQIONbDFc2eMNib5dKG3KyQ
	 FSF5uukwS2gaJevpb/hv6/ULJcqWCG4dj2vgTPlvdKdo7MyAI+H2ugyTtH529fXkWz
	 /mTXFL4ppYIQeeHxCJPIp5jdkjXkP/yQj8ndMA6A/gvL7U+YLUZstyHTNZO7QUXt23
	 eLPSAtJvDeXEpBuvQlYaucyjxz+trDbB6NaTHHA64iaLhRbA4mLfMbsSr6WTXMdIrZ
	 i6jKTVpc9SiAw==
Date: Thu, 9 May 2024 18:24:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>,
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] perf parse-events: pass parse_state to
 add_tracepoint
Message-ID: <Zj0--YbYSm-s9vRh@x1>
References: <20240505-perf_digit-v2-0-6ece307fdaad@codewreck.org>
 <20240505-perf_digit-v2-1-6ece307fdaad@codewreck.org>
 <CAP-5=fUmeyd3BR7njJEDQ-=qkpvLPMoQO-7De+3mqLaSOoZZxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUmeyd3BR7njJEDQ-=qkpvLPMoQO-7De+3mqLaSOoZZxw@mail.gmail.com>

On Wed, May 08, 2024 at 02:37:16PM -0700, Ian Rogers wrote:
> On Sun, May 5, 2024 at 4:14 AM Dominique Martinet
> <asmadeus@codewreck.org> wrote:
> >
> > The next patch will add another flag to parse_state that we will want to
> > pass to evsel__nwetp_idx(), so pass the whole parse_state all the way
> > down instead of giving only the index
> 
> Nit: evsel__newtp_idx typo
> Fwiw, I think the idx value is possibly something to be done away
> with. We renumber the evsels here:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/parse-events.c?h=perf-tools-next#n2077
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Fixed the typo.

- Arnaldo
 
> Thanks,
> Ian
> 
> > Originally-by: Jiri Olsa <jolsa@kernel.org>
> > Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> > ---
> >  tools/perf/util/parse-events.c | 31 ++++++++++++++++++-------------
> >  tools/perf/util/parse-events.h |  3 ++-
> >  tools/perf/util/parse-events.y |  2 +-
> >  3 files changed, 21 insertions(+), 15 deletions(-)
> >
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index 6f8b0fa17689..6e8cba03f0ac 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -519,13 +519,14 @@ static void tracepoint_error(struct parse_events_error *e, int err,
> >         parse_events_error__handle(e, column, strdup(str), strdup(help));
> >  }
> >
> > -static int add_tracepoint(struct list_head *list, int *idx,
> > +static int add_tracepoint(struct parse_events_state *parse_state,
> > +                         struct list_head *list,
> >                           const char *sys_name, const char *evt_name,
> >                           struct parse_events_error *err,
> >                           struct parse_events_terms *head_config, void *loc_)
> >  {
> >         YYLTYPE *loc = loc_;
> > -       struct evsel *evsel = evsel__newtp_idx(sys_name, evt_name, (*idx)++);
> > +       struct evsel *evsel = evsel__newtp_idx(sys_name, evt_name, parse_state->idx++);
> >
> >         if (IS_ERR(evsel)) {
> >                 tracepoint_error(err, PTR_ERR(evsel), sys_name, evt_name, loc->first_column);
> > @@ -544,7 +545,8 @@ static int add_tracepoint(struct list_head *list, int *idx,
> >         return 0;
> >  }
> >
> > -static int add_tracepoint_multi_event(struct list_head *list, int *idx,
> > +static int add_tracepoint_multi_event(struct parse_events_state *parse_state,
> > +                                     struct list_head *list,
> >                                       const char *sys_name, const char *evt_name,
> >                                       struct parse_events_error *err,
> >                                       struct parse_events_terms *head_config, YYLTYPE *loc)
> > @@ -578,7 +580,7 @@ static int add_tracepoint_multi_event(struct list_head *list, int *idx,
> >
> >                 found++;
> >
> > -               ret = add_tracepoint(list, idx, sys_name, evt_ent->d_name,
> > +               ret = add_tracepoint(parse_state, list, sys_name, evt_ent->d_name,
> >                                      err, head_config, loc);
> >         }
> >
> > @@ -592,19 +594,21 @@ static int add_tracepoint_multi_event(struct list_head *list, int *idx,
> >         return ret;
> >  }
> >
> > -static int add_tracepoint_event(struct list_head *list, int *idx,
> > +static int add_tracepoint_event(struct parse_events_state *parse_state,
> > +                               struct list_head *list,
> >                                 const char *sys_name, const char *evt_name,
> >                                 struct parse_events_error *err,
> >                                 struct parse_events_terms *head_config, YYLTYPE *loc)
> >  {
> >         return strpbrk(evt_name, "*?") ?
> > -               add_tracepoint_multi_event(list, idx, sys_name, evt_name,
> > +               add_tracepoint_multi_event(parse_state, list, sys_name, evt_name,
> >                                            err, head_config, loc) :
> > -               add_tracepoint(list, idx, sys_name, evt_name,
> > +               add_tracepoint(parse_state, list, sys_name, evt_name,
> >                                err, head_config, loc);
> >  }
> >
> > -static int add_tracepoint_multi_sys(struct list_head *list, int *idx,
> > +static int add_tracepoint_multi_sys(struct parse_events_state *parse_state,
> > +                                   struct list_head *list,
> >                                     const char *sys_name, const char *evt_name,
> >                                     struct parse_events_error *err,
> >                                     struct parse_events_terms *head_config, YYLTYPE *loc)
> > @@ -630,7 +634,7 @@ static int add_tracepoint_multi_sys(struct list_head *list, int *idx,
> >                 if (!strglobmatch(events_ent->d_name, sys_name))
> >                         continue;
> >
> > -               ret = add_tracepoint_event(list, idx, events_ent->d_name,
> > +               ret = add_tracepoint_event(parse_state, list, events_ent->d_name,
> >                                            evt_name, err, head_config, loc);
> >         }
> >
> > @@ -1266,7 +1270,8 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
> >         return 0;
> >  }
> >
> > -int parse_events_add_tracepoint(struct list_head *list, int *idx,
> > +int parse_events_add_tracepoint(struct parse_events_state *parse_state,
> > +                               struct list_head *list,
> >                                 const char *sys, const char *event,
> >                                 struct parse_events_error *err,
> >                                 struct parse_events_terms *head_config, void *loc_)
> > @@ -1282,14 +1287,14 @@ int parse_events_add_tracepoint(struct list_head *list, int *idx,
> >         }
> >
> >         if (strpbrk(sys, "*?"))
> > -               return add_tracepoint_multi_sys(list, idx, sys, event,
> > +               return add_tracepoint_multi_sys(parse_state, list, sys, event,
> >                                                 err, head_config, loc);
> >         else
> > -               return add_tracepoint_event(list, idx, sys, event,
> > +               return add_tracepoint_event(parse_state, list, sys, event,
> >                                             err, head_config, loc);
> >  #else
> > +       (void)parse_state;
> >         (void)list;
> > -       (void)idx;
> >         (void)sys;
> >         (void)event;
> >         (void)head_config;
> > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> > index 809359e8544e..fd55a154ceff 100644
> > --- a/tools/perf/util/parse-events.h
> > +++ b/tools/perf/util/parse-events.h
> > @@ -189,7 +189,8 @@ int parse_events_terms__to_strbuf(const struct parse_events_terms *terms, struct
> >  int parse_events__modifier_event(struct list_head *list, char *str, bool add);
> >  int parse_events__modifier_group(struct list_head *list, char *event_mod);
> >  int parse_events_name(struct list_head *list, const char *name);
> > -int parse_events_add_tracepoint(struct list_head *list, int *idx,
> > +int parse_events_add_tracepoint(struct parse_events_state *parse_state,
> > +                               struct list_head *list,
> >                                 const char *sys, const char *event,
> >                                 struct parse_events_error *error,
> >                                 struct parse_events_terms *head_config, void *loc);
> > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> > index d70f5d84af92..0bab4263f8e3 100644
> > --- a/tools/perf/util/parse-events.y
> > +++ b/tools/perf/util/parse-events.y
> > @@ -537,7 +537,7 @@ tracepoint_name opt_event_config
> >         if (!list)
> >                 YYNOMEM;
> >
> > -       err = parse_events_add_tracepoint(list, &parse_state->idx, $1.sys, $1.event,
> > +       err = parse_events_add_tracepoint(parse_state, list, $1.sys, $1.event,
> >                                         error, $2, &@1);
> >
> >         parse_events_terms__delete($2);
> >
> > --
> > 2.44.0
> >
