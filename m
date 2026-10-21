Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792561447;
	b=MOVI5Fnx+y1+hhEkSzJP235TykmcFsCSMwlyS0XkT9qPHV5jjZhjCFL85IpBXsD8SBug
	 lxv9MT0nHvDifcLanaG4DrRsIovWZ5HHNfzTbn7WOPvi7YPKI1GU+s+lC7DwtvoEvYEXm
	 jdLQoqtLD1m8mDYwfDJytAhZLAFTbwBDLFgBanUOF94Gb4b2B3rUO9uRS6j6kyoiI9BHI
	 R/ust0XBVzb+8Bm60jdA+oEpiVXft/zvRZ3CFlNFYJcietGXsuo/1sM1TUOoJGEKf5O4g
	 T99KJfQyPNwCCOCaTSxr8DuMNpgdD2K5TqbwGDmz+X8w5Fmiiesu0+DLhzLUtQ0CR2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561447;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pq/EgefaInmaM1xMHHOCdx/71VJap7V+jzn2MkyXbWs=;
	b=PhwZDM0ZRx2zM1TXG4SajBvwE0ngB+SZzhGNR27Tjm2qlZNUkg3ZmfSQz0utJH702Ru9
	 0/L6We7hfPAYRoGrDsFOUWc2sXs4uwTGenNg4icyAZlytrajyZrdUMImCPXZgewNwE2pp
	 SI41EAdWo4gJI3ycOTfWuIpYSbBguBuFfEdBuHp6Wgje7J79o05pmyPxr9z2yRDSRwLfV
	 dcDGA9KiucV3h6qQ/q9HZy5qbF1FntRVHfi6DejMMXxxSRD9xclv/duUR8WD19Np8Aj/q
	 QyfEeDSxF5zQnCVldqkvxixXB9zxTMnbAfW+G7DvNJ7ah/dGcTtrjjit9wb5yveK6nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PssnMD5m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983A2606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 05:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PssnMD5m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E5B1F000C9;
	Wed, 21 Oct 2026 05:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792561447;
	bh=pq/EgefaInmaM1xMHHOCdx/71VJap7V+jzn2MkyXbWs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PssnMD5mmjDjqUHgYvIe2DImcybu9QxKOgfnpYp5klB9JkGm/PT0xL4sqjueQjCks
	 BfsbRqUYrJJ3TvCbLkGKub7ZheeTnhHQAPufQOv4XvleR2DqvdVuhog6Qc/UEvMAHD
	 sn9U9YerRjonrjWCsq/zDF7M7Xf8/wEjN02/g2L27uFMN+Tw8CCSbZgWnuRgKZfpHd
	 OabzAr+U+/jwUkci665Wzf7t/js2OfZn20Awxp3BXb4nf7+Jz1ZGD5NQA9tldT4Nrf
	 eqkPrENycxrLsO9hOVbk4pGkHrQKYACVAIqu1oF3UxmUPYGpZaSU6Crfm9pOoqVek1
	 LckgubmWV/mxA==
Message-ID: <sashiko-outbox-179816@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v4 3/5] perf/x86/intel/lbr: Reset the cached LBR stack
 in intel_pmu_lbr_reset()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021050711.4043703-4-dapeng1.mi@linux.intel.com>
References: <20261021050711.4043703-1-dapeng1.mi@linux.intel.com>
 <20261021050711.4043703-4-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 05:44:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Reset the cached LBR stack in addition to the hardware LBR register file
> when intel_pmu_lbr_reset() is called. This prevents stale LBR data from
> being reused after a context switch or similar transition.
>=20
> Also adjust intel_pmu_arch_lbr_read_xsave() to update the cached LBR
> stack only when new hardware LBR data is present.
>=20
> Fixes: c085fb877467 ("perf/x86/intel/lbr: Support XSAVES for arch LBR rea=
d")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021050711.4043=
703-1-dapeng1.mi@linux.intel.com?part=3D3

