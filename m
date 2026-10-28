Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793211257;
	b=crUxNHaBr6Z5AZUFAkUuxwRitnI/TjW3MFTkQV2BrTRCbhdPbFNRHfo2Zk/VXpZMLPf4
	 wPH0f9PaNeC7zStJKvv1ssW7QAsz2QrDdnYw7uNexli3EqfhtV3xFHXFq4Xn53HbiiVNb
	 rAY8enNB8Pd0fbeFSrPGpaCx2+Ik5xrxgYwp/Xmc52PfsoCFBLGuOkKLxbM+vrX1Vz3Yc
	 q92tbjh82RiWLvZg2O35en8hqOnF5sin1WFOYkY3bxC8wW+MKgAgHGGg577afTgkGkz7r
	 JE4egxcjLVSciOPEsXdbM+ZgXXzLauYd1JWU7cWp9cXv8qtGR/Rp7FCF4seROyFsPnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211257;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Lw/dbCyi3Mb6wR0Ya91vfBR77eYYx3bPwGtaH0ShIQM=;
	b=wBum9ZKX/TNCVLLWLDbI8ti+ZhQhycPPCmNxorQ/rETTZhamD3ONVh2+RPwFWGv9mlFz
	 erwmZUBTemMpU5zUiTN0gBNBi5WWLHJLr7YxS05wYbn4FG3DmTlBL3TG8nJ0J1sAln2E3
	 2UGEyndM3bW+/fXKZH0E1Hs57neTQ/Mdx/5NJWzb1gelqzTH7HCHcdMuYIcZw333HxFQj
	 UbAQEGrCzELyHw4ufNMGThHhoJ2V4I+M3cHjxp8mr6ccrbuuPGj/RboFHNVfILqH1nWf4
	 hnnhmM3JSWkCXKUXcRcWkWJ07D3C0MYzMtEHqggQhwBE3rs4rTR2gLB9BkFY1fuktSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VKKfANLx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D07606BF4B
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 18:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VKKfANLx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71DC1F01829;
	Wed, 28 Oct 2026 18:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793211256;
	bh=Lw/dbCyi3Mb6wR0Ya91vfBR77eYYx3bPwGtaH0ShIQM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VKKfANLx5wntROo7TVui8Zm6tsYrk7rCkYiG9Is0e/T4TFipbzfJHEj6yaymLELBh
	 WTbyObLGUKEgOXkdcu7aFuSL0vIMkvWWnDc/uvSK8ZrIgRwemuZCfdJcJJ37Q3wPDg
	 XFYOaxKauaWxjuN9moyy5pD67Eh342iZ6mB78Zuc6G4wesXn5BoLH/dFRBQemNdQiN
	 wv0vR4W2c6zwF5zzrO4lt4e/BbKqNuCgt4qiees9dkSa350DvEeY+8zKuF2N8mca7t
	 VngbGaoM652Dm62h/+4VaZ429j7jBLDRIubzgTmj8kjewRdemRlNHi+ZTNUfsq9jT/
	 X9jYhdH+hVQgw==
Message-ID: <sashiko-outbox-188269@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf python: Add alpha-profileme.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261028-perf-alpha-profileme-v1-2-f46c1938d001@gmail.com>
References: <20261028-perf-alpha-profileme-v1-0-f46c1938d001@gmail.com>
 <20261028-perf-alpha-profileme-v1-2-f46c1938d001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 18:14:16 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf report shows where Alpha ProfileMe samples land but cannot
> aggregate the raw status attached to them.
>=20
> Add a standalone script, using the perf Python module, that summarizes
> it by symbol or, with --pc, by instruction, in the style of DCPI: the
> fraction of samples killed on a wrong path, not retired, mispredicted,
> taken or stalled, the mean PCTR1 window count, and trap counts by type.
> Mispredict and trap types are only counted when I_STAT[TRP] is set,
> since they are stale otherwise. Redirect traps are counted by their
> PALcode entry offset in PMPC.
>=20
> On an EV7, sampling a loop whose branch tests random data reports that
> branch mispredicted in 21% of its samples, and 0% with sorted data.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-perf-alpha=
-profileme-v1-0-f46c1938d001@gmail.com?part=3D2

