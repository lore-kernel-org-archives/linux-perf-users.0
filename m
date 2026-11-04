Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818620;
	b=X9Djeh06yYioyH1RfLUzDqLHB1pg1L0EUY62pQcqrh1OVJlSvB6wFyS0Icy7dt5w4+uo
	 jpz5fyZmn9yvkPqFli1Kxi2XCjV/eeCCJaNNXk6iP69lJCxw+2cvr+TwmKg++EsZlaDW9
	 fsgyiWsFl/HhaKU0maCnvIv/UxC42h7bSH67hygT5ACHKIMf6GbO57gzzWNiFk972Kbyw
	 ETXwKUxFmjd28e9yt9865sQ5z+NU4kFQdGCAgk8w9NQ0AZBB9vLEm7FPagHiC21x3qPmQ
	 oBPv1vxdt41YLDxtR1vrfK9jMW7FMB+wSBdRu4dDrpbMVhgFNTCLpGOVJRzSn8hitIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818620;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=whbehQ7fFiWa/uL9ViBd+pafTrQYUqPHQQxoVjyW650=;
	b=OPXvfoRo0LhiU9htylf/OXA5/hq+v9Pdc77lrZJ7zMOngqsXl6IGQAxNU5pztvOryTF3
	 ePHxJcQgfd2Srd9iGawIKh5jlKC3QbnF7dA7fZ9UZzSQielNqCsQo4NEfX/fexYvIpGdE
	 6ctCEqd6cBY5wMB0/s5Nq93GxL+axCT4ONxW2zxoWViGr3dy/j621PU0DdR+eg2P0NJ/X
	 zXs61cZCiZfoo5QWdD2ToAK/AmVCDsvExolcqR/sr4CcUjLimC9W5lL9NWqlqNPD5g6Qo
	 tvN4SJfwlw8yk+6rXqOScM9z4sg61ddzmtOFE9kym7uCA0x7elcWSEwOf0VV9ThqmoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YKLXl0bc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2D2606D804
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YKLXl0bc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461C71F00A2C;
	Wed,  4 Nov 2026 18:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793818619;
	bh=whbehQ7fFiWa/uL9ViBd+pafTrQYUqPHQQxoVjyW650=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YKLXl0bcsJU0yQ2kRvO6bcab9/RbYW99wB6LH4AhZcO+ukRwVwJzHBCVId/nx9fUX
	 m6R9VNC9yyc4RZCZ1VoUbolQNJJ803gD+gCACUt3g5sBdsUNRlqjsrNxvJaUthI0W7
	 wAaw+f+SbPlpKH4pbfM9kVrRkIBmQckjy6UIASroWpjIUXMFF3/SR4WS46UsM97joa
	 HTB7zrPSE4zmyFOXXlWFWPVHO28PQQcD22kHfgysoxUjTMmxgoZ45ANJILeV0lJlnU
	 Fs0CmQJ70S5Z6ObdG78kvf5vhl6GKvh0vnC8JyI9SyvyIntLApw3uhD150DKidiot7
	 lzRX6Zq3QiDIA==
Message-ID: <sashiko-outbox-197894@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/13] alpha/perf: do not report user registers from
 the entry code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104-alpha-profileme-v6-4-63362e9290a3@gmail.com>
References: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com>
 <20261104-alpha-profileme-v6-4-63362e9290a3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 18:56:58 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-alpha-prof=
ileme-v6-0-63362e9290a3@gmail.com?part=3D4

