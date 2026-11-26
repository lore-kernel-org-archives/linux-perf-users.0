Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795688938;
	b=XU+99YnPUQhFQA2BrGBMoOJr4j5kPc6WbSgb8eT6DZ38PAcDxH8QuCPIwlvfRh6NyVLE
	 H1/2RCa7dgqPSUNb897datqFfnv2g9BShCtHyjYzTveMlQx0751LnFRGuv+l21l99M9XD
	 72OpwRox47N1ZBbVKeGuZziRzLphIRWkIOecDD0+7e5xtFI5xh1ty4Tah+/aOd0IA3ehD
	 8QgULSViEwazeVdxgSr1Lj11MyV6gmtLyaSvvEMLWwI6MVDgz4vVvPkSIsTGgOBOty/cP
	 CUlZan1/rKEskqs4BP1I5yLPAQD2QMnfDgjEcAdX4aqCUVIs87OC+AMlGEudzo7OfIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795688938;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PzlyoACR5YypKgf2YrA4SnyhYiXUPZWhdtH5d2zsWAQ=;
	b=a1DDDvs2ivxn2j88hEDeMXluu/M+6K7jTZASAludOFPsVp8KIjx6T6olvy8eF0QkUKrV
	 sRdYWMQE6ktpsb2j5amO5A2QzHhg/xh+kd6JT22DyQ1YXtDfYniS0cnXFv+x+Arx5e7xD
	 n1kychXW0Be4GkUHVtOSzduT3w/kOK7o7S9DlyfOMuRgiBzDl6e+Ds4+HuTbZi4S4ORJr
	 fBMOKyheh+BPcaj8PXo/89OIkjZhq16/EReDX72Vfp2mmKCf9A41QNo3Tpcfu7tmJ4n/s
	 m1uM+bFum1dtoVRkfetjCAOnylqAHzTTfNU9ipqonM8NfaU4hEiZo0T33amZrmWABlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7BwjnQa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8867C606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7BwjnQa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830F71F000D0;
	Thu, 26 Nov 2026 10:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795688937;
	bh=PzlyoACR5YypKgf2YrA4SnyhYiXUPZWhdtH5d2zsWAQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O7BwjnQaVV+YfxqCipT0N/gfPhgBGFySmjetl7773+uHTZSiwbfyJoLgGSVl3falc
	 OBySAdku/sNfmhqim+3lT7m6fJVjlGW0Q/cHUQcAtZ0iELRMc6d9k2oOnuDkQvEqBI
	 Kj2owF+T6T6/yjNuBaiGTzdoE6HC1HBRtFXkPdb/Pehai05mRdBlbG5Y9zvsDx8Wkc
	 ly0S2Cd5e/1mS+hTr8k04voVqCMdycy/Bp2Ko7lHYmcMRHF3g/CnYzNA3yZAwbN/1q
	 PT12A641mdjRA5TdHM2KimbdeWlNVRQ+kMTJtYD7EvQwSfd3gkf6mV5S3BkeA53wJk
	 dDs/kqdZRTTTg==
Message-ID: <sashiko-outbox-235291@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf/aux: Avoid reclaim for optional higher-order
 allocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261126-perf_aux_alloc_optimize_psi-v3-1-e06b921b276a@arm.com>
References: <20261126-perf_aux_alloc_optimize_psi-v3-1-e06b921b276a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 10:28:57 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> PERF_AUX_GFP includes GFP_KERNEL, which contains __GFP_RECLAIM. On
> fragmented systems, costly AUX allocations can wake kswapd/kcompactd,
> or worse, they can stall in direct reclaim/compaction. Yabin Cui
> reported that the resulting memory pressure can trigger Android's lmkd
> to kill applications.
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
> Link: https://lore.kernel.org/lkml/CALJ9ZPO9XxF-kz5K67Jg8RtpiEmK7XFU3e+xD=
ak6LyV_We7yBQ@mail.gmail.com/
> Suggested-by: Yabin Cui <yabinc@google.com>
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Tested-by: Yabin Cui <yabinc@google.com>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-perf_aux_a=
lloc_optimize_psi-v3-1-e06b921b276a@arm.com?part=3D1
