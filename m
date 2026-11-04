Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793753806;
	b=stQ/vIdyrrBvN7A/3GvyU4rGN/AuoVR0rdC23howAKMk2TPw9yBtadGmofxOg0sFqiLj
	 X/iD3+aguIjTmtQLeRann3BsjZ2y3tyVwjzxuvOjAiTmoxhuuHh935KImhLjVm1+B+ipi
	 kihhnf49vYGDwuT2LH+F7bbhVbnRwxwXpjdp5euK7y+ZswVT4Ou9DT+sTpjbAYqH4QjaQ
	 EDY+XG+NCXqoBbldYGzYIEGPLzaqr4FCuLi5T15DqW3jCnInTZTlN2aWTX5SoF7WutsAQ
	 vAQvbIb8lBuUI3bKbaJzt+vIQOvOI8JWiuCO/OwMTsDt2ctY0JDgt6TaModhjmrf0dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793753806;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yM8yH8T5X3Gx7wgoUBKR+KYMvQSG9AVXdXOdN4poeac=;
	b=pYejdXfaZFGyPNUZGOvqbE+pgpw9q2GJH2rcYZE8Pg9D2Kojxp3YoI9ZSalNYFw0Zpw8
	 fcShLvMnb3tln1awkMnW3ZXQzc4Zbnu1Cj68MAFHEOVk8FyEJJbHpmek+moulCzz/WF+7
	 tojp5ZorMEe1/OKPgi+ubi/n5wcsOdJA3LGR7InqSJoZPjaQE5Xqt8DMW5h3tKPDdeufU
	 9R/oWlLCm2xiyImBPc65YXd9xVi4Mp+UWwOMK7u/0yYE5Sfao4sc/DrCSiAVFJaNBiT2Q
	 KhJa3rTjvo5Ex3nDKb6VNsZvQEYCJddblclZqVC9qEPe9XWAKC/BBb8TCup2hZk21Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZUdmX/7W";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F59606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 00:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUdmX/7W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99791F000C1;
	Wed,  4 Nov 2026 00:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793753806;
	bh=yM8yH8T5X3Gx7wgoUBKR+KYMvQSG9AVXdXOdN4poeac=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ZUdmX/7WM4jI8UQW06Gd+Cm+G8lqX6sv9enwr3BoqXn6f3i14YnwxEtxkdZJq5Qon
	 Q4DdGqs2c7XyUnwJCRiIIZcDNloT0OBPvxF9xGcRZ7Od9deCVd51eS/j5YLhQgLWlB
	 PnXBGQqITVAyT1glThQYraJLQkDA+1omAl2SsdvWyzDQmD0NKS5cAgkty5sxKRoyZq
	 rQ848MK3/omsHsBtscIbQvddP0w2srNlXHKWCIMXeFp5P7MrOHTEayRG4xXh9YwIia
	 rvr9ZlhD09004T61loALnSidM5EryrCBoFJxkhnz3M4R5gv8zVjt4q4O1MRGvjwqW7
	 JKs1kvMV3AlAQ==
Message-ID: <sashiko-outbox-196327@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 05/41] perf pmus: Pass struct perf_pmus to find
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-6-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 00:56:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf metricgroup: missing @pmus in resolve_metric() kernel-doc comm=
ent
--

commit 5675b0b4fb5d577cafaf5a7672d197f0a5b246dd
Author: Ian Rogers <irogers@google.com>

perf pmus: Pass struct perf_pmus to find helpers

This commit updates perf_pmus__find(), perf_pmus__find_by_type(), and
perf_pmus__find_core_pmu() to take a struct perf_pmus * argument and
updates callers to pass the appropriate environment's PMUs.

> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index c8d64573e4c0c..4e1205c1d3b2e 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c

[ ... ]

> @@ -739,6 +740,7 @@ static int metricgroup__find_metric_callback(const st=
ruct pmu_metric *pm,
>   *       architecture perf is running upon.
>   */
>  static int resolve_metric(struct list_head *metric_list,
> +			  struct perf_pmus *pmus,
>  			  struct perf_pmu *pmu,
>  			  const char *modifier,
>  			  bool metric_no_group,

[Severity: Low]
This isn't a bug, but the kernel-doc comments for __add_metric(),
metricgroup__add_metric(), and metricgroup__add_metric_list() were updated
with an @pmus entry for the new struct perf_pmus *pmus parameter. Should
the kernel-doc comment above resolve_metric() in
tools/perf/util/metricgroup.c also include @pmus?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D5
