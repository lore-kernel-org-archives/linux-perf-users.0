Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851436;
	b=sK67+cFoBTfrjzSurYE8wmyRpsW3NyBjnZQe8fIhNe7id1mMBDXbDegaV2xEF0dqq7ix
	 yIgDc0na6iKz9c+V0OSBvDMnYpvrHu9hAAZZMXb5Xj7G4SaQlRZ24avLyy+FphHWBf5WT
	 YmxNYTvj7cKfQnjgDWuMnOThpGNEpRKV6qy9VJ6Kiw2afKSZ8A8+VSpgTeBmkzpzbA+cD
	 TD5B7z0pZSTOBKow3fbZvqEJrpR464ldXXZxoY2rgWnmY+Da9xKdW30hgiy3RuLtrHJuL
	 acobh7b+sfOHIcIqfF2s0rCHlA87SKEdBtepF5UGUGowsj+JrEGKvVgoyf6tw6rNhKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851436;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Qn13P3LNgf4ATzzr1SEKfH/vpMFMf2QTYUpkreGMnJ4=;
	b=emmC155SDlScssYnft8GF07eJk02MBgNvCfyUN6XbmE+nq5zT399Ty3XX1oIBuTWM6dN
	 0aGFc+q5jDD4Wts8B8np4xOjXSPnh/Tnzf08sW2M35tg+eN+nwyaA67YNzlgCQ4zH1qCd
	 uEGS+EVr63q2Bi63zL01p2Sas2JA4H/7u/X1iwBfB544ktc/gbYgln2KpYzw6RQtHS2sL
	 z7uIZzvT+0JfEIVP8LZ2C/f9llbt4dVmgd0wPey77kGiiTSCIsU1T8YDgy6Ems2dMM1fK
	 ecfQ8Z/NIIu2vGnn6qvWXz2g+ny0DnY4WXMLn5UJ/ZaiCrxmxJS50z8HcKNUs2qXkWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nLGxjqDT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0C9606A334
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nLGxjqDT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195011F000C4;
	Mon, 16 Nov 2026 17:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851436;
	bh=Qn13P3LNgf4ATzzr1SEKfH/vpMFMf2QTYUpkreGMnJ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nLGxjqDTu5bpBgBtWwEjCeDi2IdrEWuBGcidnbmAtUPDpXOo2R2xIUSYgOUiHTZGG
	 LFEwuQVLAZoNxL6DZ3AoV1w3yDT3DU+/3TSnA5gMnuSVPT5NIPtpqugSfkxH4Bit5u
	 1IbFvCOhz5I1H2nUMxqCXs46BIr+TKRdkxH1+WC6EhZ5zw1GCHdeFE2wMfUWtkfDIi
	 tuLGhunrieUoGG7kViUt/Lgoqg3KU0Wsl+rjB4RgcoepDCsz1OLITeSzTf81iJJjCv
	 KPpiTBV4TdAiuSIT9nYpjwPf4mfScRoESryNV4m5ycGxyuN2g3HpcTdPYqfAWaxpJD
	 1pp5pXDT9fYcQ==
Message-ID: <sashiko-outbox-217443@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] MIPS: SiByte: Wire up the CPU interrupt
 controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <f.fainelli@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBFUkZPUk1BTkNFIEVWRU5UUyBTVUJTWVNURU0=?= <linux-perf-users@vger.kernel.org>
In-Reply-To: <20261116173843.911523-2-f.fainelli@gmail.com>
References: <20261116173843.911523-1-f.fainelli@gmail.com>
 <20261116173843.911523-2-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 17:50:35 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Initialize the MIPS CPU interrupt controller on SB1250 and BCM1480 so
> CPU-local interrupts have a configured irq_chip and handler. Reserve IRQs
> 128 through 135 above both interrupt mapper ranges, and dispatch BCM1480
> IP7 through the CPU controller as SB1250 already does.
>=20
> This provides the CPU-local IP7 interrupt needed by the SB1 performance
> counters without overlapping the SiByte interrupt mapper IRQ numbers.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116173843.9115=
23-1-f.fainelli@gmail.com?part=3D1

