Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019716;
	b=uF6StpQFkmF1Da8kQcKK1VbuhSt+X+sLUWVegtX0WC+aqSWFzfNeW2AEnUPoILDwC/4X
	 3KCc/QnPeKsT5AxHwdjxKr0GXkVfGx0Dwhdv2uYl2OZmrFXcKFJFp6KQ7B6AVNvBDOtgM
	 WyuF9EGnVTLk7bmR87tFaN80hcSd50YrSzioh9arYUwwmAqhtFNWAwcHX7iuODobXYjCG
	 y4R2pxIBGj5cr2DzZ0qz36ObWElGdsXvL9AQP5kOWckXNZ7+t1juhqSrzqCUpH/E2bFuk
	 AdKJVEdbsaMI88sNjzKCpRr2KoiKZ3+INr6EQOesD568Jh6hu05/cd8Zj/GJvgxPhmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019716;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CbLLtLskX4xRJthpxtxVIzVraXC6Ps1vYWf0WBaN1HY=;
	b=EQZFfZi9BMl45gPs2WFbZNBbezjpTFdjJvcZzfzUsvgnPc13U4YoMnqkGJGxbuuP6zjI
	 VNWHnWjSHq10uSvrRzvTaiqXylX9oLr4j+lVfNRQeEyYkTesu6SjtnloGbHKckTrzUb84
	 CnN8Kcqu6SfU6jULQqiMLWzJUOv5cUzrvVoW0n5BL6HkIELYivMx//WJI4ejczrpMGCWe
	 /qXRboFLBxkXdtQCBGMqXequWMCjPeb+uPQpmSLo8/CQcpHcl5T9HmLJgN/okCLQkGrSt
	 s5Aws4xgsB/TObis5U37WcyMAhGdzIN9Kmz6JfWnYLqv1cDkkqMV7cEm0puZBn8FSfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCI3C7zf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B92606A325
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCI3C7zf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0331F000C5;
	Wed, 18 Nov 2026 16:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795019716;
	bh=CbLLtLskX4xRJthpxtxVIzVraXC6Ps1vYWf0WBaN1HY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UCI3C7zfLvCAPOKgL/kGcZf0I11VQoYan0BKPN7/PAG5LKq30Xk0EvP8do2aXWadt
	 sFPVmKsSJcGZZI1OCKSI+ZIkHUUD2j0g5aj/vE9rDrhtfGf7HWCYpFSnaesdENw7ah
	 unGn6ZHuguw6s4rrKpCM2eNiiuIQnCTvUIKlWHaxG5j8rYaduu/Tl38O2HgOyaHSH0
	 nCc2NETg4ureatXEhreuvVuSOY5ODVgwEPq3a0gt0hlBg8TrcKGWLfN0cLCsXPOC48
	 a8eNsoEn3o1zadbWzryOljRNsxukTodAMqGlvoetfKHmPyxNtsMlRfnqW0Xj6nXQsw
	 CF2zEf+X+5cdQ==
Message-ID: <sashiko-outbox-221504@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/34] perf cs-etm: Track threads in timeless mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-11-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-11-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:35:15 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Associating TIDs with PIDs is useful with and without timestamps. This
> is an old assumption from when timeless =3D=3D per-thread mode so remove =
it.
>=20
> Update the comment to say exactly why this needs to be done and move it
> to a single function so it's not repeated.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D11

