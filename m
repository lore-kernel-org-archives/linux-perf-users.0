Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882136;
	b=KuwUfdxbr46x7FDilXsIaRxiGkJuTdb9umlcacQ571Og6uoAPRDGYSP0uoIg9fUXdx5D
	 PhAOgmip9LE7PdIm46TuHzBuBCEonjIHd79HxATcOH8GY/9/kci7GzxDclGNxh9X0t3HM
	 E9/YxlTMKtSeYe+CcOdmISimWK2DA/CNECffn7fyUsNuFpEGAEA+9T5btSsLl/ssyPduD
	 DjocGJjhhjWp8ADUiehuAlbCk+MZvjVgUASe5XWHUI/Q/8w0KWVU9muNECrvoL4uNjGjI
	 5Qb8uJ+hvHmAyQvAXNLRutrCFVTC3WVBbL2YsQSjMkYzAO1BBIGlCihVy/0tksB4fOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882136;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lEWMUGDRL7viZI8Q06d6+T66BORj+TZyYptqotxBaLg=;
	b=UzmYyTLCA/gqd81e1SkFSmv0OfNxDLSOybbfMHj8/Bt5HAq9x3uwqNNdJ68Nj/Pok8IW
	 K+Yjh967RQX9nnb1eqbP6+1PT8OTIbZkq72r2FHHDKykyV+V2J1XqN2XtsMIopB/sgyYj
	 cis0FJz0629q0x3cubUXp5isQY6S3L6VuiKWALZa28EKBzDSIAqlLVRNl409Oy2d1Ptq5
	 lPJcPxERczYYJryUCzYqEby4aGOOoHEoLoxyvtqaWdcTQNVRFHXe45bA4RkimTUHX3LNM
	 TBrDV3pkweWG46Cv1mak5jPwHzwEjS+7Y/zcgIB14KG6dNAvHD4Busxu1bfGjqZJbrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="D/vUzOB+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65013606A339
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D/vUzOB+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30121F00A16;
	Thu,  5 Nov 2026 12:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793882136;
	bh=lEWMUGDRL7viZI8Q06d6+T66BORj+TZyYptqotxBaLg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D/vUzOB+hxLxidzEJ8jY4Nxq1O80fdcY23WGyr+k61O8cHK1gQejkHP1FpMTlLEm2
	 1LfGj9t4kf+hilZnya86CanMjEYdKe6L05vWXvb83CmGRs83H9VjDzXCUp5yd7ZK/B
	 ++JcrI9B6hGgQ6Q+UJccKdkGCSrKvMjAR3qufMV8AzfPrLs30iOoXk8W8wGZsrBrMe
	 xiOCtnpHduTC8dgJ9dfTPFiymo5vSJNbHSsGyLoWc8k8y/gX6X4e+tvHZLqE06wnjL
	 h8Diwd3byA9okMzpnt0HAviqf4tvltpgTcPfyHwSeG3rXZA3+QXlTKi0HPGgJEoSS9
	 LKHatVMJtcE0Q==
Message-ID: <sashiko-outbox-199041@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/19] perf test: cs-etm: Increase window size in
 disassembly test
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-5-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
 <20261105-james-cs-unformatted-per-thread-fix-v4-5-7759e0ce2449@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 12:35:35 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When we increase the default timestamp interval in a later commit, less
> trace will be recorded. At the moment the amount of trace overflows the
> 64K buffer, so the exit snapshot trace is what happened at the end of
> the process rather than the beginning. With the new default interval,
> the entire execution will be contained in one buffer and the first few
> samples are always various instruction and data faults. These go to the
> kernel so don't result in ranges that can be disassembled.
>=20
> Increase the window to 6 samples to ensure something with a branch can
> be disassembled even with the fault samples.
>=20
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-james-cs-u=
nformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org?part=3D5

