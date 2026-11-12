Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794523963;
	b=wb452gbiCPvqCDewV6CYeCQv/NfnqQliHhFxFx1pW25X7PxpKeiUZys6nYWLsK26o5nx
	 xfEznlv2O5D4Vr66LV7izwf9mYhih3XmwyaAYCifVNSGYGBiqVvcTbqCu2/29Glnq9vS4
	 SQUzR07HgsAq3Ck1JWSPX1eJW1r8OdEmbuf7lP17ATym/9xRl5/ecDmZgbJ7b4mVVY17d
	 +hef1UYR5EKgrAYHtljR/DNRaXPn0CKl7E7XllXTa/jTBqd2cSgrOrxBolsVpXo8uX0Ro
	 DxEnGPGN6xLztetKPJ7stj4GMGRVItYlqSQa7pxl4GsbhV5+AorjUSfRqOvyo7IlgZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794523963;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qF2wpW2tX96beOGlLM6eNmTKIIGHODeMrD0s8wZ73RE=;
	b=LCHk90C8PbgUrLTBxYfOgdTZ4RTR9rkgnxOO5YoOEh3tmENjxFnJ/IJLVTZpKogvtRqU
	 FboE+NNuqmON7RkJWAFFnjeCd8J+KiAGIWPWM2gGfsHgbQAoflXl2mEjuAbCrfEyCH7G1
	 ENCIvSswIdmlWvKga5vokQNqvth5OJWT4D7poWgormI664FvZTucXGOICPUhJ7jGhrbhD
	 WRlKoRwjxI9wZ+H5+bZN9zMKo64xKuXq67kBRO6+VWI9GmdF1PyuPC/gStmN2MkeyYugM
	 E7KUitxdPspVz0WszZ3H5WZExkoj8rq7Uzz0w3cNNvp8aAV55zn5s+LpAELtHOe6/1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gyAgs/Ue";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE84E606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 22:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gyAgs/Ue
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19B71F000C4;
	Thu, 12 Nov 2026 22:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794523962;
	bh=qF2wpW2tX96beOGlLM6eNmTKIIGHODeMrD0s8wZ73RE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gyAgs/Ued7pVN+eO5HbRCm2T0c0lq2hGm11N0A90B+4PXaLVUOrlOBKKLodxkFCoP
	 mGASjOm3ZYPA4uyaH1Js73dx/Eu1Gq6GSGAmLPhSkCetAi4GePqTp1nXrm9yVDrsJx
	 w69ytPDI2dyV5lLnWKLJYpuW7HBtkxkzLot5eHVJbf1CjwZkH4oRHFmwcP1UGElhLL
	 mvGPFNGu1vJQQt9HGTt76Nzq+icSDt1BVsEtexVOU9RFG3BrRInDgPgKS08Z2jLVOJ
	 3QtiWdP6hGB/EqPXvkXSq5chqlVRt+6DP0/MJzHZJDD6gBR7hJ++gnNdCexTojp1s4
	 yAtHaXwueLFsQ==
Message-ID: <sashiko-outbox-211925@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] irqchip/ath79-misc: map the performance counter
 interrupt on demand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261112224445.213324-3-rosenp@gmail.com>
References: <20261112224445.213324-1-rosenp@gmail.com>
 <20261112224445.213324-3-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 22:52:42 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The MIPS perf code now asks for the counter overflow interrupt when the
> first event is created, instead of from an early_initcall. Create the
> mapping in get_c0_perfcount_int() then, instead of when the controller
> is initialized, so that the controller no longer has to be ready before
> the early initcalls.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112224445.2133=
24-1-rosenp@gmail.com?part=3D2

