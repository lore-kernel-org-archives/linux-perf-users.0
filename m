Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941786;
	b=NXYh7rRcBCV+7SzGFa/hX1zHPcQ/qoFAGIuSRgTuiOaYFwFHUZyWXkzsYXllq3kcTQxi
	 8lA4Cqp3xquU0BRmvjt5Wi1ufxP/0UdELRUXHMX/E8BHBR2LXJ3Le98RfvHb6w9Ste0X0
	 CR1/bxYBuvIsZe433/owYfzLBHdYy+U4C0vmI3MSzJlOCiIlz4o5wfvhWvLLYLGqXl0+t
	 FA3h0/rtC9F26PaxyXpj+hOxs3gI/o+VzwkLWB9oj0MRwq6ukCtbZbeVf6CZp9Qiuvq6O
	 PNn+menzuzgK3Rzvbx1e0tmmSmQ2F3ESvuNLc0fXMNkTsRVSGcjwDsbiftUulY6BCKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941786;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WOyizCfXNnTP1PuWei64pB1hRck0ubR+IlXcl6RE9t0=;
	b=W91+24YZGf8/7O04HTw0s5CnfuKmv5PcfQB1tBx5HQTHYFYtsXRWMPepeGUt5PkA0L0d
	 yylH7+6CWvAUNCOht8IMNhKMxpKiZ1NbichOOfAeNNgmZvWJBW0sMHmmTIwF//eCBB79I
	 qL4Odp5iIFLL1V4L9KR3vqrYJo0+a7D+hWdK9SsPpju8rSVd2DQv3r68gysQ1kb+y1al9
	 wBegqsmODYb67PLt31WPlAexijmJ770GWtdaxcsdL1+64ZTgxzrdaScjZG01akfijYEIW
	 LpO1ou/DNmUnKjomWxQeYzAkfQk3veLZZQXUQ7pwdjzmkqa6F0GEvUQ46IckrKuYt4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lNurF+cX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61CD606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lNurF+cX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1E11F000C4;
	Tue, 17 Nov 2026 18:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794941786;
	bh=WOyizCfXNnTP1PuWei64pB1hRck0ubR+IlXcl6RE9t0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lNurF+cX2CczT/ONlRdvI9rtHPiAVtDhDIkhRKEBWZjeTuADxc4A02yahX9S2aN4w
	 J5S1l0M7dHdZqLBaD4yS22Ck5i08X+0tiVbu4vVOLz4HvX0d6xHQyJb0piJjkf0cE8
	 8k5brpzQSdki+mBEqShaYDL4HI6Ty44ePwHe+zfgBo30rtsa/WnOny/am6IkL1Isno
	 qRkoOfYaSkGnD0/ApT4noho/DEqZ1iLR21aTmiOEB0jqvgHOhi8bncrJAyHuODrrgo
	 +dK+UQGbK94goeT9NoMSx2Plli/1C6cq+sArCQwczoUTurwhQbzNiO8N1RaPLgfSSp
	 qNJSvhNsYKyJg==
Message-ID: <sashiko-outbox-219412@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 17/23] perf config: Add __guarded_by and __must_hold
 annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117184844.99889-18-irogers@google.com>
References: <20261117184844.99889-1-irogers@google.com>
 <20261117184844.99889-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 18:56:26 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add __guarded_by() and __must_hold() annotations to static parser and
> config state in util/config.c.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117184844.9988=
9-1-irogers@google.com?part=3D17

