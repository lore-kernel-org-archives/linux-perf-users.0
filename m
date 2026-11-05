Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793861997;
	b=iX6uXsH0D8DsE0yGSjsIUb5nFG2XbIeGATeN4h/bGgVM28KqKahhbp1BAAz86BNfMdUr
	 ZGdl8o0vq+SoaS1gKrZQTraoZZqIqpIDshlG4z5jdiEo5m2kEwNj36j1erB2y2K4XeH33
	 NphrR5rivbQd2661J/4B7ZI90eMmmLvbJsCpGKAWOkqOVkBiXA/4vKMoxqHIRNvCIdj0m
	 7Ky7UXVIicv5VkhnLDuPFBAQZdSQDthjY/QX/qZHzCL5Wnpjd2Mq3tr0R+5Xr8DP41I2o
	 r8fHKPhy0t1MIBfOzIQtyZHK3ALWEW3H9NLZTEBsOyYyYs7dy6Hu7+9qUaj3q9LcfXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793861997;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P8oPMxRi0C+y7+s8Ucrb18ZUc5gBO7WLR8HMHXGtfkE=;
	b=yhwjZ9UK4zoVwXmzydek7Wv6gghMABTAxvqRWH3w6504geBZNDdMBNm5gH9/NI6dq5gQ
	 6zKZXZJ38xnjtMpA73X3VePbMvh5yZrU4nzhJ24+waNB6K+RYF16xRqSUrwBWzG9Ewah0
	 hsAtN3pHOA9ZnWQsVuIBoWpUMOVeWAWp8R72RrmRxPdbpQs/iqPuHZElGwELDSW+zDYol
	 wDae6WwedTLnCw+hfcj7NWb2E6VlAtFXE9/Wp3Z6O3zJ+ukyL9bt6IUXkpR7K9B+lEbm2
	 Hmdut5gGychSICNleQZJwXf/Vpl1qaYV8I4BkgFZbnhJoIK1tqvQWSDqVjuxSnmedSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MtKY1LlG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46852606A336
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 06:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MtKY1LlG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED201F00919;
	Thu,  5 Nov 2026 06:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793861996;
	bh=P8oPMxRi0C+y7+s8Ucrb18ZUc5gBO7WLR8HMHXGtfkE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MtKY1LlG5cisf+DjPncIXaYkrVo+t5DbhJN8yly25w/ZoA3EtOwFlBNIZf39vkej3
	 IMLZu6iMjD7kA8uu8+Zr89J1iJUNZSq3xvNafhRshZP4ND+NXI7sIAwZ5GmiFfYgrO
	 ocJV0Ycyw6Aej53a0MQme2XB6G1L72V8NCUJlFzAq4shioFVaIW0lW9IDSaG0husq3
	 O3dUvnWejMs/kR+kt50tGtao/Q6LW1Js8zxDTH5b5XyLCD9oCxxxyWqXhzy4YxyQWJ
	 nUgQK3qlGKhUPz11t0T5d4xjZfph9J2t3gksUKzSlA1YoR2kG8Yq8tcOATSPCA/R98
	 dEc8pkPT1XhSw==
Message-ID: <sashiko-outbox-198642@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf machine: Fix NULL deref in
 machine__is_lock_function()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gu Bin" <gubin@cmss.chinamobile.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105064958.2134-1-gubin@cmss.chinamobile.com>
References: <20261105064958.2134-1-gubin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 06:59:56 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> machine__is_lock_function() looks up __sched_text_start and, if found,
> assumes the remaining scheduler/lock text symbols are present too: it
> dereferences sym->start for __sched_text_end, __lock_text_start and
> __lock_text_end without a NULL check, under a "should not fail from
> here" comment.
>=20
> That assumption has already been broken in practice: on s390,
> __sched_text_end shared its address with __cpuidle_text_start and
> was dropped by symbols__fixup_duplicate(), causing a SIGSEGV in
> "perf lock contention".
> commit d8d85ce86dc8 ("perf lock contention: Fix core dump related to
> not finding the "__sched_text_end" symbol on s/390") worked around
> that particular case by keeping duplicate symbols via
> symbol_conf.allow_aliases. The symbols can also be absent when the
> kernel image has no lock text, or when the symbol table is otherwise
> incomplete.
>=20
> NULL-check each of the four lookups and share the existing failure
> handling through a fail label that records the "failed to get kernel
> symbols" state (machine->sched.text_start =3D 1), so the initialization
> is only cached as complete when every lookup succeeded and later calls
> bail out early without retrying the symbol lookups.
>=20
> Fixes: 0d2997f750d1 ("perf lock: Look up callchain for the contended lock=
s")
> Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105064958.2134=
-1-gubin@cmss.chinamobile.com?part=3D1

