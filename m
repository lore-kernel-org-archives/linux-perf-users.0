Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A536044CAE4
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392260; cv=none; b=N66Jg5GPAW1k0ApYZLo7VfkWBeDxFjv57Y9aDEJ5mbwDfldD8gcHPELaU+0YdngaXqyAnJPohAulKCACG3IB3lLIE615nQSEsb3EHtjG4GoMVuR1a9F5RyPSO9jMs0O1sNVbC44GGvvhheOECEw+rjmhzRdnwMCHvqqVjK86As4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392260; c=relaxed/simple;
	bh=4ZsW5ko5kYSOBNlrsml/boDvdzMRp4JA2uB34PGqcJc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h/GDeFTmrHYa5nGLH+F6Q89BckTCI+Q08ve9kQS99yVupc5iwxYLYr6ftgiDZOI8byIA/O5P8bhSgxY/0Uo+5z0f6XLvjlheMr5kQ5VzUxJ//JZO9CICVjVxa3NQdjANMgKPyuQWDF7xOBtvy8yvPXI2q0YeCCU7zwyr9g92SMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpQbtZ0+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpQbtZ0+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D751F000FF;
	Mon, 14 Sep 2026 13:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789392259;
	bh=4ZsW5ko5kYSOBNlrsml/boDvdzMRp4JA2uB34PGqcJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jpQbtZ0+D+9715auKTj56UYXCk2wMyekybplVt66GRT6j9/g1amdEPXGJz0xAMfYb
	 JqASPFj6B0J3Oot5vwwHaFBIbSE/pWg4wBszBhd+6wV0kDFROneyFnxwZOs9uC6WCT
	 f6fITclp7v09IFlWbUiYKxcYz6PROcGBJAyvM82PqvKEiC1+e0yaoOH0r5kClECaaQ
	 8wkWSvTQezwVQzvaV8W44/QXbO9ww07lS94PJmuo3kyWi1Heqy5djyhTioq1KCDg7h
	 eaGmzbOfC898BE7FXLsFOhlyXeTA5jw3HV0nNQAmWbZFuhCwB3lEMAiphRnl5bsen+
	 z6AV0kfHbXi8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/9] perf annotate-data: Show the sample count in the
 data-type browser
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914125451.2045-5-acme@kernel.org>
References: <20260914125451.2045-1-acme@kernel.org>
 <20260914125451.2045-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 13:24:18 +0000
Message-Id: <20260914132418.F1D751F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The data-type browser has a samples view, selected with -n (or with
> annotate.show_nr_samples), in which browser__write_overhead() prints a
> local nr_samples variable that is initialized to zero and never
> updated, so every member is listed as having no samples while the
> period and percent columns for the same entry are filled in.
>=20
> Print the histogram entry's own count instead.
>=20
> This predates the load/store counter split, so fix it ahead of that
> patch: the split then only has to adapt a line that is already correct,
> and this fix can be picked on its own.
>=20
> Fixes: d001c7a7f4736743 ("perf annotate-data: Add hist_entry__annotate_da=
ta_tui()")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914125451.2045=
-1-acme@kernel.org?part=3D4

