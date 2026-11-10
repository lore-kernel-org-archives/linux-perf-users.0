Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349471;
	b=yjDvM4Gq7EfUsoKqT8d057yVISWzgZuh6z7khMJlutWWCirVGtZ10etS60e1BD3ebqbG
	 UtAXFnxARxUWreGnugtMp56O8rKvnRyLQXUi9AwbLiprtOjJA0HhKhqf3AlD2bhKyzQUo
	 EkubjrrN0iPZ/47wiNmpezA4n9/EJ1Faw1/FTi5A03pzo9kag9rKzK9iRwzksv+myIa9+
	 qfaPNlqAu3WDzCMV2NzaDNSNOw0k8EgsncbfvUs3mYeLK5z0vgCfhCvm/2mJst3qwpNNb
	 vP0ekNIBTe1AHq2Etg+3iuVKTk+wJwnb61ou/JJBfRTcpVuFiek5K8AFdZzSNDKlOnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349471;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sV6IqD/OA6PWEl2Ajlr+QSnDaiMiy45kUaeDX8n6luc=;
	b=sdm71tCWvsSX5NO2qTXhxnkGJhQf4lTrijHIDasuwj0kkKnLcn+lvXjsR6km5kpjWpFy
	 tlwWcClnPXk9ptcAC6vFFAM4Tt5U3MGTwRUR7yMXUdAKSzYjG7XkYV/wJlFotQWji6nVW
	 xJUf0MayebhBqd8GvSfWzrMLNUpBMUpx4O4x2EkZ+5Y7ACk85lArkjCzDx9sbYwRH27oB
	 PZ7LRK/g1Yvnero4QYKophIzC73tDj0rfoUDkhA8NEZ18vlZZJBB+S+5sLBFYB57KDzSg
	 pBCuRVXbw0audUQePnv1Kx4wkywIblMZ7RG6XjoDhxqs5zqUZydUpyMlykmG6JCb+Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dggN+XQk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A8D606A334
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dggN+XQk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB80F1F008A3;
	Tue, 10 Nov 2026 22:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794349471;
	bh=sV6IqD/OA6PWEl2Ajlr+QSnDaiMiy45kUaeDX8n6luc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dggN+XQkZDt5hThcH8lB3st3dqdGPQWijVGtKkT54xXemT+aZNB3mhxEbo5j2od/d
	 0AgQV0bNpLCdcWz01dlsOlw09VLaI5gMyxNtWrMklqmCcCOw5E+1U0pgx9dZM+J+pd
	 bpNjQJvheJFdXKihDV+OgNtMS3eFJ+eG73MUOIAmCyEYOr2aVip5gr1ooQPBKZAO6M
	 V4p/6JKSFLYOBNmzBzTk67VoLHHjJiDb9CYPA9YGt8rSBuEEEvya3u57UhnnfKisU7
	 +5w2WVvTz7lAYQONbPn1Y3t4wAzUmRu4iUMH//cnNI+bUZX3qtNsbhIGzUSWEzqCjO
	 ybpSDAf/14tUg==
Message-ID: <sashiko-outbox-207823@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/20] perf bench internals: Add maps benchmark
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261110220803.2503416-11-irogers@google.com>
References: <20261027231513.816148-1-irogers@google.com>
 <20261110220803.2503416-1-irogers@google.com>
 <20261110220803.2503416-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:24:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add a 'perf bench internals maps' subcommand to measure map insertion,
> sorting, and lookup operations directly:
>=20
> 1. Inserts non-overlapping maps in ascending address order (simulating
>    /proc/<pid>/maps synthesis) and queries each map by address.
> 2. Incrementally appends maps at interior addresses (simulating runtime
>    PERF_RECORD_MMAP2 / JIT events) and immediately queries each map by
>    address and by name.
>=20
> Example output:
>=20
>   $ perf bench internals maps
>   # Running 'internals/maps' benchmark:
>     Average ascending insert + lookup: 145.870 usec (+- 14.628 usec)
>     Average append + lookup: 17405.810 usec (+- 1773.195 usec)
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110220803.2503=
416-1-irogers@google.com?part=3D10

