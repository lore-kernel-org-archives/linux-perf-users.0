Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794185943;
	b=tVZFkAjvbg5MPyDswgE+0XtYkfRMaL2OxjT27uvMOgV8dQyz0/Pay7eJ7vTcC9HVXTRi
	 PexV2+o+Bk6j4jJnWdntXbfAbBbMNom8B6brqiA/29BX5tX3OlGw7JUKR3Wl0q76XYoe1
	 FqScdIDkyc9Rg0sGriYjVVom5ZJXhefXPT5XMtEzsnmyzgaEP8NLlBWtPsmRSRxNuqEgv
	 LhCO03fyBGuiyhcybyiuLv+jv9B7pxVesMLDPPTuxhFU5TYNV22v6xuAf8W+GvAHhMjZe
	 eLtuVVRuyeX3ID3Ux6fhz8ETELXzOT9nwUJxWSXJYGQsbGZfR4mrtYtQ4HExH1EPDQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794185943;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=31s+sPbdogyDg8V6sBeS7RDt2ggI9Rn9fr3mGblgfHA=;
	b=T0xLMmFupTuGAcxSiTPMK+2lk0mwM6jCYe9XRf/XmpSiyTNo3kigNzGdimRQDGJLIPoT
	 5FDfBzN88Ymuty6BLV13XSxv0aMLKCUQTHAZ4p4UKk8FDHoUcw9L4YoTjmyDBsq18lZad
	 lGxsiYW5H1/ZasvnKT4NdITTwGBqaLa4RR5AVXpjItrzYv8IEXTCElKHWFQ4Behb2oVGt
	 EVpNScps0lSqHsGd3ZLjigr8TBBPKuOIKyZUVsQzr7LQX1IJHScqIB51Q/Em9utSumf6o
	 XKI9y6jrUU76auuv6gUB756KXBbtSTklxnhEnbVlIF41jkHGPMG70JjLli0Xv6xbu8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AV3ajEGq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4628606A31C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 00:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AV3ajEGq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6541F0089F;
	Mon,  9 Nov 2026 00:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794185942;
	bh=31s+sPbdogyDg8V6sBeS7RDt2ggI9Rn9fr3mGblgfHA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AV3ajEGqUaQh6PR+ar3axs6IAIq4XCFj/jUEj14FLmzfLjFKn6c6Q+C5P2SikGRqJ
	 oYs/LNywqsOM/pBzuKjC5/Mo9ENau1g6NOK/6Q+JmPOWQTh5WVZ3LjJGia6dgQAyTz
	 C/Gdw7uY0kPfei8unrZCf+sPBAzZ1UfE+6HZOSZu6KWnyOsJDEyiLDa5+mQmcB9oX8
	 XsGazFYf3haiOZgR8nD+MNIchjndzjNC8tP7MfOvdcfIEQpe0cstWwlCbA+jznBj1m
	 oYurU9TEVd2Ai/1QFczm6lr65OG2IAqLgM7Klyc+7I2t/8ssdXglCaoptt9Lk49VZo
	 OBI3jGQ3KdUTA==
Message-ID: <sashiko-outbox-204267@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v2 3/5] perf c2c: Show memory region in the
 per-cacheline view
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261109004402.1403713-4-dapeng1.mi@linux.intel.com>
References: <20261109004402.1403713-1-dapeng1.mi@linux.intel.com>
 <20261109004402.1403713-4-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 00:59:01 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The memory-region column is currently displayed only in the top-level
> cacheline view; it is missing from the child per-cacheline view.
>=20
> Show the memory region in the per-cacheline view as well so the display
> is complete and consistent.
>=20
> For example, the per-cacheline view now shows entries such as:
>=20
> Cacheline 0xff11002f7ef47a00
> RmtHitm  LclHitm   L1 Hit  L1 Miss      N/A    Off  Region  Node  PA cnt
> 100.00%    0.00%    0.00%    0.00%    0.00%   0x10   Mem-0     0       1
>=20
> Also move the c2c.show_mem_region assignment before setup_coalesce() so
> the per-cacheline header is generated with the correct region layout.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109004402.1403=
713-1-dapeng1.mi@linux.intel.com?part=3D3

