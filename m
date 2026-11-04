Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818482;
	b=QiUzeme6R09IhoE8MFB5ItV73YXRt9NH7RobGLeI+BdzPZTt3UCFEHDCnGsHOncGTke8
	 kjyAxQuNCDWPBEXRYLUkyYdQhB7yO+fTBbY8JqqYgFSTrbs0nPx0TWCPh9vSshMHgdJsv
	 gsRFm3xtHhaJnxVC/y2OeI++P15IlX4Vy0cW8en4hTrSiU35rLthtgpcedul0ratCB16X
	 OuwmgjQh9iz9d0E8Tdav3GBXV4KVHPtyPFuMHcM9dOuyD6RtBpjsT0de5uookE3tfu7so
	 uuuQYoT0E9c/dSBvti3AHJZprb1WF7ZyHi3SMmVbwh71OXrq/KpbEFOX3iHRj3ovXLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818482;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WpEKXxjnlEdnb2X+lDi4jTgeLRFe9gYmDpwrffbzx04=;
	b=WZt5U0Ci/kHgGukdxYsE3w4+SoeVht6yq+SeXEyb0/spVh1FpYTpJPdLBxoK9jxIwfCo
	 EcYd75N3ZQ8+1uXif7Ez2+vz8tQfBZ5O3pKi1q7S9e4puF0e14kxLyofSLcFM+dhE0RCq
	 9fB+MZfUnuwMV/SgAZXKcQK+BIwyR+N5odcFA5vE4Tu2bCfHlPL6Fl7bBIc8xnb7jE3S+
	 cuihko/UVuG8MRtn4Fs84UBXl1wQdwCq2tW17hC6pHIiGg4Mr06SSnhPj9daY7tsAVl2+
	 GgfFxp0olFSWCKPNxN/wnM8O0KjpX21pUeK+ibpFiXQW+C4CeBZ/Mqv1pjiaciDIrdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CC8IG/lG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D186082BDE
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 18:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CC8IG/lG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063121F00A02;
	Wed,  4 Nov 2026 18:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793818482;
	bh=WpEKXxjnlEdnb2X+lDi4jTgeLRFe9gYmDpwrffbzx04=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CC8IG/lG7P7YXjZmv7A8Oa5TpLc+ZMudZTqzy7X4yO+zthRmkF7EYzq2W7nF8p1dl
	 sLVLLOpyp49PH1HMx3QGgC0zWGiRxAPfzeDA5VkbSf7i+e5/LVEuiTbNq59VhLJ7k5
	 WeUj5p/YDG6WHAyyk2x4aLgT3uguzk5eZ7fI8UTBKsx8HlWws0HLaTSvBwQwI+EOr/
	 a8YQbNdpBlBefKhJHmGV3z+UbUbKRSL3OfqchV4xYoMWPhZIl2ai+v1PTS5xGbAJEa
	 VzzanCT93OzurNj+Bb52RCA0NdQc3/t+9A8UVcQGJZ+ByEMDEPu7wR0IPk7wLqMMAz
	 HYGiC67rCUT6w==
Message-ID: <sashiko-outbox-197889@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/13] alpha/perf: clear PERF_HES_UPTODATE when an
 event starts counting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104-alpha-profileme-v6-3-63362e9290a3@gmail.com>
References: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com>
 <20261104-alpha-profileme-v6-3-63362e9290a3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 18:54:41 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> alpha_pmu_add() sets PERF_HES_UPTODATE and maybe_change_configuration()
> then programs and enables the counter, but nothing clears the flag until
> the first alpha_pmu_start(). In that window alpha_pmu_stop() with
> PERF_EF_UPDATE skips the count update, because the flag claims the count
> is current. Since the next reload rewrites the counter, everything
> counted since the event was added is lost.
>=20
> perf_adjust_freq_unthr_events() does this on the first tick
> after an event in frequency mode is scheduled in, which is the default
> for perf record, and it then sees no count to adjust the period with.
>=20
> Clear the flag where the event starts counting. alpha_pmu_add() cannot
> do it, since the event is not programmed until the PMU is enabled, and
> stopping it before then must not read the counter.
>=20
> Fixes: a4eaf7f14675 ("perf: Rework the PMU methods")
> Assisted-by: Claude:claude-opus-5-5
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-alpha-prof=
ileme-v6-0-63362e9290a3@gmail.com?part=3D3

