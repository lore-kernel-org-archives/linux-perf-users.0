Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200D2C2D1;
	Wed, 16 Jul 2025 20:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752697014; cv=none; b=lFJqBXRNNk/gtIaN+TD9iJgUdu8Oe2BVZgxFTx8Gnh/kWEwBf8wYKDRsCTO0qzH180oJ3q+0d0uPDF946iSqv8i2vb6lk99TtB/LrYONuOgCTFuT3Mck52Yqg64DXBBZotiXAN+vaqw80gbbexD4OHvni6GyzQBaL3cLUqc0fjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752697014; c=relaxed/simple;
	bh=CT6/n9je+Rh3NqEPGvYqif1e1g3eSjS/92Xez6wPYM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snYSkmoJfJAPJEjy0L+XwGncDylBusKRo/a/10e536wc+0by38oo4cBUGq3p/mRqsEezeHBjaqsNKsg7bKdV7Apbb+8T0QKiOUQpdIuV1lSheh7yWZNgJP5mZsN7G4Fp1hpCddRZXiQxTGQIR9c+iFrPJ4II1k4KZdyaqOmOVs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLIZwlYb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLIZwlYb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBA8C4CEF5;
	Wed, 16 Jul 2025 20:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752697013;
	bh=CT6/n9je+Rh3NqEPGvYqif1e1g3eSjS/92Xez6wPYM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CLIZwlYbnEDbGpM4Xdn4nIskDjOtBJxhLXYSFdtHZlDoX1E/9CCOiCugT+cNJzn9x
	 x9NVCMHvRrx/MP5HPGLuAw8r6xowzhFmo8a4O8Rb9BQRt4ijxj3g6w0q9TLVUgt8iz
	 41u0Qjq6CpCRuM3JAmDYSDT9VnOgCqk4jnTzdOcRCDKH4BslsqjDNVflCMuxqo7cH2
	 kGmjQ3rwJpHkZgLjczMkdLlET2jqisoUZgAPZQmg3X3xjA9x4FVI3VTNOQVHWYcL9V
	 Ky7Tq4wMVyT9XqUUiMJE3Q2u1x1pYV9TG74HNm4OXVW0bysZG8WknSeHnw/nqr13ee
	 A5zi9nHJ6r6DQ==
Date: Wed, 16 Jul 2025 17:16:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 1/8] perf annotate: Rename to
 __hist_entry__tui_annotate()
Message-ID: <aHgIsWPhKDZx6R_-@x1>
References: <20250716050054.14130-1-namhyung@kernel.org>
 <20250716050054.14130-2-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716050054.14130-2-namhyung@kernel.org>

On Tue, Jul 15, 2025 at 10:00:47PM -0700, Namhyung Kim wrote:
> There are three different but similar functions for annotation on TUI.

Why the two initial __? Normally this is when its about work on some
data structure but the pointer to it isn't passed, but in this case the
first arg is a 'struct hist_entry *', so calling it
hist_entry__tui_annotate() would be right?

Well, there is already a hist_entry__tui_annotate(), that does some
term setup before calling this "new" __hist_entry__tui_annotate().

Looks confusing tho :-\

- Arnaldo

