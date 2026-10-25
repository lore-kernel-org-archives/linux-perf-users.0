Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792910774;
	b=SDzsjyHggaFOX0yGwrD1Zlwd+hfo4HjZtaDndop+y6tyhzGj8Sm8e1+3Cs5Xcs0QcenJ
	 69lvY1cSV7riG7B1y1387XUTNwc/ju1BdQutqCHvRwSDC7sNjfY5fcw1SaydGBl5VWhbf
	 9hMhkup90IF4SDfE2w5JxbIgHCypfYAxsng3W6GZlUgWTNK2dWYRTwJFg7PrExXd1iy5b
	 60PD4UZU/oZaazYhWtvxG7NrbFQjDs8pClQ4Ycg8YXfSmO9eaRG1ppPfRxf3pJPf9nQBL
	 xeP9JqPQt861aAnt7b2Xd7Xr+ahS6R4vnTKJ6H4xgIlGrwGny8UUdy+vk4XmFeISu/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792910774;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KyRaGNkRsZk+B3HSCMV7LmVS5AT7K0rsRyG5upIMpcM=;
	b=2/bPBsOf4P/vdq19HaDcMWWSo7C0ilgmPRd6KuAQGzddZnD5nZagXod8XQw17QmB9bJ3
	 nYww20/BvR0W1P8ZjJDHl8mH/q/qdBvOBs42vKQNaxvyUwOOZg0AC4Ql25CtVxdystf2g
	 JO+dZCkhi0It8PklXUXIoNJn723Kr9O5Xsd+TKHuWrOmN3nGwI7/5Y9LTlfZR5joQjQ6x
	 bFOPFseYk8KEjbstQSjGH7GpWVDDi/J94aSP3zDhz1cP8CwtWLrE3dvH+X0Jguz5m7frk
	 GtLDZaP1FPQcqCFZqx2mPFT6Dc6ZHNWUEVPASCJUO55hkMmvEBN10Q155M9gX6nRKgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIl49aGU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA1D606A31A
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 06:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIl49aGU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E848B1F01825;
	Sun, 25 Oct 2026 06:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792910774;
	bh=KyRaGNkRsZk+B3HSCMV7LmVS5AT7K0rsRyG5upIMpcM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mIl49aGUWxAWHJbXESka0RoHWodypjJd1bdLuBP+G5UYw8ZetD2zy+0YPEV9Ajush
	 uj0BvG8Jw1GAaLTBFnm8l0mKNj35xHfLJxR3VXvLIlZ25wYQLZYg1EkSSkIYIKeVMy
	 WsrVPAnv/qYbbadFsyVhe1hbsynNcUijcD3OnNkDIoBy7i/Nerr8m0dqVfnQpuEy/L
	 IqqY5cmrq8QEzyh7PZ+VOj3Sz0g1MvoItJA/puz5An7Hi4t59IPNlrfJl+07lh5Dn6
	 I1sRr/IOosRqADfYVatZkP+x7mZA4d4xvR/ASDJeW0MLNT159GgXAMU9N59YnQU8zm
	 FzW6vs/0/1X/A==
Message-ID: <sashiko-outbox-184100@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/7] coresight: syscfg: Fail to enable a
 configuration not loaded on the device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <cc6b083f1ece4625e5bed0aa13b1eac7e4d1e274.1792907332.git.aaupov@fb.com>
References: <20261012230527.750567-1-aaupov@fb.com>
 <cover.1792907332.git.aaupov@fb.com>
 <cc6b083f1ece4625e5bed0aa13b1eac7e4d1e274.1792907332.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 06:46:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> cscfg_csdev_enable_active_config() looks up the selected configuration in
> the device's loaded configurations, and returns success when it is not
> there. A configuration is only loaded on devices that match at least one
> of its features, so a perf session or sysfs enable that selects it on any
> other device runs without the configuration, with no error.
>=20
> Return -EINVAL instead, so enabling the source fails on that device. The
> function is only called with a non-zero configuration hash, so sources
> enabled without a configuration are unaffected.
>=20
> Fixes: f8cce2ff3c04 ("coresight: syscfg: Add API to activate and enable c=
onfigurations")
> Assisted-by: Devmate:Opus-5.5
> Signed-off-by: Amir Ayupov <aaupov@fb.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792907332.gi=
t.aaupov@fb.com?part=3D2

