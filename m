Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794814832;
	b=hdteCGxR6urvzD8bApq5OFmExeItIBT43jxuqSsoj3jxEvv4pDms1mQdU/fleyY0qm3H
	 dYY9230IJZHlOS6ldn8KHDjRHNmI1ES0TpBel31KFj0q+tPFH4acuoeoUzSZ3FLrv8omx
	 RcCqSCDeax3f9BVXMuJf0s7A3jAomp1lZT4Iba+JSXcVaD+XtXDwKqG38rcfBsQOBJjzE
	 WdbR0jqxR5/DPniXRRYwJTsVGvsYM5cHRFIjGFvEAviEnTBJphrEd9KPYX6PcCI4AWcBm
	 481nZ6qTCrHC08VtFuw3xeftlPqsV3Y7bUjdOYhJotn3oyWtn4sWiAlNJmd5JRRTdXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794814832;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oouZxlOft71JpleuF+J7PJdX7k1ticz0XeI5ENLT1+s=;
	b=w1L36kA2G2dX9ouIHHCyANillUtj4DdSfjT/XvkBfgXbDHr667MVSSQHOpmHYzXYMULZ
	 pKZTf1ZUn9QDEzZaJ+s0zHmSg4kMWYwKCCTR8thwU4+kfD3UtPOFIJXaC4+H3cmKf/1tA
	 jJYK1d46PMBuW6LT+pMLECk8U8xc5Ri1TUoxw29zHV2T4K6hBm3QZIWTksAaMICIz/QUi
	 9lekAlLSaB+JgUPwQu0XjURrAU9D4lXTUr1+AKgzNSVFGzv8lOwetOsqDBDXcUT20A42x
	 RPqHn5V+9rUAXaepOByayLPaKl4bhzb0AqFXcxq4V7Mp5PxKVohN3y9rpLMh7YCXHxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgoR+Wht;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF0F606A8A2
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgoR+Wht
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD191F000C4;
	Mon, 16 Nov 2026 07:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794814832;
	bh=oouZxlOft71JpleuF+J7PJdX7k1ticz0XeI5ENLT1+s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jgoR+WhtMYkKRIygYFzuyf6zV4xF+RVEIw1q+ffhovd9p9WFAVWilSSlCTjcHXUlQ
	 CqnVnuVTU41Vl87z62NsD4p/eduXg960X4HvoEs2/46+PKIjjY6Gr8uthC+1l/3PUN
	 /3df9zZbzoqoDaGwtPvWgR6et8jkO5nyZms3ZhltKfJSyiXvgm+lZgeHXwSGyS9o8i
	 WJETge7xUZj4P2biRRra+4GuAhAsXtd89bnKhXNTdNURyomJGU/mTdc3OpMKyGL+m4
	 qSazAZSZfHcCHpcf2RSOmVa1hh+Uz8J+G32ZmIrJIOKgua8NVavDHKIYaCnoOxwbMi
	 RykTe98jn5chQ==
Message-ID: <sashiko-outbox-216450@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 8/9] perf session: Add dso__session() and
 session-scoped allocation wrappers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116063435.2817923-9-irogers@google.com>
References: <20261116063435.2817923-1-irogers@google.com>
 <20261116063435.2817923-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 07:40:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add explicit session-scoped memory allocation wrappers:
> - perf_session__malloc(session, size)
> - perf_session__zalloc(session, size)
> - perf_session__calloc(session, nmemb, size)
> - perf_session__realloc(session, ptr, size)
> - perf_session__strdup(session, s)
>=20
> When an allocation fails and returns NULL, if a non-NULL struct
> perf_session is provided, the wrapper invokes perf_session__shrink() to
> evict unreferenced symbols, DSOs, and cached debuginfo across the
> session's machines and then retries the allocation once. This avoids
> the thrashing overhead of periodic heuristic shrinking while allowing
> perf to recover from memory exhaustion.
>=20
> Also plumb a back-pointer from struct dsos to its owning struct machine
> so machine__session(machine) and dso__session(dso) can resolve the
> active perf_session.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116063435.2817=
923-1-irogers@google.com?part=3D8

