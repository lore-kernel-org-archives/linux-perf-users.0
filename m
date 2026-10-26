Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007340;
	b=ZFGLkoTWxihE2iPl46u8ee7Kf/K2rOwEH8ykb8qe8wc0ziQS/Z4LUSsRlmXmWjVhK9Jt
	 l+EY8xTERplb4/DC0nHpJnzvFlNpcaKEX/em1sr1zm7092/x7kr2Uc0YnHdRzWGjWcM/D
	 SISEjePZQ2oQTV5tVWkEw83rf1Cd1mFtEzcEPLP1lbiLhUOZvoIu8vKCdHJ1scuKIj/UN
	 dk+7dSdF+0zxnO33bXqc+l9FCFlnDCn0thGR+5MASysHoUnWrj3bemM704Xkf0iWKD95E
	 zi4r0OhzXuPe47k9O6SJDu8vtFDiM0dTloHDCT180uQhyv0e4kyX5TM8krSON0Lj4CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007340;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jMqmzVFS9j7DyEFvDtwVQbIfO5FrBJm9pkGmlzUaG4M=;
	b=ZtYzq0IMq69avrbXfT/4GUWSh49ar1ZA8GU08lMMprbkvRH99o1dHo0MLZuz7tC3sY+9
	 Xtko/YsdO8P97IS5MKSgcSD0elY7A7S/bd5bT7M2Bpp5GRrjDI2CIsc9/U748vi5Ltu+y
	 T0xiMdcKOZlLh4tFvJWiPKkXhiFA0hAb87waGgAEdnu32xuR6m7mC70e3FTSixJ8HzGZs
	 utZv16LopkfVW87VoHnYs4HXtyKoLG6YoX5AAOC5tDRWEpBMrVKn9dD3yFmMSBz1xljqa
	 vVy1r5s4RlJQ8LjjdTHQG+2bN3zAEwE6cIdhxI1OV6JcDPtJJY3wzNwC09EjzT40TjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mUpqcpif;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD09606A31F
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mUpqcpif
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D446A1F01825;
	Mon, 26 Oct 2026 09:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007340;
	bh=jMqmzVFS9j7DyEFvDtwVQbIfO5FrBJm9pkGmlzUaG4M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mUpqcpif87QFei571is5Es1mzTX7OrVUL8IyispPQcu4X3kq/JGfDaC8b3Buugtpo
	 GPK4wnHG0tg/bXbMZ03dgjmSRji6Jgv/SYie9A7Dx40eXeLPLLybJQAw+3XibFxty8
	 wvufi4Es4Rw4SnQh2TJb5CbV2n1TKeQVDOrjRPdSHwmEOAlgAW4bWwUltZM1pWeBZC
	 tL9lLza63bPOxMWUNLI1jlZgxwcppqpUAg0EwkkfFq8MqEtUxejh9t5YcI+3J5Xp0O
	 4jq6ePJttRKm5K5rCZ68wMylDv7HxLaC8Xd6ZC1ZNk94b3r0d9P0PO19C2x2SYt+YX
	 ZXCB9QKOreCDw==
Message-ID: <sashiko-outbox-184807@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] perf debug: Avoid calling eprintf() in pr_debugN()
 when verbose < n
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <3de51d76f93fdc1170e9e923589fcc0605e50c17.1792995775.git.irogers@google.com>
References: <cover.1792995775.git.irogers@google.com>
 <3de51d76f93fdc1170e9e923589fcc0605e50c17.1792995775.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:35:39 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> pr_debugN() unconditionally evaluated its arguments and called eprintf() =
->
> veprintf() before checking if verbose >=3D n. In hot paths such as
> dso__load_sym_internal(), two pr_debug4() calls per symbol accounted for
> ~15% of total CPU time in 'perf top' even at the default verbose =3D=3D 0.
>=20
> Guard eprintf() in pr_debugN() with unlikely(verbose >=3D (n)) and define
> pr_debug() in terms of pr_debugN(1, ...).
>=20
> In test__parsing_callback() (tools/perf/tests/pmu-events.c), move the
> test_generic_metric(mexp, 0) call out of the pr_debug() argument list so
> the metric evaluation continues to run during 'perf test' when verbose =
=3D=3D 0.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792995775.gi=
t.irogers@google.com?part=3D2

