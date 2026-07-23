Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4E92C08C8
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jul 2026 05:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784784732; cv=none; b=LdRj82VBGCAgzVvxEqsZH0FuQhNkQa7NOBF3c3XG+IQP79/4Ybt6uPN4J28k1PdmN+Cuag9vHyYu16YClmUOR3fXxO91RqR1QDoGZAm21Aynj04/tZvH4x7Dq8D9VZsaRrB8gB6Wnh5SDh9z2EZvr996qyqMM+2SD9iSKN3sbPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784784732; c=relaxed/simple;
	bh=++MCgsF5QdrNR8pOHphdscg5R3/tJIyDth/ySiT5NSc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P/kAijtIxDKAz6AmG7ZkFD10ZLET4VAC1103ZDBxOAXiBtztvtuwn+KjN2uJi1j04joXfO8od1sojn8sf6OsWB98LIS4cj1OaIFKkuTsSn+/qhiPr4Ach/GuDniAinCiIgT41rxS1RSGWFYQIIxa79iyW0FBKVezYyh2Fio7VxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYHQ7Thk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYHQ7Thk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7F91F000E9;
	Thu, 23 Jul 2026 05:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784784731;
	bh=0drA5ZJIEmx5lTRcOzN9a/2zrg0f6TehLwc70uIkD74=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LYHQ7Thk4dRua0swlQbTD2nWvA62S8tQvm6RWnsxRJwghu1q/kLvRcQLqsuboWWAr
	 ZmcfU2qvt4elmgY+hocZ3FV8ecO/oX71uRbVa7RqcXNUFeASYdTUYuU7UZ35pr3awH
	 kC+/42wTg3vtMvX4lZT/FAFr6Pu1CwAhiCy3EtEHDHkxbYbEJfUOOIwyi9ej8nY2jG
	 nPcfkMoWywjGnUgScJsy1n12DbOmH8YcsiE+7n9DQRGTlrMvepw2QMSnuExen8gVeq
	 JT+mNZ6MudogsDXAmoCas5yujrBeTSi6ggGu62+4pSWMl7xaOH/eyOQZwhkaIYGdl/
	 1/QuT8XuARYow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/6] perf ui hists: Remove duplicated thread in
 popup_action
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260723045949.988740-7-irogers@google.com>
References: <20260716072351.560311-1-irogers@google.com>
 <20260723045949.988740-1-irogers@google.com>
 <20260723045949.988740-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 05:32:09 +0000
Message-Id: <20260723053210.CF7F91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The symbol filter string is not reset and freed when exiting the=
 browser, causing silent filter persistence and a memory leak.
--

--- Patch [6]: [PATCH v7 6/6] perf ui hists: Remove duplicated thread in po=
pup_action ---
commit 0930d22bfe566125dece911349b0d1a0a381a8df
Author: Ian Rogers <irogers@google.com>

perf ui hists: Remove duplicated thread in popup_action

struct popup_action has a thread but this is duplicated in the
map_symbol. Remove the non-map_symbol version so that there's only ever
1 thread with a popup_action.

> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index 39d83f15f23c6..c15874a491b43 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -2359,7 +2359,6 @@ static int hists_browser__scnprintf_title(struct hi=
st_browser *browser, char *bf
> =20
>  struct popup_action {
>  	unsigned long		time;
> -	struct thread		*thread;
>  	int (*fn)(struct hist_browser *browser, struct popup_action *act);
>  	struct map_symbol	ms;
>  	int			socket;

tools/perf/ui/browsers/hists.c:evsel__hists_browse() {
...
out_free_stack:
	pstack__delete(browser->pstack);
	free_popup_actions(actions, MAX_OPTIONS);
	thread__zput(hists->thread_filter);
	dso__put((struct dso *)hists->dso_filter);
	hists->dso_filter =3D NULL;
	perf_hpp__set_elide(HISTC_DSO, false);
	perf_hpp__set_elide(HISTC_THREAD, false);
	hists__filter_by_dso(hists);
	hists__filter_by_thread(hists);
out:
...
}

[Severity: Medium]
Does this exit cleanup path leak the symbol filter string?

It appears the dso and thread filters are properly reset here, but
hists->symbol_filter_str is completely omitted from the cleanup.

Could this result in a memory leak and silent filter persistence state? If a
user applies a symbol filter via the '/' hotkey and then exits the view,
the view might become silently filtered without UI indication in the stack
when switching browser tabs.

The commit message for 'perf ui hists: Fix stack use-after-return in
symbol_filter_str' explicitly promised to 'cleanly reset and free the symbol
filter string upon exiting the browser', but does this code fail to do so?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723045949.9887=
40-1-irogers@google.com?part=3D6
