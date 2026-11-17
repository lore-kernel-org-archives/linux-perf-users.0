Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884690;
	b=p7tzzzfznYkm7tJKzrce5LeJTp7ZK6ygGnPuyvCGI47gowgTBo/xKThPaT2NYWRDsJJD
	 LnkfoFtfaSOYz7AISv9t9uq2e000aXEkyY1C7ejUa7gHOfTNR6Q9hKQLHiQ/zfL6teZUZ
	 EYcfk6mCNXEsZlhhVUpxbncLF7vPm3oytDN/mW7ANA0+ne67vyhXw9GmDHS34S1OmmJbD
	 uCWCcDPGMWgkB2g2dp2CeFuzUvtev7jHwrSRYuKHM2O4YPkQHEboglccD3d9HIlrXQaZG
	 K1ycGvLHfvNkSGsy/iBiDsD+508/kIC75e2lTs7IcHnSNb1or6+qy4v45ORao+tvP8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884690;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+aeW+F7R/NoHs0kJrATKQ+G3yTaCUiCd2uKcg5vPvRg=;
	b=lXgY+g7q+z9HR3Fegk0xROzXJt6yJBz6Hn/nhITzNh8zpNePJ3EaQK/dPbjKYfnxpuBA
	 sVpNhTxh4sZCwKLDJshP1tUqyT0QUcs+pUT990mNwwDCWnbWo9+W80X8NDQonCdwpCCrY
	 mPIs3wPk2pbORYLTc4y6/QEMfQ7lqmf68Ov8da2k6YaYfFxJaUZDLRogIzfWu1fidTwWF
	 Nv2MqTpAL+pFoqiEbPLpfziNdsXZqwbDjBdb5pJ06YBEx+XCfnY3MVee19taMcjADZ2lo
	 30mTj6p8s93OdNnT2bcMpt7CsW8pG77ZU8G4sWSwenaDmaGiTwvTpGMh9WqET5lAoUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gayT7lEv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA854606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 03:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gayT7lEv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF881F000C4;
	Tue, 17 Nov 2026 03:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794884689;
	bh=+aeW+F7R/NoHs0kJrATKQ+G3yTaCUiCd2uKcg5vPvRg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gayT7lEvhKxdGnpmyqhjK86aODpmGkt8IZCTPyvWBKWX0rcFNTAtMO/irK1b4x7vM
	 eFJJCMiy6zlrShY+Ht+By6dUV+ceEE8WUTX3ezEtOsfKDR6cbYCJMAUpUcQAyD31YT
	 AA36Z0bGefefsLqKjhXAYn3s9wd5ak7pwJGc9Tuy09lLpP76OYT9inRF2gQhQd3fts
	 Ur9yUb2j07OEDqxUIaMVWYoarFAG+bSk6AGka5IFAErtK6G2M1C5IiojUqVQh+Wxmv
	 Sm2gQvRp/Gm7cmlmV80prGKtZN80rhOr0k52BrUMvjvHIOSQaWGqapJteqg/xxjbzZ
	 WxMGKY6mq8wzg==
Message-ID: <sashiko-outbox-218119@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/12] perf build: Record the display-only features
 in FEATURE-DUMP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117025305.3958882-10-acme@kernel.org>
References: <20261117025305.3958882-1-acme@kernel.org>
 <20261117025305.3958882-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 03:04:48 +0000
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
> llvm-perf and rust are in FEATURE_DISPLAY but not in FEATURE_TESTS: they
> can't be part of the test-all fast path, which sets every FEATURE_TESTS
> entry to 1 when test-all.c builds.  Since FEATURE-DUMP is written from
> FEATURE_TESTS only, a FEATURES_DUMP=3D build, as used by build-test, never
> sees them and silently builds without libLLVM and the rust workloads.
>=20
> Append the display features that aren't in FEATURE_TESTS to the dump
> after the regular feature checks have run.
>=20
> Fixes: 206dcfca1f5cfac3 ("perf build: Autodetect minimum required llvm-de=
v version")
> Fixes: 3f5dfa472ea6771c ("tools build: Fix rust feature detection")
> Cc: James Clark <james.clark@linaro.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117025305.3958=
882-1-acme@kernel.org?part=3D9

