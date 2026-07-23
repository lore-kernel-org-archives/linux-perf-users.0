Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C13F394470
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jul 2026 05:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783847; cv=none; b=c7tlOouyYaJit5z7eSgNwCV79GOezlA+4r/4Eg8DnIOJmxRs6sK1oK+SsdSQWTmd40rLjog3SvpiXtp+KWFKAawqRlksnpsbuJNECzs97mVU6RXMKQ+rClAbQi2twYZKJ8fFCEGWvIzSEfxhM69G4cTuCsgEbQHDodeLMOqFI3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783847; c=relaxed/simple;
	bh=0PKqYVq3iJpPWtA1Iz92z65yOAeiK5uQMGQw3EaR6jE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SEnINQBz+u+UL2SWHO6FeB8LAloZRsF8Uti7W9UQ7Mk2h7nTbCKst7hp2otw515waGcCtq6RD670Nx+W+7D6/7pW0gAeR5E9eA1kGSDREVNJuBy0b/IW1crwCQC8BsN2KZQsEiSr6U56xFYpmxVa36ZSV5AZ823WOJX1xlqhrzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dc3AKeW2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dc3AKeW2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5661F000E9;
	Thu, 23 Jul 2026 05:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784783846;
	bh=EVEU/AKneANuBuwIUTszwWG67RgInSBll8TYGIcLkmY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dc3AKeW2MzYdygwDm/SJp7QtCrMeu9SL44e2tiFJTJPAqEDHzRcE/A+Sgk8xA5WCJ
	 lApBuKg992c0AgHuWp1bj6ojcK8YpZFICQsweHBVOYJ67Vh19B0fnFBmShEqRHj10N
	 s6m9zCJW/ZpELt960ryPaPJQ0JCqQdnQ/eao/Jloji6k8dwxHab5HtiX+uTwh3E1M2
	 0H051RbLe2wsGz5EOjsKCRkeb5FEOLPM/5XGnJQM7O3f3z5jcXP1WAajAxo6DAE4Fn
	 a/B/ujNlBfFxp8LyeZl4EV5MSMvfu9/ttX/k8TDmJhrXyEQ0hodBLi/hzwwG/zDwKY
	 xUgfzOBx8wF8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/6] perf ui hists: Fix stack use-after-return in
 symbol_filter_str
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260723045949.988740-2-irogers@google.com>
References: <20260716072351.560311-1-irogers@google.com>
 <20260723045949.988740-1-irogers@google.com>
 <20260723045949.988740-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 05:17:25 +0000
Message-Id: <20260723051725.ED5661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing check for `strdup()` allocation failure causes silent mi=
sbehavior.
--

--- Patch [1]: [PATCH v7 1/6] perf ui hists: Fix stack use-after-return in =
symbol_filter_str ---
commit 4572e956370768dd763a1eddb42a82592b917d6a
Author: Ian Rogers <irogers@google.com>

perf ui hists: Fix stack use-after-return in symbol_filter_str

This commit fixes a stack use-after-return bug by duplicating the filter
string with strdup() instead of assigning a local stack array. It also
ensures the memory is correctly cleaned up using zfree().

> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 10db1e5f1e6c4..60d1f166629e0 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -726,8 +726,11 @@ static int report__collapse_hists(struct report *rep)
>  	evlist__for_each_entry(rep->session->evlist, pos) {
>  		struct hists *hists =3D evsel__hists(pos);
> =20
> -		if (pos->core.idx =3D=3D 0)
> -			hists->symbol_filter_str =3D rep->symbol_filter_str;
> +		if (pos->core.idx =3D=3D 0) {
> +			hists->symbol_filter_str =3D
> +				rep->symbol_filter_str ?
> +				strdup(rep->symbol_filter_str) : NULL;

[Severity: Medium]
If strdup() fails due to out-of-memory, it will return NULL. Does this sile=
ntly
ignore the user's requested symbol filter without propagating the error or
warning the user?

> +		}
> =20
>  		hists->socket_filter =3D rep->socket_filter;
> =20

[ ... ]

> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index b6002724bc3a6..be8a6b1697229 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -3220,7 +3220,10 @@ static int evsel__hists_browse(struct evsel *evsel=
, int nr_events, const char *h
>  					"To remove the filter later, press / + ENTER.",
>  					buf, "ENTER: OK, ESC: Cancel",
>  					delay_secs * 2) =3D=3D K_ENTER) {
> -				hists->symbol_filter_str =3D *buf ? buf : NULL;
> +				char *new_filter =3D *buf ? strdup(buf) : NULL;
> +

[Severity: Medium]
If strdup() fails, new_filter will be NULL. Could this cause the user's
existing filter to be unconditionally deleted and replaced with NULL without
warning?

> +				zfree(&hists->symbol_filter_str);
> +				hists->symbol_filter_str =3D new_filter;
>  				hists__filter_by_symbol(hists);
>  				hist_browser__reset(browser);
>  			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723045949.9887=
40-1-irogers@google.com?part=3D1
