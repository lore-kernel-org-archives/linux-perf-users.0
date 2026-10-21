Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550320;
	b=aY8UnQiA+nP/Z0ZbcJkJhdnpea/+Y2UYe4UhYtQUul2UMCzzc8MRWAR8gRU47RAUvYNh
	 m0I+RhlLXJsb+lEVPPHfHUmQ333igkb+kr39VWLUthaZMYLotCJ+Odt2jJD1qjbLWLS4t
	 /Q3RALDoMK5P0BPjuad6wQK+bInZxK3qY0k3U0VgrKRPAtTvfRgqgOqMHsjQX9fvMYywT
	 U2rOgCoJx7WMZFCebcbIf/lviVg+imMjVWF0ZzF+21vuMHCHskaVEAHDvQo89mnRcRCHp
	 /vnuJMcecTF9t9RF2vMzmW0fV6tpRh2t/+cRGt3WPHjDvpFzJiRNmv5S/aPnup67Bjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550320;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Afi+b/PFwQnFeZaEcoTGQzbA/gy9HoPLvral9h+xn80=;
	b=gp21ehthcdskevGnU+3ObqZb50hiqtQyTnIOfIrAz9T/ut5Ihw6FDeGavJOZJQt7QeLZ
	 eqAkOl7rF4Nv3d0fepK3RWuVEctSb8Mm3JtJgGvKAf+JLF8J1NDMW0+KlkrmfHVSwZgHl
	 FjiAnQXbHlpT/2ZkU6PVXpcbj/7D/+CCS+09iCYiNSJIYqmopz4mqNrADL+ADmJsylXOV
	 kvwH4FG8OUB5nvtEgvszEV1D1NFJP1RD9HXc31rRTUGL4XSoTipiDQ2S/nQAOGlSucncu
	 bsrNRRTXOQDaB5w1Fp6SO7M9UT4By//zRZ57Lm3HsscTAqKOUznEfEtUCxuK7jsf+xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kLOWLvQV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C709B606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 02:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kLOWLvQV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6FC1F000C9;
	Wed, 21 Oct 2026 02:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792550319;
	bh=Afi+b/PFwQnFeZaEcoTGQzbA/gy9HoPLvral9h+xn80=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kLOWLvQVeX5U9UXtTrUOm/qP9yiNmYlRN7wvHw54/ULFaiqpQInAaqMkeaQiHjZZv
	 SgjnrGXitpBVo+ARFcD42Wd0C3mMBw5ijU919P0buquQ7VTak+WyJGGhMVBxoYs/Qn
	 CzmYDzdG1/dhuTWmHwtNDXOL5cEEyK9rNCrHgyxOjcft8sDcQn6dXdQM0m1QMdtukU
	 Tk5SxPtO9mUScoWg8+rK0E12d1OpjpcKSj6iLTBVeGazvcwgI5UzcCRkoCFjAB0Wcm
	 BACbsoP9wMy3m3pgghuPJ/JrfmIQCH9uQICyPKmMErQWALjm7Fw034f2iTdbSSjL0T
	 Ws706qcq5rzog==
Message-ID: <sashiko-outbox-179706@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v9 5/6] perf ftrace: Support omitting
 execution duration in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021023337.809936-6-atomlin@atomlin.com>
References: <20261021023337.809936-1-atomlin@atomlin.com>
 <20261021023337.809936-6-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 02:38:39 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The Linux kernel's function graph tracer displays the execution duration
> of completed functions by default via the funcgraph-duration trace
> option. Whilst informative, in scenarios where the user is solely
> interested in the call graph topology, call flow sequence, or inlined
> hierarchy, the duration column can add visual clutter and widen each
> trace line.
>=20
> Introduce support for omitting function duration by exposing the
> noduration sub-option under --graph-opts. Consistent with the existing
> nosleep-time and noirqs sub-options, it accepts an optional value, so
> noduration=3D0 explicitly retains the duration column; when specified
> more than once, the last occurrence takes effect. When enabled, perf
> ftrace configures the kernel's tracing instance option
> funcgraph-duration to 0, and restores it to 1 upon resetting tracing
> options.
>=20
> Because the profile subcommand fundamentally requires function execution
> duration to compute timing statistics and call counts, combining
> noduration with perf ftrace profile is rejected with an explicit error.
>=20
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021023337.8099=
36-1-atomlin@atomlin.com?part=3D5

