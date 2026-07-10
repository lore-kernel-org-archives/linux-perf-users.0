Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D110639B49E
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 05:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783663147; cv=none; b=WHXu6009Z1rbFPRaERWQ0m3PdZgIz9XZVW0INC9YmYi08qouVGa3W/IAjU5aew+4TyulLluV97sCUeFMnTfkhtopdknBnc8wsq/OwXIxOXiCZ4OlxkeWdT+noTkcdZzVl05ONOLESiTh9ELcZSy6DQ+dll3z5Ev1iNusLhp5xEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783663147; c=relaxed/simple;
	bh=a/N0pYDBoiCIjwje9WeFp2ttyz5qANa9WAkqBIyKArA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u4o/EC6MoDVlBw4C7Ys55uc1QHMy+f8ST7dBkhYSghpDXVoovNDLEToh2q3bVLLyxgOVRU1GKdWezlT/xbxCk2wG/fJL3xAK83NJWqaIkW0ho3QAGlEgzgqWi7eaXeteSj6JigH1FLcd5aU25tmymPmJVQUH5JxWqN6IUB2w+jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOeshz3W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOeshz3W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0D21F000E9;
	Fri, 10 Jul 2026 05:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783663145;
	bh=KMvlqs/Li+SSfW4im+1LiLTBxwd8yI6wubG+pLCgL4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OOeshz3WzmJVTf7ITv2KlDOhZ2fLzAt6nOz3iNV0zluPI1kkICcb9m0loKOOmvnOg
	 fLy7HGxpAPoRlVNikXY9M0cAodXkF4rzZWlETr7yqmN7anhJ6b5Ah58Dcq+STV2hRR
	 mojyv8Ahy6a9KOT0ataky0aXzHRUD7PQh3QTmdzwIGy8lVUJStiWDK5sEOFXl2sbKV
	 gNcWaqUmttETpEoj3LsPxUhyAPqcIkll2zLtfGYvBZZGAfLMOrE8WURTB6USPV+qe2
	 wLvw5srul1dSbNY2ycyFL48Mv5DLQCq93Gled8k8m0N7ts1ZHyhwOKD7D1J98Zp470
	 84u8L7M9XhL4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/10] perf ui hists: Fix stack use-after-return in
 symbol_filter_str
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260710053628.1861645-4-irogers@google.com>
References: <20260710024952.1668911-1-irogers@google.com>
 <20260710053628.1861645-1-irogers@google.com>
 <20260710053628.1861645-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 05:59:04 +0000
Message-Id: <20260710055905.3B0D21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Calling `zfree()` on `hists->symbol_filter_str` attempts to free a=
 non-heap pointer (`argv`), causing `perf report` to crash.
- [Medium] Exiting the browser view permanently and unintentionally deletes=
 the global command-line symbol filter.
--

--- Patch [4]: [PATCH v5 04/10] perf ui hists: Fix stack use-after-return i=
n symbol_filter_str ---
commit d9e40115ffaf92f2da5c8c579054c376ce729ed4
Author: Ian Rogers <irogers@google.com>

perf ui hists: Fix stack use-after-return in symbol_filter_str

The patch duplicates the input string using strdup() to prevent a stack
use-after-return, safely invoking zfree() when modifying the filter, and
resetting the filter string upon exiting the browser.

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
Will calling zfree() here crash perf if the symbol filter was provided via
the command line?

When a user runs perf report with a command line filter, the argv pointer is
eventually assigned to the hists struct:

tools/perf/builtin-report.c:cmd_report() {
    ...
    report.symbol_filter_str =3D argv[0];
    ...
}

tools/perf/builtin-report.c:report__collapse_hists() {
    ...
    hists->symbol_filter_str =3D rep->symbol_filter_str;
    ...
}

Attempting to free this non-heap pointer in evsel__hists_browse() would
trigger an invalid free abort in glibc.

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

[Severity: Medium]
Does this unconditional cleanup unintentionally destroy the global
command-line filter state upon exiting the UI function?

If a user opens perf report with a command-line filter, views an event's
histogram, and then exits back to the main menu, out_free_stack clears the
filter. If they subsequently re-enter the event's histogram, the view will
be unexpectedly unfiltered.

>  out:
>  	hist_browser__delete(browser);
>  	free_popup_options(options, MAX_OPTIONS);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710053628.1861=
645-1-irogers@google.com?part=3D4
