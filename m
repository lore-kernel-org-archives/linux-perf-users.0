Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792592654;
	b=UH2sMkVkmyke9pBD8FtxNRDn7bBh7qUARIejzYt7yIWyC+PtoUYZEqmS0v9Afew6lc7i
	 2eElnBAI3a+HEWAXjMJRaLEh/cSHL/xdXVCw+sBDu4pb9Pz2hxGr8f+WCS69dlJOx1pp6
	 IzeyhJrPQHIFQ1HIV5v+Ict04ssF8G9ngAiGbI/PzZfKLDsrCoBluyvZJIsrh2hjqbKpR
	 XXDUuJfDFIkgYistSRG+tb0usKbTryfgYc1faMdK/9yFLwUPo8Jk9IteHjmPUThhZ/iY1
	 8pvx/jnEAxeSOEtq0ecL+V3PmtQTFRc7Wpe6Dnx7TQOMjCFLC98kWO13BbDZU3rwnxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592654;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZzkyONr/YFfysvmyX8zx9+vH/6yCtWIYPydsdrirhwk=;
	b=1lXNVxlpbhpRPmoELJBvJiM7R0Fmw9hRd52fyf/1TTRupKi4H5N5+bm2iO9T0Q2fXoCf
	 634TGo+HcgmhjQW8XYlm7gCE0s1I4XuvV8j1SVbEmTrb71qINfGUL5vrf08QlYR4U0vn/
	 wior3rMqK9Zjt43zA0mFcqUKSsO0uNESV8xOEu/Cr7eSGS/qpgjfMg81qUkIx+BfIUzke
	 Z/w7zXGSd28M4NdOqZlFgyQasE0N2OdtPHMVTUuaFRLkJGM1rKFUY0PryzMgkZoueWTLK
	 3D37O0gH5qKTntelHQDbSICFeaSiA4cT4Lm0GliUvk8FiNhEKATV/3nBQ/G+OcCmlKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIcR0T4d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CEC60A2606
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIcR0T4d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416FB1F000C5;
	Wed, 21 Oct 2026 14:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792592653;
	bh=ZzkyONr/YFfysvmyX8zx9+vH/6yCtWIYPydsdrirhwk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mIcR0T4ddPMATG1Oyynp2JEbB4j33poaUBDFt1qqe50L1L4EM+oUp0b3s6c+ki6Lv
	 w/ekZXcm0RJm/pTOe5JwQedmlZyXR5bXwgTI1dKtj1Za3FVLai+NrIbqrNkT9Sp/rB
	 SHxzf70MqRj3zwYG+POTEkdM9oUuBHf7WxE+De6FHlOnfTBCOwopXdgfRKD4gzCqtP
	 WtZVTC4ZxFijb3Be1ii1w1GXX3R3y6iyw6bJjI9QgUD2ualtT5mQW4L3tA2/N6Rj2q
	 6SvzjYIxt3w+hSq/GIOQGYn+1mtXGADO/oE3Z5cC83yvRk1gSsawAWDT01o2cdRDl4
	 yPgK3Or+nZmJw==
Message-ID: <sashiko-outbox-180364@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf test: Add test for events re-armed with
 PERF_EVENT_IOC_REFRESH
Reply-To: sashiko-reviews@lists.linux.dev
To: "Francesco Nigro" <nigro.fra@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021141736.2414170-1-nigro.fra@gmail.com>
References: <20261021141736.2414170-1-nigro.fra@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 14:24:12 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Open a sampling event with sample_period 1, re-arm it with
> PERF_EVENT_IOC_REFRESH from its overflow signal handler, as
> self-profilers such as async-profiler do, and check that each of 1000
> events delivers a signal. One case uses a software event (page faults),
> the other the syscalls:sys_enter_getppid tracepoint. The signal is a
> real-time one, so overflows cannot be coalesced, and the page fault
> buffer is marked MADV_NOHUGEPAGE so that each touched page faults once.
>=20
> The tracepoint case fails since
> commit 18dbcbfabfff ("perf: Fix the POLL_HUP delivery breakage"):
> only the first overflow is delivered. The re-arming ioctl succeeds,
> but the event count stays at 1. It passes on the parent commit. The
> software case passes on both.
>=20
> The test was written with an AI coding assistant (Claude) from a
> standalone reproducer; I reviewed it and ran it in QEMU on current
> mainline, on that commit and on its parent.
>=20
> Link: https://github.com/async-profiler/async-profiler/issues/1813
> Signed-off-by: Francesco Nigro <nigro.fra@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021141736.2414=
170-1-nigro.fra@gmail.com?part=3D1

