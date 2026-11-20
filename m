Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197667;
	b=CgsUbWOnBK4lDjDhEDnV1AGKP2V59s8dC9CVxCGiFx/cCZOSm98TS+pircZaQrnevFy8
	 gxYVlOktI0RPahyILuXvlV7HkcKRPUcITpDdcZ2L4MVSq1K5/Z1fjWh0qKKYw+Mf/HlC2
	 38XkgII2NHxW5Pcj2vAYHbjuYb61n0LP62/Svv85Ot7Aw5+J5ihB2sLqeZ6YGzLYxUZAG
	 CZWdqIoJD5QyM1TVCaJitVGyrUpgM3GBEVXbAMromxyQJ+I+Ze3LHDx7JFyUT2L+TgSpY
	 Qpzdz1J0DddWbPu11gojyxVVScnwWL/Mu9pxzWLwP+DGqt5CCkuetdA8Bd0O7Yvt58A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197667;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l9zGVRW2xZE0wnP0YGoIqhMVE+yn/pAq9FV1mta/UVk=;
	b=kM/NU3LJUdUJrWMcE5+l7jyrNf1Afbw+cXyK2mXH877HO4tPCcJZbd1yivhE8x3M6pk4
	 PWbFAzFIc5GKb8LZi6QXfhruYHQbqd0uVwJg85GvZMrd/HFtoZfGmdv0yccAE0xjDSDlb
	 XySct2kYtbcTeD/y7/89rmdDjcNofyAbOXpJ16KmLMDJ+J0htmILr/aqauSgw1lPxhquT
	 ptcM6Zi4JqAJ/mR8l6NkCwUoWfyTwgS2fB9L67iB9i/u2mYf5elAr4YnKAmV5WxI5udfH
	 S1U8/s9VLOILPBz98PaFhO4j720WNf2MzW+Jd5VVSAYGxmPz2iBzJ0tZJPUqAMU5aPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NlOIX/bG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AC060A2610
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 18:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NlOIX/bG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A4B1F000D2;
	Fri, 20 Nov 2026 18:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795197666;
	bh=l9zGVRW2xZE0wnP0YGoIqhMVE+yn/pAq9FV1mta/UVk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=NlOIX/bGlP4MFLpfjImzCt3Z5igGHhSk26pa94/55NifVCVTE7nN1G+IkJ4S0ErPZ
	 E3WLKOw0SD/YAImHrv41sd+J1eHjEFqvdfX3yvJOWbj+3ZpHxKBFhal16CcMx4vlvn
	 y+mwzqVw0rQlS3w6ZNSMFLIFmSe+Q60XKgEWA4ppcm90hz6xZA7nfuB61aNCP4dtt1
	 MDIDlQTBHgXrmXGcSmHalGtsurmPE2kR40wHNV7G6GOefRzgkWwCgoLVQkwVR7oj9L
	 zKLdxFP4Vd8wNzcAry9bdB5/7lgHlEqaxMtREw5AT8nqhkVDSYUPGve0qr/af4xW9B
	 pYUvo6LMnCLAw==
Message-ID: <sashiko-outbox-225777@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] perf vendor events intel: Fix misspellings in the
 Intel model tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261120175840.1274637-3-takano32@gmail.com>
References: <20261120175840.1274637-1-takano32@gmail.com>
 <20261120175840.1274637-3-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:01:05 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Five descriptions are misspelled: "Prediciton" instead of "Prediction"
> four times (the BPU_CLEARS.EARLY event in the westmereep-dp,
> westmereep-sp, nehalemep and nehalemex pipeline tables), and "contoller"
> instead of "controller" in the sierraforest srf-metrics table.  Four of
> the five are event descriptions, which `perf list` prints as they are; the
> fifth is a metric description, printed by `perf list metric`.
>=20
> Only the descriptions change.  Regenerating the tables with
>=20
>   jevents.py x86 all tools/perf/pmu-events/arch out.c out-str.c
>=20
> leaves every event name and event code untouched, and the generated
> out-str.c shrinks by 477 bytes, because the corrected text becomes
> identical to descriptions that were already stored for other models and
> the duplicates are dropped.
>=20
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120175840.1274=
637-1-takano32@gmail.com?part=3D2

