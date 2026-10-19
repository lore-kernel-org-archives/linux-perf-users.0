Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428598;
	b=HOGNAb1jCk7cD4akYiqKFovBHcWC+5KyjIcTqceZxxYV0DYbIG5zeSvTiaFwKK8AyOov
	 K/Jdq2CgU7kR+eurAbNtlczk06t/540pzBMGDaci91gd3qKQ30bWrRZqkFri7E6XtdaFu
	 0S7dT/hmK1MSB1+Cyi84VYwlg46gp8vdwaK+3pAvt+3eWOhBJLKIxCiURBvpwk1KYPcM1
	 1XaRvO1Y10Q4YkqTqL1xzuvT6xXk+0Iefxva6V1Ckv0LKV7VXbqHxYpLNAmPBV30yIbLG
	 YOgMxpcadgQ7d9Fjd0pc8K/rUrpEL0oKnFqq9JyDeEjoKXboisBZ6MSBtHXta9tLw0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428598;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q4E4R/erf16Ad5BbYMDRsKRQP/nvkL95pWIXO1rE04k=;
	b=SJ3aenoBnfNwhMMM24+9qXvFQgR0CRyMmS2LWwYrWqPgSFMbibPhrZbVWJe4GSl4Koud
	 9h4nNDiJwUIgLA6Vqf3mQ3wN4bCw0eQgKdE9bc2aZ8MJs0nvq1sQRXo4dSHWXCon0+wy8
	 3YAqmOGZNzHmfKfBUNQqSYpe8/lx1bK0/GBEPDH+rEezIRDX0VG8Vb3Vbgle7aInYCA8l
	 +W0d+M6AI36yMSGJZqeRejJ7WnS55QvcYDBk6GiCF7Xd1uS8ga9cS/NCTykMNvGzvGS1I
	 ETSysC7btjpaSi8k2i3BW5SRRcN4sm5MZNQl56Sp8Lf3iQO/rTRWlNdel6xRBCTDAwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jmXFDAjg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9432606A324
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jmXFDAjg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C401F000CB;
	Mon, 19 Oct 2026 16:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428597;
	bh=q4E4R/erf16Ad5BbYMDRsKRQP/nvkL95pWIXO1rE04k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jmXFDAjgBYaF+2qI0dd1/LXY0rnOFE/8q/sx4ShInjDPr5CKDDx8OUPkVDgGLygPe
	 U8UOIHEqGGOG6gefTHDcFTtuV2Yt2tBoCtboJGzqMt2zrULnQfyvYYy2Nuqju8/YPI
	 WeB0QBxESyyXkH/HuJFpD34ja2LPv3UpLfEmn6wb9fIcnWdSgJXi6mAb3c+LapixkO
	 UzMR2xEaM/YdTnCIfAAN0l7yKfywadvIl6EDOJV7bPDSr+Ga4vsTFwnzNK4alLgjiT
	 Ct5P8ZwH5NX4vXcuwbguPm+z2APhYRnHS7zUbJfEpaVw9NzT97SYbZAj+m36HcbTF6
	 jS4MbLguHo0TA==
Message-ID: <sashiko-outbox-177939@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] perf jevents: Add support for NVIDIA Tegra410 UCF
 PMU aliasing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Besar Wicaksono" <bwicaksono@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019164241.403644-3-bwicaksono@nvidia.com>
References: <20261019164241.403644-1-bwicaksono@nvidia.com>
 <20261019164241.403644-3-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:49:56 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add alias support for NVIDIA Tegra410 UCF PMU events and metrics.
>=20
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019164241.4036=
44-1-bwicaksono@nvidia.com?part=3D2

