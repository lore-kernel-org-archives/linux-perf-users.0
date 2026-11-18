Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972505;
	b=0/XUiwvA7w90jtuOHa7JFzUNcNaH7Hdfj9h+D3TnqqP1UzxbeKdz/GvHAoWgi0Ft6dhc
	 wQ9QVNGez5fKuCyEnbxtQsCz/ib7LvArT961SV7GONZec1URT3rrXXFoixuRsO56xqb6h
	 /QVARVv6Om4YH8zHS6aV+n0aPeUx3jEiGsoeRMxSFb8yRieG8dGCunpRlZj9GhOJi+Jnr
	 ZRAYCOZyxfoMRqHlnA0Mz+lIdkEWKv+Dc46L/LcZ6CdlaQavx4VwXyODee+c58Hh/tk6e
	 KNK5tKGITatfnaI3uLM67RRiMXsZI4/BCzosGWGQdkZLQXZGKiY4X+ezOFpy1aSOd3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972505;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Hp8TEkUSpPsQl0W3Rx9+sitz6MAGLbioQ7rIKWtIx0Y=;
	b=M7YNZrYojm5JooROgxLFrRj0MnbzRfdBLRex1vOHY65IKzFlAiCnBKGrP3avdYlQfjSI
	 suk6+sj72bp6VqjbCWOKTIZH1CCzP7JzxblUJ06hdv7ZpVlKhQluO1OLX3eMfmgHJ2jqA
	 5C3FBtK2W5oQDYkLK+xR8x0UTxHopRvxbNCaJSqsQgFGZvwQBKMbh9bYxjIjlH6ciE3Pw
	 5TxLJXC9RduG4GAeD3rzQfOlBeut1QIvBzoKIjqVl6j5rAl7aNHkHcsJ3aI4yAZwxX3Hm
	 HHR2HjUpl6od++YNzq5W6pgewP+PZzK5j1taq9v4ds3Bgyv+pouR4z4g/I1Tz9/WV5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AT7b66QI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E66606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 03:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AT7b66QI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5C21F000C4;
	Wed, 18 Nov 2026 03:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794972505;
	bh=Hp8TEkUSpPsQl0W3Rx9+sitz6MAGLbioQ7rIKWtIx0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AT7b66QIxcPTtcMTi5QbVTflpa0e5aQyZaPIkKMwGK7jmgl8N53hPbnF2k2ONBJkQ
	 M4Ue3XqzIF7tCQfAhC8FfssXNK2dcNAfb5XSFFA4E0/NybEAyITm/U8vwNk7nuxxZh
	 BnUQxAln5a6ZxA4xFB53KcWAW6mH5hRKvwp/OJpQIdAahs2/bnx3D+0oAPbE3XWxXZ
	 z81DYw1DRlCQw38BrmX6ZFWccHYVDYr7tvl8fGDwjCrX23v20RmmjyMzCwEXMBZnYq
	 4lTZ4tY75lNfApXxiW7LO67TiZJZwNAUolWBb4xYVRqh8TrPyYKckAxebm0frMPwFm
	 /AHpaXAX9d+jQ==
Message-ID: <sashiko-outbox-220011@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 07/24] perf/x86/intel: Add helper to enable PMU
 without LBR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118031453.1353625-8-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
 <20261118031453.1353625-8-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 03:28:21 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Currently, __intel_pmu_enable_all() also re-enables LBR in addition to
> the PMU. Split out the PMU-only path into a new helper,
> ___intel_pmu_enable_all(), so the PMU can be enabled independently. This
> allows the branch snapshot path to re-enable the PMU without touching LBR.
>=20
> Also remove the unused added argument from __intel_pmu_enable_all().
>=20
> No functional change intended.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118031453.1353=
625-1-dapeng1.mi@linux.intel.com?part=3D7

