Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794973168;
	b=X6QETZL47DLoevbAPOZfpszjD0rD0Nm1IRh4N2JQRJLn23oSJkv7m5tSA3FT01MKIDo4
	 qrWXfGYSkbmtxAUZVhOEDHcDvY1ZwY5CaPODVOFXOcRwORxqgAsjW4xPhJhzVnM/C79/W
	 UBS1DcmU40JkunsTVoruwm9UmSclorADhbI3nDhM6zI/P6teLdSKergGjalof+mKTs9Tv
	 p6PAkM0cf2imdFeQFdUgJEpKXsN68ug/Fa72+e3S9uf/QXnppmmZrcnGPdVr5AY9MqwRO
	 9dDxKEddjV8fBrXgtRRHTXWf9ljoBpHO2rmTOOQYPIBLNj/X0c3zzDFxjKwtbWWa/qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794973168;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Z5+LkdfNmOQAVFgQK0N/U9GTZEfdQD5ZTXtKBkd3InE=;
	b=l6NYa3FwrLp3+imRIzgbyUaccfnUEwZEjcA1xYkH+Ws97Z75izLTh1Fgx8omqyOOxhOY
	 4rGDp6UHvKv54Ey8PPmy6tW/YM8y4o1WkMpCk6k1nnGL8A8jUH8JF2Og/Cm7pxpkDRN+E
	 2hS1FeVetBJ1TYX3jKphY9cX2ILq2Ybe8NWkzci1CCtLnGiExIf6ml4sH+8AG+oQkwNJY
	 1c1vUFuwFwxcE8D80yz0/mxpJ+XUCIRLJtr6qMgYAyLwpAfU1JWYz/Mi/dGLNCc1cKIpz
	 nAhgk6zmtQWirh9369xAKv5GA2O4kmhLtygaZJ/ljAn2cICvoEnnZs09KyJdSAJ5Iyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SsboM3D3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25AD606A32A
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 03:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SsboM3D3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6D11F000C4;
	Wed, 18 Nov 2026 03:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794973168;
	bh=Z5+LkdfNmOQAVFgQK0N/U9GTZEfdQD5ZTXtKBkd3InE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SsboM3D3rW69dvCSHMlR0ZCLXnlIn3kcpZK/tYY/sUPJ7ShjStfv98b8bwsSDafwP
	 fJiejprP3F7hYUVvt0eCLoi7b9uLe6wlWGNpn9z+TmKE/emhyONf5jdtlZewIJ+w4T
	 LvQdkTdnGP/1VuOLKsNpDdfNBfAYs6puQB7ZFQi6a+26aNrnCqA6iUS7I/iVZ23XNl
	 84/tVPwaeFb89J/Ti9ReI0AEsLs7k07h7lCmfx60/KEkKwI4mBwrEndAsLgyMc92c7
	 +JG6Bm/RylF5ZE6QzuL85TvQho8fdAsQS8vZLlrLaRUBzRk1VutXel/PkStmqKYFE4
	 mUttMin8oFdCg==
Message-ID: <sashiko-outbox-220029@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 08/24] perf/x86/intel: Avoid re-enabling PMU and LBR
 for BPF when disabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118031453.1353625-9-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
 <20261118031453.1353625-9-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 03:39:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> __intel_pmu_snapshot_branch_stack() currently re-enables the PMU and LBR
> unconditionally even when they were already disabled in PMI context.
> This can cause events such as cycles and instructions to be counted
> while the PMI handler is running, which is not intended.
>=20
> Only restore the PMU and LBR on the BPF path if they were originally
> enabled.
>=20
> Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-179823@kernel.org/
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118031453.1353=
625-1-dapeng1.mi@linux.intel.com?part=3D8

