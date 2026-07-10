Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA423233958
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 05:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783662901; cv=none; b=Xp4nKjRBYvIfGeSAsqKUyQP6u8GNZHp5M/92tY1l2WL08V/E4uk494vXVaqBLNJsKPlEqqnUQmW9lYhuz3O+60/W1uhkqQHMMa30VJdkxmf6vomFnz+8gelkohFjHyyLVuFKMsbN4W3XxF8Uayr4VMCLfjrK2RZRajNl5EcNPxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783662901; c=relaxed/simple;
	bh=uRPUb2m8c4dEDYi/D3KENgAww6fxmKzCtLAjxgcAXrg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QtftERccXvCYu8oflr9LDdDnVyJ/xs/F9ri8HXlArxmV1UOOu1mZorFqD1RLgc2tPiak0p9xj9wztg6nF6f3YHG7jJTVaV1yw5s/G8CcmC1pOyut0LyhscpzreUqS8Sqx9kL0DXKP81XHpCtrA+v6GDNyBY2xSm7lHnr/a1wGTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkOhgkMD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkOhgkMD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664FF1F000E9;
	Fri, 10 Jul 2026 05:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783662900;
	bh=M3IgImK1oeQf9moLRa27qiVRye3+FTI+56sZ9UF0+zI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jkOhgkMDLMSIW+TPU2A3keEirnS5MVWNssos8i3oOpVQ2MUgGo7K8R293EJTEkHnk
	 aMz/c1dH+sCnUu5B53cRz8PuqI5sIga2RwqrMGFd+iVKyS9Wm9H0JeEcpSbz16uUom
	 QiC7I6+qzX11n8Bt17x2e8hwMJ3xkznTnN/to0CF9roQPhTMfvhM/GU+6I3PsLXIwO
	 81Z8wHDAbTDjqCaFHOdLBSfGQ7MZZgNu8driF0bOB+hwHnnX7/9Q/87hyPCond1C4K
	 4PSAU0zx3jDjl/7X+XOl6CNfnD7Zo3in+eaoDkbBlmdNyXbiqKZNLSf+gVyZB6i5mf
	 Tp07i6ft12YPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/10] perf hists browser: Increase MAX_OPTIONS to
 prevent stack buffer overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260710053628.1861645-1-irogers@google.com>
References: <20260710024952.1668911-1-irogers@google.com>
 <20260710053628.1861645-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 05:54:59 +0000
Message-Id: <20260710055500.664FF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A pointer to a local stack array is assigned to a longer-lived str=
ucture field (`hists->symbol_filter_str`), leading to a Use-After-Free.
--

--- Patch [1]: [PATCH v5 01/10] perf hists browser: Increase MAX_OPTIONS to=
 prevent stack buffer overflow ---
commit b1c79545734c108ba31495cc1454bc12dd7ce4ad
Author: Ian Rogers <irogers@google.com>

perf hists browser: Increase MAX_OPTIONS to prevent stack buffer overflow

In evsel__hists_browse(), the options and actions arrays are statically
allocated on the stack with a size of MAX_OPTIONS. Depending on the context,
the sum of added options can theoretically exceed 16, potentially leading to
a stack buffer overflow. This patch increases MAX_OPTIONS to 32 to safely
accommodate the maximum possible number of options.

Link: https://lore.kernel.org/linux-perf-users/20260708235834.3FB771F00A3A@=
smtp.kernel.org/

> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index cfa6386e6e1da..671961946d56c 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -3003,7 +3003,7 @@ static int evsel__hists_browse(struct evsel *evsel,=
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

[Severity: High]
This isn't a bug introduced by this patch, but since we are looking at
evsel__hists_browse(), can this cause a use-after-free later?

Just below this context, there is a local stack array declared:

    char buf[128];

Later in the function, when handling the '/' key for symbol filtering,
a pointer to this local stack array is assigned to a persistent field:

    case '/':
        if (ui_browser__input_window("Symbol to show",
                ...
                buf, "ENTER: OK, ESC: Cancel",
                delay_secs * 2) =3D=3D K_ENTER) {
            hists->symbol_filter_str =3D *buf ? buf : NULL;
            ...

When the function returns and the user exits the browser, buf is destroyed,
but hists->symbol_filter_str will still point to this invalid stack memory.

In a multi-threaded context like perf top, if background processing threads=
 or
subsequent timer-driven UI refreshes (via hists__filter_by_symbol() ->
hists__filter_entry_by_symbol() -> strstr()) read from it:

    strstr(he->ms.sym->name, hists->symbol_filter_str)

Could this lead to memory corruption or crashes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710053628.1861=
645-1-irogers@google.com?part=3D1
