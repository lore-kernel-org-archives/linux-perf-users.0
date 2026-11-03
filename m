Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711572;
	b=cXMScYLNeLiV0ew+DfoPuPUK8W0iGWKEDazA2PMubrt0bv11DzA3g+zVvsIVHkEsuuGR
	 kYoJA3rWnb4JMEEFRoT/j1OgOz6e+bbLiGxIR8syc6pm47i1hRtfjq26W0Qs1HhyLU+zp
	 TiqyFN2n5OLvUnHZCwCSvkMNtTClgRkXKoDJYZlBbIJbsissP+/R4aoYJ8zWVygLTE+f5
	 ufByQ/FFzwGipYV0iKC0Fszt3CZLu2DpnFcS5CEzcjxAHbJHFnPjI7nyVRcuW2tJ4hypu
	 zOxuIUUNic3Qi7x38Q0f9loQy9rSsNuUSpdb83Ke/rP7BD8ozhEwksqx3jwZaaMSYUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711572;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4oNiQxgT41ifCTjro4DXxsAy9ewbEyz94U41drSnL8I=;
	b=3DGIW7ryqHy3Lo3kVO6F1gQTMSXd2vsrWjHpZIGedWW51MK5jpBAWvKDza/cyVTlR7dT
	 xYBeb3zWVuqdIuzBWYUbdnYfSn+Hy6BXfhiYJ8xdXKS4tJU7OrhK2YZkHHnWbvrFG4LeZ
	 Az5RTWNuRsk/1f9PE8eCEEIL3/HJKN9CvgOE0JGaMtIH61u4fOneFJrPhWJdFMBt0zKo3
	 9hMiTI7xktrRd1wGLBS5QWps6fRwb4yV8zXwN+ajT3QndB7sThbsaNY/G0FSY8Ktriz8N
	 leijXS1JlwDtbycymUwa0VUtshdpfb+YR6oCxMf2OcrFAqgWfRKc7YiNeLg/70q9ogQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k0y8RRiw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C2D606A324
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k0y8RRiw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9321F000C1;
	Tue,  3 Nov 2026 13:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793711571;
	bh=4oNiQxgT41ifCTjro4DXxsAy9ewbEyz94U41drSnL8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k0y8RRiw64b+GZy67ifsBhsjA5qqy3fVSuIjGtj7pO4o2hxhIt23D0QoJ8eqpWIKO
	 TOYggye50hEL2ii82OKiPz8ZyGCRWH0+aQvl0WnLwiI7Lgv5DSjbAgsaeuaoo0NhxA
	 EuCAfCPtn5qCfruMUjPhP6dLXDhYZxuHADKObMyOn2n4RjmruJi8Or8mmIi7mEWJ89
	 cmv/Miv9GUOhjMW/Un1IatM/5bawMDKokF49Gjc5ubr9GWFhYZJcZNZrX6qXOLlX6M
	 gdouxAIsdA/HdVLg1VsvJJkx9XWXIEzncRkSJyEwCDjlYqyrk65ys+UoiITEw8M3V+
	 PRWPHuq0t3l7g==
Message-ID: <sashiko-outbox-195311@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf/hw_breakpoint: Clear stop state in
 hw_breakpoint_add()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bertinetti" <paolobertinetti200f4@proton.me>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103130732.764081-3-paolobertinetti200f4@proton.me>
References: <20261103130732.764081-1-paolobertinetti200f4@proton.me>
 <20261103130732.764081-3-paolobertinetti200f4@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 13:12:51 +0000
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
> hw_breakpoint_add() sets PERF_HES_STOPPED when PERF_EF_START is
> missing, but never clears it. The flag set by pmu->stop() stays, and
> perf_bp_event() drops every later hit, so a breakpoint re-armed this
> way delivers only its first overflow.
>=20
> Set the state from PERF_EF_START on every add, as perf_swevent_add()
> does.
>=20
> Fixes: 18dbcbfabfff ("perf: Fix the POLL_HUP delivery breakage")
> Assisted-by: LLM
> Signed-off-by: Paolo Bertinetti <paolobertinetti200f4@proton.me>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103130732.7640=
81-1-paolobertinetti200f4@proton.me?part=3D2

