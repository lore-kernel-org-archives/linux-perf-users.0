Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793935066;
	b=lcfD6Ipkj5IdJrKhINQkjy0CS3Z1O5ZE7r4YhiHzk5zpkrX66sA2Xj2qgBGQdauKLhVP
	 AbqqZPtvCofRh6SZWYzsQyQ8d9PGivB6RBEV+Af/lW6GG0rPCjb5kdnik7s2e6rNBSdTG
	 thCkBP5Yag3lvikXG7PSQ0EvdhMEAels4+bFy6CCx13TKOVs5vg0judyLnI2pH7qgEVV2
	 t/g1nxHC1lfvKN6Li6SuJtkx/VybkKCf9c5CEu1GXCb9gnEcuayQPqJLuu5hPbIaW6JMP
	 yrVqqtM546exffz33xI3G5biGllUtqPUpEnea78CvcLsUAPlTVpU4/45f0iTbvgjNaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793935066;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gQvm8PsSSWnZIwREAnueObGCqV7n2xEgO4V5Xel8Cqg=;
	b=NioSQ6XQB3PYdC8YsKPkQU13sveY2ausva80iLiN6+y+34p20uUcMoIKB1LTl9F7Fzb4
	 yT0bAZt2ILrXlXsLqCaNtjVzhCBjoZvoiLiEBhrW7IVcV75PUP5//cHQFYCTBONRVOznt
	 XbapmHu0uZm2t5Jtyqkj4DLYYEJc92g8fWbTyUqOY08JL0W8mCDu0uhDZ+i2BZbimO09p
	 yxXgu8tWluDLDPrFyCsfupRv0UfclGAAgu52lY0c2fvbEkAKp3JEfcx+N44AkClE4HtDE
	 9YpJJOOdoQEc/UmUoi25A6nVRblaKY/Iz7fvUejfIz7x79vmV2x8DW+PeetcS5qtWnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XjRIGmdd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E2B606A31B
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 03:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XjRIGmdd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022CC1F0089F;
	Fri,  6 Nov 2026 03:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793935066;
	bh=gQvm8PsSSWnZIwREAnueObGCqV7n2xEgO4V5Xel8Cqg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XjRIGmddSKbEDwRMJLxNR8dOqzZ7H3zDa+GUIaxxO3EJfsvqJvla0/uHIctsmJ05g
	 w5n5CJkP4zSU5Zgia6Q5JhxxHcwzi+bkB4GoVz/RaZYDm/CDxlPH8rCe5NIu52d72E
	 ksLaY4qltcJqHIBgQT7dETUxjAUPY1MBB4upH4KYc6JQIzILMJMFSnSus/5kPIi5YU
	 ouxBH0f5i15b9Bh1owRrvd7+D5pEqSsuPhFYW+u5qU7wlmpoMxw7Ak6Ltt8X5pnpsa
	 H4f/etCnatDvSjWyQhTBcZndMjj8B550JVracXPh87yVYmQe1lxnaCfzmBgdgNoleI
	 uaM/Gtrm56b5Q==
Message-ID: <sashiko-outbox-200641@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/x86/intel/ds: don't WARN when the BTS buffer can't
 be allocated
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuehong Wu" <wuyuehong@cmss.chinamobile.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-perf-ds-bts-warn-1-yuehongwu@cmss.chinamobile.com>
References: <20261105-perf-ds-bts-warn-1-yuehongwu@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 03:17:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> alloc_bts_buffer() asks for the buffer with __GFP_NOWARN and then WARNs
> if the allocation failed anyway.  The failure is already handled: the
> caller disables BTS for the event and releases what was set up, and
> perf_event_open() returns -ENOMEM.
>=20
> The WARN_ONCE() came with commit 4485154138f6 ("perf/x86/intel: Avoid
> spamming kernel log for BTS buffer failure"), which added __GFP_NOWARN to
> stop the log spam of the failing per-CPU allocation but kept one warning
> as a hint.  That hint is fatal under panic_on_warn: on a machine with
> BTS, the 64 KiB buffer allocation can fail on a memory-constrained
> system and a plain perf_event_open() then panics the kernel.  Since the
> allocation explicitly asked not to warn and the error path is fine, drop
> the WARN_ONCE().
>=20
> Reproduced on 7.3.0-next-20261027 by making the page allocator fail the
> order-4 BTS buffer allocation (fail_page_alloc: min-order=3D4,
> ignore-gfp-wait=3D0).  Without this change the first perf_event_open() of
> a hardware event hits the warning and, with panic_on_warn=3D1, panics.
> With this change the same allocation failure is silent: BTS is disabled
> and a following branches/period=3D1 event returns -EOPNOTSUPP, while the
> kernel keeps running.  The buffer is allocated per possible CPU,
> independently of any specific BTS event, so the failure path is
> exercised without BTS tracing.
>=20
> Fixes: 4485154138f6 ("perf/x86/intel: Avoid spamming kernel log for BTS b=
uffer failure")
> Signed-off-by: Yuehong Wu <wuyuehong@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-perf-ds-bt=
s-warn-1-yuehongwu@cmss.chinamobile.com?part=3D1

