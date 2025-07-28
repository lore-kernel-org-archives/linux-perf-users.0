Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221808F48;
	Mon, 28 Jul 2025 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753727989; cv=none; b=rjuFWP67J3vu+fJf0JxQvYqOTMLH8/s/79xdfFoUVwxMDk8yNLVcF4+o6FxnPc8WqrZRUByP5VBtphwYkh+xzR24zilPHI0ZRdnZxApuxU3SpaT0ZmVWJGPk6cxRWIQl/LjbPg3y9nW4HueZkbIB8bgNXDZHSLqLBU9T8iwbiSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753727989; c=relaxed/simple;
	bh=uF+e44nBnH40h2WHsDgmsp9aWWZE+kzMmLQfxJkbwdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PE6kckOoIgmBJ1mfb3qeJAgf5F90dFkC0KmOEONxBxefR/fRY1uBy/tdIgMeUSt0W1Uv0mNQ11fu04LRh/FYhROzCV0WZH6xITBLxALE3JRNgi8RWuniWm8wD3xteVtrZP6ECA9niVfy08uev3wab9kcOW9MiVXXtCAm4AmzZ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQJT0ufQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQJT0ufQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C67C4CEF4;
	Mon, 28 Jul 2025 18:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753727988;
	bh=uF+e44nBnH40h2WHsDgmsp9aWWZE+kzMmLQfxJkbwdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQJT0ufQ5fO/Z5Ojk5PimpYnAdq24dq5G06Fq9nROGgE4unZ/EIrW3+9gbWM1ogW7
	 my4IQD4mpaxVcwTF5C915h+1K0/+uUllaTI7WJiWTF98ZlHz/qllH2FURgh9831tie
	 F/EvQ0R1q1V87Gbn9Zcrh+7R8RE8j9LrxGl//KPOn3nrkyNsOaJGRy7RJ+bJLocs0G
	 tt8ZFIn0FzmMsKJ5/8280/VyumXjOajpmGYSiCE4uFlOgWhzBBw6FXlg1tW352zFFU
	 aaUvE6f9xO7wrRxTCn57+OJlsebg0u0CYXJJEtKr4WDualOTYf2OT6i4yZy3UQe/wN
	 7NMbi3NDiW/Xw==
Date: Mon, 28 Jul 2025 11:39:46 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 1/9] perf annotate: Rename to
 __hist_entry__tui_annotate()
Message-ID: <aIfD8gwyLA61upIG@google.com>
References: <20250725193755.12276-1-namhyung@kernel.org>
 <20250725193755.12276-2-namhyung@kernel.org>
 <CAP-5=fXcBfQCbsrYmyrr4X+Svoo7iJW_62G8jG9C7f7hwwQAfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXcBfQCbsrYmyrr4X+Svoo7iJW_62G8jG9C7f7hwwQAfA@mail.gmail.com>

