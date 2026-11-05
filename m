Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885141;
	b=x1HXHzUf0sfyKpuoQvWHo22Y6hzODWOdEMVoMLkhO8RJR/6lVYsjGlYlc8Re+3RzfCrS
	 ds7ShuC7F+eqZ3OsPeMEuhSluq961qtx7I7P0Ho48CRCfQHXRz4wW+AhE76ZXThH00foP
	 T3lZs/NpVhYwTE2pSU0Q3Tz89klQ7LCDPP9WfWUoxbcM9GzHm3GSpP3Ho1YrjIktvydWw
	 6tQJGNhqHHWqLIu8aMr01ZXYmVdNRXtgq2QtTdyKVNacwsyOdbQu8H4Oah2au+S0eQFuY
	 9/tnh7Tfnli0VDzMu4O+ut//JplItr+vvira09RTSMJG4jm8apGPGFY7INVbLnJogOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885141;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=w0VlVnCtcHvbJfMwSmjimqkL2YngckocN7Y3boEvRZ8=;
	b=rN+ZeyeO7MLP8OK66pHOVrgAow/dFHu7vS+78oOu1cIU4sD6T0wN1aj80+/Ncc/QQtbJ
	 hF6DiBy3Ct1BzzeQVRp0asorR1uSh981Xmc8hDjlutC9d4Kvd7DPWe9E0CKSD2HnTR+YM
	 ToN0VZ8GpDr4b5WVSR5nHw/PHtgLAM6ERijtzsWomtfHI3u+sCJKCdvcjYNLXIgotLY4G
	 u8BIRjeACrrrWRbW9U+1s7oFDbqBqGNqtNPMMFukKgQlO6BkAP6aZTlfGj2TEhilcblfX
	 7rId5ng+a5IJD6DZwEvFynxJ1Ua2auvrIwxGg9n2mrQsiBIe/dz+5qwz2xHZ+ST0Irw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jzc6lmuo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3F1606A32E
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jzc6lmuo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8171F000C1;
	Thu,  5 Nov 2026 13:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793885140;
	bh=w0VlVnCtcHvbJfMwSmjimqkL2YngckocN7Y3boEvRZ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jzc6lmuoVXThyTgqbfB3R0yGkbGTxpteg880Q+qwvDTjIgQ47gv8iEd4PhTIeMGGu
	 fOW5eLWPwDzVJFu14/Xs7cKQts4X+AMDCz812vnBW5XKG3va//sJX4LTAydIKxKEhi
	 z9NTak7XEngvZWsEQAFf2bVJALnY9OYu12I5xmOc+SyleBlQTXSMTgYymp7y331KlJ
	 kMwl+TmDOftEKNIrOeCmw3J5x+BZi3eesxIT5GJ1aps2igofWi1YCaGtA78ONdpig6
	 AeFmUnFkV2sPZ5maonEE4+LEtWgzaf8F8VFE13kOSL3QY7qPnABtijs5CMMYUcGnMc
	 OU8DMVVuY5/gg==
Message-ID: <sashiko-outbox-199138@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/19] perf cs-etm: Don't print missing buffers in
 snapshot mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-14-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
 <20261105-james-cs-unformatted-per-thread-fix-v4-14-7759e0ce2449@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 13:25:40 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The driver produces lots of AUX records for trace data that was never
> captured in snapshot mode. Downgrade this to a pr_debug3 message as it's
> only an error in normal mode.
>=20
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-james-cs-u=
nformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org?part=3D14

