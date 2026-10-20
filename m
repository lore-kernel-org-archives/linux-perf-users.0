Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517022;
	b=BDjdlsRWza6/O1V4Rjg1K5oy84H9RwhFdesJcnfpW7kT3g5836gZ8akw28SSG4bMiyXF
	 JUsOulnbwlyptYeAb+JunEEERjxPG7WBQVf5LmN85+3P0eGOcTfVAbuKulFmzU3RqN2Af
	 BMNs1UCqaGqxG1otHQOF37VSihGP1rg/gidwZjwdFzwKoItG+8tGf7zIOo98XNUSaStow
	 f7GoM9OGnvrjWqrZpctMtgGksrkyaAFpxgwGxafTjQ+cyqQO7x/lbWml1YZyjHt2+roki
	 JgeuUNUTysrgeGxXQnatETyE79lxfrUdXXXyA9okTus2Z6oRWkNARd0iK4rhyscYbfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517022;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RBMhY5nyhkGZknOFaUgwKWJ5w5jVy7GkGEQt7IxNunY=;
	b=0pDBSwGtrpaYsUz0oiG4AHlzpS12zmTmB7Tm+usNyYa6Wt9Hiwc4bdAGhosS1uCt2Jdh
	 +/g0odE9TyI0AH81UStAyptY0YgSKH6M2GA09XUniL6VJQclMEoee9BpGRLiRUXush4ok
	 tRbwQL012TGTOtTuTxn2Go6KAKiNsW+SJUq807ufuNJUVkdU+d9cJb86v7Wu+Iz2KMNgd
	 T3C9uaiIvIY/Zss/hXB8Wfzp7Wjs9tsbXJCFwBNRWYUMPFhADXcLnGXFR2Zpf1FheNCAF
	 JVCzpxFl1MaVi0s/6wHwia/BCOoYnZFtPrpq7tQtjBtm5Vaw8PEd8l8LMF5H0kUX5IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TGZiOYij;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D961606A31D
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TGZiOYij
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA6E1F000C9;
	Tue, 20 Oct 2026 17:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792517021;
	bh=RBMhY5nyhkGZknOFaUgwKWJ5w5jVy7GkGEQt7IxNunY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=TGZiOYijKI8LyWZsto1u41DSOU6pAOrmSM6+Xf/m3gaB99pGZj0RAdAzYMsPoUeTz
	 hVmbR1CsLjfPU6cxelfsWHuAYEYDMsbjt15I15WHh1TQ2DlVnPxAWUzEU6Fer8jY1u
	 BqyOr7z4ov+p7T8KIVh1Yso8I4fwQUIyGukE2wX3Jc6cN0HI/qA841ec9QWuiqLmEO
	 bLOJni8/tVjO/hQoI0R+WPPkqlAGJzJdMEyJDbx3wF3OPPgOML6EshxaMDWZPbcKvr
	 WItWegUL3hojCl6VlqNGIoRR4NfEoPP2SuX0pO3PCrWX2L5uYCALfa1+Yj0AxHiBha
	 Zs4WwxNG3dr8A==
Message-ID: <sashiko-outbox-179413@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf mmap: Use the head selected by read_init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Moses" <p@1g4.org>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261020171946.3593127-2-p@1g4.org>
References: <20261020171946.3593127-1-p@1g4.org>
 <20261020171946.3593127-2-p@1g4.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 17:23:38 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf_mmap__push() reads the producer head before calling
> perf_mmap__read_init(), which reads it again to select the range to copy.
>=20
> If the producer advances between those reads, push() copies through the
> newer head but stores the earlier head in prev. The next drain starts at
> that earlier position and can write the same records to perf.data again.
>=20
> Use the head selected by read_init(): end for forward buffers and start
> for overwrite buffers. Save it before the copy loop advances start so
> prev matches the range that was copied.
>=20
> Fixes: 8872481bd048 ("perf mmap: Introduce perf_mmap__read_init()")
> Signed-off-by: Paul Moses <p@1g4.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020171946.3593=
127-1-p@1g4.org?part=3D1

