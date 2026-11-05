Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885428;
	b=Jn6u2tmat9XAOBdHwc/QrMWVPTvWtKMCjPnpLoXoX4182Ty4h32AI7Nk+D3j/dWvmVdl
	 DvwvqzVlOdfJcMIAVVYdw6EhnvL8FLihE+RLKOtgMPf6lnnInxTCbBfgpYnYBTFOV7gIA
	 JWODZ8rJtynknJat3dKnalo0VAsQh9qi/n+bh6vk3v71JOjav6qHhZZ0P48xHGRnHirY1
	 MZO1aYB/y5x3YDMOu8UdocjO4i249QsaqyDncP9TKo3PJ8JFLYI/bHEJ5v+TIsmXEpGT6
	 v8fM9eLNzCAXKJDVRd/ewl6AgszbKmM60N4OW0CiU/yRDm7wuJU0J/D1VJ4JZXTh7Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885428;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=B8pjo/fb166Y5I8jBn3VbJ48EuZkAk9N4GoB6EdtkdM=;
	b=HQPJXb5T7Odh4QBzJXxjPL1e2wj1ONrSHU2zCu1ZGMwN69naIk3Du2o1Rwxg17FEm+BL
	 iG7dAYlUPxAqBb8v7e1RKskTIq4zuuSGJdCgo1V3QmktqjOZWhLmmfnB69n5wPYy4GHzY
	 tZkX/W3L+/WN1kpelGrE8ozWNIwTgPcKb8Q+/YZRV1aFiWyScFRLDV3e/zUOmqctwSbaB
	 9vkLTKEAvWl745gGBzz8wEzDa/nbRwKY3kfL3J7hjvDG8WlXk8X6oIh/1KT9dIPZIKy0r
	 ZrA7XY+gHs3GE9ekEVA3Pbhv/JZhLg2TwO9PVyNPjtBy6iAVVA17kOfQtuONm+AIGDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n1C5ip9Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0FC606D836
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n1C5ip9Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E347C1F000C1;
	Thu,  5 Nov 2026 13:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793885428;
	bh=B8pjo/fb166Y5I8jBn3VbJ48EuZkAk9N4GoB6EdtkdM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n1C5ip9YoWQOH7iYWfmai0Ia62coH3dHILsa3c16RyFryYr1TbROA7AMLKXG1t8VT
	 tyYVrA3CHxBdh8ue9O7SsvwM6sQl9VoxZJuQDZETmlAYYOp4DQmWuD9BJW7Wh4XAIJ
	 CZqP0KqRKyryKRUxLgfGU2QncykhRnYmbM3rM+WSlY1Wjk6wyRfRGGx/ZJCHEfBU63
	 2CO8sS0TNZjyhYtCMgce9MFv02aI5BLMcEIcP1itOmuiWHp8lzpyJlLk3hqb8ul/mU
	 f94oRkyZQLf2SzeANy+JZNdD+j3hBFeTfk7gMTnlQKDklwNfPnV98Am3841PGZJyFt
	 3jUkLZZkUgM2g==
Message-ID: <sashiko-outbox-199153@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/19] perf auxtrace: cs-etm: Capture wrapped
 snapshots
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-15-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
 <20261105-james-cs-unformatted-per-thread-fix-v4-15-7759e0ce2449@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 13:30:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> find_snapshot() isn't implemented for Coresight, so when a wrap occurs
> we only save from offset 0 to current head, modulo buffer size, rather
> than capturing the whole buffer. Coresight drivers currently use a
> monotonic head pointer even in snapshot mode, which gives a lot more
> information for taking snapshots than a wrapped pointer. It means we
> don't need to search for data at the end of the buffer to guess if a
> wrap has occurred, and we can go back to saving partial buffers after a
> wrap by checking if the next size to take is less than the buffer
> size.
>=20
> The drivers will always be able to generate a monotonic head because
> TRBE has a bytes written counter, so even if we stop generating an AUX
> record on every overflow, we can check if the counter indicated an
> overwrite and offset head by a whole buffer size if it wrapped. This
> forces userspace to read the whole buffer rather than between last and
> [ ... ]
> buffer's worth of new data.
>=20
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-james-cs-u=
nformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org?part=3D15

