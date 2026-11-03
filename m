Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676363;
	b=MmT5+tJpWiZFQSyX5gq0hoYpmINOtsK5bxZkB1I+wsTZsBe6Aeuyqrnn8k7KbcrtZN64
	 ejT5OX7QF7nnAZMrvECIIt8JbMhJmrzQEEOLaXftsKyYIcFh3wyW0xjKJdpFfJd7pKpnu
	 Mk3fOCQLGnmt+bGDVbiwPvCNFOKgjfPWFE5zJVt4+dyhS7ReNARnH18rGTHyIFMD/vLQm
	 JZtB+b3VcrZ4/QF+nlttBcjspr9WPIliNGAzAlCeXntVGWypZg7rrwQraZyXELfbi7CDj
	 kBj5VBu/nS2UiMW9iPylDcFAcWJGQ0gjLAjYVexsUFR2u8dJ5wB61B5nU0+zLhEXAZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676363;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4uSPJ2+TlTP5w8f8wQNSzFeQ6nkvhIU5NxcZXvOyMkU=;
	b=5oKE2g6OTKyUnkxCnwkcNnE/QfMa+RA018G0uqmLbLfKglvE5Gj61YuBZXPNgMpdz4Gc
	 Dq7002rBrqpJChCtqh2w6CtKZ/ZTIjVMaC0yh9O+aAKnIKGUiztpipEPg64vz6l0RIHHw
	 WmBBoRsYsXXMeRawMia7mxtFTWlk2gSunFvayiLB4aWVhcTlXlhXWB9pcR7/YiI7ryJbe
	 mS3FiXRjf7J7s6gS7w26lu0oMB//Qepg9LhPwxNZc+V+32rkUHq+gPo/cj8HO7ucaPPv6
	 2uegyGy/IJoZmrEBSWADSCE5HqYGK4tP684PaD5MbCo8MOpeug/ObkNN4Ogjgywo9pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TudFlD92;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF78606A324
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 03:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TudFlD92
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A261F000C1;
	Tue,  3 Nov 2026 03:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793676362;
	bh=4uSPJ2+TlTP5w8f8wQNSzFeQ6nkvhIU5NxcZXvOyMkU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TudFlD92Uy9R6+0JA9ers743fY0Ggui0Tk4/FPAp9CHC/ErSyokv4hztaWs3OgMsE
	 QFENEsnnpeGOH2MBaRtpCidFiTUpz22Q7Jz6J0GuGk9tobKFytc+1nuzBK4PEZ5FBn
	 Cp72OcNf4hdquhHBChzSFERRDO5VoHNbTyYRgrhqXCqph6ZhlquYjq6QIWUZNBoLT2
	 G7bq/g3qmxAsxQ0AjDMQgfVj0j8QJcsl9PQ/A1ifrj8/4Xm9beCcC0GRPdRE8oHvaY
	 YRrkozRtIUVgjedxd2qGUcfAEt+2Xb31QbvC9GxBM6JgupYdyMpJtn4rLrXiZmaaOZ
	 KrkqUnAxtAZug==
Message-ID: <sashiko-outbox-194514@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/7] alpha/perf: implement ProfileMe sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-alpha-profileme-v4-5-61e00f5e1da8@gmail.com>
References: <20261102-alpha-profileme-v4-0-61e00f5e1da8@gmail.com>
 <20261102-alpha-profileme-v4-5-61e00f5e1da8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 03:26:01 +0000
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
> multiplexes it with other hardware events. The event type chooses the
> [ ... ]
> wrong path are sampled at their own PC, as ProfileMe defines them.
>=20
> Suggested-by: Magnus Lindholm <linmag7@gmail.com>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-alpha-prof=
ileme-v4-0-61e00f5e1da8@gmail.com?part=3D5

