Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942472;
	b=0Cof1F8T2aV6yeSw3uIgJiCtplQDOaxL7zpOdmwWaBRJOZWK36tzEJQXpn5NYcYz5QZ3
	 m0+5U76xxYjraxWpOGidJCqALSBJjwrR51ZqQjzrIYy7466pbDOloYkCH49tyK+yJIT9t
	 3eQy7YotR0XS8EZHqTGNJVO3s9sfDMpjIOP5QFtCpXgw9qP1mSHSe3vhHgmClMrrZU6Hv
	 XnoxTq2qCvkmzo+G3Dm4uM+B6Rgtol8bW5qo/u+QvD2jJxTckdcLVoletGS1QqjE5RHy0
	 +/MauJlNN9+lCw9h2vhkstLJ3Vf2+I2JCIffCelumtyP/UtOtr7QpNszFmaT9bcYgjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942472;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=30vHrof3JYNgNaC4sb09VAYRQuA+iFhiMGf5a6KPVrI=;
	b=Vz43yUOSvbQUlRppi6qerVkRyEDWKP1me4s5GQcjJrGQj7M7LySCPfo3DzhM2C6ePZ/3
	 IONFITdapTXC34yNynEmA0UYeCOLNDW0BA4AoSGL8e3eocYJi3d9M0GStdxmcgCm8w3Qr
	 mPDhy9eJsxnVL/C11A7FHItggenL3VyBJKqyVn1BVTxSbekby0TvlaaWT7UceOKoRudt0
	 ejMxm/dcvCR3RIWeWhb3zn2duwHwt+w9M5jt8jxvp5KaQoMvGyB65Fcvwt9Gmnq1W3YYn
	 tmbQzi1Iod1f9YOKQ+hUCgstaiMrENSBG8eKi4hB/qRugQGOiMhaGHRdrVdM9Vg+O3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZSdSc4W5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81A9606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZSdSc4W5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5E41F000C4;
	Tue, 17 Nov 2026 19:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794942472;
	bh=30vHrof3JYNgNaC4sb09VAYRQuA+iFhiMGf5a6KPVrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZSdSc4W5zFgH7cRIy7zkyx/2CQt5YgOfZHOBtujD6pLFlVwK0CkROuhj4eEwCaKUr
	 OjZS5Utf8yJ8La/FTETIko8H/Z4/jyGzs0+TTlYgyDyMt8nVxxS7Gf8ehzCyKVLgzP
	 z1Gwg3lFsuh9ygmCqSboTwkoG8ARxdaqZ1DAY5ZtJShwu35ZgZ8nn5Qakax7SRj8i3
	 WwFZIFmM8fUUf3RwFS9Sja4i1hYp5M2G/TAK74VillZII9v8u5qIW+EFiyucEosp81
	 /m3uxMv0sF2y0WVcepH3i+lHZlS2ziJhrTAYQfuMPFJ3T0QHuVpwU/tuektKcoPf2U
	 8vwV2d1g4Vv5Q==
Message-ID: <sashiko-outbox-219440@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 19/23] perf maps: Fix lock inversion in
 maps__load_first()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117184844.99889-20-irogers@google.com>
References: <20261117184844.99889-1-irogers@google.com>
 <20261117184844.99889-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:07:51 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In maps__load_first(), take a reference to the first map and drop
> maps__lock(maps) before calling map__load() to avoid a read-to-write
> self-deadlock when loading kernel maps inserts extra trampoline maps.
>=20
> Fixes: e77b0236cd0c ("perf maps: Add maps__load_first()")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117184844.9988=
9-1-irogers@google.com?part=3D19

