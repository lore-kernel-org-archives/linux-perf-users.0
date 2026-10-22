Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693775;
	b=5hNheSe80b2yLMcQJFmU2UiLH7pTxSA01ofpWaOhajIZlMj9yPY1NWNJC9qugZlbXSTz
	 dMvDGcXWoO7gdKLRtJwn3I+S7CT9Z37Es7n/wU1u1l7YfpsDxWuSZhrL0eMocFV7jPNEY
	 N5TsFAL9h5e0UT6p/W1lCH0lvJ1Bp1yVk6fO22t4dKaUacjGFY270Vhjww7dyyf9Cy/v0
	 xC6yoMTnHFaGKv1CvH1D7oxCG/tH4xSROZ/ieyQFla1yrVVDXe5mZ3sWezcAhdPEaT9UP
	 tF6Dc4AGMw25e7V+7pXCCEDm5x3Ka0csuE0I2CgTbaHdBQI9Ri1SCUFNFS+Bygakm0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693775;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DMnPeSIPwJhIaxEEkP6ttF1XCRyabj9I+/8zgq4VHwo=;
	b=GJDXEcPX3+dr+I0rte4tavYvXBROHAOrqb+4qUKUpm/JTQ/dePM8i3H/ujI8TpIEIQI6
	 OmBa13llF6qrTRw80MrjW3lpyWwkUMy8tXsSvPntMVZUZ3+MMbnEjBf3dXtrJmEcVb4xR
	 aYSM6f1L1iaJse8Nu337qhax+QpaNclFSHa7xDjN1vvR3T9UYUFLHLS3bxae/8Ho2+/jM
	 VZciKKuWPnOnu4Uaf5KkiOdAtBMthrokKISkQrKy8/y9fx7vJ1yhYxfiRIZlLJ1FN2Mfb
	 4hFzBtMS3Jgo72q1bv7DyGu7DBrLB/G4vqilY3TS9hbTWN+y4+eLtc0KcNOHD6m0yHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BNdNhvPv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E43606A324
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BNdNhvPv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B601F01825;
	Thu, 22 Oct 2026 18:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693775;
	bh=DMnPeSIPwJhIaxEEkP6ttF1XCRyabj9I+/8zgq4VHwo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BNdNhvPvm9BNJHXv/1ZIYGiWkEwe1BVtUZnV1dmnHCQCiPotWYk+Fkt7RJ3uYEnB0
	 /w77fW2SsFAOzhXABLKwIw2EUmTV9HpPqwPf4chYsU6hxRwDI2+vmdsmaWff3/zssf
	 SllNyRU/dUUbxhWP0UpJeVLgbVI6QNsrf0lnn9q4AhM7Va1Qwoo5vlGJ05JzIdHwrG
	 T0rOCPsiocJU3Zjqlos0v3jQiqxrxY199KmkisWktFhiQZlAhgoKXElVyzv/7I0hI/
	 9XwZHkzyLuGnc9hlxdgn3neTxmS/Q1T14HsDi4RLamvkxYbe5l3T0KR8K711+az5AM
	 EP1RNWdX11bUQ==
Message-ID: <sashiko-outbox-181919@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/10] tools headers: Sync UAPI linux/mount.h with
 the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022182431.25673-9-acme@kernel.org>
References: <20261022182431.25673-1-acme@kernel.org>
 <20261022182431.25673-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 18:29:34 +0000
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
> To pick up the changes in:
>=20
>   73b40395c71c ("mount: add OPEN_TREE_DROP_MNTNS_MOUNTS")
>=20
> That don't result in changes to the string tables generated from this hea=
der.
>=20
> This addresses this perf build warning:
>=20
>   Warning: Kernel ABI header differences:
>     diff -u tools/perf/trace/beauty/include/uapi/linux/mount.h include/ua=
pi/linux/mount.h
>=20
> Please see tools/include/uapi/README for further details.
>=20
> Cc: Kir Kolyshkin <kolyshkin@gmail.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022182431.2567=
3-1-acme@kernel.org?part=3D8

