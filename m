Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414972;
	b=4VnVQbwfPwDFbTVsA/whjJlmTKoV5p4tDEUGDdX9F2nJMayKumfp9gWK3zUbdZlXY4Q3
	 afHJoYlG8nGf4aCg/SR237i94N3NTp2jQlZN4k3WzjRcfWGYdIJf4lhTLVEFPXqEGYSI9
	 OUmzZ3P03Zq7CypOkFabghP/wMHyFoL3mH70JZdY5VgBHpunpVKVhXDYSn8OrI7JAv6wa
	 4+UPI6AevOtjOPz4K5hpXb/FcuZBaRC1NJeTiJoXhGEWWSximrp6Xga4Lz3qXSEJ1B3+O
	 LoTYmEJXTsuYJEMKvUXHicbyFMER4t+7QX5yuPNqDMkuhBUSq05DWL5o1143xChRS9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414972;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HgeyHCWSnDessDjQhfL2y9IkHuOSB8sgrHdUkgiI1oE=;
	b=mffY/UO4+yweexuqJCNVmNBKNlerf088DdnoXdztSufikZGhaN3pFVnSvnxW9fJpD4xc
	 42mxIckuYFO5ITZZHRRjLMajD6P9WCnHLMXfMrDCMTt/tjdvWMmO+U0VqiVB/y5Aq+d6j
	 XKb/avfJzSykSnlZfYh4Mg3wuTRTwWeACtNaO4lxKcad9k2TCG/dxpGXkRyZWClxhxaGx
	 +3mZ6Z7LF9cLw3a24UiPknu3GVYxrWybSUW/lqJmcsyvpvsa3pHlENw8rpYDURNzVdEXN
	 LqkZiXpc5p5nnGNADNAufhpfy82zAs9hYN/tqQpLtu8MhlTK+22ZjI7QzuIvlpvJWQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rsxcs+oS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECBF606A32D
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rsxcs+oS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFD11F00A06;
	Wed, 11 Nov 2026 16:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794414972;
	bh=HgeyHCWSnDessDjQhfL2y9IkHuOSB8sgrHdUkgiI1oE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Rsxcs+oSEn0lka6nXorTIutXXhc50lGSicQf5rA6mb57TX6VZNPXYz0ir2l1CW2Zp
	 fYLNF0y+vx6Brc0PHYoPdqEsW9FDHGyO1NxZYY+QZAwGMonQwJ3KOWvFUJ6X7MawtG
	 W7/GOHIRgGKMFwSa1v3gBsl4Q3vyJA3qq6FROjx1NSDPJFuKynA9f+CksXBgbMGdoE
	 WqZ6HQpDANM0z1u3BU/9DjYz39SFaQB2IC86JfBXmVr6etVlqar1gg/VWAjBwhfPTy
	 MitKTmhinrTbkuydw4z94nti4rkRVHYzBbkLGKoAnzRhqM2F1osNIDaEJINQ5endBB
	 WvQloYiRdh34Q==
Message-ID: <sashiko-outbox-209298@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/3] perf jevents: Check the JSON keys a table may
 carry
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261111150920.2383157-4-takano32@gmail.com>
References: <20261111132622.2349165-1-takano32@gmail.com>
 <20261111150920.2383157-1-takano32@gmail.com>
 <20261111150920.2383157-4-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 16:36:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> jevents.py takes the fields it wants out of each JSON object by name -
> jd.get('BriefDescription'), 'EventCode' in jd, jd['ExtSel'], and the
> fourteen names in event_fields that it looks for with 'key in jd' - so a
> key spelled another way is dropped without a word and the object is built
> without whatever that field held.  Nothing in the build and nothing in the
> generated table says so.
>=20
> Two of those are in the tree.  "PublicDescrition" is in 16 of the 28
> entries of arm64/ampere/ampereonex/mmu.json, where the long description
> each of them lost repeated the BriefDescription, which is why it could sit
> there unnoticed.  "BriefDescript6ion" is in one entry each of
> amdzen4/cache.json, amdzen5/load-store.json and amdzen6/load-store.json,
> and those objects carry no other description, so ls_inef_sw_pref.all is
> generated with an empty text field on Zen 4, 5 and 6.
>=20
> [ ... ]
>=20
> The two misspellings in the tree are fixed by separate patches; until they
> are applied the target reports them, which is what it is for.
>=20
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111150920.2383=
157-1-takano32@gmail.com?part=3D3

