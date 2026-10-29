Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249920;
	b=QibDODbDXcnIaIPomZISBUoE96s3WAfy6qmQr89b4VrlycKrHBR3jYN8CYNu5wXZYm4N
	 micDP2PQSCqLJZURL6/rsiVWmlbLIPKgx5pkzSsAisDdHRIJOKDUG3yuMV1npXrxmD7gU
	 9XRJ9H65HOPuHu0RNN7Ni8PIgn1LG0CBxa/km39DQ0uam/BvdzXUVuBx7myeIrLXH0r6P
	 HdqB0AndFKmQegLkOXoZbMUlNh+WXcGezNqIToVTIB6u/5tXoWMbLJy8fB74t2jW/qe92
	 LqZWxcLxGxlI7HZvhlB/uuQISRHPrckZTEKZjISc8JHMGyKwalGL3u3rwgcLSgjGtiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249920;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kjZXdvUbztVMtPh8CXbcNRri/FrIEYg/cWS2zBSvuk4=;
	b=mwaJSP8zQGns8yb+Ttyh/usabiBqTRZsPTbdhOkPCAan21e4MMrVRGvmAb265YIc+Uif
	 MO0eKASo8/N9js/pme7ZhhTZT7bu01d8aVRxif0s+qlagdYHBu4wBndXr0CiAEN6KqD3V
	 9vvAcvu5FJo6hGUZCQFNek75i+uskRTfwPLAHejwQpacynR22PlNwiLOS4KFvzdXu7V8X
	 bF+sib21PBpyzCOACQM5wB3jVp/aquCGnQ58Doc9i2o+HFuSkYESRhywqcdcgbBmX8dWR
	 W+e0Y6oP4VUJDJjiAh+tXTBb2LnufS1lJZE5GrrDOGrZOrD3aGcyVwQEw4S45vwUUXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hn3iWndV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF69606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 04:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hn3iWndV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67841F01828;
	Thu, 29 Oct 2026 04:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793249920;
	bh=kjZXdvUbztVMtPh8CXbcNRri/FrIEYg/cWS2zBSvuk4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hn3iWndVXcVnx1CLZsMmnRV+qAKVfY90xXfGdGOU5XxA+ehe6aTqfCU1ERkeUnXg7
	 CTmw9+Fbo/F4K+9qCK/kyaeSBYXI/6v2L1992fM7QaVXAmF0wPLdUqvi+Bac9aeJ6h
	 9cTHviuY2GZyqw8ybaUFOU4yFydMCtzFt846ELpKJD5qKSkTUTKAH7vbzW3w2nsNSp
	 NLr/T///58C8T56eYGXTMcKe1/3Pqy8/HTc1Ot5b70RNbkN0FoES8D02E/sLrI2UtL
	 JTjUdTKfDBxdB0Mc7FSOUQBcbTvAuxYzv0gf+ipo1IntslBB6U2AHKW9CUno+n6l9X
	 mqceSD2aJcSpQ==
Message-ID: <sashiko-outbox-188720@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v5 10/18] perf/x86/intel: Allow LBR read helpers to
 operate on explicit stacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029043914.1395147-11-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-11-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 04:58:39 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The LBR read helpers currently assume the default stack,
> cpuc->lbr_stack, and therefore cannot be reused for other LBR
> stacks that may be in use. Extend the *_lbr_read() helpers to take
> an explicit LBR stack argument, so they can operate on any LBR stack
> instead of only the default one.
>=20
> Update the related callers, including intel_pmu_store_lbr() and
> intel_pmu_lbr_filter(), to pass the appropriate stack explicitly.
>=20
> No function change intended.
>=20
> Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029043914.1395=
147-1-dapeng1.mi@linux.intel.com?part=3D10

