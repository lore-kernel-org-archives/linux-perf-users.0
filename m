Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794758987;
	b=Ifb7BgveBlDCx2ELt8rYzf4qrfM6UfyxxjIzfeKlAizYyZo8/YCFMxEsrb+JyB+0la++
	 M9MJeKdlQRMkirx3RqCF/l3mvxfrmFp5SFgtJOh+mh7wPdrW54cNLYdZf2CralCEcsxxx
	 3LbKfwukq1oAZwMNJGGvPh0JVCArJqN/W4mM3qAi7pRLZ7Qod3v6URK015yXSNRVSgeMc
	 JPLanxYCxHMVix4GZaOsLAl0uQX2jNS4DtEIXrp66dL7u2+h7Ua9eFR64ER+lnFukXzZH
	 Hm7UH85gqzwfmi/v7PD83+usZkucWcYC0Id+H5h0LXrNgm8AoIifUbDMF96MkUfmZFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794758987;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oahg3z8Yulgx89mtnQTo+0ghpnRPO7o2421+bKN0088=;
	b=pk4LEz3BWlX5I/xc2Q3+gcMGeJ1tzFriS5gjp3FY2wPn4nHzG7od0y0I3ke2cPieibhn
	 3TTIU98XmIgUoV1RevdwrfTmP9PvtnhYlNmVnczkr6TgtOI8au6Mm2SdRH1QtSFXqHvYE
	 UzbTyS7a4pmUBwR4XnyAcXlfHNtmcTZeF+vMEB7xzJ0n8KgaCBSwMZKiGz5cLSCgPI263
	 iFbvXpEUmPnwpal62eb6E3KicFsKrI2GZZUgMI5Jq8qSuMNPmRaZk4gw23VPJpSQPYR/x
	 pjjW2pszn0hNszh5XWnHbADrTeJ2vsE0kH8nNyi2AXb+70wRMA/GY301xV1zZDzePSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nporhMUZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3D4606A31A
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nporhMUZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8FE1F000C4;
	Sun, 15 Nov 2026 16:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794758987;
	bh=oahg3z8Yulgx89mtnQTo+0ghpnRPO7o2421+bKN0088=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nporhMUZmbZYmtfbzuHBuIjhz1hO3kePE9gq/zbEkZN7s5jADL+HQYjfVT08RX3P6
	 CgaqqPt7oqbRAtkbtpIlgLdZgaCl7Namuet0k3R9c5wYU7UR2Nci7fNe+4j7UXGpQc
	 X2uKlTcmcSvMpRHr0uneFjfZIByOCEfMJDzPdRHPxkkFwSjkvYyDOmeQmMyXdR1kDf
	 Id7/IhjA5GhugIRWWHQZ9iJ6PQoPQ9qvPEhoExVorbZnr5sHRBnWtFKoytmIXOJGJQ
	 lgr9SgbQvrZFlxg4gf4GzgOIL+SWfHk7PN1vlEGtx5WU313KfXSTWv9FfjUwu0iaL2
	 11PCiXQTEYj6A==
Message-ID: <sashiko-outbox-215643@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] uprobes: avoid postponing return-probe SRCU lease
 expiration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Avi Weiss" <thnkslprpt@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261115155921.260878-1-thnkslprpt@gmail.com>
References: <20261115155921.260878-1-thnkslprpt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 16:09:46 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> prepare_uretprobe() reprograms the per-task return-instance timer on every
> successfully installed return probe. If a traced outer function remains
> active while nested traced calls arrive more frequently than the timeout,
> the shared timer keeps moving forward and the outer instance can hold its
> SRCU read-side lease indefinitely. This delays unrelated synchronous upro=
be
> unregister operations that must wait for the same SRCU grace period.
>=20
> Use timer_reduce() to preserve the earliest pending expiry. Pair a full
> memory barrier after publishing a return instance with one before the tim=
er
> callback traverses the list. A publisher that observes the earlier timer
> as pending must then be visible to that callback - otherwise the producer
> rearms the expired timer.
>=20
> In an x86-64 QEMU reproducer with nested traced calls every 10 ms, an
> unrelated tracefs event disable took 7,740 ms on the baseline and 70 ms
> with the change. A corrected monotonic-clock regression run measured
> 2,210 ms versus 79 ms, with 15 additional long-lived timer-boundary
> cases and process exit/exec checks passing. Narrow LKMM store-buffering
> litmus tests observed the lost-rearm outcome without both barriers and
> forbade it when both were present.
>=20
> Fixes: dd1a7567784e ("uprobes: SRCU-protect uretprobe lifetime (with time=
out)")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115155921.2608=
78-1-thnkslprpt@gmail.com?part=3D1

