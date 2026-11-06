Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940401;
	b=VMKWzDGgPjQNPQfWQpMiHYHvXsh6nScW45s3Vjma+UEqdLhfY+oTrG2Ra0FXmFhffS5j
	 n6wN6rvZDfE9thrKKqwE+xQaVkxd5CISh+oACWtJqn3ASvwP6Xl893+XAZLbapTvhHq8B
	 5Pu8dU9rHP9ldQuTbHt4bPkcLazKTLhYTqnTzxMWMzRH1w2I1vuPBfldQFcQyy2ZckEkM
	 Jr4ba2DX97mCcCIt26EUNyy4zh89GaTvnyJrssEjd7iHCr+CHqygkBRDigRq9//X+m8pe
	 yd/4fG79uFWdu7LBKcDtlHZNwJOf1aMooSw2Z6XsPLOEcJOvcpMsCjkZnDxFJq89P2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940401;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TeSJUipgE/47PHtJXpheCvT+FY6w2Zv5/CK6qVoMfbY=;
	b=OdVzU50gTq2AaFhbZcuRowbaKm/QZo/Mdz2tYoYWmGmPgFfLAfWrYJKgGTdDQCKXstyv
	 QT5/7hUClzWd+Aa515sL74l/KVdnuMTJsR1n/nBZ8DZel6cfcTQsHnq752Z88BQQ4mzSv
	 X6Lv8oxHCbnenLGVmONA8oQ66nyApj2C7bIxcON3ptR/uKxg92jFqTVGv9EWZ1G0k/ZIQ
	 tcx6mCrMynO7kWi+j98CADXcn7kxbjI5skY9g/wbAPXWHfc1ggrCRdIZZIuBudSgk1gmi
	 Rs2TWMLVt6BDHTOCo5K3R3vcnpuvsDwtM0HBCRz9NCelhAei2z4RDqropY4qW2O7HSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gi9wUdj9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE40606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 04:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gi9wUdj9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA8E1F0089F;
	Fri,  6 Nov 2026 04:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793940400;
	bh=TeSJUipgE/47PHtJXpheCvT+FY6w2Zv5/CK6qVoMfbY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gi9wUdj9P16tFsuk8qmVR3TeWYau3KbGGoLjwK4r0VHu0sa/cXk9J2d9vos7fbxnr
	 IRfUsDdB335OyGBfBzOXeAxBynWv6Hn9TaexyFS+JaWPTI/3U98KtmyjRPE6Tqyb+w
	 02zkPEOOkFk+uUNfeGz+IH4MR6/LzwPWyF2B+BHb2z66La5jKZzeRMr+l//NsqdsKv
	 RZlJ5ygkOBqWQmk2cA1BejRehYZoHEMA1rkGLdjpibdQgp5+akL6ERkYyo0+WQP4KX
	 pManku2kHGI5pjeQa/N7yHyIAtGzMEoNgY7ncT8mmudtzge97Qk77IgJr9q4lqicmp
	 EisBQDaHD+yGQ==
Message-ID: <sashiko-outbox-200760@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/14] alpha/perf: do not report user registers from
 the entry code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-alpha-profileme-v7-5-c474e892abb0@gmail.com>
References: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
 <20261105-alpha-profileme-v7-5-c474e892abb0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 04:46:39 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf_get_regs_user() returns task_pt_regs() whenever a sample of a user
> task lands in the kernel. But exception entry runs with interrupts
> enabled, so the sample can land before the entry code has saved the user
> registers. Only the part PALcode pushed is valid then. An interrupt
> taken on the first instruction of entUna, say, pushes its own frame on
> top of PALcode's, which overlaps the rest of the user frame, so r7 and r8
> read as the interrupt's r23 and r24.
>=20
> Report no user registers while the interrupted PC is in the entry code.
> Such a sample also gets no user stack dump. The range is all of the entry
> code from entInt to the end of the save in entSys, so it also drops the
> registers of samples that land after they were saved there.
>=20
> An interrupt that nests on one taken in the entry code still reads the
> incomplete frame, as its own PC has left the entry code.
>=20
> Fixes: 9280e99d87dd ("alpha: add HAVE_PERF_REGS and HAVE_PERF_USER_STACK_=
DUMP support")
> Assisted-by: Claude:claude-opus-5-5
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-alpha-prof=
ileme-v7-0-c474e892abb0@gmail.com?part=3D5

