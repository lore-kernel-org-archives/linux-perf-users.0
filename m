Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794512136;
	b=q5ndQneTraWPsCxL9Vv6MdizRzuikvV0qUr6+uLXSsSbd32kur6OPsBSowkpcdfn1+Qy
	 w52nZzAcOhQQ5uw6YXmRFuEvoT6VPY9NJ3TlYlB1FMtSAdgoz5iBQGLWJVLBZQe6Q1GKS
	 rhIPJgmYpRSxVIletXjQHM15WsYeATA1dUv5SuMiR56dCfRY16ndrs13xg4dFyxsd/gB/
	 6LZJZlOGTV6ru7hPlMMSdc+f47fHlHujrizUbyYiYrS6QUL3Wkn/O+VXJq4Q74r7t2BE6
	 tuxRg5mSUpf7gpz5mPowlc6bdtBY5PHYFs0x+mZesTA67AiUKhxZr9dcaO72tWRyBUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794512136;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Cyx76UQhrcgPr08tHM53/LuuJ0driAY9jyQTpVHY1J0=;
	b=Wf9HUGtPpTkN9SXRHXc5aeI7liT6sj4K0ZDGYXJLR+t/d8QtazZsY2mVDEYgihfOGpIy
	 Kdz2rQKi4wfNShGYES0AQ9j3IrmmcCwNWBStMDhO+Rt9snZZxXGym1x1eT0Tf/IH/ojna
	 /v1MFiNBHtKo1frYQ+8BrGXTOA3sqQJoXhoaJp7IS7H2URqgSoEaaVRXPFfIxPA6qym7h
	 cE8zqCIVBcSujwVY8xJAsHvaUixB0Ho3eXrRUTzos3U5278Orwyj7AwI5+mht+9RQ2xj1
	 xDm7KoG67ou2XE0ISPmteGXAx8+qi4xUUo0xmFuvuP5tq9DtpCt1G/PHTqASisQS1vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LAYfGBcp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5F3606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LAYfGBcp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20E21F000C4;
	Thu, 12 Nov 2026 19:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794512135;
	bh=Cyx76UQhrcgPr08tHM53/LuuJ0driAY9jyQTpVHY1J0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LAYfGBcpprhnArrI6bXnV9uLkTcM4zfNj/TpV1KHTb9vDaAnddDoXUSIKHsfz0wo4
	 Fi4vI4xG+Mizug5YC9s7b1YI1I0qzIF370Q+Wt0Xc4xzLtwfxRPa8PkoT12KtfCd1F
	 T5+Df1a22hqMoqHlN2Vbij9ELM7PdtD2FxP+bWcsCGCtu6osBcyiLPX+aUDIbZyv9W
	 lW3N+eEo1L7BlTbAIWWbS1gy/0jNTdDLZTHYc5KmVa7a+jksWaBkXVK4hdtBSFG2ay
	 RjMq8ekumq33obao+9vFs+loT8Sam/e55mVF1uOQU3cSlxDwh50l8co4SWHQCgo4Vz
	 iMGzkVMMuGU8g==
Message-ID: <sashiko-outbox-211769@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] MIPS: SiByte: Wire up the CPU interrupt controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <f.fainelli@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBFUkZPUk1BTkNFIEVWRU5UUyBTVUJTWVNURU0=?= <linux-perf-users@vger.kernel.org>
In-Reply-To: <20261112190916.3725141-2-f.fainelli@gmail.com>
References: <20261112190916.3725141-1-f.fainelli@gmail.com>
 <20261112190916.3725141-2-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 19:35:35 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112190916.3725=
141-1-f.fainelli@gmail.com?part=3D1

