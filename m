Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA4A4A33;
	Thu, 26 Jun 2025 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750960240; cv=none; b=onpiBj0T/fwwboCGJMlvN1JJooQD4TXZRdfIlHMM7NEt6sUE0K7kZfDlAuuVWIB705Q5GWsSgdKzpXCdoS4P8++iKCyANLJvCoDmyLHpimBNlN5YNTRxgkRDkSriJlPiXtDdKnGF2Q8vmRZue6NFm+3NeY76emJjmVWvsLmzbPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750960240; c=relaxed/simple;
	bh=eeYWsVThjIY01P/CUkD0Vk7rWE+85aKF38UTy8A0piA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGHf+mIOmi+BjfJu39lhdnpreU0ptUZwQufAP2o14d1oDu2PjiKBy1BI8b4/rZOAkLDqqdEd6Cmo44EeyZTM6R0SM+uCDV2oBcOKe9EN+Rk8lRZJxw5NFhNd9u9ivQAJtM/Mh9Ft/RRCq1KeRT7qdpanliktv1WmlojY/sQ96eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDDAhNfj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDDAhNfj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540C9C4CEEB;
	Thu, 26 Jun 2025 17:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750960239;
	bh=eeYWsVThjIY01P/CUkD0Vk7rWE+85aKF38UTy8A0piA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XDDAhNfj1QeZQikOL5AnqcAqQIGyv/pWdYvJ5PDEfQtxmidcbr7s5N6EnJG4x1VbF
	 1S8S47hjntC4yt7HFEPAjihfWKkipg1FOzctxAFPgZrvVjILNYcpYnVe3mFGhcBaai
	 4RcHPhhmuR+G/xZENLQTZE1oM6oho3IfCRq8s4idoj3az0PpQOquGPrhlkwzWlLQx/
	 oe3eNynTCsC2n3iH4GfLrbt+aJ59o2QyEIRGI8myLNMjAS27PyJEeCoHMzoGmvV3qU
	 JRtrGyuW6PQ1oVv4ib+jRgxU9MEZfMsDOH2YpnNb/yXn8Z+n4wZQimAICnT6pS8AXP
	 gmGytd5SMmRIQ==
Date: Thu, 26 Jun 2025 10:50:37 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3] perf annotate: Fix source code annotate with objdump
Message-ID: <aF2IbcebglJOP1LG@google.com>
References: <20250625230339.702610-1-namhyung@kernel.org>
 <CAP-5=fUUOT4-1DU=Lx7OTayLssUq_ZT-bdGuqRzj_2jMqBx_FQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUUOT4-1DU=Lx7OTayLssUq_ZT-bdGuqRzj_2jMqBx_FQ@mail.gmail.com>

Hi Ian,

On Thu, Jun 26, 2025 at 08:23:30AM -0700, Ian Rogers wrote:
> On Wed, Jun 25, 2025 at 4:03 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Recently it uses llvm and capstone to speed up annotation or disassembly
> > of instructions.  But they don't support source code view yet.  Until it
> > fixed, we can force to use objdump for source code annotation.
> >
> > To prevent performance loss, it's disabled by default and turned it on
> > when user requests it in TUI by pressing 's' key.
> >
> > Link: https://lore.kernel.org/r/20250608004613.238291-1-namhyung@kernel.org
> > Reported-by: Ingo Molnar <mingo@kernel.org>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Can we move this series forward:
> https://lore.kernel.org/lkml/20250417230740.86048-1-irogers@google.com/
> There was some build testing by Arnaldo but then things became
> stalled. I'm guessing I'll need to send a rebase.

I'll take a look.  Is there any thing related to this patchset?
It'd be nice if we can land this first.

Thanks,
Namhyung

