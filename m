Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795555358;
	b=qHTMaoWfKibZBOXAZ+14XIT+SbRt7fwyER+fbz50l2xdaXgAuLp1QhtyaHnW/TXWS7yv
	 sUFCceL8XdtR2RwHZIx2f5N5zpEok1sHbkQpw5qarHE73gHhnH/cFpOyLZEbOA2ldV51t
	 ibj6UFGfoE9J/xSBX4JJzrSJMUPEDPbrMOIX6J5/DqVqVhH4FLWW8r0ia4dqGFB0Jb1l1
	 39MAw+A739JuickUhhxIIiDy7sgxgRuJeVj8An5hxnWCGdK3+JYXKuB5o/w1Q6gCb9Vwe
	 yNiYEv/LWJK/y/nSDHYOlcty6WET4RHLBuftAocn3gji58KRIKbHCmrFsMMPjjS7wqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795555358;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U8GP36S8Pf06Z4jf1MncWOxXMlI3E5JtneCV2D5Tbw8=;
	b=vl/KuBkscnnZO0+3NmNsyO/9pOYlQ2DKwki+A+7Kl9kahXElWTk4a3SiX6rfbohbwulj
	 Y+o68GkpfKjKtC8qDwyURstu6o7n9j+jiVuKCQhisz57e3nYi4cFGLU7j3JktszkT6RRK
	 NCY/af1MtUZ9Ll2C+C1vdndn3k1KbOvwnkzLZ6B/9iNnIZHHmrc8KTOHzEKkMPOPWE03X
	 H9OtyQIibbMMgA4+7qjbAWaOJAXvoCQc0ZrpoK5dCdejMSSeXUXEWy8QHMSzZ5R+lGCNF
	 WEmaWZNPs4naaviZp88WiE5GH0bV864kH3C42TC8srA70WC1hqP8uvI6FMIU4idYFlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BRe3CMOd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026DE606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 21:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BRe3CMOd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E4F1F000C0;
	Tue, 24 Nov 2026 21:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795555357;
	bh=U8GP36S8Pf06Z4jf1MncWOxXMlI3E5JtneCV2D5Tbw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BRe3CMOdHXXHlYXiwc7etP8c03psUM3dCvFviFAMrlBR7Ul9qbvhj/ExLnQXuwXiX
	 WTCiVORXSZhjwNW2MYQZEBvw/wIvPPyanhQwQ2mdvYu2VvdtVYU1EB+lbKH4/glQJJ
	 PukIeSd15eUXkYzWw1xizdmS0LJ4JnMFNNsXpYJmdBLX3bRwCB5MTaPqoRdG39rpd2
	 CDgFl5ghBWjpcVzny3uUU2mmp5CwMhymgajyJsk3ceWMNRN/F7wXMCp5S9md98jogM
	 C2UYDCrlBudN+/HybSrrUBP4g73PnLcWu8RaU9s1vKWTPcNdQvvJ1wiMmbyw73ZAPH
	 FFlPJxJsMkukg==
Message-ID: <sashiko-outbox-232039@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/x86/amd/core: Handle overflows of counters stopped
 by a throttle
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oancea Catalin" <john3@mailbox.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261124211146.61378-1-john3@mailbox.org>
References: <20261124211146.61378-1-john3@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 21:22:37 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> amd_pmu_v2_handle_irq() reads PerfCntrGlobalStatus once, handles the
> overflows of the counters which are set in cpuc->active_mask and warns
> about every status bit which is left over:
>=20
>   New overflows for inactive PMCs: 2
>   WARNING: arch/x86/events/amd/core.c:1031 at amd_pmu_v2_handle_irq+0x86e=
/0x9a0
>   Call Trace:
>    perf_event_nmi_handler
>    nmi_handle
>    default_do_nmi
>    exc_nmi
>=20
> Throttling stops the whole event group, so perf_event_overflow() can
> stop counters which the loop has not reached yet. When both events of a
> group overflow in the same NMI and the first one is throttled:
> [ ... ]
> this patch were produced with an AI coding assistant (Claude Code,
> model Claude Mythos 5.2).
>=20
> Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
> Signed-off-by: Oancea Catalin <john3@mailbox.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124211146.6137=
8-1-john3@mailbox.org?part=3D1
