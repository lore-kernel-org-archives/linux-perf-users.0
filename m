Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794144177;
	b=uxbQk2Fy2zfG4eeY/shQmsV6U37fC2LnecH9MbAthxCAiEkVP3CX+yjcBnv8o966UnWv
	 4RHEXaz0YNSsG/T3O6coVybeZfNIW+RVxmUjcDpqQU0/ExHUsqSz5frJoAAKtZ8Dql6ls
	 3wXio8kiF/m+UlQdm/kHnEnpL2RZQBU1dOBz/I5dGdT5YIXxgxk6vJZ/X0pzzhJwZ95Ck
	 W9PTAGEB/DSYfaBPlbQRiWokW/IXxDdyGWy9Bu+m5FyeR2E6j3QBlk9uYMUBdCplL7eTa
	 rA1YnJWvoEfIWNcqyAAzqdBw+RhPC0KWYdtXobkzR/egQgelBX3+li11eh6YHR4BR8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794144177;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+kXDFcXm0ach0xHZUrHCbX+FAAEIt+q98M+OklQFSqs=;
	b=a3V15Wqbx9pmilCeWJKjFhKw09rghMMZcV0fB0yKHbnTwPEc+A1fGforQTHvTIUUxnX/
	 kHnp8qBWLgM/CT5e2aAF1fRzONXR7uEOnXb7o4CrBPWtsJyZi5X0AfypzhQl7nadPvoRk
	 /A5U8+u5nmHLj/DcxPDLG6CGb+qTj6vuZbtvef70ZwFM36OXQpukUAAQTlAMxmqfCEoxP
	 C2qZZ3jr2KfpBM0K59OaAM2djqv2CTJiO3/PIgChGLWqYNLgM/Qc8H/1Nlf0qDsZT8Ky8
	 E6Y6BHl4mI3it1Hi/Vpt5i9/UUVE6YUwiYGOmYL4+XjOyONr6vkl1Sg3IknrjAtr4zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ouiEHPG5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E422606A31C
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Nov 2026 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ouiEHPG5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73FD1F0089F;
	Sun,  8 Nov 2026 13:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794144177;
	bh=+kXDFcXm0ach0xHZUrHCbX+FAAEIt+q98M+OklQFSqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ouiEHPG5WZ81NkRXbSznisoX+5V2Qh2Bd4bppKkxMKxY0CYtieOMg4eIPmKM+Q//4
	 lBBZddVRUN5NLJ0yUZoQ4bRwNtHvXTExjdZlp4OoLJb2rRoDHjZtW5cf5kR1wjxUmD
	 P4V2MhH9cbT8GRt2AmzcnaEqSOBI5MdyFZX4yKAO8+inrp3QSftq+k8vdpcT5zd5GX
	 FrFSjvV1J9lP4/NRe3gdkqAggrRqBRJDkMPcdenervgpjy8zDqb5dMYHpxQLMEXxNV
	 qfs5Zj/qKgrKqnF9nUVVwtWdghbSgl/s2JcwQlD6rZ10/iwpRJ9ztlkNTDagxD1Jsb
	 mXr31wzRJBHiA==
Message-ID: <sashiko-outbox-203775@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: mips: mti,mips-cm: add performance
 counter interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261108-i6500-cm3-pmu-v1-3-bd119584891a@mobileye.com>
References: <20261108-i6500-cm3-pmu-v1-0-bd119584891a@mobileye.com>
 <20261108-i6500-cm3-pmu-v1-3-bd119584891a@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 13:22:56 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The CM3 asserts so_cm_perf_cnt_int when one of its performance counters
> overflows. Whether that output is connected to an interrupt controller
> input is up to the SoC integrator, so describe it as an optional
> 'interrupts' property of the coherency-manager node. When absent, the
> counters have to be polled by software.
>=20
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-i6500-cm3-=
pmu-v1-0-bd119584891a@mobileye.com?part=3D3

