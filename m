Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B43233928
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188129; cv=none; b=Zwa7icc8gkvQjVINpf14a6OVeLQ/wWqxEglZZKa4i5zAOgFlieHvIvcIbau5/iL3y7AeMaPhWs8pFmx0DjQHy6Zl4tYmzD5lR463VmysCLid3SnLSlPRKrTFK5vTmqSqufQj1m6yUDHYO510wJmIFQQdxdonwgkyGg3eypqGN3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188129; c=relaxed/simple;
	bh=5f+cPboBeBW+K6wLWQnjX8ZGQCAN+22iV1gXclrChMI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iXDILl9VBRGaTl7hJa/bLmhHapPxPBPutsXpcL7g4t1Z/Juj7a1Ku42tZ1y0oFbFxlBy0iCVQhy+txUMy5b5AazVDnc0YP0GFd0oYIZWoyWaG99+dwcLrHPkP80x7MD5oSgDu2SIDuVsII8tcJXp6ohInRyRFLUpK25KTVRKXyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rp1Dxm/a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rp1Dxm/a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BC71F000E9;
	Thu, 16 Jul 2026 07:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188128;
	bh=aliMVr09ZpBFa1NqK7qfKFiVHO4MZavM6nfOjgH2keQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rp1Dxm/aJ6H5BMdZb59zWIKFyM5te8i8N0D96n7SPeUdSe+EjWuflkhUdCeR7WvWu
	 3PSuxfBQN8n0qyJahmnlafsYX9gx500i4BSGqjfqUQ8wTTWN/MWSQy57261DHzp3q1
	 OElzr2U/5TMGE5x6B8VZ5W1iRcjn1qKdkfe/LmDY74cw0QZfO28lUYU1yKclCC6su9
	 BfE0gunsc3W5X/IyiYKW4zu5Gwn7l/EMhPp/yLvvmGAvfbwwL2jaoGIFn6LdSeudzV
	 A/OIZCykdkdM/JbqS2WzCOHt4pSJLyqUhtsTK6WDx2Eeaj3UNW+jE77GKnBez5la/F
	 XjGn+2Ok/RSyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/10] perf ui hists: Fix stack use-after-return in
 symbol_filter_str
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260716072351.560311-4-irogers@google.com>
References: <20260710053628.1861645-1-irogers@google.com>
 <20260716072351.560311-1-irogers@google.com>
 <20260716072351.560311-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 07:48:47 +0000
Message-Id: <20260716074848.01BC71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditional free of a non-heap `argv` pointer leading to a crash=
, and unintended destruction of the CLI symbol filter state.
--

--- Patch [4]: [PATCH v6 04/10] perf ui hists: Fix stack use-after-return i=
n symbol_filter_str ---
commit 7f822e6fd8f11b66dda82bea74a7a54f3a875831
Author: Ian Rogers <irogers@google.com>

perf ui hists: Fix stack use-after-return in symbol_filter_str

In evsel__hists_browse(), the local stack array 'buf' is assigned directly
to the persistent 'hists->symbol_filter_str' pointer. This commit fixes the
dangling pointer by duplicating the string and cleanly freeing it on exit.

> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index 793959574a9ad..4282ef1b81f75 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -3213,7 +3213,10 @@ static int evsel__hists_browse(struct evsel *evsel=
, int nr_events, const char *h
>  					"To remove the filter later, press / + ENTER.",
>  					buf, "ENTER: OK, ESC: Cancel",
>  					delay_secs * 2) =3D=3D K_ENTER) {
> -				hists->symbol_filter_str =3D *buf ? buf : NULL;
> +				char *new_filter =3D *buf ? strdup(buf) : NULL;
> +
> +				zfree(&hists->symbol_filter_str);

[Severity: High]
If the user invoked perf report with a command line option like
--symbol-filter=3Dmy_func, hists->symbol_filter_str will have been assigned
directly to the argv pointer in tools/perf/builtin-report.c:

report__collapse_hists() {
    ...
    hists->symbol_filter_str =3D rep->symbol_filter_str;

Will calling zfree() here cause a glibc invalid pointer crash when the
user interactively applies a new filter?

> +				hists->symbol_filter_str =3D new_filter;
>  				hists__filter_by_symbol(hists);
>  				hist_browser__reset(browser);
>  			}

[ ... ]

> @@ -3447,6 +3450,8 @@ static int evsel__hists_browse(struct evsel *evsel,=
 int nr_events, const char *h
>  	}
>  out_free_stack:
>  	pstack__delete(browser->pstack);
> +	zfree(&hists->symbol_filter_str);
> +	hists__filter_by_symbol(hists);

[Severity: High]
Similarly, does this unconditional free on exit crash if the filter was
initialized from the CLI?

Additionally, does unconditionally clearing this pointer permanently destroy
the --symbol-filter state for subsequent views of the same event?

>  out:
>  	hist_browser__delete(browser);
>  	free_popup_options(options, MAX_OPTIONS);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716072351.5603=
11-1-irogers@google.com?part=3D4
