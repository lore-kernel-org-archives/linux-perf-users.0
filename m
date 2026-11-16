Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813400;
	b=mrMhtKPUr3GfvEkFcmyec5+hCe7GptCF/gSHOXvtSDO7oXbAA2OmpcI/BhlxiG5+5i7R
	 ADYfABvgRqTEcgUzvqUiUwZ65uJ5M+Q8OCh4tkpw9usKkUD992jDMKPtt8pmmdyGbQcn6
	 zVfkOuBUx/lAuJGK0826cdgTVSK9AxpztUgRr+DRsIG9lG5ix3a9mmyWnNt4v7rLE16RX
	 jYE4kQoN9xrpz/5gkmFcLw/PtXqpxtMcDNNEe1npTvLaWgPm7aBtOxkx5h4nelyn9TNkH
	 gmQAvyOuDlu9aBp1ilqA+IgOAErl24TN3yzi5syDGrAtyCq2HMnFUyI8WdFO3lt+A2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813400;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DLl6aDnmJbj8IA4uLSPYrozTWC0vOM/APdynSpp932A=;
	b=mZsyh2xiud0pJtzlcphsLirZud9QKcjL6BEGZt9bQGaIq38y2XxHOs29ewcjd3SM0r+m
	 BxnEU8rIsFrEz2BHXCECyZ9Ptkj3ilp7Tw5j3H74mTJ+7Y69bDQCYHMbp4XkwFlKn3amE
	 Pp49JBQFSBEkbcxgU4pQt7ikY22BEK31jNfaYUqhfSnedCfuYQjf7lJJdEx6J5iyq9XGC
	 6k7TgNEti2IPNtUGY1W7NsCFu2paAvwRm2aFr/L9v3bOYNuoA72ibnFncjPlGnbxZxasv
	 FSo+lsSxfl734A5ffoZScErp8JjSisDd3cIFqWxnJlxpuHioJnaj/w2+2y7CVfAwenQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jGYCJLkJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56E2606A329
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jGYCJLkJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D581F000C4;
	Mon, 16 Nov 2026 07:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794813400;
	bh=DLl6aDnmJbj8IA4uLSPYrozTWC0vOM/APdynSpp932A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jGYCJLkJMxaDOn9GWsxbyQusrntEVJGnkmrJ++43P8yxYpGP/1trfoi0RYU/copeE
	 mSrt2c7TLzkSc0O8pvnp1krGvrNk+4DU9342N9TjS/ho8vuy1lHGjKMnkQx4vS3MUL
	 fy7SNjwJu2KRhrv3WItY5QAp+DVNSQuuMvpcCK9BajIF5TpZwkGvSbmBv88TEy9cEt
	 0hfc06NCoSbukkVXcQznDPBEnnL//0vxGX3ZVHRyCQSPsx2Hl3Q7kkZPwrcEn49+Wu
	 X0nDPUGrGi7lEoCa7y/niZMW/LbE3f00tDrKGyOTV02RlI5Xj3Ajbjt78hsAisFFBU
	 ckpblHVAN901w==
Message-ID: <sashiko-outbox-216400@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/10] perf build: Default JEVENTS_ARCH to all
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116070038.2968725-11-irogers@google.com>
References: <20261116070038.2968725-1-irogers@google.com>
 <20261116070038.2968725-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 07:16:39 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Because block-indexed string compression packs PMU event and metric
> strings into independently compressed ~8 KiB blocks decompressed on
> demand via (block_id << 16) | sub_offset, bundling non-host
> architectures' compressed blocks in .rodata incurs zero runtime
> decompression CPU or heap memory unless those architectures are queried.
> With zstd enabled, bundling PMU event and metric tables for all
> architectures (JEVENTS_ARCH=3Dall) is 5.77 MiB smaller overall than an
> uncompressed x86-only build (JEVENTS_ARCH=3Dx86 JEVENTS_COMPRESS=3Dnone),
> cutting the stripped perf binary nearly in half (-45.4%) while enabling
> cross-architecture perf.data analysis out of the box:
>=20
>   Component                   x86 + none      all + zstd      Delta
>   -----------------------------------------------------------------
>   pmu-events-string.o (dec)   6,901,987 B      794,032 B    -88.5%
>   pmu-events.o (dec)            257,987 B      314,940 B    +22.1%
> [ ... ]
> to NO_JEVENTS=3D1 if that architecture lacks mapfile.csv), and update
> tools/perf/tests/make to exercise JEVENTS_ARCH=3D$(SRCARCH) alongside the
> new default.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116070038.2968=
725-1-irogers@google.com?part=3D10

