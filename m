Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116673;
	b=OC48JIZyVJOmw14gHj9bQ98/irhuUiLQEixbXaN46CCFmIasX6YbiNf3LYjomXODi7wF
	 R2HZ664ZHIUwE9RFuFYunXhlH9Rj3rPsN4bxT2fiYDup/+Pm8FUD/0v7FtwOmj1kKTE1H
	 +1xTuz8hOw0O08VRZ2h2fiJBaM6tNUiS0XRi3yy96IDKzuKe898H6BmsIRI8kANDboxYN
	 sy7SKqrwawW4AkEKlcb77G/A/n+oHuiy6YngKgZVJBeasyJgOiWeWLD+bkdry+VtC7pVz
	 cxP9WyMbFORaUoYkZRZkxK5/uW6FH+umVbz3kerpA/9uW17BfZbAxyMw9TUs7IGAL1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116673;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RnVPUiQvSLVhCURQzAmQH1nX0+fRatV7NXGZR9mSOiQ=;
	b=lqHmo5qOve2mTSlsZjWGI4aeeZ7IJFujFEM4fmX5p2w1NDGlJoPI+E5f3Auo/KAQwCqP
	 IjveFEGm6TgtDWvEoEttiq8eazaqBzUS9aLQMxxSH0EO1w4e7sMf+mKDTJ3XJvfq2xAXN
	 uzJRR2vwqJXsfUCGhfylXgdlj6OgsDtp+/AYqnFu6rTgTZ4CWISSZ13Xr6+M8DMxgpTH9
	 tYZUNIsdoIinVvSvviRIkL5wNiRU/G9y0zbEMqNqbpfV4Jo55CEUgFHET9ddVGOWN7Mld
	 wIr/zVa+17DXTagfGW3fbs13BMDRZqMiW3IFgD/jBQMUAcNrIiwjZY3Zw4/a2WuD+Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TDQNyPAr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1E9606A324
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TDQNyPAr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039861F000C7;
	Thu, 19 Nov 2026 19:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116673;
	bh=RnVPUiQvSLVhCURQzAmQH1nX0+fRatV7NXGZR9mSOiQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TDQNyPArkBdMiugdUbrOnZI28j9TExx2bp7fQ5A95w6UlWT0IAXyiIUTBDcCGI2oJ
	 +ihzYtxx228cQfRDkCEjevPFRhA+dlQX1iDp1jgJfNfzVhpPJrx9MoQ71rqvcluJ5Q
	 isFhEl0GP4ikRh1Dg/lklaTbhXOzwGvys5nw8gtjXcByaI/RiH0yAZOeFlPa5/iv8W
	 7iNbUV7jVlCk5vGoZIrFXJh4DbZJvHxT3Ywmk5WPg4LTHilHdFDCRcChGwD+dokxu6
	 ByrSdPs+yvGWfG13AtZMHsC4hX7TLK5qvPArjF3jiIESamAGBfdXG1VQ1NtRWALYEA
	 mpUOt1n2chXOQ==
Message-ID: <sashiko-outbox-223927@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/hw_breakpoint: fix ctx->mutex vs perf_event_mutex
 inversion on attr modify
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dominik Maier" <dmnk@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119192228.2661266-1-dmnk@google.com>
References: <20261119192228.2661266-1-dmnk@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:31:12 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The perf events lock hierarchy documented in kernel/events/core.c orders
> task_struct::perf_event_mutex outside perf_event_context::mutex, which
> perf_event_open() and prctl(PR_TASK_PERF_EVENTS_ENABLE) follow.
>=20
> However, perf_ioctl(PERF_EVENT_IOC_MODIFY_ATTRIBUTES) acquires
> ctx->mutex first via perf_event_ctx_lock() and then calls
> perf_event_modify_attr() -> modify_user_hw_breakpoint_check() ->
> modify_bp_slot() -> bp_constraints_lock(), which locks
> bp->hw.target->perf_event_mutex when bp_type changes. If one thread in a
> process calls prctl(PR_TASK_PERF_EVENTS_ENABLE) while another calls
> ioctl(PERF_EVENT_IOC_MODIFY_ATTRIBUTES) with an alternating bp_type on a
> self-targeted breakpoint, the two threads deadlock against each other in
> TASK_UNINTERRUPTIBLE state.
>=20
> Decouple bp_constraints_lock() from task_struct::perf_event_mutex by
> [ ... ]
>=20
> Fixes: 0912037fec11 ("perf/hw_breakpoint: Reduce contention with large nu=
mber of tasks")
> Fixes: 32ff77e8cc9e ("perf/core: Implement fast breakpoint modification v=
ia _IOC_MODIFY_ATTRIBUTES")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dominik Maier <dmnk@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119192228.2661=
266-1-dmnk@google.com?part=3D1

