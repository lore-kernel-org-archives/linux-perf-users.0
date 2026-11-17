Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942205;
	b=0ayXm4QsYDRcAor8HMQsgjNLpR/HgfVRjbbq4hJmSf720OMG7JOjppL9DXnYemnlynaR
	 boked3BIL0HKSmliny3R+fgUdbDcFMrdo71o8fwYI6KP5rLNq83WaFWoKpf2svcGaP3H1
	 kdU75NLEm3rwBRlzrxNHAo8JWM6o0mEip6jahAOllY3zv5+urADZe48DsVHJz+iRR60OE
	 pZ4LeUJGzhr3t28XS/eVoVgVwQROyxCjfbenqMFH0K9hE439zeMN4On7gP70wVdV7E7IB
	 vS9TyIbfdOw9UGECfcHAdLTKRbwKasou+DOuOqpowLfbX9SpiktUxN24IAf7ILZhlkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942205;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=15rWXZqjr3MwvjItuXOcJNA2fHoZMMXoO5BTB8vqRhU=;
	b=Hhr63D/Hv0NaAlYenzPtKjCUN2dk9DWCxxRc0IVrslZsrE6q8018HE1YmYXRhp5qAsY2
	 5Mq7TYfnd9HIbgXqfOFPrOYoUO6VVnbXnM386RUFscTk0K+LmtM/t+ozYFgXeoOaTZgUC
	 6ubZp+e0pz+PpXX2NAdDbgqWHh9k7KvZT+dUsfyTtOhmBtfLuFEJIY4etR3fgaOYW1OVi
	 +3ByNohGPeVQKHSYzDb91SmebPjBmYDxMLhfYsJ/yoavLnPgwlbAO/zxFvuKVvlUUfD3V
	 QVkCIFR+qwH7IkreRaXn4aHD6gsg4GXu5o7ndw5w+wxCl8c1vhxmBMjoHu2ReDDSJqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NAEXjf4l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63978606A32A
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NAEXjf4l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1202D1F000C7;
	Tue, 17 Nov 2026 19:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794942205;
	bh=15rWXZqjr3MwvjItuXOcJNA2fHoZMMXoO5BTB8vqRhU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NAEXjf4ltgrWMz/YTvH/AHqJvPex2Lpa7Hee93bruQsKUMu1khWOZKTel/5NegeAr
	 0mGjE8NIuTGbe1D68KmYRqE6urHs6tM2ralWVrJDI8zEBmF6KSIMjUZfXIXbiV/JuD
	 4sDyO4M6K2IpTRDKOO3jwPRA+PRu8oQZa43/gkeZHm2l1OOkNQQDbL391ngRot0rjs
	 vFO4cULbXMiTbmVm8WTtS09cnVxDBddUdYt63ujAXjoXnUBqBuaoQKzwLs3c1Om5aB
	 XQT0856/slNEaPRvAbhcRYDkcD1atYEC2it30uPxlXx/b8bDkO6Ze2dRlBlL47R3mK
	 JZRw2PIB3KbEw==
Message-ID: <sashiko-outbox-219429@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 04/23] perf mutex: Use kernel style
 compiler-context-analysis.h annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117184844.99889-5-irogers@google.com>
References: <20261117184844.99889-1-irogers@google.com>
 <20261117184844.99889-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:03:24 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Enable -DWARN_CONTEXT_ANALYSIS alongside -Wthread-safety for Clang
> builds in tools/perf/Makefile.config, replace the custom lock safety
> macros in tools/perf with the kernel's compiler-context-analysis.h
> annotations (context_lock_struct, __guarded_by, __acquires,
> __acquires_shared, __releases, __releases_shared, __cond_acquires,
> __must_hold, __must_hold_shared, __must_not_hold, __returns_ctx_lock,
> __no_context_analysis, and __context_unsafe), and remove the redundant
> macro definitions from tools/perf/util/mutex.h.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117184844.9988=
9-1-irogers@google.com?part=3D4

