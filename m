Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE0835F5E4
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 03:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783652749; cv=none; b=L2ib+vgxXrOSNq9AiTAIW4iauD1IteDPkWO2pOTrAcb7KEtOl6sWATJ1eQ9qWx+LLZSALsqX8rZQ32ECq92hNQX+on0UINIvlf9mlTPb0SmxEJPf9KfwMmL4A0DhDqfSl7JOsgl1HsuukFVCZYCgzngQ+upAiX2XemsvpugzW14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783652749; c=relaxed/simple;
	bh=oCb6KhSeubXqC/pWCjrDYZngKWWgM1o8k/mB9hRSMeM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TUWBiAl630z5xU5UrMxidgDzTSdRTyZ5U6F9/1C+mQDOjJlarxvw7JoyAhxVM/2QK96CXfGBRWyoeK8hcWuD9D3f8G/Knsam3roHvHKzuS6I+yCicwL4aSdV1wOJjWqSPoZ8XC01/GQHKp6fMGyMhbBplPHH2eMfQjY6qYwRE3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dp8cePaj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dp8cePaj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93851F000E9;
	Fri, 10 Jul 2026 03:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783652747;
	bh=vRTBF/WleufcWgdGanP1QIrne/X+e1R3UCbzgeRbfz8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dp8cePajlw+i6RlelgT1zDc3OZe8lmcfTfl719Qbpr9UZqd0kn55ErQqO3uPANoKn
	 I+Wzg5yjNXKpKuUpKNNG590a11rOOyaX1DX5+f5DEs2Ffpezt8pQ6MKWnQI2QiXH19
	 YK1vDirMYyRMmA9vSHStOUshi02gR91i60EZ9x9lHqj2T4jKWcaV5enoN0MRz8eH+s
	 Xfm0U+48xw7HWAtJlbSnCKpKxLjZVdjdtMy8WtLT1n+QQUlKf3iQPg3NnbiE7N0OTP
	 44VXRYve5NjXudKC7KjvsMGiLcF/444qBXmTY9rOszkJFyFLMOe2wvUWWD8AAtMfFr
	 vYMQBtawr+A8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/9] perf ui hists: Fix memory leak in
 evsel__hists_browse() interactive loop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260710024952.1668911-5-irogers@google.com>
References: <20260709165220.1411149-1-irogers@google.com>
 <20260710024952.1668911-1-irogers@google.com>
 <20260710024952.1668911-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 03:05:47 +0000
Message-Id: <20260710030547.A93851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Raw pointer assignment of reference-counted structs violates REF=
CNT_CHECKING lifecycle rules.

Pre-existing issues:
- [High] Stack-allocated buffer `buf` is assigned to a long-lived structure=
 field `hists->symbol_filter_str`, leading to a Use-After-Free when the fun=
ction returns.
--

--- Patch [5]: [PATCH v4 5/9] perf ui hists: Fix memory leak in evsel__hist=
s_browse() interactive loop ---
commit 8a51dcaa31cd8e1cae7b31630b60408cb040d87b
Author: Ian Rogers <irogers@google.com>

perf ui hists: Fix memory leak in evsel__hists_browse() interactive loop

In the evsel__hists_browse() interactive loop, the options array is
filled with strings dynamically allocated via asprintf() and displayed
in a popup menu. However, if the user picks a hotkey or triggers another
menu iteration, nr_options is reset to 0 without freeing the prior
strings, leaving them abandoned in the array and leaking memory on every
menu event.

Fix it by invoking free_popup_options(options, MAX_OPTIONS) at the
beginning of each menu iteration (covering both the while(1) start and
the 'do_hotkey:' label).

Closes: https://lore.kernel.org/linux-perf-users/20260709170834.52F1A1F000E=
9@smtp.kernel.org/

> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index 8b4c7510991f3..aed154622467f 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -3087,6 +3087,7 @@ static int evsel__hists_browse(struct evsel *evsel,=
 int nr_events, const char *h
> =20
>  		key =3D 0; // reset key
>  do_hotkey:		 // key came straight from options ui__popup_menu()
> +		free_popup_options(options, MAX_OPTIONS);
>  		choice =3D nr_options =3D 0;
>  		key =3D hist_browser__run(browser, helpline, warn_lost_event, key);
> =20

[ ... ]

> @@ -3156,6 +3157,6 @@ static int evsel__hists_browse(struct evsel *evsel,=
 int nr_events, const char *h
>  					if (!bi || !bi->to.ms.map)
>  						continue;
> =20
>  					actions->ms.sym =3D symbol__new_unresolved(bi->to.al_addr, bi->to.m=
s.map);
>  					actions->ms.thread =3D bi->to.ms.thread;
>  					actions->ms.map =3D bi->to.ms.map;

[Severity: Medium]
In tools/perf/ui/browsers/hists.c:evsel__hists_browse(), is it safe to
directly assign actions->ms.thread without using thread__get() when
processing the SORT_MODE__BRANCH selection?

It seems this raw pointer assignment of a reference-counted struct violates
lifecycle rules. Could this lead to asan use-after-free traps or lsan
leaks during the interactive menu loop?

[ ... ]

> @@ -3215,6 +3216,6 @@ static int evsel__hists_browse(struct evsel *evsel,=
 int nr_events, const char *h
>  		case '/':
>  			if (ui_browser__input_window("Symbol to show",
>  					"Please enter the name of symbol you want to see.\n"
>  					"To remove the filter later, press / + ENTER.",
>  					buf, "ENTER: OK, ESC: Cancel",
>  					delay_secs * 2) =3D=3D K_ENTER) {
>  				hists->symbol_filter_str =3D *buf ? buf : NULL;
>  				hists__filter_by_symbol(hists);

[Severity: High]
This is a pre-existing issue, but in tools/perf/ui/browsers/hists.c:evsel__=
hists_browse(),
doesn't this assign a stack-allocated buffer (buf) to the persistent
hists->symbol_filter_str pointer without duplicating it?

If a user applies a symbol filter in the single-event browser view and then
exits, could this cause a use-after-free when evsel__hists_browse() returns
while a background thread is still applying filters?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710024952.1668=
911-1-irogers@google.com?part=3D5
