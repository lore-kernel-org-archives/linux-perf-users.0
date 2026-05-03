Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24DC29AB1A;
	Sun,  3 May 2026 23:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777852186; cv=none; b=jZhHDySidNvy3lNLJLKil1a85956q1pfUtF2EGPIFPSWGozEHeb8eoIudnCZNxVsqUWuigKR4wQN89MBTmOTr7wWInDoVI2/+B1MwY768Cjddf55akL23ClXuPqvjzjkgMHW+lw+z1RRwN+hOUJ97QZq6gZ6TvJt+6kUxedsWtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777852186; c=relaxed/simple;
	bh=YXU6cwKu4rd5Sp/06vU48qzrTdOKuIaUtm5gpEVRccI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YN2AMGl1Ea2m8tWr5Ev9jpWvUgvMlcTyXkVQYHupK8q9myKtJcOfVnSieIEynVxY0r4Hx/DVZty+uxUQOOEgKu7VbXKCM5Q1r2BimZpbmsxVSJ8WkGj6XYVrcdY+dQ6Om6VYw/MiKQAhFXnf4+3jGiQkS8FFVAKENZzEuJaX6xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHuqzCtW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHuqzCtW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CF1C2BCB4;
	Sun,  3 May 2026 23:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777852186;
	bh=YXU6cwKu4rd5Sp/06vU48qzrTdOKuIaUtm5gpEVRccI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oHuqzCtWyrzcQMTYyEW174K4wNEpSWtTJp/idFpM2m/H2n0/mqItnQ4d25pIaSTmO
	 Us9MwS6ruPkj3n4Q9hNLskrSbo7WZ3/hKSlpPIwd9hvKqiPyi/uM7nnM/63yFJ0tp8
	 PUMTk3jUAjQaGL3zJ3ZHx9qZt/LRpZTiUC42Bib/RwRZg/ndunHSGA98GtROUVx19I
	 XY5pbgw1hiXYvUQWzgxqbRq+JlJDxCCAanOfxYRFPl5S01JKQ8vr6k61U1QhmplACZ
	 0m7COebbxvGi4LQo7ZxQCFmbWbOYL630MZlacm77MLkhU5oqNQy3Vry7Ycvarp6lel
	 0onZbV2UxVe+g==
Date: Sun, 3 May 2026 16:49:44 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Zecheng Li <zli94@ncsu.edu>,
	Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] perf probe-finder: Fix libdw API contract
 violations
Message-ID: <afffGDs7HlRhizlG@z2>
References: <20260503003552.1063540-1-irogers@google.com>
 <20260503171032.1559338-1-irogers@google.com>
 <20260503171032.1559338-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260503171032.1559338-5-irogers@google.com>

On Sun, May 03, 2026 at 10:10:30AM -0700, Ian Rogers wrote:
> Check return values of `dwarf_formsdata`, `dwarf_entrypc`,
> `dwarf_highpc`, `dwarf_bytesize`, `dwarf_attr`, `dwarf_decl_line`,
> `dwarf_getfuncs`, and `dwarf_formref_die`. Validate `dwarf_diename` and
> `dwarf_diecu` results to prevent potential crashes. Fix C90 mixed
> declarations.
> 
> Additionally:
>  - Avoid vfprintf undefined behavior with NULL strings by using the
>    `die_name()` helper for `dwarf_diename()` in `pr_*` calls,
>    including when warning about tail calls.
>  - Prevent NULL pointer dereference in `convert_variable_fields()`
>    when processing array elements for variables in registers.
>  - Fallback to offset 0 in `line_range_search_cb()` instead of
>    skipping functions without `DW_AT_decl_line`.
>  - Relax `dwarf_getfuncs` error checking in
>    `find_probe_point_by_func()` and `find_line_range_by_func()` to
>    prevent premature CU search aborts, ensuring robustness against
>    corrupted CUs.
> 
> Fixes: 66f69b219716 ("perf probe: Support DW_AT_const_value constant value")
> Fixes: 3d918a12a1b3 ("perf probe: Find fentry mcount fuzzed parameter location")
> Fixes: bcfc082150c6 ("perf probe: Remove redundant dwarf functions")
> Fixes: 221d061182b8 ("perf probe: Fix to search local variables in appropriate scope")
> Fixes: b55a87ade383 ("perf probe: Remove die() from probe-finder code")
> Fixes: 4c859351226c ("perf probe: Support glob wildcards for function name")
> Assisted-by: Gemini-CLI:Google Gemini 3
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
[SNIP]
> @@ -1293,13 +1318,17 @@ static int add_probe_trace_event(Dwarf_Die *sc_die, struct probe_finder *pf)
>  	if (ret < 0)
>  		goto end;
>  
> -	tev->point.realname = strdup(dwarf_diename(sc_die));
> +	realname = dwarf_diename(sc_die);
> +	tev->point.realname = strdup(realname ?: "unknown");

Could be:

	tev->point.realname = strdup(die_name(sc_die));


>  	if (!tev->point.realname) {
>  		ret = -ENOMEM;
>  		goto end;
>  	}
>  
> -	tev->lang = dwarf_srclang(dwarf_diecu(sc_die, &pf->cu_die, NULL, NULL));
> +	if (dwarf_diecu(sc_die, &cu_die_mem, NULL, NULL) != NULL)

I think it should fill pf->cu_die.

Thanks,
Namhyung


> +		tev->lang = dwarf_srclang(&cu_die_mem);
> +	else
> +		tev->lang = DW_LANG_C; // Fallback
>  
>  	pr_debug("Probe point found: %s+%lu\n", tev->point.symbol,
>  		 tev->point.offset);
> @@ -1794,7 +1823,8 @@ static int line_range_search_cb(Dwarf_Die *sp_die, void *data)
>  
>  	if (die_match_name(sp_die, lr->function) && die_is_func_def(sp_die)) {
>  		lf->fname = die_get_decl_file(sp_die);
> -		dwarf_decl_line(sp_die, &lr->offset);
> +		if (dwarf_decl_line(sp_die, &lr->offset) != 0)
> +			lr->offset = 0; // Fallback if no line info
>  		pr_debug("fname: %s, lineno:%d\n", lf->fname, lr->offset);
>  		lf->lno_s = lr->offset + lr->start;
>  		if (lf->lno_s < 0)	/* Overflow */
> @@ -1818,7 +1848,8 @@ static int line_range_search_cb(Dwarf_Die *sp_die, void *data)
>  static int find_line_range_by_func(struct line_finder *lf)
>  {
>  	struct dwarf_callback_param param = {.data = (void *)lf, .retval = 0};
> -	dwarf_getfuncs(&lf->cu_die, line_range_search_cb, &param, 0);
> +	if (dwarf_getfuncs(&lf->cu_die, line_range_search_cb, &param, 0) < 0)
> +		pr_debug("Failed to get functions from CU\n");
>  	return param.retval;
>  }
>  
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
