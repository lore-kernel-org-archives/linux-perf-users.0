Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB6B3955D0
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 05:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783662944; cv=none; b=UmKOjzc3OTlE1aczKw5Tnh48dnZgaqUW3OLwpu1cBPgPVLPdyITCh/jRJi14mjF42UgxvllBp+Mkzt6Mz07xEY1uUkBO6aBhUaAfQF1QSrvjm5jJbdptSSkc+thHkmRJ/CY0z58HonRgLiprkg7D0nniDTvtSJ8AJWhoMCWQvVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783662944; c=relaxed/simple;
	bh=9mMGTm6PtG6VM2dE7Dg325OxhJk7ajxV9t99F+a3UDg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G7eCpUWMwdNPQl2ec3d1RAs13ZdL4W9VaryhD2YVXuvGGGfF/JTfmn1sq3JQUDiDiSGjCYCyCEVquAQTFFYuu/NA1esfyvfL6jsJBvRWTb3+InBVzYRKmilYOwHCP3LyPfq2DuC99UvANiFrdXl9rDUz/SHZhCUJFCWT+HP2OX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YISoAz7g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YISoAz7g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F3E1F000E9;
	Fri, 10 Jul 2026 05:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783662942;
	bh=C9V1x/qTanhb5eUGW1Flt2NUk0NAQV+tTlPMxZ2Oroo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YISoAz7g7PkFMBAm48vjpdIlF95lThdD0LjgsQ7yjxttdPBZ2326dn6JQLTHP7bTR
	 f3NxM/hk8xIOsI146DczFntHUiUSwG2UQCO3fnfeilS4gPBu1i02psdPejVY4+wuso
	 pleun8lWDX6CRqfI++cTYpt3FnykyNnRWYET4UL6ROh69tylPeSE5/YmtPtQUs/bZB
	 fTTQ3aB3KGxL2Eq59KusJ+MqMCsLrLhtYW4PWVGEvTtyKQIkUcAqFQxjZ6U591JxBK
	 iFe0rVx0QG3g7vIEfykKSmCYj+ikbGCfj7wSioMV/n/RGtzxNjoXRTv6WbCuATc8RM
	 /a05WN6ttztBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/10] perf ui hists: Fix uninitialized stack memory
 free on pstack allocation failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260710053628.1861645-2-irogers@google.com>
References: <20260710024952.1668911-1-irogers@google.com>
 <20260710053628.1861645-1-irogers@google.com>
 <20260710053628.1861645-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 05:55:42 +0000
Message-Id: <20260710055542.92F3E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Memory leak of dynamically allocated popup menu options during m=
ain interaction loop.
- [Medium] Unconditional pointer increments leave uninitialized or undefine=
d array slots on allocation failure.
- [Low] Missing explicit POSIX header inclusions breaking musl libc compati=
bility.
--

--- Patch [2]: [PATCH v5 02/10] perf ui hists: Fix uninitialized stack memo=
ry free on pstack allocation failure ---
commit 77f870443b8c814782369da867fcd967bbc78bdf
Author: Ian Rogers <irogers@google.com>

perf ui hists: Fix uninitialized stack memory free on pstack allocation fai=
lure

Fixes heap corruption by initializing the options and actions arrays before
the pstack allocation check, preventing an uninitialized stack pointer from
being passed to free_popup_options() if the allocation fails.

Link: https://lore.kernel.org/linux-perf-users/20260709035230.6DBEE1F000E9@=
smtp.kernel.org/

> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index 671961946d56c..45958bbe45092 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -3064,15 +3064,15 @@ static int evsel__hists_browse(struct evsel *evse=
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

[Severity: Medium]
This is a pre-existing issue, but does this code leak dynamically allocated
popup menu options during the main interaction loop?

Looking at evsel__hists_browse() when returning to the do_hotkey label:

tools/perf/ui/browsers/hists.c:evsel__hists_browse() {
    ...
do_hotkey:       // key came straight from options ui__popup_menu()
        choice =3D nr_options =3D 0;
    ...
}

It appears nr_options is reset to 0 without freeing the strings previously
allocated and stored in the options array. The subsequent iteration might
overwrite the string pointers, permanently leaking the previously allocated
strings. Could we ensure the strings are freed here?

[Severity: Low]
This is a pre-existing issue, but could missing explicit POSIX header
inclusions break musl libc compatibility?

For example, hist_browser__dump() uses access() and F_OK without explicitly
including <unistd.h>:

tools/perf/ui/browsers/hists.c:hist_browser__dump() {
    ...
    if (access(filename, F_OK))
    ...
}

Similarly, switch_data_file() relies on PATH_MAX without explicitly includi=
ng
<limits.h>:

tools/perf/ui/browsers/hists.c:switch_data_file() {
    ...
    char path[PATH_MAX];
    ...
}

Could these headers be explicitly included to ensure musl libc builds don't
fail?

[Severity: Medium]
This is a pre-existing issue, but do unconditional pointer increments here
leave uninitialized array slots on allocation failure?

Looking at add_script_opt():

tools/perf/ui/browsers/hists.c:add_script_opt() {
    ...
        optstr++;
        act++;
    ...
}

If a previous call to add_script_opt_2() fails (e.g., asprintf fails and
returns 0), the target string pointer is left unpopulated. However, this
code unconditionally increments the array pointers. If a subsequent allocat=
ion
succeeds, the array gets populated with a gap, but nr_options is still
incremented.

Might this cause the UI menu iteration to dereference an undefined or NULL
pointer at the gap?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710053628.1861=
645-1-irogers@google.com?part=3D2
