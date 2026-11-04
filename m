Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819653;
	b=S3MrESyZ0NBpoz4QwA8fmDqhMExq+c9akpsgoHXB2Nmo8dMkcsBs3wNGD8S49MjCPLIB
	 pKyqBXk6HfbIQuKYAzv4pCNWumoSRa04SbAqsU0TI0p8gquM1KIGIzqEPKC1W9PGKNgtr
	 kBdDe22/DNLkYESEsxxl5ZNsK2lGDYZFfRddVDWa9YfcmPP+V9+nzFuFGRTbYlSwDL5GF
	 xZ9CT+YX8T6ye/Vk0G2edBJIFD8UkDj+8qcDam72o8ngyNeGxaA4NahDGjJNln2Ko+GAs
	 Rt10u9sf3mFEnDxV9WS65uLnrlQp5aQoz3q/mux3u9/ugVKNDTo6Nz0VMFOOojQJWaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819653;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YDqJM9B3btXnxAgN52+MsZiWegZbM1eDrdY49HzQlbU=;
	b=AlVp81zjhBSBBrCNkU8qMu1wZcTzRonZFdGiMGTCNgP+BIJMaBawQ2iYsMoBGK3+d2Ap
	 EBFacDdW/L4BHNKr3d1aSE6LrtnWyz7vnhXccUUlQSqZXK6khAiVAOkCY+qNyWdp6DUnd
	 HANQOZAE9ymvpK9mOFeJbieDyg7kojDeiSyTXe7VXRBnBopUFUBS38h4U5NtcyS2gCmPN
	 xnLqqk8WCH8kbPDuyV/tXvRZ5NKbDeBPsFFr3LkkEaVFK02v9MAnav1wh8RL/vEYSUn3v
	 uifI54s4noAem9iiViyDFdQKViXxSlGJ0pisTYErSLDOqgC0EyHC+QWU+QPHPIsZNFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ScLsE+Vy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC86606A326
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ScLsE+Vy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9127D1F000C1;
	Wed,  4 Nov 2026 19:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793819652;
	bh=YDqJM9B3btXnxAgN52+MsZiWegZbM1eDrdY49HzQlbU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ScLsE+VypjwH83LH1pdD5z51S4oCXxL9GWjjSp7qUQiPUee+pLW1ystJOQor8iXMp
	 wrC+8XD3Ub5KqRtjselfTO8M5M33o7PSA9hq9nyyffvxEl02aZlCVj75cvzNfXRgzR
	 JM76FPgHD46Z6m2frpZu3yqM+zqAacCnZqYu2eRROROJjSiBWzJ8tSQ4x3yOMr6Md4
	 8547YmRoiXdgU9M3xMiUuRZyq6k7TPhbeIyEHy5qqx4HBLGmPQ5ckBCd6Ri7vR9GZp
	 awYxrdALRteyuQw6ddf47uq475vx42fdHqvauvyA9B/OKbsSAW3pxdxpNcvmZiH9+n
	 I+J+i5IZCfgOg==
Message-ID: <sashiko-outbox-197929@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] perf alpha: Add perf mem support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104-perf-alpha-profileme-v4-3-1771ea02950e@gmail.com>
References: <20261104-perf-alpha-profileme-v4-0-1771ea02950e@gmail.com>
 <20261104-perf-alpha-profileme-v4-3-1771ea02950e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 19:14:12 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The Alpha kernel series "alpha/perf: add ProfileMe sampling" reports the
> data source of ProfileMe samples of loads and stores: whether they hit or
> missed the DTB, and whether they were loads, stores or prefetches.
>=20
> Give the Alpha core PMU a mem-ldst event, cpu/cycles,profileme/, as AMD
> does with IBS Op. cycles:p is not used, as precise events sample only
> retired instructions, and a load or store that misses the DTB is aborted
> and refetched. The profileme format bit only exists on the EV67 and
> later, which have ProfileMe.
>=20
> Suggested-by: Ian Rogers <irogers@google.com>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-perf-alpha=
-profileme-v4-0-1771ea02950e@gmail.com?part=3D3

