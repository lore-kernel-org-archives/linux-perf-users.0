Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793383112;
	b=RcLkLqjg88FDl7t0Gomc4a4S32U1aTvFOZ6wxZxYnfBFH0eEi+P0sBisZehZ3zHJYupv
	 3nxGS9Wlwz/EuqQUlCmN0JMIq4aVc1/DaOWnT4HW2SFpo1j6BepcIiJML0dNEK9+qYtYr
	 wGbsyopLID0/jdwMEOoEHW+1g7Ftl/gltmDk/MLGGqVBjcz/zO0AO+ipl/O4IuvzkV5bx
	 vB0xH/uxgSoXf/54wMEj9sV50H4KKuxtTPeg++bRgRIDDwNZct8RWQrPURYdy/fTfFnkR
	 sgl9Kj64o5bz6/qoOAsqJFoUFFvAr3OmZl55Z6BZxUH0msqu5BPGqH9ZxLeyISILX1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383112;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ogbqRV8i9gJApr2pWMpuq+ck4+iVyjunc89yNnvkdmc=;
	b=f5wicUer300/oW869sIMDu5v/T+DRuPxYcCACFmn0/jTmKbSre3LbM87eFui81vwnFTP
	 ZL8YrsOfjVcfqSQsdVRRbr6uXaZfyw1/wZFihMxrJnlo/PbZk+vYilc8DBWBj7UL5MgLR
	 2DZlBRZ2WBH5AMI80ehGm0uXbGQ2c+q+3HDNCilBUvMxrjkFlNenZHVovRPPa6P6i56Nm
	 J7pd1/HLYuIEmVhY5SPsAWjKTRCMuOiXRkpJpQcJJWKefLmAE418q/NotTh7On3Q1+5wD
	 ycwDOmQaORuCpNqW29o1eAQmVod0kK9nzrF60Skd6mOp4Ldmu4IBIUfwyKB9l4MjBQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i9piHoFv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307A4606A32C
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 17:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i9piHoFv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E690F1F0093A;
	Fri, 30 Oct 2026 17:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793383111;
	bh=ogbqRV8i9gJApr2pWMpuq+ck4+iVyjunc89yNnvkdmc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i9piHoFvMlIgCS7KXoT5iCBNp3vtHjZINz3+goS3Z6AGTGWY/LanLonCfOnNsLLN/
	 QrMAwlBVzL2AS0xJd6yqE0XL1GcwctCRCF/ae6OcNZ143GGC3gx5GI1iuPBFfZFU1U
	 ZwqnKQkKU5DmKrB252H3Kw6FTk3/+RcX6u/Y4seWS5VYxjDX1KWKxJdm2WHG0kumgP
	 3L+yLpAKseYyOe1/0T7wzD36R/w9hj2DAyfjMJxgXUavI8tWso8I1pmjl3dUyk88LN
	 7OO+kNSoJsXzrm8YMRsQkoCwJJvmmJ069N3hLexjUD6wrUhwhYoXoUBhAqDdstGkdm
	 r3rgaXVq3V+Sg==
Message-ID: <sashiko-outbox-191381@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/9] perf stat: Check merged PMU instance's cpumasks
 when skipping zero counts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Besar Wicaksono" <bwicaksono@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030174816.1544471-7-bwicaksono@nvidia.com>
References: <20261030174816.1544471-1-bwicaksono@nvidia.com>
 <20261030174816.1544471-7-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 17:58:30 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030174816.1544=
471-1-bwicaksono@nvidia.com?part=3D6

