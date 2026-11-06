Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941574;
	b=QZt3Rxku65Ap/ZWY3myjuZ25P9qy6rIEAfXuUhR8kq4Ll2X1zse9e41FL24cJRkFdRyl
	 jl+myOz0KJsscpBBbpt5GSnRmjb9XfUJ5raoRY3BdwQOZYaDI8eNuTYskWOKldxPE44PH
	 5a4b9mW913n0gsgvOXJx/MbfpTPuz8WivjLKQqLls355XaSoCvdlo+zH64pSgUFZruArP
	 e1mGdkSdgP/QodNwa9V8lAPuZ1smCLGS909cDs4Y5nnZvGURxp8FKICnlwMntMc0qrnSd
	 luIL3rSj5NuUqbL5KSiElH7ob88MMHB1uinHyEXmELmDAxw766NON4Ab7LkmL1UMQvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941574;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JZCapsY4s/fRxz+IoW5tO8h6KIT/+2WhA3Tn8gNbVoU=;
	b=FzS5Bx2UWo2JJkvKVtc0VTi4CGXYCUzaK1cN3RgcfTFM22HLYHR7suUYW69SJUVqDBh6
	 pjOz7ooOmPJ8B27fUKDgY3dz9Xm7sdldxzDO7Saangf1IMhZk5jD/wYDpGS6XroppvcdM
	 OBTmKTN5C/iaFKeB5faQTDN/8r7OwinJz3fNSDlx7EJ6Y+r9BqE56BViOz3T2bt7KlsJD
	 OC4ZPltOu/P3vK8LankxfMjHZV63sN++K0KfDJwQG6PCpo6pzQ4de6d9/9EdmUjoa1Usa
	 oSLvopYus8/6+hCf+P9jbikXjwpX6c0Ppv8ZR20i7P8o3OYoGgGTQ+ssLgudaqXNgSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcpf7Vo+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5921606A328
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcpf7Vo+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD461F008A1;
	Fri,  6 Nov 2026 05:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793941573;
	bh=JZCapsY4s/fRxz+IoW5tO8h6KIT/+2WhA3Tn8gNbVoU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bcpf7Vo+PJpvkk+VWtBwv8hhFftHC9GufUT05GKk/1bvKSE1w+fUhFhBGZuNBhevy
	 4A8dLUS3QlXl/PMX6Irxlrhc/XGevlcSvFPVcTijL1Ucau/TzLMoT8UYMHbFJGLX+t
	 BCBq//RFvYZdiSrBTuBW3Q1a8ZbgTXWXocJHbVKuApd4X9F3yuMrK1RDcbH1QBAS8U
	 wJlOVXtryia33oIdDTE4CRrljzSsPY1fSW4sLEoMvF21LD3pfdDREMG+ECJ9f4m5/F
	 GF4h18Mar/sTrH4OV0GRh7Z+IcgmRI3+Hk5rZ8XBSolpb7MM0tSqhY1qfD99uZQLeq
	 AJRDP1uDx7lMg==
Message-ID: <sashiko-outbox-200792@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/14] alpha/perf: optionally randomize the ProfileMe
 sampling interval
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-alpha-profileme-v7-9-c474e892abb0@gmail.com>
References: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
 <20261105-alpha-profileme-v7-9-c474e892abb0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:06:12 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> A fixed sampling interval can phase-lock with a loop whose length divides
> it, so that the same few instructions are profiled over and over while
> the rest of the loop is never seen. DCPI avoided this by randomizing the
> interval.
>=20
> Add a randomize config bit that varies each interval by up to 1/16 of
> the period in either direction. Only ProfileMe events accept it, since
> Aggregate mode samples already land a variable distance from the
> instruction that overflowed. Counts are unaffected, because prev_count
> already records the value written to the counter. The jitter is
> computed with mul_u64_u32_shr() and the sum saturates, so that a period
> beyond 32 bits cannot overflow.
>=20
> The jitter comes from a per-CPU prandom state rather than
> get_random_u32_below(), which takes the batched entropy local lock and
> triggers an invalid wait context report from lockdep in the PMI.
>=20
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-alpha-prof=
ileme-v7-0-c474e892abb0@gmail.com?part=3D9

