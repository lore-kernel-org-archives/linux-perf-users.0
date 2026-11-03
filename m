Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793679554;
	b=CXV8ZDmq+uJeVgUuC+jRI9BxUXKHdGlyiLSqPSx0yyePkoLQD3NHJGjRU+Qe8MFAklly
	 JUaMzAqw6X0GPbJ3DZnqtTAvW4FalyBpW5STzBMnYXIibs1JfJJ1PAG1TIbbef2/KVvAU
	 FG+ffDChW3i4JMWOt0dY6ADrWQHPJyYNZjVX99LVlF6CFrawjgM+Ieb8lmc6DNs0zYdFl
	 z2fSoxXOPly8G2Ate7aX1mxsyauIJaIDCxR4cSYLkNnZdTiZqQrHH9e7hEcbPJwMw6TWm
	 Jkqs1h7hUai95KIBazp/0eVMyI4bOQxaT2yjnJWDvI7Sud5Kgg/e6skcFgEFk8dB5QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793679554;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QnUbTTposM2WNy9SId3srkOTCqqrJ/B6qIptlfL32vU=;
	b=CetqqRvBWuw9YjQ5v19twfXVIS9DcIVdtmwtEMt7nYxJehrkCKvR/k/fFhTBzFCbwYxN
	 W8WHNwYx3ArenwyBXh4E5HjLKso4Cwo6cyeVxpyVKQKvf7rXEAsKPly/6Gdl0ZUFnQx5z
	 zWdctd/c0lNPXuKlbS4GS471mOx3ujJzKkSIyoNB0Uuv1Zqg0z2vGzUJll4iUnmbZfAFx
	 RplK8FAXs5Od9Moacs6Ylkn1u5zBRWu3Jrb/rpVrpVyCMcp5sI0Hq8MLlrvb0sSOuYEdE
	 daN8p/zOORXybZcjyrMRbvLnWk7fhxQSER9nHE4jO3jg8LOh0yCfiZppdNuJxOUIPmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EpyQWCPu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5463B606A326
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 04:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EpyQWCPu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47901F000C1;
	Tue,  3 Nov 2026 04:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793679554;
	bh=QnUbTTposM2WNy9SId3srkOTCqqrJ/B6qIptlfL32vU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EpyQWCPum8Bit5s+Sv7iiwMWaiZYqejsQaD4iu8yZwu5feeuxNWxaWEoRYb83ut9s
	 NV1eWiGldGitNNjojsdyWPR5nwj/TVjYsnUkamCahxCnLbm9Ne7lqLE/vbQSRv6vf3
	 1urW+6JZpJ5aCKKXBGSMJWVv5xhorS0tI7EEYB+3xzQeGXH1D3W420DDNfeYyw79G1
	 ASHUrXi1llS5HJ0Km8KH1zy2sY3S8jHhDNqmwO5wB0TNfzARcPlMd5dVicspVadBhA
	 2Ph/sfrSLX+PHrcXQVegPkcxdpo59xTwc2HxhOm6d++tZQV6nBRRxFybFC5RxNpFcJ
	 yNEEH9MhwbYqw==
Message-ID: <sashiko-outbox-194562@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 1/3] dt-bindings: perf: Add Broadcom Raspberry Pi
 AXI PMU definition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103041416.2940213-2-irogers@google.com>
References: <20261103041416.2940213-1-irogers@google.com>
 <20261103041416.2940213-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 04:19:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add device tree bindings for the Broadcom Raspberry Pi AXI PMU block
> found on BCM2835, BCM2711, and BCM2712 SoCs.
>=20
> Depending on the SoC and security configuration, these PMUs support
> either direct MMIO access for the System monitor or routing via the
> Raspberry Pi firmware mailbox IPC for the VideoCore VPU monitor.
>=20
> Co-developed-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103041416.2940=
213-1-irogers@google.com?part=3D1

