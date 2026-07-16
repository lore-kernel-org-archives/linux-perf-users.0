Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97AB32A3FF
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187472; cv=none; b=OkG6Z+wSDpIqrZZM8/YLeqy++Fa+txrxeBcW06Gn+zEVzxm/Efi0iZ5KqMqumCa8qS6EspIVcQuSLXObb6opU/ve+9k5ZZQdXcNjD2gFsVrwHSlHAjDZXNY6Y5rJp7fpRazCnizok2zafRxAmuhn3MZ7pcswEw3eaUZg3KFhsRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187472; c=relaxed/simple;
	bh=3u/C4cIhLEyiEBLm60sy0GToBfeO3LS3b4v5b2qukic=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EVbLVtShPe7cbbGrCKKimZ+rq7FE8cKvF6srJUdWCJtEQBMPg92/PW8dFvj0Fsxl2umad79cvQ/nUi32ea4BLFiuejs2YGBvJQ22YGRXusHssbMYUAjUgjMWhVgqRPMyrzzTR3jtZV836hdjocmTWRxnUth3wNDP2xy71xtMaJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlLRXHbF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlLRXHbF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C301F000E9;
	Thu, 16 Jul 2026 07:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784187471;
	bh=g5+oYf3MytysocoF2BN7TjinL7LhcuWA5zaDGGtL7Gg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RlLRXHbFTA/fzdJeiTgwBCI91J1O6/FTEsLuTM0K+kZNM4IZ6LH5mqCgpMbmMzq3J
	 Lr2Qk82p5so91WGGrLIoYUWWw2Tlx9kndHMrWLYUJNvpzWSJ/PAAZcQMGcwtJnOkRG
	 hG1SCRs+a9tsdzw1CqPUvwqQx134aVsbXd0Pkk10v9P2aFCn0HP+pd6pLMYBb2MC0j
	 MsH4or/bY7MSGKhuMr/irbT0+a+qRqa9K0CDvI8bRW65qeYWVQqY1l4NpthPUohssz
	 kboq7v9UGxOtVkf41Q21AGO66QI1hglYUGt8GXlkTP7yc+25/YwPEB2IvS1/g9Pvo7
	 +SJmLjsAb6k6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/10] perf ui hists: Remove duplicated thread in
 popup_action
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260716072351.560311-8-irogers@google.com>
References: <20260710053628.1861645-1-irogers@google.com>
 <20260716072351.560311-1-irogers@google.com>
 <20260716072351.560311-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 07:37:50 +0000
Message-Id: <20260716073751.40C301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Assigning a raw pointer to `actions->ms.map` without taking a re=
ference, followed by `free_popup_actions()` dropping the reference, causes =
a refcount underflow.
- [Low] The commit removes the `thread` member from `struct popup_action` b=
ut leaves multiple read and write accesses to it intact, breaking the build.
--

--- Patch [8]: [PATCH v6 08/10] perf ui hists: Remove duplicated thread in =
popup_action ---
commit 1a6678f7f83293dd5e22da61354ad80c36378c0a
Author: Ian Rogers <irogers@google.com>

perf ui hists: Remove duplicated thread in popup_action

This commit removes the thread member from struct popup_action since it is
duplicated in the map_symbol structure. It aims to ensure there is only ever
one thread associated with a popup_action.

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
Does this removal cause a build regression?

There are still accesses to act->thread and actions->thread in several plac=
es
that will no longer compile:

tools/perf/ui/browsers/hists.c:do_zoom_thread() {
    struct thread *thread =3D act->thread;
...
}

tools/perf/ui/browsers/hists.c:do_run_script() {
...
    if (act->thread)
        len +=3D strlen(thread__comm_str(act->thread));
...
}

tools/perf/ui/browsers/hists.c:evsel__hists_browse() {
...
        } else if (top =3D=3D &browser->hists->thread_filter) {
            actions->thread =3D thread;
            do_zoom_thread(browser, actions);
        }
...
}

[Severity: Medium]
Can this code cause a refcount underflow regression?

In evsel__hists_browse(), when handling K_ESC or K_LEFT, actions->ms.map is
assigned directly without taking a reference:

tools/perf/ui/browsers/hists.c:evsel__hists_browse() {
...
        case K_ESC:
        case K_LEFT: {
            ...
            actions->ms.map =3D map;
            ...
            continue;
        }
...
}

The loop then hits continue, and at the do_hotkey label, free_popup_actions=
()
drops the reference, which can cause an underflow when map_symbol__exit()
calls map__zput():

tools/perf/ui/browsers/hists.c:evsel__hists_browse() {
...
do_hotkey:
        free_popup_options(options, MAX_OPTIONS);
        free_popup_actions(actions, MAX_OPTIONS);
...
}

>  	int (*fn)(struct hist_browser *browser, struct popup_action *act);
>  	struct map_symbol	ms;
>  	int			socket;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716072351.5603=
11-1-irogers@google.com?part=3D8
