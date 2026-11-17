Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794947830;
	b=Hi5Cy1HWY08DPGd2flsz/Jckm8IE9DaBiBclb6+4yV8CQ/gerKPeKrrF5H91Y1/D6a3D
	 hJxXXFWpIj5mtWNzyWLOni33QnldmWIFMJD3TfUxWeguvwxibF1gZV4IZrdLDI0GTIAT2
	 zEzpic+M3teuWX/vsiCsxlfxD9VgkYZ7EdcgYkPHuyB+ubpg4TNWrTxhF0JnFxhDMdOE1
	 rGdNQo0rwDnJed9KoE/10pZxwkCXsoR/kd2K3Wyx75xPUNzxhugRySWCqRLqEPu4zftx1
	 z1niaVv/HuBo8BpGPye01Pt5bVlAFteMuFZw83OQGmbP9J1QarnYPkyfyFIAfXR8U0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947830;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yKwctNbU1CsQmfXnH/gPuAbYAbeq8KMZaxH1UjaNCn0=;
	b=Q7c04CH0b4+HBHpMizJAAE/27fU2zy6OJKyq/hEZXErzz7RkHv1UF7+Pyd8ggpSYS34z
	 b0lFW27e9qRLEcy+ZprKcdPhHiqUH83kpi8dTdlXRIKRWWgGzicCRFB8r5RmUUSztpzgq
	 2lOb12WkxfCTxzD2GL/8uz9nWByLDe6WoLdMzXtseB5QEInDADK2vuMXhywrnCZ+Zwc4N
	 9SjmQwdwhM/uACWzO6yH8NIIsljWpaxYcx6fvgJ9QYb8iQf5KpkNuZ4YuGunXsKYslfzt
	 wZmStqfVUg9kOvzeheKa9d6lOCWWLhOqICHXmD8cFwpC6QL9Mm0FerEeTlqBRxzvGTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S07yKI+c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE871606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 20:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S07yKI+c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2141B1F000C4;
	Tue, 17 Nov 2026 20:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794947830;
	bh=yKwctNbU1CsQmfXnH/gPuAbYAbeq8KMZaxH1UjaNCn0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=S07yKI+cl5b14F/15WtMNghYWVzOZP+CgKPEpynTexJtxoRfqFLGrqNSYwxioAu0J
	 hXxvUNftkAsmRzEs4Jen5v0Q8/g9/w8wI+ES0UYjuXaKqDWkaU2y6zjVMChUUCiR8c
	 49h5qiay/DT9Bj1VXO36ndvCseaHnm+8dB7BkKOqVq1UmF9FnBu1YxCemoa1+bU88k
	 g8XArAxGaKQaoB0Se7MHPnEy2BfE3KdI22sIf26YyjYpQiXBF9HSHEMT8SJMpRdUV4
	 h6lw/oxytMxFB8ZPI6Y5Zi9iz6e+3FiZVZgtMCNcMhMaS0MBDHIUObZgcB+9BjHQSX
	 6xygxBm+nMArQ==
Message-ID: <sashiko-outbox-219630@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/core: Use the elapsed period for frequency-mode
 period adjustment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gregg Leventhal" <gleventhal@janestreet.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261117152351.1294050-1-gleventhal@janestreet.com>
References: <CAFN_u7G94CC_RGL1La66jX+jRKHSJdAB5PKkTRSWrUvqhM48oQ@mail.gmail.com>
 <20261117152351.1294050-1-gleventhal@janestreet.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:37:08 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] perf: data race in __perf_event_overflow() [1]
--

commit 3821f44b0f2d83639af791a4e85517a4c30f74ba
Author: Jay Hilton <jahilton@janestreet.com>

perf/core: Use the elapsed period for frequency-mode period adjustment

This commit passes the sample's elapsed period (data->period) instead of
hwc->last_period from __perf_event_overflow() to
__perf_event_account_interrupt() so frequency-mode period adjustment uses
the period of the interval that just completed rather than the newly
re-armed period.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 614f9f0e65005..5ce85180db7c6 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c

[ ... ]

> @@ -10912,7 +10919,7 @@ static int __perf_event_overflow(struct perf_even=
t *event,
>  	if (unlikely(!is_sampling_event(event)))
>  		return 0;
> =20
> -	ret =3D __perf_event_account_interrupt(event, throttle);
> +	ret =3D __perf_event_account_interrupt(event, throttle, data->period);
> =20
>  	if (event->attr.aux_pause)
>  		perf_event_aux_pause(event->aux_event, true);

[Severity: Critical]
This problem wasn't introduced by this patch, but can
__perf_event_overflow() hit a data race [1] when reading
event->aux_event for aux_pause or aux_resume?

When a PMI fires in NMI context, __perf_event_overflow() loads
event->aux_event with a plain read instead of smp_load_acquire(), racing
with concurrent updates to event->aux_event.  Passing a stale or
uninitialized pointer to perf_event_aux_pause() -> ring_buffer_get() in
NMI context can dereference invalid memory and panic the kernel.

[1] https://sashiko.dev/#/bug/linux-3357f385-bcd3-40bc-a0de-f4f4d883aff5

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117152351.1294=
050-1-gleventhal@janestreet.com?part=3D1