On Fri, Jul 25, 2025 at 05:16:39PM -0700, Ian Rogers wrote:
> On Fri, Jul 25, 2025 at 12:38 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > There are three different but similar functions for annotation on TUI.
> > Rename it to __hist_entry__tui_annotate() and make sure it passes 'he'.
> > It's not used for now but it'll be needed for later use.
> >
> > Also remove map_symbol__tui_annotate() which was a simple wrapper.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/ui/browsers/annotate.c | 17 +++++++----------
> >  tools/perf/ui/browsers/hists.c    |  2 +-
> >  tools/perf/util/annotate.h        | 12 ------------
> >  tools/perf/util/hist.h            | 12 +++++++-----
> >  4 files changed, 15 insertions(+), 28 deletions(-)
> >
> > diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> > index 183902dac042ecb0..28ef146f29e8e742 100644
> > --- a/tools/perf/ui/browsers/annotate.c
> > +++ b/tools/perf/ui/browsers/annotate.c
> > @@ -27,6 +27,7 @@ struct annotate_browser {
> >         struct rb_node             *curr_hot;
> >         struct annotation_line     *selection;
> >         struct arch                *arch;
> > +       struct hist_entry          *he;
> 
> nit: as you are here is it worth commenting this, for example, who owns "he"?

Hmm.. good point.  The hist entries can be deleted by perf top display
thread so we cannot guarantee it's live during the annotation.  Maybe we
need a copy and with proper reference counting on its fields.  I'll
think about it more.

> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks for your review!
Namhyung

> 
> >         bool                        searching_backwards;
> >         char                        search_bf[128];
> >  };
> > @@ -557,7 +558,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
> >         target_ms.map = ms->map;
> >         target_ms.sym = dl->ops.target.sym;
> >         annotation__unlock(notes);
> > -       symbol__tui_annotate(&target_ms, evsel, hbt);
> > +       __hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt);
> >         sym_title(ms->sym, ms->map, title, sizeof(title), annotate_opts.percent_type);
> >         ui_browser__show_title(&browser->b, title);
> >         return true;
> > @@ -1032,12 +1033,6 @@ static int annotate_browser__run(struct annotate_browser *browser,
> >         return key;
> >  }
> >
> > -int map_symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
> > -                            struct hist_browser_timer *hbt)
> > -{
> > -       return symbol__tui_annotate(ms, evsel, hbt);
> > -}
> > -
> >  int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
> >                              struct hist_browser_timer *hbt)
> >  {
> > @@ -1046,11 +1041,12 @@ int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
> >         SLang_init_tty(0, 0, 0);
> >         SLtty_set_suspend_state(true);
> >
> > -       return map_symbol__tui_annotate(&he->ms, evsel, hbt);
> > +       return __hist_entry__tui_annotate(he, &he->ms, evsel, hbt);
> >  }
> >
> > -int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
> > -                        struct hist_browser_timer *hbt)
> > +int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
> > +                              struct evsel *evsel,
> > +                              struct hist_browser_timer *hbt)
> >  {
> >         struct symbol *sym = ms->sym;
> >         struct annotation *notes = symbol__annotation(sym);
> > @@ -1064,6 +1060,7 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
> >                         .priv    = ms,
> >                         .use_navkeypressed = true,
> >                 },
> > +               .he = he,
> >         };
> >         struct dso *dso;
> >         int ret = -1, err;
> > diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> > index d9d3fb44477ac6d5..487c0b08c0038710 100644
> > --- a/tools/perf/ui/browsers/hists.c
> > +++ b/tools/perf/ui/browsers/hists.c
> > @@ -2484,8 +2484,8 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
> >         else
> >                 evsel = hists_to_evsel(browser->hists);
> >
> > -       err = map_symbol__tui_annotate(&act->ms, evsel, browser->hbt);
> >         he = hist_browser__selected_entry(browser);
> > +       err = __hist_entry__tui_annotate(he, &act->ms, evsel, browser->hbt);
> >         /*
> >          * offer option to annotate the other branch source or target
> >          * (if they exists) when returning from annotate
> > diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> > index 8b5131d257b01e3e..0f640e4871744262 100644
> > --- a/tools/perf/util/annotate.h
> > +++ b/tools/perf/util/annotate.h
> > @@ -471,18 +471,6 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel);
> >  int hist_entry__tty_annotate(struct hist_entry *he, struct evsel *evsel);
> >  int hist_entry__tty_annotate2(struct hist_entry *he, struct evsel *evsel);
> >
> > -#ifdef HAVE_SLANG_SUPPORT
> > -int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
> > -                        struct hist_browser_timer *hbt);
> > -#else
> > -static inline int symbol__tui_annotate(struct map_symbol *ms __maybe_unused,
> > -                               struct evsel *evsel  __maybe_unused,
> > -                               struct hist_browser_timer *hbt __maybe_unused)
> > -{
> > -       return 0;
> > -}
> > -#endif
> > -
> >  void annotation_options__init(void);
> >  void annotation_options__exit(void);
> >
> > diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> > index 70438d03ca9c33b1..c64005278687cb02 100644
> > --- a/tools/perf/util/hist.h
> > +++ b/tools/perf/util/hist.h
> > @@ -713,8 +713,9 @@ struct block_hist {
> >  #include "../ui/keysyms.h"
> >  void attr_to_script(char *buf, struct perf_event_attr *attr);
> >
> > -int map_symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
> > -                            struct hist_browser_timer *hbt);
> > +int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
> > +                              struct evsel *evsel,
> > +                              struct hist_browser_timer *hbt);
> >
> >  int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
> >                              struct hist_browser_timer *hbt);
> > @@ -742,9 +743,10 @@ int evlist__tui_browse_hists(struct evlist *evlist __maybe_unused,
> >  {
> >         return 0;
> >  }
> > -static inline int map_symbol__tui_annotate(struct map_symbol *ms __maybe_unused,
> > -                                          struct evsel *evsel __maybe_unused,
> > -                                          struct hist_browser_timer *hbt __maybe_unused)
> > +static inline int __hist_entry__tui_annotate(struct hist_entry *he __maybe_unused,
> > +                                            struct map_symbol *ms __maybe_unused,
> > +                                            struct evsel *evsel __maybe_unused,
> > +                                            struct hist_browser_timer *hbt __maybe_unused)
> >  {
> >         return 0;
> >  }
> > --
> > 2.50.1
> >
