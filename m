Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941776;
	b=B3GGkOR2+9Kx1lWiCO9t9fw0WgvagAK+nXsewUxj/5CllY8UhkTooCcI2IeblndNy1MQ
	 pwG0T1DeUN2MUtNrSrcP/it8LjFHCB88fcHWshORDJClvMvZRC7x/pKHkn7GUbs+piOsf
	 nXG70S1mnLyNeCcuRVJzhoUu+ujTVPK1A8Bb5LcRYevQ1PPqxKUau/snFe4iyy0NUBW+H
	 TaBExQmTNWWFuvM6XfCPs9ikA3h/2mfsAQTCOGloyrmPH15YevfiyXI4bYlIfVQhs2fs6
	 P/Ah1TbwKa2mrfnCKs/G9IT/xLxpIsveyXHNoKGxYGAkRCgXecgtrAfHqNiNYfXuAdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941776;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DVcNz53gxO7K3G+jvc7kXzZPJ4fpyAnEzSknGgED4nA=;
	b=ddUiryM4dHGMDD1MJKrO513bC+5TIhsv5+AA6arN5nl/3H/7BT+67jWuv5vNrhov2XcB
	 xEHoKPTBsQtYpb5IV5YNLmaPQ6mUJVWy1sdEwofHT8aFPLpiZSXGKzrQeB47y5Oo/pjtd
	 qNDB0Ek5GiEHCVEZdr0J/Mno8kADl9RXSKrTNkiakzoa+kh5rIUuLbo0ug6Wzk6dJzEe4
	 wn3H1SUyb54YdNgCnwL7GE7dx1Gx9uhSLdC5t1RaOIQuYcP8nfihUK2i6Bpro0aXjtEmM
	 uxt7dZqS0Z1wBV22lY5gA3bGhJO8WSpwSUHplgVDfNVocoMx6IZnyfBu+phA1yNC3vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oHlF13gu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9F3606A334
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oHlF13gu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77741F000C4;
	Tue, 17 Nov 2026 18:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794941775;
	bh=DVcNz53gxO7K3G+jvc7kXzZPJ4fpyAnEzSknGgED4nA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oHlF13guXsE3mJfxO9qd+knbjwDL/Xw27A/bV/EQ56mMSkBWwyj/5HvxW+HDDfL97
	 KzEMeVxkIX1NgTV9qIp4nVJHe6xFh7ULyFu+Q+cMb1H2jhoR+n0QjdlD8bcDwtzeDj
	 Iaf2pNQlqBAJ4lP8+ieGdzJBkjLKPvBlxOfpANva56m3n1CZ8a9OklV7gGoVgI2eCe
	 Q/2slqvdmXN8nKwp5e5k0cMSzvMa/+pGr2wP0FcKJBkvc8IgoULnp/oEdPaInikSKo
	 cBwbDt2my01nBoOqB6lMr+i730ARK4ffrJvDJ0V50zrqF6MV+Sm6w/sh0KEc2h5DVg
	 CgCIWkUZ6qeDg==
Message-ID: <sashiko-outbox-219411@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 14/23] perf thread: Expand context analysis
 annotations to threads and namespaces_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117184844.99889-15-irogers@google.com>
References: <20261117184844.99889-1-irogers@google.com>
 <20261117184844.99889-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 18:56:15 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Annotate shard and last_match in struct threads_table_entry with
> __guarded_by(&lock) and add __must_hold_shared()/__must_hold() to the
> last_match helpers in util/threads.c.
>=20
> In util/thread.h and util/thread.c, add __returns_ctx_lock() to
> thread__namespaces_lock() and thread__comm_lock(), annotate
> namespaces_list and comm_list with __guarded_by(), and add
> __must_hold_shared()/__must_hold() to the namespaces_list helpers.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117184844.9988=
9-1-irogers@google.com?part=3D14

