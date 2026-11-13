Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601593;
	b=DVZ3e8o/w7wkm2lVeyom3nJjZAiscBOeEIV5tEE3Lhu6L9gJzmSKfSk4xPn5UG4yx0Rp
	 WcNhDnm8Rku48m0SNCw486KXYP5reKJzxrVxiOjsZ48k/rms/KJ98P/7h7RcGHncf/cNi
	 SCJHDizEme/DZ8DNk8jsxOtTj+JqYQ2qfMiiiGVEUk3OdmZbrSmQGVKTT2UvUczzfqYjh
	 8txnh5kH5tidTlwI5O8sf1FBJSqP1n8rrEYftLYAmKraMvnIvojR7Ss1CSqs9s2Nsa//u
	 b5D6IdtIHFPB6sEYsoAFH7h0xOjytkLaQAfn9qEuwU1p2Q/9Eg6V6ao6O1mMKkpLYXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601593;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3Fg4JBllkP0nfSndlhrjD1U/qPCJX6upMzyNbdykKYc=;
	b=E06UOLqTp9v8QiRU3vtaAWohmYGDIFXnYTc4C7e/5198lShdlVw2MjSxtAOP5HZ7KwMU
	 Sgj+PAwTKhEIK+pQ5rDD5Zr/YN9OsOWAq3uUF/1uYdhejGBHs6uXx49DpUmkhZlRiU+Z6
	 sztJgD3I/8Nh/xv+HSAzSp0rRRu5bv6sQSfFwpfJxGi5zCpRuGEXR0ZvWhChqJaCmA/05
	 dxO0chfc7WTZDreYg/Lxg4Mtf21ndriNf9DOUA52UFKnH5LVAYKnaoart1akLfa0zJq53
	 axwSQ+r2RU9lxXkeNpXYq+mokEjP3fu1/Vve3X1sp1z0LAiB4WzbLlOfx3W5UMnJvAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X4Dc4Dao;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6778D606A32D
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X4Dc4Dao
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D591F000C4;
	Fri, 13 Nov 2026 20:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794601593;
	bh=3Fg4JBllkP0nfSndlhrjD1U/qPCJX6upMzyNbdykKYc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X4Dc4DaoseHLo/ENV6sbTwkKtljSFFHjsJuM3EVF+YSRuZRHNbNptNVp/6cM6xA8u
	 ZHsfDh8Ws5+LkmPIyRdNbQXThnjubdJRuPE654Rpr4gIiEm+32yOnhawfTYSteQTYD
	 bLvQ+iRvQXziYY8ZQKHruj0MrWgJ0qfI7OXikbttIgrJjVZqPu4y7ap8YfTKXT201t
	 QEYprwTp1THd5L+mYRsSNW3309gC4J+ON5if7A73i94oNO6UWPpT5o/qUjgHmpG/op
	 qQd3r7P0aU/GZXvxJMCdhD8Dhx0/Vm3DUHOl5pn+VwqShM+GiGgL64PudaZOAvrgbE
	 HWR7f6sF6eXgA==
Message-ID: <sashiko-outbox-213638@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/11] perf test: Skip the LBR inline unwinding check
 when unsupported
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113200850.2803460-12-acme@kernel.org>
References: <20261113200850.2803460-1-acme@kernel.org>
 <20261113200850.2803460-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:26:27 +0000
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
> The check only looks for the PMU's caps/branches file before recording
> with --call-graph lbr.  AMD BRS advertises branches but only samples its
> own retired branches event, so the record with cycles is rejected and
> the test fails instead of skipping.
>=20
> Probe the record and skip when it fails, as the branch stack test does.
>=20
> Fixes: 446c595dc0dd ("perf test addr2line_inlines: Ensure inline informat=
ion shows on LBR leaves")
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113200850.2803=
460-1-acme@kernel.org?part=3D11

