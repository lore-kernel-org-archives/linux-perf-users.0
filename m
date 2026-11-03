Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711628;
	b=VOo1RSHsyTrkvbPQvTEUfEYBkdMV56t0XR14YvznMoVPXB9Lflw0VpM7UphfQtb3Hn6f
	 s/YccdlTlTYBgOHbF9tYEQYsSxOzYt0G+13iDHWM+PUR5g+P3qzpe+aY/23J9SBJaAWXx
	 NhSzVJ0ALKm2qbqooObd0RPvipkmE4yVguxxGfmZ/IiUnq3kzrVh4XBYG931nKdXWpgqz
	 TKds2O8TS6CciRzFluNBJ+wtOgzrFSro8g4BQxzBcjtVGEYJzByYEepjdNOAP1KVrpYXB
	 CQkYhMfUfk5uiY0fJCo5Lh+WKWUahKW/ADZIfAQO70u0AeDWHGYuQa2BwGaxOOABdwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711628;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7JE6FOl2DBMZo9lGsTqE7oul6KX+mZnwCR4N2Cb3Qko=;
	b=4idj8XmjNen+K9haIEouQ1HHlApjM95fkM4+YRJsElFaVRxo0RvP0AAlf3Pw3JkliZYo
	 MFjPAF1i5zdWjJOMb/4URSMopoVkShZ7MhMQJeLrNAoousC+T9xdKG4GAwEE+DqWzDP/e
	 gVPxakRGIGNYZDsDW+WHJkLoOsI6XO2PUol8FUC70Iou60hE7VUkCIGLbyXhHXwZMKBq0
	 1XVK+xYxCdF8moI7rSWoSU7uvQytUpCRoEKetG9kZgVCVdiLrrrtOPQjqnhPbhDdmExJe
	 WDX80usKfdjYawqn4yVNCLcoCnD4qsMlsRibNJFJTXapvvR++/pCmvhB/AQaCEVvvTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SqavyYia;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B141606A326
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SqavyYia
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BD91F000C1;
	Tue,  3 Nov 2026 13:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793711627;
	bh=7JE6FOl2DBMZo9lGsTqE7oul6KX+mZnwCR4N2Cb3Qko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SqavyYiaGFSYRQKzKRPUFeQc11cJ0ULrgbGLeoJ1wb79Exnn4oHbk+wem1joopsF0
	 CqkJLr4mt4mTJhqn0KgG2otnravOFJkjnghI6inWcHv4DYC6ELb2swYe9ecSLFKSpQ
	 FDxT9JPSXc5e4jtgXs00+FjP8uTdl2kNRVGKLq0ioT16DZYRycAg17AhpFk191it6h
	 szf6Ngil7ggjEG07EhigWS1TsGsQAzBLCKZZZN2EVYc09wV0DsavPC6FPHaTNewmZE
	 QedQ4mWnhVEbYWlfKgwiOInaPlZlA0/KyhwbUxzNIB3su/yMpZZAp5f/cEcUA8sViE
	 v93R1RpP3ueQA==
Message-ID: <sashiko-outbox-195312@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf/hw_breakpoint: Clear stop state in
 hw_breakpoint_add()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bertinetti" <paolobertinetti200f4@proton.me>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103130859.764885-3-paolobertinetti200f4@proton.me>
References: <20261103130859.764885-3-paolobertinetti200f4@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 13:13:47 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103130859.7648=
85-2-paolobertinetti200f4@proton.me?part=3D2

