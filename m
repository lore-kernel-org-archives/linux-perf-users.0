Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079814;
	b=3d35wnIeMzyNWnNJHLLnqbpA/lYMmHl2cFtnM0E3KIBVTDCZKY42aHJp3TBqeuBUdg9w
	 xsKiTlendzyaOKmmnJ8yN/R1p4mqTV8k3Pwuw0S6wooj6UnjKGzEjR0nrUJ7WROy9C1Y2
	 DRHNOgT05gtuRNUBX7pp6GJoL7gFyyD62HJJKodccl6GqdlWOOH504o3i1d94Yp32LWdZ
	 iN6fUFcR9QPIw9IrOd7KXZJynZbldEDMN4GIR739eBH68k4AuD7mKpJEOhmbckiJd7c+x
	 Zra5FYq76KUbFSk8Yp/o6NYMICDHC8MLMOQaQo6slmISPDTV6qUZQ8AgZbjnyyQfCzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079814;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NFrMxTDi09PxgPkwTYo98qIfNK/dJUFJcQg4/8Ze1yU=;
	b=rTkRb3SQzfHQ/lIUyafeVH1qxhd4kEmheJrrFXfg5RYnc48Jcqwqxw3yWLl+va9gcPG5
	 APDAD1gRmJJM20feP8udaHh/dI5ywYgbdAV18laCRg0NB/MxwW5SrqZRm/dSs6nIib06G
	 Cj/B6pQof7qeBBc6vGkWduJFQPFVsJBWvBq+qZCMHHOdSqhy0jrU7iOOA+oeKqTN3dN3P
	 Js4yWvRKy/G1oYjrGK/ZBPIiSHOIOYQAYCjhbQVLmJiiUV6QEsjLGClhdbLW3eK0VvGXP
	 JmCz9NLXsMvRqQn0uBd/ESY8geKJtHqS9zaFbkNNjeqJlMuKiomEuWxwTZChYTYeFdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YG/q72PR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3A3606A324
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 09:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YG/q72PR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE21A1F000C4;
	Thu, 19 Nov 2026 09:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795079814;
	bh=NFrMxTDi09PxgPkwTYo98qIfNK/dJUFJcQg4/8Ze1yU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YG/q72PR+ChiuUDOh06nxzlena0ROhgfOHXUr0Du2Mo3xGo3FdZESbzTZ/MC27aQM
	 AyMHeO8zj0ejHYm46E3Va9VwyTtK1ry60SfKm6Us4DwFaS6E1C128SvFrjzzs2QU7n
	 sw0LLuKOkBhXOdJ58jZiAMyvIJhx8lirngN0E2Oxkmg0HkZOlf7oPaec378UlBc761
	 DKch3kmMZM/Cdb4GpIu3aD4ii8kTCKNr6rQMhP9WBfpAHQAzj2aC048nGA/w7KBvL8
	 e1FkRxlgGAdr5vtA/U0ofEBVlpgdTw7cUQkoSVZTt4jQwHY7gG6NECZbHTVekwBO2s
	 SaDjhTMgjZJRw==
Message-ID: <sashiko-outbox-222806@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] perf: arm_pmu: Add workaround for FUJITSU-MONAKA
 Erratum E#030002
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tomohiro Misono" <misono.tomohiro@fujitsu.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119-monaka-fix-for-upstream-v3-3-057df4d2ca3c@fujitsu.com>
References: <20261119-monaka-fix-for-upstream-v3-0-057df4d2ca3c@fujitsu.com>
 <20261119-monaka-fix-for-upstream-v3-3-057df4d2ca3c@fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 09:16:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> FUJITSU-MONAKA Erratum E#030002 affects FUJITSU-MONAKA CPU.
>=20
> On affected FUJITSU-MONAKA CPUs, after a PMU event counter is
> stopped at a value just before overflow, an overflow might still
> be incorrectly detected, resulting interrupt storm in some case.
>=20
> For example, if the following conditions are met:
>   1) Running perf to count an event in user space only
>   2) The event can also occur in kernel space
>   3) The counter value is set just before the overflow
>      (when using the -F option, initial counter value is -1)
>=20
> when the kernel is about to return to user space after enabling
> the count, an overflow interrupt is incorrectly triggered by an
> event that occurred in kernel space. Since the counter value is
> not updated (correctly), the interrupt handler does nothing and
> returns with the same condition. This leads to another wrong interrupt
> and results in an interrupt storm and eventually a softlockup.
>=20
> Work around the erratum by avoiding programming PMU event counters
> with values within 7 counts of overflow because the counter
> can increase up to 7 at a time.
>=20
> Signed-off-by: Tomohiro Misono <misono.tomohiro@fujitsu.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-monaka-fix=
-for-upstream-v3-0-057df4d2ca3c@fujitsu.com?part=3D3

