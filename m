Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793675216;
	b=B8Fl/m45HI4MfBb8N0V/5GJ6mdZTzuGpsCqICvl6eJg/DUNTrFXZ/5XJIszTS+X2VKGg
	 12PY2PZXw82wNoaUyt/LVMltAOKRSh0B4W1lJ35LSQNpq6xryxiHgrV0JZnBaKGcNtUuX
	 U8RVcUvSX8e+NlDFVyhxkj56eg7yXNN0WSZ4Q0a5xnpTIGZWhPY3PcciWJw/aGNXqE7hn
	 bfuruey+31WL3EMY8gpozPztnNUxldKmDKyXpwvyCXmsto/RXB6zqJhDnCv0AeTtPQw36
	 foFPUW5GJx3WF3qjjNcy6T6kAp10g12Lkcgaahr4EW9ptkZDU5wMAvq7zBawpqBEFIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793675216;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jZLWLqRhRtkegqRKyiqKQUk0Xyka4ILUgv3luuJ192Q=;
	b=t2x/S7jwmwugDPokMADE+EU3brgOz+cGZxg5MkV+rKobukV584xjThyvv6/2CpJeg5JG
	 W8wmazb52CnX4vfJUx0h3MqJ197+EgT7ohniWZUXIXiNSQ0NbnrIJcebQLf5q6tyq1gtO
	 FBKRVUuX2EE/bnu6DX7OvhxG2SnyqeD3eZVXP5RunRn79eWK5OlD3RLRf+wzSGTX/oSUK
	 CR5aLQ+FzQL5usUPAzcdPQ8/0a9D5PMJBj5h4P9B1cW3cAspzOGs6TS8Xgy6US3qAufEu
	 IQVhm161W7XXX6RaV5Jvxp8/aCchcbsYD2UGe7JNj6iyZn5xRFQFO0DY4yt4u5q0aGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qwo69olG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33697606A326
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 03:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qwo69olG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97D81F00919;
	Tue,  3 Nov 2026 03:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793675216;
	bh=jZLWLqRhRtkegqRKyiqKQUk0Xyka4ILUgv3luuJ192Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qwo69olGlK48xWKixLimczxoNJBHyWxhUUd7vT1LnbD1Vt2cPTmBbPbr8oqwjcdaC
	 b8Nh5KbGhRSBkf7ecqQ9TYIkuH6Q4HkiaIt3C7yr/VE1VSq3JotJvlUj4TPOLDo9lC
	 Mxr0M3X+wOX51fRqoZmzBRg1OUhu2iZXWqXVqAGfkRfsEWbAx4vQY4jvWaJ5xcogLC
	 nVXlRdq011R16r9swVs4v6yK47Lp0iMsT5kWAuRu9zsI6glate6OnSatBGWMy/O0R3
	 Xs5hKXq+9dK5U59oCFQXKBB+z3t8wGy49dWrDkP2vcByaC4ob14LbdzHdVGJM8Pmsa
	 KELckRXuxBQSQ==
Message-ID: <sashiko-outbox-194491@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/7] alpha/perf: clear PERF_HES_UPTODATE when an
 event starts counting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-alpha-profileme-v4-3-61e00f5e1da8@gmail.com>
References: <20261102-alpha-profileme-v4-0-61e00f5e1da8@gmail.com>
 <20261102-alpha-profileme-v4-3-61e00f5e1da8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 03:06:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> alpha_pmu_add() sets PERF_HES_UPTODATE and maybe_change_configuration()
> then programs and enables the counter, but nothing clears the flag until
> the first alpha_pmu_start(). In that window alpha_pmu_stop() with
> PERF_EF_UPDATE skips the count update, because the flag claims the count
> is current. Since the next reload rewrites the counter, everything
> counted since the event was added is lost.
>=20
> perf_adjust_freq_unthr_events() does this on the first tick
> after an event in frequency mode is scheduled in, which is the default
> for perf record, and it then sees no count to adjust the period with.
>=20
> Clear the flag where the event starts counting. alpha_pmu_add() cannot
> do it, since the event is not programmed until the PMU is enabled, and
> stopping it before then must not read the counter.
>=20
> Fixes: a4eaf7f14675 ("perf: Rework the PMU methods")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-alpha-prof=
ileme-v4-0-61e00f5e1da8@gmail.com?part=3D3

