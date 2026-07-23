Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FA539BFF2
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jul 2026 05:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783979; cv=none; b=PQ4UWGPpZH07wFCuvu9srVmQiN0SgS9alfl7/23iT2PMQUWH4KNf6tHUjiIHbft5FpU5jmk3q1qF+fqHlhds8OpdZHsksyBfpHF++ok2wlgLvzBl122Sfu8Qbi1jgB+fQXxWORQwrurnpRLycJt1mbGDajn7VKTiKgRpmBOOYpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783979; c=relaxed/simple;
	bh=zrPqvNa9S9h0jCbjE982YqvDbtOLg5kcyusuJS2xOXQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AIxZ1VfC8+cDCuWXBXS2uKEdEL101EaJhipSCmIqjH+oXx0Zv040FzEhDqjutW/bWApa/fgYU0hQQlQ6F9zzO4j1IgMTD1HhThVCwwJvevLciKesdeiI7H4ZVHiLyyI04Nko0bw6vOT4p0qq8l/POoL8SZpjJhynz4hNwMwOK3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5+balTR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5+balTR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DA01F000E9;
	Thu, 23 Jul 2026 05:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784783977;
	bh=gq40m4f8nCwTgc+4kVAK2DSVrgfEwnPgOkMU+u0rexg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j5+balTRn6vTwzmmvWXiWaFRgIeE0J7+CMtcGcwdBkSMS8GFl5Yw/1NzK9AtIDAvf
	 cN3yDcwwEGGgwzz5tPKdulC/TUtayC34FXD1iDfxtdjfOLB8nGdjU13X9Bs82cSxpZ
	 C8xIiuV0R5JxMCqCoW4T1t2jwBy8HJzfkrOZTHnSKs7BpLJccBWZUzy4QLCsURXi6C
	 SEhcd1p7zDKly8v1p3pSenNKllAAqxnDrVirtkzsrFqei9ItcWAURvbJjOcEpPUJDt
	 F9lWp73QF6b7F29JpYlBQ5Rulx6wBJH/FvNTDVjttJCMvE1FLZ20FbRvZfsqAUiywN
	 YTu5FWlXQc9OQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/6] perf ui hists: Guard against NULL hist_entry in
 add_script_opt()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260723045949.988740-3-irogers@google.com>
References: <20260716072351.560311-1-irogers@google.com>
 <20260723045949.988740-1-irogers@google.com>
 <20260723045949.988740-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 05:19:36 +0000
Message-Id: <20260723051937.80DA01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] NULL pointer dereference when toggling annotation with an empty br=
owser selection.
--

--- Patch [2]: [PATCH v7 2/6] perf ui hists: Guard against NULL hist_entry =
in add_script_opt() ---
commit f95ba72ff3ba56daab82a876b00253253abac4da
Author: Ian Rogers <irogers@google.com>

perf ui hists: Guard against NULL hist_entry in add_script_opt()

This commit adds an explicit check for a NULL hist_entry in add_script_opt()
before accessing the entry's time field. This prevents a potential NULL
pointer dereference when the browser selection is empty or filtered out.

While reviewing this fix, I noticed a similar pre-existing issue in another
file.

tools/perf/builtin-c2c.c:perf_c2c__toggle_annotation()
> static int perf_c2c__toggle_annotation(struct hist_browser *browser)
> {
> 	struct hist_entry *he =3D browser->he_selection;
> 	// ...
> 	if (!perf_c2c__has_annotation(he->hists->hpp_list)) {

[Severity: High]
This is a pre-existing issue, but could this cause a segmentation fault if
the browser selection is empty? The code dereferences the he pointer to
access he->hists->hpp_list before validating it.

> 		ui_browser__help_window(&browser->b, "No annotation support");
> 		return 0;
> 	}
>=20
> 	if (he =3D=3D NULL) {

If a user opens the c2c cacheline browser on an empty or completely
filtered dataset and presses the annotation hotkey, browser->he_selection=20
is NULL. Since the safety check happens after the dereference, it appears=20
this would crash the perf tool.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723045949.9887=
40-1-irogers@google.com?part=3D2
