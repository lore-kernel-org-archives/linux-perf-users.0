Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792968154;
	b=3coYhbq+wy/HpHkcRTOwgARdVo4O36Gf6IO0ZuRPeJRJ7+EhuKqlP13FQWw0IoU2G2M0
	 1aO1aRG2SUGOhJAQ9Q0dDxoZVFiABceyIbRKTyomBiOQgPeH5UKR1YI3BmMh+ex6IXrp9
	 afV38Xtsml59fh9XaNmgcEQzlL69hHnplat8VeMcnfYPnKmR281Ec5wZ0xKZBU0kHrZUa
	 e/HskI7oJ6fP28lLMseP0uDxe/ksM+HqkUelf/Yyr3uieZs2nnozLE5n+t69IXthp2LOD
	 5Tws5YBOqDEgsu7Jm/aHIUO9AobwGwNoqLTbjVuFjoyQGC8Na3glB9Om0Ahs2KukIkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792968154;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jWV/onQA83S3Ui4iB/Xl8LpUJ4FLROisP2tezTTVdG4=;
	b=ucS9R3cWgWKL8u6S8SgbbfHTg2s9TUcfTTt2E9y39W/Wsw0yfbQb5CXfP0E13cglU6/y
	 nC8rY8PD3q5LJewB1jc/tC/HlyTBL7xUyyApyc0o2jwv4CZ1+EK2s+8l4HVm6ZSFKnHQ2
	 omiCPppYlwQXf6w8c1xbqqsyKmM9rRdQtK2nTzOytZwINpsP9PHDNWHUM/gOi6iq4Yw5j
	 ZqkUAB44sFBCsh2KYoYgmTNOdX7u/57j6GYIJtCOiqTuKdVLenELJItjmFOYSR79gsV0X
	 nMEK7qMyZrnyJ2qqH+Mthb83D31gusTavEiaHAsyhEyEllKo1LaJkkfv1D4dvfKezYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wa2RXEUa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E797E606A31A
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 22:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wa2RXEUa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C26E1F01825;
	Sun, 25 Oct 2026 22:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792968153;
	bh=jWV/onQA83S3Ui4iB/Xl8LpUJ4FLROisP2tezTTVdG4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Wa2RXEUaSmdsjPGHWnEUocDcL8sIFfH5RfLS3iRgAM446vTnybt07vbxiAeXllNIu
	 Ea3KfCdXPw2JCkm7KuK8aJEUQcq8iAivzC9jahq5d8G83itWG/bomsAsRtqBAK11os
	 RUAbQvxx+tRTYCI3QjEnMgaEjHIX3Fs2WENYb4H5z++SnH/5u+y7GIq+b0ABtB//Ya
	 hs9QTK08vwz2oKg6qBBZBy603FMOd1bnk62PExwDMRmxKJY8Lptr0RxS/+Fna6cNNA
	 Da22JaTlmDcBuZnDpElDof/n0lv2D+cwSrbEVQ7LUCQ6J2IlLfOl8VPwYd10b0wH06
	 4BgvyCis33+EA==
Message-ID: <sashiko-outbox-184495@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/7] perf maps: Check map__start_cmp() in
 __maps__insert()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261025220349.1244499-4-irogers@google.com>
References: <20261025220349.1244499-1-irogers@google.com>
 <20261025220349.1244499-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 22:42:32 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In __maps__insert(), maps_by_address_sorted is kept true if the previous
> map's end is less than or equal to the new map's start. However, when a
> map has an end of 0 (for example, an unmapped [0, 0) map or a map whose
> end has not been set yet) and a [0, 0) map is inserted after it,
> map__end(prev) <=3D map__start(new) evaluates to 0 <=3D 0 (true) even when
> map__start_cmp(&prev, &new) > 0 (either because map__start(prev) > 0 or
> because prev's pointer address is greater than new's pointer address).
> This leaves maps_by_address_sorted set to true on an array that is not
> ordered according to map__start_cmp(), causing bsearch() in
> maps__by_address_index() to fail and return -1 during __maps__remove().
>=20
> Also check map__start_cmp(&maps_by_address[nr_maps - 2], &new) <=3D 0 when
> updating maps_by_address_sorted in __maps__insert().
>=20
> Fixes: 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted arra=
y for addresses")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025220349.1244=
499-1-irogers@google.com?part=3D4

