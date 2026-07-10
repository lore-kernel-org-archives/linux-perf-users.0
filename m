Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA852E974D
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 03:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783652962; cv=none; b=Xi04ya4D8w4DrscR9oFO75sMatW1IZsPMOsKfvSB7QmCnBMClINuUllNMede5+rC27Xf7X5+1Gh1CFdhnJVor/Wf3VCCYooGtEzM0x9SgekuWhyyS0CqZpCm5ubaLmTMPAQ/O3f09uwuZQwT8yHycBaxOS1SALk/Qj3CM8VHzpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783652962; c=relaxed/simple;
	bh=0XLR6AAyQLtWoXrcNxPlRZL82NrD3tSmjAWF+2+8Ea8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vh2h2zk++zsmZ6fCmyoXuRFkTqFknPPOTjtMUQ5B3bxp7gozFk0geU+nOCPrieP3ZO0jEngU2yyy1hhl2J5ycFppfEqkjaAqkcrifpQicTqravpIRvAF/j5GCk3A2pUFAsQc6oYbHszeTZ123cSWeNGMt6Qxfw44q8HAyl/VBRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imjETXJO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imjETXJO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFB31F000E9;
	Fri, 10 Jul 2026 03:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783652960;
	bh=HekEdWK28GDhIZL7aWIDIGhvkGQ7KFRRi5GCznxuGNY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=imjETXJOZm9btWdvgWjd4TpCWVxz3uN1ZkqN1FkKvDGAcq3abv4KSOPpJYkrjzEZt
	 W7Pxfzm7hAGRRe9bwu9Z7O4eNfF6BYSPGtXUWdGgf5biM2icRE16OIsIIaZ9y13gjK
	 H/Kixu89J8rJ0OffPiSDfbNHYiaYEtPh4ERkiDcOFq1Dc0AszzNHqVuqAXDni6Pcys
	 nj7k7qKCbOf56dJ2c+nSeU2DxLG9pF93LSMkqZf2hJiui3Y1MmD41btu08JHq/YVak
	 LBNz34u7Kl8nBFN7YIL/8ASsrBAbGHrvIRnafL+dYDa8Gj5ypivCHUpxeFPID5MYx6
	 4pYgMuuiogofw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/9] perf ui hists: Fix uninitialized stack memory
 free on pstack allocation failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260710024952.1668911-4-irogers@google.com>
References: <20260709165220.1411149-1-irogers@google.com>
 <20260710024952.1668911-1-irogers@google.com>
 <20260710024952.1668911-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 03:09:20 +0000
Message-Id: <20260710030920.8FFB31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Stack Use-After-Free (Dangling Pointer) in symbol filter string.
--

--- Patch [4]: [PATCH v4 4/9] perf ui hists: Fix uninitialized stack memory=
 free on pstack allocation failure ---
commit afaaff3407afa197242fdd0b413eb9b246beadbe
Author: Ian Rogers <irogers@google.com>

perf ui hists: Fix uninitialized stack memory free on pstack allocation fai=
lure

Fixes heap corruption by initializing the options and actions arrays before
the pstack allocation check, preventing an uninitialized stack pointer from
being passed to free_popup_options() if the allocation fails.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/20260709035230.6DBEE1F000E=
9@smtp.kernel.org/
Fixes: f2b487db45f2 ("perf hists browser: Fix possible memory leak")

> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index c6cfbcc580617..8b4c7510991f3 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -3064,15 +3064,15 @@ static int evsel__hists_browse(struct evsel *evse=
l, int nr_events, const char *h
>  		browser->min_pcnt =3D min_pcnt;
>  	hist_browser__update_nr_entries(browser);
> =20

[Severity: High]
This is a pre-existing issue, but I noticed a potential stack use-after-free
involving the local variable buf that is defined in evsel__hists_browse().

Later in evsel__hists_browse(), the local stack array buf is assigned to
the persistent hists->symbol_filter_str:

hists->symbol_filter_str =3D *buf ? buf : NULL;

If the user presses TAB to switch to another event, evsel__hists_browse()
returns and pops its stack frame.

Can this dangling pointer be accessed by the background timer? It looks
like perf_top__sort_new_samples() periodically iterates over events and
calls hists__filter_entry_by_symbol(), which then dereferences the pointer:

tools/perf/util/hist.c:hists__filter_entry_by_symbol() {
    ...
    if (hists->symbol_filter_str !=3D NULL &&
        (!he->ms.sym || strstr(he->ms.sym->name,
                   hists->symbol_filter_str) =3D=3D NULL)) {
    ...
}

Could this read uninitialized or overwritten stack memory from the current
frame if a timer fires after the symbol filter string is set?

> +	memset(options, 0, sizeof(options));
> +	memset(actions, 0, sizeof(actions));
> +
>  	browser->pstack =3D pstack__new(3);
>  	if (browser->pstack =3D=3D NULL)
>  		goto out;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710024952.1668=
911-1-irogers@google.com?part=3D4
