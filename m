Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725295;
	b=jYpB8DNZYWv7RKJH1B0LCMU22N9WT8+pBM0dhMnp0f8hE7UT/5Po7J8cNiwklF/uor/U
	 Qp1xYRe9UQhg9SFmxRYrLrPY1X6jUIIZ3gv1sPiTRzzSLU4d9uz56feMqq6m6ohHEH7D3
	 yZ+AvM6GwR7uaz2mIfWbyMo68UlweMe53GrICCq3ISUaUM4/mty6sGycSFYzVnbvbEbEP
	 rSnqnMLFEACSDZEQ2IKnMax2c84Sk+YlnVKId6vY4JwEiibF7WWAZf/QuPtxZGUJsAoSc
	 0JxO4ZSb3EKwEWJCgZpfS5xwilteg2XXjL4o77UMFdtSzGlgbFC4ggLSUv1CVF9ZxGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725295;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Sz/gJwSkDO84DrcCGCytTfDyg3oK3LO+u62uiTtW/Zg=;
	b=PMWJm2UxVP3O9KyCxB79FpL8F7AD/fdHU2B6C4LSwGRMK2TkQ0KsTO903m61gQs2rUB2
	 PjiP36FRjRBPSTo9w4ys31teDkMEtH3Rvxq34P/O+u5mokWVl1K1o1xu9LurN7Yz3NWZ8
	 mXQevywD2+K5BDYohIveKUIjsfkSIAswVhBxI//R4OLU/u9bMdxixRqhvRoCLNfLeZn+B
	 onsr+/VW0lK/Rob8iXPeHX8JFx5v7m5Cw7BcxcqdS005JQlci1aT9nSkG49gXFQkyo+xy
	 VUjPh94B3OoCkKyn87OiNljLrGUSv1PBu+4D1nOJvwJ3twPVPNhocy/AEJXFaYTVAgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VN6H1uxO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A854606D815
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VN6H1uxO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D1A1F00A29;
	Tue,  3 Nov 2026 17:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793725295;
	bh=Sz/gJwSkDO84DrcCGCytTfDyg3oK3LO+u62uiTtW/Zg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VN6H1uxOYwfKMYuaHBCgbkE83BbxgvmmosQJy3G/JoXcYVpbAo03kLRHTEnVrQJ/s
	 BB9aaX2IFII765s8/nZVEG6fgusAk8DY+tGAUmZ93LTC3PvnyxfqRhQrcEm6aAkz1d
	 0CJOXO3DcYU/1fJf0oSChIMNBvEUjvayT3FrPR4824MoMXmyj22m8w7iOMb7u+ZQAs
	 HmcYdjvdqeict1vXi2t0KigoVOhen5cD8llKPoBx3WPrPEcKg4w4MQawlwtOPEzOaq
	 i2QKMJ1KNBu9SedV9JgJX9bbdnXDz/CGGloiwuCuGSCzOr1PZe/kyTsaV8LndcWtC+
	 ezlb7u+V5nvug==
Message-ID: <sashiko-outbox-195768@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf build: Override OUTPUT when building internal
 libraries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Safonov" <dima@arista.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103-perf-output-v1-1-df33a0368cf2@arista.com>
References: <20261103-perf-output-v1-1-df33a0368cf2@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 17:01:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Dmitry Safonov <dima@arista.com>
>=20
> After commit 1572ba36fbca ("perf tests: Improvements to build-test
> performance"), building perf with OUTPUT on the command line fails:
>   make -C tools/perf OUTPUT=3D/tmp/linux/bld/perf/ ARCH=3Dx86_64 LC_ALL=
=3DC CC=3Dgcc HOSTCC=3Dgcc LD=3Dld
>   ...
>   make[3]: *** No rule to make target '/tmp/linux/perf/libsubcmd/libsubcm=
d.a'.  Stop.
>=20
> MAKEFLAGS propagates the command-line OUTPUT assignment to recursive make=
s.
> The library builds pass their output directories through $O, but the assi=
gnment
> to $OUTPUT in tools/scripts/Makefile.include cannot replace a command-line
> argument. This affects libapi, libperf, libsubcmd and libsymbol.
>=20
> With "unexport MAKEFLAGS" returned and added $(info) debug in libsubcmd
> Makefile produces:
>   OUTPUT =3D /tmp/linux/perf/libsubcmd/
> Without it, on current master it prints:
>   OUTPUT =3D /tmp/linux/perf/
>=20
> Pass OUTPUT explicitly to each library build, including the trailing slash
> required when constructing file names. This follows the existing libbpf
> build rule and preserves MAKEFLAGS and jobserver propagation.
>=20
> Fixes: 1572ba36fbca ("perf tests: Improvements to build-test performance")
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-perf-outpu=
t-v1-1-df33a0368cf2@arista.com?part=3D1

