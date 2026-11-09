Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794212316;
	b=wx5ZZEPfhR9vx6E4f/vkxTDJ75r9RHGbS5xWv2gS6FkOFV1vRwk1C2N2O1G1U8triJKK
	 L00Or/pJIAEgH8NxHOvSajYqKzxzcs5KBGfVvMCuwcj3TpxPD9xgJEPBIamodpPdW2a14
	 ROpwN/LPHU4VigGlYlvJsXe2jwFFIvpqoty1rRxn1tO5BNtxNcYwZ6euYLYFPCvey64is
	 e7Kp85fCqs7wfhFZrez9YuoqxQr9nEDQntpc2glKNuWMa713/9KH/nI+RDQBH6pGpWBh1
	 r63U/1d8Vs0I+BgfHaho7E/xrN0K/lOjXhXFHkz2DZ0xz8G0jFX6qrfZpbiTXiHPQOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212316;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=i/9s/2SlIw2j222eGrBmezs92r2B4SDA5YcPD1F/bzA=;
	b=D7Uq0tv+trwiuhoQXeaLQvg015VpESRtRvj7hZqTk4Kj1gFm4el2T8QjSJRHxUfXd/C5
	 9LsazXYlOPlR62vi0yeuMMXZMmL4dFwMOC5jBBF1v+0NsVBuntSYaniOxzkDI3QKze9XH
	 T310er3n+KspAYGSEYg6OhbSeIUHkKr5/nksx7ESf8kbqCHqEFWJ8Vpqb02F7YVQURM97
	 Z298YZjvooGSqsWK/9K4TsfNspk2f70bOl4YemHkLNmd5C5AwuNrGNUeigrP08mwEQLdy
	 8WqdaVpx1ip8VkE/ortCDo1urTjJoASf5wS1Hvrzci1FCgBAvxVS9Jkz/anVVWydiuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LlshMkvA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDC0606A321
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 08:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LlshMkvA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552331F008A2;
	Mon,  9 Nov 2026 08:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794212315;
	bh=i/9s/2SlIw2j222eGrBmezs92r2B4SDA5YcPD1F/bzA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LlshMkvApoADorGA5cr0tq7/unE6Jc83/+wi7T0BYzFA+h+4YW68P8f3nkPXGN0ap
	 MciyOUNwe8HYCCKb2gCftidCWySq+CaGHemyRdk6doOzk1yOhLdJBIUuod9K4uSHjo
	 Y4vd8HaNB9elPJfQ3Jm4Xc/RhLYY7Kgp58Xkvn2I/4X4DtXXDcbzNPbnrOunPx3qp4
	 xbWSoN/63IkkQHN99oE4eiyvKdeW1FaV91Zm0XS6VnrtpX9fvVIAQlww67xPE3ONkA
	 qK5CCTBGHf83GAmOcD7bW8pS0YEv35Y8XArpMQ3G0sx+YP9Zk2pmCSClPTLBpTOoLi
	 BEFL5WjuvFXuA==
Message-ID: <sashiko-outbox-204582@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 2/3] perf: Add Raspberry Pi BCM2835 AXI PMU driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261109080126.417161-3-irogers@google.com>
References: <20261109080126.417161-1-irogers@google.com>
 <20261109080126.417161-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 08:18:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add a PMU driver for the Raspberry Pi AXI performance monitors. It
> provides access to the System and VideoCore performance counters on
> Broadcom BCM2835 and BCM2711 platforms natively through the perf
> subsystem.
>=20
> The driver implements bus-watcher refcounting, group validation, CPU
> hotplug migration, and sysfs event aliases mapping hardware-specific
> events to AXI pipelines (such as DMA, V3D, HVS, and ISP). Memory-mapped
> endpoints for the primary System bus are read synchronously, while the
> VideoCore VPU monitor is polled asynchronously in process context via a
> single bulk Raspberry Pi firmware mailbox read across all active bus
> watchers.
>=20
> Co-developed-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Tested-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109080126.4171=
61-1-irogers@google.com?part=3D2