> 
> > ---
> > v3)
> >  * show warning when there's no source code
> >
> >  tools/perf/ui/browsers/annotate.c | 86 +++++++++++++++++++++++++++++--
> >  tools/perf/util/annotate.c        |  2 +
> >  tools/perf/util/annotate.h        |  1 +
> >  tools/perf/util/disasm.c          |  7 +++
> >  4 files changed, 93 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> > index ab776b1ed2d5b4ba..183902dac042ecb0 100644
> > --- a/tools/perf/ui/browsers/annotate.c
> > +++ b/tools/perf/ui/browsers/annotate.c
> > @@ -345,6 +345,23 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
> >         browser->curr_hot = rb_last(&browser->entries);
> >  }
> >
> > +static struct annotation_line *annotate_browser__find_new_asm_line(
> > +                                       struct annotate_browser *browser,
> > +                                       int idx_asm)
> > +{
> > +       struct annotation_line *al;
> > +       struct list_head *head = browser->b.entries;
> > +
> > +       /* find an annotation line in the new list with the same idx_asm */
> > +       list_for_each_entry(al, head, node) {
> > +               if (al->idx_asm == idx_asm)
> > +                       return al;
> > +       }
> > +
> > +       /* There are no asm lines */
> > +       return NULL;
> > +}
> > +
> >  static struct annotation_line *annotate_browser__find_next_asm_line(
> >                                         struct annotate_browser *browser,
> >                                         struct annotation_line *al)
> > @@ -368,7 +385,31 @@ static struct annotation_line *annotate_browser__find_next_asm_line(
> >         return NULL;
> >  }
> >
> > -static bool annotate_browser__toggle_source(struct annotate_browser *browser)
> > +static bool annotation__has_source(struct annotation *notes)
> > +{
> > +       struct annotation_line *al;
> > +       bool found_asm = false;
> > +
> > +       /* Let's skip the first non-asm lines which present regardless of source. */
> > +       list_for_each_entry(al, &notes->src->source, node) {
> > +               if (al->offset >= 0) {
> > +                       found_asm = true;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       if (found_asm) {
> > +               /* After assembly lines, any line without offset means source. */
> > +               list_for_each_entry_continue(al, &notes->src->source, node) {
> > +                       if (al->offset == -1)
> > +                               return true;
> > +               }
> > +       }
> > +       return false;
> > +}
> > +
> > +static bool annotate_browser__toggle_source(struct annotate_browser *browser,
> > +                                           struct evsel *evsel)
> >  {
> >         struct annotation *notes = browser__annotation(&browser->b);
> >         struct annotation_line *al;
> > @@ -377,6 +418,39 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser)
> >         browser->b.seek(&browser->b, offset, SEEK_CUR);
> >         al = list_entry(browser->b.top, struct annotation_line, node);
> >
> > +       if (!annotate_opts.annotate_src)
> > +               annotate_opts.annotate_src = true;
> > +
> > +       /*
> > +        * It's about to get source code annotation for the first time.
> > +        * Drop the existing annotation_lines and get the new one with source.
> > +        * And then move to the original line at the same asm index.
> > +        */
> > +       if (annotate_opts.hide_src_code && !notes->src->tried_source) {
> > +               struct map_symbol *ms = browser->b.priv;
> > +               int orig_idx_asm = al->idx_asm;
> > +
> > +               /* annotate again with source code info */
> > +               annotate_opts.hide_src_code = false;
> > +               annotated_source__purge(notes->src);
> > +               symbol__annotate2(ms, evsel, &browser->arch);
> > +               annotate_opts.hide_src_code = true;
> > +
> > +               /* should be after annotated_source__purge() */
> > +               notes->src->tried_source = true;
> > +
> > +               if (!annotation__has_source(notes))
> > +                       ui__warning("Annotation has no source code.");
> > +
> > +               browser->b.entries = &notes->src->source;
> > +               al = annotate_browser__find_new_asm_line(browser, orig_idx_asm);
> > +               if (unlikely(al == NULL)) {
> > +                       al = list_first_entry(&notes->src->source,
> > +                                             struct annotation_line, node);
> > +               }
> > +               browser->b.seek(&browser->b, al->idx_asm, SEEK_SET);
> > +       }
> > +
> >         if (annotate_opts.hide_src_code) {
> >                 if (al->idx_asm < offset)
> >                         offset = al->idx;
> > @@ -833,7 +907,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
> >                         nd = browser->curr_hot;
> >                         break;
> >                 case 's':
> > -                       if (annotate_browser__toggle_source(browser))
> > +                       if (annotate_browser__toggle_source(browser, evsel))
> >                                 ui_helpline__puts(help);
> >                         annotate__scnprintf_title(hists, title, sizeof(title));
> >                         annotate_browser__show(&browser->b, title, help);
> > @@ -1011,6 +1085,12 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
> >                         ui__error("Couldn't annotate %s:\n%s", sym->name, msg);
> >                         return -1;
> >                 }
> > +
> > +               if (!annotate_opts.hide_src_code) {
> > +                       notes->src->tried_source = true;
> > +                       if (!annotation__has_source(notes))
> > +                               ui__warning("Annotation has no source code.");
> > +               }
> >         }
> >
> >         ui_helpline__push("Press ESC to exit");
> > @@ -1025,7 +1105,7 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
> >
> >         ret = annotate_browser__run(&browser, evsel, hbt);
> >
> > -       if(not_annotated)
> > +       if (not_annotated && !notes->src->tried_source)
> >                 annotated_source__purge(notes->src);
> >
> >         return ret;
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index 264a212b47df850c..0dd475a744b6dfac 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -1451,6 +1451,7 @@ void annotated_source__purge(struct annotated_source *as)
> >                 list_del_init(&al->node);
> >                 disasm_line__free(disasm_line(al));
> >         }
> > +       as->tried_source = false;
> >  }
> >
> >  static size_t disasm_line__fprintf(struct disasm_line *dl, FILE *fp)
> > @@ -2280,6 +2281,7 @@ void annotation_options__init(void)
> >         opt->annotate_src = true;
> >         opt->offset_level = ANNOTATION__OFFSET_JUMP_TARGETS;
> >         opt->percent_type = PERCENT_PERIOD_LOCAL;
> > +       opt->hide_src_code = true;
> >         opt->hide_src_code_on_title = true;
> >  }
> >
> > diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> > index bbb89b32f398b3c9..8b5131d257b01e3e 100644
> > --- a/tools/perf/util/annotate.h
> > +++ b/tools/perf/util/annotate.h
> > @@ -294,6 +294,7 @@ struct annotated_source {
> >         int                     nr_entries;
> >         int                     nr_asm_entries;
> >         int                     max_jump_sources;
> > +       bool                    tried_source;
> >         u64                     start;
> >         struct {
> >                 u8              addr;
> > diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> > index 8f0eb56c6fc66a96..ff475a239f4b0db4 100644
> > --- a/tools/perf/util/disasm.c
> > +++ b/tools/perf/util/disasm.c
> > @@ -2284,6 +2284,13 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
> >                 }
> >         }
> >
> > +       /* FIXME: LLVM and CAPSTONE should support source code */
> > +       if (options->annotate_src && !options->hide_src_code) {
> > +               err = symbol__disassemble_objdump(symfs_filename, sym, args);
> > +               if (err == 0)
> > +                       goto out_remove_tmp;
> > +       }
> > +
> >         err = -1;
> >         for (u8 i = 0; i < ARRAY_SIZE(options->disassemblers) && err != 0; i++) {
> >                 enum perf_disassembler dis = options->disassemblers[i];
> > --
> > 2.50.0.727.gbf7dc18ff4-goog
> >
