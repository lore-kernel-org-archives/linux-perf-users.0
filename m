Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC73178F3A;
	Mon, 28 Jul 2025 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753728897; cv=none; b=mfBPj76oLxj7Voz6qW85dT31vABmUbvLTit7+2EVSmlvwHA8txFFBH+Y1d5nIO/f44XR3eFuV/NkxzDly45voFJZV9eGGG0HHeBAeeeVZXPrlmxbv0gWHCB4Haqcd7OsBAYmE5ffqiNjXgBrYncipWbhCShEOv1td5rcZoQ3Ur4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753728897; c=relaxed/simple;
	bh=WnEp3RagWtEHBySiC59fYeCvC2c0jxhYSbMXiCFkVo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNb+X4iwGEAWlk6A1wWWl+EThJ0z6+I7gWvzFp8nhXtDBh44KRLwa6vQgm5dB1dhtcG2mAyDb8T6bhCEdiTODIZVxOgPXJMZimoYHKXlfdSm+WxwxiQSRXoWThGaVtJs0YCg0+mbHtO9EwvDu6q2bo8As7SYDF06vYg+YsdLUsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2PYwWB9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2PYwWB9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7226C4CEE7;
	Mon, 28 Jul 2025 18:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753728897;
	bh=WnEp3RagWtEHBySiC59fYeCvC2c0jxhYSbMXiCFkVo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I2PYwWB9EJ8zXLWPLfbodljZbQiOWuCTHO64dVw5sblznyOhO5B5a4Oth78XM9vIZ
	 DB8BKRua7Onozl11c1bxts35o82FKUvJ49/h1Dl83GQEw2SzlDRUMp/4Ow40Xvv/xk
	 RcfK2fUEmsLp6ae/wwI+zttlF416BRQK3LLO74LJuOzi8Tz84bMRgMRZ/JB+7ax6gr
	 doTj2Quvnt4bBsP5YdP2ADTMDG07eTaSUTXc9t1cUqJBcjvJX7D8MIuRaemxLo4Ld0
	 /ja57/kl0QjwQksju432JnPEZ7Ijnrja4XNOXmMy2L5Qsnj1msiPWBoWYbaNHiH19p
	 c/EQmmU+1pKNA==
Date: Mon, 28 Jul 2025 11:54:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 9/9] perf annotate: Add dso__debuginfo() helper
Message-ID: <aIfHf7lAvsETtkFP@google.com>
References: <20250725193755.12276-1-namhyung@kernel.org>
 <20250725193755.12276-10-namhyung@kernel.org>
 <CAP-5=fXj5pcuut9dTVqZfmipTb-sRkZXUwjhJ41rTDNOKDJPQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXj5pcuut9dTVqZfmipTb-sRkZXUwjhJ41rTDNOKDJPQQ@mail.gmail.com>

On Fri, Jul 25, 2025 at 05:46:48PM -0700, Ian Rogers wrote:
> On Fri, Jul 25, 2025 at 12:38 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > It'd be great if it can get the correct debug information using DSO
> > build-Id not just the path name.  Instead of adding new callsites of
> > debuginfo__new(), let's add dso__debuginfo() which can hide the access
> > using the pathname and help the future conversion.
> >
> > Suggested-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> :-) and my prior review comments now make less sense. I think putting
> the ui__warning into dso__debugingo makes sense, wdyt?
 
I think it depends on what the caller does.  This code is just to get
the debuginfo from DSO and it cannot know if it's ok to print messages.
So it'd be better for callers to handle the case IMHO.

Thanks,
Namhyung

> > ---
> >  tools/perf/ui/browsers/annotate.c |  4 ++--
> >  tools/perf/util/annotate.c        |  6 +++---
> >  tools/perf/util/dso.h             | 10 ++++++++++
> >  3 files changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> > index 2a4db5bdcdb7e9d8..54610621c5f910fe 100644
> > --- a/tools/perf/ui/browsers/annotate.c
> > +++ b/tools/perf/ui/browsers/annotate.c
> > @@ -1042,7 +1042,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
> >                 case 'T':
> >                         annotate_opts.code_with_type ^= 1;
> >                         if (browser->dbg == NULL)
> > -                               browser->dbg = debuginfo__new(dso__long_name(map__dso(ms->map)));
> > +                               browser->dbg = dso__debuginfo(map__dso(ms->map));
> >                         annotate_browser__show(&browser->b, title, help);
> >                         annotate_browser__debuginfo_warning(browser);
> >                         continue;
> > @@ -1128,7 +1128,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
> >         ui_helpline__push("Press ESC to exit");
> >
> >         if (annotate_opts.code_with_type)
> > -               browser.dbg = debuginfo__new(dso__long_name(dso));
> > +               browser.dbg = dso__debuginfo(dso);
> >
> >         browser.b.width = notes->src->widths.max_line_len;
> >         browser.b.nr_entries = notes->src->nr_entries;
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index 6fc07971631ac8a3..05eb19b110ab7dcf 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -1270,7 +1270,7 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
> >         apd.addr_fmt_width = annotated_source__addr_fmt_width(&notes->src->source,
> >                                                               apd.start);
> >         evsel__get_arch(evsel, &apd.arch);
> > -       apd.dbg = debuginfo__new(filename);
> > +       apd.dbg = dso__debuginfo(dso);
> >
> >         list_for_each_entry(pos, &notes->src->source, node) {
> >                 int err;
> > @@ -1375,7 +1375,7 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
> >
> >         if (annotate_opts.code_with_type) {
> >                 evsel__get_arch(apd->evsel, &apd->arch);
> > -               apd->dbg = debuginfo__new(dso__long_name(map__dso(apd->he->ms.map)));
> > +               apd->dbg = dso__debuginfo(map__dso(apd->he->ms.map));
> >         }
> >
> >         list_for_each_entry(al, &notes->src->source, node) {
> > @@ -2888,7 +2888,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
> >                 di_cache.dso = dso__get(map__dso(ms->map));
> >
> >                 debuginfo__delete(di_cache.dbg);
> > -               di_cache.dbg = debuginfo__new(dso__long_name(di_cache.dso));
> > +               di_cache.dbg = dso__debuginfo(di_cache.dso);
> >         }
> >
> >         if (di_cache.dbg == NULL) {
> > diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> > index 7df1673f08d3ddb4..fd8e95de77f78dfc 100644
> > --- a/tools/perf/util/dso.h
> > +++ b/tools/perf/util/dso.h
> > @@ -10,6 +10,7 @@
> >  #include <stdio.h>
> >  #include <linux/bitops.h>
> >  #include "build-id.h"
> > +#include "debuginfo.h"
> >  #include "mutex.h"
> >  #include <internal/rc_check.h>
> >
> > @@ -914,4 +915,13 @@ u64 dso__findnew_global_type(struct dso *dso, u64 addr, u64 offset);
> >  bool perf_pid_map_tid(const char *dso_name, int *tid);
> >  bool is_perf_pid_map_name(const char *dso_name);
> >
> > +/*
> > + * In the future, we may get debuginfo using build-ID (w/o path).
> > + * Add this helper is for the smooth conversion.
> > + */
> > +static inline struct debuginfo *dso__debuginfo(struct dso *dso)
> > +{
> > +       return debuginfo__new(dso__long_name(dso));
> > +}
> > +
> >  #endif /* __PERF_DSO */
> > --
> > 2.50.1
> >
