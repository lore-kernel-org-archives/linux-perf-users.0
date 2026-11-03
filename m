Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680180;
	b=EPknW5BIbcCz45tVLL+wIncOiBI7nTpVxmv6t5ARf49JV/8NmLJDQEhE5vVdkINChJQh
	 Cmmb5yhlKEtZKvTif9EQglRq0lzf9KAIKC4/1rSnqbhjzbpWs71jQfk0zD+CK1p3+yibJ
	 KIITWZlnbEP4EAUirDqQREibBlyhcKC+66rh4y4la1mOJEPqqZEij7Yf2YJYIiI23+ioM
	 cpen0KiiFUOeNW3MzrovQvysd60fRkwyee/ujk246aJivwNAJQ68iqoPGZitBVBuxMn/W
	 SNF6KDuJRuIG9T+0wMWbb6QjMpgKOqmb2pIbExuearImc56ttr1LM83TV4wODcHF3XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680180;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vbxLDaLyl2sSZZzYQssJic67RMxf3qaVW7BCf7PINWc=;
	b=yoOPnz4tHunWMtez6svkFkFoGPV75vC+dgH+vWPW7t+8eojx2zwt6kurgMy9FjIxfyDZ
	 Ms/VaTF5ROhjlr73hVdX9b/PkzYpzm0AA682AVSmMs5TaY/9bSuALFS+tluebHRiU4p2E
	 bs1nSOYzlaba//MOSGt6r2XHMikp5C0ihTHGo970Y+BXK2PJMxQIfCLY1pR3yRKvq6Vi+
	 a+ooiXpeOVdO6U3vdNTnpodXCgG+lU992cH99r4nz67bYekZzE3lbYzzF284/hM0fcojq
	 U0ZrM4p7G7NVjIhRDENAaBKqY1jOkumc2mNZFjOSJGcN8c+q4GnIo6P/qBJHIvohOlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jw/GlIWW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4D8606A324
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 04:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jw/GlIWW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0992D1F000C1;
	Tue,  3 Nov 2026 04:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793680180;
	bh=vbxLDaLyl2sSZZzYQssJic67RMxf3qaVW7BCf7PINWc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jw/GlIWW3nB3pDh6z91MUmGPyvr09ZKalLXrhc2Vv5PQsChpP5pI9XCU3/8grJ6a8
	 wZq2fOCcEkLzBbxTliu6LGBM1+AUVJwEkArMjJtxY/n2GGttWZduz0bOg23fniBgcB
	 N0rfO5SMAJ6yK6p4z2u7SJPxAS53c0Bl3CufaSIAzTbupQy8byuomUlfgCIp0crGiS
	 vI/08X3MokH7KlkacnpAXnQwHHc57fbDtHtaqjuQwD2fwjQ2MR3/bUdnJXPHi5aQFd
	 R4mdn7HNjPx9oa0T8vz1UkJsf3Y6EQ02EfjTG7WSemdlPHpDoFoaCTYAvxU4zrXy5b
	 YxB8anKbsbHWQ==
Message-ID: <sashiko-outbox-194566@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 2/3] perf: Add Raspberry Pi BCM2835 AXI PMU driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103041416.2940213-3-irogers@google.com>
References: <20261103041416.2940213-1-irogers@google.com>
 <20261103041416.2940213-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 04:29:39 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103041416.2940=
213-1-irogers@google.com?part=3D2

