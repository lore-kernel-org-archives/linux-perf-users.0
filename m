Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793943050;
	b=teoxSnx9PV/ePJKI8lXMrEGVHHcKTOYm6yXDZcrjx7tEGQi2HJqalZSjRa29XiTodQj9
	 99ZeblW9qGXEC8TgXF0UOgNSl/kZFhToOl2HKVD4Sa7UluEUm/ru4Aua0ivIIPzkTFsUV
	 0uD/m5pOt2Jc5dZ0Qt/cxBOaDmsygxck1Duw3RnvhBR7Juf/S0g3ip7p2WYDf24cTHP/R
	 mdavCMVYxDq+9UesKph7u48vWy2eoTL339AGcKBvhh65OGUGrlSVhUJ047BAIRVtxJKSm
	 ViQtbtGi20klsAXLJP/T31BT3V0Hk14W98kEiPMXUL2DJZO/NfjKy0fW+M0iGLSqWfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943050;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dkDSxm+nCkXHOK7HlIBarAhIs+e5QxpUgtarDTUjVeY=;
	b=UzCEhvCrKTGKgcds9SrWWz8LsmHSXNnKEC7DqXFrtth45jWULOEbbOGwEo4ge2byVuiS
	 lHJgRU7kqVdmF/Muu/serWBZZRtWm11pyaL8zIRH7GdRFRRAOl0kpUYaY8DDtqi2XvUyd
	 fFbo8+jNpluCKmAyHNx2OXIzL+0teKUIKvYwl/XiUiKQF3TPVFnoiocWamKpIYYFH8yMF
	 Hog713divdAwcdWaesbyekFWh8bGjcTWumX+m5qHYHizouHIO1hWzNwDFkogtyWBpkOlj
	 vERyA+neIozkqtQIxsPw7zqbbS0fKXzspWLZHWjTrQZYgOR5vKvXva/Byc2p26aTcNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgxCKOM1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0197606A328
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgxCKOM1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DCA1F008A1;
	Fri,  6 Nov 2026 05:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793943049;
	bh=dkDSxm+nCkXHOK7HlIBarAhIs+e5QxpUgtarDTUjVeY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=LgxCKOM15VnoPM35BkO45d9fZh4UpYZLn6dL+jStuaumX07IloTFucMHT/WIIyjRZ
	 hJ/7dS6evzKREG7vZpFMmtCfnZlX82DlF1fv+z7/BPcg4wMWb3YQhbdql3rAOQVo/x
	 OABsgSwtlPvoQgf76DWzPAXCrAl7g9n5l+awx4zqv1MIB/nlwTEmOoyCtXyvQcVgpJ
	 52eRljeN2fyVx5dNF73PORujycC40oZMmRlEH4YLP8SbOP9+6kHwboB3v1hk7BVE2j
	 VPH7dZ2sLnXgqSFoJVDQd3AVQ64nUkv8pogTEprT/VJs7aLHQZ54D9VRRjy+fOfUh3
	 5pUKFf4+3cNBw==
Message-ID: <sashiko-outbox-200821@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf intel-pt: Free the old snapshot reference array
 after growing it
Reply-To: sashiko-reviews@lists.linux.dev
To: lirongqing <lirongqing@baidu.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261104021951.1779-1-lirongqing@baidu.com>
References: <20261104021951.1779-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:30:49 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Li RongQing <lirongqing@baidu.com>
>=20
> Growing snapshot_refs allocates a new array and copies the old entries,
> then overwrites the only pointer to the old array. Snapshot recording
> with more than sixteen AUX mappings leaks that allocation on expansion.
>=20
> Free the old array after copying its entries. The reference buffers are
> still owned by the entries copied into the replacement array.
>=20
> Fixes: 90e457f7be08 ("perf tools: Add Intel PT support")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104021951.1779=
-1-lirongqing@baidu.com?part=3D1

