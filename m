Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810011;
	b=SADeykCOU03/6ZUb7ydEDz1JVH7sap8/LRN/45mOmRNcVTnrQYYTrIAd/+4rm6Q7F1YX
	 Uz1VDJ71RPM9xucDLf3/sIsXoZwLyhyOAK0VJt5/2OzaYZ/RZMHzlbmmMddFiatARPZcQ
	 jLCc2TVWnTUWYCLGFOulvvWKwKJbt2YYe8/4oglGi0AmO4dgncr10wFDubljI6qAUf8eq
	 zlqeV5yTCP3SNLUTvyfzq4ahhcFK7UIDY2qhGvr0mjZXDgZygg8FVpAeJQcPNwKzZ8blu
	 BcDvb7hurjw4Nmanz1hd/1XVV0108aaImByRWVnaaRCv9NgYbyCPmGK+zTj3PNgqqRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810011;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lE2/uAIADp1FAUG+yQa1Hxf8ZwC3vh5SC0HXiNHGjPQ=;
	b=Q0L7ss3OZCLE8FVN/Fs7hDkn0Kcnk958NiwGzsE17EGRF15H7345gb8txUXMzMMGKeZ0
	 OMrvhDNZm2pZF/T0P7OzwQTdptDkvQyh62DOSc13zYpBZWVpgZV5DdWsZ0rrag2X5cspM
	 qldDDura2nUXqb7dAQaJQtieIN+LSH/nSzRpdxkCxo52o0xjEpbeMugWZESr52txP774X
	 X1qaKBiytDyGfDFbgJji5F9W1Zab85FHg7/ls5NPB/ubP2EoMO6AiiABh09rfHpCv66l2
	 ZwcDh4NqNxmbRtzAxLOc9t3ICGNfnzHDAyxt8vU3mCX65Bdc8ebzV2HAi5w9X7qUcBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BxD8CC/+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76C8606A32F
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BxD8CC/+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2CB1F000C1;
	Wed,  4 Nov 2026 16:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793810010;
	bh=lE2/uAIADp1FAUG+yQa1Hxf8ZwC3vh5SC0HXiNHGjPQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BxD8CC/+wI/1TOo3OtJISVCUYb0Bd2OIpqEfTv8URjgZReTbRopzaOo8udM6NXVEI
	 ixDgK7d7Ea9OWwU5NVN0npOs5kB64xWvVXMqsO3bBZv/FHjME1XxyA2W6of5gkagqN
	 J0gXm/UL2y0WKdj1tcjaUslTZXtiuePU5S5u5uhKJDRhL7Cv6ULZxqjFznUrr8MPAw
	 H/2e5K45+IXpFgtsVEjRGS+CZ0wvcUL01aNH1lRBio8t+I7dupu3zHfb72QED9D4PL
	 Iqo8cO1m8E4sDWZxBqEfS9O0PBBEr8EQGXa84G5wgZp4km75ccsQuWZ7N9Pvm4tJi1
	 JYBVoTmQYyJRw==
Message-ID: <sashiko-outbox-197623@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/7] perf jevents: Add support for NVIDIA Tegra410
 PCIE-TGT PMU aliasing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Besar Wicaksono" <bwicaksono@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104160716.2910873-4-bwicaksono@nvidia.com>
References: <20261104160716.2910873-1-bwicaksono@nvidia.com>
 <20261104160716.2910873-4-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:33:29 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add alias support for NVIDIA Tegra410 PCIE-TGT PMU events and metrics.
>=20
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104160716.2910=
873-1-bwicaksono@nvidia.com?part=3D3

