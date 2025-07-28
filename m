Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6744F4A11;
	Mon, 28 Jul 2025 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753728164; cv=none; b=fjTubShjOKW9M4mT3Z8MzJZUx5jRpjs6egh7JoFlZ63xEqxhl5QnLPOVHN4ZfRICYDFFnr8Qkc4jnGNdu5xVW6cXYoNMGG+4kwUwQkDVMI852Go8Aut7vpavvyyhm27ICoFOXNnUg298DfJFPtwvIgTXY5rQrfGyLGvbkCy/GZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753728164; c=relaxed/simple;
	bh=z6cyh8fL9Uh1Y/lSoKuNYFuY1ro/OuaKS84RZGxsnys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cS5RucoNclzghSsM51JY2TvlH/mq+0G14efWI7BY/ADaYGgX7yjG3475a2PQtptm5zQAZXu6I5LJ/rrg/qtc9sD7HoQa1HnwlOaeoKzWUq+eiBHlN5zvltFExh26VcinvsKg1q8bhv9N/I3znGdVaRsOhpriXVD1MjRMpi1y7IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOGCsO7X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOGCsO7X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3737C4CEE7;
	Mon, 28 Jul 2025 18:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753728164;
	bh=z6cyh8fL9Uh1Y/lSoKuNYFuY1ro/OuaKS84RZGxsnys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TOGCsO7X/8mSzPnf426kkg2Z/V8bHQR0NVJmpgTdNYQfTkd4mSv75454H9BU+Ze1g
	 5EBXYsYt+8C1dUvSzQoHS7SYG6EwekF28gsFj3rQrEWsv9J2a7/l7G23mnXQIcnkYU
	 GVEHlnrRGw8mCqt3IeMiDvbD3icDi6YE8DbdV+68wXEz9loGZMUF5yArQItaixu4rQ
	 NEPVp790vqo5lJ9fEbmgBZ5GRyhxCvtB03ITC38Enczp25H9mow6NWRSUFq+fZoqca
	 8vkAzwi3+UJxaVB8OYLYJWoWgaDhVcM5e+BRtFPyCtd46kaBUU6L7ourRfz9yAle4l
	 KS7jhwuP8Ykig==
Date: Mon, 28 Jul 2025 11:42:42 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 2/9] perf annotate: Remove __annotation_line__write()
Message-ID: <aIfEogcWn3yvv-Pq@google.com>
References: <20250725193755.12276-1-namhyung@kernel.org>
 <20250725193755.12276-3-namhyung@kernel.org>
 <CAP-5=fVG6q37_tVvFo12OCiiE4zu0fqkf_3Z1rmoanVLXR7DOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVG6q37_tVvFo12OCiiE4zu0fqkf_3Z1rmoanVLXR7DOA@mail.gmail.com>

On Fri, Jul 25, 2025 at 05:20:28PM -0700, Ian Rogers wrote:
> On Fri, Jul 25, 2025 at 12:38 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Get rid of the internal function and convert function arguments into
> > local variables if they are used more than once.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/annotate.c | 46 ++++++++++++++++----------------------
> >  1 file changed, 19 insertions(+), 27 deletions(-)
> >
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index 0dd475a744b6dfac..69ee83052396b15e 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -1935,24 +1935,26 @@ int annotation_br_cntr_entry(char **str, int br_cntr_nr,
> >         return -ENOMEM;
> >  }
> >
> > -static void __annotation_line__write(struct annotation_line *al, struct annotation *notes,
> > -                                    bool first_line, bool current_entry, bool change_color, int width,
> > -                                    void *obj, unsigned int percent_type,
> > -                                    int  (*obj__set_color)(void *obj, int color),
> > -                                    void (*obj__set_percent_color)(void *obj, double percent, bool current),
> > -                                    int  (*obj__set_jumps_percent_color)(void *obj, int nr, bool current),
> > -                                    void (*obj__printf)(void *obj, const char *fmt, ...),
> > -                                    void (*obj__write_graph)(void *obj, int graph))
> > -
> > -{
> > -       double percent_max = annotation_line__max_percent(al, percent_type);
> > -       int pcnt_width = annotation__pcnt_width(notes),
> > -           cycles_width = annotation__cycles_width(notes);
> > +void annotation_line__write(struct annotation_line *al, struct annotation *notes,
> > +                           struct annotation_write_ops *wops)
> 
> nit: constify wops? If its const are the local variables worth it?
 
Sure, I think it's good.

Thanks,
Namhyung

> > +{
> > +       bool current_entry = wops->current_entry;
> > +       bool change_color = wops->change_color;
> > +       double percent_max = annotation_line__max_percent(al, annotate_opts.percent_type);
> > +       int width = wops->width;
> > +       int pcnt_width = annotation__pcnt_width(notes);
> > +       int cycles_width = annotation__cycles_width(notes);
> >         bool show_title = false;
> >         char bf[256];
> >         int printed;
> > -
> > -       if (first_line && (al->offset == -1 || percent_max == 0.0)) {
> > +       void *obj = wops->obj;
> > +       int  (*obj__set_color)(void *obj, int color) = wops->set_color;
> > +       void (*obj__set_percent_color)(void *obj, double percent, bool current) = wops->set_percent_color;
> > +       int  (*obj__set_jumps_percent_color)(void *obj, int nr, bool current) = wops->set_jumps_percent_color;
> > +       void (*obj__printf)(void *obj, const char *fmt, ...) = wops->printf;
> > +       void (*obj__write_graph)(void *obj, int graph) = wops->write_graph;
> > +
> > +       if (wops->first_line && (al->offset == -1 || percent_max == 0.0)) {
> >                 if (notes->branch && al->cycles) {
> >                         if (al->cycles->ipc == 0.0 && al->cycles->avg == 0)
> >                                 show_title = true;
> > @@ -1966,7 +1968,8 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
> >                 for (i = 0; i < al->data_nr; i++) {
> >                         double percent;
> >
> > -                       percent = annotation_data__percent(&al->data[i], percent_type);
> > +                       percent = annotation_data__percent(&al->data[i],
> > +                                                          annotate_opts.percent_type);
> >
> >                         obj__set_percent_color(obj, percent, current_entry);
> >                         if (symbol_conf.show_total_period) {
> > @@ -2115,17 +2118,6 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
> >
> >  }
> >
> > -void annotation_line__write(struct annotation_line *al, struct annotation *notes,
> > -                           struct annotation_write_ops *wops)
> > -{
> > -       __annotation_line__write(al, notes, wops->first_line, wops->current_entry,
> > -                                wops->change_color, wops->width, wops->obj,
> > -                                annotate_opts.percent_type,
> > -                                wops->set_color, wops->set_percent_color,
> > -                                wops->set_jumps_percent_color, wops->printf,
> > -                                wops->write_graph);
> > -}
> > -
> >  int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
> >                       struct arch **parch)
> >  {
> > --
> > 2.50.1
> >
