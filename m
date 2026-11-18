Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041678;
	b=VJ4M+6DDfa5FdVHXry36ZVdu02jBXHNwXY2TzU0ntzajZG2uMsM5Jucezf+Rki6OZakv
	 hBR1HWRPe5J5KtQDXLbp1AClDeSjiXeoy12c7yWoKhTa91GoTmbIuxJfZx8cArB2BJ/2R
	 qp1/A5dWpXOO67wmdns9l1qb336wrcluwsJTgRTrTcxB4zmEcy7zhWgQG8l7AnzTDcTeR
	 5ZprfGn8IoNX0wMoT+3wERx+AV9N3WGRgFkWR5gW2s+EOsK5dEtDownuw1PeHvaj+h4tW
	 TQuFw6pvQB3ZvUt8ve2Ohyip0mDACcfYIjwgMuhBuuTn9rnrEv8ZnGb/1JJA6xAq/8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041678;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U1TDsAsZ8ByuNfd3GkrIrk4zKlCFj3ydUI3s7t0qPjY=;
	b=j6v6kj4U7FDGek0JmuCY3mOAi+bDnc1rNgnWR0r2OISRQy/RKvE1DOvHzOTSur5siiqm
	 qHeRCsCwKtJNAOrRwtVq0AXz9rTJuWhYl4wdlL7WWmoKBVGv28vBPiMPtrbVYEQhZwLYb
	 DcxoFj45zZAVXYmFkrz8phzKc+3f13hpOQb4ICK86dUcXV+I7UiFjaM0441l9qMGKY2tc
	 7KfCPs2usiOdT5t6eqN5Fym1+vkxX6AzwLj7u5MGmtdYNOOBXaG8s61XmHFP2GZB7mvnm
	 ewzgnFzQN4j4bfHPhtQoaYEtxkiaaoHen3mrlRN5h0BwqpnyZwahjmwRHVXsxTl0QMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HjdX1u41;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10EA606A325
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 22:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HjdX1u41
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5472D1F000C6;
	Wed, 18 Nov 2026 22:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795041678;
	bh=U1TDsAsZ8ByuNfd3GkrIrk4zKlCFj3ydUI3s7t0qPjY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HjdX1u411+dJYAetCQZHRgzXUDHFo3S/tCyBKR0QzX+bd6MTRZlUHrtVuOCgwaKKR
	 Munmo3tRQ5x0ErhzN+0PlTsVSQIbyxYOA/W44fXbZQ71yKWupNC4vd9jNUZ9ZjMfkB
	 T6iX79+hnkE64M/xKbfaJOtDX0KkaRBySseOqb6PLlR+qXmWPA5il0d98ErgKiC2ma
	 u6wvATdTWRTU3iqRGfLLPgUaPQO3w2eB7crpkzL84vsMGA65jK6NRzN/J2T8zTtWHp
	 0nTdrIks4w19c9rDMQ8NMvnbktHm88Z/Yf9c9dH68VCvbF1k+2MzO1actTI4xQhMLj
	 TMxgOt7Wga18A==
Message-ID: <sashiko-outbox-222109@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/13] perf tests: Silence the libbfd probe in
 build-test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118223725.121500-10-acme@kernel.org>
References: <20261118223725.121500-1-acme@kernel.org>
 <20261118223725.121500-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:41:17 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> build-test evaluates the libbfd probe at parse time and the compiler's
> stderr isn't captured by $(shell ...), so without binutils-devel it
> prints "bfd.h: No such file or directory" once per tests/make
> invocation, five times per run.
>=20
> Redirect the compiler's stderr; the empty result still skips the
> nondistro tests as intended.
>=20
> Fixes: 523471c5163659c6 ("perf build: Skip nondistro build test if libbfd=
 is old")
> Reviewed-by: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223725.1215=
00-1-acme@kernel.org?part=3D9

