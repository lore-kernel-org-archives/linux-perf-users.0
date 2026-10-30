Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373860;
	b=tNCRYo+EME+F9yyeXES+Ldc5W6dPEJbDbBJxZPlRy4gYCKPeaa9RdJO2sX6i14uQ2KSA
	 02mFUfhGHUCgt05sFkYq8huc3aVUYu5a7UATTOBFGj/swtioKgCXAdEWZcEhxteQmXN9E
	 OhvQ1L9NtJqsJc3ie0s+q3Py6pvgQsOQtfuKyyjRiTGfxKwLJGGkhglzG6A+tG2F1g321
	 ocVuUcotSvYhlaKwuxLf4PC4UDC/V3iMEdB42dSMuY8LsPjI5orjtwJxeDgB1Z2YeUebG
	 kIxBC+43sPF+pMUB7cdlPHBYWntWp2iiYr2k+ZylxuhqHxvSRlAaGwB4YJv7Tfc/t9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373860;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Lag/HMnldLPPUoM0TN2HEWH34B4xShxrmuF9JYmVXW8=;
	b=S52PcMOCWboEw3MX6/6x9BUnl/LRVJabhKSY8SwRrCwJ91gfwB+BH622wTiGd5e+ygll
	 uo5dHMbXkzg+oNUbyrRI78pG9vsm+nt80unbasU8pXu+s46YOSY3Xwq+GvxW0FXXVAYTK
	 0IabCSCChOk0UMgIeu4H0eU8dpUYUw2+61qwC53EFaK9OMaLqLp8D56s6MjzDg1csGNZO
	 IjTpoBmmSF6+1axmwWvI9wgIELRm6ufzSsvIu0sD8VOjsiOoj+CW+sWHaH53gh0nzq/CD
	 O9Fb6c3B9shnRFZIH/8EiMmdbcfYDezRTnlCsVLAaHpNDDkMWzSXu3HDEdLbQntxUNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f9AL3pFt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08838606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f9AL3pFt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4331F00A02;
	Fri, 30 Oct 2026 15:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793373859;
	bh=Lag/HMnldLPPUoM0TN2HEWH34B4xShxrmuF9JYmVXW8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f9AL3pFtOjN9aOV0yeRvoJosknJVpvF0RevPajVwnVcjFydT62Q4Py7yml+bqNETT
	 hZ3AyAZqjbl2uUuR+d1qdxsvaX1I5yEpTN0BfDXo2CFsIeNgSjyAjLjM+RkN257BEl
	 YUpF7OEodizvew94VXkRLHVyknu2YgoeRfSNP4gKADBxHRNSO+kySXtYd7T/a8bv3m
	 PlfOPd67ujQeLt7a3dZpVCy//bDuT4r5RraMTObzJZgqNrUaYuYe5BIrW4Ayduqg5E
	 88jKGFauU5RELU5gBzfEoYqQVUhrZt17fao8TKwrfErZvL2zxLwF8QbgH7MAiuZjzp
	 QwyylPUFADpxg==
Message-ID: <sashiko-outbox-191167@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/14] perf tests: Check CoreSight syscall entry and
 exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-12-7629b52ab047@arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
 <20261030-perf_cs_etm_fix_non_taken-v3-12-7629b52ab047@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 15:24:18 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Record the existing callchain workload, which issues gettid() through
> SVC. The test requires syscall/sysret pairs to advance the PC by four
> bytes.
>=20
> For example, an expected syscall/sysret pair is:
>=20
>   syscall           bb76e4 =3D> ffff800080010c00 insn: 01 00 00 d4
>   ...
>   sysret  ffff800080012284 =3D>           bb76e8 insn: e0 03 9f d6
>=20
> The entry instruction is SVC #0 at 0xbb76e4. On syscall completion,
> ERET returns to 0xbb76e8, the instruction immediately after SVC.
>=20
> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-perf_cs_et=
m_fix_non_taken-v3-0-7629b52ab047@arm.com?part=3D12

