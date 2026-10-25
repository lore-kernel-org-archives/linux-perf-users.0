Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792952196;
	b=UOwj3Bcr4idmDixCjtJtOVqwqnUR1Nzw430o1aJi/44D0e7yx7pxWjKVW7hefMLsEH44
	 umIECIg+2Zy2Nz8/a33Aw5GWN71NHsGtrMKaVNs6lcpoSSpRQnX9IoIh0oyC8fJQOEbcY
	 IwFjylnxfAYQjK1SE2rCPjaDtNM8rfd8NdsPIAx+i20gGMwfJ96hVEJuKmvK3Gc55Efgq
	 /3ne/jDTLuGt7KLxyNLd6D3u/L3voyt3hiky8/gDVq6wDNnJb1qY2ud7voxRUg244AKCK
	 Uv6wuv1H5PHPrvYupz4UuCZbOgFTy2cw/OMsbC14xyVwpo1FWlT6/9QdP1am7fia2cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792952196;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qUGbGw6lhXSgFcYPpKmrjDekCemkuWrCSxYH09TQDRs=;
	b=GB/NGeovMCnXWBpgqV3AAOBb3u6cIc6dgOiUoDs4s2aFREoZp589Ca8W59t8wEiDKSJ4
	 Q2txFl4lFSqc8PWHZ1c72Mgv5C19Aaf/bgh1wl/imDB0hB0jRMaQO6iMFomAmFMx/MphL
	 ePPpt0CH/hlgdXBqb14sAfP74S8YqGOX07z77F3QfJx+FLwETimns7drTtyKtAg9nqV3t
	 5F1dQ7e8Nf/MjzMmNfgQgVCl+8GJ5QgA3ALZKn5Vh38rzXT+sKqPq9BkfbJbCXKbJjZXW
	 RPdoymXH1TjxD1ukdOIr0pGgfHRBtjWw+7XqDcNPf+3YVcUJN7Eda1JIF5XGL5McquA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YRAVETB6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C92606A31A
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YRAVETB6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663C11F01825;
	Sun, 25 Oct 2026 18:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792952195;
	bh=qUGbGw6lhXSgFcYPpKmrjDekCemkuWrCSxYH09TQDRs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YRAVETB6om4HOjcsT66h5cz1ge7cl5UigAoki0cR3Eb19E+bW8nzDqWgVNv3lfkJo
	 oDR2l+orkZyTWa1bvnTEvqW/VOXSeJ+VffJ9iAiQ/IhuALf+Id3vFZexh2FB147Mt1
	 Dusm8m5MYejCowUkx6ZLCW3ELmi7NpZoKSTFprZ2ZWx5q4Tw+s3oVR3BO/X5aEZOAY
	 WTAF040jiWURBlxvqO0RBaJs7nIe6D6MSu9K+kfntz8f6TWbFMqtft19RkFoQAbaxl
	 VtIsXJeLFZBgaluwQ5XW/Cx3DxHOF50KiJps1gO13Zl7oBZLb00Ec70Sr798hrVU/5
	 RWMECjCJgRpsA==
Message-ID: <sashiko-outbox-184318@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v11 03/10] perf ftrace: Support
 filtering return address comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261025181125.514372-4-atomlin@atomlin.com>
References: <20261025181125.514372-1-atomlin@atomlin.com>
 <20261025181125.514372-4-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 18:16:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When tracing with the Linux kernel's function graph tracer, enabling
> funcgraph-retaddr records the return address of each function entry as
> a comment in the trace stream (e.g. /* <-load_elf_phdrs+0x6c/0xb0 */).
> Whilst valuable for tracing execution origins, these trailing comments
> can add considerable visual clutter to the call graph, particularly
> when examining deeply nested call trees or when synthesising higher-level
> abstractions.
>=20
> Introduce support for filtering out return address comments from
> function graph trace output whenever return address display is not
> explicitly requested via --graph-opts retaddr.
>=20
> Key aspects of this implementation:
>=20
>     1.  Return address parsing and filtering
> [ ... ]
>         parsing and string filtering across all supported formats.
>=20
> Tested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025181125.5143=
72-1-atomlin@atomlin.com?part=3D3

