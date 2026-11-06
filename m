Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941616;
	b=JHBvYNYATg/YLduFKh2Tx0nmAIhLh6WkkQj6CQRyarfperduxBDhs+XxLtmNonD/54RA
	 d60jWU1/LZXYyFUb8IYrS1okqvbkAesYlnfJ4SCuJyg5icXTEMVhSfT+zKZr5ovtzLLZA
	 ZDNJ9MR5iaTKbH5uGhKG2A3Y9gwZcLMM78hqToFDuAFAemfQxBPnA8/A78nftUl0b4q4U
	 z19bP6APGCQtoEVzHj5x6dyHFC29/gGnY6KASGCpcETd9Vq3Bt3+g1h2cZa1jvJLBWuXF
	 A4YS93ioc0Z4Q+JJzCZr34jy/cHzVbJp6Q+Ol6Ear1AtkpNQJKbB/rH7EpRNFUOCWBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941616;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aOMsEvfHj9rMRLucaFcY3QEQu2DM7YKIhu7nrKbO8vM=;
	b=sbj/mp+Ra3MuKZp+WnogII4EI9UIfLiuHYRHgrcSsfor9GSWl3WixTd2Xs41D/3V4vYE
	 Kr9jKa8uxsGK0dXSTSfxgV0dDggODddU3T4ircK8BI+AC8KHoCehoBppswC3X3SVoZxUx
	 HNKDqL7GOvRy8ZZSM5q+2Pr56g2V/oYRW/Uf2OX0SMgx7Y1SPni0s6TKsBwj594j68J2y
	 M5FDADTPp63FoAKTMdMbR+t9st5F1bfOBZmBUfXap1g5ugS+0pzKa3foUKBvDhWCUYhM2
	 nKpfmOBhXzZNBA2TnZUULanGFQw2vDXCkDT4LamKtV9/M0FgwP/EgIostwyKKkJgfQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a3R4Dy8S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53847606A31B
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a3R4Dy8S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C9F1F0089F;
	Fri,  6 Nov 2026 05:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793941615;
	bh=aOMsEvfHj9rMRLucaFcY3QEQu2DM7YKIhu7nrKbO8vM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a3R4Dy8Sr131r2Pc6V+LXcc7HQLN2daxoTad6avzigLDFEKzN/oxQvTu/rwuSFsSu
	 3JtLFj5XgfrPGDq7GkOz798/7hXaWBNU5yFcIirvn/ZuaJoB/KMQFQ5Ng8sZy5xKKu
	 1AgPFDiZgMEngWbVT82XuFSaocjp7TZEG2So7gDYedFLILHdj6WR/nig8BuBe80W64
	 E6W9y2GH2X6q2qeP/xriKzX1RrfUG4WfoEqPgPaI/RqKXgNIZfA/QlFSg/6kfBgM2V
	 KUqjlWVI8Urq43fpOVi5w/gJ1KgpBNHXQ9Ea2CwF4DmctilKZXfnFUhcl71n0jpCzi
	 uA/3Q1KB12OUA==
Message-ID: <sashiko-outbox-200794@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/14] alpha/perf: implement ProfileMe sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-alpha-profileme-v7-7-c474e892abb0@gmail.com>
References: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
 <20261105-alpha-profileme-v7-7-c474e892abb0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:06:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The 21264 (EV67 and later) and 21364 have two performance counting modes,
> and the driver only uses Aggregate mode. Its samples report the PC at
> which the counter interrupt was taken, which lands a variable number of
> instructions after the one that overflowed the counter. On an EV7 a
> 16-instruction user loop shows up at only 4 PCs, anywhere from 15
> instructions before to 12 after the real one.
>=20
> In ProfileMe mode, the instruction that overflows PCTR0 opens a window
> during which PCTR1 counts, and when it closes PALcode delivers the
> interrupt with that instruction's PC latched in PMPC.
>=20
> Select ProfileMe with the new profileme config bit or with precise_ip,
> since PMPC has no skid. PCTR_CTL[SL0] selects the mode for both
> counters, so a ProfileMe event is scheduled alone and perf core
> multiplexes it with other hardware events. precise_ip 3 is refused, as
> [ ... ]
> Suggested-by: Magnus Lindholm <linmag7@gmail.com>
> Assisted-by: Claude:claude-opus-5-5
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-alpha-prof=
ileme-v7-0-c474e892abb0@gmail.com?part=3D7

