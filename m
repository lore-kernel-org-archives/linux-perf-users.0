Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957D7347DD
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783616916; cv=none; b=CbGFJ9AGNUvj/NT9zelB98SEyDTCqd3DVhyvOO6H0WAB0VSMa24Mlxz8ZPacuq0ABm8jJnR9NvQ+vBQUm5Wr7qa4980/ivGpOBQA80F8FCWmk0sJ1VJoCu86h61xMemO+l9uzqS/m+81LXaRhcJF3FMy2aMHMturd8+rlYWvRFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783616916; c=relaxed/simple;
	bh=rAB89+q4BvtPNRNZOrCbTB44ER+rIW0KD9fKl8NJoRc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OIPl65wpvwVLDPoKc9uWm/f0V9fkdTbC7919HBoMlvbgCE81puNWYj6JGraXJmBjQwFfstnvO/E/Bsvmqdnyncb2Zlwea9pDDrtNs07WLwAQs3z7G30ExEs3onIhhFDI9Gh7Trj3SnZo+4Giz6LqPuNT5lzc8r7WdZ1Oli+DBvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoyBmMYi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoyBmMYi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F1A1F000E9;
	Thu,  9 Jul 2026 17:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783616914;
	bh=P9mlvvA6//evoeRaJraJ+0FrxuNsVMoRcnx548X03Hg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XoyBmMYiKe3qrMbTQcDQla2cabSMe6AIzt1AC6l/KbVdAassKljdI6jQOJ6BLbAKX
	 vUB9MOQQJV8g9PTgrbipD4X1chWfsP/vWYFc91/fxKIWjtwHbiu+BlyEXJu6lXhYqJ
	 RiERz9VEvYLcUp7AGwC7Khe7wySA+hMYWj3LhhlOpndUF3zVWMeDNpotrlfDMkzxWX
	 a7FFPyihacGsFyQJ2Ru1evo2rZ4sRZqXw4p2uHhREq4iqCLmMuJHSLo3qu2w+ncqk5
	 c+lkvfc3Taaucdy/SvfnKWJpv74A0Pc0A5qqTVTUsH2jbTL4G3XwSHsIN9K5dMmPlT
	 h7V2AmOaoJz/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] perf hists browser: Increase MAX_OPTIONS to
 prevent stack buffer overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260709165220.1411149-4-irogers@google.com>
References: <20260709033701.1117943-1-irogers@google.com>
 <20260709165220.1411149-1-irogers@google.com>
 <20260709165220.1411149-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 17:08:33 +0000
Message-Id: <20260709170834.52F1A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Memory leak of dynamically allocated popup menu strings in the i=
nteraction loop.
- [Medium] Missing reference counting for `dso_filter` can lead to a use-af=
ter-free.
- [Medium] Unconditional pointer increment after string allocation failure =
leads to a NULL pointer dereference.
--

--- Patch [4]: [PATCH v3 4/4] perf hists browser: Increase MAX_OPTIONS to p=
revent stack buffer overflow ---
commit b8ca9e63522e300d76cedfda674dbc631afbc3e2
Author: Ian Rogers <irogers@google.com>

perf hists browser: Increase MAX_OPTIONS to prevent stack buffer overflow

The commit increases MAX_OPTIONS in evsel__hists_browse() from 16 to 32 to
prevent a potential stack buffer overflow when adding menu options. It also
moves the memset of options and actions earlier in the function to avoid
reading uninitialized memory on an error path.

Closes: https://lore.kernel.org/linux-perf-users/20260708235834.3FB771F00A3=
A@smtp.kernel.org/
Fixes: f2b487db45f2 ("perf hists browser: Fix possible memory leak")

> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index a93846b8dc885..8e54c29728d1c 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -3002,7 +3002,7 @@ static int evsel__hists_browse(struct evsel *evsel,=
 int nr_events, const char *h
>  	struct hists *hists =3D evsel__hists(evsel);
>  	struct hist_browser *browser =3D perf_evsel_browser__new(evsel, hbt, en=
v);
>  	struct branch_info *bi =3D NULL;
> -#define MAX_OPTIONS  16
> +#define MAX_OPTIONS  32
>  	char *options[MAX_OPTIONS];
>  	struct popup_action actions[MAX_OPTIONS];
>  	int nr_options =3D 0;
> @@ -3063,15 +3063,15 @@ static int evsel__hists_browse(struct evsel *evse=
l, int nr_events, const char *h
>  		browser->min_pcnt =3D min_pcnt;
>  	hist_browser__update_nr_entries(browser);
> =20
> +	memset(options, 0, sizeof(options));
> +	memset(actions, 0, sizeof(actions));
> +
>  	browser->pstack =3D pstack__new(3);
>  	if (browser->pstack =3D=3D NULL)
>  		goto out;
> =20
>  	ui_helpline__push(helpline);
> =20
> -	memset(options, 0, sizeof(options));
> -	memset(actions, 0, sizeof(actions));
> -
>  	if (symbol_conf.col_width_list_str)
>  		perf_hpp__set_user_width(symbol_conf.col_width_list_str);
> =20

[Severity: Medium]
This is a pre-existing issue, but I noticed a potential memory leak in
evsel__hists_browse() later in the same function when handling the options
array.

When the interactive loop runs, the dynamically allocated strings added to
the options array via asprintf() appear to be abandoned because nr_options
is reset to 0 in each iteration without freeing them:

tools/perf/ui/browsers/hists.c:evsel__hists_browse() {
    ...
    while (1) {
        ...
        key =3D 0; // reset key
do_hotkey:       // key came straight from options ui__popup_menu()
        choice =3D nr_options =3D 0;
    ...
}

Does this cause memory to leak continuously as the user interacts with the
menu and new strings are allocated?


[Severity: Medium]
This is another pre-existing issue, but I noticed a potential missing
reference count in hists_browser__zoom_map().

The reference-counted dso struct is assigned as a raw pointer without
acquiring a reference via dso__get():

tools/perf/ui/browsers/hists.c:hists_browser__zoom_map() {
    ...
    browser->hists->dso_filter =3D dso;
    ...
}

Could this lead to a use-after-free defect if the underlying dso is freed
while the filter remains active, since it's later cleared without calling
dso__put()?


[Severity: Medium]
This is also a pre-existing issue, but I found a sequence in add_script_opt=
()
that might cause a NULL pointer dereference.

If the first call to add_script_opt_2() fails (for example, due to an
asprintf allocation failure), the pointer remains unset. The function then
unconditionally increments the optstr and act pointers:

tools/perf/ui/browsers/hists.c:add_script_opt() {
    ...
    optstr++;
    act++;
    ...
}

If a second allocation then completes successfully, the caller increments
nr_options, but the options array would contain an uninitialized or NULL
pointer gap at its first active index.

Can this NULL pointer be subsequently dereferenced by ui__popup_menu() via
ui_browser__write_nstring()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709165220.1411=
149-1-irogers@google.com?part=3D4
