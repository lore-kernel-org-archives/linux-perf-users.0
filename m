Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1A839A7F2
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 05:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783663136; cv=none; b=b6edxZom8pUigXLNHh1puX2DSUga5s7zCQHHykwJdwAqxdacO1s3c6NYPFpr8XgZljPm0ughnwZPX2WSHmt1ROzbzK4WezXugSrjyjEvxPYNPDaX87+hw682U4FrVtVzYCpjqm8AM23jSR75aXV8VrQ/9+bNUE2ARzKRH5opOvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783663136; c=relaxed/simple;
	bh=Y/54mXXrPQyB+3BCa26XY4XJ1V5zMixyC23IGc4MVtM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cD5QAeydXIV4yjwaY1OZSSaLJq+8/I3GKCNNY90J625E6G4oG1g2qlyiq+DNnQoFz4nvHYIyB5Tk+6y4UKQb2qcAObfZmmv5qGaDLLkkw+xqeX0lv8Yrr8Kp8i0BuqgfVY7OziWvWEX6hXYiHCyh0+PnQw9Bvn9rbW/kT3Os+ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOfjg01j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOfjg01j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FEA1F000E9;
	Fri, 10 Jul 2026 05:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783663134;
	bh=nyBVOOsAVnguQoKRuIzyJoPp6lsChKY+N7xU3pnpqJw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QOfjg01j8j5RD26IumgGoACgPyojZHaOwGntJa9dsxJMlVmSqcroT2ObsZ4TAi1km
	 joc3l3ggYewqI1bsDMVcNSHKPsb2yJnjuKbT0sTKHkhfnAvSyG2ZBOfgpBr4uWtng0
	 13K8oUhp93IQce+FVEqw0xLAE/8ok0JZDuP2uUEk3OyReCTlN4kzNTCdvB3cK46Kuq
	 WDkBs5C4mPg47ZDEeLcMeFG5xEFHpcMkTJ6OgDVKtNZrnjFyanpVZgNF95Pza/1XAQ
	 B7phf4VfF9dY81fQZ57A87iPrK+u0OKsQZOBZY2QEmwo2rFXJisQ7Cg4SXNt90VkBq
	 hc1B31oNilZkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/10] perf ui hists: Fix dso_filter reference leak
 and exit zoom cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260710053628.1861645-9-irogers@google.com>
References: <20260710024952.1668911-1-irogers@google.com>
 <20260710053628.1861645-1-irogers@google.com>
 <20260710053628.1861645-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 05:58:53 +0000
Message-Id: <20260710055854.55FEA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Unconditional free of non-heap memory causes a crash when exitin=
g the browser or replacing a command-line symbol filter.
- [Medium] Unconditionally clearing hists filters and un-eliding columns on=
 browser exit permanently destroys persistent command-line configurations.
--

--- Patch [9]: [PATCH v5 09/10] perf ui hists: Fix dso_filter reference lea=
k and exit zoom cleanup ---
commit 1af645505e5c140a87449557e914e317c6cf9b3b
Author: Ian Rogers <irogers@google.com>

perf ui hists: Fix dso_filter reference leak and exit zoom cleanup

In hists_browser__zoom_map(), the active dso is assigned as a raw pointer
to hists->dso_filter without acquiring a reference using dso__get(). This
patch properly acquires a reference when assigning the filter, and releases
it when clearing it, while also resetting the persistent hists structure
upon exit.

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
> +	perf_hpp__set_elide(HISTC_DSO, false);
> +	perf_hpp__set_elide(HISTC_THREAD, false);
> +	perf_hpp__set_elide(HISTC_SOCKET, false);
> +	hists__filter_by_dso(hists);
> +	hists__filter_by_thread(hists);
> +	hists__filter_by_socket(hists);

[Severity: Medium]
Could unconditionally clearing the hists filters and un-eliding columns here
permanently destroy persistent command-line configurations?

If a user launches perf report with persistent global filters like
--socket-filter 0, hists->socket_filter is initialized. When navigating into
the TUI for a specific event and then exiting back to the main menu (tab
switching), this teardown path unconditionally clears the filters (e.g.,
hists->socket_filter =3D -1) and un-elides the columns.

Could this destroy the user's requested command-line configuration for the
remainder of the session?

>  	zfree(&hists->symbol_filter_str);

[Severity: Medium]
Will this unconditional free cause a crash when exiting the browser or
replacing a command-line symbol filter?

When a user runs perf report --symbol-filter <sym>, the argv pointer is
assigned directly without strdup():

tools/perf/builtin-report.c:cmd_report() {
    ...
	report.symbol_filter_str =3D argv[0];
    ...
}

When exiting the browser, or when applying a new inline filter inside the T=
UI
via evsel__hists_browse(), this zfree() attempts to free the non-heap argv
string. Can this trigger a glibc abort?=20

This unconditional free was introduced by commit "perf ui hists: Fix stack
use-after-return in symbol_filter_str".

>  	hists__filter_by_symbol(hists);
>  out:
>  	hist_browser__delete(browser);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710053628.1861=
645-1-irogers@google.com?part=3D9
