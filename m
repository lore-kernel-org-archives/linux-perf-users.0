Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794997472;
	b=WP1k7ymrGc+Gq5nQfVHeU5KmSdlkO8FjTHr9gC8g63W+ZHffZIFYbrkPtDT8c4t4VvSx
	 IQ9AQi/a1qBLl5K+wdgsg+3pOp133hFTDadydBh+nDt+lcI5G9UegwhNbdBZe+gqUsaBW
	 80wuSbcfU/C6gwZoRrifQIkHXvhb8F+me2H7VimfUkPg1quh05pRaI68M557LMVZL2VXr
	 obekLPmBv1L5fl0aYJpBKr3+aKhXpM/IzOAN0kLxKlVh2szyfVh3TVDTw2h9bHb5kZ4D7
	 ChiYgf2ylORTjIAG2DTKemmU0ahyEp+mKNwe7s7+gk5PPwALVumPQWMNUD7f8nDyHyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794997472;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5r2T4U9L0mMjTwobTnTElddijnNU1+IttyxjxBkB4YQ=;
	b=xHLQ/gHKa/iLnkoCJ5Dg+/RrzHuLncvpLZBkXO2CHNs4pcYVFJ2s/xmLyw9PTMWnsM52
	 C6ZArl0Sz4wmzShQPTdv1VIgY1Hq7chfj+11A65KoXPO1y7EjLXGn5I0QsYlZXHuL3Myr
	 3V6Jix4n6kgI5vwgVLteJeIfBsI4fYf9mIPqd1o+cLHDipR//yKkdNi7C2xfsTomGC2Mu
	 9dH7tHzekKlhDN1RYrOKOP8VNy4tQokU8kq1+R/fqAovQY9myPxx9zCybFzPZ1cJG8cmm
	 nFzaSBzjYW62fFIiwaEbd5N4MJ31FtAU7LrOXxF1bGpHyvMYjZ0M68BWp4CkA48j7UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMpMc8Ld;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C08A606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMpMc8Ld
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9241F000C4;
	Wed, 18 Nov 2026 10:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794997472;
	bh=5r2T4U9L0mMjTwobTnTElddijnNU1+IttyxjxBkB4YQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iMpMc8LdEXruYDaxmnwJiQNq7vqD50YDe0Eocon5TiU///sytN+0jyRGvdbKO+AWo
	 XbZF+Umq3Gd1x2qIzmgWls7T4a5I6Tepfu2wHsh/CB3C3bwBcefzLW99MU44YSQsA0
	 MVuOMWDeLV/xBMrunSGdLeyZZU/6M6Veiik7AJdZJK2Iv5lvay87txMQvkrEfJkdAE
	 kWtY3DuTVo0ntA5aFXsO74V5Hw7cA7fQBWlvykT9gDamLfVw+qSe+YWUEUs/LlPATS
	 nhAP5guF3lKFxA774KJ18WKa8hjdcwMl+iaSx2zpErGgIXUXk98hyKgG4LPBbSWmOY
	 BLSIJWmVvjZZQ==
Message-ID: <sashiko-outbox-220684@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: perf: arm,smmu-v3-pmcg: Allow
 power-domains
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amita Mishra" <amitamishra@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118101913.3135869-2-amitamishra@google.com>
References: <20261118101913.3135869-1-amitamishra@google.com>
 <20261118101913.3135869-2-amitamishra@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 10:24:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> On some SoCs, SMMUv3 Performance Monitor Counter Groups (PMCGs) reside
> in switchable power domains rather than an always-on domain.
>=20
> Document the optional power-domains property so that runtime power
> management can manage the PMCG power state.
>=20
> Signed-off-by: Amita Mishra <amitamishra@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118101913.3135=
869-1-amitamishra@google.com?part=3D1

