Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793582530;
	b=YPmXC+xEiFvAedL4x4fc6su/E70f1HedR/YBfTNj74/qWI3+yVKJexg2dIzKursZw/zr
	 jFjOYk6/VxSUs7kQ+U4Tj5tSEqFhxzWFpCSvPYADuFCjDuMgvD3ftM0bkOxcB1TWBet4K
	 0F+rtrLrOht/jAGvgm947pp7YzARFnGTZyjXNg9FiW/PKEWUD6DHPp1oYdoC1Od37ykOP
	 fBcY6PBOHdr7J7QjtUXvEHSQ4P0tQIs5SSlDwyDKO5/keYobC5/BzqgH4AK6G35xKCczg
	 LxfDY7gNevnSb/IKuYuH33yYO5lZQH80urodaeqOEH+k+LwNS1Jjc9onLN7Z5D3dFaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793582530;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G1M3iTdkFzk5DmhmR6lnl+wtZPJ6OizEJsyOyfYFEP0=;
	b=vzH+gSpCt9sEJ7LajeOnub1Q6Z2x9NMIe2mxU3QJvK6tv47DqT4XaVDGNe/Z2RQQLd/r
	 DtYNH6kiXpVuaFjmmfnSVrdq6tpdMHJW8IiNKi5SY2pCN58kRJ8TgLuSLTxsa2sR1qeP1
	 TuS/LE4lWn2biiaBsZJ8aIcuvaHX3flyIQm+OWNYDk8gXeIG2DPFlCTQpMNw3M6lhBVCv
	 dwFXlmvvmEKekkya2Db8nxbIBMk96DPob++PhM9aGATllevF9tvUybVnopejPEz7iYb6p
	 qYe28hoY9sa5SvrkzJ1JG6zsluboWrsw43q/HYmTNgcbP/MbTTb3iwKaEfgY/msk92w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ReBtxXP8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DDE606A331
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 01:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ReBtxXP8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6641F000C1;
	Mon,  2 Nov 2026 01:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793582529;
	bh=G1M3iTdkFzk5DmhmR6lnl+wtZPJ6OizEJsyOyfYFEP0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ReBtxXP80OX5n+wV4SPFyBQtleu2tWipBk1curAumJv579jbAihND9dro8wCi9Ije
	 2mJwJ3LVQsKHiYF9a+Q6WikPrV3mkuhZwJ3xnney0Peu1lyJ7Rjr2IOcan/PTA2Fg2
	 JQWGCbYkDdf1Wke7iruX2NY47ZSwcWZ8FtsAdt5EE5uFZv9XnasdYkfla9lg1dS0Ua
	 vbdSXw9Mr5XxB6EEt9NJfz/9BNsHorxzCckVz5Y0Z5uxYrn/jDHZk9005RQ6S3Xu64
	 2069lFZ90zAkEklqO7Lb33+QhDrLZZ4YpsGCLZJx0kj1FYox3uKiFm9f8ZYxtbKx2j
	 lbguFU2+cNjgg==
Message-ID: <sashiko-outbox-192803@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf/core: Avoid NULL dereference in mux interval
 store
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102005905.2017784-1-dapeng1.mi@linux.intel.com>
References: <20261102005905.2017784-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 01:22:09 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf_pmu_register() currently exposes the PMU device and its attributes
> before the per-CPU perf_cpu_pmu_context (cpc) has been allocated and
> initialized. That allows a race where user space writes
> perf_event_mux_interval_ms before cpc is ready, and
> perf_event_mux_interval_ms_store() dereferences it unconditionally.
>=20
> Fix this by allocating and initializing the per-CPU PMU context before
> making the PMU attribute visible, and add a NULL check in
> perf_event_mux_interval_ms_store() to avoid dereferencing a missing cpc.
>=20
> Reported-by: Hanxiang Xu <xuhx@hust.edu.cn>
> Closes: https://lore.kernel.org/all/de936c3.1476b.1a162c34cec.Coremail.xu=
hx@hust.edu.cn/
> Fixes: 62b856397927 ("perf: Add sysfs entry to adjust multiplexing interv=
al per PMU")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102005905.2017=
784-1-dapeng1.mi@linux.intel.com?part=3D1

