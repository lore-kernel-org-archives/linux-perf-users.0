Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793258500;
	b=uJUCbtQ4SkdDYInEqjMJf8z/Itj+7xLDcEd1wg62rqgfMPloDRvxuHhCFHymCoobk9g1
	 wDtWRGanb/a2JIqflXzJjViEBTPdm3nT214F28ju1bot/tl11xd9wdcY9dZ+vr46AJQhO
	 z2pqKwF43aGl58FKQOvqtvavxgzQ2r43Ng36ZKHhbPwehaT4ugloZ8+TBgiwRbwLHGnFu
	 dZ7+Q6LHvA4P9AVtbB7qwl3h44ZWLYYfC4JO4lBWjRiJoDsqY3kWoCMclB2XnTduIGFDg
	 d9WSHSdYHvVOT6l3/dZilBqhOQh3rcX+aJ/6pb6wMlu+9GlXqYLOSRFPrSuxsuOHC7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793258500;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QHHKamQEBdXcQ8lpltpq0HjIhKqKt1jRj+X/vusJwM4=;
	b=ZZTOQPvDv+o7opGSNjaGDjcSD8G7o7lgYbujUoMRso01ycpgHEDhMZVO4LUOIlcMt3GE
	 IJuIdKEXkGDtVSbJGbnhZGKCMVKYwRmEyHtRg1VpgCubgoTQ/7ZNtLWguBUCqkjlI6pUR
	 8F2+6GbsklUIwjaOWEZG7jBPxqB5SKBI9KsVU8A6lAbFMMfIqkm3Q1vU2cQzoMpDQXaB2
	 T6eBBEXZYOacL2sAZxVUTshyBJmGWtVov2T7v79q3uzrBIJE6Uw4GDT++uHM6WFIxx6/W
	 vQmXtLM43cJYCE7VA5rp/fGivg0IWqgG/+w4wzEaUOy0d9tCG+rIReTPTDcIvK7uSjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KpGuRrWx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA110606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KpGuRrWx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5B41F01825;
	Thu, 29 Oct 2026 07:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793258499;
	bh=QHHKamQEBdXcQ8lpltpq0HjIhKqKt1jRj+X/vusJwM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KpGuRrWxYH0OPBO/yp7XuKLRLeBL+AjmZPVYdgj/1qGZVaoAWm0wy8F+zbKMMAZNO
	 SwG7N3IEaYRWigMxZSl/3xeAWCjK2xoUTdWLT5WoBsiglhH2Cs2pG7rkBgX4a6WyZ0
	 /eBGZQXsh8DNe3kVVx8WeTV+ZV4a25i+xx+/PIyvqaqrMRIn6e+rEG1/WnhMbSANaB
	 9aIIdC3XeojRV9e0j8Uh6jTJ3uNh55SgeYSxXyPGFFDkrt9z1bh3yrHjL1A8s34y/w
	 qhE++xl59NqKBzGjyk/m7QzGvTh0HVKYebZVKM1F2EfULzQFzheKj/i5v1Pm1OFPr3
	 0EAeRElNYDxyg==
Message-ID: <sashiko-outbox-188856@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf annotate-data: Show event name in the data-type
 title
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029071510.460873-1-wutengda@huaweicloud.com>
References: <20261029071510.460873-1-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 07:21:38 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The same data type can be annotated for multiple sampling events, in
> which case the data-type header is printed once per event.  But the
> header only shows the type name and the sample count, so several
> identical-looking headers are emitted and the user cannot tell which
> event each of them corresponds to. E.g.
>=20
>   $ perf annotate --data-type=3Dpage --stdio --itrace=3Df
>   Annotate type: 'struct page' in [kernel.kallsyms] (59208 samples):
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>    Percent     offset       size  field
>     100.00          0       0x40  struct page      {
>       9.95          0        0x8      long unsigned int   flags;
>=20
>   Annotate type: 'struct page' in [kernel.kallsyms] (59480 samples):
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> [ ... ]
>    Percent     offset       size  field
>     100.00          0       0x40  struct page      {
>      10.15          0        0x8      long unsigned int   flags;
>=20
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029071510.4608=
73-1-wutengda@huaweicloud.com?part=3D1

