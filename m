Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793991243;
	b=MDUTyBcvwzYcY+DAAwrkd+7uxJiZ/TR+jD/j4mWHJ9IRmaP/ZS0Bgwjp6XMnxf+z741O
	 5cfsKkU65Q5v1l3eRmxMvsNfD5uPWn0RxUVwVGDaX8qBsYG2KIqKCamacUtm1rf15zN74
	 JnlP0dqKP0fqmQFaKP5YisppsaXZtTZ5BqRRr0PtlLCiwLRIfwcH+d304SxNqh3KviAiU
	 WAhIpOmoZM2IFcSSdVPAGjSeezsWYt3Ermwv/1PXawqLWfhPZJT3Iinajo8wDkRJ1+LHW
	 K6KYXy3mexiDtHXQaai3iHflsdk8H9jj4IsZWtJRxbmZMUt/7pOiGH79AIlH7CinzDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991243;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AuGg27+9IMpciHcEnbUzptbZl49jagNmm+REWY+RQ38=;
	b=I5n5kMdG+C/3PwLMVWSSAmk2ev/uKAkp9C0e/06QlSS3Yj1L75a9iMp4VKHNrNjU3o9X
	 ovPrUHDYq4S9IAIHVCbrzydpw2upsaXdOIKi0S90aTTsKiAqUQRa42mfsa4f37ijI8F66
	 b+noY0wiANe3hIhAJo3HsOLqomMRggo2glLjBlvpHByHGdZAeJ3B7MdrMlPxArHF2J3Du
	 QDTHYDqvPq7pGyzaDc2PHwEe1p93jli70VLFAF6lkc6OF3Y8Rq2zcXkXpmsGZMKicFBbL
	 YyL8OV4f0qdr3823wOLY2VH/xJyt4WZdZhpd/qhw0aTsosrbEPFPVggepyw33hCtoEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b04mEkU5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0A6606A329
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 18:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b04mEkU5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D9F1F0089F;
	Fri,  6 Nov 2026 18:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793991242;
	bh=AuGg27+9IMpciHcEnbUzptbZl49jagNmm+REWY+RQ38=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b04mEkU5ynRcI9tFaNE630A/xrrGzta/arv5rW1MWsVfa3RGc4XCTd2RoJj782A1e
	 QwiX3vT6GZcnwTldfYT6T8hXWRWYofEw0YRyz/mfvZOG25tmj/AAP7UJPHdR85vygh
	 /jKCVEyp8JeSwY2wlQ3nMFrUioHXn3MRlKlU3th25ogdSi0JemDMWoJFbh2w81U2vS
	 ArqulRxO0/Q2yXgWNp5qDofCWMSsyGFiB6L6O4Yy7wvjshbD4rMDvtiZuUuAGG/oQw
	 Vo/+mMsiJwdsIFiBOELV67WDwbNRjAH7R5dimSIlPRBO+n+r+NcjY82niZOEccc606
	 C8pnZYZX1mrMA==
Message-ID: <sashiko-outbox-202115@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: Process subdirectory Makefiles unconditionally
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <4b2e518499270b2a6cab3e04a1123458d82d2759.1793990977.git.robin.murphy@arm.com>
References: <4b2e518499270b2a6cab3e04a1123458d82d2759.1793990977.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 18:54:01 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Our subdirectories here are purely for file-level organisation rather
> than any particular build structure, and everything in the Makefiles
> is already conditional on the appropriate config options. Plus they're
> not exactly big and complex, so for simplicity let's just drop the
> top-level conditions.
>=20
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/4b2e518499270b2a6ca=
b3e04a1123458d82d2759.1793990977.git.robin.murphy@arm.com?part=3D1

