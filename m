Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693696;
	b=hwR5Eba/7H2x9PaZ/kIc5L0PbAgHOIsdzlM7Z0fE9L5DyTOHw0fUoNVzTsKZRO/uu/TZ
	 1F7qmMxVCpP334Xvh0P2zaw+HKGxWQTFMHjpXIhI+6ay7ZtDDiogNt5hrOorM7MTuEjAL
	 zYMW4R48+HJsFEdOxklzDLH7tvn00X/JgXIUZ0dTBgH4b/cpfaeJ9bye+FZvDsSPrZMt/
	 9WXP9KIOMeE41MTwlVGDwm+FfBRR9nXDYlSo9r3yuHCrRREK/8GToMfDmZKocrbi6Ttzq
	 giWPwLbE6TOD+b04i4DDumru6lejJ/OrR6ydiJrnqE0TOvLuw9eAf2Rcj4Cs2skgoCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693696;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/rKgJhQWqvxMbfB0f/iIj+Hye7lkyuFiDUs6QaKqmJA=;
	b=3+CAW7VWHqaTwwPA7rFGw5rYWjnk7qafxuMLYsjGf4eTjxZrr8cg1mEoxCuGU9frIV7s
	 eZPr5aWtKz62Tc7p/rUHcWtQ7f4xl01v30pYT5XSm34JdphlOmaL0i8OgGPt7s2vIbiu6
	 lSDS5RnCKfR5PcYCWaCvFBme0tUS/Hoo2EDQoS81d969lXbDUPcTwFEJfDVazzbEuN1sC
	 34c6sLWe6CaX59FHqnsvZKSJxzUdUY8KPs7pCE4aQFRL/B4D544MVrWtSBcP5mIH+ujxd
	 PRCZXWr2I/vFIGU2sQjS5tXi0h1zXyVcN/MRD5BippDzIZWnpnL6X5YOTxPGZSAMkSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fC8byVNf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED3F606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fC8byVNf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA811F031E1;
	Thu, 22 Oct 2026 18:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693696;
	bh=/rKgJhQWqvxMbfB0f/iIj+Hye7lkyuFiDUs6QaKqmJA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fC8byVNfZGmON/Lw4i6NM7VZgpP8Mibzms9OQKPN/BOjpm2Ki/kdl0cq/RNRZSd5A
	 dy35jmrdBzF1CCCkS6qR2Unkijk6Ju0vfqfCO541NvmHgXGmZhA+gv7v2RfgnbY29z
	 2MzLLKhDqXmCVc3S10wNu62PaUr7PTJIiqeiXk3/PdseG8oMrtnx44F8ugcpXpYPtj
	 YeSLOakHhhhQOtlSE2uM9jb+fmpkonthHAxB4r7dIHiOkUdXwSWZSmVf22WVIL5HGg
	 elrZT5I1uHZRvvT1ajmaq0m52f+wHg9RREwylfJ2GyinG/pjacZKQxqGgbOlrVYm6U
	 pJvl/shIByd2A==
Message-ID: <sashiko-outbox-181914@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/10] tools headers UAPI: Sync linux/rtnetlink.h
 with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022182431.25673-4-acme@kernel.org>
References: <20261022182431.25673-1-acme@kernel.org>
 <20261022182431.25673-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 18:28:15 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> To pick up the changes in:
>=20
>   cc17e386f8a5 ("ipv6: add ip6_del_rt_reason()")
>=20
> That just rebuilds perf, silencing this build warning.
>=20
> This addresses this perf build warning:
>=20
>   Warning: Kernel ABI header differences:
>     diff -u tools/include/uapi/linux/rtnetlink.h include/uapi/linux/rtnet=
link.h
>=20
> Please see tools/include/uapi/README for further details.
>=20
> Cc: Yuyang Huang <sigefriedhyy@gmail.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022182431.2567=
3-1-acme@kernel.org?part=3D3

