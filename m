Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793212429;
	b=CagKETXbROB13drmXhe1VK07VPsILshKgvIoG4K5i9tuqeaZJuX0or+iC0ZL3VGF4HXO
	 cRHSl0PfLwKZ2vcqaXcuLIq7dkK7e28RLeSGq5KJq7T2g2R/02FIdIIq7V3OP7ePGNySx
	 91FaNtPL4aeTYKA6u0x4uF0PU03jSOuO1EkQv7VHWiOsTYBARJp2J5OwZBKIAsOqN123a
	 Brbpu2nYPeEuMj6Yuchl6wczU5kIK2qk9/yITzPyd+ZmzCDra48OzIdG9gLfdglaAQYHn
	 pg4805cNzhffZxMAVfrUlapbQiVPyUytC89zScgOBVcxP8MGlyQnmMFcg2fav/203QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212429;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n71AXaq1Io+Ebup1FmqCRhX0iTaSFsLwhTJAKJ7veuk=;
	b=C2Em4lVdAUNcPfoSngQfFzqDj+vxPLK7w0MpxEg1za3nxETYfQkXNFDQTUkmPgI3kHI2
	 QaMrxK3+vMqi7H1ZPLNU1SCmPc3j4Cw0AE2HwBZKN4zUfS18QMHp8nFoq1G4mY51GWLa0
	 fLrxNui89u6NHkoML6Ll5e2f+sHVlurULQowlRhY/fgwAZJzXpfOLbKL2dIkFNPI2nGl4
	 MiD+uUbA47JIAG8D+TMoSVd/yzSKDtMyALbtg7wth/X8v99mDQhBEvsIK8QAolv04RS2E
	 Wk06YSCO0/6dYhmoB76qcBthkQcmVoOAXh4FAQMk3Nl42ceYotMj4Iny24zAg1wqa9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D47a1myJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAEB606A31A
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D47a1myJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D051F01825;
	Wed, 28 Oct 2026 18:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793212429;
	bh=n71AXaq1Io+Ebup1FmqCRhX0iTaSFsLwhTJAKJ7veuk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=D47a1myJxQUZTIHJqxLhkicw8oKaYCXVvD8eOHevei11bHIvJyUO0dvtlDuSfb3PY
	 vHjrVgcGOesbFSGpZJSoWUXW+by+ScxAObNv0vgTJedmTcgIYDtLEd/BLe6mhfR7Gx
	 ZrnYFTWP8IOgfR5MYDp6WMs76RXjbXMo1e/maKtDl0IqWUBE4SVxurAf/gksObQGVg
	 UPKZLs/l5SaJmX00Vo/suLg65DTnsKB2NipX72BJPGwR483k8kTXdw9RseBv2sARCg
	 5tRTyK1/PqNxn771AMF/J8bHfHzZJgOaSR2ztZ6PTfHxhFeAblUZRxFkvyTQ9zHoQH
	 Tp2SFFdTxwbCg==
Message-ID: <sashiko-outbox-188296@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH][next] perf cs-etm: Fix spelling mistake "should't" ->
 "shouldn't"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colin Ian King" <colin.i.king@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261028183137.537812-1-colin.i.king@gmail.com>
References: <20261028183137.537812-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 18:33:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> There is a spelling mistake in a pr_err error message. Fix it.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028183137.5378=
12-1-colin.i.king@gmail.com?part=3D1

