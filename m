Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792968459;
	b=QO5MgXDgBlHq6RFmAwTgt7x7xR12xBnH/9i5lZ6yRuY6vba8uJheI4ufFEGdAWrWdmcy
	 bWhsdZOn15hlVDvXeWmUtOPIpzENxTSubW2+V1lwOoZae5bk2/uDbr+1DAE227SjeO4Ax
	 idYrmQSjJM+9iNnM3DbkvxsoYLcObfHoy2+2uoJsDhsbwNyWDPgHoQw7NcRZNOxPTpUDq
	 MKmD0g1XiT6nwviU7R76Bn/CCduVEigLofno2qaF2K/ah9qnjEz02gtsCxbxklkoDEfMy
	 fd6kDbIFsYpEWIGkHvCdRiTmmXfGK2/BHPOLR7x/oM9H1euwfQ1bxOrjxXf3qHcHoIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792968459;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Gwwe31rUlaxvShJ/hfytQGel40QMslh5Sxjvn6DnBXw=;
	b=wjEloFuL551zW2q+qMd/Hf4FEoM04eU0v7b2S7psSvc72DBgZSi2TdO6u7VVckGmXxns
	 bQKP/PvoUzNXADPtqXVRHFbjXVAG6AKRQurx13FG8j1ro+tJ8lxCQUmcQeyYAO58zduoJ
	 eIRDYMWoz6HPsAOeGaKlMXFaNwcw1/rNy+hNX0EbgpxWWVnIoCrJ0NPQQUWMhs7Gn0xmA
	 OBgOTyIWs6Vkgc3sVpY5PXQjexC92QmaW+F9bRbRMocqDb83q8uhlgNujiPogK0+z/inP
	 Msq/I9XhWjG39D21WcARFD3YqyTzjmHlmPQCmAwkBzKrn7SN8voks2mHCk3RH5BuC4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=imRhPMUg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6384606A31A
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 22:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=imRhPMUg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B551F01825;
	Sun, 25 Oct 2026 22:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792968458;
	bh=Gwwe31rUlaxvShJ/hfytQGel40QMslh5Sxjvn6DnBXw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=imRhPMUgyxv+WcwD8GCksWC1bQDgA19GU0JPeavPKZcfxHIrK+lP1RT77SdPjaHlQ
	 Iqphm6DHvxy3PPik5mOi0U+AxgBr1lsXiCFyAYHWJyeEcyghy6Xvx35A1CbANWQtqb
	 4FcYLVZuJ50AAaWvP+R7x80s7JRHDfgZVlWQiCSw47bdhkc/6Ix6cZXk7CHvRIMGTy
	 EDXwQIE9YAiPMxKem9Y35M2CW6+5Bx5GNnpFTZi7jIY+UbN8O0l92cPQlv2Cu5IFCC
	 2NdY0Rha5THtW6Yzsxz8PpV10yKhrbSawKhyZNtprJk4CwAqXUGb+HwY9xxQWwQekK
	 uiNEBOH/R5qkA==
Message-ID: <sashiko-outbox-184503@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/7] perf inject: Use perf_tool__init() for
 --vm-time-correlation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261025220349.1244499-5-irogers@google.com>
References: <20261025220349.1244499-1-irogers@google.com>
 <20261025220349.1244499-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 22:47:37 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When cmd_inject() was converted to use perf_tool__init() in commit
> a37c0436f379 ("perf inject: Use perf_tool__init()"), the
> --vm-time-correlation branch in __cmd_inject() still called
> memset(&inject->tool, 0, sizeof(inject->tool)) to clear the default
> repipe callbacks. Zeroing out the struct overwrites all default stub
> handlers set by perf_tool__init() with NULL, causing a NULL function
> pointer dereference if any other event type is encountered.
>=20
> Use perf_tool__init(&inject->tool, /*ordered_events=3D*/true) instead of
> memset() so that un-overridden callbacks retain their default stub
> handlers.
>=20
> Fixes: a37c0436f379 ("perf inject: Use perf_tool__init()")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025220349.1244=
499-1-irogers@google.com?part=3D5

