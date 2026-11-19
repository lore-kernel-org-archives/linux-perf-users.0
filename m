Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110836;
	b=mqDyLRybrXaZsnQYh42d22A45F/a1ECjQoTbs4dhurlcsKHxfFxtWVjyvKca0jTRI7ez
	 360rje89IkZPUl3y+80NVPRao3fEcLQuLg5gOeWcDoGFuANe3YgUWtWJsbZIFKjUx2vWH
	 RW4fL+dQDPGK5dnxZ0FomAYPoHBMduD47/uaXejZv6kP321m0lm/cxPCz0dTk3y6iRJ7I
	 sgQRsm71bCQp75DM/rY4WdN5Ttnyh3OmUgubICC8i1SnFQQUBf6evMbmjShvQwxK1iqoW
	 98JKiyZoSD6Pn2yzjmRU0Ln7BcnJM2lkQwU/O1lIamHYPJZ/nIBAj83qvA/yqnoDoaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110836;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mfCMSJSVryWRe0whbPHJF3ua1Yw0G2hC0KARhHp4cDE=;
	b=HOqAeGqszz9WrcbnaOcUHy78SjlrHq6b5OMtNG4Rh9jPDvzV4e3ypvWERnM0k1iJjaHi
	 KdG6Cyh7S6ynfOzYnUD2qfaSWTbOjXana4HoG9uh1M1zztmo7l6nTbOu+J2wYxkobC/sZ
	 wkXsTcxWXlhzfntzcGIKftYYeZxB/nqn22koAdog1XCLurEjxDrQ3oiVnv9dvxfBTSNAo
	 Gh5pSolj+/TaF9wuGaT5d5eEEsxHJHBsWNMWQ69TDSeS6oA6jozGtQEXLFU/bzRbqBUKL
	 OlnePv86iCu+mroK5ffprnfYjChUSe8thgUNcCgO+Ihj6856NgAJ+48avx5f9yG3UMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="B8/2A/v5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66601606A324
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B8/2A/v5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51B01F000C5;
	Thu, 19 Nov 2026 17:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795110836;
	bh=mfCMSJSVryWRe0whbPHJF3ua1Yw0G2hC0KARhHp4cDE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B8/2A/v5va/vSqPHxrssCyCzPJlp9BzRwCDIKLG+9mCKoSGe4g8UGjIbo9OIIzMn6
	 PgCA5PC8r8ys22k7fRMdVESM9rcH5fMhTQsJKR+5K5ihWYkM92CQj8cYZ6+HvwN+5S
	 YoCYnM22ue+Bt0cWPbq2PT6tPWCCetx/Fc98EQcBAA2dh/ue8GuftrFP6+4zcMB/d7
	 WyPnNcysyPzer9s4Xr+T4P6M0E6AX9nIHa5aWXePa3TTEioz41KfVuhZMMyDPpKy+v
	 uqRQ6Am8sO0m9lRVY1l/gbOhG397uapd6gII4NiiFR0Fnk1b7WpU3h5XIwz/lzkNot
	 MriouQwCOPmaw==
Message-ID: <sashiko-outbox-223730@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/7] dt-bindings: mips: mti,mips-cm: add performance
 counter interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119-i6500-cm3-pmu-v3-4-c86410934b51@mobileye.com>
References: <20261119-i6500-cm3-pmu-v3-0-c86410934b51@mobileye.com>
 <20261119-i6500-cm3-pmu-v3-4-c86410934b51@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 17:53:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The CM3 asserts so_cm_perf_cnt_int when one of its performance counters
> overflows. Whether that output is connected to an interrupt controller
> input is up to the SoC integrator, so describe it as an optional
> 'interrupts' property of the coherency-manager node. When absent, the
> counters have to be polled by software.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-i6500-cm3-=
pmu-v3-0-c86410934b51@mobileye.com?part=3D4

