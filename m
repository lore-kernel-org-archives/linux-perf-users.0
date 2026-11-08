Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794163230;
	b=wnUQWQpab2FUTLqfV6B4QP+SM7uqaG+YlKsc+SYWFG1xNeh3Bw9NIJg/dgUITC73WbGt
	 BNRbHPdN+agLeOVPGN/r9ScsswRquJcq+7IuD3t0nRoZtsCyAkud0hTMVs1d0RDgBnO1r
	 ZXRKRBZxkUWUStIA0nTcRmg/z3/M0TRiuQSo2KQ5Kx8x9arWHVuNEHJeUvbKNJHMNkkMN
	 lwFUe9ncpdvOSi96p8luhck3Z7qTiT1BKNMStYVb32I1IbgfB7TZUUt2L+RttaE3g+VcO
	 ISWXSztnvxV2dGItLaFcb6FdnAD0RT0MKTXkyhyNui0deRCaYgsWcGNDdXjGKsk22NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794163230;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HvIQrNjq8WTaxl1rdMfIG+pt4GT2ZTSngdzgdE9CgxE=;
	b=qkwjuLJcdf4wK+sEHoQD6t6o8r+4PIFoRICvPozz5ghj8+Rjn3mrkV1Yt7x+IeaR7QW0
	 MnkwgHxfRSS/3N7gEY1hOriS++8rj7XsmunC/DM1B8Dp66AxZk7gcpZx+0oq/p2faYZ0b
	 k0DAGFCtxFc7LmRGRmqfjI8EiMdbspMAZJJWfDIaOgcShgItNNZhMQBOIxt4SmYg50y7f
	 q44fJcd3VYk7dDNK4tm/DQ8Y32skXK+OxqqWP+x4WsnVAqtDzDYDPc7DPaiUmVGkaUq1B
	 whY0polTxSfCKI75SZKjjqO8F5BS19UMfQ2GDY+4ist9/bqhh9RCRrg8dMmRQpF4OnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qe7F2iE9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706AB606A31C
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Nov 2026 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qe7F2iE9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB45A1F0089F;
	Sun,  8 Nov 2026 18:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794163230;
	bh=HvIQrNjq8WTaxl1rdMfIG+pt4GT2ZTSngdzgdE9CgxE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Qe7F2iE91/Wzy3q7ubRzmycogHfeCm+RCSA3hAqRXU/rxDrNARLLvStbMM1jvMgRG
	 aqAL2JD6468SKhyjUuyBnOr9P2goygaXhxtEqz0caT5fkYXaUsJwDp5g5tHN9NG/8Q
	 62262frgEYhmoOiFblkbsopBrF6Ml8W5j3de1CJVGWJKGcpFTzKrMW6wYYqAqkamNX
	 upCEKxl1yt8vojnlM7M9+VPvxYd/YdlIsbtV5HWeBeoRjhQFZD5B0PBkAR07tc78IO
	 ph4jT2fQJ0UH/gUsAguMi5SClKS8FbO9eqrpeqgTaO6M9dZS66NV5tqXA2IZr02tdx
	 8rx9uwZmSPzZg==
Message-ID: <sashiko-outbox-203910@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf vendor events arm64 AmpereOneX: Fix misspelled
 PublicDescription keys
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261108183846.3804875-1-takano32@gmail.com>
References: <20261108183846.3804875-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 18:40:29 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Sixteen of the 28 entries in mmu.json spell PublicDescription as
> "PublicDescrition"; the other 12 spell it correctly.  jevents.py reads
> only the keys it asks for by name, so those 16 fields are dead.
>=20
> Fixing them does not change the perf list output: every one of the 16
> entries has a BriefDescription with the same text, and jevents.py drops
> the long description when it equals the brief one (jevents.py:405).
> Running jevents.py for arm64 before and after this change gives a
> byte-identical generated string table.  This is a cleanup, not a fix for
> anything a user can see.
>=20
> The file becomes self-consistent again, and the field works if the brief
> text is ever changed on its own.  No text, name, code or expression
> changes.
>=20
> Written with Hermes Agent, an LLM assistant; the tables were regenerated
> with jevents.py on top of this change, perf was not rebuilt.
>=20
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108183846.3804=
875-1-takano32@gmail.com?part=3D1

