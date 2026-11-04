Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793763089;
	b=OnTgFIwCvmu/LU0qk8I6zEnmiOjEQdRk+rIXe+6jXoYR7uZNvo4BMXD0OblFmnTO62Ab
	 B7oJC9lk6CTie5v+PO7nZ0EhSuO325JsxtfqNvciAeC6ZiYK5DuHkP12VJsf+EwUicx6j
	 Qgl5oC1ucO6IJoqXTQZ749KvEzlfXo/8Le3Kdj9HmwGlwtQP9qBF6/fagVec3JLOsHXZv
	 4Mop2GosdEFBsjxmA6IzHQpuGNQvNa51WAMbBWVfabyZmRdu7u1GYoaMPJs3qr0G9g7i2
	 spiXpnPwflD1IU8RSdRSWJUZVuVSvPecWy0PT8lnPBrV+CGJ1nr96rdUmKgxQYzHAFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793763089;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bKIomRaL1Xm9Vm3Pli4qF38JhJwGARdnDg0tNL+SszQ=;
	b=i0os0ty3YdcYi8MMSIBPKGpMODu+d5wK8HxFg7VY12qfBIHpxvjZW9yV4lo4NOD0LdcG
	 vI0tZYd2hYorn0ZGsio1ZpptjA87MuOK84axF2h821bstdPJbX74JeyHprCI1lvJiG0VA
	 NQfaraHJ/ajgtdFhIII/70yZChwkEWgVw5JtOACRMRR0JdbjEQlgUU1yY0PIOiiX07TXe
	 //q1pMWh2KcbRoiBD8OZnnlxw8ROLn7FI1WuMn+kB68uEL1FlX5cFt9/HDhca69RffDSR
	 /djx/OevByaHMOLQGBJWtvvHuF7vFB/CJUjJsEm1mlSmRY0D29EmAYZ5kddpC0Bbbug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TEf3Hh0u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD80C606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 03:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TEf3Hh0u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705EF1F000C1;
	Wed,  4 Nov 2026 03:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793763088;
	bh=bKIomRaL1Xm9Vm3Pli4qF38JhJwGARdnDg0tNL+SszQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TEf3Hh0uMhGlSOkl1eRqtmNsDymkcQv97zE/UuNAisFZM/UeJu99tPCviX8fAHt/6
	 ZJajMzew9S3ucIjTsXIrv7Qc9xgyVH9QoLvqEUTu2//r17TNBn+kk9g1RGmEa+/qoD
	 /O2CC0R1mFaOZ7a267EzqL3TcfGRjFFlQWSH14Hh/WFJH+Lcw/mv+tbtmEg1jyGxxG
	 1h3E+z/gU6EnBgxMMroCEBgWFAlqM7+0wJUeTJthNxliRVRbBb3kyQ/iBZPUasQoHe
	 HUmPFL/K2kR39w8lsxOvU+c8ByPhu4CWnuYihv6hTlmk7dfT51gtRfjuM0/aVOXlsx
	 /zVtlBZIG1E8w==
Message-ID: <sashiko-outbox-196604@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 2/3] perf: Add Raspberry Pi BCM2835 AXI PMU driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104030300.1140180-3-irogers@google.com>
References: <20261104030300.1140180-1-irogers@google.com>
 <20261104030300.1140180-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:31:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add a PMU driver for the Raspberry Pi AXI performance monitors. It
> provides access to the System and VideoCore performance counters on
> Broadcom BCM2835 and BCM2711 platforms natively through the perf
> subsystem.
>=20
> The driver implements bus-watcher refcounting, group validation, CPU
> hotplug migration, and sysfs event aliases mapping hardware-specific
> events to AXI pipelines (such as DMA, V3D, HVS, and ISP). Memory-mapped
> endpoints for the primary System bus are read synchronously, while the
> VideoCore VPU monitor is polled asynchronously in process context via a
> single bulk Raspberry Pi firmware mailbox read across all active bus
> watchers.
>=20
> Co-developed-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104030300.1140=
180-1-irogers@google.com?part=3D2

