Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887329;
	b=oG/7VN5J+9BnPSXERSEh3DIai3qf8QxpoJHVFX6+B+0E2eSEQJnk9S/5oDz3894Nua5Z
	 rNBNd5SQDpABjzrb7oQYj+g52+8YnQePGSCHBU5ib/Kkf4DoidU2+odVwbV50CmtjayNP
	 X5q+dbd1sCIdrdxfplAjO4J9oxCGrRPTXnamzCeWcdSxUay6Au55NX3vgGVc6iraYi4iX
	 BQfjBEMHQiDZRIpRdeRWnE6KPAoNnVUyw8mi5QDpuR+B53RIWEYv374+Gu5vYQm/CqfNq
	 oDj4X501PFx/CJV7oeB6pYG68E5T5Xz80lgx5ln9kwhE30scjV60w2H9H4fYa/NzfjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887329;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TX8/Xra1McSY9hX0hOTxtTgwLlbRtKVtMNJUa1cvE9w=;
	b=wJFzrckEqY8b3D4QE8onlqrFh5YE/mdSmja2zBGuozWUMOnMUD/GPjlNfW3B/4aWg0FX
	 Cqqyd7BwOI/2oMN8y6YzLJAr3yhCoR7FJLkuqhmpQxLeINR0vmIjQUjxfTBWM318/a2JR
	 Xmjt1WI6bKRfiH8Yw1DAIdsC1dCluPxD3lB4KR0EoU49VVCF2DAj5D9Cl5pklQMhX9W2C
	 yzSApX1DuzKlFoB64xeIw0IEIqzTg+JwbLq+ZunIS298wQkjh+ahHJw4HylgV1GKKcd6c
	 oud6SyXIGie7BcC+5Uu5plXKr9ryiO2WA6M/aZJczAIUdGCQuZwLmgRLXpKnBgOvdpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2ttl40O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFA0606A31B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2ttl40O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B851F000C1;
	Thu,  5 Nov 2026 14:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793887328;
	bh=TX8/Xra1McSY9hX0hOTxtTgwLlbRtKVtMNJUa1cvE9w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j2ttl40ORoHOeQevp/y7vUFTf4mHdjDer8ICUlqgNZo6urL4BMKoL7GIcJAVaM3K7
	 2eg9L5YVsRzIFwnhWgZWPxN3YX+t3C23DU/zltJx06aZhs5Gxj3qlzByeV7/BEv1xg
	 HVfufNyI54R5fjt/swVYw8Fhf/gX9oPI+LyEZVtRTFjxWph3pJhfqAQ57OfrKw1I+4
	 FBFP+fAqE8CgYHwL1Gkfcw4CmL7Uuuu1gxkRK6Vv9Lw9+/lsORo8c4Cf5RKTa99sV4
	 C2VWyOX5E1X/tH9QTSCX0Fx7goAzWBY+DLJ2Dx1OJDAmF2WgEHEGOhknHiHjQTXrSx
	 s3d91NFhXzcvg==
Message-ID: <sashiko-outbox-199186@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 19/19] perf test: cs-etm: Increase snapshot size
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-19-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
 <20261105-james-cs-unformatted-per-thread-fix-v4-19-7759e0ce2449@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 14:02:07 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> AUX maps require at least two pages, so for machines with 64K pages,
> 128K is the minimum.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-james-cs-u=
nformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org?part=3D19

