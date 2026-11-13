Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589805;
	b=x4tdbQ/N05t2ssv20eH8SoqC1O1NAD2Z2ThCbkh4UzbAnoSHVh3fSkQg7ZerHUDHb4pG
	 N0Y73vP4t1sBYD1Lx2K3UGdJDRTE2mw9rBtqB6VBQ4xxQOYOVz6VIha8O1ip7Ouo+j+Gs
	 7VCdtkLj9xz7mIyD2BdHsjLz8cWUeuaV7fAQJARuyTV5uQm4PY0Jk9nxpRZWI3tRCqGTz
	 NXIrZtvoj/kEqdJTNgg7m3A3959iy3ihtkSHC2inFWeYa9CR1OblN3QqYtShN8Fy8TRM8
	 +TBD1qfCRosaElWei0nWos4LtEAtynnyBp5mGgd7/39LllRk9GF1ze/xsXGhR0BZ1dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589805;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WHpdnHzdFVRJrkkeic5WE1bTUMHqie/U7Tln1bvZuD4=;
	b=oWSTBCZAv/bIxsINvvnWgvqheWYbfCTMM8o3fS7pxe+AAnAwezXnjGSV3ESxUivwzoi5
	 gwFmJVe8+kw4ZEJjFZNUS8DhBLrj5fe8aHIOzhb5blFPQimawzFCGVDrmgtthfm9VF/DN
	 sLsIuooLBW73B6sbmkplwun6PvKrrbirWTBrFgrK03Xo8Pru8O8kncQNDLjZPIuz0BHkm
	 fFeCO+NwxCxvuWyXMOqu/qP8C0OpLfngEFkQU+4LTEyjsgvk0punuD2ee0VXbHAFU51e5
	 GYvCHlJqmEWMI0HQYZsURGgWYzRRkWb4I4WEMTMztnaOJwewfDDcxmE83JxLeMchcMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+G+LCtV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6B6606A327
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+G+LCtV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F8C1F000C4;
	Fri, 13 Nov 2026 17:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589804;
	bh=WHpdnHzdFVRJrkkeic5WE1bTUMHqie/U7Tln1bvZuD4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K+G+LCtVju+JtR+5IzeYWGzNcIAVD468rUu/jCTFuGVTngJfVpYYVwSJZJZJBYVRh
	 3xD1OwfwABTMF5DxPElH/tFHjrPt3Ek1SVP48kgXDiav1finrrZqpnwrOjycRbznQH
	 IAmQq46LtJe48Q6F497BHH7WD01gVciP0+vMKZHdhmYvfrvdkrf0n4AYxraplXLslN
	 zNC6Xc5mGpd7DcECFknAL67A4BqtJ+m7h2WuOG/bBIPLjdbbJo584D067D5pPG3pJb
	 WPeMhNt1d+ih6zYsw2zwv0n1FcQx2da/sLlRNRguS2k+kBs7C7UO4cIOnXY+Nmoe9V
	 YyCw/554jlUDg==
Message-ID: <sashiko-outbox-213281@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 19/21] perf maps: Fix lock inversion in
 maps__load_first()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113164152.2095566-20-irogers@google.com>
References: <20261113164152.2095566-1-irogers@google.com>
 <20261113164152.2095566-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:10:04 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In maps__load_first(), take a reference to the first map and drop
> maps__lock(maps) before calling map__load() to avoid a read-to-write
> self-deadlock when loading kernel maps inserts extra trampoline maps.
>=20
> Fixes: e77b0236cd0c ("perf maps: Add maps__load_first()")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113164152.2095=
566-1-irogers@google.com?part=3D19

