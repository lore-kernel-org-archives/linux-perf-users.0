Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAFD19AD5C;
	Sat, 18 Jul 2026 05:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784353096; cv=none; b=HtftH5U7Ayln2AOwOsyG7vMwOI6GSu1YvH6rpsiba+i50dzTO7neKNbwuzFQAR2bh/2SV0NZTVG8YoeVYL1buOgFr0W9/Ud6K+4NESZY0JSPLYJykpdGngwn2yWgXMvC9lNV89aSI6X7+w8YSTWGCD0K1SdC7U+CvSMkXfEC0UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784353096; c=relaxed/simple;
	bh=s4+toEIpGHTIC7SWW/zBkFyg/3CA9TZmqUGwwkMMMfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiJFTyuRZu+Jpgd0X3v6xhrkyg50TojbdFcvKKR2qAzIpLHF+8RdX1BE+3PGDCU9JG/Dy6eR3gJqVc6sKRm2+uu49wTqGI7IZV240yzACXvFOqwzbM2y+6BZtnOSbew+gEwxvJy0pyrVC9WcswQvo7myKwGdAzQtyDkE9j4cY/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwnKxOGz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwnKxOGz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4A21F000E9;
	Sat, 18 Jul 2026 05:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784353095;
	bh=T9qgBCMTMjO6d1pm3sGtBY7xMfkGzbpgBhsDT5fAd88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YwnKxOGzCM3FA5HGXmqLxnXCvU4ZWPiZcHnRbJtEkd6gkEbsYMMICb9T2c33PACUR
	 uc2+tduaDd71oEf7viaYTqXUXCk3uM09LBwXvdYtCqIUkiRCT9Ox4Dg4QtMnY/BjWI
	 BCCEwastm/spxRl2fiGx5mKHashf7Mk5fzOBPGT5M7qTsY7tAI1tGI91QGjEfNwBvT
	 +418mqqBK9AyqZxPFarVgeVGA6NjXNCQESKpWwtA9mfiTpM4E5Ier+fRYHMkintvfy
	 iBCceT/Cwe5tSQPkELVhy7cjsZ8UPu3O5+PRTdWysj43vX1ltRi8BKitnvOYLZBDUi
	 AhiZcKPwv6yCg==
Date: Fri, 17 Jul 2026 22:38:13 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v6 04/10] perf ui hists: Fix stack use-after-return in
 symbol_filter_str
Message-ID: <alsRRWa6_Ju8I2x2@google.com>
References: <20260710053628.1861645-1-irogers@google.com>
 <20260716072351.560311-1-irogers@google.com>
 <20260716072351.560311-4-irogers@google.com>
 <20260716074848.01BC71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260716074848.01BC71F000E9@smtp.kernel.org>

On Thu, Jul 16, 2026 at 07:48:47AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Unconditional free of a non-heap `argv` pointer leading to a crash, and unintended destruction of the CLI symbol filter state.
> --
> 
> --- Patch [4]: [PATCH v6 04/10] perf ui hists: Fix stack use-after-return in symbol_filter_str ---
> commit 7f822e6fd8f11b66dda82bea74a7a54f3a875831
> Author: Ian Rogers <irogers@google.com>
> 
> perf ui hists: Fix stack use-after-return in symbol_filter_str
> 
> In evsel__hists_browse(), the local stack array 'buf' is assigned directly
> to the persistent 'hists->symbol_filter_str' pointer. This commit fixes the
> dangling pointer by duplicating the string and cleanly freeing it on exit.
> 
> > diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> > index 793959574a9ad..4282ef1b81f75 100644
> > --- a/tools/perf/ui/browsers/hists.c
> > +++ b/tools/perf/ui/browsers/hists.c
> > @@ -3213,7 +3213,10 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
> >  					"To remove the filter later, press / + ENTER.",
> >  					buf, "ENTER: OK, ESC: Cancel",
> >  					delay_secs * 2) == K_ENTER) {
> > -				hists->symbol_filter_str = *buf ? buf : NULL;
> > +				char *new_filter = *buf ? strdup(buf) : NULL;
> > +
> > +				zfree(&hists->symbol_filter_str);
> 
> [Severity: High]
> If the user invoked perf report with a command line option like
> --symbol-filter=my_func, hists->symbol_filter_str will have been assigned
> directly to the argv pointer in tools/perf/builtin-report.c:
> 
> report__collapse_hists() {
>     ...
>     hists->symbol_filter_str = rep->symbol_filter_str;
> 
> Will calling zfree() here cause a glibc invalid pointer crash when the
> user interactively applies a new filter?

Right, please update there to copy the command line string.  It seems
there's a test code to set it too.

Thanks,
Namhyung

> 
> > +				hists->symbol_filter_str = new_filter;
> >  				hists__filter_by_symbol(hists);
> >  				hist_browser__reset(browser);
> >  			}
> 
> [ ... ]
> 
> > @@ -3447,6 +3450,8 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
> >  	}
> >  out_free_stack:
> >  	pstack__delete(browser->pstack);
> > +	zfree(&hists->symbol_filter_str);
> > +	hists__filter_by_symbol(hists);
> 
> [Severity: High]
> Similarly, does this unconditional free on exit crash if the filter was
> initialized from the CLI?
> 
> Additionally, does unconditionally clearing this pointer permanently destroy
> the --symbol-filter state for subsequent views of the same event?
> 
> >  out:
> >  	hist_browser__delete(browser);
> >  	free_popup_options(options, MAX_OPTIONS);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260716072351.560311-1-irogers@google.com?part=4
