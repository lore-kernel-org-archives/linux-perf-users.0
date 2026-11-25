Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608198;
	b=mbrDzJhfErI/BRc9w0VIKmE5AAYo0SkrL7YCzebKvScOxLW2f6ihDqI29Oy+mrPEvzdh
	 t/IV9XDBnUo4grlQ0nzObVJ8Q0vhofzwnC9vKg8dtC2rrD7BPbhHMKwf7IaqGtkacUz1K
	 TXse+W64o2Fa87XA+q9D0tzoRm/IH8APIBm2TsLxn7HHLAdiXlDitfSv3/UIMgQW9ZdB1
	 x8D7uyayFGyQgQj1BxmaLoIIjDHWtbxHTGq2x1fplyOkdlBL2KTDAZccG3WStUYRPyPq1
	 X4p8wC4O/+AWz5D4ZIv0Dw4JlouGYdTQV4itBMfp+y1+/Cm2DRnAN5GpNaSPHK1GxQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608198;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=N1sNjAi7FF8b+1XaoRADW4MJ42XhnYGdyas8QQSfDIs=;
	b=SDZIhd8ZeykwDUbPEdq0t1B+uCC3MPHyjXveLpqWHoKqLuWxf9RNW/io6jfgaLo2hAd7
	 SWjEbpmbRuACGT+CZ4zhAe8ffquykJpbnyHZuzvrDXmNjGIhERiHYpoOReYSxA4PYX2I7
	 8ipQwHpFsCUFWH0x1+Cq8qEBlnwHNsrbYc/mgyZHoYjiOnMo8rbqB5CRlwLK57pklXgoZ
	 1d/XX6yl1mtR3Ur9QCmEID/YhLn1ihjekHncojmpcZ6eSarVdqTgzELeo3/1I0pLcpQkq
	 mIKcH+34JlYJDdfoYFCH2zdJjrCLGx+wDBS+qhnEmYyugNJZvEr3YlfxwVD+fEH00kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iD3pmz0p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0987606A697
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 12:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iD3pmz0p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6EF1F00A19;
	Wed, 25 Nov 2026 12:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795608198;
	bh=N1sNjAi7FF8b+1XaoRADW4MJ42XhnYGdyas8QQSfDIs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iD3pmz0py7rGcE34zwA1vIAElTSUtk03fd+7MaKfFbodEp9QbLoByAkd0Uzza9k7d
	 sD0I8QVO3eQeUb+FVftT8QWgnE8Bjx3pLEdl+DenvTuN1pI+ySrv+EMIbKDLkDdDWZ
	 43SkYvsFbhPnw+Ese0JR4WBoiwxL+O7erdY21X69oauTBEgy9KNUpsZWcZrasa+tSO
	 epwAdIvuDM72K9CXkJIXZqBByodnBUv9eV0LbLmMT4pnAScYksIvZgUpRzlH3wkRFL
	 WkIRk2pZ1kkrrTDrKEmwgdUdKy2Hue7zvjk9SzoaJzJ6dspYe5JAIZ/YZvXDaoG+D4
	 OcNBuXcuPRbCw==
Message-ID: <sashiko-outbox-233330@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf/aux: Avoid reclaim for optional higher-order
 allocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261125-perf_aux_alloc_optimize_psi-v2-1-b2ac7ed12849@arm.com>
References: <20261125-perf_aux_alloc_optimize_psi-v2-1-b2ac7ed12849@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 12:03:17 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> PERF_AUX_GFP includes GFP_KERNEL, which contains __GFP_RECLAIM. On
> fragmented systems, costly AUX allocations can wake kswapd. When perf
> falls back to lower orders, the allocating task can stall in direct
> reclaim or compaction. Yabin Cui reported that the resulting memory
> pressure can trigger Android's lmkd to kill applications.
>=20
> For PMUs that support scatter-gather, higher-order AUX allocations are
> optional. Clear __GFP_RECLAIM and set __GFP_NOMEMALLOC for these
> attempts. Perf can then use contiguous pages when available and fall
> back to smaller orders without reclaiming memory or drawing on emergency
> reserves for the larger allocation.
>=20
> The comparison is based on Yabin's result from an Android Pixel, a
> production phone with 4 KiB pages, 12 GiB of RAM and 6 GiB of zram.
>=20
> [ ... ]
>=20
> Reported-by: Yabin Cui <yabinc@google.com>
> Link: https://lore.kernel.org/lkml/CALJ9ZPO9XxF-kz5K67Jg8RtpiEmK7XFU3e+xD=
ak6LyV_We7yBQ@mail.gmail.com/
> Suggested-by: Yabin Cui <yabinc@google.com>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-perf_aux_a=
lloc_optimize_psi-v2-1-b2ac7ed12849@arm.com?part=3D1
