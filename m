Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590937;
	b=eKPUDzCxZJYk4wNTyu67JXuXVv5uMd7sygG+EPnTtt3kXNO14ZbmH3zKKbPDzMRjJuWf
	 nhF9DRpGLHzAhG+avIoDYZaVkQuSyS+cJgYF0ByUZE/boiGfEMlDobN/UphzdUNvRt7cv
	 7DUb8GRTCKmrj17FGJtXh5hTwRrq+mRKtAcAJEh1EyT9AeAqBbgbdgU6+WCO2V6ANmHDd
	 v7LM9cWuzBNDOe8J670ezRJz0gPtCgMpV/8mNbQnRPSiEkaW4E1Dosa4+VNQatcnW0vYm
	 Y8ErA70kfei1Xj8H0OMiJTXnktpXRaC/fUyMfcxjYnpEADfRhWe1De6WnDdhhIwwdLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590937;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0inhnlJEzr0b2I//r79/L6H7SIdwk24jRQGRRHWJ63Q=;
	b=Vvv5Z2a/00sn0PorJldyeozs+gi6RAtIMJZo7kaD9F7MbK4gfw1YiSsOoA5+qJrpp+yP
	 3RdRP1HUX1FxY5TLEBX5twLb69yUnxr7SCnckKmYuM73EV5mqx0ZmttGcUBjb9/Yh2MdY
	 u1/lL8wUa1jhFdSDJtFYc9ArgZX6mDgfTtfPKLxBRuzx8z1163k+Pr1xJDb2dTMAhbeNh
	 XclhhIDPR9UD2WTFWE+kb/dP35ZpsuVjMxSGaEgkyeUqRqPqG8LhnjcIN58GODlNUs4Tn
	 +uVrZ04R128TQErxdpwGzLs/tEXps3I6hFoXk/51BFu1JJyE+O/r+HtevuuV0VEyotQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YYsrOVUW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BA1606B44F
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YYsrOVUW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D7B1F000C4;
	Fri, 13 Nov 2026 17:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794590937;
	bh=0inhnlJEzr0b2I//r79/L6H7SIdwk24jRQGRRHWJ63Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YYsrOVUWiKw6IxDikiI8Dt5J2bw2j/zq3Wnc6QUbUUHnyiC0DdTEvNx7UcoHDwZTJ
	 fI6JyrPNsr5XEXa51HL0P+6GNt616TatnmlZtvfzwXNoG3JtVW0n5urBVwDFv6RUVi
	 JQGHebXWlrQGPUVeAOPzLuGp6HmoOH0mV9JcJUm8RwqMe4ozx5WJu2YvHNVhiuvHmI
	 9S2svZ5m7OHAmOc/VIy6CiZXaX4vPV8koKhphF/odOOaISSBgfSMMg25PTA4sO+Kts
	 dOrq2grkQw8Al7hTMpSFYz8u6YPooxf1f7VJXRUF4ZcOrD6DUGxMILpNJVVN76+SS6
	 IRWfv2m5aqWyg==
Message-ID: <sashiko-outbox-213308@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/23] perf demangle: Add fast-path prefix checks for
 Rust and Java demanglers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113171734.2188066-15-irogers@google.com>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
 <20261113171734.2188066-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:28:57 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> During DSO symbol loading in dso__load_sym_internal(), dso__demangle_sym()
> is called for every ELF symbol. Both rust_demangle_demangle() and
> java_demangle_sym() previously performed string searches or buffer
> allocations before checking whether the symbol name could possibly be a
> mangled Rust or Java symbol, adding unnecessary overhead on plain C
> symbols.
>=20
> Add fast-path prefix checks in dso__demangle_sym() before calling
> rust_demangle_demangle() (using strstarts() for '_ZN', 'ZN', '__ZN',
> '_R', 'R', or '__R', keeping demangle-rust-v0.c unmodified relative to
> upstream rustc-demangle) and in java_demangle_sym() (requiring 'L', ';',
> '(', and ')') to reject non-Rust and non-Java symbol names immediately.
>=20
> Using 'perf bench internals symbols':
>=20
>   Before (perf binary):
>     Average DSO load + sort: 7.348 msec (+- 0.069 msec)
>   After (perf binary, -4.2%):
>     Average DSO load + sort: 7.041 msec (+- 0.051 msec)
>=20
>   Before (libLLVM.so.21.1):
>     Average DSO load + sort: 81.196 msec (+- 0.780 msec)
>   After (libLLVM.so.21.1, -3.2%):
>     Average DSO load + sort: 78.599 msec (+- 0.857 msec)
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113171734.2188=
066-1-irogers@google.com?part=3D14

