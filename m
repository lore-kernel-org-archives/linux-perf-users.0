Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793775844;
	b=LyjUOebwUv7nBeyllJQag7V2WY9ZLYu92lrnGx7Yaui+uC5tWqfozw0oBVJ9MTasEjGd
	 +h9/9u5qmw7osa0FyIcm31hPN9/VP/gmqY0RcEOl9+N1vZx2/qWbFLUGVB2BkYno5uGIS
	 VHfy4vMiKDg/ovP7Nb0fLZK8sVmaBeWIXiFtldqWNIGOV1GUXT4c0HBQunGOR8RV71E2u
	 N7Y/alwfZ+dBpsnAuLLecXeeaqH4groA0uLX40JmWHwi3yjuT0Uti+mCfnsJCgeGQ1OjO
	 TQMtQMQ4v+wlEBvV4+NZpdNa8sciWrWzrnukfgAjVpzxoRv1wW0vKiI687M7SX4QhEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793775844;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L7oBuGXIIpVF/XJBOl7HHQ1fxQp1qkiricBMnRip2d4=;
	b=3O9Wo5wjCoXszhp5XS3RM435OvuS2z+vBnL2xO8Df2HTs2EvJ45jwlFGqu7OaIUNoaCn
	 URaGFNHS85xudCstDNbdkt4udltljqxiAptO0vZgztzozg2mpiUxrqaofuSRIoEu2NlBD
	 QsxyJl5B9/0OMHjvE8QZKeDPEE5FoSz8x3A5aVfWMCeGC0tsEcj+tHyto31RsRr3fqWhO
	 oAY2rm4yW1tzeFujL3zB2pWTv3Aj1Tkzb2uH21Mi/8QyzIeyGcYI/QbZnQpajbrTyg5xp
	 SuWVcbZTWcD75DO6YPBhcXLPHkLzf7Xd1DDAPz6r8MFBl9MByOb2Bxdxf4wWsax0zGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PHr9ki3S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68815606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 07:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PHr9ki3S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C871F000C1;
	Wed,  4 Nov 2026 07:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793775844;
	bh=L7oBuGXIIpVF/XJBOl7HHQ1fxQp1qkiricBMnRip2d4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=PHr9ki3SgRj2sPJK6lG46hgNSidft8UDisEGzMf2efRqAPP/Q7z27DIsIBHWxebgh
	 1HZGWKCgPwGwUv21ekMR1qnjTmVWwpA+ETmUZlmkGrgRvna3Ai0H+TwOyT1/pIMpJX
	 Vp1T5c+3MrPthKMx9IjVQKjWwxyxaiI+Uy68j7OS/vBov4i+lQyXOglv2VWJkuUHSf
	 8hhN/Mb5pOmkE3nVxBtVjLQBgmz07STaQxF0XyA8LaMwbUERmUD/EmOAypiPvdMwjm
	 Q/mtRps33ij4WneMsnoGRXSEWudmNcEyTiZMhFKDHBx6aSdwBBtH96L795an/NyPsm
	 gyauxnqDIbrew==
Message-ID: <sashiko-outbox-196774@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 36/41] perf pmu: Probe memory profiling events and
 sample formats
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-37-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-37-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 07:04:03 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Extend perf_pmu__probe() with try_open_mem_evlist() and
> probe_mem_events() to test which perf_mem_events types (such as
> ldlat-loads and ldlat-stores) can be opened on the PMU and which
> additional memory sample formats (PERF_SAMPLE_WEIGHT,
> PERF_SAMPLE_WEIGHT_STRUCT, PERF_SAMPLE_PHYS_ADDR,
> PERF_SAMPLE_DATA_PAGE_SIZE, PERF_SAMPLE_TRANSACTION) are supported with
> them.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D36

