Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262253;
	b=J01+KIU9B6TTcFz/7rw6ur9kcXQgLMQMrbpyBj4QVtxIKb9sBufY/eIeF773gUhGYS4a
	 /1MOchQlWx4J8fTo0LOlShrcj/NT9qTlHdc5jr8P5eSDSTGJ2tf/jaXJz23ndnGEYN7o7
	 Zg/lTlUGov3U2bjAZdns2w6SndvQUh0qIV98spzI0AEkUz0lEwUC/87fM7E2Q5lPShvAd
	 lplWFK0LyZyXCV5rmQr5c0qz4RJShhzjWhVCxfYTK6pOoU6DczI7VF8gWaH9d3bUNVhVv
	 F93iZvcJnuZPHeq2WBE8KM6JUGeNy9nuV5OMjKmaKV7BKduBo2WTLsyZoZ5pElbiBdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262253;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0Bexeg/gSFUA/jDSK/GAAh0FEFK1LXV+ETtFXoLcGTc=;
	b=NR71uMHA1Ly5kzBvGl4eEe8lpf/eHX036vyxL+YNoCZS5PgiPwcZa8JTChuXAwnEW4fG
	 FdK1qPlI1Byta249QBG83E7Yp1V6TzQ/PbGcJNWwHT7oPsaS/o9YCiPJii8/fvgPqqW9j
	 qaEsL/hBLXoi8mHUAHTNLYll/fjI8uNbczm4PAQl48YeS3tFuUJzCKPahpDMMRxbkGPQD
	 e0fYSIAfGu9cA0m+u9e3Cfp7gJXtw+DJNuDui8wQYZy6un01eClb4rNlA0h/RDhTp1pm0
	 nzjrZozIzGcV+NUYO1KCAKyaD5Q2W7Kmg5K1K7v0pcfrJd6YGCeoo2TaGw2kK0wGNVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8qMj+QO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB71F606A31C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 22:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8qMj+QO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381D31F008A1;
	Mon,  9 Nov 2026 22:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262248;
	bh=0Bexeg/gSFUA/jDSK/GAAh0FEFK1LXV+ETtFXoLcGTc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C8qMj+QOdrsrzOIzJNE6A6D0Csbp31UX0Yh26gtkMxp704HEkk89fEDIbEtkniFRv
	 hLIIylUdY465Mvega+Z4hi3+s40yuV1iQTGaz4lEU9p63cOBGiNRlg/Z0ledyF6wyR
	 rkOfcyA/lpEZKubQfQ783p/FqtyJZAJcH/2cxrCLOp6ll6mNuQ4Vkxt5MIJYzKzTfU
	 ZkUDDeV4JQbHUxD8hmGfUq999V1V3ph8sV13IsaKKstq3aF4vBog0t2P/oRD9Ibb14
	 sg7sNHTolNaKcA5TAECFZ8He/d1vYN+gbC6ozUaS5J4OVaq1esfoChnQue+azWsRXg
	 NBnTWS4h2pjFA==
Message-ID: <sashiko-outbox-205704@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 18/20] perf maps: Fix lock inversion in
 maps__load_first()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107044102.1506626-19-irogers@google.com>
References: <20261107044102.1506626-1-irogers@google.com>
 <20261107044102.1506626-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 22:10:47 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107044102.1506=
626-1-irogers@google.com?part=3D18

