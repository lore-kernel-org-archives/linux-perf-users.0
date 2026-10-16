Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C592E3D9699
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 21:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185943; cv=none; b=daxxrjafGH6AKR4b7f4Ayo9Y4b+VRaSf44OKo0OpM64At0LziuU/fWUiUTHgcSDpFWoRtSJ2DqL96hZQZUj5fZh2XOy6wwes/DZ3OdipEQQDappKMSXh/iZb1z8EsT8rmmpNhJFOcTLKUif/iaeT+1rWrl4IoftWyPzdnJmOlOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185943; c=relaxed/simple;
	bh=6hDkenWUuE3G05H80e3FqIiPLvXvidFUxRbGppiasxI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=BoM1KIxQDItQIWxq8EdHB2wCzAv1TbzTOzIraeGTcCtDic0arT5fI1HwAaVjzUC7LQnHPaXpZC6043GpNBOlSdVIziD4hRrNJ8xSCgNyuERHf/QcVihuj4RPZpg+MPEqAePwPNd20BQbTR3pxY71utXrFQ4onVe/0u1guM7cdas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+vXKZXc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+vXKZXc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B35B1F000C5;
	Fri, 16 Oct 2026 21:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792185942;
	bh=9vQG49OfcD0l4gVL5gzNHuwyJvcRfiedQWBuqDVCj1k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L+vXKZXc6mf6lvJ7KWbOsTG7ejSnj+eZwgVmyu3XcHEJ8QUCOGZt1m9svWCdadsdu
	 YSmmZ7oMh4ZNZqGMjiY7JUax/Ivsg7bPjQN+rqIV5zcYTW1CZqaNA52y6aVSA5dDW8
	 TYo0RyxKroae0aie+wikn7zFUTLje9cc+PUrkieggJlzt8uJ0zRMpjN/9Ma6mpLZTJ
	 2hldhZ3dYRffKJmODkGbASRx/TZF9Jhf4uG9nee8mEfV1WV6797M1aEPOqLUS7TwJ4
	 zXalo6Tissx0lsL5dHCIp8/jJ/jPsLouR1ON5IktiUx9d2efYgQp+PheUZWSzc32yj
	 X2ICEubJlQ6sg==
Message-ID: <sashiko-outbox-174966@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/21] perf evsel: Mark the event as supported when
 retrying an open
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016212102.76550-8-acme@kernel.org>
References: <20261016212102.76550-1-acme@kernel.org>
 <20261016212102.76550-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 21:25:42 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Opening a group with perf record on a machine with perf_event_paranoid >
> 1 and no CAP_PERFMON fails the first perf_event_open() with EACCES, after
> which evsel__open_cpu() clears evsel->supported; evsel__fallback() then
> adds exclude_kernel and record__open() retries, and the retry succeeds
> with supported left false.  get_group_fd() treats unsupported events as
> ungroupable, so the retry opens the group members without their leader:
>=20
>   sys_perf_event_open: pid 12345 cpu 0 group_fd -1
>   FAILED '.../test-record-group-sampling1' - group failure
>=20
> which fails the group subtests of "perf test 82", the Perf attribute
> expectations test, when it is run as a regular user, while it passes as
> root or with CAP_PERFMON, where the first open doesn't fail.
>=20
> commit 2cc7aa995ce9 ("perf stat: Refactor retry/skip/fatal error handling=
")
> dropped the pos->supported =3D true that record__open() did after a
> successful open and moved the resets into the stat code only, while
> saying "When an event is tried the supported is set to true again".  Do
> that in evsel__open_cpu(), which every open entry point funnels through,
> so that a retry describes its own try instead of the previous failure.
>=20
> Fixes: 2cc7aa995ce9ecd8 ("perf stat: Refactor retry/skip/fatal error hand=
ling")
> Cc: Ian Rogers <irogers@google.com>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016212102.7655=
0-1-acme@kernel.org?part=3D7

