Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373726;
	b=ItDLQKtOGQzOpnWWCZsMCMq+rACGdfTJkOs1Iz0Z8TjUnAhn76lEpbj1qxTiyqXV2JGl
	 y8yCzMOsAHAaLRs3ZzWIVEwUvFCFU6UoRCnS/GZph+s4xn6ZvNs0FXXmDQtQmyRfK8myU
	 3RU8VcKzqj2ILLgYExCyiLtyuxw+UOLL5iwiQjAb9EP1QbQ4QY5ce2TlBxJFowc0yw+vh
	 dFMaAidg6d3MODb42SVnNT5q4Yb0xL2sEgkXAlfPKrwsJ7XsyWTUTFgfiREhRu6oxAmE8
	 iN8mVWMGwzr1hkKQc8KhauiUXD0XHlal91XPL/BLvpTzTjkghWaOcgYLKt86kKrcHGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373726;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=faYY1DPe4L8/RaUp1Dh+NO8Hcri70XcJlejqV1CC6TU=;
	b=Eq6B2PAn60H+z9Y06qWNTCBkmkLw+xxOB4zBSAlV66kqy+SNVz/aRrdq9x22xJd79An2
	 DGiqho/KE3F3+mNWjxhNrfYc+X0tabprG9s9PDE1gFd6en+SkVRNoc6BW2oerGfExNUll
	 kRSKuAx5aiHn3jR4kGzIS/PgD9CY2psaQaDv2jANSllEIx/k0k9K2qJAQqlmFNUmBZ+mp
	 D9MPdfz1j91Vq2VZehSnshaO9kL7LVfFvEFWDXslkeQWY9QYGkJ+hbVrZ6LV74ApErTup
	 4wrijA5T1MqiFLpKkYJ1HlmfigSjKSkJReCL0m9jshVaKFkj/q5b29mgxoMGBrE+/Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VWOxIKQP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0063F606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VWOxIKQP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B343A1F0093A;
	Fri, 30 Oct 2026 15:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793373725;
	bh=faYY1DPe4L8/RaUp1Dh+NO8Hcri70XcJlejqV1CC6TU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VWOxIKQPSlNHSQdYuCSNdJcaCuG/GMPlYRwIJlXAZ6x5OhQRKahxSsaqyGqGSJ1Ip
	 Nei6H9/0X0jNQR7PpvLcteRWt9WvuaFsXAnEef9G8ee+YxvPDO/VXNsx8SqZjQsQh6
	 jz2p5pAcaHBALJW8/SsmpekQTAsxu8agekj5FknzXYzx2z1A8RzOQyoBBFv8dDAw8/
	 j4zSn4Z35hY2i4dvMsfd6WGtulzCulTO5Srd6ndBjdt3n6yHg84vMfSlIEvvCfbufp
	 GD9aROcrcGtnPDHqAx4pygZMdrVsmc074swtDDhWV4C+LyU1js5whXJLqa4RMx4hBS
	 AhmWRGfLbD1pg==
Message-ID: <sashiko-outbox-191160@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/14] perf tests: Check CoreSight IRQ entry and exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-11-7629b52ab047@arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
 <20261030-perf_cs_etm_fix_non_taken-v3-11-7629b52ab047@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 15:22:05 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add an AArch64 branch_not_taken_loop workload and a CoreSight shell test
> checking IRQ entry and exit PCs. Use cpu-clock to generate timer
> interrupts.
>=20
> Retry at different timer frequencies and fail if no complete pair is
> captured after all three attempts.
>=20
> For example, an expected hw int/iret pair is:
>=20
>   hw int           5cc928 =3D> ffff800080010c80 insn: 63 04 00 f1
>   ...
>   iret   ffff800080012284 =3D>           5cc928 insn: e0 03 9f d6
>=20
> The entry PC is the architectural resume address, here SUBS X3, X3, #1
> at 0x5cc928. After the IRQ is handled, ERET returns to the same PC to
> continue execution.
>=20
> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-perf_cs_et=
m_fix_non_taken-v3-0-7629b52ab047@arm.com?part=3D11

