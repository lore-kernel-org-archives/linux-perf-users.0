Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFBA3F4101
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148557; cv=none; b=WVGkV144xfeO2N9aBsLNdYlSJhA6oUig0c8fuH5Y2y9zxZY2IzwGi/gfDoyBcrnL5mvE/seQgj17m7z4drwEsYOQKc6wyJGH/4JSwqlG9zirAPyK1VuIcCrJr7xMjdH347asBapE8pr9z4LJE9/Cv8PezpFW4REuntOAQ7UZluY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148557; c=relaxed/simple;
	bh=DZdZanhDN9EijzD11KcGXFg9ASaniX3zeOoQrvQT9Vs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K7azivzB8w/8lkyKyKKPvNrCnlZLsC9+YeNurFdq46v7Fz/RnEy6MUx6AH11cNl6zH8jMJIIA8U1VqKh/7I21Q4huhlZkjY50Le2/r5PnCmYSeH8tXVC5kylzq51j7HmAZ8eBL1xIbiWlroZ4BR574CD370zCfWpHHWgeCD3D24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3LPb+/O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3LPb+/O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6478E1F00893;
	Wed, 23 Sep 2026 07:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148556;
	bh=DZdZanhDN9EijzD11KcGXFg9ASaniX3zeOoQrvQT9Vs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a3LPb+/OMI9FxnosSS6wp3fFzNAIZV2vQvrNw46kMzANPNYIpGDaSxme+9s3Sr9iL
	 iJKXKF59JFsp3okGeXf5CMvYNFtPkSM+830NWXObolSicny3b+EZkp+AErwoGmk6T1
	 5sxdPfny0lNdIm/wUdZWcDFGUNS2gbpoE3fHUqg+g0e1q81FQ12+eO+V0i0KNfqg1y
	 JfGBXq/kTwIaRNTcw41f9teFNpkO7jWpTIPowgwg8TQ5T8UONLvdNGUOSES/GBvheo
	 xa+1eg+LYY0sZQ90XVZKKrX8ygGNe5uXKaHKi5n+MAa7YTwIwq0LUlKjkSNAQ8A0fz
	 IudUWLjQx3Awg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/23] perf trace: Free the whole evsel_trace in
 evsel__put_and_free_priv
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <3cda6a7189745fc6251f18f9308dca3b1a32a33d.1790145937.git.irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <3cda6a7189745fc6251f18f9308dca3b1a32a33d.1790145937.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:29:15 +0000
Message-Id: <20260923072916.6478E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Every evsel->priv in builtin-trace.c is a struct evsel_trace, allocated
> by evsel_trace__new(). It holds a syscall_arg_fmt array in its fmt
> member, which evsel__syscall_arg_fmt() allocates on demand for the
> syscalls:sys_{enter,exit}_SYSCALL tracepoints and for every other
> tracepoint that gets its arguments pretty printed.
>=20
> evsel__put_and_free_priv() only did zfree(&evsel->priv), releasing the
> evsel_trace itself and leaking that array. Use evsel_trace__delete(),
> which frees fmt first, exactly as the out_delete path of
> evsel__syscall_arg_fmt() already does.
>=20
> The current callers are all error paths that run before fmt can have
> been allocated, so nothing leaks in practice today, but the helper is
> the obvious thing to reach for whenever an evsel is discarded and it
> should be safe for that.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790145937.gi=
t.irogers@google.com?part=3D4

