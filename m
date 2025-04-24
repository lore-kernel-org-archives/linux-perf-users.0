Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20FE27B500
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Apr 2025 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498226; cv=none; b=BBbAnw1t9+MtAbVQog+yKue9yps6Al/XpFeBcLfLCuqXrZuvPaMDyA8bEEOsLmd7qeh6IZP60aGYlyqgAnrS4e9l9BYjx7ZIzOzmacDJV2so6MD1t5roSWDYn9oeYzvYdURGJOAxp1x7+TfHUN5Ku7WY5bT2aWHuCCtv18knDS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498226; c=relaxed/simple;
	bh=3/GoBzVRdOOVirsHLoMta3NkOrdmzsDwbjeu8/reP6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsB8qrmcxJYEOXaVp4Tf+wgstl/jtB45AjMMeDJPnt0RkTaQxBPZgsbcbVSJD/TyqS4ocSa3EgP7nVJxsgjo934u3p3XsInKy0xCKjmhL8Mx4gX1RGEEMR0Rwy35CgAhzrsJA+GK4w1eJytBo9YFeV+gO6l1zAT6KHn7ZpvSMGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEPZ1zeM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEPZ1zeM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24F2C4CEE3;
	Thu, 24 Apr 2025 12:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745498226;
	bh=3/GoBzVRdOOVirsHLoMta3NkOrdmzsDwbjeu8/reP6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IEPZ1zeMO2J7epeZb9xaPDITOcqREe3/UuT9cugtJzpkFqjHWyCaioRmn+6Ps7wZu
	 TAqxJ2lqeiHemFR5sCixMkDLpC51VO7ysv///vSzZ9CYOWXcn+ITdQykcYsSUw5YMF
	 my1MKtzFlk+CJFTzMVHtA9IhSuTKsh2xdJScZdo5qkaERB7pckP5sz4kYegApuKGHW
	 aBYpX+ZnL+Ec7ASpsHj9EZT6Gzcjhyefthyf4fOFTaszqL7Hagb1Go9232njJthTWN
	 UdOMaNjwOamH101Cr+ibs9W0opOQvvaLOmlnW7gjvSj6IeTvbY4gEwInJx1ztrUhXV
	 adC0A+FQfE2Yw==
Date: Thu, 24 Apr 2025 09:37:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Howard Chu <howardchu95@gmail.com>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [perf top] annotation doesn't work, libunwind doesn't seem to be
 working either
Message-ID: <aAowbu4OV4qgn0sf@x1>
References: <Z9vgt1pjiNbDBDbM@gmail.com>
 <Z9w_aFlzOkoCTSqK@google.com>
 <Z-EJnye74la1triY@gmail.com>
 <Z--pWmTHGb62_83e@gmail.com>
 <CAH0uvoi3oaZesWKLtaJRm3AkJx9j-G_Xm66Z276xH5+k11zisQ@mail.gmail.com>
 <Z_QEND63LoxP0h9H@gmail.com>
 <Z_Rz10stoLzBocIO@x1>
 <Z_S_JB_L_t9viciV@google.com>
 <Z_XpADpc9WtUdbmX@x1>
 <Z_gunJ9C3H25Uo9Q@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_gunJ9C3H25Uo9Q@google.com>

