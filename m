Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602864;
	b=eqQG5tTVmxNp1YC9cG3wCDMhS7KujL8uMXhiqArISNQ0SbZQ4gjR8JmluKe3qr4nhNHV
	 pRMByPnwqm0lO0uygjzA/zwvcSWtvDkey7PoMXY32GPcWiILQWhfhbRk0k+nOViktx3AY
	 MeldNbsNk9mstujeqKfc2oO9tTI25Py3Rpww5XrAX5Uqxz38LTX716R8bsNqWzhNjHwUZ
	 rGCSHTMHXD2bgQ/aeOznpIwko1PSJ8+3yTd57vPs7oA9TLTB4FaLnX8kxl7dsSonldsDo
	 mf1iQoZnX5IbbJeKrVK3WiXUNXzYkadq6A6adms8LvZe3ifficvLpuYXGPSHEh/uRMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602864;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RRpUhbndOndiBiJdG648N1sjMovGH/zjiD/cGVNqjmI=;
	b=Vdcm/0G2cmlOtB5a3+38HgivMCN6TOHMAd4lO2CplarszgfM6OLJ9Oe8cZnHhr1UDhvS
	 WyM4rfKrsYRkqSGZvIJfk8BYvbCFeKQdz02AMO0F6UlbhJ85kxmIQwIxHNmJeXtGJLYll
	 XRo058F5GuVK7SkJrSeyjlsvFT1keOUjzK8CyTDoNEhW+swidri3DmRlCIS65l3+qJkMP
	 Evp+LM1qr5z7glnPoUNJ59MGWVkL+77tx3uN76pkpLxs1R4IoVGDsk4j95phXTKos5Gz7
	 tTInynU3YsN7OX9qJp7TB0KLh7ydEsXmiTvBgdaXFhTjiUb5KindUUf/e5DF8tQRR3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dj0HRty3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09363606A332
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dj0HRty3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9571F000C4;
	Fri, 13 Nov 2026 20:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794602863;
	bh=RRpUhbndOndiBiJdG648N1sjMovGH/zjiD/cGVNqjmI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dj0HRty3eluwkPUclmYSYBcquWeHrvp+8ekeOjyWHya/kqgli0tcLm2iuUrumv8tw
	 tiGmDBPKL4YktKgEgfLkshfqqVW9la/QnVaOJpsm8fzT0/pVd4aGegCZjHE2p1vHNx
	 +gRQJbbRDYwstxsNshZWLN/Y9KIVoDxNdIR/r4EOB9jPc4p6fztirKVd6E+K9FRpsf
	 nUUgncrzdnjWMw86oqXe1A/NT2rH3Yk/XYLrDaEm/852U1V6Bw2sE+bGrCYLhJIM4g
	 q87i1KF1Q+P/i+GMNV4fuXHyJuYxlB5edOW2fOYIBpuNKz1yBjxoLyhFBtMVq71NX9
	 7+rsDI7Qr6Q8A==
Message-ID: <sashiko-outbox-213681@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 29/30] perf script: Display metrics for perf stat
 record data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-30-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-30-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:47:43 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf script displays the counts of each stat round read from a perf stat
> record perf.data file. Also display, after each round, the metrics
> requested on the perf stat record command line (or all matching metrics
> when --all-metrics or stat.all-metrics=3Dtrue is used), computed from the
> counts aggregated across CPUs and threads, for example:
>=20
>   $ perf stat record -M insn_per_cycle -a sleep 1
>   $ perf script
>   CPU THREAD         VAL         ENA         RUN        TIME EVENT
>   ...
>   cpu_atom/cpu-cycles/  metric:      0.7 instructions  insn_per_cycle
>   cpu_core/cpu-cycles/  metric:      1.3 instructions  insn_per_cycle
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D29

