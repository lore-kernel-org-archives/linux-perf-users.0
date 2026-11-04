Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793775219;
	b=i8I6GOAFcNktC7mVSymsevBSR8Llu1AAZrzUEoPhO3irJ5dy15QGTGME7R02eNNdUKsd
	 /z42D6N5NCiDAp/y04LyGLdnXc0ZHq2dCIZb0oQVDaGfh6BPbT0QtelSoiV6aB0wkrQVx
	 wo0+WMQTB+vPxaRAhFXjT9LB6MK5bcbDzidvwXHXJS8sAZN1xmQ1Qou2uYhgRFeYFFZHK
	 CczEza5SgZ0OcGndW6iLYCv/rTpREE6Qr4L9H06kIe61Mo4dVc/qYJhcU3tqARwpHSgjl
	 iXuP5hBxrRR3cLJ/xtYuabcltJ7cmHqco6sC7mx+HMZwVH0ctUOaoF8lfgzU8IEMPwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793775219;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=laVxCKP+i+DvGy5rrZ6MAOPj0c9RMSJwwemj9GOG9j4=;
	b=Ng3+VslePdXsv12QQkgr/A+INZ7wg4CZIGgVBpz18icbXtyu9zb22kwXeDr3TvHeo5mI
	 Odg6Wob3q3M4CY9UmrauNgPbhC0Oh3yMFOWlkbOHRayfMP082+klLl2wiyVDf1IiJPWxS
	 PFL3GjjKgwX+0wSqSZRDyHnm3/zTBoDP2DkczulP77gApwrHVp8TktsV/37b/XxrDy6/c
	 0kjD90UiQxN4JS6mT1AJ+JcQonLTNn/LTYI0SEzOQEJ8zIYyFfpbuv4OSRp4CEZVx3dqZ
	 RW6njtH3FbLuW9mSiips9apE437hq39j/mgyl8WjBAild+WqZlOSjTBzMDXVODRwcTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I+t1vr1c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1A7606A326
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 06:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I+t1vr1c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3309C1F000C1;
	Wed,  4 Nov 2026 06:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793775218;
	bh=laVxCKP+i+DvGy5rrZ6MAOPj0c9RMSJwwemj9GOG9j4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=I+t1vr1cHtkX2PqkIT1mkLm7UXzQvzIXXXOzAZ8mZ8Z0Rd9lYMRDaAXJHhiE9wu/0
	 NErBrJ1uR6ttqqkAiCUM0gN16DwAzz44x88/kNwEJAfVLtxo1Ls2UQDcsKJK8Ez/96
	 l2hcuLpNxB0FnQCZ/HNYV3rYOr5VFpxziHB/E8Mapx/iJ8vq1VOtqNzcF09b4iNAKX
	 YVIwzD20Q94xu8ECMRJibpSiTmtUkOSR0sqnVYTlHu4AFyRrZ7jEio8kiAxLCfqQug
	 9mitoytg5C60pxOSQhWd2SRll26I1J7t0A1F25wXqSwdoJWnPFonc05h3oj54RY3KK
	 fpOyw+dVc35Pw==
Message-ID: <sashiko-outbox-196771@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 35/41] perf pmu: Probe interrupt registers that
 require precise sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-36-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-36-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 06:53:37 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Some interrupt registers can only be sampled with precise sampling, for
> example on x86 the XMM registers are captured in PEBS records and
> x86_pmu_hw_config() rejects them in sample_regs_intr without precise_ip.
> The interrupt register probe tried precise sampling as a fallback, or
> for the legacy extended registers unconditionally, so the probed mask
> didn't show which registers require it.
>=20
> Add probe_regs_open() that opens without precise sampling first and
> records when only the precise open succeeds, and record the interrupt
> registers and SIMD register classes that require precise sampling in
> intr_regs_precise_mask, intr_simd_precise_mask and
> intr_pred_precise_mask.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D35

