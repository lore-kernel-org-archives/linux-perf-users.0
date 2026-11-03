Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672004;
	b=iS7dIygthaptDzpZFO7KNAqjnj5JVptFOixTN7F8df3McfFASil2fiUcn0XzfFkd7tb4
	 Tf1dIvBcZYFchZBmcxnunO1CHvoBmQDfCiHnbjeuLpwBI7G7GWxrm2Dw88HeV1s/kwmjo
	 3e6JOGFOMsJ4oZQeP2dd5QxN6T3spPj8scuF8YYbFN0P9SM4DQQ8CHdrmGCuwgvhzEJEN
	 EZYLhSBCBMFLPhPcGux5CYdxPx+IcgqXgOkkp+/3cpJ4UZUJuW2p1zqKBxuQbvyFMJeLd
	 W7aFdeALq4rUJUGpUyof4hoLLBwT16ohHcp3CB/vK/4NIstNFNKNv2mkSCJMmv53v1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672004;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KXIAJc2uFjJaVFDqE1UDb9Sj0ErznYui1ICF9PcrYB8=;
	b=sLMtUoU5v3tjcWFuAfXa6peLP2RoG/C9yvH8gPoTBg2D/14QMJLPU/qx3EkPIUI+yd/B
	 OsSrepcTXY4JEDVmiR8S2LQ62kxsBXTDxHf2c3fZtcGqFXLTlQyg2jyNtppXQ3qtrhmQN
	 0QUUbkLJ2MPw6DcxFGFbM9M73R9nLCuOkt+gJsF0CxEpZ7vlQNTXhDbRlcFjiG56Zu9A/
	 oAeD4wbgGTHe1WfVFVEqQOhg5UXUIa3r6E7qsiid8hkuzN1d5xR7+i5I7iXzY06bzN6dM
	 MupiQMDCegM0c+Lkcgsz6dHgnTymQs8eMvg5yFL/+GiB75J3wwXcPs8QyH3Y9BXz7gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TAF9TVWe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF0B606A332
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 02:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TAF9TVWe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EA61F0093A;
	Tue,  3 Nov 2026 02:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793672003;
	bh=KXIAJc2uFjJaVFDqE1UDb9Sj0ErznYui1ICF9PcrYB8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TAF9TVWej2EpHi0bqLDpMCQ+0uzrZGgdBCf0zdfrVYEIQXvjvDJbD8Y4mz98RKEW6
	 dldwAi+0BuIsRpjXZWbM2FwrrGFRF6SPL9zcf6flNg84hCX3PLw2LX5XcMYlbW6Gd8
	 7RfsSU6HccLpCs/j/H95UVbE8jjVfDHnMtsHok6Vh2l+TG5vbRGOR7crHTop3Kg6Lx
	 X5Stbln2ZmuodTKd1GqwYvhHMpTN6cICs/3IMLm2XmzExU2KQUJH8Cm7bpnwKaMC2J
	 ykGs/qrviha3sbG5P38e6B9Pcnhk05Rxh7crbiTx5hBLLG0J58Q21SD+ex+A/WmY3u
	 hc1vjKw5NISqQ==
Message-ID: <sashiko-outbox-194452@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/7] tools: build perf in tools_build
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102021253.2545235-5-sashal@kernel.org>
References: <20261102021253.2545235-1-sashal@kernel.org>
 <20261102021253.2545235-5-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 02:13:23 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add CONFIG_TOOLS_BUILD_PERF. perf is built as it is built standalone,
> with optional features enabled when their libraries are installed, and
> with perf's WERROR setting following CONFIG_WERROR. The feature table is
> left out of the kernel build log.
>=20
> CONFIG_TOOLS_BUILD_PERF_MINIMAL builds it with MINIMAL=3D1 instead, which
> turns every optional feature off, so the result does not depend on the
> build machine. allmodconfig and allyesconfig turn it on.
>=20
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102021253.2545=
235-1-sashal@kernel.org?part=3D4