On Thu, Apr 10, 2025 at 01:48:28PM -0700, Namhyung Kim wrote:
> On Wed, Apr 09, 2025 at 12:26:56AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, Apr 07, 2025 at 11:16:04PM -0700, Namhyung Kim wrote:
> > > On Mon, Apr 07, 2025 at 09:54:47PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > A quick test here with perf top without setting the above ends up with
> > > > the behaviour that Ingo reported, no source code is shown and 's'
> > > > doesn't work. Then if I set it to use objdump:
> > 
> > > > root@number:~# perf config annotate.disassemblers=objdump
> > > > root@number:~# perf config annotate.disassemblers
> > > > annotate.disassemblers=objdump
> > > > root@number:~# cat ~/.perfconfig 
> > > > # this file is auto-generated.
> > > > [annotate]
> > > > 	disassemblers = objdump
> > > > root@number:~#
> > 
> > > > It takes longer to show the annotated output but there is source code
> > > > and 's' works.
> > 
> > > Thanks for chasing it down, we miss source line support in the disasm
> > > using capstone and libllvm.  We can add that later but for now we may
> > > refresh the result and force to objdump when source line is requested.
> > 
> > That is a good idea, I thought about it as well and will check how to do
> > it on top of what I have at:
> > 
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf-annotate%2bbuild
> 
> How about this?
> 
> >From ce37ae9008ec7c6ab66ee1b6632a3c51bc0802f3 Mon Sep 17 00:00:00 2001
> From: Namhyung Kim <namhyung@kernel.org>
> Date: Thu, 10 Apr 2025 13:42:16 -0700
> Subject: [PATCH] perf annotate: Fix source code annotate with objdump
> 
> Recently it uses llvm and capstone to speed up annotation or disassembly
> of instructions.  But they don't support source code view yet.  Until it
> fixed, we can force to use objdump for source code annotation.
> 
> To prevent performance loss, it's disabled by default and turned it on
> when user requests it in TUI by pressing 's' key.
> 
> Reported-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/ui/browsers/annotate.c | 43 +++++++++++++++++++++++++++++--
>  tools/perf/util/annotate.c        |  2 ++
>  tools/perf/util/annotate.h        |  1 +
>  tools/perf/util/disasm.c          |  7 +++++
>  4 files changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index ab776b1ed2d5b4ba..fe31069990d77e65 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -345,6 +345,23 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
>  	browser->curr_hot = rb_last(&browser->entries);
>  }
>  
> +static struct annotation_line *annotate_browser__find_new_asm_line(
> +					struct annotate_browser *browser,
> +					int idx_asm)
> +{
> +	struct annotation_line *al;
> +	struct list_head *head = browser->b.entries;
> +
> +	/* find an annotation line in the new list with the same idx_asm */
> +	list_for_each_entry(al, head, node) {
> +		if (al->idx_asm == idx_asm)
> +			return al;
> +	}
> +
> +	/* There are no asm lines */
> +	return NULL;
> +}
> +
>  static struct annotation_line *annotate_browser__find_next_asm_line(
>  					struct annotate_browser *browser,
>  					struct annotation_line *al)
> @@ -368,7 +385,8 @@ static struct annotation_line *annotate_browser__find_next_asm_line(
>  	return NULL;
>  }
>  
> -static bool annotate_browser__toggle_source(struct annotate_browser *browser)
> +static bool annotate_browser__toggle_source(struct annotate_browser *browser,
> +					    struct evsel *evsel)
>  {
>  	struct annotation *notes = browser__annotation(&browser->b);
>  	struct annotation_line *al;
> @@ -377,6 +395,27 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser)
>  	browser->b.seek(&browser->b, offset, SEEK_CUR);
>  	al = list_entry(browser->b.top, struct annotation_line, node);
>  
> +	if (!annotate_opts.annotate_src)
> +		annotate_opts.annotate_src = true;
> +
> +	if (annotate_opts.hide_src_code && !notes->src->tried_source) {
> +		struct map_symbol *ms = browser->b.priv;
> +		bool orig_entries = notes->src->nr_entries;

  CC      /tmp/build/perf-tools-next/ui/browsers/annotate.o
  AR      /tmp/build/perf-tools-next/libpmu-events.a
  AR      /tmp/build/perf-tools-next/libperf-test.a
  AR      /tmp/build/perf-tools-next/libperf-util.a
ui/browsers/annotate.c: In function ‘annotate_browser__toggle_source’:
ui/browsers/annotate.c:403:22: error: unused variable ‘orig_entries’ [-Werror=unused-variable]
  403 |                 bool orig_entries = notes->src->nr_entries;
      |                      ^~~~~~~~~~~~
cc1: all warnings being treated as errors
make[5]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:85: /tmp/build/perf-tools-next/ui/browsers/annotate.o] Error 1
make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:142: browsers] Error 2
make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:142: ui] Error 2
make[2]: *** [Makefile.perf:792: /tmp/build/perf-tools-next/perf-ui-in.o] Error 2
make[1]: *** [Makefile.perf:290: sub-make] Error 2
make: *** [Makefile:119: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
⬢ [acme@toolbox perf-tools-next]$ 

I'm applying this on top, ok?

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index fe31069990d77e65..b400ac032dcba9a6 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -400,7 +400,6 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser,
 
 	if (annotate_opts.hide_src_code && !notes->src->tried_source) {
 		struct map_symbol *ms = browser->b.priv;
-		bool orig_entries = notes->src->nr_entries;
 		int orig_idx_asm = al->idx_asm;
 
 		notes->src->tried_source = true;


Nah, this part needs checking:

+               browser->b.entries = &notes->src->source;
+               al = annotate_browser__find_new_asm_line(browser, orig_idx_asm);
+               browser->b.seek(&browser->b, al->idx_asm, SEEK_SET);

As annotate_browser__find_new_asm_line() can return NULL.

Can you please resubmit with these changes?

Thanks,

- Arnaldo

> +		int orig_idx_asm = al->idx_asm;
> +
> +		notes->src->tried_source = true;
> +
> +		/* annotate again with source code info */
> +		annotate_opts.hide_src_code = false;
> +		annotated_source__purge(notes->src);
> +		symbol__annotate2(ms, evsel, &browser->arch);
> +		annotate_opts.hide_src_code = true;
> +
> +		browser->b.entries = &notes->src->source;
> +		al = annotate_browser__find_new_asm_line(browser, orig_idx_asm);
> +		browser->b.seek(&browser->b, al->idx_asm, SEEK_SET);
> +	}
> +
>  	if (annotate_opts.hide_src_code) {
>  		if (al->idx_asm < offset)
>  			offset = al->idx;
> @@ -833,7 +872,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
>  			nd = browser->curr_hot;
>  			break;
>  		case 's':
> -			if (annotate_browser__toggle_source(browser))
> +			if (annotate_browser__toggle_source(browser, evsel))
>  				ui_helpline__puts(help);
>  			annotate__scnprintf_title(hists, title, sizeof(title));
>  			annotate_browser__show(&browser->b, title, help);
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 264a212b47df850c..0dd475a744b6dfac 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1451,6 +1451,7 @@ void annotated_source__purge(struct annotated_source *as)
>  		list_del_init(&al->node);
>  		disasm_line__free(disasm_line(al));
>  	}
> +	as->tried_source = false;
>  }
>  
>  static size_t disasm_line__fprintf(struct disasm_line *dl, FILE *fp)
> @@ -2280,6 +2281,7 @@ void annotation_options__init(void)
>  	opt->annotate_src = true;
>  	opt->offset_level = ANNOTATION__OFFSET_JUMP_TARGETS;
>  	opt->percent_type = PERCENT_PERIOD_LOCAL;
> +	opt->hide_src_code = true;
>  	opt->hide_src_code_on_title = true;
>  }
>  
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index bbb89b32f398b3c9..8b5131d257b01e3e 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -294,6 +294,7 @@ struct annotated_source {
>  	int			nr_entries;
>  	int			nr_asm_entries;
>  	int			max_jump_sources;
> +	bool			tried_source;
>  	u64			start;
>  	struct {
>  		u8		addr;
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 8f0eb56c6fc66a96..ff475a239f4b0db4 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -2284,6 +2284,13 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  		}
>  	}
>  
> +	/* FIXME: LLVM and CAPSTONE should support source code */
> +	if (options->annotate_src && !options->hide_src_code) {
> +		err = symbol__disassemble_objdump(symfs_filename, sym, args);
> +		if (err == 0)
> +			goto out_remove_tmp;
> +	}
> +
>  	err = -1;
>  	for (u8 i = 0; i < ARRAY_SIZE(options->disassemblers) && err != 0; i++) {
>  		enum perf_disassembler dis = options->disassemblers[i];
> -- 
> 2.49.0.604.gff1f9ca942-goog
> 