> Rename it to __hist_entry__tui_annotate() and make sure it passes 'he'.
> It's not used for now but it'll be needed for later use.
> 
> Also remove map_symbol__tui_annotate() which was a simple wrapper.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/ui/browsers/annotate.c | 17 +++++++----------
>  tools/perf/ui/browsers/hists.c    |  2 +-
>  tools/perf/util/annotate.h        | 12 ------------
>  tools/perf/util/hist.h            | 12 +++++++-----
>  4 files changed, 15 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index 183902dac042ecb0..28ef146f29e8e742 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -27,6 +27,7 @@ struct annotate_browser {
>  	struct rb_node		   *curr_hot;
>  	struct annotation_line	   *selection;
>  	struct arch		   *arch;
> +	struct hist_entry	   *he;
>  	bool			    searching_backwards;
>  	char			    search_bf[128];
>  };
> @@ -557,7 +558,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
>  	target_ms.map = ms->map;
>  	target_ms.sym = dl->ops.target.sym;
>  	annotation__unlock(notes);
> -	symbol__tui_annotate(&target_ms, evsel, hbt);
> +	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt);
>  	sym_title(ms->sym, ms->map, title, sizeof(title), annotate_opts.percent_type);
>  	ui_browser__show_title(&browser->b, title);
>  	return true;
> @@ -1032,12 +1033,6 @@ static int annotate_browser__run(struct annotate_browser *browser,
>  	return key;
>  }
>  
> -int map_symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
> -			     struct hist_browser_timer *hbt)
> -{
> -	return symbol__tui_annotate(ms, evsel, hbt);
> -}
> -
>  int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
>  			     struct hist_browser_timer *hbt)
>  {
> @@ -1046,11 +1041,12 @@ int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
>  	SLang_init_tty(0, 0, 0);
>  	SLtty_set_suspend_state(true);
>  
> -	return map_symbol__tui_annotate(&he->ms, evsel, hbt);
> +	return __hist_entry__tui_annotate(he, &he->ms, evsel, hbt);
>  }
>  
> -int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
> -			 struct hist_browser_timer *hbt)
> +int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
> +			       struct evsel *evsel,
> +			       struct hist_browser_timer *hbt)
>  {
>  	struct symbol *sym = ms->sym;
>  	struct annotation *notes = symbol__annotation(sym);
> @@ -1064,6 +1060,7 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
>  			.priv	 = ms,
>  			.use_navkeypressed = true,
>  		},
> +		.he = he,
>  	};
>  	struct dso *dso;
>  	int ret = -1, err;
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index d26b925e3d7f46af..55455c49faf01891 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -2484,8 +2484,8 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
>  	else
>  		evsel = hists_to_evsel(browser->hists);
>  
> -	err = map_symbol__tui_annotate(&act->ms, evsel, browser->hbt);
>  	he = hist_browser__selected_entry(browser);
> +	err = __hist_entry__tui_annotate(he, &act->ms, evsel, browser->hbt);
>  	/*
>  	 * offer option to annotate the other branch source or target
>  	 * (if they exists) when returning from annotate
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 8b5131d257b01e3e..0f640e4871744262 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -471,18 +471,6 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel);
>  int hist_entry__tty_annotate(struct hist_entry *he, struct evsel *evsel);
>  int hist_entry__tty_annotate2(struct hist_entry *he, struct evsel *evsel);
>  
> -#ifdef HAVE_SLANG_SUPPORT
> -int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
> -			 struct hist_browser_timer *hbt);
> -#else
> -static inline int symbol__tui_annotate(struct map_symbol *ms __maybe_unused,
> -				struct evsel *evsel  __maybe_unused,
> -				struct hist_browser_timer *hbt __maybe_unused)
> -{
> -	return 0;
> -}
> -#endif
> -
>  void annotation_options__init(void);
>  void annotation_options__exit(void);
>  
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index c64254088fc77246..11ae738772ca4f61 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -712,8 +712,9 @@ struct block_hist {
>  #include "../ui/keysyms.h"
>  void attr_to_script(char *buf, struct perf_event_attr *attr);
>  
> -int map_symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
> -			     struct hist_browser_timer *hbt);
> +int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
> +			       struct evsel *evsel,
> +			       struct hist_browser_timer *hbt);
>  
>  int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
>  			     struct hist_browser_timer *hbt);
> @@ -741,9 +742,10 @@ int evlist__tui_browse_hists(struct evlist *evlist __maybe_unused,
>  {
>  	return 0;
>  }
> -static inline int map_symbol__tui_annotate(struct map_symbol *ms __maybe_unused,
> -					   struct evsel *evsel __maybe_unused,
> -					   struct hist_browser_timer *hbt __maybe_unused)
> +static inline int __hist_entry__tui_annotate(struct hist_entry *he __maybe_unused,
> +					     struct map_symbol *ms __maybe_unused,
> +					     struct evsel *evsel __maybe_unused,
> +					     struct hist_browser_timer *hbt __maybe_unused)
>  {
>  	return 0;
>  }
> -- 
> 2.50.0
