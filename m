Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114645;
	b=Xm6XBtqGUlTxGPKCB5Rf5u59GgL0zVIdPiJGlSea4LHKfNxJ/oFdtSIVsR1QFsQEhPoq
	 MfNJ71xqAbxrzVd0oAvAdkEYbWm3wsajKFVcWC0AeyIblcwpkAFp2y+lIVA2BNzKNvrBk
	 ny4T1Z+WER3AeYOFeNpPAoFhBJxaRV6gpkgcWn6cmWhR/7GmdiwDfAY6/OugVbdSSQQCN
	 bZkDeUMxuN1e4Hq+1KiD2QRFU/t1rjrnBZP+1LZMF/B87ZlCAb8BF2CWD2cBa20CDGTFO
	 0EnZjAWWcTXFTIY8AoSyA5YvZ0JpOrEgxBbGNYNBRMiST72QbblekiaQK8I95B7WPag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114645;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Y4EUJJTw+H06+IWN6536irQOgGov2H9hakBdaJUg26M=;
	b=IJNS3keZ2bYGePQymSoB/AUBZtRFCtELjb1+vrGg0FQBBZZGCcZ2yqg6CLleOwpZvIun
	 GuxCdbfYHGkZyNTx3h1azObRw4w+GRxCQsHiOLf7Z9b21dAmf8TEVS6JhdkPmcWadEus3
	 5n9OKlXsbNIswCR+MzdpqQERWx1+ak6FBxgE3G4bRhR8ZmgS5jCQIeWm2dWOuJl+7Ipfv
	 D/X1r9vQit9u0S8h0Z3V3Kqe/c7KB10iaY/ttTl4gyF3cq3iOQ5OiToQUhUa4go8MaKR6
	 ZH9DwyOrUjtaiS3CVMjzex/WBBZUQ9NierXsdfaFSL7Q06v7Rse8NuRkwicOOZHa/Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ArJiD43o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8385606A324
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ArJiD43o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DAE1F000C5;
	Thu, 19 Nov 2026 18:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795114645;
	bh=Y4EUJJTw+H06+IWN6536irQOgGov2H9hakBdaJUg26M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ArJiD43otsyerBGMpzE1SQHVaT2+XyIJNk7kEPOgKk9EoITHoFFPVJv4KTrFXyOzP
	 1n5cm8n6vQ8HJLhX1XlDIec2kpqsaZrt2vGXZWklvEud+hy/ElhRosbBaJwxgzlaWY
	 GBNjwbqWhIHrs8hbOSTUCaQeBJeoHw7t9K8Jdy5zsXOGglBMU96pUzD/dkQxVU2wO5
	 nZRPy8BA1/cDtTRchAkMJ7BLIUqfqIuw7Fs9fIBzBozs0cj90Gll6gol6ybV4NHqwC
	 ww5roYmo/2M77C40UvnKcTAh+XwCUdsaSPpe776Dn+fvg1BchgVc5aXibNbwn8VTLg
	 u2ry41lWyfI9g==
Message-ID: <sashiko-outbox-223814@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 09/33] perf: arm_pmuv3: Allocate counter indices
 from high to low
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-10-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-10-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 18:57:24 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> MDCR_EL2.HPMN assigns low-index general-purpose counters (0..HPMN-1) to
> the guest and high-index counters (HPMN..N-1) to the host. Allocate host
> event counters from high index to low index to minimize collisions with
> guest counter partitions and avoid rescheduling host perf events on vCPU
> load when enough upper counters are free.
>=20
> When allocating a 64-bit chained pair (even counter idx - 1 paired with
> odd counter idx), verify that both idx and idx - 1 are present in
> cpuc->cntr_mask so an odd HPMN boundary cannot allocate a guest-owned
> even counter as the lower half of a host chained event.
>=20
> Tested-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D9

