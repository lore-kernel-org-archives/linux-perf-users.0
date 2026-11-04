Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810585;
	b=WE33z3QhhC4JD3EJf25rmUkbBOtUrtUf9Ff4cBvk8qmXa9Bhr+7wbVJTbUmC3uH5vG5T
	 HQJnbDDU80C6MN4SV0QU+vKgNVJ/TRjue/LJ1CsTjOAmt7UDUTxQEMnEhkJNwsL0QhItc
	 xbo3wAcSqLZm0oRtLlzRthxyG2KgFwb95mEN+XWj1tmMrbXrlZZf2ZiyXYFovdgZdgu1z
	 AKsxk2CudHSsVX8HhRIjXAKv32r4gu+addDaikMW4uC9HAqoOeWQVNu8OFxA08iNmTtmx
	 nOzF0wDWZ0Z2VqMDOGfPrIAg71Ne2YAT7AnNyqG5hIxFo7bG7uDsMzCViYMqMncEaAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810585;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K7kxE1S8USSKlqln/nGZGshzvgm1BG5dn8LbBvjd/N8=;
	b=QkDKBLXIAmnYb7pTsC3ldufZgg3HXW3rPcKuwMqA2RK7NRbbooXYpVQkDCU0m9DhWhfu
	 X4kKDb+CYWYagR4wrI6g5hcIBXyuryzDQ6Nvs/P3hjq776PF72HfONF9eWj2qngnDr0rD
	 1ZvI13spjbq6f+daRyAlQCua0KkfRXTt49wRMQM1hwIQ5R0pwddZ7rqWbMd4GMoDu+5dj
	 o3FXcPHvMTswF5s9O23G9mBnETq0kERf9jkFfhtHqj7AyxuHRvs5SRvSaRLhcEW1HQC/Q
	 GkpLhuQ6TCwIjw6hCQbAQXiVIzvPE1fsutCEkqSlDY2kOtGgAs8rQNgP8UT8dWazDtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BjL9+Hce;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46200606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BjL9+Hce
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A761F000C1;
	Wed,  4 Nov 2026 16:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793810584;
	bh=K7kxE1S8USSKlqln/nGZGshzvgm1BG5dn8LbBvjd/N8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BjL9+HceUZKbYcXWp8s2ARqUQshSTws35/Fzjt32hFMt/iXi1XQRmBGImR4In823w
	 0Ce0FL1rzzdc1GicDveiOO9Ssf2b4bDcAh/5Gz3B1Dw6pwLfUYM16YY7fNW3JB6tbb
	 Io3JV98FSiornJLCUNllJuTtHIzkrVMJesibLzK5M2OqZfAVspBClKIClAeQmZhSV5
	 R+u8Igb52A51Kl87yGrmY8nwUPJy8ZVPvlsfNl37REiSvSKeQxkwQUutB6pqhAKdzQ
	 we1IfX9y0hyW0D5ev+nGGaTyZYuiT4cPKf/JedUvws/X2tFzsLUXFharrgYL6dSFjd
	 uxSGI4FHS4SEQ==
Message-ID: <sashiko-outbox-197652@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/7] perf stat: Check merged PMU instance's cpumasks
 when skipping zero counts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Besar Wicaksono" <bwicaksono@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104160716.2910873-7-bwicaksono@nvidia.com>
References: <20261104160716.2910873-1-bwicaksono@nvidia.com>
 <20261104160716.2910873-7-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:43:04 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Commit dd15480a3d67 ("perf stat: Hide invalid uncore event output for
> aggr mode") hides a 0 count of an uncore event in an aggregation id
> that the event is not counted in, using the event's cpumask. When an
> uncore event has more than one PMU instance, the evsels of the other
> instances are merged into the evsel of the first one, and only the
> cpumask of the first instance is checked. A 0 count in an aggregation
> id covered only by another instance is then hidden, while a non-zero
> count in the same id is printed.
>=20
> For example, on a dual-socket NVIDIA Tegra410 with one UCF PMU per
> socket (nvidia_ucf_pmu_0 on CPU 0, nvidia_ucf_pmu_1 on CPU 88):
>=20
> Before:
>   $ perf stat -a --per-socket -e UCF_SLC_ACCESS_ATOMIC,UCF_SLC_ACCESS_RD =
-- sleep 1
>   S268435456    1                  0      UCF_SLC_ACCESS_ATOMIC
> [ ... ]
> count in, such as the other cores in --per-core mode. Core PMUs and
> --no-aggr output are unchanged.
>=20
> Fixes: dd15480a3d67 ("perf stat: Hide invalid uncore event output for agg=
r mode")
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104160716.2910=
873-1-bwicaksono@nvidia.com?part=3D6

