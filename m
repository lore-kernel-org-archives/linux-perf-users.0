Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3A9386C24
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 05:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783662886; cv=none; b=tq112EJD7/4Et0oFQ5kV8TH8ngznoknmzQRKfoHNTlsxxOlbUjBe1JByiHTLLaJthURXZ9IZdHCiYrmoXtlMDlNoOsnCMfl4e6fBCyYhU5Y3CjTOAM2RA+q5RrYc57xcatNeAPS8oLOHYosdq9+TQ95p4wgcR3kiTLr98VOORMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783662886; c=relaxed/simple;
	bh=AzrsWWBA73vBpsyLonap47nbMVRWwwvkidz+zf0z6+o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sYHpLZ2vJKlRkpVVz8t3lCpMLkd2xH5KBmEuFdZj/TRIVLud386xNbYvgem/ECRkjko0+dtB/GhpNSN2R8KKgelu0YOCtqSsO8QfmWv84TiROCD1gYMf3i3Y0Jn2IEVHiDFx9X3uXhHDgvbtk7zx+LmTZzIu5nGCNj8t1bRLiJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nG8WH5t/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nG8WH5t/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E4B1F000E9;
	Fri, 10 Jul 2026 05:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783662884;
	bh=ZXTvRtd0nLXg9RdSaXTH5IlISn5gTHwVZcWprF+LtDw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nG8WH5t/QXacKKwFvQ6B/lol/tG9ZltI9naJ+uLAXNwX23mEAFGqhcvjQOQpLqxmh
	 6mQ/PimVvjVDllyv7i+6ECLjGq+8mrwoaThPD+r7jDHE+ccG93RCYjHA1MqtKe432m
	 BuuN0vKwGhYrbIaqykgPo5QjoW8X2gtHMW6x1EIXF3/VHVeGBagF6VLOozodMsVJIc
	 N2r8XZFde0gISbNVlgR7UgNFw4SigBti6Cm74/CymnRHGLgVtjBXlzXc+jPpgdesXN
	 BIA4n0uy1PvCGD0jt/idWReK+JIO68OAQtt6n6c6d8eo//b+lMFF3NXn7+okRtEGGX
	 pU42cQz+hIBPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/10] perf ui hists: Remove duplicated thread in
 popup_action
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260710053628.1861645-8-irogers@google.com>
References: <20260710024952.1668911-1-irogers@google.com>
 <20260710053628.1861645-1-irogers@google.com>
 <20260710053628.1861645-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 05:54:44 +0000
Message-Id: <20260710055444.69E4B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Unbalanced reference counting in the `K_LEFT` hotkey handler cau=
ses a premature free (UAF) of the map object.
- [Low] Removing the `thread` field from `struct popup_action` without upda=
ting remaining usages causes an immediate compilation error.
--

--- Patch [8]: [PATCH v5 08/10] perf ui hists: Remove duplicated thread in =
popup_action ---
commit 47ec26b37921590fc3d34f8d6da23b87b59a413a
Author: Ian Rogers <irogers@google.com>

perf ui hists: Remove duplicated thread in popup_action

This commit removes the thread field from struct popup_action as it is
already duplicated within the map_symbol structure. This ensures there is
only a single thread associated with a popup_action.

> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index 6145c7878c648..89c3d3dc69a27 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -2359,7 +2359,6 @@ static int hists_browser__scnprintf_title(struct hi=
st_browser *browser, char *bf
> =20
>  struct popup_action {
>  	unsigned long		time;
> -	struct thread		*thread;

[Severity: Low]
Is it possible this removal causes a compilation error? There appear to be
remaining references to the thread field in this file:

tools/perf/ui/browsers/hists.c:do_zoom_thread() {
    ...
	struct thread *thread =3D act->thread;
    ...
}

tools/perf/ui/browsers/hists.c:do_run_script() {
    ...
		if (act->thread) {
    ...
}

tools/perf/ui/browsers/hists.c:evsel__hists_browse() {
    ...
			} else if (top =3D=3D &browser->hists->thread_filter) {
				actions->thread =3D thread;
				do_zoom_thread(browser, actions);
    ...
}

[Severity: Medium]
Will this lead to unbalanced reference counting on the map object?

In the K_LEFT hotkey handler, an un-referenced map pointer is assigned into
the actions array before a continue statement:

tools/perf/ui/browsers/hists.c:evsel__hists_browse() {
    ...
			actions->ms.map =3D map;
			top =3D pstack__peek(browser->pstack);
			if (top =3D=3D &browser->hists->dso_filter) {
				/*
				 * No need to set actions->dso here since
				 * it's just to remove the current filter.
				 */
				do_zoom_dso(browser, actions);
			} else if (top =3D=3D &browser->hists->thread_filter) {
				actions->thread =3D thread;
				do_zoom_thread(browser, actions);
			} else if (top =3D=3D &browser->hists->socket_filter) {
				do_zoom_socket(browser, actions);
			}
			continue;
    ...
}

When the loop restarts at do_hotkey, free_popup_actions() drops references
for the actions array, which appears to prematurely free the map object:

tools/perf/ui/browsers/hists.c:evsel__hists_browse() {
    ...
do_hotkey:		 // key came straight from options ui__popup_menu()
		free_popup_options(options, MAX_OPTIONS);
		free_popup_actions(actions, MAX_OPTIONS);
    ...
}

>  	int (*fn)(struct hist_browser *browser, struct popup_action *act);
>  	struct map_symbol	ms;
>  	int			socket;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710053628.1861=
645-1-irogers@google.com?part=3D8
