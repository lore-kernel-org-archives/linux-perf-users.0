Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700801;
	b=19mK9QE08ASCJ0NGUOmXdAE8cteY4M39DgkHzbkHKAoDmq3YXTIjj26V91BzGpuwiK1J
	 7ksLKZaTbD4aB8kvUijGvXyWhHUi0p5fGhK3n3ROpB/34YPZ16d0EnpyXJ+qW+9/d8pFY
	 xd9WZmzZjViVh3JK+GezGrTNUtGOVHg6gu+t8BnAE8fO6dsJYM1NFoWSrFo96kVONs2V1
	 LyElGFQZGkmiZ/EKJb7PyRTnegWAtBb5tWtFf2V2RgQlaXzOUdxMyrTxupa5afI3kQH2N
	 ExL41qtjwV/EtxQ2ytR1gS854xP5rRhSFsLlcWTcJIFs+XtjCDnrDHSwNBOrpRKQDag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700801;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YJ58g92tu5eXwbbLvwqW1U2OJ/mmNN6ucC9PPkwid2s=;
	b=VnAaWSoEC8LiyxS3S5dNXBpI6P25DHGYxy5LXpWGkNacAPssJG2Ys3a2eQjtuy4vufT3
	 bg4RPNyUk2ywAdKrN0WyX0Izot+xGu7DOC/Jq1Lghmdpfje32ZDX4KJrn9qNGxykIXQLq
	 YbPPgkldSq1to5s+TrI343+WuaXLdk+9injQu4PjP76kfsGV1Q/yxWnzkhA9z7G7j4Hqv
	 pgN2Sn6ELU0Q799lhZJtQ7yurN2Cm7dXiFjtDPSZAQb86vHiMCGIX9gwkF48a9ZTrj5q2
	 vTFDFtFB2ii3Qw+ET3v+2xT64v1pWnVS7uLWpmkys6n4c5ND2mHCUR0fQXwV3t5TvEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jtt7tsEa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAC5606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jtt7tsEa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BC01F01825;
	Thu, 22 Oct 2026 20:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792700801;
	bh=YJ58g92tu5eXwbbLvwqW1U2OJ/mmNN6ucC9PPkwid2s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jtt7tsEal5ee65jZj0PV5rfkvul7NDiANQo2wmHnAREr6G9yWtMuoY2VmrRFDwZMT
	 RZQa7viTUR4FawnV+ch9uAa4uVU3LOrOGe9Gy+6dLHEZqVQu0lMuyC+HwBJYdC7RmQ
	 QpfPgZV4YjcZypK9LSrplZ46UyafUE/R5GUlhz68Fy6mI7dDSbLeWlLL3mbsD787h/
	 TsI79kCBR7D1xZlaaAkYDKAh22RKjyIHfNFaqZI1DFfKXYhfBFWOuFwrzmYGdUzgrb
	 chKn3IWl7aFuHtwui4BZepY9KS7D/tuUe3cGYANhxLRE1z14nnJziMviUNum9gsQGU
	 sj2OGOuLVHYjA==
Message-ID: <sashiko-outbox-182001@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 17/19] perf config, intel-tpebs, env: Add
 __guarded_by and __must_hold annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022201453.1717523-18-irogers@google.com>
References: <20261021223905.715051-1-irogers@google.com>
 <20261022201453.1717523-1-irogers@google.com>
 <20261022201453.1717523-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:26:40 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add __guarded_by() and __must_hold() annotations to static parser and
> config state in util/config.c, TPEBS state in util/intel-tpebs.c, and
> bpf_progs and cgroups trees in struct perf_env.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022201453.1717=
523-1-irogers@google.com?part=3D17

