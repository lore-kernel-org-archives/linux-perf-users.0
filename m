Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793383112;
	b=duo+04SHfdImFd959tX7bRqcQ+uWRjrY2DhyMP1/KyuErrWehwFdKaT2/UFO3Z+ShG/I
	 xFNm1ZuM++NEGlhrYolYWkFrePPNUzVuUOk3OHeSAC0J1eX+lbLypC4rxAuP2aCmaZoLb
	 AW6+ZbFurHf21VvHU/43DiononpZbOoBKXBNmkFpCYSGdR824fFqrWoBbkYuuDr4t0NJx
	 A1zncK+KoxSK7W0RMcCmX1V+vLVByhnZJvCfkrXFxlcnIZaSRlEnI+w60N9Nbdd48NcgA
	 SGpU73AierbIk0VyIceoe2XdSOEVhJ6f/gGdc7nzQpmUoWlghEo9uC33bEVT9P+2N0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383112;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=piLZWpk9IVfkd3t1N+4AOaZVMqZj8bDdlOxwHJ1qFhg=;
	b=P6UL2O2AzRBbPl2UwNU+Gvl8D3w4Xn0swLRI10nEVibUSNw9eIJlngeocXWEJhNK6rQ3
	 PkS0HNYZXUYNe6OT01Tq1KzUeWDkQkPChrfCeBjjFcKKoDX0a2ydvr5Td1Qb+vDuPKuJP
	 iy8XqkU3tr5l4ouSaB3gL0rsnu8XNmRUs8KvytZTrkZAG39A8V0Xfr72pxMv6RFscSCJL
	 8zft9w29gZyFVJuEr9jYnbiWtu04pdzNPzMYVTdzaudDIQI8JCa+V4huquoBr/57i65WT
	 Vit6Zd/jWQjM/PaLqZU9TnzKVzBRUzxwoKtnLZ1w0evADpHDNykfyzYUccVZCfA1cvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bk02p/pf";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66293606A329
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bk02p/pf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C96E1F00A02;
	Fri, 30 Oct 2026 17:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793383112;
	bh=piLZWpk9IVfkd3t1N+4AOaZVMqZj8bDdlOxwHJ1qFhg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bk02p/pfH65z+q9xHZydG5F1mXhwappTAevzTh07a58E33OCUV5nFem3T9sPBh7Qa
	 fMA9uMs1srAQskbHIJTTPnEPfa0Qpw912rjqDOFNOfc3ftDkV8JL4ZsEOomrUFLlHB
	 VyottlrKy3cOYByDbyyYY+P30LkQp74LslYLB9EumSUe+p7E1kUAXvA6jdBH9imEJI
	 lRufQv9ATCZy+D/RhpmFwhBaQULhGNMytvT4tNLJEpwKXtzLXd7hCVHdckI93LZpmm
	 yfXdsKwshUcw+78dT/qzRupmWdfzAyHv4QRM4g8DPcnaPPsduA49ovVTHZRVGX5gs0
	 KCPUJxKZjKhkA==
Message-ID: <sashiko-outbox-191383@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/9] perf jevents: Add support for NVIDIA Tegra410
 PCIE PMU aliasing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Besar Wicaksono" <bwicaksono@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030174816.1544471-3-bwicaksono@nvidia.com>
References: <20261030174816.1544471-1-bwicaksono@nvidia.com>
 <20261030174816.1544471-3-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 17:58:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add alias support for NVIDIA Tegra410 PCIE PMU events and metrics.
>=20
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030174816.1544=
471-1-bwicaksono@nvidia.com?part=3D2

