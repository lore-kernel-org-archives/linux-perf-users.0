Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831192DAFA9
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188150; cv=none; b=k2SbDAanh7NMoRAD1F76z+nzMk/P6pfZylvV5SeqCMUOae7IhEa/0yRGUYH2C0AxgHoVDTT+3tV7O2Y1eCdOksz1pid4xfkAJxOXGN2PyQpu5KCjgLOvsXVamgB53dfuNFMpEuon6HnegDj1W38X5U6g9682+ddHxI1UJyCWgws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188150; c=relaxed/simple;
	bh=aJrUAJYgs1RnEm5zOjgNrpG6jvoN3cd+T2b51cstEIc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OV5iNnWcp27NlTWG2GIoz2LULP+FXrpryn8pI8vAAsvBBIwRo4FFVuas42cq81fnrSs03uh2e0YIBMBJhd/GlhNZpK/8be4gteaVUg4lzHyzDPlm6FZ/IgT50IeH8pwaJzNczHxKAzqgBiNoDSep3e39yHV4ORjp/YweKX+MDeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQUfAZC1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQUfAZC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363541F000E9;
	Thu, 16 Jul 2026 07:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188149;
	bh=gM4c3BXuIY60Oo7NB2Rp0qJp5GX9fRXKawa9upH9qvE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FQUfAZC1v3dQdBGcH3TDEm3dwyq6v3tU+17tFL2Dfj/s9sbwZ6GzkGUd/fXLY/V9K
	 EixB9OagR8SfUcVVDqHBb/HR1wKRicCey76RximlztJILgLdP+LhyyHZtuDo84L+K+
	 ++gCUsNygtBUGLxaqnfCaZkzcgiySmiH7Nlc86uvI4g4Ftk79HkEcK87cbcjai27XV
	 beNC1VQtgzY2EBzw7iQjplawg4aF22zEudJcNdgIhD1vEPBbBCw9MUDb2bqsT1t59h
	 BLCX6nyoq5KlRF4ZQLxFSguUpWdPXpRkk2GsaZ1FOF12jiEo/EHVVEAnYnfsc3oy+L
	 dd08KvAi3ZjDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/10] perf ui hists: Fix dso_filter reference leak
 and exit zoom cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260716072351.560311-9-irogers@google.com>
References: <20260710053628.1861645-1-irogers@google.com>
 <20260716072351.560311-1-irogers@google.com>
 <20260716072351.560311-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 07:49:08 +0000
Message-Id: <20260716074909.363541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Calling `zfree(&hists->symbol_filter_str)` on a pointer that origi=
nated from an unallocated command-line argument causes a fatal crash.
- [Medium] The newly added exit cleanup blindly clears global command-line =
configurations like `socket_filter`, permanently destroying their effects a=
cross browser tabs.
--

--- Patch [9]: [PATCH v6 09/10] perf ui hists: Fix dso_filter reference lea=
k and exit zoom cleanup ---
commit 8368ef0112285b0a616e2a03e40dea893c6d1d5b
Author: Ian Rogers <irogers@google.com>

perf ui hists: Fix dso_filter reference leak and exit zoom cleanup

This commit fixes a potential use-after-free by acquiring and releasing a
reference to dso_filter in hists_browser__zoom_map(). It also fully resets
the persistent hists structure upon exiting the browser stack to prevent
state corruption across tab switches.

Closes: https://lore.kernel.org/linux-perf-users/20260709170834.52F1A1F000E=
9@smtp.kernel.org/

> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index 89c3d3dc69a27..e0ef756d95367 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
[ ... ]
> @@ -3491,6 +3492,16 @@ static int evsel__hists_browse(struct evsel *evsel=
, int nr_events, const char *h
>  out_free_stack:
>  	pstack__delete(browser->pstack);
>  	free_popup_actions(actions, MAX_OPTIONS);
> +	thread__zput(hists->thread_filter);
> +	dso__put((struct dso *)hists->dso_filter);
> +	hists->dso_filter =3D NULL;
> +	hists->socket_filter =3D -1;

[Severity: Medium]
Will this unconditionally clear the global command-line configuration?

If a user invokes perf report with --socket-filter <N>, the configuration
is stored in hists->socket_filter. When the user exits the TUI view (e.g.,
by pressing ESC), this cleanup resets the filter to -1.

Could this result in subsequent views of the same event incorrectly
displaying unfiltered data across browser tabs?

> +	perf_hpp__set_elide(HISTC_DSO, false);
> +	perf_hpp__set_elide(HISTC_THREAD, false);
> +	perf_hpp__set_elide(HISTC_SOCKET, false);
> +	hists__filter_by_dso(hists);
> +	hists__filter_by_thread(hists);
> +	hists__filter_by_socket(hists);
>  	zfree(&hists->symbol_filter_str);

[Severity: High]
Does this zfree() call attempt to free a non-heap pointer?

If a user invokes perf report --symbol-filter <sym>, the command-line
argument is assigned without dynamic allocation:

tools/perf/builtin-report.c:cmd_report() {
    ...
    report.symbol_filter_str =3D argv[0];
    ...
}

This pointer is then passed to hists->symbol_filter_str. When the TUI exits
evsel__hists_browse(), calling zfree() on this non-heap pointer will
trigger a fatal glibc abort. Can we avoid calling zfree() on pointers
originating from unallocated command-line arguments?

>  	hists__filter_by_symbol(hists);
>  out:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716072351.5603=
11-1-irogers@google.com?part=3D9
