Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607022;
	b=Mwz8aW2vhxOrs2ug+qSOsd/l2xjMG5BYKQAkMdZJ5NZrAPT7W8/qb+8d4a8PEY041GbB
	 X8MTk2oFgZIRiGBmJFAnVHuJbrsaycl+x/QHtuutvywhRxyK8Wmvk724GRBPkvcq53gTb
	 wEESVAPRWc0XTZaBDqK1OiHkjjthLlCopwRDODsDbrAq3BsVUSzhhE4t68AxrZK8Kgl0p
	 rtbYFjbEOf816Q8zcLk8uJC8iqox0BFTS0IBkTDb5Yz9hrxzqLnOSpkZTvcyLdG4bU5o1
	 nsujZoqULEgx1rwGY2mEjDUDHbZ/z3E/PnxOfu/3IQYuH47YMRdqVky2/BLQsLPd87Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607022;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iNXgmh+BcZKRUCnCeraUy8bnYVZ/OYnN8Hw8hAnU9y0=;
	b=ghHuk7N2EUwchwMSXfWo98HG7DjaH12IfO3dduTYXNcGibwKZClbHsy9Mx5TImoE40pr
	 iy7ncq8HD74o0UmgWqkbOwVE1oG7F64+G4y1qSTyZ1ebR0lsJ1+vI3hzH9mRyLIH4Xpzp
	 gty0FvDdcLt0O9Ual4Fhk7ASh9FCjWEaWmEL6/YxdCVuDITwSklPFb8Dhl05qYDnw4XS3
	 8pJymWehGFbAXNPhKC+zI7j6Y0NruUcegR/9NVPCcTGnDUMykpz1ckbKUfiziAv5P0Z74
	 RObIqeE2oOA2BH3cYQUBVhx1NhQpTu9k5KKhmmdRU8xjpgJRg4a2M5ZARnPL02hHABg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEx8XQhg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BC1606A332
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEx8XQhg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDBE1F000C4;
	Fri, 13 Nov 2026 21:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794607022;
	bh=iNXgmh+BcZKRUCnCeraUy8bnYVZ/OYnN8Hw8hAnU9y0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OEx8XQhgnlGpbFPNvryG9psmETBPdcpZCsl2gSkAe/z5SyfvjawKOtiRbX0pqn9p/
	 7F/fg93HeqEL2cngVlHlTehMhctWnhz38jxvEuz8X7Udt/q/GWlW0jFUYE/jPGwzA9
	 8XUZZ8CWAPfh8OVyYTiaw+X+lhAMsdY7s4xcxD1sVpBdQ/saq0CEZsJboW7MtHroM9
	 c17jsxBamZzdW7BvwpK2/+v5fCXYLnflc22IV/af6sS7U8iJLYilXVllh19+aLPM0l
	 Yf/fGaesvxO6tx6bc6UgQ8qej2+aWl0kOjRx9fEDoCM5SXCcrKgKI7EDTp6DvrKL+j
	 QbBXR043U8wlQ==
Message-ID: <sashiko-outbox-213750@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 10/26] perf ftrace: Use generic hashmap for
 profile_hash
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113214850.3329699-11-irogers@google.com>
References: <20261113214850.3329699-1-irogers@google.com>
 <20261113214850.3329699-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:57:01 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Convert perf_ftrace::profile_hash to DECLARE_HASHMAP(ftrace_profile_map,
> char *, struct ftrace_profile_data *) and use the typed hashmap__* and
> hashmap__for_each() wrappers.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214850.3329=
699-1-irogers@google.com?part=3D10

