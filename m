Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E158F277C88
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 03:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783652820; cv=none; b=ix/BJ8UNulU70TAdDd4tEN/XG9qfiaUESku+S46Ji6SoR8NN6QxUT0DHijztJ2qGXhYJ6Pwb6taxmaMzArZC3mPaAoMqpxBkbSgc7l/FRIrWCNfxeu11pZ+0FngXgA1qw/LK2Ph1AOGuOE09MG9PDd0rtud7fkB+fSFGsFmVJaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783652820; c=relaxed/simple;
	bh=N5cw+41/FKgquupRrO2pTyPJNtzHlWCeu2+x5KPU2FE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dOVBSHNxoAAVtY7yOfbZyxf88JdwH9PgKMrdkimNLhUex6zhrxAhdlByH7ZjP11ez716tQZVflRcH1Y3P9PXZeOiqCJnKiJ9LiEx8NfDSzYBZAITNUkD1Nrr9sjWFDcz1wEhEUUNRr+5TJLLeLV1cSNjWcRzeW91FD4GAGEKMgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL68KjQz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL68KjQz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4EB1F000E9;
	Fri, 10 Jul 2026 03:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783652819;
	bh=hYu3Da0P2sMm04wgY/Ob5GWe6mMyVlhFQFq0DTmfgnE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JL68KjQzgnZJ/OXNrizGyoFFlzjEBZIs7GNVRlDI4vnsa7t64lP6I/yB7/mWvu7fd
	 yUEvz2gVZJHaErXtuRAXyqXz3T5K+GmS3zSvpkg8kjpEhXVx+Dxe3xRiGdx2CiuYXS
	 qLb0Lvi0RZHhSZ+ttGCi1bMgDWPTNSdjRZGiTeZ9SOuKSqPmdykgh/FIqFFbzv7D/T
	 wCiQj4M96oIWfVqZIbAFV6U1/F2mJlj3Ix6QNCUdYOd6hn3TFcF4uB1dYBdWGKKi0n
	 7c8T5rkDU/1V+Nnw0QZXnRnFYLwMKZEk7PJDroRaxBKbVOhefWCPN5vF3cdT1xxFGO
	 2VKRtN2H28S4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/9] perf hists browser: Increase MAX_OPTIONS to
 prevent stack buffer overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260710024952.1668911-1-irogers@google.com>
References: <20260709165220.1411149-1-irogers@google.com>
 <20260710024952.1668911-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 03:06:58 +0000
Message-Id: <20260710030659.5A4EB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Uninitialized Pointer Free on error path in `evsel__hists_brow=
se()`
--

--- Patch [1]: [PATCH v4 1/9] perf hists browser: Increase MAX_OPTIONS to p=
revent stack buffer overflow ---
commit e3c0cd11e9823ee7177a41443ce63fd50ac88289
Author: Ian Rogers <irogers@google.com>

perf hists browser: Increase MAX_OPTIONS to prevent stack buffer overflow

This commit increases MAX_OPTIONS from 16 to 32 in evsel__hists_browse() to
safely accommodate the maximum possible number of options and prevent a sta=
ck
buffer overflow.

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

[Severity: Critical]
This isn't a bug introduced by this patch, but does the error path for
pstack__new() cause an arbitrary free here?

If pstack__new(3) fails due to ENOMEM in evsel__hists_browse(), execution
jumps to the out label before the options array is zeroed by memset():

tools/perf/ui/browsers/hists.c:evsel__hists_browse() {
    ...
    char *options[MAX_OPTIONS];
    ...
    browser->pstack =3D pstack__new(3);
    if (browser->pstack =3D=3D NULL)
        goto out;
    ...
}

The error handler then calls free_popup_options(options, MAX_OPTIONS),
which attempts to free all 32 uninitialized stack pointers.

Could a crafted perf.data file potentially prime the stack and induce an
allocation failure to exploit this arbitrary free?

>  	struct popup_action actions[MAX_OPTIONS];
>  	int nr_options =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710024952.1668=
911-1-irogers@google.com?part=3D1
