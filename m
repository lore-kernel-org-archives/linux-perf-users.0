Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE3C5B1EB
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 03:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783569152; cv=none; b=Rlc09IvwMc4tBM1lx2ekRJEtd/TjeK5aXzaYgor6l+3eLtZkBBgkQDBuf70pcnvTNu2zXV3DDNbsNkozLk+vQew1e8ZeEDcy8386rQqURo7TS6abgy+C1cR2jfDYF+vvPy/wroaDtCU+p1WwieC7YNHFABcptOnLaiTJShD96S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783569152; c=relaxed/simple;
	bh=ITYir01WzWRcbwip81NatCD05mYJNK4ID4758Li64Ss=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dsq0Y6/MGUupx30fR5awO2aN/JOJgUSZOgbZeNvdGa6sTA3VbY1yc90kxLyHYKNNGB8KuG3hVxn9hvGCMxMkDRyd6E4BmCSLkyA5EbxYrM2ipnykVJJ9ZMjyALWW7ezhIVnf56abmMRmyjKxfZwQPdaKBO5zeDxRY1Ky/Aked9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNlblE7s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNlblE7s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBEE1F000E9;
	Thu,  9 Jul 2026 03:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783569150;
	bh=XGSGjDxoi7IG65UbBYFsvqhPTB6tRqcxE62kBmCrPN8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lNlblE7sEt9uUWK1HXlTTsokAQ7Nds7015aDVdK/j3B8mmjjA2AXaAdNq/EmOFdic
	 ISPgaQPotmfjx3t1E5bs89GstTuRamCAPvflRRAT28XEAdR4kHpF1h1LTBvqZrq9ZT
	 qKGqQnE3jk+xAa0BK4XbxXc9O2gTGucul6lyOz1dsPtMKP5jKbfpQcW7peDceM4pf8
	 Edt1GErM93v0GJ7IwlQ928dLKya8Dbm0cS8DKlFqrtUhES2+yVJykTcly1DfKr5O9T
	 yG5oxu4eXEplvf5787jm00ylj/YzhwT5yI1L6mePCpqOkQShS8mDqPQoarB5dMOvsl
	 YVkNxRUnFkt9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] perf hists browser: Increase MAX_OPTIONS to
 prevent stack buffer overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260709033701.1117943-4-irogers@google.com>
References: <20260708234646.1040003-1-irogers@google.com>
 <20260709033701.1117943-1-irogers@google.com>
 <20260709033701.1117943-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 03:52:29 +0000
Message-Id: <20260709035230.6DBEE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized stack memory passed to free() on pstack__new() error=
 path, causing heap corruption.
--

--- Patch [4]: [PATCH v2 4/4] perf hists browser: Increase MAX_OPTIONS to p=
revent stack buffer overflow ---
commit a3310ba19dbf043afaf000421ada085b9b1e380f
Author: Ian Rogers <irogers@google.com>

perf hists browser: Increase MAX_OPTIONS to prevent stack buffer overflow

In evsel__hists_browse(), the 'options' and 'actions' arrays are statically
allocated on the stack with a size of MAX_OPTIONS (16). Depending on the
context, the sum of added options can theoretically exceed 16 (potentially
reaching up to ~19). This could lead to a stack buffer overflow, so this
patch increases MAX_OPTIONS to 32 to accommodate the maximum possible number
of options without risking an overflow.

Closes: https://lore.kernel.org/linux-perf-users/20260708235834.3FB771F00A3=
A@smtp.kernel.org/

> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index a93846b8dc885..2b81217b02dfd 100644
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

[Severity: High]
This isn't a bug introduced by this patch, but if pstack__new() fails before
the array is initialized:

tools/perf/ui/browsers/hists.c:evsel__hists_browse() {
    ...
	browser->pstack =3D pstack__new(3);
	if (browser->pstack =3D=3D NULL)
		goto out;

	ui_helpline__push(helpline);

	memset(options, 0, sizeof(options));
    ...
out:
	hist_browser__delete(browser);
	free_popup_options(options, MAX_OPTIONS);
    ...
}

Does this pass uninitialized stack memory to free_popup_options(), which co=
uld
cause heap corruption when it attempts to free garbage stack pointers?

>  	struct popup_action actions[MAX_OPTIONS];
>  	int nr_options =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709033701.1117=
943-1-irogers@google.com?part=3D4
