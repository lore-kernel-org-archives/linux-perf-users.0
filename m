Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711675;
	b=D+/fynduB00AY2k/aWgSCo6O2dHwbAtXv1iNQMzvGpoV6YZJjitYWxDNU1lT9beclQCO
	 y1jtsML8P1oY5v7ioqhdn0F1tcySAwYQZGuMSRiTrI28kmTcFvuzlJS8CLEl9YlB2ABDp
	 T7T7ITJ+dneG4s/cgtfMnfFClJlsLp9J/SPQjHj9423VM6V5EV4+qAURJGU/XzLUA2qdy
	 7HdHrshxptvWW9ZgNEjDJj79ic3MKQl7wWg2J7nB0HHUPA/vo8+iUx+Nj6lQ2iwl5LG3f
	 +NO3bLyGtK3FgZI+2uYnHwwBHcV7Pn1GQWoq072xnk7pg0V0MUQxsE6iOiVIlOKC8MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711675;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PXv5ag3ZwYu1TcyAumwAfRA8Pm31jkv8qx0HgCkQ6hg=;
	b=EYLRa2gFyl4R7jNajEPoOdytxESNkrymfh/5Uo7Y/dnbKkjbloZtaGUfTFJgU1oa3GjK
	 2SV5rfnihYQU8QbquO9BDVCtWLPk0wmbNctaNjc0Un8+CHu52Bh2mDUkqvSJNwmRVgpXQ
	 BQqf0wRcmzBejtK6eA4elwZy+j/lnJzyIPRRsf2s56FxnGsyoZFs1TBLzh728BvuAJ9VZ
	 OgCd4M6f6agbh9w/M3CDLTTnVfl8ql+yRe7jDYeQHI+lFfd+6Cdn4lXU51ZyL2kET0EOh
	 hU37TAVCVtav6NZVaK5CHTCSHZbfWJYTDMvxDljmmSLMgjciPBrp1s42UzH944xKV7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7hFUTP5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C164D606A328
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7hFUTP5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428231F00919;
	Tue,  3 Nov 2026 13:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793711674;
	bh=PXv5ag3ZwYu1TcyAumwAfRA8Pm31jkv8qx0HgCkQ6hg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O7hFUTP5LOqZTJZrgOFuhlIdTqhCaXkhITidZ/mACKy4WYqqeZfEhNNcr+39Zqubs
	 X3bgcHKKEyO5YaalBeMa5PGxbymVgBqqKalB0piSmhGppxc3OkWG5ywqhYipfFQFZF
	 p8KnbgVFq2eEiJgKEbBmzL0p8BmKN4DG0JNRWgUHcHbDF5ZY3kDW004KH7hCicLgeB
	 oD7S1ccMRuFyPHCB5K+6vohRvB3SA3q1vAN3FPNeoEnNQT5wPQYFEFVHg0Mxxd7GCq
	 sAQoEKAGCpv/SSO7tLAqXEYkkgpUtIW96CSvIlFyDeUyh3t4IizdtytPelBltYoTWt
	 vTg5Gdzg3uZOg==
Message-ID: <sashiko-outbox-195313@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] tracing/perf: Clear stop state in perf_trace_add()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bertinetti" <paolobertinetti200f4@proton.me>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103130732.764081-2-paolobertinetti200f4@proton.me>
References: <20261103130732.764081-1-paolobertinetti200f4@proton.me>
 <20261103130732.764081-2-paolobertinetti200f4@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 13:14:33 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Since commit 18dbcbfabfff ("perf: Fix the POLL_HUP delivery breakage"),
> __perf_event_overflow() stops the event with pmu->stop() and disables
> it when the PERF_EVENT_IOC_REFRESH limit is reached. When userspace
> re-arms the event with PERF_EVENT_IOC_REFRESH, the event is enabled
> again and pmu->add() is called with PERF_EF_START.
>=20
> perf_trace_add() sets PERF_HES_STOPPED when PERF_EF_START is missing,
> but never clears it. The flag set by pmu->stop() stays, and
> perf_tp_event_match() drops every later hit. A tracepoint, kprobe or
> uprobe event re-armed this way delivers only its first overflow. This
> breaks self-profilers such as async-profiler, and the "Event re-armed
> with PERF_EVENT_IOC_REFRESH" perf test fails:
>=20
>   1000 events, count 1, 1 overflows (1 POLL_HUP), re-arm errno 0
>   Tracepoint event : FAILED!
>=20
> Set the state from PERF_EF_START on every add, as perf_swevent_add()
> does.
>=20
> Fixes: 18dbcbfabfff ("perf: Fix the POLL_HUP delivery breakage")
> Reported-by: Francesco Nigro <nigro.fra@gmail.com>
> Closes: https://lore.kernel.org/r/20261021131006.2101248-1-nigro.fra@gmai=
l.com/
> Assisted-by: LLM
> Signed-off-by: Paolo Bertinetti <paolobertinetti200f4@proton.me>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103130732.7640=
81-1-paolobertinetti200f4@proton.me?part=3D1

