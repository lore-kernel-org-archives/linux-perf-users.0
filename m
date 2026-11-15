Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794756176;
	b=MqR8Ob0zUuB7+RC9wcMjQ1KSYdynF1ZAgNRQiJdDRgHEJ6sIZJdVtH38M1Ysw45QK/OB
	 2fnNZieUj27YfxgIpQeMHBCvMaecsa0/KFS9LVI8GKRtNtvnyILE1E/R+TuRIEvrKtipt
	 a4u+GhVYznr/vJ1GNk3OJ0qiwb4iuXf4tGxKvUpt4Wz+Sf7rKkKJGu7T/iiMaDZSAco27
	 Fv0XLRdYELYl3EtLLy91nqOT/XpiWeSUb+KhHecb3tf/QM5zEixv8VR8kOrNRty1Qu+dg
	 es3/lbAtwhvFPEhdc3d1AyAGdrkWrorWOiW+vp4nUTVDMbLCeDm5YItktOR3HA/x1Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794756176;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mNL9hZvWFKedsjnhtlPNANm4Gc7qRaU0YCvjv/UHR+I=;
	b=sHREWlR0XO/5ueEZ6E42I86TPmcuwng1Kzs7+9bYwMlk87sAH1nM4Kn1QHAAdKZvrWmw
	 kQ7RnZlAg8htUN7zlS7Zcbrqymix3gZCemSDfW0+9rT3zlv+7o3orFTcDCt8Dw4+UGOOx
	 a4aC7K7Bio0dC8/SEAOFHPJJNML7xPzbQnOpmfCuwXCU98qt2s83dHObZzHKsLcJSKdI4
	 uaaURpdC4BN5ScKyoE/kaN/AjSLf3Q1AdipuCrRHgzpjFIAImn9Ebv9lqerF1tHQgtV6D
	 qu0urzGdhZpiuk//BnMFGDCY88d24H44lujN16nyaHk1TTEWTklj++q5riiK+6SupxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9wuhe1X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F24606A31D
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9wuhe1X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AD41F000C4;
	Sun, 15 Nov 2026 15:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794756175;
	bh=mNL9hZvWFKedsjnhtlPNANm4Gc7qRaU0YCvjv/UHR+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M9wuhe1X74qWHn95VzDuEIS7QH0ApCfZuCPSFWjFGQ+8GDtP4I+BIDaSyzA2yzfit
	 j1dBy4ZnjM5rnpV95let8j+rFur/qXbDQvxoKXjT+vNdyeSmMcr5XfRphu042QKVvz
	 34TWOxyESNwEaV7zs1Acbz3CzIkEAgMBi2odcFaKiTuEFo1pSo40EIzNkLCBdrTO7i
	 z+B7jnpN+ZK76PDM3nhwHisvMaGLCgUe3T0Ux77pyaCsp1x4/dmD7BHdj1mFnu8Wct
	 kB3rtF/LBSCMOZN9Ze5gJ7l6rjiIz3tPSRaXXXnqjkEVz465yyZn2PHVlB83NvvzzT
	 lIFXu3cClvV7w==
Message-ID: <sashiko-outbox-215620@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/core: Accumulate lost samples in inherited group
 reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Avi Weiss" <thnkslprpt@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261115151458.258097-1-thnkslprpt@gmail.com>
References: <20261115151458.258097-1-thnkslprpt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 15:22:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> `__perf_read_group_add()` accumulates event counts from inherited
> child events, but overwrites the `PERF_FORMAT_LOST` fields. A
> child reporting no losses therefore hides nonzero parent losses
> while it is alive.
>=20
> Accumulate `lost_samples` for the group leader and siblings so
> group reads preserve losses across inherited events.
>=20
> Fixes: 119a784c8127 ("perf/core: Add a new read format to get a number of=
 lost samples")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115151458.2580=
97-1-thnkslprpt@gmail.com?part=3D1

