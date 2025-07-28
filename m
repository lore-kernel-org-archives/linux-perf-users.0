Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997A34A01;
	Mon, 28 Jul 2025 18:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753728423; cv=none; b=fcQNoRo9Ms5lf1LZZCZaj1Wt5fMtB5p+IR7jsZuRYFiQwYK+qOIcU8GT3DsqVqEwemJwrMtQU5XsJ835W1lNJulHF7RG2TE+Wv92FL5irmmFvA+1C/82Es4INPsaUml9+gpfsczahVcRHKls7lS8k9LpcgiOwqLfLrxM+9YmaNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753728423; c=relaxed/simple;
	bh=02Fddf8ITJihQ8B/mhFuNZSUFPZDC0Xr/u8l2xDBq0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdeYPG1lTgtedG4CwlPJbOelcL3m7x7OTi62/Nor8pbCT1NqLNsOlb1luGOqN+bqQVHPQy+9Qy9RYVUsbUWC+2S6Rh5deII775uAkNf0MKGPURSOgclq0VzQfK/v4KKKD00P2jLEDrGBw4nZoo53d/Pl2rpKRNBgu4p0fpo0zEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vi/MIXy5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vi/MIXy5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE881C4CEE7;
	Mon, 28 Jul 2025 18:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753728423;
	bh=02Fddf8ITJihQ8B/mhFuNZSUFPZDC0Xr/u8l2xDBq0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vi/MIXy5XCFlVbeVJl1XpG/AkUlIoYhaNCviZztZ9OPdr18DuRoz7I9Y6xilwXWTV
	 XKxDAHE1NuKn3MYPSOYqEUHKnSpRm4qggphjeekw+eGX0W3R64wTy/kOjc4LymuLgN
	 aDMoTbAuEkrVjhuCdsxxkJo3jmlOthfBtkvhXH4G37lmXKHM+vwVFPQYOI0Mll2lEo
	 zi5i67qJ3zW7o7BqLQryVrevjtN4roWpo4spFZmCYyWEs+Rh69iEpO2rlSFJApukL6
	 WiEF636thrudPjbcdH3NkG1x9ITKtLh9kmzDrsYaspt6HtWKs4EVn9O1DC8WdtWEyr
	 XP+d0khtzM1Yw==
Date: Mon, 28 Jul 2025 11:47:01 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 4/9] perf annotate: Simplify width calculation in
 annotation_line__write()
Message-ID: <aIfFpfYqxveCJJLC@google.com>
References: <20250725193755.12276-1-namhyung@kernel.org>
 <20250725193755.12276-5-namhyung@kernel.org>
 <CAP-5=fUM=1paD_3morMnz_6m8WWE8pmN0sC27xPanbp3FWYtjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUM=1paD_3morMnz_6m8WWE8pmN0sC27xPanbp3FWYtjQ@mail.gmail.com>

On Fri, Jul 25, 2025 at 05:30:04PM -0700, Ian Rogers wrote:
> On Fri, Jul 25, 2025 at 12:38 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The width is updated after each part is printed.  It can skip the output
> > processing if the total printed size is bigger than the width.
> >
> > No function changes intended.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/annotate.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index c21152710148b68c..d69e406c1bc289cd 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -1993,6 +1993,7 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
> >                                            symbol_conf.show_nr_samples ? "Samples" : "Percent");
> >                 }
> >         }
> > +       width -= pcnt_width;
> >
> >         if (notes->branch) {
> >                 if (al->cycles && al->cycles->ipc)
> > @@ -2056,11 +2057,12 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
> >                         obj__printf(obj, "%*s", ANNOTATION__AVG_IPC_WIDTH, bf);
> >                 }
> >         }
> > +       width -= cycles_width;
> >
> >         obj__printf(obj, " ");
> >
> >         if (!*al->line)
> > -               obj__printf(obj, "%-*s", width - pcnt_width - cycles_width, " ");
> > +               obj__printf(obj, "%-*s", width, " ");
> >         else if (al->offset == -1) {
> >                 if (al->line_nr && annotate_opts.show_linenr)
> >                         printed = scnprintf(bf, sizeof(bf), "%-*d ",
> > @@ -2069,7 +2071,7 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
> >                         printed = scnprintf(bf, sizeof(bf), "%-*s  ",
> >                                             notes->src->widths.addr, " ");
> >                 obj__printf(obj, bf);
> > -               obj__printf(obj, "%-*s", width - printed - pcnt_width - cycles_width + 1, al->line);
> > +               obj__printf(obj, "%-*s", width - printed + 1, al->line);
> 
> This doesn't seem to line up with the commit message, should width be
> updated prior to this call?

Fair enough.

> 
> >         } else {
> >                 u64 addr = al->offset;
> >                 int color = -1;
> > @@ -2112,9 +2114,11 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
> >                 if (change_color)
> >                         obj__set_color(obj, color);
> >
> > +               width -= printed + 3;
> 
> nit: For constants that like '+3' here and '+1' it'd be nice for a
> comment just to say where the adjustment comes from.

Sure, will do.

Thanks,
Namhyung
 
> > +
> >                 disasm_line__write(disasm_line(al), notes, obj, bf, sizeof(bf), obj__printf, obj__write_graph);
> >
> > -               obj__printf(obj, "%-*s", width - pcnt_width - cycles_width - 3 - printed, bf);
> > +               obj__printf(obj, "%-*s", width, bf);
> >
> >                 (void)apd;
> >         }
> > --
> > 2.50.1
> >
