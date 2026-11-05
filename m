Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883947;
	b=mH5uTWHWXGNJsJ6lasI2CRkN9b93uYC+y/k5tD3snfs/7BGW+1wWkC11jbIGFf9A+xhb
	 oEOR4l3pAdZ+GS52XDRvPyFl0FP8XX87SjZU+1bf9ElJ836vT2FqkVk3HO9SJYFgCasee
	 XfzKdzzlu8G568Isiajvs7aEzBScVwZjSP15JD8dkqe/DPMdDcL2J+bylGGyiAIY9xkqe
	 aA8BaXVpky2X/lLGFSMEWzVAI6haPxYiLqEbvXg7+Aap3e0Ud9+Jd5++MS9B77Z8izQP8
	 cTGZvrRv7hY9vNLEGS3W8RGrnZpbAcYckuK/TX2HQJxjBKkcNIEHPJq6djUV6BSaIew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883947;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZZxxgu6XtYTD1dM/WnLwEkYKlr0hjH/NB5hL1sw/iaE=;
	b=VkUf5PDsIlbw8EpptZoiIkNCoUv52+x1M+8XlqA2IKQOJGJ+6HjX1UdT3wYDhRYUMCfj
	 nmGBTG0iT6ei3rNZeMCwcLvhu+s2SAhLs8hbWML9zGG8ysGEuDjae9x9jHY0oxL2onayk
	 wlniEW8n00+JEVkfzd/8V4LL87EdG2OZ8UH7neR2Kz+9GjzrU4BSY5ST/j2JCkkUEd4XJ
	 DZwDZEvDw99zoHXO6wb3OYScBTS7R4BLmslgJLBPI1C4t1vSBBdwSXGnTAAVxys7jEU7m
	 EKDHj/JL1B7GLisr/D20lf0FZNbC9bSFPFrD8zmzglh96d4yaPBVKqEh6kyKqTkIepg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h7n8k1w7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3461606A32D
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 13:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h7n8k1w7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A791F00919;
	Thu,  5 Nov 2026 13:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793883946;
	bh=ZZxxgu6XtYTD1dM/WnLwEkYKlr0hjH/NB5hL1sw/iaE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h7n8k1w7wC5U4/SpOpsiAqLoRW6qg9UspwBpEkM/5POW0QVBmlQt4CnMJscT66tab
	 +694huL5YbNU5f2ClAppaa1ISsP6WSXdTrRhwlAjF+aYWi9sFL7HSGwRxnstbn/Gfv
	 Hu3X2V9hOQV4YmSgOctmJuO+zQhQEWX/nvz9nEzaK9t8g2f2OCOra2fGSOiROEz+JM
	 kDyXmTrv4Xz3T3WaDkvTxsuPscy0Gb0dgrny+iALop/g1TLzEClDVtEC59P7YFCU7G
	 cKGAi8kDtnwuDS+XPcHtrf22ekCs4w3+o27/29AJk1xlSZBflUNGR5BcEEoIn2TEN/
	 m0rJPSgLJadbQ==
Message-ID: <sashiko-outbox-199115@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/19] perf auxtrace: Turn Intel BTS snapshot search
 into a generic one
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-10-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
 <20261105-james-cs-unformatted-per-thread-fix-v4-10-7759e0ce2449@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 13:05:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Currently each auxtrace user has to implement both the snapshot search
> and the logic to fixup the 'head' and 'old' values after finding a wrap.
> IntelPT and BTS have the same fixup logic but different wrap searches.
> BTS and Arm SPE have the same search but SPE modifies head differently
> (although it probably shouldn=E2=80=99t), and Arm Coresight doesn't have a
> search at all, but later it will want the same search and fixup logic.
>=20
> Add auxtrace_record__default_find_snapshot() as a generic
> find_snapshot() implementation that tracers can use without
> reimplementing it. It's based on intel_bts_find_snapshot() and the
> search includes the caching from it. Split the pointer fixup into
> auxtrace_record__snapshot_fixup() so that tracers with their own search,
> like Intel PT, can still share it.
>=20
> No functional changes intended apart from changing the pr_debug3()s
> to print hex to match __auxtrace_mmap__read() and no longer leaking
> snapshot_refs when expanding the array length.
>=20
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-james-cs-u=
nformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org?part=3D10

