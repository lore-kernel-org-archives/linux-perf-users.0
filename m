Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793343600;
	b=nwBq1KaIxYsV+IDbMlYuvi5Tb7rotxffAVkBFyyv9qm9lraE9shfHwr+LQ8//g+Nvb7y
	 9rq3+lGrsuL0n0t1Ojo4BO/qPIZWwBbQ9cqkXrAZZNAepCpYXY7e0ae0msDA5/8LvVZ+2
	 U7BHB2pk6L5586yhPC8H0TJ+g7JvTj+sdvsl/6YC6n7vyuWUETyZi3tkOO/VvIEoW+nHx
	 uZGDk6wL48zHUMWbYY4jOFH3KFijXMW/njyhUY+dBiL7glwHxjbGwcQ8ryuVgQSDDLwIO
	 J2xoOD/8/jYBL4+laIRVmClvohGL15u3iIt62K6fYEIiK5KP4jLpGhqQoDpQzuMZ7OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793343600;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BTK/DNRK4YxedMydCekcYhCHthtEeouRog92RNpoM4c=;
	b=oc1Pj5TzKQxKgP+AHwb8zUi0OyCZ/Bfztksn9978H9ZPJOf3suKe5KwYpJRNryUNcLSa
	 77q6ZIhJ1HJnj8v1h9Qyzn0QErHBfGLon6BrMoHJxenGDZRBQvSrp8P6UbEJ6h3pV/bZD
	 QxLXtTwtXAQnECPI1OSw++Ppfhuw+hejbd+EDrAP0gt913Rd8YT7mUp1bv6uKdhjTA4bV
	 2Z3W7ttJB+tp9ghgjS4sKig+CNVUEdAO9+s1ef1B8oiOiwrAG2eM/SIY7Kj1rl5KLdkxQ
	 bTjl+aHAxqO6q1Uy+0J44g+M2dR4H/AUN1gO+T29b6MxihlHvquOH/EUUENnfaEY7CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bPEgHgdJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70C4606A31D
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 06:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bPEgHgdJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B21E1F000C1;
	Fri, 30 Oct 2026 06:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793343599;
	bh=BTK/DNRK4YxedMydCekcYhCHthtEeouRog92RNpoM4c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bPEgHgdJfJn+Q90hyRiNNETMknpk9NziHKnI7rCWFIifRZSvRDX+diH+MJdjVTnn+
	 hDt8/XU94fC8fQm7WdkXVGPU1ZXnG0ER2g9HSruRbiZFK6rL46woVJnskgytxCKj3p
	 X5etyJUsbJSipGz6/Z72eHVvjjSV+MX1gbihiX9pw+8OTRImd/+fH0w0wiGbDcg/n5
	 ouKW9v9Bene0jqAs/K01EjAadFAU9TVqA4tTl/TlJg1UCx3KqessgtchWhnJzFLyh4
	 lulnw+8/XC3xPd7o9DcOgAKIc66cSyMsd3OYzJBdLwVmTUy3W6vjLzpMQVSx5gSBe9
	 HecoVRm/9GRKw==
Message-ID: <sashiko-outbox-190624@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf record: reject CPU indices equal to the mask size
Reply-To: sashiko-reviews@lists.linux.dev
To: Paul <p@1g4.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030064825.2156317-1-p@1g4.org>
References: <20261030064825.2156317-1-p@1g4.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 06:59:58 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Paul Moses <p@1g4.org>
>=20
> record__mmap_cpu_mask_init() rejects CPU indices greater than nbits but
> accepts nbits itself. Valid indices end at nbits - 1. When nbits is a
> multiple of BITS_PER_LONG, __set_bit() accesses the word immediately past
> the bitmap allocation.
>=20
> User specified recording thread masks reach this write before they are
> intersected with the selected CPU mask. For example, an affinity mask
> containing CPU 64 overruns a bitmap allocated for 64 possible CPUs.
>=20
> =3D=3D40343=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address=
 0x7bbab4000018 at pc 0x6195de57af45 bp 0x7ffe25545d20 sp 0x7ffe25545d18
> READ of size 8 at 0x7bbab4000018 thread T0
>    =20
> Reject indices greater than or equal to nbits before setting a bit.
>=20
> Fixes: cbd7bfc7fd99 ("tools/perf: Fix out of bound access to cpu mask arr=
ay")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moses <p@1g4.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030064825.2156=
317-1-p@1g4.org?part=3D1

