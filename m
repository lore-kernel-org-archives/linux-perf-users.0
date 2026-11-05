Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793860589;
	b=fQ7jbi6UnSv2T58gxLgeuyg6COc7gfiym6S6hznCr0iZNMNxhKr+teRLLwCSgZbwA9qZ
	 Tr6W5Mu+HfB7imAOsszHFIhM2mleRvQEaHej+ZBxiE1gVtQ3i3BhGSynTpXQfu+GZbzKW
	 s8i4RnZqo6TgOWHx4yVb81+ylwtHiQ50IHpmGLVFeLawELI8L8GcvZEetMIfxoQuvCMN7
	 SCSvRCITkT2MVAJWDcfboxCgUoAl5KbqN4Vr39IkIPiW2Ff8IVMNPFuSd9JDXgmrp0HiU
	 CrnwZpizhlc+BS1dVyg4vXMUEP8k/9mebSM+gOW2v34hJwot1aSdJNs9Gn70yXNZEZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793860589;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hO8hJZdW5RYA2Wgf0C1CutYaUiF1GOj7tDdTTSqooTA=;
	b=UnTNVfylYXYeLWnkbbVyy4P6wbledlHu8TseantMYw4xVgq8Ro28u4YiuXGHlWs4V+2Y
	 D0X0p9LYBsazIiyDZWi1GiAoI9XVqalgVzivcuIQS9FKHrkLcnspEKQ8FS6Os014T4wQd
	 ZsuvZcXtYq/r+xuxi9CjREJR+58IEb3KBdAUIM8tJ9s5tpxjH9ZtNwKBWezrsjdhs3yBJ
	 L+BDyLwGM+d4eP7Cvjwe1YNPpGC2eLTj3CLmCMrzDLbYeaBm6gbIM7WyhT9+R+FgZJ7dc
	 0vOAGkQ0DBrjwjv0VunWi9NnJpD0OvgBpSHgZbnaBchJBBSUzcwoC6KpJVLLFGU43pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kdoASjiw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13717606A31B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 06:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kdoASjiw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC5B1F000C1;
	Thu,  5 Nov 2026 06:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793860588;
	bh=hO8hJZdW5RYA2Wgf0C1CutYaUiF1GOj7tDdTTSqooTA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kdoASjiwa8upfKubM7eLIa3l9OHPYs+3u1H06LImBb4mbXVRNKH7hw8iKElIcxcWg
	 aeH+g73E5NanwDKOWvrmllbH9ZDNtrWbd/+hfOz1Fce2LtMq856LK9FuEjCA0whG9x
	 URxTXXErmsHc5D0876eKiwS7qx6c8xzQIYJNnAPLVO8VTjIQC0tLD6kSJGPahuJV4f
	 XLXr11rOALqdGrGB914cCecrpXOu41tpUkqMtF3sCD2e+uGdDVz52FxV+gwzchsBi8
	 0VXGHojOvf+iCDAc96dA1fZG4geaZiDsKDWjx/b2QLD9b6ElJS/9bLS+ttJ0+RVJvd
	 uFF2C3THtb9gA==
Message-ID: <sashiko-outbox-198626@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf vendor events riscv: Add C-SKY C930 JSON file
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R1VPIFJlbiAoWHVhblRpZSk=?= <guoren@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-csky_c930_pmu-v3-1-3f33e6b3d259@kernel.org>
References: <20261105-csky_c930_pmu-v3-1-3f33e6b3d259@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 06:36:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Chen Pei <cp0613@linux.alibaba.com>
>=20
> Add PMU event descriptions for the C-SKY C930 core so perf can list and
> select its hardware events by name instead of requiring raw event codes.
> The events cover core counters, branch prediction, instruction fetch,
> integer execution, load/store operations, vector and floating-point
> execution, caches and TLBs.
>=20
> Add a mapfile.csv entry matching mvendorid 0x5b7 and marchid
> 0x8000000009201600, allowing any mimpid, to select the C930 event table.
>=20
> For example:
>=20
> perf stat -e cache.l1d.rd.miss,tlb.l1d.miss ./workload
>=20
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> Signed-off-by: GUO Ren (XuanTie) <guoren@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-csky_c930_=
pmu-v3-1-3f33e6b3d259@kernel.org?part=3D1

