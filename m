Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020286;
	b=c8brlwFcaDMf+Hv0Ls/V1mliCq2XpdZ0MOjibqsRNVM/3a1/t8dAR2e99+vM7x86RJMh
	 i7xCyj04Ql2b/AcPq9sl0Fj3aZMXyMKlJMpvsUcLKUyPNyq2Ax/6jzwiRFylFt/Ah8cNd
	 hMNkjTfdKGOt/pvuWSfJv+A/dkux3pADsg5NtxXg6Ns5pkhaAZ1G6OXy0Rt3UWUIadUoT
	 2l3ASQ7pOc01z+eVboMJWyEbNO5BGudCOk1FxeG3aYKdwSgCpJ8MvBmB2X1xXKuwkwIbu
	 Nq/l78j4FkIhG0trBYJV5JjSbv9SnFQzRr9hOZVylzXp+nMghDW0AWOT6r6w8ITmlAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020286;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bJ+FzQc3jFqVgj4pJGURqkKaZ3w03hhi8ASFSTZCNb0=;
	b=OV7KM2hewHmQApTI+8WtZcFSqXq00sEwYSPR2UHtaRrd+4xqvqocII2E0qqaT6Jesx0O
	 kZUP0XvWPCH+lwDTxeF9kkJqvoRkVveSQoOAEcmZAMcZKySiK2kbBgLRtmnrmHE81DeNP
	 vjQcATyYXJtCAjU99LbP0VgLWxoYDifRgs/I/5RxZ3COBV5JF8CHrbUNnpZ/SReeDFfxL
	 3s1MTb0RJIWl893Q3/VlBm3pQVuyM30mACXqpFSKjrelrP5KdYagVTPnHuJmPtXlcz52r
	 9vN96+2mXf0e36PM+DKxuho8RbS0QWkagNvZp/N22A5fFi8bRkt6+u3RxW/8YGe+a1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KPDTlPkm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA86606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KPDTlPkm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5611F000C5;
	Wed, 18 Nov 2026 16:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020286;
	bh=bJ+FzQc3jFqVgj4pJGURqkKaZ3w03hhi8ASFSTZCNb0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KPDTlPkmjkFfFZ8bc2BuuzkR+prp3Bc/5PwKAiAH50SZ2Lk74QNZpy6ndcLQh3W77
	 ie8RhpK+17Fxtf7DjzhM9xmW204RJlCwpAzA4KGboflIfLbJG+LV+GJGSdsfYNJtzT
	 36tTFhJ7WJEPaaaH2CaiTw+g/eNnnAb1+Dd8v3n2K/3eU+Oe4I89dm6ThKlTTQ8fD1
	 4eDSba8gyppNMWy4XNXKX1+7VojlccjLAMiViJnc5XXWYUbTAcAelMh7s+qWaM7TAk
	 meZd4R09iPlGY+ew5SfV5ThdGe0BJJQmrXpyZBtqz82zwIhdVCM8LDRaGemBov0FYk
	 urrmyJuYyK0uA==
Message-ID: <sashiko-outbox-221542@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 25/34] perf cs-etm: Consume each OpenCSD packet
 immediately
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-25-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-25-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:44:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Decode and consume one packet during each heap iteration. Return the
> context directly from the backend so that the packet can be processed.
> If the packet was a timestamp, then there is no action other than
> inserting that queue back into the heap at the new time.
>=20
> Drain the decoder on the last trace byte of each buffer because it gets
> reset across each buffer and that would drop the last bit of unprocessed
> trace.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D25

