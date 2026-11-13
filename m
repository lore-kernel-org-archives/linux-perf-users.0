Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602266;
	b=FP4tODa7tw5954VnyVryGWsZcJGqhDQC5u+4WA8EyPfQoWstiOp+8z9kgQ7Dru+/n576
	 VfIAfIjVF3bdilVIAcc87cAGp37lrJAVMM4OSgKOqYGX530WtUgZCdZzV8MT1eY6Vjh7A
	 m98YGySaIzCFYWlcbQo2CTKU7GxAArJWnqhpa1MMs01kTMeQRhexdmr0vYuMEwVztgLe5
	 RGao2dGKorI63TFmsGKHr5UHbasNhJ74PGZbBxTf50amCZE2jL2OgxM8PjWk2KlqUuUeY
	 sOMcpFigEX3Ex1RM6tJkGjMrDm+uL2ooEuSxUM2wYfcKqxGqbMeMLiGS8Cer4ZS6WdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602266;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wS12biGlf01nvwwIAMWH/yPYCnz2/CHaEyyxPwTbYBI=;
	b=wfpaeXG1OGWXV8iVVFOIXuuoeoXzt5rs3ghb6CZq5BEjO0w3+5MQQDch+zn98B1jyLJ2
	 e9c+SgVcAqWXuOb+0yJFC261a+QF4qoeeZVvU0dSVvG5sBJybF7ndCnKFPo4tjKAydaPa
	 S5oz1Bd2gBcL8kjLeCHJm03kzq+7fBhUIF1qaq0BVbfGqJ/35uSYbKwyyNwEc1ZmqFREX
	 UbKXCCQ4vccbHaSVkZweVRctvPCANPCouqWFgAZE5N3mxMc4UhQpTcRaojO88WYDbjXQ4
	 afdd8VN6UVz6e4Rm364gaBiyz4KrVd9hx3HuI1AHcOudbVjoDS+1ym1SauoD2Eux2WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LoPlLFGM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C16D606A334
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LoPlLFGM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64CB1F000C4;
	Fri, 13 Nov 2026 20:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794602265;
	bh=wS12biGlf01nvwwIAMWH/yPYCnz2/CHaEyyxPwTbYBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LoPlLFGMOhXihxs9HPIl0GeU/uM8qVUWiNOlDf6+Dlj0tP5ZbVewMXyodJ8Jl2OOt
	 BxKLzS/8IxXIQCKrumTeM/Yxdp6+Nh4JXHRAxBf+vUqzadAvZoBoV1IVRRKv+k1jdP
	 GDuB2Jp5eyHZUrd+k0FHDAulTm/vriy5bIXKdRgJlANCpwY2ZSkrWryekMHkvieY6S
	 ZGgRuN/ZiXmaa0NjCrSzY+gO1f7OfAQxYZWgeDPjzsMoj+b6EO3Z035dcHl9gXWfvc
	 RzcCB+18ALnZnFwuLLcJ/oh9epS5S/QTQcVhJx+lfd6fJyBdzqqagzUHbaQ4niM5wO
	 nzN5CTLoA9BPg==
Message-ID: <sashiko-outbox-213659@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 18/30] perf metricgroup: Pass struct perf_pmus to
 metricgroup__for_each_metric()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-19-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:37:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> metricgroup__sys_event_iter() matched system metrics against uncore
> PMUs using the live host's PMUs, so when processing a perf.data file
> from another machine system metrics were matched against the wrong PMU
> topology. Add a struct perf_pmus * argument to
> metricgroup__for_each_metric() and use it to match the metric's compat
> identifier. Callers pass the PMUs of the environment they are working
> on.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D18

